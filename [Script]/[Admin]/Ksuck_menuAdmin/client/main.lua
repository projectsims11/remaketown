ESX = nil
admin = {}
local display, frozen, isSpectating, noclip, speed  = false, false, false, false, 1
local temppos = nil
_playerRank = nil
_jobs = nil
_results = nil
playerID = 0

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

AddEventHandler("Fewthz_core:ClientMemoryGarbage", function()
	Citizen.CreateThread(function()
		Wait(math.random(100, 2000))
		collectgarbage()
	end)
end)

-- ปิด
RegisterNUICallback("exit", function(data)
    SetDisplay(false)
end)

RegisterNUICallback("ban", function(data)
    TriggerServerEvent("admin:Ban", data.playerid, tonumber(data.inputData), "You have been put on a timeout")
end)

RegisterNUICallback("permaban", function(data)
    TriggerServerEvent("admin:Ban", data.playerid, 0, data.inputData)
end)

RegisterNUICallback("unban", function(data)
    TriggerServerEvent("admin:Unban", data.confirmoutput)
    admin.GetPlayers()
end)

RegisterNUICallback("addCash", function(data)
    local amnt = tonumber(data.inputData)
    TriggerServerEvent("admin:AddCash", data.playerid, amnt)
end)

RegisterNUICallback("addBlackCash", function(data)
    local amnt = tonumber(data.inputData)
    TriggerServerEvent("admin:AddBlackCash", data.playerid, amnt)
end)

RegisterNUICallback("addBank", function(data)
    local amnt = tonumber(data.inputData)
    TriggerServerEvent("admin:AddBank", data.playerid, amnt)
end)

RegisterNUICallback("inventory", function(data)
	ConfigCL["Inventory"](data)
end)

RegisterNUICallback("giveitem", function(data)
    local amnt = tonumber(data.amount)
    print("id: "..data.playerid.." name: "..data.name.." amount: "..data.amount)
    TriggerServerEvent("admin:AddItem", data.playerid, data.name, amnt)
end)

RegisterNUICallback("error", function(data)
    chat(data.error, {255,0,0})
    SetDisplay(false)
end)

RegisterNUICallback("tp-wp", function(data)
    admin.TeleportToWaypoint()
end)

RegisterNUICallback("bring", function(data)
    TriggerServerEvent("admin:Teleport", data.playerid, "bring")
end)

RegisterNUICallback("goto", function(data)
    TriggerServerEvent("admin:Teleport", data.playerid, "goto")
end)

RegisterNUICallback("kick", function(data)
    TriggerServerEvent("admin:Kick", data.playerid, data.inputData)
end)

RegisterNUICallback("spectate", function(data)
	playerID = data.playerid
	admin.Spectate(playerID, true)
	isSpectating = true
	SetDisplay(false)
end)

RegisterNUICallback("freeze", function(data)
	TriggerServerEvent("admin:Freeze", data.playerid)
end)

RegisterNUICallback("kill", function(data)
	TriggerServerEvent("admin:Slay", data.playerid)
end)

RegisterNUICallback("promote", function(data)
	TriggerServerEvent("admin:Promote", data.playerid, data.level)
end)

RegisterNUICallback("weapon", function(data)
	TriggerServerEvent("admin:GiveWeapon", data.playerid, data.weapon)
end)

RegisterNUICallback("noclip", function(data)
	admin.Noclip()
	SetDisplay(false)
	AdmNoclip()
end)


RegisterNUICallback("fix", function(data)
	local playerPed = GetPlayerPed(-1)
	if IsPedInAnyVehicle(playerPed, false) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		SetVehicleEngineHealth(vehicle, 1000)
		SetVehicleEngineOn( vehicle, true, true )
		SetVehicleFixed(vehicle)
		SetVehicleDirtLevel(vehicle, 0)
		ESX.ShowNotification("Your vehicle has been fixed.")
	else
		ESX.ShowNotification("You're not in a vehicle! There is no vehicle to fix!.")
	end
	SetDisplay(false)
end)


--new

RegisterNUICallback("god", function(data)
	TriggerServerEvent("admin:God", data.playerid)
	SetDisplay(false)
end)

