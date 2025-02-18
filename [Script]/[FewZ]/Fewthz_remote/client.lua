ESX = exports['es_extended']:getSharedObject()
local useCarlockSound = true -- OPTIONS: (true/false)

RegisterKeyMapping('LockCar','LockCar', 'keyboard', 'U')
RegisterCommand('LockCar', function()
	if not Keys then
		Keys = true
		doLockSystemToggleLocks()
		Keys = false
        Citizen.Wait(250)
    end
end)

function doLockSystemToggleLocks(plate)
	local dict = "anim@mp_player_intmenu@key_fob@"
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(0)
	end
		  local coords = GetEntityCoords(GetPlayerPed(-1))
		  local hasAlreadyLocked = false
		  cars = ESX.Game.GetVehiclesInArea(coords, 30)
		  local carstrie = {}
		  local cars_dist = {}		
		  notowned = 0
		  if #cars == 0 then
			  --ESX.ShowNotification("Keine Fahrzeuge in der Nähe zum Abschließen.")
			  exports["pNotify"]:SendNotification({
				text = 'ไม่มีรถอยู่ใกล้ๆ',
				type = "error",
				timeout = 3000,
				layout = "centerRight",
				queue = "global"
			})
		  else
			  for j=1, #cars, 1 do
				  local coordscar = GetEntityCoords(cars[j])
				  local distance = Vdist(coordscar.x, coordscar.y, coordscar.z, coords.x, coords.y, coords.z)
				  table.insert(cars_dist, {cars[j], distance})
			  end
			  for k=1, #cars_dist, 1 do
				  local z = -1
				  local distance, car = 999
				  for l=1, #cars_dist, 1 do
					  if cars_dist[l][2] < distance then
						  distance = cars_dist[l][2]
						  car = cars_dist[l][1]
						  z = l
					  end
				  end
				  if z ~= -1 then
					  table.remove(cars_dist, z)
					  table.insert(carstrie, car)
				  end
			  end
			  for i=1, #carstrie, 1 do
				  local plate = ESX.Math.Trim(GetVehicleNumberPlateText(carstrie[i]))
				  ESX.TriggerServerCallback('Fewthz_remote:isVehicleOwner', function(owner)
					if owner and hasAlreadyLocked ~= true then
					  local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(carstrie[i]))
					  vehicleLabel = GetLabelText(vehicleLabel)
					  local lock = GetVehicleDoorLockStatus(carstrie[i])
					  if lock == 1 or lock == 0 then
						  SetVehicleDoorShut(carstrie[i], 0, false)
						  SetVehicleDoorShut(carstrie[i], 1, false)
						  SetVehicleDoorShut(carstrie[i], 2, false)
						  SetVehicleDoorShut(carstrie[i], 3, false)
						  SetVehicleDoorsLocked(carstrie[i], 2)
						  PlayVehicleDoorCloseSound(carstrie[i], 1)
						  --ESX.ShowNotification('Du hast dein ~y~'..vehicleLabel..'~s~ ~r~Abgeschlossen~s~.')
						  exports["pNotify"]:SendNotification({
							text = 'ล็อครถเรียบร้อย',
							type = "success",
							timeout = 3000,
							layout = "centerRight",
							queue = "global"
						})
						  if not IsPedInAnyVehicle(PlayerPedId(), true) then
							  TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
						  end
						  if useCarlockSound == true then
							  TriggerEvent("InteractSound_CL:PlayOnOne", "lock", 0.2)
						  end
						  SetVehicleLights(carstrie[i], 2)
						  Citizen.Wait(150)
						  SetVehicleLights(carstrie[i], 0)
						  Citizen.Wait(150)
						  SetVehicleLights(carstrie[i], 2)
						  Citizen.Wait(150)
						  SetVehicleLights(carstrie[i], 0)
						  hasAlreadyLocked = true
					  elseif lock == 2 then
						  SetVehicleDoorsLocked(carstrie[i], 1)
						  PlayVehicleDoorOpenSound(carstrie[i], 0)
						  --ESX.ShowNotification('Du hast dein ~y~'..vehicleLabel..'~s~ ~g~Aufgeschlossen~s~.')
						  exports["pNotify"]:SendNotification({
							text = 'ปลดล็อครถเรียบร้อย',
							type = "error",
							timeout = 3000,
							layout = "centerRight",
							queue = "global"
						})
						  if not IsPedInAnyVehicle(PlayerPedId(), true) then
							  TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
						  end
						  if useCarlockSound == true then
							TriggerEvent("InteractSound_CL:PlayOnOne", "unlock", 0.2)
						  end
						  SetVehicleLights(carstrie[i], 2)
						  Citizen.Wait(150)
						  SetVehicleLights(carstrie[i], 0)
						  Citizen.Wait(150)
						  SetVehicleLights(carstrie[i], 2)
						  Citizen.Wait(150)
						  SetVehicleLights(carstrie[i], 0)
						  hasAlreadyLocked = true
					  end
					else
					  notowned = notowned + 1
					end
				if notowned == #carstrie then
					  --ESX.ShowNotification("Keine Fahrzeuge in der Nähe zum Abschließen.")
					  exports["pNotify"]:SendNotification({
						text = 'ไม่มีรถอยู่ใกล้',
						type = "error",
						timeout = 3000,
						layout = "centerRight",
						queue = "global"
					})
				end	
			end, plate)
		end			
	end
