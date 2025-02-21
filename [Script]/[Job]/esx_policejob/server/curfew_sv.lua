ESX = nil
ESX = exports['es_extended']:getSharedObject()

local OnZone = false
RegisterServerEvent('curfew_Police:send')
AddEventHandler('curfew_Police:send', function(result)
    if not OnZone then
        TriggerClientEvent("redzone:setposition", source, result)
        OnZone = true
    else
        TriggerClientEvent("redzone:stopredzone", -1)
        OnZone = false
    end
end)

RegisterServerEvent('redzone:sentlocation')
AddEventHandler('redzone:sentlocation', function(x1,y1,z1,result)
    TriggerClientEvent('redzone:createForAll', -1, x1,y1,z1,result)
end)