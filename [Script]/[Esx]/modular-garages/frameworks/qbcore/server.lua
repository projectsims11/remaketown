if GetResourceState("qb-core") ~= "started" then return end

local QBCore = exports["qb-core"]:GetCoreObject()

function FetchUserVehicles(source, garage)
    local vehicles = {}

    local query = "SELECT * FROM player_vehicles WHERE citizenid = @citizenid AND state = 1"
    -- State 0 = out, 1 = in, 2 = impounded

    if Config.ParkingType == "specific" then
        query = "SELECT * FROM player_vehicles WHERE citizenid = @citizenid AND garage = @garage AND state = 1"
    end

    local res = MySQL.query.await(query, {
        ["@citizenid"] = QBCore.Functions.GetPlayer(source).PlayerData.citizenid,
        ["@garage"] = garage,
    })

    for _, v in ipairs(res) do
        vehicles[#vehicles + 1] = ConvertVehicleTable(v)
    end

    return vehicles
end

function FetchImpoundedUserVehicles(source, impound)
    local vehicles = {}
    local res = MySQL.query.await(
        "SELECT * FROM player_vehicles WHERE citizenid = @citizenid AND (state = 2 OR state = 0)", {
            ["@citizenid"] = QBCore.Functions.GetPlayer(source).PlayerData.citizenid,
        })

    for _, v in ipairs(res) do
        vehicles[#vehicles + 1] = ConvertVehicleTable(v)
    end

    return vehicles
end

function SpawnVehicle(src, plate, userVehicle, garage, impound)
    local result = MySQL.query.await("SELECT state FROM player_vehicles WHERE plate = ?", { plate })

    if result[1] == nil then return Notify(src, T("already_out"), "error") end

    TriggerClientEvent("modular-garages:client:spawnVehicle", src, userVehicle, garage, impound)
    MySQL.update("UPDATE player_vehicles SET state = ?, garage = ? WHERE plate = ?", { 0, "impoundlot", plate })
    Wait(500) -- Doesn't work if the vehicle hasn't spawned
    exports["qb-vehiclekeys"]:GiveKeys(src, plate)
end

function ParkVehicle(source, vehicleEntity, plate, garage, props)
    if not DoesEntityExist(vehicleEntity) then return end
    DeleteEntity(vehicleEntity)
    MySQL.update("UPDATE player_vehicles SET state = ?, garage = ?, mods = ? WHERE plate = ?",
        { 1, garage, json.encode(props, { indent = true }), plate })
end

function FavoriteVehicle(source, plate, isFavorite, garage)
    MySQL.update.await("UPDATE player_vehicles SET isFavorite = ? WHERE plate = ?", { isFavorite and 1 or 0, plate })
    TriggerClientEvent("modular-garages:client:receiveVehicles", source, FetchUserVehicles(source, garage))
end

--- Notify
---@param source any Player source
---@param msg string Message to show
---@param type "error" | "success" | "info"
function Notify(source, msg, type)
    QBCore.Functions.Notify(source, msg, type)
end

--- Gets all of the vehicles owned by the player
---@param source any Player source
---@param plate string Vehicle plate
function GetUserOwnedVehicle(source, plate)
    local query = "SELECT * FROM player_vehicles WHERE citizenid = @citizenid AND plate = @plate"
    local res = MySQL.query.await(query, {
        ["@citizenid"] = QBCore.Functions.GetPlayer(source).PlayerData.citizenid,
        ["@plate"] = plate,
    })

    if not next(res) then return nil end

    return ConvertVehicleTable(res[1])
end

function ConvertVehicleTable(vehicle)
    local vehicleData = json.decode(vehicle.mods)

    return {
        plate = vehicle.plate,
        model = tonumber(vehicle.hash),
        owner = vehicle.citizenid,
        state = vehicle.state == 1 and "in" or "out",
        garage = vehicle.garage,
        props = vehicleData,
        fuel = vehicleData.fuelLevel,
        health = vehicleData.bodyHealth,
        isFavorite = vehicle.isFavorite,
    }
end
