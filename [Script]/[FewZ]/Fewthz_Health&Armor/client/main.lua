if Config.ESX then
    RegisterNetEvent('esx:playerLoaded')
    AddEventHandler('esx:playerLoaded', function(playerData)
        Wait(5000)
        TriggerServerEvent("Fewthz_health-armour:loadData")
    end)
end

if Config.Standalone then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            local playerPed = PlayerPedId()
            if playerPed and playerPed ~= -1 then
                if NetworkIsPlayerActive(PlayerId()) then
                    Citizen.Wait(5000)
                    TriggerServerEvent("Fewthz_health-armour:loadData")
                    break
                end
            end
        end
    end)
end

RegisterNetEvent('Fewthz_health-armour:setData')
AddEventHandler('Fewthz_health-armour:setData', function(data)
    print('Heal&Armour')
    local playerPed = GetPlayerPed(-1)
    local health = SetEntityHealth(playerPed, data.Health)
    local armour = SetPedArmour(playerPed, data.Armour)
end)