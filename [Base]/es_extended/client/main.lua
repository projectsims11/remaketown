CreateThread(function()
	while true do
		Wait(100)

		if NetworkIsPlayerActive(PlayerId()) then
			exports.spawnmanager:setAutoSpawn(false)
			DoScreenFadeOut(0)
			Wait(500)
			TriggerServerEvent('esx:onPlayerJoined')
			break
		end
	end
end)

RegisterNetEvent("esx:requestModel", function(model)
	ESX.Streaming.RequestModel(model)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer, isNew, skin)
	ESX.PlayerData = xPlayer

	exports.spawnmanager:spawnPlayer({
		x = ESX.PlayerData.coords.x,
		y = ESX.PlayerData.coords.y,
		z = ESX.PlayerData.coords.z + 0.25,
		heading = ESX.PlayerData.coords.heading,
		model = `mp_m_freemode_01`,
		skipFade = false
	}, function()
		TriggerServerEvent('esx:onPlayerSpawn')
		TriggerEvent('esx:onPlayerSpawn')
		TriggerEvent('esx:restoreLoadout')

		if isNew then
			TriggerEvent('skinchanger:loadDefaultModel', skin.sex == 0)
		elseif skin then
			TriggerEvent('skinchanger:loadSkin', skin)
		end

		TriggerEvent('esx:loadingScreenOff')
		ShutdownLoadingScreen()
		ShutdownLoadingScreenNui()
	end)

	ESX.PlayerLoaded = true

	while ESX.PlayerData.ped == nil do Wait(20) end

	if Config.EnablePVP then
		SetCanAttackFriendly(ESX.PlayerData.ped, true, false)
		NetworkSetFriendlyFireOption(true)
	end

RegisterNetEvent('update:data:players')
    AddEventHandler('update:data:players', function(health, armour)
	SetPedArmour(PlayerPedId(), armour)
	SetEntityHealth(PlayerPedId(), health)
end)

		-- RemoveHudComponents
		for i = 1, #(Config.RemoveHudComponents) do
			if Config.RemoveHudComponents[i] then
				SetHudComponentPosition(i, 999999.0, 999999.0)
			end
		end


	SetDefaultVehicleNumberPlateTextPattern(-1, Config.CustomAIPlates)
	StartServerSyncLoops()
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
	ESX.PlayerLoaded = false
end)

local function onPlayerSpawn()
	ESX.SetPlayerData('ped', PlayerPedId())
	ESX.SetPlayerData('dead', false)
end

AddEventHandler('playerSpawned', onPlayerSpawn)
AddEventHandler('esx:onPlayerSpawn', onPlayerSpawn)

AddEventHandler('esx:onPlayerDeath', function()
	ESX.SetPlayerData('ped', PlayerPedId())
	ESX.SetPlayerData('dead', true)
end)

AddEventHandler('skinchanger:modelLoaded', function()
	while not ESX.PlayerLoaded do
		Wait(100)
	end
	TriggerEvent('esx:restoreLoadout')
end)

AddEventHandler('esx:restoreLoadout', function()
	ESX.SetPlayerData('ped', PlayerPedId())

	local ammoTypes = {}
	RemoveAllPedWeapons(ESX.PlayerData.ped, true)

	for _, v in ipairs(ESX.PlayerData.loadout) do
		local weaponName = v.name
		local weaponHash = GetHashKey(weaponName)

		GiveWeaponToPed(ESX.PlayerData.ped, weaponHash, 0, false, false)
		SetPedWeaponTintIndex(ESX.PlayerData.ped, weaponHash, v.tintIndex)

		local ammoType = GetPedAmmoTypeFromWeapon(ESX.PlayerData.ped, weaponHash)

		for _, v2 in ipairs(v.components) do
			local componentHash = ESX.GetWeaponComponent(weaponName, v2).hash
			GiveWeaponComponentToPed(ESX.PlayerData.ped, weaponHash, componentHash)
		end

		if not ammoTypes[ammoType] then
			AddAmmoToPed(ESX.PlayerData.ped, weaponHash, v.ammo)
			ammoTypes[ammoType] = true
		end
	end
end)

