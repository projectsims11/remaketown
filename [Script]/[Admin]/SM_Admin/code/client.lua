local checkPermission = false
local jobList = {}
local playerLists = {}
local dataPlayers = {}

ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent(Config["EventRoute"]["getSharedObject"], function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)

Citizen.CreateThread(function()
	Wait(1000)
	while true do
		if NetworkIsPlayerActive(PlayerId()) then
			TriggerServerEvent("SM_Admin:playerLoaded")
			break 
		end
		Wait(10)
	end
end)

RegisterKeyMapping("smadmin", "Admin Menu", "keyboard", "HOME")
RegisterCommand("smadmin", function()
	if not checkPermission then
		TriggerServerEvent("SM_Admin:getData:Group")
	else
		if checkPermission then
			ShowMenuUI(true)
		else
			TriggerEvent("chat:addMessage", { args = { "SM_Admin", " You do not have permissions for this" }})
		end
	end
end)

RegisterNetEvent("SM_Admin:loadData:Group")
AddEventHandler("SM_Admin:loadData:Group", function(check)
	checkPermission = check
	if checkPermission then
		ShowMenuUI(true)
		RegisterCommand("smnoclip", function()
			Noclip()
		end)
		RegisterKeyMapping("smnoclip", "Admin Menu[No clip]", "keyboard", 'CAPITAL')
	end
end)

RegisterNetEvent("SM_Admin:loadData:List")
AddEventHandler("SM_Admin:loadData:List", function(jobList)
	jobList = jobList
	local playerPed = { id = GetPlayerServerId(PlayerId()), name = GetPlayerName(PlayerId()) }
	SendNUIMessage({ 
		type = "Settings", 
		itemslist = GetItemList(),
		weaponlist = ESX.GetWeaponList(),
		vehiclelist = GetVehicleList(),
		joblist = jobList,
		url_images = Config["EventRoute"]["InventoryImages"],
		playerPed = playerPed
	})
end)

RegisterNetEvent("SM_Admin:loadData:Players")
AddEventHandler("SM_Admin:loadData:Players", function(players)
	playerLists = players
	SendNUIMessage({ type = "playerlist", list = playerLists })
end)

RegisterNetEvent("SM_Admin:loadData:User")
AddEventHandler("SM_Admin:loadData:User", function(data)
	SendNUIMessage({
		type = "dataplayer",
		playerid = data.playerid,
		identifier = data.identifier,
		rpname = data.rpname,
		cash = data.cash,
		bank = data.bank,
		job = data.job,
		steamid = data.steamid
	})
end)

RegisterNetEvent("SM_Admin:loadData:BanLists")
AddEventHandler("SM_Admin:loadData:BanLists", function(data)
	SendNUIMessage({ type = "banLists", banLists = data })
end)

RegisterNetEvent("SM_Admin:Heal:ToCL")
AddEventHandler("SM_Admin:Heal:ToCL", function(type)
	Config["Heal"](type)
end)

RegisterNetEvent("SM_Admin:Revive:ToCL")
AddEventHandler("SM_Admin:Revive:ToCL", function(type)
	Config["Revive"](type)
end)

RegisterNetEvent("SM_Admin:Teleport:ToCL")
AddEventHandler("SM_Admin:Teleport:ToCL", function(pos)
	SetEntityCoords(PlayerPedId(), pos.x, pos.y, pos.z)
end)

RegisterNetEvent("SM_Admin:Freeze:ToCL")
AddEventHandler("SM_Admin:Freeze:ToCL", function()
	frozen = not frozen
	TaskLeaveAnyVehicle(PlayerPedId(), 0, 16)
	FreezeEntityPosition(PlayerPedId(), frozen)
end)

RegisterNetEvent("SM_Admin:Slay:ToCL")
AddEventHandler("SM_Admin:Slay:ToCL", function()
	SetEntityHealth(PlayerPedId(), 0)
end)