RegisterNUICallback("godall",function(data)
	TriggerServerEvent("admin:Godall")
	SetDisplay(false)
end)

RegisterNUICallback("heal", function(data)
    TriggerServerEvent("admin:heal",data.playerid)
	SetDisplay(false)
end)


RegisterNUICallback("healall", function(data)
    TriggerServerEvent("admin:healall")
	SetDisplay(false)
end)

RegisterNUICallback("slayall", function(data)
    TriggerServerEvent("admin:Slays")
end)

RegisterNUICallback("bringall",function(data)
    TriggerServerEvent("admin:Teleportx")
end)

RegisterNUICallback("skin",function(data)
    ConfigCL["SetSkin"](data)
	SetDisplay(false)
end)

RegisterNUICallback("setskin",function(data)
    TriggerServerEvent("admin:skin", data.playerid)
	SetDisplay(false)
end)

local Updateblip = false
RegisterNUICallback("Updateblip", function()
    TriggerServerEvent("admin:addUpdateblip", Updateblip)
	if Updateblip == false then
		removeAllBlips()
	else
		Updateblip = true
	end
	SetDisplay(false)
end)

RegisterNUICallback("reviveallplayer", function(data)
	TriggerServerEvent("admin:revives")
	SetDisplay(false)
end)

--แต่งรถ
RegisterNUICallback("setvehicle", function(data)
	local playerPed = GetPlayerPed(-1)
	if IsPedInAnyVehicle(playerPed, false) then
		ConfigCL["SetVehicle"](data)
	else
		-- ESX.ShowNotification("You're not in a vehicle! There is no vehicle .")
	end
	SetDisplay(false)
end)

--แต่งรถเต็ม
RegisterNUICallback("Maxvehicle", function(vehicle)
	local playerPed = GetPlayerPed(-1)
	if IsPedInAnyVehicle(playerPed, false) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		TaskWarpPedIntoVehicle(ESX.PlayerData.ped, vehicle, -1)
		SetVehicleDirtLevel(vehicle, 0)
		SetVehicleFuelLevel(vehicle, 100.0)
		-- SetVehicleCustomSecondaryColour(vehicle, 55, 140, 191) -- ESX Blue
		SetEntityAsMissionEntity(vehicle, true, true) -- Persistant Vehicle

		SetVehicleExplodesOnHighExplosionDamage(vehicle, true)
		SetVehicleModKit(vehicle, 0)
		SetVehicleMod(vehicle, 11, 3, false) -- modEngine
		SetVehicleMod(vehicle, 12, 2, false) -- modBrakes
		SetVehicleMod(vehicle, 13, 2, false) -- modTransmission
		SetVehicleMod(vehicle, 15, 3, false) -- modSuspension
		SetVehicleMod(vehicle, 16, 4, false) -- modArmor
		ToggleVehicleMod(vehicle, 18, true) -- modTurbo
		SetVehicleTurboPressure(vehicle, 100.0)
		--SetVehicleNumberPlateText(vehicle, "ESX KISS")
		SetVehicleNumberPlateTextIndex(vehicle, 1)
		SetVehicleNitroEnabled(vehicle, true)

		for i=0, 3 do
			SetVehicleNeonLightEnabled(vehicle, i, true)
		end
		SetVehicleNeonLightsColour(vehicle, 55, 140, 191)  -- ESX Blue
		ESX.ShowNotification("Your vehicle has been fixed.")
	else
		ESX.ShowNotification("You're not in a vehicle! There is no vehicle to fix!.")
	end
	SetDisplay(false)
end)

--end
RegisterNUICallback("spawnvehicle", function(data)
	admin.SpawnVehicle(data.model)
	SetDisplay(false)
end)

RegisterNUICallback("setplayerped", function(data)
	admin.GetPlayePed(data.model)
	SetDisplay(false)
end)

RegisterNUICallback("announce", function(data)
	TriggerServerEvent("admin:Announcement", data.inputData)
end)

RegisterNUICallback("setJob", function(data)
	TriggerServerEvent("admin:setJob", data.playerid, data.job, data.rank)
end)

RegisterNUICallback("revive", function(data)
	TriggerServerEvent('admin:revive', data.playerid)
	SetDisplay(false)
end)

