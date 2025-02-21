ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local OnZone = {}  

RegisterServerEvent('curfew_Police:sentlocation')
AddEventHandler('curfew_Police:sentlocation', function(x1, y1, z1, result)
    table.insert(OnZone, {x = x1, y = y1, z = z1, result = result})  
    TriggerClientEvent('curfew_Police:createForAll', -1, x1, y1, z1, result)
end)

RegisterServerEvent('curfew_Police:firstSpawn')
AddEventHandler("curfew_Police:firstSpawn", function()
    for k, zone in pairs(OnZone) do
        TriggerClientEvent('curfew_Police:createForAll', source, zone.x, zone.y, zone.z, zone.result, k)
    end
end)