RegisterNetEvent("SM_Admin:God:ToCL")
AddEventHandler("SM_Admin:God:ToCL", function()
	if not hasGodmode then
		hasGodmode = true
		SetEntityInvincible(PlayerPedId(), true)
		SetPlayerInvincible(PlayerId(), true)
		SetEntityOnlyDamagedByPlayer(GetPlayerPed(-1), false)
		SetEntityCanBeDamaged(GetPlayerPed(-1), false)
		SetEntityProofs(GetPlayerPed(-1), true, true, true, true, true, true, true, true)
	else
		SetEntityInvincible(PlayerPedId(), false)
		SetEntityInvincible(PlayerPedId(), false)
		SetPlayerInvincible(PlayerId(), false)
		SetEntityOnlyDamagedByPlayer(GetPlayerPed(-1), true)
		SetEntityCanBeDamaged(GetPlayerPed(-1), true)
		SetEntityProofs(GetPlayerPed(-1), false, false, false, false, false, false, false, false)
		hasGodmode = false
	end
end)

RegisterNetEvent("SM_Admin:tpwp:ToCL")
AddEventHandler("SM_Admin:tpwp:ToCL", function()
	Config["TeleportToWaypoint"]()
end)

RegisterNetEvent("zack:ShowAnnouncement")
AddEventHandler("zack:ShowAnnouncement", function(msg)
    if not IsPauseMenuActive() then
        if msg then
            msg = msg:gsub("~r~", "<span style=color:red;>")
            msg = msg:gsub("~b~", "<span style='color:rgb(0, 213, 255);'>")
            msg = msg:gsub("~g~", "<span style='color:rgb(0, 255, 68);'>")
            msg = msg:gsub("~y~", "<span style=color:yellow;>")
            msg = msg:gsub("~p~", "<span style='color:rgb(220, 0, 255);'>")
            msg = msg:gsub("~f~", "<span style=color:grey;>")
            msg = msg:gsub("~m~", "<span style=color:darkgrey;>")
            msg = msg:gsub("~u~", "<span style=color:black;>")
            msg = msg:gsub("~o~", "<span style=color:gold;>")
            msg = msg:gsub("~s~", "</span>")
            msg = msg:gsub("~w~", "</span>")
            msg = msg:gsub("~b~", "<b>")
            msg = msg:gsub("~n~", "<br>")
            msg = msg:gsub("\n", "<br>")
            msg = "<span style=color:currentColor>" .. msg .. "</span>"

            SendNUIMessage({ 
                type = "ShowAnm",
                message = msg,
            })
        end
    end
end)



RegisterNUICallback("copyCoords", function(_, cb)
    local pos = GetEntityCoords(PlayerPedId())
    local heading = GetEntityHeading(PlayerPedId())
    local stringCoords = ("coords = { x = %.2f, y = %.2f, z = %.2f }, heading = %.2f"):format(pos.x, pos.y, pos.z, heading)
	ShowNotification("Copy Coords : "..stringCoords)
    cb({ coords = stringCoords })
end)

RegisterNUICallback("announce", function(data)
	--TriggerServerEvent("SM_Admin:sendData:Announce", data.text)
	TriggerServerEvent("zack:announceHandler", data.text, "all") -- ให้แอดมินส่งประกาศไปยังทุกคน
end)

RegisterNUICallback("setjob", function(data)
	TriggerServerEvent("SM_Admin:setJob:User", data.playerid, data.job, data.grade)
end)

RegisterNUICallback("reload-online", function(_, cb)
	TriggerServerEvent("SM_Admin:getData:Players")
	if not playerLists then return end
	cb({ list = playerLists })
end)

RegisterNUICallback("user", function(data)
	TriggerServerEvent("SM_Admin:getData:User", data.playerid)
end)

RegisterNUICallback("spawnVehicle", function(data)
	if Config["spawnVehicle"](data.model) then
		ShowNotification("Spawned "..GetLabelText(data.model))
	end
end)

RegisterNUICallback("customsVehicle", function()
	if Config["customsVehicle"]() then
		ShowMenuUI(false)
	else
		ShowNotification("You're not in a vehicle! There is no vehicle .")
	end
end)

RegisterNUICallback("repairVehicle", function()

	if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
		local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
		SetVehicleEngineHealth(vehicle, 1000)
		SetVehicleEngineOn(vehicle, true, true)
		SetVehicleFixed(vehicle)
		SetVehicleDirtLevel(vehicle, 0)
		return true
	end

	if Config["repairVehicle"]() then
		ShowNotification("Your vehicle has been fixed.")
	else
		ShowNotification("You're not in a vehicle! There is no vehicle to fix!.")
	end
end)