RegisterNUICallback("setTime", function(data)
	TriggerServerEvent("admin:Time", data.inputData)
end)

RegisterNUICallback("freezeTime", function(data)
	TriggerServerEvent("admin:freezeTime")
end)

RegisterNUICallback("changeWeather", function(data)
	TriggerServerEvent("admin:Weather", data.weather)
end)

RegisterNUICallback("freezeWeather", function(data)
	TriggerServerEvent("admin:freezeWeather")
end)

RegisterNUICallback("blackout", function(data)
	TriggerServerEvent("admin:Blackout")
end)

RegisterNUICallback("DeleteVehicles", function(data)
	DeleteVehicles()
end)

RegisterNUICallback("DeleteObjects", function(data)
	DeleteObjects()
end)

--- SetDisplay display
function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })

end




---Teleport To Waypoint
admin.TeleportToWaypoint = function()
	local  playerRank = _playerRank
    if Config.Perms[_playerRank] and Config.Perms[_playerRank].CanTpWp then
        local WaypointHandle = GetFirstBlipInfoId(8)
        if DoesBlipExist(WaypointHandle) then
            local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)
            for height = 1, 1000 do
                SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
                local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)
                if foundGround then
                    SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
                    break
                end
                Citizen.Wait(5)
            end
            ESX.ShowNotification("Teleported.")
        else
            ESX.ShowNotification("Please place your waypoint.")
        end
    else
        TriggerEvent('chat:addMessage', {args = {"admin", " ไม่ได้รับอนุญาติ"}})
    end
end

admin.GetPlayers = function()
    ESX.TriggerServerCallback("admin:getPlayers", function(players) 
        SendNUIMessage({type = "data", data = players})
    end)
	if _bans == nil then
		ESX.TriggerServerCallback("admin:getBanList", function(bans) 
			_bans = bans
		    SendNUIMessage({type = "bans", banlist = bans})
		end)
	else
		SendNUIMessage({type = "bans", banlist = _bans})
	end
end

admin.GetItemList = function()
	local weapons = ESX.GetWeaponList()
	if _jobs == nil then
		ESX.TriggerServerCallback("admin:getJobs", function(jobs) 
			_jobs = jobs
		    ESX.TriggerServerCallback("admin:getItemList", function(results) 
				_results = results
		        SendNUIMessage({type = "items", itemslist = results, weaponlist = weapons, vehiclelist = Config.Vehicles, joblist = jobs , pedlist = Config.PedModel, texturl = ConfigJs["JS"],})
		    end)
		end)
	else
		SendNUIMessage({type = "items", itemslist = _results, weaponlist = weapons, vehiclelist = Config.Vehicles, joblist = _jobs , pedlist = Config.PedModel, texturl = ConfigJs["JS"],})
	end
end

local nearBlips = {}
local longBlips = {}

RegisterNetEvent('admin:removeUser')
AddEventHandler('admin:removeUser', function(plyId)
	print('OUT:'..plyId)
    if nearBlips[plyId] then
        RemoveBlip(nearBlips[plyId].blip)
        nearBlips[plyId] = nil
    end
    if longBlips[plyId] then
        RemoveBlip(longBlips[plyId].blip)
        longBlips[plyId] = nil
    end
end)

RegisterNetEvent('admin:showblip')
AddEventHandler('admin:showblip', function(myId, data)
	for k, v in pairs(data) do
        local cId = GetPlayerFromServerId(v.playerId)
        if true then
            if myId ~= v.playerId then
                if cId ~= -1 then
                    if nearBlips[v.playerId] == nil then  -- switch/init blip from long to close proximity
                        if longBlips[v.playerId] then
                            RemoveBlip(longBlips[v.playerId].blip)
                            longBlips[v.playerId] = nil
                        end
                        nearBlips[v.playerId] = {}
                        nearBlips[v.playerId].blip = AddBlipForEntity(GetPlayerPed(cId))
                        setupBlip(nearBlips[v.playerId].blip, v)
                    end  
                else
                    if longBlips[v.playerId] == nil then -- switch/init blip from close to long proximity
                        if nearBlips[v.playerId] then
                            RemoveBlip(nearBlips[v.playerId].blip)
                            nearBlips[v.playerId] = nil
                        end
                        longBlips[v.playerId] = {}
                        longBlips[v.playerId].blip = AddBlipForCoord(v.coords)
                        setupBlip(longBlips[v.playerId].blip, v)
                    else
                        if longBlips[v.playerId] then
                            RemoveBlip(longBlips[v.playerId].blip)
                        end
                        longBlips[v.playerId].blip = AddBlipForCoord(v.coords)
                        setupBlip(longBlips[v.playerId].blip, v)
                    end

                   
                end
            end
        end
    end
end)

