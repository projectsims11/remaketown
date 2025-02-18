Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local FirstSpawn, PlayerLoaded = true, false
local hasAlreadyJoined = false
local blipscops = {}
local PlayerData = {}
local talk = false

IsDead = false
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	PlayerLoaded = true
	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	PlayerLoaded = true
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

AddEventHandler('playerSpawned', function()
	IsDead = false
	
	if FirstSpawn then
		exports.spawnmanager:setAutoSpawn(false) -- disable respawn
		FirstSpawn = false

		NetworkSetFriendlyFireOption(true)

		ESX.TriggerServerCallback('esx_ambulancejob:getDeathStatus', function(isDead)
			if isDead and Config.AntiCombatLog then
				while not PlayerLoaded do
					Citizen.Wait(1000)
				end
				Wait(3000)
				TriggerEvent("pNotify:SendNotification", {
					text = "<span style='color:white;'> ".._U("combatlog_message").." </span> </strong>",
					type = "info",
					timeout = 3000,
					layout = "centerRight",
					queue = "global"
				})
				Citizen.Wait(1000)
				SetEntityHealth(PlayerPedId(), 0)
			end
		end)
	end
	Wait(100)
	FreezeEntityPosition(PlayerPedId(), false)
end)

-- Create blips
Citizen.CreateThread(function()
	for k,v in pairs(Config.Hospitals) do
		local blip = AddBlipForCoord(v.Blip.coords)

		SetBlipSprite(blip, v.Blip.sprite)
		SetBlipScale(blip, v.Blip.scale)
		SetBlipColour(blip, v.Blip.color)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		-- AddTextComponentSubstringPlayerName(_U('hospital'))
		AddTextComponentString('<font face="sarabun">โรงพยาบาล</font>')
		EndTextCommandSetBlipName(blip)
	end
end)

-- Disable most inputs when dead
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if IsDead then
			DisableAllControlActions(0)
			if talk then
				EnableControlAction(0, 249, true)
			end
			-- EnableControlAction(0, Keys['N'], true)
			EnableControlAction(0, Keys['G'], true)
			EnableControlAction(0, Keys['X'], true)
			--EnableControlAction(0, Keys['E'], true)
			--EnableControlAction(0, Keys['M'], true)
			--EnableControlAction(0, Keys['H'], true)
			EnableControlAction(0, Keys['R'], true)
			--EnableControlAction(0, Keys['DELETE'], true)
			--EnableControlAction(0, Keys['F6'], true)
			EnableControlAction(0, Keys['ENTER'], true)
			EnableControlAction(0, Keys['Q'], true)
			EnableControlAction(0, 18, true)
			EnableControlAction(0, 176, true)
			EnableControlAction(0, 191, true)
			EnableControlAction(0, 201, true)
			EnableControlAction(0, 215, true)
			EnableControlAction(0, 44, true)
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('esx_ambulancejob:removeblips')
AddEventHandler('esx_ambulancejob:removeblips', function(target)
	if blipsDead then
		RemoveBlip(blipsDead)
	end
end)

RegisterFontFile('font4thai') 

function OnPlayerDeath()
	local second = 1000
	local playerPed = PlayerPedId()
	local coordss    = GetEntityCoords(playerPed)
	-- print('PlayerDeath :  '..coordss) 
	IsDead = true
	FreezeEntityPosition(PlayerPedId(), true)
	--ClearPedTasksImmediately(playerPed)
	--SetCurrentPedWeapon(playerPed, GetHashKey("WEAPON_UNARMED"), true)
	ESX.UI.Menu.CloseAll()
	TriggerServerEvent('esx_ambulancejob:setDeathStatus', true)
	if Config.AutoRespawn then
		if exports.Fewthz_Check:CheckAmbulance(1) then

			StartDeathTimer()
			sendUILong()
		else
			StartAutoRespawnTimer()
			sendUIshort()
		end
	else
		StartDeathTimer()
		sendUILong()
	end
end