RegisterNUICallback("delVehicle", function()

	local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
		return coroutine.wrap(function()
		  local iter, id = initFunc()
		  if not id or id == 0 then
			disposeFunc(iter)
			return
		  end
		  
		  local enum = {handle = iter, destructor = disposeFunc}
		  setmetatable(enum, entityEnumerator)
		  
		  local next = true
		  repeat
			coroutine.yield(id)
			next, id = moveFunc(iter)
		  until not next
		  
		  enum.destructor, enum.handle = nil, nil
		  disposeFunc(iter)
		end)
	end

	local function EnumerateVehicles()
		return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
	end

	local function DeleteVehicles()
		for vehicle in EnumerateVehicles() do
			if (not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1))) then 
				SetVehicleHasBeenOwnedByPlayer(vehicle, false) 
				SetEntityAsMissionEntity(vehicle, false, false) 
				DeleteVehicle(vehicle)
				if (DoesEntityExist(vehicle)) then 
					DeleteVehicle(vehicle) 
					
				end
				deleted = true
			end
		end
		return deleted
	end

	local success = DeleteVehicles()
	if success then
		ShowNotification("Deleted the vehicle successfully.")
	else
		ShowNotification("No vehicle found to delete.")
	end

	if type(Config["doAfterdeleteVehicle"]) == "function" then
		Config["doAfterdeleteVehicle"]()
	end

	

	--if Config["deleteVehicle"]() then
	--	ShowNotification("Deleted the vehicle successfully.")
	--end
end)

RegisterNUICallback("delVehicle50M", function()
	if Config["deleteVehicle50M"]() then
		ShowNotification("Deleted the vehicle 50 range successfully.")
	end
end)

RegisterNUICallback("nametags", function()
	ShowName()
end)

RegisterNUICallback("blipPlayers", function()
	ShowBlips()
end)

RegisterNUICallback("blackout", function()
	TriggerServerEvent("SM_Admin:Blackout")
end)

RegisterNUICallback("freezeTime", function()
	TriggerServerEvent("SM_Admin:freezeTime")
end)

RegisterNUICallback("tpwp", function()
	if Config["TeleportToWaypoint"]() then
		ShowNotification("Teleported.")
	else
		ShowNotification("Please place your waypoint.")
	end
end)

RegisterNUICallback("setTime", function(data)
	TriggerServerEvent("SM_Admin:Time", data.time)
	ShowNotification("Set the time to "..data.time.." .")
end)

RegisterNUICallback("setWeather", function(data)
	TriggerServerEvent("SM_Admin:Weather", data.weather)
	ShowNotification("Set the weather to "..data.weather.." .")
end)

RegisterNUICallback("heal", function(data)
	TriggerServerEvent("SM_Admin:Heal:ToSV", data.type, data.playerid)
	ShowNotification("healing successfully .")
end)

RegisterNUICallback("revive", function(data)
	TriggerServerEvent("SM_Admin:Revive:ToSV", data.type, data.playerid)
	ShowNotification("revive successfully .")
end)

RegisterNUICallback("godme", function(data)
	TriggerEvent("SM_Admin:God:ToCL")
	ShowNotification("You enabled/disabled Godmode for "..GetPlayerName(GetPlayerFromServerId(data.playerid)))
end)

RegisterNUICallback("noclip", function()
	Noclip()
end)

RegisterNUICallback("giveItem", function(data)
	if data.amount == "" then data.amount = 1 end
	TriggerServerEvent("SM_Admin:AddItem", data.playerid, data.name, tonumber(data.amount))
	print("[giveItem] id: "..data.playerid.." name: "..data.name.." amount: "..data.amount)
	ShowNotification("[giveItem] id: "..data.playerid.." name: "..data.name.." amount: "..data.amount)
end)

RegisterNUICallback("giveWeapon", function(data)
	TriggerServerEvent("SM_Admin:GiveWeapon", data.playerid, data.name)
	print("[giveWeapon] id: "..data.playerid.." name: "..data.name)
	ShowNotification("[giveWeapon] id: "..data.playerid.." name: "..data.name)
end)

RegisterNUICallback("giveMoney", function(data)
	TriggerServerEvent("SM_Admin:AddMoney", data.playerid, data.type, tonumber(data.amount))
	print("[giveMoney] id: "..data.playerid.." name: "..data.type.." amount: "..data.amount)
	ShowNotification("[giveMoney] id: "..data.playerid.." name: "..data.type.." amount: "..data.amount)
end)