function setupBlip(blip, data)
	SetBlipSprite(blip, 1)
	SetBlipDisplay(blip, 2)
	SetBlipScale(blip,  1.0)
	SetBlipColour(blip, 0)
    SetBlipFlashes(blip, false)
    SetBlipCategory(blip, 7)
	BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(data.rpname)
	EndTextCommandSetBlipName(blip)
end


AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    removeAllBlips()
end)

function removeAllBlips()
    for k, v in pairs(nearBlips) do
        RemoveBlip(v.blip)
    end
    for k, v in pairs(longBlips) do
        RemoveBlip(v.blip)
    end
    nearBlips = {}
    longBlips = {}
end

function restoreBlip(blip) 
    SetBlipSprite(blip, 6)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.7)
    SetBlipColour(blip, 0)
    SetBlipShowCone(blip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(GetPlayerName(PlayerId()))
    EndTextCommandSetBlipName(blip)
    SetBlipCategory(blip, 1)
end

RegisterNetEvent('admin:Freeze')
AddEventHandler('admin:Freeze', function(targetPed)
	local player = PlayerId()
	local ped = PlayerPedId()

	frozen = not frozen

	if not frozen then
		if not IsEntityVisible(ped) then
			SetEntityVisible(ped, true)
		end

		if not IsPedInAnyVehicle(ped) then
			SetEntityCollision(ped, true)
		end

		FreezeEntityPosition(ped, false)
		SetPlayerInvincible(player, false)
	else
		SetEntityCollision(ped, false)
		FreezeEntityPosition(ped, true)
		SetPlayerInvincible(player, true)

		if not IsPedFatallyInjured(ped) then
			ClearPedTasksImmediately(ped)
		end
	end
end)


RegisterNetEvent('admin_:teleport')
AddEventHandler('admin_:teleport', function(temppos)
	SetEntityCoords(PlayerPedId(), temppos.x, temppos.y, temppos.z)
end)


RegisterNetEvent('admin:Slay')
AddEventHandler('admin:Slay', function(targetPed)
	SetEntityHealth(PlayerPedId(), 0)
end)

local hasGodmode = false
RegisterNetEvent('admin:God')
AddEventHandler('admin:God', function(targetPed)
	if not hasGodmode then
		hasGodmode = true
		SetEntityInvincible(PlayerPedId(), true)
		--exports['Jay_notify']:Alert("คุณอมตะแล้ว",3000,'success')
	else
		hasGodmode = false
		SetEntityInvincible(PlayerPedId(), false)
		--exports['Jay_notify']:Alert("คุณปกติแล้ว",3000,'error')
	end
end)

local Nstamina = false
RegisterNUICallback("stamina",function()
	SetDisplay(false)
    Nstamina = not Nstamina
	if Nstamina then
		Citizen.CreateThread(function()
			inStamina()
		end)
	end
end)

function inStamina ()
	while Nstamina do
		Citizen.Wait(1)
		RestorePlayerStamina(PlayerId(), 50.0)
	end
end

local Njumping = false
RegisterNUICallback("jumping",function()
    Njumping = not Njumping
	if Njumping then
		Citizen.CreateThread(function()
			inJumping()
		end)
	end
	SetDisplay(false)
end)

function inJumping()
	while Njumping do
		Citizen.Wait(1)
		SetSuperJumpThisFrame(PlayerId())
	end
end


RegisterNUICallback("Speed", function(data)
	TriggerServerEvent("admin:Speed",data.playerid)
	SetDisplay(false)
end)

local Nspeed = false
RegisterNetEvent('admin:Speed')
AddEventHandler('admin:Speed', function(targetPed)
	if not Nspeed  then
		Nspeed = true
		SetRunSprintMultiplierForPlayer(PlayerId(), 1.45)
	else
		Nspeed = false
		SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
	end
end)

RegisterNetEvent("admin:heal")
AddEventHandler("admin:heal",function(targetPed)
        TriggerEvent('esx_status:set', 'hunger', 1000000)
		TriggerEvent('esx_status:set', 'stress', 0)
        SetEntityHealth(PlayerPedId(),200)
end)

RegisterNetEvent("healall")
AddEventHandler("healall",function()
        TriggerEvent('esx_status:set', 'hunger', 1000000)
		TriggerEvent('esx_status:set', 'stress', 0)
        SetEntityHealth(GetPlayerPed(-1),200)
end)

RegisterNetEvent("reviveallplayer")
AddEventHandler("reviveallplayer", function()
	local ped = GetPlayerPed(-1)	
	if GetEntityHealth(ped) == 0 then
		TriggerEvent('esx_ambulancejob:revive')
	end
end)

--Effect
local dict2 = "proj_indep_firework" --หมวดหมู่
local particleName2 = "scr_indep_firework_grd_burst" -- effect
SetParticle = function()
	Citizen.CreateThread(function()
		RequestNamedPtfxAsset(dict2)
		while not HasNamedPtfxAssetLoaded(dict2) do
			Citizen.Wait(0)
		end
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped, true))
		local a = 0
		while a < 25 do
			UseParticleFxAssetNextCall(dict2)
			StartParticleFxNonLoopedAtCoord(particleName2, x, y, z, 1.50, 1.50, 1.50, 1.50, false, false, false)
			a = a + 1
			break
			Citizen.Wait(50)
		end
	end)