RegisterNetEvent('esx_ambulancejob:useItem')
AddEventHandler('esx_ambulancejob:useItem', function(itemName)
	ESX.UI.Menu.CloseAll()

	if itemName == 'medikit' then
		local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
		local playerPed = PlayerPedId()

		ESX.Streaming.RequestAnimDict(lib, function()
			TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)

			Citizen.Wait(500)
			while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
				Citizen.Wait(0)
				DisableAllControlActions(0)
			end
	
			TriggerEvent('esx_ambulancejob:heal', 'big', true)
			ESX.ShowNotification(_U('used_medikit'))
		end)

	elseif itemName == 'bandage' then
		local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
		local playerPed = PlayerPedId()

		ESX.Streaming.RequestAnimDict(lib, function()
			TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)

			Citizen.Wait(500)
			while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
				Citizen.Wait(0)
				DisableAllControlActions(0)
			end

			TriggerEvent('esx_ambulancejob:heal', 'small', true)
			ESX.ShowNotification(_U('used_bandage'))
		end)
	end
end)



function SendDistressSignal()
	local playerPed = PlayerPedId()
	PedPosition		= GetEntityCoords(playerPed)
	
	local PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z }

	ESX.ShowNotification(_U('distress_sent'))

    TriggerServerEvent('esx_addons_gcphone:startCall', 'ambulance', _U('distress_message'), PlayerCoords, {

		PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z },
	})
	
end



function secondsToClock(seconds)
	local seconds, hours, mins, secs = tonumber(seconds), 0, 0, 0

	if seconds <= 0 then
		return 0, 0
	else
		local hours = string.format("%02.f", math.floor(seconds / 3600))
		local mins = string.format("%02.f", math.floor(seconds / 60 - (hours * 60)))
		local secs = string.format("%02.f", math.floor(seconds - hours * 3600 - mins * 60))

		return mins, secs
	end
end

function StartDeathTimer()
	local canPayFine = false

	if Config.EarlyRespawnFine then
		ESX.TriggerServerCallback('esx_ambulancejob:checkBalance', function(canPay)
			canPayFine = canPay
		end)
	end

	local earlySpawnTimer = ESX.Math.Round(Config.EarlyRespawnTimer / 1000)
	local bleedoutTimer = ESX.Math.Round(Config.BleedoutTimer / 1000)

	Citizen.CreateThread(function()
		-- early respawn timer
		while earlySpawnTimer > 0 and IsDead do
			Citizen.Wait(1000)

			if earlySpawnTimer > 0 then
				earlySpawnTimer = earlySpawnTimer - 1
			end
		
			min,sec = secondsToClock(earlySpawnTimer)
			sendUILong(min,sec,earlySpawnTimer)
			

			if not IsDead then
				closeUI()
				break
			end
		end

		-- bleedout timer
		while bleedoutTimer > 0 and IsDead do
			Citizen.Wait(1000)

			if bleedoutTimer > 0 then
				bleedoutTimer = bleedoutTimer - 1
			end

			min,sec = secondsToClock(bleedoutTimer)
			sendUIbleed(min,sec,bleedoutTimer)

			if bleedoutTimer < 1 and IsDead then
				SendNUIMessage({
					type = 'NuiAmbulance',
					donetime = true,
					-- short = false
				})
				RemoveItemsAfterRPDeath()
			end

			if not IsDead then
				closeUI()
				break
			end
		end
	end)


	Citizen.CreateThread(function()
		Wait(500)
		while IsDead do
		  Citizen.Wait(0)
		  if IsControlPressed(0, Keys['X']) then
			  ClearPedTasksImmediately(PlayerPedId())
			  clearped()
		  end
		 end
	  end)

	  Citizen.CreateThread(function()
		Wait(500)
		while IsDead do
		  	Citizen.Wait(0)
		  	if IsControlPressed(0, Keys['R'])  then
				if not talk then
					requesToTalkNui()
				else
					exports['okokNotify']:Alert("แจ้งเตือน", "ได้รับอนุญาตให้พูดแล้ว", 5000, 'error')
					Citizen.Wait(5000)
				end
			end
		end
	end)

	Citizen.CreateThread(function()
		Wait(500)
		while IsDead do 
			Citizen.Wait(0)
			if IsControlPressed(0, Keys['G']) then
				alertambulance()
				SendDistressSignal() -- sms mobile
				signal()
			end
		end
	end)

	if Config.keyPolice ~= '' then

		Citizen.CreateThread(function()
			Wait(500)
			while IsDead do 
				Citizen.Wait(0)
				if IsControlPressed(0, Keys['K']) then	
					-- ใส่ alert ตร 
					alertpolice()
					police()
				end
			end
		end)
	end

end

