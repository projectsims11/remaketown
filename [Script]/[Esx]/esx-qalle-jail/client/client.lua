local Keys = {
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
ESX = nil
PlayerData = {}
injaill = false
local jailTime = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData() == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()

	LoadTeleporters()
end)

Citizen.CreateThread(function()   
    while true do
		Citizen.Wait(0)
		local playerPed = GetPlayerPed(-1)
		local coords = GetEntityCoords(playerPed)	
		local Text = Config.Texttp["Pos"]	
		local canSleep  = true
		if GetDistanceBetweenCoords(coords, Text["x"], Text["y"], Text["z"] , true) < 10 then	
			canSleep = false
			DrawMarker(Config.Marker.type, Text["x"], Text["y"], Text["z"] -0.8, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, Config.Marker.rotate, nil, nil, false)	
		end

		if GetDistanceBetweenCoords(coords, Text["x"], Text["y"], Text["z"] , true) < 2 then	
			canSleep = false
			ShowToolTip( Config.Text, Text["x"], Text["y"], Text["z"] + 0.42)
			if IsControlJustPressed(0, Keys["E"]) and not IsPedInAnyVehicle(playerPed, true) then
				local money = exports["Fewthz_Check"]:Money()
                if money > Config.Price then   
					TriggerEvent("esx-qalle-jail:havemoney")
					TriggerServerEvent("esx-qalle-jail:removemoney")
				else
					exports['okokNotify']:Alert("แจ้งเตือน", '<span style="color:red">ล้มเหลว</span> คุณไม่มีเงิน <span style="color:red">' .. Config.Price ..'</span> บาท', 3000, 'error')
				end
			end
		end

		if canSleep then
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(newData)
	PlayerData = newData
	Citizen.Wait(25000)
	ESX.TriggerServerCallback("esx-qalle-jail:retrieveJailTime", function(inJail, newJailTime)
		if inJail then
			jailTime = newJailTime
			JailLogin()
		end
	end)
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(response)
	PlayerData["job"] = response
end)

RegisterNetEvent("esx-qalle-jail:openJailMenu")
AddEventHandler("esx-qalle-jail:openJailMenu", function()
	OpenJailMenu()
end)

RegisterNetEvent("esx-qalle-jail:jailPlayer")
AddEventHandler("esx-qalle-jail:jailPlayer", function(newJailTime)
	jailTime = newJailTime
	Cutscene()
end)

RegisterNetEvent("esx-qalle-jail:unJailPlayer")
AddEventHandler("esx-qalle-jail:unJailPlayer", function()
	jailTime = 0
	UnJail()
end)

function JailLogin()
	local JailPosition = Config.JailPositions["Cell"]
	SetEntityCoords(PlayerPedId(), JailPosition["x"], JailPosition["y"], JailPosition["z"] - 1)
	ESX.ShowNotification("Last time you went to sleep you were jailed, because of that you are now put back!")
	InJail()
end

function UnJail()
	InJail()
	ESX.Game.Teleport(PlayerPedId(), Config.Teleports["Unjail"])
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
		TriggerEvent('skinchanger:loadSkin', skin)
	end)
	exports['okokNotify']:Alert("แจ้งเตือน!", "คุณถูกปล่อยตัวเป็นอิสระ", 5000, 'success')
	injaill = false
end

function InJail()
	Citizen.CreateThread(function()
		while jailTime > 0 do
			jailTime = jailTime - 1			  
			exports['okokNotify']:Alert("แจ้งเตือน!", "คุณเหลือเวลาติดคุกอีก ".. jailTime .." นาที", 5000, 'warning')
			TriggerServerEvent("esx-qalle-jail:updateJailTime", jailTime)
			if jailTime == 0 then
				UnJail()
				TriggerServerEvent("esx-qalle-jail:updateJailTime", 0)
			end
			Citizen.Wait(60000)
		end
	end)
	injaill = true
end