end



admin.Noclip = function()
    if Config.Perms[_playerRank] and Config.Perms[_playerRank].CanNoClip then
		noclip = not noclip
		
	    local msg = "disabled"
		if noclip then
			msg = "enabled"
			SetParticle()
		end
		TriggerEvent('chat:addMessage', {args = {"admin ", " Noclip has been " .. msg}})
		-- ESX.ShowNotification(" Noclip has been " .. msg)
		
		local heading = 0
		Citizen.CreateThread(function()
			local playerped = PlayerPedId()
			local entity = playerped
			local noclip_pos = GetEntityCoords(PlayerPedId(), false)
			if IsPedInAnyVehicle(playerped) then
				entity =  GetVehiclePedIsUsing(playerped)
			end
			
			SetEntityCollision(entity, not noclip, not noclip)
        	FreezeEntityPosition(entity, noclip)
        	SetVehicleRadioEnabled(entity, not noclip)
			if noclip then
				SetEntityAlpha(entity, 51, false)
			else
				local reval, z_ = GetGroundZFor_3dCoord(noclip_pos.x, noclip_pos.y, noclip_pos.z)
				SetEntityCoords(entity,noclip_pos.x, noclip_pos.y,z_+1)
				SetEntityVisible(PlayerPedId(), true, true)
        		SetLocalPlayerVisibleLocally(false)
				SetEveryoneIgnorePlayer(PlayerPedId(), false)
        		SetPoliceIgnorePlayer(PlayerPedId(), false)
			end
			local follow = true
			while noclip do
				Citizen.Wait(0)
				SetEntityVisible(PlayerPedId(), false, false)
        		SetLocalPlayerVisibleLocally(true)
				SetEveryoneIgnorePlayer(PlayerPedId(), true)
        		SetPoliceIgnorePlayer(PlayerPedId(), true)
				if follow then
					heading = getCamDirection()
				else
					if(IsControlPressed(1, 34))then
						heading = heading + 1.5
						if(heading > 360)then
							heading = 0
						end
						SetEntityHeading(entity, heading)
					end
					if(IsControlPressed(1, 9))then
						heading = heading - 1.5
						if(heading < 0)then
							heading = 360
						end
						SetEntityHeading(entity, heading)
					end
				end
				if(IsControlJustReleased(0, 74))then
					follow = not follow
					Wait(300)
				end
				if(IsControlPressed(1, 8))then
					noclip_pos = GetOffsetFromEntityInWorldCoords(entity, 0.0, -1.0*Config.Noclip[speed].speed, 0.0)
				end
				if(IsControlPressed(1, 32))then
					noclip_pos = GetOffsetFromEntityInWorldCoords(entity, 0.0, 1.0*Config.Noclip[speed].speed, 0.0)
				end
				if(IsControlPressed(1, 52))then
					noclip_pos = GetOffsetFromEntityInWorldCoords(entity, 0.0, 0.0, 1.0*Config.Noclip[speed].speed)
				end
				if(IsControlPressed(1, 48))then
					noclip_pos = GetOffsetFromEntityInWorldCoords(entity, 0.0, 0.0, -1.0*Config.Noclip[speed].speed)
				end
				
				SetEntityVelocity(entity, 0.0, 0.0, 0.0)
            	SetEntityRotation(entity, 0.0, 0.0, 0.0, 0, false)
            	SetEntityHeading(entity, heading)
            	SetEntityCoordsNoOffset(entity, noclip_pos.x, noclip_pos.y, noclip_pos.z, noclip, noclip, noclip)
			end
			ResetEntityAlpha(entity)
			SetParticle()
		end)
	else
        TriggerEvent('chat:addMessage', {args = {"admin ", "คุณไม่ได้รับอนุญาตสำหรับสิ่งนี้"}})
    end
