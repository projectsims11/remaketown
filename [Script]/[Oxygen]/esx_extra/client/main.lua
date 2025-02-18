ESX 					  = nil
local CurrentActionData   = {}
local lastTime 			  = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local second = 1000
local minute = 60 * second

RegisterNetEvent('esx_extraitems:oxygen_mask')
AddEventHandler('esx_extraitems:oxygen_mask', function()
	TriggerEvent('lorraxs_progress', 10 * minute, function(isBusy) 
	if not isBusy then 
		local playerPed  = GetPlayerPed(-1)
		local coords     = GetEntityCoords(playerPed)
		local boneIndex  = GetPedBoneIndex(playerPed, 12844)
		local boneIndex2 = GetPedBoneIndex(playerPed, 24818)
		
		ESX.Game.SpawnObject('p_s_scuba_mask_s', {
			x = coords.x,
			y = coords.y,
			z = coords.z - 3
		}, function(object)
			ESX.Game.SpawnObject('p_s_scuba_tank_s', {
				x = coords.x,
				y = coords.y,
				z = coords.z - 3
			}, function(object2)
				AttachEntityToEntity(object2, playerPed, boneIndex2, -0.30, -0.22, 0.0, 0.0, 90.0, 180.0, true, true, false, true, 1, true)
				AttachEntityToEntity(object, playerPed, boneIndex, 0.0, 0.0, 0.0, 0.0, 90.0, 180.0, true, true, false, true, 1, true)
				SetPedDiesInWater(playerPed, false)				
				Citizen.Wait(10 * minute)  --Because we trigger hud with 200000ms
				SetPedDiesInWater(playerPed, true)
				DeleteObject(object)
				DeleteObject(object2)
				ClearPedSecondaryTask(playerPed)
				end)
			end)
		end
	end)
end)