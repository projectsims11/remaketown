local ESX = nil

if Config.ESX then
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

    AddEventHandler('esx:playerLogout', function(source)
        src = source

        if src == nil then return end
    
        SaveHealthAndArmour(src)
    end)
end

local Statuses = {}

MySQL.Async.fetchAll("SELECT * FROM `fewthz_health_armour`",{},
function(data)
    for k,v in ipairs(data) do
        Statuses[v.identifier] = v.status
    end
end)

RegisterServerEvent("Fewthz_health-armour:loadData")
AddEventHandler("Fewthz_health-armour:loadData", function()
    src = source

    if src == nil then return end

    local identifier

    if Config.ESX then
        local xPlayer = ESX.GetPlayerFromId(src)
        identifier = xPlayer.identifier
    end

    if Config.Standalone then
        for k, v in ipairs(GetPlayerIdentifiers(src)) do
            if string.sub(v, 1, string.len("steam:")) == "steam:" then
                identifier = v
            end
        end
    end

    if identifier == nil then return end

    if Statuses[identifier] == nil then 
        MySQL.Async.execute('INSERT INTO `fewthz_health_armour` (`identifier`, `status`) VALUES (@identifier, @status)', {
            ["@identifier"] = identifier,
            ["@status"] = "{}"
        })

        Statuses[identifier] = {}
    end

    local status = MySQL.Sync.fetchAll("SELECT `status` FROM `fewthz_health_armour` WHERE `identifier` = '" .. identifier .. "' LIMIT 1")
    if status[1] then
        data = json.decode(status[1].status)

        if data.Health == nil then return end

        TriggerClientEvent("Fewthz_health-armour:setData", src, data)
    end          
end)


AddEventHandler('playerDropped', function (reason)
    src = source

    if src == nil then return end

    SaveHealthAndArmour(src)
end)

function SaveHealthAndArmour(src)
    local identifier

    if Config.ESX then
        local xPlayer = ESX.GetPlayerFromId(src)
        identifier = xPlayer.identifier
    end
    
    if Config.Standalone then
        for k, v in ipairs(GetPlayerIdentifiers(src)) do
            if string.sub(v, 1, string.len("steam:")) == "steam:" then
                identifier = v
            end
        end
    end

    if identifier == nil then return end

    local playerPed = GetPlayerPed(src)
    local health = GetEntityHealth(playerPed)
    local armour = GetPedArmour(playerPed)

    local data = {}
    data.Health = health
    data.Armour = armour

    local jsonData = json.encode(data)

    MySQL.Async.execute("UPDATE `fewthz_health_armour` SET `status` = '" .. jsonData .. "' WHERE `identifier` = '" .. identifier .. "'")
end