-- Credit: https://github.com/LukeWasTakenn, https://github.com/LukeWasTakenn/luke_garages/blob/master/client/client.lua#L331-L352
AddStateBagChangeHandler('VehicleProperties', nil, function(bagName, _, value)
	if not value then
		return
	end

	local netId = bagName:gsub('entity:', '')
	local timer = GetGameTimer()
	while not NetworkDoesEntityExistWithNetworkId(tonumber(netId)) do
		Wait(0)
		if GetGameTimer() - timer > 10000 then
			return
		end
	end

	local vehicle = NetToVeh(tonumber(netId))
	local timer2 = GetGameTimer()
	while NetworkGetEntityOwner(vehicle) ~= PlayerId() do
		Wait(0)
		if GetGameTimer() - timer2 > 10000 then
			return
		end
	end

	ESX.Game.SetVehicleProperties(vehicle, value)
end)

if Config["Function_Base"]['Update_Weapon'] then
	Citizen.CreateThread(function()
		local lastLoadout = {}
	
		while true do
			Citizen.Wait(3000)
			local playerPed, loadout, loadoutChanged = PlayerPedId(), {}, false
	
			for k,v in ipairs(Config.Weapons) do
				local weaponName = v.name
				local weaponHash = GetHashKey(weaponName)
	
				if HasPedGotWeapon(playerPed, weaponHash, false) then
					local ammo, tintIndex, weaponComponents = GetAmmoInPedWeapon(playerPed, weaponHash), GetPedWeaponTintIndex(playerPed, weaponHash), {}
	
					for k2,v2 in ipairs(v.components) do
						if HasPedGotWeaponComponent(playerPed, weaponHash, v2.hash) then
							table.insert(weaponComponents, v2.name)
						end
					end
	
					if not lastLoadout[weaponName] or lastLoadout[weaponName] ~= ammo then
						loadoutChanged = true
					end
	
					lastLoadout[weaponName] = ammo
	
					table.insert(loadout, {
						name = weaponName,
						ammo = ammo,
						label = v.label,
						components = weaponComponents,
						tintIndex = tintIndex
					})
				else
					if lastLoadout[weaponName] then
						loadoutChanged = true
					end
	
					lastLoadout[weaponName] = nil
				end
			end
	
			if loadoutChanged and isLoadoutLoaded then
				ESX.PlayerData.loadout = loadout
				TriggerServerEvent('esx:updateLoadout', loadout)
			end
		end
	end)
end

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
	for i = 1, #(ESX.PlayerData.accounts) do
		if ESX.PlayerData.accounts[i].name == account.name then
			ESX.PlayerData.accounts[i] = account
			break
		end
	end

	ESX.SetPlayerData('accounts', ESX.PlayerData.accounts)
end)

RegisterNetEvent('esx:addInventoryItem')
AddEventHandler('esx:addInventoryItem', function(item, count, showNotification)
	for k, v in ipairs(ESX.PlayerData.inventory) do
		if v.name == item then
			ESX.PlayerData.inventory[k].count = count
			break
		end
	end
end)

RegisterNetEvent('esx:removeInventoryItem')
AddEventHandler('esx:removeInventoryItem', function(item, count, showNotification)
	for k, v in ipairs(ESX.PlayerData.inventory) do
		if v.name == item then
			ESX.PlayerData.inventory[k].count = count
			break
		end
	end
end)

RegisterNetEvent('esx:addWeapon')
AddEventHandler('esx:addWeapon', function()
	print("[^1ERROR^7] event ^5'esx:addWeapon'^7 Has Been Removed. Please use ^5xPlayer.addWeapon^7 Instead!")
end)

RegisterNetEvent('esx:addWeaponComponent')
AddEventHandler('esx:addWeaponComponent', function()
	print("[^1ERROR^7] event ^5'esx:addWeaponComponent'^7 Has Been Removed. Please use ^5xPlayer.addWeaponComponent^7 Instead!")
end)

RegisterNetEvent('esx:setWeaponAmmo')
AddEventHandler('esx:setWeaponAmmo', function()
	print("[^1ERROR^7] event ^5'esx:setWeaponAmmo'^7 Has Been Removed. Please use ^5xPlayer.addWeaponAmmo^7 Instead!")
end)

RegisterNetEvent('esx:setWeaponTint')
AddEventHandler('esx:setWeaponTint', function(weapon, weaponTintIndex)
	SetPedWeaponTintIndex(ESX.PlayerData.ped, GetHashKey(weapon), weaponTintIndex)
end)

RegisterNetEvent('esx:removeWeapon')
AddEventHandler('esx:removeWeapon', function()
	print("[^1ERROR^7] event ^5'esx:removeWeapon'^7 Has Been Removed. Please use ^5xPlayer.removeWeapon^7 Instead!")
end)

