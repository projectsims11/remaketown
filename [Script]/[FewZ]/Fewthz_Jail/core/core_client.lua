local isInJail, unjail = false, false
local jailTime, fastTimer = 0, 0
local jailPos = nil
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

if Config.CutScene then
	function loadAnim(animDict)
		RequestAnimDict(animDict)
	
		while not HasAnimDictLoaded(animDict) do
			Citizen.Wait(10)
		end
	end
	
	function loadModel(model)
		RequestModel(model)
	
		while not HasModelLoaded(model) do
			Citizen.Wait(10)
		end
	end
end

RegisterNetEvent(GetCurrentResourceName() .. ':jailPlayer')
AddEventHandler(GetCurrentResourceName() .. ':jailPlayer', function(_jailTime, _jailPosition, _quiet)
	jailTime = _jailTime
	jailPos = _jailPosition

	local playerPed = PlayerPedId()

	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.prison_wear.male)
		else
			TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.prison_wear.female)
		end
	end)

	if Config.CutScene and not _quiet then
		DoScreenFadeOut(100)
		Citizen.Wait(250)

		loadModel(-1320879687)
		local PolicePosition = {
			['x'] = 402.91702270508, 
			['y'] = -1000.6376953125, 
			['z'] = -99.004028320313, 
			['h'] = 356.88052368164
		}
		local Police = CreatePed(5, -1320879687, PolicePosition['x'], PolicePosition['y'], PolicePosition['z'], PolicePosition['h'], false)
		TaskStartScenarioInPlace(Police, 'WORLD_HUMAN_PAPARAZZI', 0, false)

		local PlayerPosition = { 
			['x'] = 402.91567993164, 
			['y'] = -996.75970458984, 
			['z'] = -99.000259399414, 
			['h'] = 186.22499084473 
		}
		local PlayerPed = PlayerPedId()
		SetEntityCoords(PlayerPed, PlayerPosition['x'], PlayerPosition['y'], PlayerPosition['z'] - 1)
		SetEntityHeading(PlayerPed, PlayerPosition['h'])
		FreezeEntityPosition(PlayerPed, true)

		local CamOptions = {
			['x'] = 402.88830566406, 
			['y'] = -1003.8851318359, 
			['z'] = -97.419647216797, 
			['rotationX'] = -15.433070763946, 
			['rotationY'] = 0.0, 
			['rotationZ'] = -0.31496068835258, 
			['cameraId'] = 0 
		}

		CamOptions['cameraId'] = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)

		SetCamCoord(CamOptions['cameraId'], CamOptions['x'], CamOptions['y'], CamOptions['z'])
		SetCamRot(CamOptions['cameraId'], CamOptions['rotationX'], CamOptions['rotationY'], CamOptions['rotationZ'])

		RenderScriptCams(true, false, 0, true, true)

		Citizen.Wait(1000)
		DoScreenFadeIn(100)
		Citizen.Wait(10000)
		DoScreenFadeOut(250)

		DeleteEntity(Police)
		SetModelAsNoLongerNeeded(-1320879687)

		Citizen.Wait(1000)
		DoScreenFadeIn(250)
		TriggerServerEvent('InteractSound_SV:PlayOnSource', 'cell', 0.3)

		RenderScriptCams(false, false, 0, true, true)
		FreezeEntityPosition(PlayerPed, false)
		DestroyCam(0)
	end

	SetPedArmour(playerPed, 0)
	ESX.Game.Teleport(playerPed, Config.JailLocations[_jailPosition].JailPosition)
	isInJail, unjail = true, false

	while not unjail do
		Citizen.Wait(2000)
	end
	SetEntityCoords(playerPed, Config.UnjailPosition)
	isInJail = false

	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
	end)
end)

Citizen.CreateThread(function()
	Citizen.Wait(1000)
	SendNUIMessage({
		type = 'setup',
		locations = Config.JailLocations
	})
end)

RegisterNetEvent(GetCurrentResourceName() .. ':unjailPlayer')
AddEventHandler(GetCurrentResourceName() .. ':unjailPlayer', function()
	print('you have been released from jailed!')
	unjail, jailTime, fastTimer = true, 0, 0

	SetEntityCoords(PlayerPedId(), Config.UnjailPosition)

	Config.Executor.OnUnJailed()
end)

RegisterNetEvent(GetCurrentResourceName() .. ':openMenu')
AddEventHandler(GetCurrentResourceName() .. ':openMenu', function()
	SendNUIMessage({
		type = 'open'
	})
	SetNuiFocus(true, true)

	if Config.BlurBackdrop then
		TriggerScreenblurFadeIn()
	end
end)

RegisterNetEvent(GetCurrentResourceName() .. ':closeMenu')
AddEventHandler(GetCurrentResourceName() .. ':closeMenu', function()
	SendNUIMessage({
		type = 'close'
	})
	SetNuiFocus(false, false)

	if Config.BlurBackdrop then
		TriggerScreenblurFadeOut()
	end
end)

RegisterNUICallback('submit', function(data, cb)
	TriggerServerEvent(GetCurrentResourceName() .. ':sendToJail', data.playerId, data.time, false, data.location, data.announce)
	cb('ok')
end)

RegisterNUICallback('close', function(data, cb)
	TriggerEvent(GetCurrentResourceName() .. ':closeMenu')
	cb('ok')
end)

RegisterNUICallback('getNearestPlayer', function(data, cb)
	local closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer()

	if closestPlayer == -1 or closestPlayerDistance > 3.0 then
		Config.Executor.OnNoPlayerNearby()
	else
		SendNUIMessage({
			type = 'getNearestPlayer',
			id = GetPlayerServerId(closestPlayer)
		})
	end

	cb('ok')
end)

AddEventHandler('esx:onPlayerSpawn', function(spawn)
	if isInJail then
		ESX.Game.Teleport(PlayerPedId(), Config.JailLocations['large_prison'].JailPosition)
	end
end)

AddEventHandler('esx:onPlayerDeath', function(data)
    if isInJail then
		ESX.Game.Teleport(PlayerPedId(), Config.JailLocations['small_prison'].JailPosition)
	end   
end)

if Config.DevTest then
	RegisterCommand('jailer', function(source, args, rawCommand)
		TriggerEvent(GetCurrentResourceName() .. ':openMenu')
	end, false)
end