RegisterNUICallback("healall", function()
	TriggerServerEvent("SM_Admin:Heal:ToSV", "all")
	ShowNotification("healing all successfully .")
end)

RegisterNUICallback("reviveall", function()
	TriggerServerEvent("SM_Admin:Revive:ToSV", "all")
	ShowNotification("revive all successfully .")
end)

RegisterNUICallback("spectate", function(data)
	print("spectate", data.playerid)
end)

RegisterNUICallback("bring", function(data)
	TriggerServerEvent("SM_Admin:Teleport:ToSV", data.playerid, "bring")
	ShowNotification("You brought a player")
end)

RegisterNUICallback("goto", function(data)
	TriggerServerEvent("SM_Admin:Teleport:ToSV", data.playerid, "goto")
	ShowNotification("You teleported to a player")
end)

RegisterNUICallback("openinventory", function(data)
	if Config["openInventory"](data.playerid) then
		ShowMenuUI(false)
	end
end)

RegisterNUICallback("freeze", function(data)
	TriggerServerEvent("SM_Admin:Freeze:ToSV", data.playerid)
	ShowNotification("You Froze/Unfroze "..GetPlayerName(GetPlayerFromServerId(data.playerid)))
end)

RegisterNUICallback("kill", function(data)
	TriggerServerEvent("SM_Admin:Slay:ToSV", data.playerid)
	ShowNotification("You slayed "..GetPlayerName(GetPlayerFromServerId(data.playerid)))
end)

RegisterNUICallback("god", function(data)
	TriggerServerEvent("SM_Admin:God:ToSV", data.playerid)
	ShowNotification("You enabled/disabled Godmode for "..GetPlayerName(GetPlayerFromServerId(data.playerid)))
end)

RegisterNUICallback("kick", function(data)
	TriggerServerEvent("SM_Admin:Kick", data.playerid, data.text)
	ShowNotification("Kicked Player: "..GetPlayerName(GetPlayerFromServerId(data.playerid)).." Reason: "..data.text)
end)

RegisterNUICallback("getbanlists", function()
	TriggerServerEvent("SM_Admin:getData:BanLists")
end)

RegisterNUICallback("ban", function(data)
	TriggerServerEvent("SM_Admin:Ban", data.playerid, data.text)
	ShowNotification("banned Player: "..GetPlayerName(GetPlayerFromServerId(data.playerid)))
end)

RegisterNUICallback("unban", function(data)
	TriggerServerEvent("SM_Admin:Unban", data.identifier)
	ShowNotification("unbanned Player: "..data.name)
end)

RegisterNUICallback("NUIFocusOff", function()
	ShowMenuUI(false)
end)

RegisterCommand("nametags", function(source, args)
	ShowName()
end)

--- NameTags ---
local playerGamerTags = {}
local fivemGamerTagCompsEnum = {
    GamerName = 0,
    CrewTag = 1,
    HealthArmour = 2,
    BigText = 3,
    AudioIcon = 4,
    UsingMenu = 5,
    PassiveMode = 6,
    WantedStars = 7,
    Driver = 8,
    CoDriver = 9,
    Tagged = 12,
    GamerNameNearby = 13,
    Arrow = 14,
    Packages = 15,
    InvIfPedIsFollowing = 16,
    RankText = 17,
    Typing = 18
}

ShowName = function()
	if checkPermission then
		toggle_nametags = not toggle_nametags

		local msg = "~r~disabled"
		if toggle_nametags then msg = "~g~enabled" end
		ShowNotification("NameTags " .. msg.." ~s~.")

		Citizen.CreateThread(function()
			while toggle_nametags do
				local curCoords = GetEntityCoords(PlayerPedId())
				for _,pid in ipairs(GetActivePlayers()) do
					local targetPed = GetPlayerPed(pid)
					if not playerGamerTags[pid] or not IsMpGamerTagActive(playerGamerTags[pid].gamerTag) then
						local playerName = string.sub(GetPlayerName(pid) or "unknown", 1, 75)
						local playerStr = '[' .. GetPlayerServerId(pid) .. ']' .. ' ' .. playerName
						playerGamerTags[pid] = {
							gamerTag = CreateFakeMpGamerTag(targetPed, playerStr, false, false, 0),
							ped = targetPed
						}
					end
					local targetTag = playerGamerTags[pid].gamerTag
					local targetPedCoords = GetEntityCoords(targetPed)
					if #(targetPedCoords - curCoords) <= 50 then
						setGamerTag(targetTag, pid)
					else
						clearGamerTag(targetTag)
					end
				end
				Citizen.Wait(1000)
			end
			cleanAllGamerTags()
		end)
	else
        TriggerEvent("chat:addMessage", { args = { "SM_Admin ", " You do not have permission for this." }})
	end
