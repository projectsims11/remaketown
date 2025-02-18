
local IsBusy = false
ESX = nil 

Config['Setup_cl']()

RegisterNetEvent('alonedev.esport:onAed')
AddEventHandler('alonedev.esport:onAed', function(data)
	if not IsBusy and GetEntityHealth(PlayerPedId()) > 0 and not IsPedInAnyVehicle(PlayerPedId(), true) then 
		if data['Zone'] then 
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()) , data['Zone'].coords , false) > data['Zone'].rad then 
				TriggerEvent('alonedev.esport:notify' , 'ไม่สามารถใช้นอกโซนได้')
				return
			end
		end
	
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		if closestPlayer == -1 or closestDistance > 1.3 then
			TriggerEvent('alonedev.esport:notify' , 'ไม่พบผู้เล่น')
		else
			local closestPlayerPed = GetPlayerPed(closestPlayer)
			if IsPedDeadOrDying(closestPlayerPed, 1) then
				IsBusy = true
				local playerPed = PlayerPedId()
				local Iscancel = false
				Citizen.CreateThread(function()
					Iscancel = Config['AedProgbar'](data['Time'])
				end)
				Citizen.CreateThread(function()
					while not Iscancel and IsBusy  do
						Wait(0)
						local coordx = GetEntityCoords(closestPlayerPed)
						DrawMarker(2, coordx.x, coordx.y, coordx.z + 1.5, 0, 0, 0,
								   0, 0, 0, 0.4, 0.4, 0.4, 255, 0, 0, 100, 1, 0, 0,
								   0, 0, 0, 0)
						if IsControlJustPressed(0, 73) or IsPedDeadOrDying(PlayerPedId()) then
							Iscancel = true
							break
						end

						if not IsBusy then 
							break
						end
					end
				end)
				local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'
				for i=1, data['Time'], 1 do
					if not Iscancel then 
						ESX.Streaming.RequestAnimDict(lib, function()
							TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
						end)
						Citizen.Wait(900)
					else 
						ClearPedTasksImmediately(PlayerPedId())
					end
				end
	
				if not Iscancel then 
					if GetEntityHealth(PlayerPedId()) > 0 then 
						TriggerServerEvent('alonedev.esport:revive', GetPlayerServerId(closestPlayer) , data['item_name'])
					end
				end
				Iscancel = false
				IsBusy = false
			end
		end
	end
end)

RegisterNetEvent('alonedev.esport:revive')
AddEventHandler('alonedev.esport:revive', function()
	Config['ReviveAed']()
end)

RegisterNetEvent('alonedev.esport:notify')
AddEventHandler('alonedev.esport:notify' , function(text)
	Config['Noti'](text)
end)

