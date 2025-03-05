if GetResourceState("qb-core") ~= "started" then return end

local QBCore = exports["qb-core"]:GetCoreObject()

function SpawnVehicle(vehicle, coords, heading, props)
    QBCore.Functions.SpawnVehicle(vehicle, function(spawnedVehicle)
        SetEntityHeading(spawnedVehicle, heading)
        SetVehicleProps(spawnedVehicle, props)

        if Config.PlaceIntoVehicle then
            TaskWarpPedIntoVehicle(PlayerPedId(), spawnedVehicle, -1)
        end
    end, coords, true)
end

function SetVehicleProps(vehicle, props)
    QBCore.Functions.SetVehicleProperties(vehicle, props)
end

function GetVehicleProps(vehicle)
    return QBCore.Functions.GetVehicleProperties(vehicle)
end

function Notify(message, type)
    QBCore.Functions.Notify(message, type)
end