end

setGamerTag = function(targetTag, pid)
	-- Setup name
	SetMpGamerTagVisibility(targetTag, fivemGamerTagCompsEnum.GamerName, 1)

	-- Setup Health
	SetMpGamerTagHealthBarColor(targetTag, 129)
	SetMpGamerTagAlpha(targetTag, fivemGamerTagCompsEnum.HealthArmour, 255)
	SetMpGamerTagVisibility(targetTag, fivemGamerTagCompsEnum.HealthArmour, 1)

	-- Setup AudioIcon
	SetMpGamerTagAlpha(targetTag, fivemGamerTagCompsEnum.AudioIcon, 255)
	if NetworkIsPlayerTalking(pid) then
		SetMpGamerTagVisibility(targetTag, fivemGamerTagCompsEnum.AudioIcon, true)
		SetMpGamerTagColour(targetTag, fivemGamerTagCompsEnum.AudioIcon, 12) --HUD_COLOUR_YELLOW
		SetMpGamerTagColour(targetTag, fivemGamerTagCompsEnum.GamerName, 12) --HUD_COLOUR_YELLOW
	else
		SetMpGamerTagVisibility(targetTag, fivemGamerTagCompsEnum.AudioIcon, false)
		SetMpGamerTagColour(targetTag, fivemGamerTagCompsEnum.AudioIcon, 0)
		SetMpGamerTagColour(targetTag, fivemGamerTagCompsEnum.GamerName, 0)
	end
end

clearGamerTag = function(targetTag)
    SetMpGamerTagVisibility(targetTag, fivemGamerTagCompsEnum.GamerName, 0)  -- Cleanup name
    SetMpGamerTagVisibility(targetTag, fivemGamerTagCompsEnum.HealthArmour, 0)  -- Cleanup Health
    SetMpGamerTagVisibility(targetTag, fivemGamerTagCompsEnum.AudioIcon, 0)  -- Cleanup AudioIcon
end

cleanAllGamerTags = function()
    for _,v in pairs(playerGamerTags) do
        if IsMpGamerTagActive(v.gamerTag) then
            RemoveMpGamerTag(v.gamerTag)
        end
    end
    playerGamerTags = {}
end
--- NameTags ---

--- Noclip ---
local noclip, speed = false, 1

Noclip = function()
    if checkPermission then
		noclip = not noclip
		
		Noclip_Speed()
	    local msg = "~r~disabled"
		if noclip then msg = "~g~enabled" end
		ShowNotification(" Noclip has been " .. msg.." ~s~.")
		
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
		end)
	else
        TriggerEvent("chat:addMessage", { args = { "SM_Admin ", " You do not have permission for this." }})
    end
end

Noclip_Speed = function()
	Citizen.CreateThread(function()
		while noclip do
			Citizen.Wait(0)
			if noclip then
				if IsControlJustPressed(0, 21) then
					speed = speed + 1
					if #Config.Noclip < speed then
						speed = 1
					end
					TriggerEvent("chat:addMessage", { args = { "SM_Admin ", " Noclip Speed: " .. Config.Noclip[speed].text }})
				end
			end
		end
	end)
end

getCamDirection = function()
	local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(GetPlayerPed(-1))
	return heading
end