end


admin.SpawnVehicle = function(model)
	local  playerRank = _playerRank
    if Config.Perms[_playerRank] and Config.Perms[_playerRank].CanSpawnVehicle then
		local coords = GetEntityCoords(PlayerPedId())
		local closestVehicle = ESX.Game.GetClosestVehicle(coords)
		ESX.Game.DeleteVehicle(closestVehicle)
		ESX.Game.SpawnVehicle(model, vector3(coords.x + 2.0, coords.y, coords.z), 0.0, function(vehicle) --get vehicle info
			if DoesEntityExist(vehicle) then
				TaskWarpPedIntoVehicle(PlayerPedId(),  vehicle, -1)
				ESX.ShowNotification("Spawned "..model)			
			end		
		end)
	else
        TriggerEvent('chat:addMessage', {args = {"admin", "คุณไม่ได้รับอนุญาตสำหรับสิ่งนี้"}})
    end
end

admin.GetPlayePed = function(model)
	local  playerRank = _playerRank

	print(model)

    if Config.Perms[_playerRank] and Config.Perms[_playerRank].CanPed then
		if model ~= 'blank' then
			SetParticle()
			local playermodel = GetHashKey(model)
			RequestModel(playermodel)
			while not HasModelLoaded(playermodel) do
			    Wait(100)
			end
			SetPlayerModel(PlayerId(), playermodel)
			SetModelAsNoLongerNeeded(playermodel)

		else
			SetParticle()
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				local isMale = skin.sex == 0

				TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
					ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
						TriggerEvent('skinchanger:loadSkin', skin)
						TriggerEvent('esx:restoreLoadout')
					end)
				end)
			end) 
		end



	end
end