end

RegisterNetEvent("Fewthz_remote:useKey")
AddEventHandler("Fewthz_remote:useKey", function(plate)

	local dict = "anim@mp_player_intmenu@key_fob@"
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(0)
	end

		local coords = GetEntityCoords(GetPlayerPed(-1))
		local hasAlreadyLocked = false
		cars = ESX.Game.GetVehiclesInArea(coords, 30)
		local carstrie = {}
		local cars_dist = {}		
		notowned = 0
		if #cars == 0 then
			exports["pNotify"]:SendNotification({
				text = 'ไม่มีรถอยู่ใกล้ๆ',
				type = "error",
				timeout = 3000,
				layout = "centerRight",
				queue = "global"
			})
		else
			for j=1, #cars, 1 do
				local coordscar = GetEntityCoords(cars[j])
				local distance = Vdist(coordscar.x, coordscar.y, coordscar.z, coords.x, coords.y, coords.z)
				if distance < Config.LockDistance then
					table.insert(cars_dist, {cars[j], distance})
				end
			end
			for k=1, #cars_dist, 1 do
				local z = -1
				local distance, car = 999
				for l=1, #cars_dist, 1 do
					if cars_dist[l][2] < distance then
						distance = cars_dist[l][2]
						car = cars_dist[l][1]
						z = l
					end
				end
				if z ~= -1 then
					table.remove(cars_dist, z)
					table.insert(carstrie, car)
				end
			end
			for i=1, #carstrie, 1 do
				local nearby_plate = ESX.Math.Trim(GetVehicleNumberPlateText(carstrie[i]))
				if plate == nearby_plate then
					if hasAlreadyLocked ~= true then
						local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(carstrie[i]))
						vehicleLabel = GetLabelText(vehicleLabel)
						local lock = GetVehicleDoorLockStatus(carstrie[i])
						if lock == 1 or lock == 0 then
							SetVehicleDoorShut(carstrie[i], 0, false)
							SetVehicleDoorShut(carstrie[i], 1, false)
							SetVehicleDoorShut(carstrie[i], 2, false)
							SetVehicleDoorShut(carstrie[i], 3, false)
							SetVehicleDoorsLocked(carstrie[i], 2)
							PlayVehicleDoorCloseSound(carstrie[i], 1)
							exports["pNotify"]:SendNotification({
								text = 'ล็อครถเรียบร้อย',
								type = "success",
								timeout = 3000,
								layout = "centerRight",
								queue = "global"
							})

							TriggerEvent("InteractSound_CL:PlayOnOne", "lock", 0.5)
							if not IsPedInAnyVehicle(PlayerPedId(), true) then
								TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
							end
							hasAlreadyLocked = true
						elseif lock == 2 then
							SetVehicleDoorsLocked(carstrie[i], 1)
							PlayVehicleDoorOpenSound(carstrie[i], 0)
							exports["pNotify"]:SendNotification({
								text = 'ปลดล็อครถเรียบร้อย',
								type = "error",
								timeout = 3000,
								layout = "centerRight",
								queue = "global"
							})
							TriggerEvent("InteractSound_CL:PlayOnOne", 'unlock', 0.5)
							if not IsPedInAnyVehicle(PlayerPedId(), true) then
								TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
							end
							hasAlreadyLocked = true
						end
					else
						notowned = notowned + 1
					end

					if notowned == #carstrie then
						exports["pNotify"]:SendNotification({
								text = 'ไม่มีรถอยู่ใกล้',
								type = "error",
								timeout = 3000,
								layout = "centerRight",
								queue = "global"
							})
					end	
				end
			end			
		end
