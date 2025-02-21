ESX = nil
ESX = exports['es_extended']:getSharedObject()

local OnZone = false
RegisterServerEvent('curfew_Police:send1')
AddEventHandler('curfew_Police:send1', function(result)
    if not OnZone then
        TriggerClientEvent("redzone:setposition1", source, result)
        OnZone = true
    else
        TriggerClientEvent("redzone:stopredzone1", -1)
        OnZone = false
    end
end)

RegisterServerEvent('redzone:sentlocation1')
AddEventHandler('redzone:sentlocation1', function(x1,y1,z1,result)
    TriggerClientEvent('redzone:createForAll1', -1, x1,y1,z1,result)
end)