RegisterNetEvent('esx:removeWeaponComponent')
AddEventHandler('esx:removeWeaponComponent', function(weapon, weaponComponent)
	local componentHash = ESX.GetWeaponComponent(weapon, weaponComponent).hash
	RemoveWeaponComponentFromPed(ESX.PlayerData.ped, GetHashKey(weapon), componentHash)
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(Job)
	ESX.SetPlayerData('job', Job)
end)

RegisterNetEvent('esx:registerSuggestions')
AddEventHandler('esx:registerSuggestions', function(registeredCommands)
	for name, command in pairs(registeredCommands) do
		if command.suggestion then
			TriggerEvent('chat:addSuggestion', ('/%s'):format(name), command.suggestion.help, command.suggestion.arguments)
		end
	end
end)

function StartServerSyncLoops()
	CreateThread(function()
		local currentWeapon = { Ammo = 0 }
		while ESX.PlayerLoaded do
			local sleep = 1500
			if GetSelectedPedWeapon(ESX.PlayerData.ped) ~= -1569615261 then
				sleep = 1000
				local _, weaponHash = GetCurrentPedWeapon(ESX.PlayerData.ped, true)
				local weapon = ESX.GetWeaponFromHash(weaponHash)
				if weapon then
					local ammoCount = GetAmmoInPedWeapon(ESX.PlayerData.ped, weaponHash)
					if weapon.name ~= currentWeapon.name then
						currentWeapon.Ammo = ammoCount
						currentWeapon.name = weapon.name
					else
						if ammoCount ~= currentWeapon.Ammo then
							currentWeapon.Ammo = ammoCount
							TriggerServerEvent('esx:updateWeaponAmmo', weapon.name, ammoCount)
						end
					end
				end
			end
			Wait(sleep)
		end
	end)
end

-- disable wanted level
if not Config.EnableWantedLevel then
	ClearPlayerWantedLevel(PlayerId())
	SetMaxWantedLevel(0)
end

----- Admin commands from esx_adminplus

RegisterNetEvent("esx:tpm")
AddEventHandler("esx:tpm", function()
	local GetEntityCoords = GetEntityCoords
	local GetGroundZFor_3dCoord = GetGroundZFor_3dCoord
	local GetFirstBlipInfoId = GetFirstBlipInfoId
	local DoesBlipExist = DoesBlipExist
	local DoScreenFadeOut = DoScreenFadeOut
	local GetBlipInfoIdCoord = GetBlipInfoIdCoord
	local GetVehiclePedIsIn = GetVehiclePedIsIn

	ESX.TriggerServerCallback("esx:isUserAdmin", function(admin)
		if not admin then
			return
		end
		local blipMarker = GetFirstBlipInfoId(8)
		if not DoesBlipExist(blipMarker) then
			ESX.ShowNotification(TranslateCap('tpm_nowaypoint'), true, false, 140)
			return 'marker'
		end

		-- Fade screen to hide how clients get teleported.
		DoScreenFadeOut(650)
		while not IsScreenFadedOut() do
			Wait(0)
		end

		local ped, coords = ESX.PlayerData.ped, GetBlipInfoIdCoord(blipMarker)
		local vehicle = GetVehiclePedIsIn(ped, false)
		local oldCoords = GetEntityCoords(ped)

		-- Unpack coords instead of having to unpack them while iterating.
		-- 825.0 seems to be the max a player can reach while 0.0 being the lowest.
		local x, y, groundZ, Z_START = coords['x'], coords['y'], 850.0, 950.0
		local found = false
		FreezeEntityPosition(vehicle > 0 and vehicle or ped, true)

		for i = Z_START, 0, -25.0 do
			local z = i
			if (i % 2) ~= 0 then
				z = Z_START - i
			end

			NewLoadSceneStart(x, y, z, x, y, z, 50.0, 0)
			local curTime = GetGameTimer()
			while IsNetworkLoadingScene() do
				if GetGameTimer() - curTime > 1000 then
					break
				end
				Wait(0)
			end
			NewLoadSceneStop()
			SetPedCoordsKeepVehicle(ped, x, y, z)

			while not HasCollisionLoadedAroundEntity(ped) do
				RequestCollisionAtCoord(x, y, z)
				if GetGameTimer() - curTime > 1000 then
					break
				end
				Wait(0)
			end

			-- Get ground coord. As mentioned in the natives, this only works if the client is in render distance.
			found, groundZ = GetGroundZFor_3dCoord(x, y, z, false)
			if found then
				Wait(0)
				SetPedCoordsKeepVehicle(ped, x, y, groundZ)
				break
			end
			Wait(0)
		end

		-- Remove black screen once the loop has ended.
		DoScreenFadeIn(650)
		FreezeEntityPosition(vehicle > 0 and vehicle or ped, false)

		if not found then
			-- If we can't find the coords, set the coords to the old ones.
			-- We don't unpack them before since they aren't in a loop and only called once.
			SetPedCoordsKeepVehicle(ped, oldCoords['x'], oldCoords['y'], oldCoords['z'] - 1.0)
			ESX.ShowNotification(TranslateCap('tpm_success'), true, false, 140)
		end

		-- If Z coord was found, set coords in found coords.
		SetPedCoordsKeepVehicle(ped, x, y, groundZ)
		ESX.ShowNotification(TranslateCap('tpm_success'), true, false, 140)
	end)
end)