function LoadTeleporters()
	Citizen.CreateThread(function()
		while true do			
			local sleepThread = 500
			local Ped = PlayerPedId()
			local PedCoords = GetEntityCoords(Ped)
			for p, v in pairs(Config.Teleports) do
				local DistanceCheck = GetDistanceBetweenCoords(PedCoords, v["x"], v["y"], v["z"], true)
				if DistanceCheck <= 7.5 then
					sleepThread = 5
					--ESX.Game.Utils.DrawText3D(v, "[E] Open Door", 0.4)
					if DistanceCheck <= 1.0 then
						if IsControlJustPressed(0, 38) then
							TeleportPlayer(v)
						end
					end
				end
			end
			Citizen.Wait(sleepThread)
		end
	end)
end

function OpenJailMenu()
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'jail_prison_menu',
		{
			title    = "Prison Menu",
			align    = 'center',
			elements = {
				{ label = "ส่งผู้เล่นเข้าเรือนจำใหญ่", value = "jail_closest_player" },
				{ label = "นำผู้เล่นออกเรือนจำใหญ่", value = "unjail_player" }
			}
		}, 
	function(data, menu)
		local action = data.current.value
		if action == "jail_closest_player" then
			menu.close()
			ESX.UI.Menu.Open(
          		'dialog', GetCurrentResourceName(), 'jail_choose_time_menu',
          		{
            		title = "เวลา (นาที)"
          		},
          	function(data2, menu2)
            	local jailTime = tonumber(data2.value)
            	if jailTime == nil then
              		ESX.ShowNotification("The time needs to be in minutes!")
            	else
              		menu2.close()
              		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
              		if closestPlayer == -1 or closestDistance > 3.0 then
                		ESX.ShowNotification("No players nearby!")
					else
						ESX.UI.Menu.Open(
							'dialog', GetCurrentResourceName(), 'jail_choose_reason_menu',
							{
							  title = "คดี (ต้องใส่)"
							},
						function(data3, menu3)		  
						  	local reason = data3.value		  
						  	if reason == nil then
								ESX.ShowNotification("You need to put something here!")
						  	else
								menu3.close()		  
								local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()		  
								if closestPlayer == -1 or closestDistance > 3.0 then
								  	ESX.ShowNotification("No players nearby!")
								else
								  	TriggerServerEvent("esx-qalle-jail:jailPlayer", GetPlayerServerId(closestPlayer), jailTime, reason)
								end		  
						  	end		  
						end, function(data3, menu3)
							menu3.close()
						end)
              		end
				end
          	end, function(data2, menu2)
				menu2.close()
			end)
		elseif action == "unjail_player" then
			local elements = {}
			ESX.TriggerServerCallback("esx-qalle-jail:retrieveJailedPlayers", function(playerArray)
				if #playerArray == 0 then
					ESX.ShowNotification("Your jail is empty!")
					return
				end
				for i = 1, #playerArray, 1 do
					table.insert(elements, {label = "Prisoner: " .. playerArray[i].firstname .. " | Jail Time: " .. playerArray[i].jailTime .. " minutes", value = playerArray[i].identifier })
				end
				ESX.UI.Menu.Open(
					'default', GetCurrentResourceName(), 'jail_unjail_menu',
					{
						title = "Unjail Player",
						align = "center",
						elements = elements
					},
				function(data2, menu2)
					local action = data2.current.value
					TriggerServerEvent("esx-qalle-jail:unJailPlayer", action)
					menu2.close()
				end, function(data2, menu2)
					menu2.close()
				end)
			end)
		end
	end, function(data, menu)
		menu.close()
	end)	
end

RegisterNetEvent('esx-qalle-jail:havemoney')
AddEventHandler('esx-qalle-jail:havemoney', function()
	havemoneyy()
end)

function havemoneyy()
	ESX.Game.Teleport(PlayerPedId(), Config.Teleports["Tp"])
end

function Deadteleport()
	ESX.Game.Teleport(PlayerPedId(), Config.Teleports["Deadspawn"])		
end

AddEventHandler('esx:onPlayerDeath', function(data)
    if injaill then
		Citizen.Wait(500)
		Deadteleport()
	end   
end)

ShowToolTip = function (msg, x,y,z)
    AddTextEntry('FewZ', msg)
    SetFloatingHelpTextWorldPosition(1, x,y,z)
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
    BeginTextCommandDisplayHelp('FewZ')
    EndTextCommandDisplayHelp(2, false, false, -1)
end