admin.Spectate = function(target, bool)
	local  playerRank = _playerRank
    if Config.Perms[_playerRank] and Config.Perms[_playerRank].CanSpectate then
		if bool then
			temppos = GetEntityCoords(PlayerPedId(), false)
			ESX.TriggerServerCallback("admin:TeleportSpectate", function(callback)
				SetEntityInvincible(PlayerPedId(), true)
				SetEntityVisible(PlayerPedId(), false, false)
				FreezeEntityPosition(PlayerPedId(), true)
				Wait(1000)
				local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
				local name = GetPlayerName(GetPlayerFromServerId(target))
				if targetPed ~= PlayerPedId() then
					
					if (not IsScreenFadedOut() and not IsScreenFadingOut()) then
						DoScreenFadeOut(1000)
						while (not IsScreenFadedOut()) do
							Wait(0)
						end
						local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))
						RequestCollisionAtCoord(targetx,targety,targetz)
						NetworkSetInSpectatorMode(true, targetPed)
						ESX.ShowNotification("Spectating "..name)
						if(IsScreenFadedOut()) then
							DoScreenFadeIn(1000)
						end
					end
					
				else
					ESX.ShowNotification("You can not spectate yourself.")
				end
			end,target)
			Citizen.CreateThread(function()
				while isSpectating do
					Citizen.Wait(0)
					if IsControlJustPressed(0, 322)  then
						admin.Spectate(playerID, false)
						isSpectating = false
						playerID = nil
					end
				end
			end)
		else
			local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
			local name = GetPlayerName(GetPlayerFromServerId(target))
			if(not IsScreenFadedOut() and not IsScreenFadingOut()) then
				DoScreenFadeOut(1000)
				while (not IsScreenFadedOut()) do
					Wait(0)
				end
				local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))
				RequestCollisionAtCoord(targetx,targety,targetz)
				NetworkSetInSpectatorMode(false, targetPed)
				ESX.ShowNotification("Stopped spectating "..name)
				if(IsScreenFadedOut()) then
					DoScreenFadeIn(1000)
				end
			end
			if temppos ~= nil then
				SetEntityCoords(PlayerPedId(),temppos)
				SetEntityInvincible(PlayerPedId(), false)
				SetEntityVisible(PlayerPedId(), true, true)
				FreezeEntityPosition(PlayerPedId(), false)
			end
		end
	else
        TriggerEvent('chat:addMessage', {args = {"admin ", "คุณไม่ได้รับอนุญาตสำหรับสิ่งนี้"}})
    end
end


function regiskey_()
	RegisterKeyMapping("Noclip", "Admin Menu[No clip]", "keyboard", 'CAPITAL')
end

RegisterKeyMapping("admin", " Admin Menu", "keyboard", Config['ระบบการตั้งค่า'].KeyOpen)

RegisterCommand("admin", function(source,args)
	if _playerRank == nil then
		ESX.TriggerServerCallback("esx_marker:fetchUserRank", function(playerRank)
			_playerRank = playerRank
    	    if Config.Perms[_playerRank] then
				RegisterKeyMapping("Noclip", " Admin Menu", "keyboard", Config['ระบบการตั้งค่า'].KeyOpen)
    	    	local coords = round(GetEntityCoords(PlayerPedId()), 2)
    	    	SendNUIMessage({type = "coords", coordData = coords})
    			admin.GetPlayers()
    			admin.GetItemList()
    			SetDisplay(true)
    		else
    			TriggerEvent('chat:addMessage', {args = {"admin", " You do not have permissions for this"}})
    		end
    	end)
	else
		if Config.Perms[_playerRank] then
			local coords = round(GetEntityCoords(PlayerPedId()), 2)
			SendNUIMessage({type = "coords", coordData = coords})
			admin.GetPlayers()
			admin.GetItemList()
			SetDisplay(true)
		else
			TriggerEvent('chat:addMessage', {args = {"admin", " You do not have permissions for this"}})
		end
	end
end)

RegisterCommand("admin", function(source,args)
	if _playerRank == nil then
		ESX.TriggerServerCallback("esx_marker:fetchUserRank", function(playerRank)
			_playerRank = playerRank
    	    if Config.Perms[_playerRank] then
				regiskey_()
    	    	local coords = round(GetEntityCoords(PlayerPedId()), 2)
    	    	SendNUIMessage({type = "coords", coordData = coords})
    			admin.GetPlayers()
    			admin.GetItemList()
    			SetDisplay(true)
    		else
    			TriggerEvent('chat:addMessage', {args = {"admin", " You do not have permissions for this"}})
    		end
    	end)
	else
		if Config.Perms[_playerRank] then
			local coords = round(GetEntityCoords(PlayerPedId()), 2)
			SendNUIMessage({type = "coords", coordData = coords})
			admin.GetPlayers()
			admin.GetItemList()
			SetDisplay(true)
		else
			TriggerEvent('chat:addMessage', {args = {"admin", " You do not have permissions for this"}})
		end
	end
end)

RegisterCommand("Noclip", function(source,args)
	admin.Noclip()
	AdmNoclip()
end)

