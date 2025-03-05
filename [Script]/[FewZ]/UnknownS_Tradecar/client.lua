ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('UnknownS_Tradecar:GetVehicleInfo')
AddEventHandler('UnknownS_Tradecar:GetVehicleInfo', function(source_playername, date, plate, price, source)
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local closestPlayer, playerDistance = ESX.Game.GetClosestPlayer()
	local sellerID = source
	target = GetPlayerServerId(closestPlayer)

	if closestPlayer ~= -1 and playerDistance <= 3.0 then
		local vehicle = ESX.Game.GetClosestVehicle(coords)
		local vehiclecoords = GetEntityCoords(vehicle)
		local vehDistance = GetDistanceBetweenCoords(coords, vehiclecoords, true)
		if DoesEntityExist(vehicle) and (vehDistance <= 3) then
			local vehProps = ESX.Game.GetVehicleProperties(vehicle)
			ESX.TriggerServerCallback("UnknownS_Tradecar:GetTargetName", function(targetName)
				SetNuiFocus(true, true)
				SendNUIMessage({
					action = 'openContractSeller',
					plate = vehProps.plate,
					model = GetDisplayNameFromVehicleModel(vehProps.model),
					source_playername = source_playername,
					sourceID = sellerID,
					target_playername = targetName,
					targetID = target,
					date = date,
					description = description,
					price = price
				})
			end, target)
		else
			ClearPedTasks(PlayerPedId())
				
				TriggerEvent("nc_notify:PushNotification", {
					title = 'โอนรถ',
					description = " ต้องอยู่ใกล้รถถึงจะทำได้z",
					icon = 'car_key',
					type = 'error',
					duration = 5000
				})
		end
	else
		ClearPedTasks(PlayerPedId())
			TriggerEvent("nc_notify:PushNotification", {
				title = 'โอนรถ',
				description = " ไม่มีคนอยู่บริเวณนี้",
				icon = 'car_key',
				type = 'error',
				duration = 5000
			})
	end
end)

RegisterNetEvent('UnknownS_Tradecar:OpenContractInfo')
AddEventHandler('UnknownS_Tradecar:OpenContractInfo', function()
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = 'openContractInfo'
	})
end)

RegisterNetEvent('UnknownS_Tradecar:OpenContractOnBuyer')
AddEventHandler('UnknownS_Tradecar:OpenContractOnBuyer', function(data)
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = 'openContractOnBuyer',
		plate = data.plateNumber,
		model = data.vehicleModel,
		source_playername = data.sourceName,
		sourceID = data.sourceID,
		target_playername = data.targetName,
		targetID = data.targetID,
		date = data.date,
		description = data.description,
		price = data.price
	})
end)

RegisterNUICallback("action", function(data, cb)
	if data.action == "submitContractInfo" then
		TriggerServerEvent("UnknownS_Tradecar:SendVehicleInfo", data.vehicle_description, data.vehicle_price)
		SetNuiFocus(false, false)
	elseif data.action == "signContract1" then
		TriggerServerEvent("UnknownS_Tradecar:SendContractToBuyer", data)
		ClearPedTasks(PlayerPedId())
		SetNuiFocus(false, false)
	elseif data.action == "signContract2" then
		TriggerServerEvent("UnknownS_Tradecar:changeVehicleOwner", data)
		ClearPedTasks(PlayerPedId())
		SetNuiFocus(false, false)
	elseif data.action == "close" then
		ClearPedTasks(PlayerPedId())
		SetNuiFocus(false, false)
	end
end)

RegisterNetEvent('UnknownS_Tradecar:startContractAnimation')
AddEventHandler('UnknownS_Tradecar:startContractAnimation', function(player)
	loadAnimDict('anim@amb@nightclub@peds@')
	TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_CLIPBOARD', 0, false)
end)

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(0)
	end
end