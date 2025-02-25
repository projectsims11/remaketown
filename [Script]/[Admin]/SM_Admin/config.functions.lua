-- Function ในการเสกพาหนะ (client)
Config["spawnVehicle"] = function(model)
	local coords = GetEntityCoords(PlayerPedId())
	local closestVehicle = ESX.Game.GetClosestVehicle(coords)
	ESX.Game.DeleteVehicle(closestVehicle)
	ESX.Game.SpawnVehicle(model, vector3(coords.x + 2.0, coords.y, coords.z), 0.0, function(vehicle)
		if DoesEntityExist(vehicle) then
			TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
		end		
	end)
	return true
end

-- Function เปิดเมนูแต่งพาหนะ (client)
Config["customsVehicle"] = function()
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
		--exports["Dv_Hunter_customShop"]:openByMenuAdmin()
		exports.Fewthz_Lscustom_ui:openByMenuAdmin()
		return true
	end
end

-- Function ซ่อมพาหนะ (client)
Config["repairVehicle"] = function()
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
		local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
		SetVehicleEngineHealth(vehicle, 1000)
		SetVehicleEngineOn(vehicle, true, true)
		SetVehicleFixed(vehicle)
		SetVehicleDirtLevel(vehicle, 0)
		return true
	end
end

-- Function ลบพาหนะ (client)
Config["doAfterdeleteVehicle"] = function()
	print('Deleted around vehicles..') -- zack
end

-- Function ลบพาหนะ ในระยะ 50 เมตร (client)
Config["deleteVehicle50M"] = function()
	--TriggerEvent("esx:deleteVehicle", 50.0)

	print('This is disabled function!') -- zack
end

-- Function วาปไปยังจุดที่ Mark ในแผนที่ (client)
Config["TeleportToWaypoint"] = function()
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
			Citizen.Wait(0)
		end
		return true
	end
end

-- Function ฮีลผู้เล่น (client)
Config["Heal"] = function(type)
	SetEntityHealth(PlayerPedId(), GetEntityMaxHealth(PlayerPedId()))
	ClearPedBloodDamage(PlayerPedId())
	TriggerEvent('esx_status:set', 'hunger', 1000000)
	TriggerEvent('esx_status:set', 'stress', 0)
	RestorePlayerStamina(PlayerId(), 100.0)
end

-- Function ชุบผู้เล่น (client)
Config["Revive"] = function(type)
	if type == "all" then
		if IsPedDeadOrDying(PlayerPedId(), 1) then
			TriggerEvent("esx_ambulancejob:revive")
		end
	elseif type == "one" then
		TriggerEvent("esx_ambulancejob:revive")
	end
end

-- Function เปิดกระเป๋าผู้เล่น (client)
Config["openInventory"] = function(playerid)
	TriggerEvent("esx_inventoryhud:openPlayerInventory", playerid)
	return true
end

-- Function ประกาศแอดมิน (server)
Config["Announce"] = function(message)
	TriggerClientEvent("chat:addMessage", -1, { color = { 255, 0, 0}, args = { "Announcement ", message } })
	ShowAnnoucement()
end
