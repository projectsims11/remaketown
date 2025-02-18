ESX = exports["es_extended"]:getSharedObject()

local range = Config.range
local notifIn = false
local notifOut = false
local isDead = false
local closestZone = 1

Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end
	
	for i = 1, #Config['zone'], 1 do
		local blip = AddBlipForRadius(Config['zone'][closestZone].x, Config['zone'][closestZone].y, Config['zone'][closestZone].z, Config['zone'][closestZone].size or range)

		if Config.ShowBlip == true then
			local szBlip = AddBlipForCoord(Config['zone'][i].x, Config['zone'][i].y, Config['zone'][i].z)
			SetBlipAsShortRange(szBlip, true)
			SetBlipColour(blip,59)
			SetBlipSprite(szBlip, 84)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('<font face="sarabun"> WARZONE วอโซน </font>')
			EndTextCommandSetBlipName(szBlip)
		end
		
		SetBlipColour(blip,59)
		SetBlipAlpha(blip,180)
	end
end)

Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end
	
	while true do
		local playerPed = GetPlayerPed(-1)
		local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
		local minDistance = 100000
		for i = 1, #Config['zone'], 1 do
			dist = Vdist(Config['zone'][i].x, Config['zone'][i].y, Config['zone'][i].z, x, y, z)
			if dist < minDistance then
				minDistance = dist
				closestZone = i
			end
		end
		Citizen.Wait(15000)
	end
end)

Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end
	
	while true do
		Citizen.Wait(0)
		local player = GetPlayerPed(-1)
		local coord = GetEntityCoords(PlayerPedId())
		local x,y,z = table.unpack(GetEntityCoords(player, true))
		local dist = Vdist(Config['zone'][closestZone].x, Config['zone'][closestZone].y, Config['zone'][closestZone].z, x, y, z)
		local sleep = true
		
		if Config.Show == true then
			if dist <= range then
				if not notifIn then
					exports.pNotify:SendNotification(
					{
						text = "Join Warzone",
						type = "success",
						timeout = 3000,
						layout = "topRight",
						queue = "warzone"
					})
					notifIn = true
					notifOut = false
					isDead = false
				end
			else
				if not notifOut then
					exports.pNotify:SendNotification(
					{
						text = "Exit Warzone",
						type = "error",
						timeout = 3000,
						layout = "topRight",
						queue = "warzone"
					})
					notifOut = true
					notifIn = false
					isDead = false
				end
			end
		elseif Config.Show == false then
			if dist <= range then
				if not notifIn then
					notifIn = true
					notifOut = false
					isDead = false
				end
			else
				if not notifOut then
					notifOut = true
					notifIn = false
					isDead = false
				end
			end
		end

		if not notifOut then
			if isDead then
				onDeath(data)
				isDead = false
				Wait(1000)
				SetEntityHealth(player, Config.SpawnHealth)
			end
		end

		if Config.ZoneView == true then
			if Config.Zone == true then
				if GetDistanceBetweenCoords(coord, Config['zone'][closestZone].x, Config['zone'][closestZone].y, Config['zone'][closestZone].z,true) < Config.DrawDistance then
					sleep = false
					DrawMarker(1, Config['zone'][closestZone].x, Config['zone'][closestZone].y, Config['zone'][closestZone].z-1.0001, 0, 0, 0, 0, 0, 0, Config['zone'][closestZone].size or range * 2, Config['zone'][closestZone].size or range * 2, 50.0, 59, 0, 0, 155, 0, 0, 2, 0, 0, 0, 0) -- ปรับขนาดวงแดง
				end
			end
		elseif Config.ZoneView == false then
			if Config.Zone == true then
				if not notifOut then
					if GetDistanceBetweenCoords(coord, Config['zone'][closestZone].x, Config['zone'][closestZone].y, Config['zone'][closestZone].z,true) < Config.DrawDistance then
						sleep = false
						DrawMarker(1, Config['zone'][closestZone].x, Config['zone'][closestZone].y, Config['zone'][closestZone].z-1.0001, 0, 0, 0, 0, 0, 0, Config['zone'][closestZone].size or range * 2, Config['zone'][closestZone].size or range * 2, 50.0, 59, 0, 0, 155, 0, 0, 2, 0, 0, 0, 0) -- ปรับขนาดวงแดง
					end
				end
			end
		end
		if sleep then
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local Ped = PlayerPedId()
		local canSleep  = true
		if Config.allowCarInside == false then
			if GetDistanceBetweenCoords(GetEntityCoords(Ped),Config['zone'][closestZone].x, Config['zone'][closestZone].y, Config['zone'][closestZone].z,true) < Config.range + 2.0 then
				canSleep = false
		  		local PedVeh = GetVehiclePedIsIn(Ped,false) 
		  		if PedVeh ~= 0 then
					local vehCoords = GetEntityCoords(PedVeh)
					SetEntityCoords(PedVeh, vehCoords)
					TaskLeaveVehicle(Ped, PedVeh, 0)
		  		end
			end
		end
		if canSleep then
			Citizen.Wait(500)
		end
	end
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	OnPlayerDeath()
end)

function OnPlayerDeath()
	isDead = true
end

function onDeath(data)
	exports['progressBars']:startUI(Config.SpawnTime * 1000, "กำลังจะเกิด")
	Wait(Config.SpawnTime * 1000)

	TriggerEvent('FewZ:revive')
end

RegisterNetEvent('FewZ:revive')
AddEventHandler('FewZ:revive', function()
	local playerPed = PlayerPedId() -- GetPlayerPed(-1) << don't use this one cuz it old native of esx
	local coords    = GetEntityCoords(playerPed)
	print('revive :  '..coords) 

	FreezeEntityPosition(PlayerPedId(), true)
	Wait(100)

	TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)

	TriggerEvent('esx:onPlayerSpawn')

	Citizen.CreateThread(function()

		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(0)
		end

		RespawnPed(playerPed, coords)
		
		StopScreenEffect('')
		DoScreenFadeIn(800)
		FreezeEntityPosition(PlayerPedId(), false)
		Citizen.Wait(1000)
	end)
end)

function RespawnPed(ped, coordsa, heading)
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	SetEntityCoordsNoOffset(playerPed, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(playerPed, false)
	TriggerEvent('playerSpawned', coords.x, coords.y, coords.z)
	ClearPedBloodDamage(playerPed)
	Citizen.Wait(1000)
	ESX.UI.Menu.CloseAll()
end
