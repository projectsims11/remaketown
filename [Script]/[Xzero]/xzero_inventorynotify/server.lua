script_name = GetCurrentResourceName()
version_lasted = nil;
GetName = function(a) return script_name .. a end;
RegisEvent = function(b, a, c)
    if b then RegisterNetEvent(a) end
    AddEventHandler(a, c)
end;
SAOWIJAOIJDOZAISJSAUZHAYUSSAZIAJISADSDS = nil;
Citizen.CreateThread(function()
    SAOWIJAOIJDOZAISJSAUZHAYUSSAZIAJISADSDS = true;
end)
RegisEvent(true, GetName(':server:Verify:Request'), function()
    TriggerClientEvent(GetName(':client:Verify:Receive'), source,
                       SAOWIJAOIJDOZAISJSAUZHAYUSSAZIAJISADSDS)
end)
ESX = nil;
xZero = {}
xZero.Init = function()
    Wait(500)
    if SAOWIJAOIJDOZAISJSAUZHAYUSSAZIAJISADSDS then
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(j) ESX = j end)
            Wait(1)
        end
    end
end;
