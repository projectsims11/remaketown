GlobalFunction = function(event, data)
    local options = {
        event = event,
        data = data
    }

    TriggerServerEvent("Fewthz_safe:globalEvent", options)
end

TryToCrack = function(safeEntity)
	local currentStreetName = GetCurrentStreetName()

	if Config.Debug then
		local breachObjects = SpawnBreachObjects(safeEntity)
		local safeCoords = GetEntityCoords(safeEntity)		

		GlobalFunction("open_door", {
			["store"] = currentStreetName,
			["doorCoords"] = {
				["x"] = safeCoords["x"],
				["y"] = safeCoords["y"],
				["z"] = safeCoords["z"]
			},
			["objects"] = breachObjects,
			["streetName"] = currentStreetName,
			["save"] = true
		})
		
		return
	end

	ESX.TriggerServerCallback("Fewthz_safe:checkIfSafeIsBreachable", function(state)
		if state then
			StartCrackingSafe(safeEntity)
		else
			ESX.ShowNotification("You can't crack this.")
		end
	end, currentStreetName)
end

StartCrackingSafe = function(safeEntity)
	if isCracking then
		return
	end

	isCracking = true

	currentSafeCorrectPosition = math.random(1, 350)

	while not HasStreamedTextureDictLoaded("MPSafeCracking") do
		Citizen.Wait(0)

		RequestStreamedTextureDict("MPSafeCracking", false)	
	end

	RequestAmbientAudioBank("SAFE_CRACK", false)

	while not HasAnimDictLoaded("mini@safe_cracking") do
		Citizen.Wait(0)

		RequestAnimDict("mini@safe_cracking")
	end

	TaskPlayAnim(PlayerPedId(), "mini@safe_cracking", "dial_turn_clock_normal", 0.5, 1.0, -1, 11, 0.0, 0, 0, 0)

	HandleControls(safeEntity)

	Citizen.CreateThread(function()
		while isCracking do
			Citizen.Wait(0)

			DrawSprite("MPSafeCracking", "Dial_BG", 0.5, 0.4, 0.2, 0.3, 0.0, 255, 255, 255, 255)
			DrawSprite("MPSafeCracking", "Dial", 0.5, 0.4, 0.2 * 0.5, 0.3 * 0.5, dialRotation, 255, 255, 255, 255)

			DrawButtons({
				{
					["label"] = "Right quick",
					["button"] = "~INPUT_CELLPHONE_RIGHT~"
				},
				{
					["label"] = "Right slow",
					["button"] = "~INPUT_CELLPHONE_DOWN~"
				},
				{
					["label"] = "Left slow",
					["button"] = "~INPUT_CELLPHONE_UP~"
				},
				{
					["label"] = "Left fast",
					["button"] = "~INPUT_CELLPHONE_LEFT~"
				},
				{
					["label"] = "Try crack",
					["button"] = "~INPUT_JUMP~"
				},
				{
					["label"] = "Cancel",
					["button"] = "~INPUT_DETONATE~"
				}
			})

			if not IsEntityPlayingAnim(PlayerPedId(), "mini@safe_cracking", "dial_turn_clock_normal", 3) and isCracking then
				TaskPlayAnim(PlayerPedId(), "mini@safe_cracking", "dial_turn_clock_normal", 0.5, 1.0, -1, 11, 0.0, 0, 0, 0)
			end

			for i = 1, Config.TotalLocks do
				local lockState = safeLocks[i] and "lock_open" or "lock_closed"

				DrawSprite("MPSafeCracking", lockState, 0.25 + (i / 10), 0.6, 0.2 * 0.2, 0.3 * 0.2, 0.0, 255, 255, 255, 255)
			end
		end

		RemoveAnimDict("mini@safe_cracking")
	end)
end

ResetCrackingGame = function()
	isCracking = false
	
	safeLocks = {}

	ReleaseAmbientAudioBank("SAFE_CRACK")
	SetStreamedTextureDictAsNoLongerNeeded("MPSafeCracking")

	if IsEntityPlayingAnim(PlayerPedId(), "mini@safe_cracking", "dial_turn_clock_normal", 3) then
		ClearPedTasks(PlayerPedId())
	end
end

