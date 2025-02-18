ESX = nil

Config['Setup_cl']()

local IsUsing = false

RegisterNetEvent('alonedev.esport:onArmor')
AddEventHandler('alonedev.esport:onArmor', function(data)
	if not IsUsing then
		IsUsing = true
		if data['Remove'] then 
			TriggerServerEvent('alonedev.esport:deleteitem' , data['item_name'])
		end
		local playerPed = PlayerPedId()
		local lib, anim = "clothingtie", "try_tie_negative_a" 
		Config['ArmorProgbar'](data['item_name'] ,data['Time'])
		ESX.Streaming.RequestAnimDict(lib, function()
			local co = GetEntityCoords(playerPed)
			local he = GetEntityHeading(playerPed)
			TaskPlayAnimAdvanced(playerPed, lib, anim, co.x, co.y, co.z, 0, 0, he, 8.0, 1.0, -1, 51, 0.0, 0, 0)
			Citizen.Wait(5000)
			ClearPedTasks(playerPed)
			SetPedArmour(PlayerPedId(), data["Armor"])
		end)
		IsUsing = false
	end
end)