function AdmNoclip()
	Citizen.CreateThread(function()
		while noclip do
			Citizen.Wait(0)
			if IsControlJustPressed(0, 322)  then
				admin.Noclip()
			end
			if IsControlJustPressed(0, 21) then
				speed = speed + 1
				if #Config.Noclip < speed then
					speed = 1
				end
				TriggerEvent('chat:addMessage', {args = {"Admin ", " Noclip Speed: " .. Config.Noclip[speed].text}})
			end
		end
	end)
end



function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

--Create tag
function OnRequestGamerTags()
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        if (Ksuck.GamerTags[ped] == nil) or (Ksuck.GamerTags[ped].ped == nil) or not (IsMpGamerTagActive(Ksuck.GamerTags[ped].tags)) then
            
            --set สี แต่ยังไม่ได้สี
            local colors = {
                ["_dev"] = 'DEV',
                ["superadmin"] = 'FONDATEUR',
                ["admin"] = 'ADMIN',
                ["mod"] = 'MODO',
                ["user"] = 'USER',
            }
            
            local formatted;
            local group = 0;
            local permission = 0;
            local fetching = RetrievePlayersDataByID(GetPlayerServerId(player));
            print(fetching.group)
            if (fetching) then
                -- ยศ [%s] ID [%d] ชื่อ %s อาชีพ (%s)                                                                                    fetching.jobs
                formatted = string.format('[%d] %s ',GetPlayerServerId(player), GetPlayerName(player))
            else
                formatted = string.format('[%d] %s ',GetPlayerServerId(player), GetPlayerName(player))
            end
            if (fetching) then
                group = fetching.group
                permission = fetching.permission
            end

            Ksuck.GamerTags[ped] = {
                player = player,
                ped = ped,
                group = group,
                permission = permission,
                tags = CreateFakeMpGamerTag(ped, formatted)
            };
        end

    end
end

function RetrievePlayersDataByID(source)
    local player = {};
    for i, v in pairs(Ksuck.Players) do
        if (v.source == source) then
            player = v;
        end
    end
    return player;
end

local player = {};
Ksuck = {} or {};
Ksuck.GamerTags = {} or {};
Ksuck.Players = {} or {}; --- Players lists

local head_ = false;
RegisterNUICallback("name_on", function()
    if not head_  then
        head_ = true
        Citizen.CreateThread(function()
            open_name()
        end)
    else
        head_ = false
        for i, v in pairs(Ksuck.GamerTags) do
            RemoveMpGamerTag(v.tags)
        end
    end
    SetDisplay(false)
end)

function open_name()
    while head_ do
        Citizen.Wait(1)
        OnRequestGamerTags()
    end
end

Citizen.CreateThread(function()
    while true do
        if head_ then    
            for i, v in pairs(Ksuck.GamerTags) do
                local target = GetEntityCoords(v.ped, false);

                if #(target - GetEntityCoords(PlayerPedId())) < 120 then
                    SetMpGamerTagVisibility(v.tags, 0, true)
                    SetMpGamerTagVisibility(v.tags, 2, true)
                    SetMpGamerTagHealthBarColor(v.tags,27)
                    
                    SetMpGamerTagVisibility(v.tags, 4, NetworkIsPlayerTalking(v.player))
                    SetMpGamerTagAlpha(v.tags, 2, 255)
                    SetMpGamerTagAlpha(v.tags, 4, 255)
                    --ได้สีตรงนี้
                    local colors = {
                        ["_dev"] = 21,
                        ["superadmin"] = 12,
                        ["admin"] = 27,
                        ["modo"] = 9,
                    }
                    SetMpGamerTagColour(v.tags, 0, colors[v.group] or 0)
                else
                    RemoveMpGamerTag(v.tags)
                    Ksuck.GamerTags[i] = nil;
                end
            end
        end
        Citizen.Wait(1)
    end
end)

function getCamDirection()
	local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(GetPlayerPed(-1))
	return heading
	--local pitch = GetGameplayCamRelativePitch()
	--local x = -math.sin(heading*math.pi/180.0)
	--local y = math.cos(heading*math.pi/180.0)
	--local z = math.sin(pitch*math.pi/180.0)
	--local len = math.sqrt(x*x+y*y+z*z)
	--if len ~= 0 then
	--	x = x/len
	--	y = y/len
	--	z = z/len
	--end
	--return x,y,z
end