round = function(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end
--- Noclip ---

--- PlayerBlips ---
local playerBlips = {}

ShowBlips = function()
	if checkPermission then
		toggle_blip = not toggle_blip

		local msg = "~r~disabled"
		if toggle_blip then msg = "~g~enabled" end
		ShowNotification("Player Blips " .. msg.." ~s~.")

		Citizen.CreateThread(function()
			while toggle_blip do
				for _,pid in ipairs(GetActivePlayers()) do
					if NetworkIsPlayerActive(pid) then
						local targetPed = GetPlayerPed(pid)
						RemoveBlip(playerBlips[pid])
						local blip = AddBlipForEntity(targetPed)
						SetBlipNameToPlayerName(blip, pid)
						SetBlipColour(blip, 0)
						SetBlipCategory(blip, 0)
						SetBlipScale(blip, 0.85)
						playerBlips[pid] = blip
					end
				end
				Citizen.Wait(1000)
			end
			cleanAllPlayerBlips()
		end)
	else
        TriggerEvent("chat:addMessage", { args = { "SM_Admin ", " You do not have permission for this." }})
	end
end

cleanAllPlayerBlips = function()
    for k,v in pairs(playerBlips) do
		RemoveBlip(playerBlips[k])
    end
    playerBlips = {}
end
--- PlayerBlips ---

ShowMenuUI = function(key)
	SetNuiFocus(key, key)
	SendNUIMessage({ type = "Menu", display = key })
end

GetItemList = function()
	local inventory = ESX.GetPlayerData().inventory
	local itemList = {}
	for k,v in pairs(inventory) do
		itemList[k] = { name = v.name, label = v.label }
	end
	return itemList
end

GetVehicleList = function()
	--[[local vehicleList = {}
	for k,v in pairs(GetAllVehicleModels()) do
		local label = GetLabelText(v)
		if label == "NULL" then label = v end
		vehicleList[k] = { model = v, label = label }
	end
	return vehicleList]]

	local vehicleList = {} -- zack
    for _, v in pairs(Config["vehiclesList"]) do
        table.insert(vehicleList, { model = v.model, label = v.label })
    end
    return vehicleList
end

ShowNotification = function(msg)
	if not IsPauseMenuActive() then
		if msg then
			msg = msg:gsub("~r~", "<span style=color:red;>")
			msg = msg:gsub("~b~", "<span style='color:rgb(0, 213, 255);'>")
			msg = msg:gsub("~g~", "<span style='color:rgb(0, 255, 68);'>")
			msg = msg:gsub("~y~", "<span style=color:yellow;>")
			msg = msg:gsub("~p~", "<span style='color:rgb(220, 0, 255);'>")
			msg = msg:gsub("~f~", "<span style=color:grey;>")
			msg = msg:gsub("~m~", "<span style=color:darkgrey;>")
			msg = msg:gsub("~u~", "<span style=color:black;>")
			msg = msg:gsub("~o~", "<span style=color:gold;>")
			msg = msg:gsub("~s~", "</span>")
			msg = msg:gsub("~w~", "</span>")
			msg = msg:gsub("~b~", "<b>")
			msg = msg:gsub("~n~", "<br>")
			msg = msg:gsub("\n", "<br>")
			msg = "<span style=color:currentColor>" .. msg .. "</span>"

            SendNUIMessage({ 
				type = "ShowHelp",
                message = msg,
            })
		end
	end
end

ShowAnnoucement = function(msg)
	if not IsPauseMenuActive() then
		if msg then
			msg = msg:gsub("~r~", "<span style=color:red;>")
			msg = msg:gsub("~b~", "<span style='color:rgb(0, 213, 255);'>")
			msg = msg:gsub("~g~", "<span style='color:rgb(0, 255, 68);'>")
			msg = msg:gsub("~y~", "<span style=color:yellow;>")
			msg = msg:gsub("~p~", "<span style='color:rgb(220, 0, 255);'>")
			msg = msg:gsub("~f~", "<span style=color:grey;>")
			msg = msg:gsub("~m~", "<span style=color:darkgrey;>")
			msg = msg:gsub("~u~", "<span style=color:black;>")
			msg = msg:gsub("~o~", "<span style=color:gold;>")
			msg = msg:gsub("~s~", "</span>")
			msg = msg:gsub("~w~", "</span>")
			msg = msg:gsub("~b~", "<b>")
			msg = msg:gsub("~n~", "<br>")
			msg = msg:gsub("\n", "<br>")
			msg = "<span style=color:currentColor>" .. msg .. "</span>"

            SendNUIMessage({ 
				type = "ShowAnm",
                message = msg,
            })
		end
	end
end


AddEventHandler("onResourceStop", function(resource)
	if resource == "SM_Admin" then
		cleanAllGamerTags()
	end
end)