function StartAutoRespawnTimer()
	local autoSpawnTimer = ESX.Round(Config.AutoRespawnTimer / 1000)

	Citizen.CreateThread(function()
		-- auto respawn timer
		while autoSpawnTimer > 0 and IsDead do
			Citizen.Wait(1000)

			if autoSpawnTimer > 0 then
				autoSpawnTimer = autoSpawnTimer - 1
			end

			
			min,sec = secondsToClock(autoSpawnTimer)
			sendUIshort(min,sec,autoSpawnTimer)


			if autoSpawnTimer < 1 and IsDead then
				SendNUIMessage({
					type = 'NuiAmbulance',
					donetime = true,
				})
				TriggerServerEvent('MedicxD:ReviveMe')
				break
			end
			if not IsDead then
				closeUI()
				break
			end
		end

	end)


end


local closestPlayer, closestDistance = 0
function checkClosestPlayer()
	local inVehicle   = IsPedSittingInAnyVehicle(PlayerPedId())
	 closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer > 1 and closestDistance <= 10.0 and not inVehicle  then	
		
			return true
	else
			return false
	end
end

function RemoveItemsAfterRPDeath()
	TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)

	Citizen.CreateThread(function()
			DoScreenFadeOut(800)

			while not IsScreenFadedOut() do
				Citizen.Wait(10)
			end

			ESX.TriggerServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function()
				local formattedCoords = GetEntityCoords(PlayerPedId())
				-- local formattedCoords = {
				-- 	x = Config.RespawnPoint.coords.x,
				-- 	y = Config.RespawnPoint.coords.y,
				-- 	z = Config.RespawnPoint.coords.z
				-- }

			ESX.SetPlayerData('lastPosition', formattedCoords)


			TriggerServerEvent('esx:updateLastPosition', formattedCoords)
			RespawnPed(PlayerPedId(), formattedCoords, Config.RespawnPoint.heading)
			--RespawnPed(PlayerPed, formattedCoords, 0.0)
			

			StopScreenEffect('')
			DoScreenFadeIn(800)
		end)
	end)
end

AddEventHandler('esx:onPlayerDeath', function(data)
	talk = false
	OnPlayerDeath()
end)