HandleControls = function(safeEntity)
	Citizen.CreateThread(function()
		while isCracking do	
			DisableControlAction(0, 38, true)

			if IsControlJustPressed(0, 22) then
				if dialRotation == currentSafeCorrectPosition then
					PlaySoundFrontend(0, "TUMBLER_PIN_FALL", "SAFE_CRACK_SOUNDSET", 1)

					safeLocks[#safeLocks + 1] = true

					if #safeLocks == 1 then
						local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))

						TriggerServerEvent("esx_phone:send", "police", "GPS มีคนกำลังปล้นร้านค้า!", true, { ["x"] = x, ["y"] = y, ["z"] = z })
						TriggerEvent("scotty-policealert:alertNet", "atm")
					end

					if #safeLocks < Config.TotalLocks then
						currentSafeCorrectPosition = math.random(1, 350)
					else
						ResetCrackingGame()

						local closestSafeaAtCoords = GetEntityCoords(safeEntity)
						local currentStreetName = GetCurrentStreetName()
				
						ESX.TriggerServerCallback("Fewthz_safe:safeBreached", function(breached)
							if breached then
								local breachObjects = SpawnBreachObjects(safeEntity)
				
								GlobalFunction("open_door", {
									["store"] = currentStreetName,
									["doorCoords"] = {
										["x"] = closestSafeaAtCoords["x"],
										["y"] = closestSafeaAtCoords["y"],
										["z"] = closestSafeaAtCoords["z"]
									},
									["objects"] = breachObjects,
									["streetName"] = currentStreetName,
									["save"] = true
								})
				
								ESX.ShowNotification("You cracked the safe!")
							else
								ESX.ShowNotification("The safe is already open!")
							end
						end, {
							["store"] = currentStreetName,
							["doorCoords"] = {
								["x"] = closestSafeaAtCoords["x"],
								["y"] = closestSafeaAtCoords["y"],
								["z"] = closestSafeaAtCoords["z"]
							},
							["doorRotation"] = GetEntityRotation(safeEntity)
						})
					end
				else
					ESX.ShowNotification("Wrong combination try again.")
				end
			elseif IsControlJustPressed(0, 47) then
				ResetCrackingGame()
			elseif IsControlJustPressed(0, 172) then
				MoveSafeDial(true)
			elseif IsControlJustPressed(0, 173) then
				MoveSafeDial(false)
			elseif IsControlPressed(0, 174) then
				MoveSafeDial(true)
			elseif IsControlPressed(0, 175) then
				MoveSafeDial(false)
			end

		  	Citizen.Wait(0)
		end
	end)
end

MoveSafeDial = function(clockwise)
	if clockwise then
		dialRotation = dialRotation + 1

		if dialRotation == currentSafeCorrectPosition then
			PlaySoundFrontend(0, "TUMBLER_PIN_FALL", "SAFE_CRACK_SOUNDSET", 1)
		else
			PlaySoundFrontend(0, "TUMBLER_TURN", "SAFE_CRACK_SOUNDSET", 1)
		end

		if dialRotation >= 360 then
			dialRotation = 0.0
		end
	else
		dialRotation = dialRotation - 1

		if dialRotation == currentSafeCorrectPosition then
			PlaySoundFrontend(0, "TUMBLER_PIN_FALL", "SAFE_CRACK_SOUNDSET", 1)
		else
			PlaySoundFrontend(0, "TUMBLER_TURN", "SAFE_CRACK_SOUNDSET", 1)
		end

		if dialRotation <= 0 then
			dialRotation = 360.0
		end
	end

	Citizen.Wait(10)
end

ControlDoor = function(close, safeEntity)
	Citizen.CreateThread(function()
		local runs = 0

		while runs < 140 do
			Citizen.Wait(10)

			local oldSafeHeading = GetEntityHeading(safeEntity)

			if close then
				SetEntityHeading(safeEntity, oldSafeHeading - 0.7)
			else
				SetEntityHeading(safeEntity, oldSafeHeading + 0.7)
			end

			runs = runs + 1	
		end

		FreezeEntityPosition(safeEntity, true)
	end)
end

