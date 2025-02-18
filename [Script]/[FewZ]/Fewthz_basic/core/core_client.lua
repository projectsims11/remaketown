_G.ESX = nil
_G.script_name =  "Fewthz_basic"
_G.Nightvision = false
_G.Thermalvision = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent(Config["Fewthz-Router"]["client_shared_obj"], function(obj) ESX = obj end)
		Citizen.Wait(7)
	end
end)

RegisterNetEvent(Config["Fewthz-Router"]["client_player_load"])
AddEventHandler(Config["Fewthz-Router"]["client_player_load"], function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent(Config["Fewthz-Router"]["client_player_setjob"])
AddEventHandler(Config["Fewthz-Router"]["client_player_setjob"], function(job)
	PlayerData.job = job
end)

RegisterNetEvent(script_name..":addammo")
AddEventHandler(script_name..":addammo", function()
	local ped = GetPlayerPed(-1)
	if IsPedArmed(ped, 4) then
		hash = GetSelectedPedWeapon(ped)
		if hash ~= nil then
			TriggerEvent("pNotify:SendNotification", {
				text = Config["Text_Alert"]["AddAmmo"],
				type = "information",
				timeout = 5000,
				layout = "centerRight",
				queue = "global"
			})
			TriggerServerEvent(":deleteammo", hash)
		else
			TriggerEvent("pNotify:SendNotification", {
				text = Config["Text_Alert"]["Not_Work"],
				type = "information",
				timeout = 5000,
				layout = "centerRight",
				queue = "global"
			})
		end
	else
		TriggerEvent("pNotify:SendNotification", {
			text = Config["Text_Alert"]["Not_Weapon"],
			type = "information",
			timeout = 5000,
			layout = "centerRight",
			queue = "global"
		})
	end
end)

Nightvision = true
RegisterNetEvent(script_name..":nightvision")
AddEventHandler(script_name..":nightvision", function()
	if ( Nightvision ) then
		SetNightvision(true)
		Nightvision = false
		local animDict = "mp_masks@on_foot"
		local animName = "put_on_mask"
		RequestAnimDict(animDict)
		while not HasAnimDictLoaded(animDict) do
			Citizen.Wait(10)
		end
		TaskPlayAnim(GetPlayerPed(-1), animDict, animName, 8.0, -8.0, -1, 50, 0, false, false, false)
		Citizen.Wait(800)
		ClearPedTasks(PlayerPedId())
		TriggerEvent(Config["Fewthz-Router"]["client_player_getskin"], function(skin)
			if Config["CameraClothes"].male ~= nil then
				TriggerEvent(Config["Fewthz-Router"]["client_player_loadclothes"], skin, Config["CameraClothes"].male)
			else
				if Config["CameraClothes"].female ~= nil then
					TriggerEvent(Config["Fewthz-Router"]["client_player_loadclothes"], skin, Config["CameraClothes"].female)
				end
			end
		end)
	else
		SetNightvision(false)
		Nightvision = true
		local animDict = "missfbi4"
		local animName = "takeoff_mask"
		RequestAnimDict(animDict)
		while not HasAnimDictLoaded(animDict) do
			Citizen.Wait(10)
		end
		TaskPlayAnim(GetPlayerPed(-1), animDict, animName, 8.0, -8.0, -1, 50, 0, false, false, false)
		Citizen.Wait(1000)
		ClearPedTasks(PlayerPedId())
		TriggerEvent(Config["Fewthz-Router"]["client_player_getskin"], function(skin)
			if skin.sex == 0 then
				local clothesSkin = {
            		["mask_1"] = 0, ["mask_2"] = 0
				}
				TriggerEvent(Config["Fewthz-Router"]["client_player_loadclothes"], skin, clothesSkin)
			else
				local clothesSkin = {
            		["mask_1"] = 0, ["mask_2"] 	= 0
        		}
				TriggerEvent(Config["Fewthz-Router"]["client_player_loadclothes"], skin, clothesSkin)
			end
		end)
	end
end)

Thermalvision = true
RegisterNetEvent(script_name..":thermalvision")
AddEventHandler(script_name..":thermalvision", function()
	if ( Thermalvision ) then
		SetSeethrough(true)
		Thermalvision = false
		local animDict = "mp_masks@on_foot"
		local animName = "put_on_mask"
		RequestAnimDict(animDict)
		while not HasAnimDictLoaded(animDict) do
			Citizen.Wait(10)
		end
		TaskPlayAnim(GetPlayerPed(-1), animDict, animName, 8.0, -8.0, -1, 50, 0, false, false, false)
		Citizen.Wait(800)
		ClearPedTasks(PlayerPedId())
		TriggerEvent(Config["Fewthz-Router"]["client_player_getskin"], function(skin)
			if Config["CameraClothes"].male ~= nil then
				TriggerEvent(Config["Fewthz-Router"]["client_player_loadclothes"], skin, Config["CameraClothes"].male)
			else
				if Config["CameraClothes"].female ~= nil then
					TriggerEvent(Config["Fewthz-Router"]["client_player_loadclothes"], skin, Config["CameraClothes"].female)
				end
			end
		end)
	else
		SetSeethrough(false)
		Thermalvision = true
		local animDict = "missfbi4"
		local animName = "takeoff_mask"
		RequestAnimDict(animDict)
		while not HasAnimDictLoaded(animDict) do
			Citizen.Wait(10)
		end
		TaskPlayAnim(GetPlayerPed(-1), animDict, animName, 8.0, -8.0, -1, 50, 0, false, false, false)
		Citizen.Wait(1000)
		ClearPedTasks(PlayerPedId())
		TriggerEvent(Config["Fewthz-Router"]["client_player_getskin"], function(skin)
			if skin.sex == 0 then
				local clothesSkin = {
            		["mask_1"] = 0, ["mask_2"] = 0
				}
				TriggerEvent(Config["Fewthz-Router"]["client_player_loadclothes"], skin, clothesSkin)
			else
				local clothesSkin = {
            		["mask_1"] = 0, ["mask_2"] 	= 0
        		}
				TriggerEvent(Config["Fewthz-Router"]["client_player_loadclothes"], skin, clothesSkin)
			end
		end)
	end
end)

function setNightvision(flag)
	Nightvision = flag
end

function SetThermalvision(flag2)
	Thermalvision = flag2
end

AddEventHandler("Fewthz_core:ClientMemoryGarbage", function()
	Citizen.CreateThread(function()
		Wait(math.random(100, 2000))
		collectgarbage()
	end)
end)