RegisterNetEvent('esx_ambulancejob:revive')
AddEventHandler('esx_ambulancejob:revive', function()
	talk = false
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
		closeUI()
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
	SetEntityHealth(playerPed, 110 ) 
	Citizen.Wait(1000)
	closeUI()
	ESX.UI.Menu.CloseAll()
end

-- Create blip for colleagues
function createBlip(id)
	local ped = GetPlayerPed(id)
	local blip = GetBlipFromEntity(ped)

	if not DoesBlipExist(blip) then -- Add blip and create head display on player
		blip = AddBlipForEntity(ped)
		SetBlipSprite(blip, 1)
		ShowHeadingIndicatorOnBlip(blip, true) -- Player Blip indicator
		SetBlipRotation(blip, math.ceil(GetEntityHeading(ped))) -- update rotation
		SetBlipNameToPlayerName(blip, id) -- update blip name
		SetBlipScale(blip, 0.85) -- set scale
		SetBlipAsShortRange(blip, true)
		
		table.insert(blipsCops, blip) -- add blip to array so we can remove it later
	end
end

RegisterNetEvent('esx_ambulancejob:updateBlip')
AddEventHandler('esx_ambulancejob:updateBlip', function()

	
	-- Clean the blip table
	blipsCops = {}

	-- Enable blip?
	if Config.MaxInService ~= -1 and not playerInService then
		return
	end

	if not Config.EnableJobBlip then
		return
	end
	
	-- Is the player a cop? In that case show all the blips for other cops
	if PlayerData.job ~= nil and PlayerData.job.name == 'ambulance' then

	end

end)

-- Load unloaded IPLs
if Config.LoadIpl then
	Citizen.CreateThread(function()
		RequestIpl('Coroner_Int_on') -- Morgue
	end)
end

local timeprogressleft= 0
local timerespawn = false
function sendUIshort(min,sec,timeleft)
				local timeprogress = 0
				local autoSpawnTimer = ESX.Round(Config.AutoRespawnTimer / 1000)
				
				if min == nil and sec == nil then
				timerespawn = true
				timeprogress = (((autoSpawnTimer / autoSpawnTimer) * 100) / 2 )- 50
				min,sec = secondsToClock(autoSpawnTimer)
				else
					timeprogress = (((timeleft / autoSpawnTimer) * 100) / 2 )- 50

				end
				timeprogressleft = timeprogress
				SendNUIMessage({
					type = 'NuiAmbulance',
					playerid = GetPlayerServerId(PlayerId()),
					earlytimemin = min,
					earlytimesec = sec,
					short = timerespawn,
					timeprogressbar = timeprogress,
					bleed = false,
					clear = false,
					theme = Config.Theme,
					keyClearbody = Config.keyClearbody,
					keySignal = Config.keySignal,
					keyPolice = Config.keyPolice,
					heartRate = Config.hearRate,
					keyTalk = Config.keyTalk
				})
end
function sendUILong(min,sec,timeleft)
	local timeprogress = 0
	local totaltimes = ESX.Math.Round(Config.EarlyRespawnTimer / 1000)
	if min == nil and sec == nil then
	timerespawn = false
	min,sec = secondsToClock(totaltimes)
	timeprogress = (((totaltimes / totaltimes) * 100) / 2 ) - 50
	else
		timeprogress = (((timeleft / totaltimes) * 100) / 2 ) - 50
	end
	timeprogressleft = timeprogress
	-- print(math.abs( timeprogress ))
	SendNUIMessage({
		type = 'NuiAmbulance',
		playerid = GetPlayerServerId(PlayerId()),
		earlytimemin = min,
		earlytimesec = sec,
		short = timerespawn,
		timeprogressbar = timeprogress,
		bleed = false,
		clear = false,
		theme = Config.Theme,
		keyClearbody = Config.keyClearbody,
		keySignal = Config.keySignal,
		keyPolice = Config.keyPolice,
		heartRate = Config.hearRate,
		keyTalk = Config.keyTalk
	})
end
function sendUIbleed(min,sec,timeleft)
	local bleedoutTimer = ESX.Math.Round(Config.BleedoutTimer / 1000)
	timeprogress = (((timeleft / bleedoutTimer) * 100) / 2 ) - 50
	timeprogressleft = timeprogress
	SendNUIMessage({
		type = 'NuiAmbulance',
		playerid = GetPlayerServerId(PlayerId()),
		earlytimemin = min,
		earlytimesec = sec,
		timeprogressbar = timeprogress,
		short = timerespawn,
		bleed = true,
		clear = false,
		theme = Config.Theme,
		keyClearbody = Config.keyClearbody,
		keySignal = Config.keySignal,
		heartRate = Config.hearRate,
		keyPolice = Config.keyPolice,
		keyTalk = Config.keyTalk
	})
end

function closeUI()
	SendNUIMessage({
		type = 'respawn',
		clear = true
	})
end

function clearped()
	SendNUIMessage({
		type = 'NuiAmbulance',
		playerid = GetPlayerServerId(PlayerId()),
		short = timerespawn,
		earlytimemin = min,
		earlytimesec = sec,
		timeprogressbar = timeprogressleft,
		clear = false,
		bleed = false,
		clearbody = false,
		cooldownBody = Config.cooldownBody,
		theme = Config.Theme,
		keyClearbody = Config.keyClearbody,
		keySignal = Config.keySignal,
		keyPolice = Config.keyPolice,
		cooldownpolice = Config.cooldownpolice,
		heartRate = Config.hearRate,
		keyTalk = Config.keyTalk
	})
	Citizen.Wait(Config.cooldownBody)
end

function signal ()
	SendNUIMessage({
		type = 'NuiAmbulance',
		playerid = GetPlayerServerId(PlayerId()),
		short = timerespawn,
		earlytimemin = min,
		earlytimesec = sec,
		timeprogressbar = timeprogressleft,
		signal = false,
		bleed = false,
		cooldownSignal = Config.cooldownSignal,
		theme = Config.Theme,
		keyClearbody = Config.keyClearbody,
		keySignal = Config.keySignal,
		keyPolice = Config.keyPolice,
		cooldownpolice = Config.cooldownpolice,
		heartRate = Config.hearRate,
		keyTalk = Config.keyTalk
	})

	Citizen.Wait(Config.cooldownSignal)
end

function police()
	SendNUIMessage({
		type = 'NuiAmbulance',
		playerid = GetPlayerServerId(PlayerId()),
		short = timerespawn,
		earlytimemin = min,
		earlytimesec = sec,
		timeprogressbar = timeprogressleft,
		police = false,
		bleed = false,
		cooldownSignal = Config.cooldownSignal,
		theme = Config.Theme,
		keyClearbody = Config.keyClearbody,
		keySignal = Config.keySignal,
		keyPolice = Config.keyPolice,
		cooldownpolice = Config.cooldownpolice,
		heartRate = Config.hearRate,
		keyTalk = Config.keyTalk
	})

	Citizen.Wait(Config.cooldownSignal)
end

function requesToTalkNui()


	if checkClosestPlayer() then
		closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		local playerID = GetPlayerServerId(closestPlayer)
		TriggerServerEvent('esx_ambulancejob:requestTalk', playerID)
		exports['okokNotify']:Alert("แจ้งเตือน", "ส่งคำขออนุญาตพูดไปแล้ว", 5000, 'success')

		Nuitalk(Config.cooldowntalk)
	
		Citizen.Wait(Config.cooldowntalk)

	else
		exports['okokNotify']:Alert("แจ้งเตือน", "ไม่พบผู้เล่นอยู่ในระยะ", 5000, 'error')
		Nuitalk(5000)
		Citizen.Wait(5000)
	end
	

end


function Nuitalk(cd)
	SendNUIMessage({
		type = 'NuiAmbulance',
		playerid = GetPlayerServerId(PlayerId()),
		short = timerespawn,
		earlytimemin = min,
		earlytimesec = sec,
		timeprogressbar = timeprogressleft,
		talk = false,
		bleed = false,
		cooldowntalk = cd,
		theme = Config.Theme,
		keyClearbody = Config.keyClearbody,
		keySignal = Config.keySignal,
		keyPolice = Config.keyPolice,
		cooldownpolice = Config.cooldownpolice,
		heartRate = Config.hearRate,
		keyTalk = Config.keyTalk
	})
end

RegisterNetEvent('esx_ambulancejob:requesToTalk')
AddEventHandler('esx_ambulancejob:requesToTalk', function(playerTalk)
    local elements = {
		{label = "อนุญาตให้พูด",value = 'confirm3'},
        {label = "อนุญาตให้พูด 5 นาที",value = 'confirm1'},
        {label = "อนุญาตให้พูด 10 นาที",value = 'confirm2'},
        {label = "ไม่อนุญาตให้พูด...",value = 'no'},
	}
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'requesToTalk', {
		title    = 'ผู้เล่น '..playerTalk..' ขออนุญาติพูด',
		align    = 'right',
		elements = elements
	}, function(data,menu)
		if data.current.value == 'confirm1' then
            TriggerServerEvent('esx_ambulancejob:requestAccept', playerTalk, true,5)
			menu.close()
        elseif data.current.value == 'confirm2' then
        	TriggerServerEvent('esx_ambulancejob:requestAccept', playerTalk, true,10)
        	menu.close()
		elseif data.current.value == 'confirm3' then
        	TriggerServerEvent('esx_ambulancejob:requestAccept', playerTalk, true,500)
        	menu.close()
        elseif data.current.value == 'no' then
            TriggerServerEvent('esx_ambulancejob:requestAccept', playerTalk, false)
        	menu.close()
		end
	end, function(data,menu)
		menu.close()
	end)
end)

RegisterNetEvent('esx_ambulancejob:updateTalk')
AddEventHandler('esx_ambulancejob:updateTalk', function(time)
    if time == Config.Talk1.Time then
        talk = true 
		exports['okokNotify']:Alert("แจ้งเตือน", Config.Talk1.Notify, 5000, 'success')
        Citizen.Wait(1000 * 60 * time)
        talk = false
    elseif time == Config.Talk2.Time then
        talk = true 
		exports['okokNotify']:Alert("แจ้งเตือน", Config.Talk2.Notify, 5000, 'success')
        Citizen.Wait(1000 * 60 * time)
        talk = false
	elseif time == 500 then
		talk = true 
		exports['okokNotify']:Alert("แจ้งเตือน", Config.Talk3.Notify, 5000, 'success')
    else
		exports['okokNotify']:Alert("แจ้งเตือน", Config.Talk4.Notify, 5000, 'error')
    end
end)

--คำสั่ง die
RegisterCommand("die", function()
    SetEntityHealth(PlayerPedId(), 0)
end)