SpawnBreachObjects = function(safeEntity)
	local breachObjects = {}

	local startX = -0.1

	while not HasModelLoaded(GetHashKey("prop_anim_cash_pile_02")) do
		Citizen.Wait(0)

		RequestModel(GetHashKey("prop_anim_cash_pile_02"))
	end

	for cashPileIndex = 1, 4 do
		local cashPileCoords = GetOffsetFromEntityInWorldCoords(safeEntity, startX, 0.4, 0.09)
		local cashPile = CreateObject(GetHashKey("prop_anim_cash_pile_02"), cashPileCoords, true)
		
		table.insert(breachObjects, ObjToNet(cashPile))

		startX = startX - 0.15
	end
	
	while not HasModelLoaded(GetHashKey("prop_champ_01a")) do
		Citizen.Wait(0)

		RequestModel(GetHashKey("prop_champ_01a"))
	end

	local champCoords = GetOffsetFromEntityInWorldCoords(safeEntity, -0.45, 0.4, -0.65)
	local champEntity = CreateObject(GetHashKey("prop_champ_01a"), champCoords, true)

	table.insert(breachObjects, ObjToNet(champEntity))

	SetModelAsNoLongerNeeded(GetHashKey("prop_anim_cash_pile_02"))
	SetModelAsNoLongerNeeded(GetHashKey("prop_champ_01a"))

	return breachObjects
end

TakeSafeItem = function(itemEntity, safeData)
	while not HasAnimDictLoaded("mp_missheist_ornatebank") do
		Citizen.Wait(0)

		RequestAnimDict("mp_missheist_ornatebank")
	end

	TaskPlayAnim(PlayerPedId(), "mp_missheist_ornatebank", "put_cash_into_bag_loop", 1.0, 1.0, 1250, 63, 0.0, 0, 0, 0)

	Citizen.Wait(200)

	while IsEntityPlayingAnim(PlayerPedId(), "mp_missheist_ornatebank", "put_cash_into_bag_loop", 3) do
		Citizen.Wait(0)
	end

	if DoesEntityExist(itemEntity) then
		while not NetworkHasControlOfEntity(itemEntity) do
			Citizen.Wait(0)
	
			NetworkRequestControlOfEntity(itemEntity)
		end

		local stoleItem = GetEntityModel(itemEntity) == GetHashKey("prop_anim_cash_pile_02") and "money" or "champagne"

		ESX.TriggerServerCallback("Fewthz_safe:receiveReward", function(received)
			if received then
				-- print("You stole: " .. stoleItem)
			end
		end, stoleItem)

		DeleteEntity(itemEntity)
	else
		ESX.ShowNotification("Someone stole it before you!")
	end
end

DrawButtons = function(buttonsToDraw)
	Citizen.CreateThread(function()
		local instructionScaleform = RequestScaleformMovie("instructional_buttons")
	
		while not HasScaleformMovieLoaded(instructionScaleform) do
			Wait(0)
		end
	
		PushScaleformMovieFunction(instructionScaleform, "CLEAR_ALL")
		PushScaleformMovieFunction(instructionScaleform, "TOGGLE_MOUSE_BUTTONS")
		PushScaleformMovieFunctionParameterBool(0)
		PopScaleformMovieFunctionVoid()
	
		for buttonIndex, buttonValues in ipairs(buttonsToDraw) do
			PushScaleformMovieFunction(instructionScaleform, "SET_DATA_SLOT")
			PushScaleformMovieFunctionParameterInt(buttonIndex - 1)
	
			PushScaleformMovieMethodParameterButtonName(buttonValues["button"])
			PushScaleformMovieFunctionParameterString(buttonValues["label"])
			PopScaleformMovieFunctionVoid()
		end
	
		PushScaleformMovieFunction(instructionScaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
		PushScaleformMovieFunctionParameterInt(-1)
		PopScaleformMovieFunctionVoid()
		DrawScaleformMovieFullscreen(instructionScaleform, 255, 255, 255, 255)
	
		-- SetScaleformMovieAsNoLongerNeeded(instructionScaleform)
	end)
  end

GetCurrentStreetName = function()
	local pedCoords = GetEntityCoords(PlayerPedId())

	local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(pedCoords["x"], pedCoords["y"], pedCoords["z"], currentStreetHash, intersectStreetHash)
	local currentStreetName = GetStreetNameFromHashKey(currentStreetHash)

	return currentStreetName
end

DrawScriptMarker = function(markerData)
    DrawMarker(markerData["type"] or 1, markerData["pos"] or vector3(0.0, 0.0, 0.0), 0.0, 0.0, 0.0, (markerData["type"] == 6 and -90.0 or markerData["rotate"] and -180.0) or 0.0, 0.0, 0.0, markerData["sizeX"] or 1.0, markerData["sizeY"] or 1.0, markerData["sizeZ"] or 1.0, markerData["r"] or 1.0, markerData["g"] or 1.0, markerData["b"] or 1.0, 100, false, true, 2, false, false, false, false)
end