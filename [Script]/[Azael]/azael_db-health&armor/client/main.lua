--[[
	code generated using luamin.js, Herrtt#3868
--]]


ESX = nil
local healthLoaded, isHealth, armorLoaded, isArmor, notifyHealth, notifyArmour = false, false, false, false, false, false
local delayLoaded = (Config['ped_loaded_delay'] * 1000)
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent(Config['esx_routers']['client_shared_obj'], function(obj)
			ESX = obj
		end)
		Citizen.Wait(0)
	end
end)
RegisterNetEvent('azael_db-health&armor:playerLoaded')
AddEventHandler('azael_db-health&armor:playerLoaded', function(pedLoaded)
	if pedLoaded then
		Citizen.Wait(delayLoaded)
		healthLoaded = true
		armorLoaded = true
	end
end)
AddEventHandler('esx_status:loaded', function(status)
	TriggerEvent('esx_status:registerStatus', 'health', Config['ped_max_health'], '#f4003e', function(status)
		return false
	end, function(status)
		status.remove(0)
	end)
	TriggerEvent('esx_status:registerStatus', 'armor', 0, '#00cc99', function(status)
		return false
	end, function(status)
		status.remove(0)
	end)
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1000)
			local playerPed = PlayerPedId()
			local playerHealth = GetEntityHealth(playerPed)
			local playerArmor = GetPedArmour(playerPed)
			SetPedMaxHealth(playerPed, Config['ped_max_health'])
			if Config['enable_health'] then
				TriggerEvent('esx_status:getStatus', 'health', function(status)
					if not healthLoaded and isHealth then
						if playerHealth >= (100) and playerHealth ~= status.val then
							TriggerEvent('esx_status:set', 'health', playerHealth)
							if Config['enable_debug'] then
								TriggerServerEvent('azael_db-health&armor:playerDebug', GetPlayerServerId(PlayerId()), 'esx_status:set-health('..playerHealth..')')
							end
						end
						if playerHealth < (100) and status.val > (0) then
							TriggerEvent('esx_status:set', 'health', 0)
							if Config['enable_debug'] then
								TriggerServerEvent('azael_db-health&armor:playerDebug', GetPlayerServerId(PlayerId()), 'esx_status:set-health(0)')
							end
						end
					end
					if healthLoaded and status.val then
						healthLoaded = false
						isHealth = true
						notifyHealth = status.val
						SetEntityHealth(playerPed, status.val)
						if Config['enable_debug'] then
							TriggerServerEvent('azael_db-health&armor:playerDebug', GetPlayerServerId(PlayerId()), 'SetEntityHealth('..status.val..')')
						end
					end
				end)
			end
			if Config['enable_armor'] then
				TriggerEvent('esx_status:getStatus', 'armor', function(status)
					if not armorLoaded and isArmor then
						if playerArmor > (0) and playerArmor ~= status.val then
							TriggerEvent('esx_status:set', 'armor', playerArmor)
							if Config['enable_debug'] then
								TriggerServerEvent('azael_db-health&armor:playerDebug', GetPlayerServerId(PlayerId()), 'esx_status:set-armor('..playerArmor..')')
							end
						end
						if playerArmor < (1) and status.val > (0) then
							TriggerEvent('esx_status:set', 'armor', 0)
							if Config['enable_debug'] then
								TriggerServerEvent('azael_db-health&armor:playerDebug', GetPlayerServerId(PlayerId()), 'esx_status:set-armor(0)')
							end
						end
					end
					if armorLoaded then
						armorLoaded = false
						isArmor = true
						notifyArmour = status.val
						SetPedArmour(playerPed, status.val)
						if Config['enable_debug'] then
							TriggerServerEvent('azael_db-health&armor:playerDebug', GetPlayerServerId(PlayerId()), 'SetPedArmour('..status.val..')')
						end
					end
				end)
			end
		end
	end)
end)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if notifyHealth and notifyArmour then
			ESX.TriggerServerCallback('azael_db-health&armor:playerName', function(playerName)
				if playerName then
					notification(playerName, notifyHealth, notifyArmour)
				end
			end)
			break
		end
	end
end)
function notification(name, health, armour)
	notifyHealth, notifyArmour = false, false
	if health > (100) then
		health = (health - 100)
	elseif health == (100) then
		health = (1)
	end
	local playerName, playerHealth, playerArmor = name, health, armour
	local playerId = GetPlayerServerId(PlayerId())
	local mugshot, mugshotStr = ESX.Game.GetPedMugshot(PlayerPedId())
	ESX.ShowAdvancedNotification(playerName, 'Server #'..playerId..'', 'You have remaining ~g~health~s~ ~y~'..playerHealth..'%~s~ and ~b~armor~s~ ~y~'..playerArmor..'%~s~.', mugshotStr)
	UnregisterPedheadshot(mugshot)
end