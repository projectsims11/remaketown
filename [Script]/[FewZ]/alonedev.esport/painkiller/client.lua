local IsPainkiller = false
ESX = nil 

Config['Setup_cl']()

RegisterNetEvent('alonedev.esport:onPainkiller')
AddEventHandler('alonedev.esport:onPainkiller', function(data)
    if not IsPainkiller and GetEntityHealth(PlayerPedId()) > 0 and not IsPedInAnyVehicle(PlayerPedId(), true)  then
        IsPainkiller = true
		if data['Remove'] then 
			TriggerServerEvent('alonedev.esport:deleteitem' , data['item_name'])
		end
        local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
        local playerPed = GetPlayerPed(-1)  
        ESX.Streaming.RequestAnimDict(lib, function()
            TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)     
            Citizen.Wait(data['Time'] * 1000)
            ClearPedTasks(GetPlayerPed(-1))
            local Playerhealth = GetEntityHealth(GetPlayerPed(-1))
            SetEntityHealth(GetPlayerPed(-1), Playerhealth + data['HealthPlus'])
        end)
        IsPainkiller = false
    end
end)