local noclip = false
local noclip_pos = vector3(0, 0, 70)
local heading = 0

local function noclipThread()
	while noclip do
		SetEntityCoordsNoOffset(ESX.PlayerData.ped, noclip_pos.x, noclip_pos.y, noclip_pos.z, 0, 0, 0)

		if IsControlPressed(1, 34) then
			heading = heading + 1.5
			if heading > 360 then
				heading = 0
			end

			SetEntityHeading(ESX.PlayerData.ped, heading)
		end

		if IsControlPressed(1, 9) then
			heading = heading - 1.5
			if heading < 0 then
				heading = 360
			end

			SetEntityHeading(ESX.PlayerData.ped, heading)
		end

		if IsControlPressed(1, 8) then
			noclip_pos = GetOffsetFromEntityInWorldCoords(ESX.PlayerData.ped, 0.0, 1.0, 0.0)
		end

		if IsControlPressed(1, 32) then
			noclip_pos = GetOffsetFromEntityInWorldCoords(ESX.PlayerData.ped, 0.0, -1.0, 0.0)
		end

		if IsControlPressed(1, 27) then
			noclip_pos = GetOffsetFromEntityInWorldCoords(ESX.PlayerData.ped, 0.0, 0.0, 1.0)
		end

		if IsControlPressed(1, 173) then
			noclip_pos = GetOffsetFromEntityInWorldCoords(ESX.PlayerData.ped, 0.0, 0.0, -1.0)
		end
		Wait(0)
	end
end

RegisterNetEvent("esx:noclip")
AddEventHandler("esx:noclip", function()
	ESX.TriggerServerCallback("esx:isUserAdmin", function(admin)
		if not admin then
			return
		end

		if not noclip then
			noclip_pos = GetEntityCoords(ESX.PlayerData.ped, false)
			heading = GetEntityHeading(ESX.PlayerData.ped)
		end

		noclip = not noclip
		if noclip then
			CreateThread(noclipThread)
		end

		ESX.ShowNotification(TranslateCap('noclip_message', noclip and Translate('enabled') or Translate('disabled')), true, false, 140)
	end)
end)

RegisterNetEvent("esx:killPlayer")
AddEventHandler("esx:killPlayer", function()
	SetEntityHealth(ESX.PlayerData.ped, 0)
end)

RegisterNetEvent("esx:repairPedVehicle")
AddEventHandler("esx:repairPedVehicle", function()
	local ped = ESX.PlayerData.ped
	local vehicle = GetVehiclePedIsIn(ped, false)
	SetVehicleEngineHealth(vehicle, 1000)
	SetVehicleEngineOn(vehicle, true, true)
	SetVehicleFixed(vehicle)
	SetVehicleDirtLevel(vehicle, 0)
end)

RegisterNetEvent("esx:freezePlayer")
AddEventHandler("esx:freezePlayer", function(input)
	local player = PlayerId()
	if input == 'freeze' then
		SetEntityCollision(ESX.PlayerData.ped, false)
		FreezeEntityPosition(ESX.PlayerData.ped, true)
		SetPlayerInvincible(player, true)
	elseif input == 'unfreeze' then
		SetEntityCollision(ESX.PlayerData.ped, true)
		FreezeEntityPosition(ESX.PlayerData.ped, false)
		SetPlayerInvincible(player, false)
	end
end)

ESX.RegisterClientCallback("esx:GetVehicleType", function(cb, model)
	cb(ESX.GetVehicleType(model))
end)

AddStateBagChangeHandler('metadata', 'player:' .. tostring(GetPlayerServerId(PlayerId())), function(_, key, val)
	ESX.SetPlayerData(key, val)
end)