end)

local isInVehicle = false
local isEnteringVehicle = false
Citizen.CreateThread(function()
    while true do
		Citizen.Wait(0)
        local ped = PlayerPedId()
		local canSleep  = true
        if Config.EnableCheckOwner then
			if not isInVehicle and not IsPlayerDead(PlayerId()) then
				if DoesEntityExist(GetVehiclePedIsTryingToEnter(ped)) and not isEnteringVehicle then
					canSleep = false
					local vehicle = GetVehiclePedIsTryingToEnter(ped)
					isEnteringVehicle = true
					local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
					ESX.TriggerServerCallback('Fewthz_remote:isVehicleOwner', function(owner)
			        	local isSeatFree = true

			        	for i=-1, GetVehicleNumberOfPassengers(vehicle), 1 do
			        		if not IsVehicleSeatFree(vehicle, i) then
			        			isSeatFree = false
			        			break
			        		end
			        	end

						if not owner then
							 if isSeatFree then
							 	ESX.ShowNotification("No vehicle owner in car.")
							 	SetVehicleDoorsLockedForPlayer(vehicle , PlayerId() , true  )
					        else
					        	SetVehicleDoorsLockedForPlayer(vehicle , PlayerId() , false )
					        end
						else
			        		SetVehicleDoorsLockedForPlayer(vehicle , PlayerId() , false)
						end
					end, plate)
				elseif not DoesEntityExist(GetVehiclePedIsTryingToEnter(ped)) and not IsPedInAnyVehicle(ped, true) and isEnteringVehicle then
					isEnteringVehicle = false
				elseif IsPedInAnyVehicle(ped, false) then
					isEnteringVehicle = false
					isInVehicle = true
				end
		   	elseif isInVehicle then
				if not IsPedInAnyVehicle(ped, false) or IsPlayerDead(PlayerId()) then
					isInVehicle = false
				end
			end
		end
		if canSleep then
			Citizen.Wait(500)
		end
    end
end)

if(Config.disableCar_NPC)then
    Citizen.CreateThread(function()
        while true do
            Wait(7)
            local ped = GetPlayerPed(-1)
            if DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId(ped))) then
                local veh = GetVehiclePedIsTryingToEnter(PlayerPedId(ped))
                local lock = GetVehicleDoorLockStatus(veh)
                if lock == 7 then
                    SetVehicleDoorsLocked(veh, 2)
                end
                local pedd = GetPedInVehicleSeat(veh, -1)
                if pedd then
                    SetPedCanBeDraggedOut(pedd, false)
                end
            end
        end
    end)
end

AddEventHandler("Fewthz_core:ClientMemoryGarbage", function()
	Citizen.CreateThread(function()
		Wait(math.random(100, 2000))
		collectgarbage()
	end)
end)