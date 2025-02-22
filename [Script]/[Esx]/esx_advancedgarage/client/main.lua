local ESX    			 	  = nil
local PlayerData 			  = {}
local JobBlips 				  = {}
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local userProperties          = {}
local this_Garage             = {}
local privateBlips            = {}
local Keys 					  = {
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

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
	refreshBlips()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	refreshBlips()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
	deleteBlips()
	refreshBlips()
end)

local function has_value (tab, val)
	for index, value in ipairs(tab) do
		if value == val then
				return true
		end
	end
	return false
end

-- List Owned Cars Menu
function ListOwnedCarsMenu()
	local elements = {}
	if Config.ShowSpacer1 == true then
		table.insert(elements, {label = _U('spacer1')})
	end
	
	if Config.ShowSpacer2 == true then
		table.insert(elements, {label = _U('spacer2')})
	end
	
	if Config.ShowSpacer3 == true then
		table.insert(elements, {label = _U('spacer3')})
	end
	
	ESX.TriggerServerCallback(GetCurrentResourceName() .. ':getOwnedCars', function(ownedCars)
		if #ownedCars == 0 then
			exports['okokNotify']:Alert("แจ้งเตือน", "คุณไม่มีรถอยู่ในการาจ", 5000, 'error')
		else
			SetNuiFocus(true, true)
			SendNUIMessage({
				display = true
			})
			SendNUIMessage({
				clear = true
			})

			for k,v in pairs(ownedCars) do
				local hashVehicule = json.decode(v.vehicle).model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = GetLabelText(aheadVehName)
				local labelvehicle
				local plate = k .. '. ' .. v.plate
				local plate2 = v.plate
				local enginpersen = json.decode(v.health_vehicles).health_engine
                local bodypersen = json.decode(v.health_vehicles).health_body
                local fuelpersen = json.decode(v.health_vehicles).fuel
                local fuel = tostring(math.ceil(fuelpersen))
                local engine = tostring(math.ceil(enginpersen))
                local body = tostring(math.ceil(bodypersen))

			


				SendNUIMessage({
					garage = 'car',
					model = aheadVehName,
					name = vehicleName,
					plate = plate,
					plate2 = plate2,
					fuel  = fuel,
					engine = engine,
					body = body
				})

				if v.stored then
					labelvehicle = '| ' .. plate .. ' | ' .. vehicleName .. ' | ' .. _U('loc_garage') .. ' |'
				else
					labelvehicle = '| ' .. plate .. ' | ' .. vehicleName .. ' | ' .. _U('loc_pound')  .. ' |'
				end

				table.insert(elements, {
					label = labelvehicle, 
					vehicle = json.decode(v.vehicle), 
					stored = v.stored, 
					plate = v.plate, 
					damage = json.decode(v.health_vehicles)
				})
			end
		end
	end)
end

-- Store Owned Cars Menu
function StoreOwnedCarsMenu()
	local playerPed  = GetPlayerPed(-1)
	local vehicle =	GetVehiclePedIsIn(playerPed, false)
	local DSMSS = GetVehiclePedIsIn(playerPed, false)
	local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
	
	ESX.TriggerServerCallback(GetCurrentResourceName() .. ':storeVehicle',function(valid)
		if(valid) then
			local hasEnoughMoney = exports["Fewthz_Check"]:Money()
			if hasEnoughMoney > Config.Price then
				SaveDamage(vehicle, vehicleProps)
				DeleteEntity(vehicle)
				TriggerServerEvent(GetCurrentResourceName() .. ':payCar', Config.Price)
				TriggerServerEvent(GetCurrentResourceName() .. ':setVehicleState', vehicleProps.plate, true)

				local sendToDiscord = '' .. GetPlayerName(PlayerId()) .. ' เก็บรถ '.. vehicleProps.model ..' ทะเบียน ' .. vehicleProps.plate .. ' เข้า Garage '
				TriggerServerEvent('azael_discordlogs:sendToDiscord', 'PutVehicleGarage', sendToDiscord, GetPlayerServerId(PlayerId()), '^2')

				TriggerEvent("pNotify:SendNotification", {
					text = '<strong class="green-text">เก็บรถของคุณเรียบร้อยแล้ว จ่าย '..Config.Price..'</strong>',
					type = "success",
					timeout = 3000,
					layout = "bottomCenter",
					queue = "global"
				})
			else
				TriggerEvent("pNotify:SendNotification", {
					text = '<strong class="red-text">คุณไม่มีเงินเพียงพอ</strong>',
					type = "error",
					timeout = 3000,
					layout = "bottomCenter",
					queue = "global"
				})		
			end
		else
			TriggerEvent("pNotify:SendNotification", {
				text = '<strong class="red-text">คุณไม่สามารถจัดเก็บยานพาหนะนี้ได้ เนื่องจากคุณไม่ใช่เจ้าของ</strong>',
				type = "error",
				timeout = 3000,
				layout = "bottomCenter",
				queue = "global"
			})
		end
	end, vehicleProps)
end

-- Pound Owned Cars Menu
function ReturnOwnedCarsMenu()
	ESX.TriggerServerCallback('esx_advancedgarage:getOutOwnedCars', function(ownedCars)
		local elements = {}
		if #ownedCars == 0 then
			exports['okokNotify']:Alert("แจ้งเตือน", "คุณไม่มีรถอยู่ในการาจ", 5000, 'error')
		else
			SendNUIMessage({
				clear = true,
			})

			SetNuiFocus(true, true)

			SendNUIMessage({
				display = true,
			})

			for k,v in pairs(ownedCars) do
				local hashVehicule = json.decode(v.vehicle).model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = GetLabelText(aheadVehName)
				local labelvehicle
				local plate = k..'. '..v.plate
				local plate2 = v.plate
				local enginpersen = json.decode(v.health_vehicles).health_engine
                local bodypersen = json.decode(v.health_vehicles).health_body
                local fuelpersen = json.decode(v.health_vehicles).fuel
                local fuel = tostring(math.ceil(GetVehicleFuelLevel(fuelpersen)))
                local engine = tostring(math.ceil(GetVehicleFuelLevel(enginpersen)))
                local body = tostring(math.ceil(GetVehicleFuelLevel(bodypersen)))


				SendNUIMessage({
					garage = 'pound',
					model = aheadVehName,
					name = vehicleName,
					plate = plate,
					fuel  = fuel,
					plate2 = plate2,
					engine = engine,
					body = body,
				})

				if v.stored then
					labelvehicle = '| ' .. plate .. ' | ' .. vehicleName .. ' | ' .. _U('loc_garage') .. ' |'
				else
					labelvehicle = '| ' .. plate .. ' | ' .. vehicleName .. ' | ' .. _U('loc_pound')  .. ' |'
				end

				table.insert(elements, {label = labelvehicle, vehicle = json.decode(v.vehicle), stored = v.stored, plate = v.plate, damage = json.decode(v.health_vehicles)})
			end
		end
	end)
end

function ReturnPoliceOwnedCarsMenu()
	if Config.NoPolicePound == exports.Fewthz_Check:CheckPoliceonline() then
		ESX.TriggerServerCallback('esx_advancedgarage:getOutOwnedCarsNonpolice', function(ownedCars)
			local elements = {}

			SendNUIMessage({
				clear = true,
			})

			SetNuiFocus(true, true)

			SendNUIMessage({
				display = true,
			})

			for k,v in pairs(ownedCars) do
				local hashVehicule = json.decode(v.vehicle).model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = GetLabelText(aheadVehName)
				local labelvehicle
				local plate = k .. '. ' .. v.plate
				local plate2 = v.plate
				local enginpersen = json.decode(v.health_vehicles).health_engine
                local bodypersen = json.decode(v.health_vehicles).health_body
                local fuelpersen = json.decode(v.health_vehicles).fuel
                local fuel = tostring(math.ceil(GetVehicleFuelLevel(fuelpersen)))
                local engine = tostring(math.ceil(enginpersen))
                local body = tostring(math.ceil(bodypersen))

				SendNUIMessage({
					garage = 'pound_police_taken',
					model = aheadVehName,
					name = vehicleName,
					plate = plate,
					plate2 = plate2,
					fuel  = fuel,
					engine = engine,
					body = body
				})

				if v.stored then
					labelvehicle = '| ' .. plate .. ' | ' .. vehicleName .. ' | ' .. _U('loc_garage') .. ' |'
				else
					labelvehicle = '| ' .. plate .. ' | ' .. vehicleName .. ' | ' .. _U('loc_pound')  .. ' |'
				end

				table.insert(elements, {
					label = labelvehicle, 
					vehicle = json.decode(v.vehicle), 
					stored = v.stored, 
					plate = v.plate, 
					damage = json.decode(v.health_vehicles)
				})
			end
		end)
	else
		TriggerEvent("pNotify:SendNotification", {
			text = '<strong class="red-text">ตำรวจมีมากกว่า 1 กรุณาไปติดต่อเจ้าหน้าที่ตำรวจ.</strong>',
			type = "error",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		})
	end
end

-- Pound Owned Boat Menu
function ReturnOwnedBoatMenu()
	ESX.TriggerServerCallback('esx_advancedgarage:getOutOwnedBoat', function(ownedBoat)
		local elements = {}
		if #ownedBoat == 0 then
			exports['okokNotify']:Alert("แจ้งเตือน", "คุณไม่มีรถอยู่ในการาจ", 5000, 'error')
		else
			SendNUIMessage({
				clear = true,
			})

			SetNuiFocus(true, true)

			SendNUIMessage({
				display = true,
			})

			for k,v in pairs(ownedBoat) do
				local hashVehicule = json.decode(v.vehicle).model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = GetLabelText(aheadVehName)
				local labelvehicle
				local plate = k..'. '..v.plate
				local plate2 = v.plate
				local enginpersen = json.decode(v.health_vehicles).health_engine
                local bodypersen = json.decode(v.health_vehicles).health_body
                local fuelpersen = json.decode(v.health_vehicles).fuel
                local fuel = tostring(math.ceil(GetVehicleFuelLevel(fuelpersen)))
                local engine = tostring(math.ceil(GetVehicleFuelLevel(enginpersen)))
                local body = tostring(math.ceil(GetVehicleFuelLevel(bodypersen)))


				SendNUIMessage({
					garage = 'boat',
					model = aheadVehName,
					name = vehicleName,
					plate = plate,
					fuel  = fuel,
					plate2 = plate2,
					engine = engine,
					body = body,
				})

				if v.stored then
					labelvehicle = '| ' .. plate .. ' | ' .. vehicleName .. ' | ' .. _U('loc_garage') .. ' |'
				else
					labelvehicle = '| ' .. plate .. ' | ' .. vehicleName .. ' | ' .. _U('loc_pound')  .. ' |'
				end

				table.insert(elements, {label = labelvehicle, vehicle = json.decode(v.vehicle), stored = v.stored, plate = v.plate, damage = json.decode(v.health_vehicles)})
			end
		end
	end)
end

-- Pound Owned helicopter Menu
function helicoptermenu()
	ESX.TriggerServerCallback('esx_advancedgarage:getOutOwnedhelicopter', function(ownedBoat)
		local elements = {}
		if #ownedBoat == 0 then
			exports['okokNotify']:Alert("แจ้งเตือน", "คุณไม่มีรถอยู่ในการาจ", 5000, 'error')
		else
			SendNUIMessage({
				clear = true,
			})

			SetNuiFocus(true, true)

			SendNUIMessage({
				display = true,
			})

			for k,v in pairs(ownedBoat) do
				local hashVehicule = json.decode(v.vehicle).model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = GetLabelText(aheadVehName)
				local labelvehicle
				local plate = k..'. '..v.plate
				local plate2 = v.plate
				local enginpersen = json.decode(v.health_vehicles).health_engine
                local bodypersen = json.decode(v.health_vehicles).health_body
                local fuelpersen = json.decode(v.health_vehicles).fuel
                local fuel = tostring(math.ceil(GetVehicleFuelLevel(fuelpersen)))
                local engine = tostring(math.ceil(GetVehicleFuelLevel(enginpersen)))
                local body = tostring(math.ceil(GetVehicleFuelLevel(bodypersen)))


				SendNUIMessage({
					garage = 'helicopter',
					model = aheadVehName,
					name = vehicleName,
					plate = plate,
					fuel  = fuel,
					plate2 = plate2,
					engine = engine,
					body = body,
				})

				if v.stored then
					labelvehicle = '| ' .. plate .. ' | ' .. vehicleName .. ' | ' .. _U('loc_garage') .. ' |'
				else
					labelvehicle = '| ' .. plate .. ' | ' .. vehicleName .. ' | ' .. _U('loc_pound')  .. ' |'
				end

				table.insert(elements, {label = labelvehicle, vehicle = json.decode(v.vehicle), stored = v.stored, plate = v.plate, damage = json.decode(v.health_vehicles)})
			end
		end
	end)
end

-- Spawn Cars
local oldCars = {}


function SpawnVehiclePolice(vehicle, plate, damage)
    local cb_veh = nil
    ESX.Game.SpawnVehicle(vehicle.model, {
        x = this_Garage.SpawnPoint.x,
        y = this_Garage.SpawnPoint.y,
        z = this_Garage.SpawnPoint.z + 1
    }, this_Garage.SpawnPoint.h, function(callback_vehicle)
        ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
        cb_veh = callback_vehicle
        SetDamage(callback_vehicle, damage)
        SetVehRadioStation(callback_vehicle, "OFF")
        TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
		
    end)
    TriggerServerEvent(GetCurrentResourceName() .. ':setVehicleStatePolice', plate, false)
    local sendToDiscord = '' .. GetPlayerName(PlayerId()) .. ' นำพาหนะ hash = ' .. vehicle.model ..
                              ' ทะเบียน ' .. plate .. ' ออกจาก Garage '
    TriggerServerEvent('azael_discordlogs:sendToDiscord', 'GetVehicleGarage', sendToDiscord,
        GetPlayerServerId(PlayerId()), '^2')
end


function SpawnVehicle(vehicle, plate, damage)
    local cb_veh = nil
    ESX.Game.SpawnVehicle(vehicle.model, {
        x = this_Garage.SpawnPoint.x,
        y = this_Garage.SpawnPoint.y,
        z = this_Garage.SpawnPoint.z + 1
    }, this_Garage.SpawnPoint.h, function(callback_vehicle)
        ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
        cb_veh = callback_vehicle
        SetDamage(callback_vehicle, damage)
        SetVehRadioStation(callback_vehicle, "OFF")
        TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
    end)
    TriggerServerEvent(GetCurrentResourceName() .. ':setVehicleState', plate, false)
    local sendToDiscord = '' .. GetPlayerName(PlayerId()) .. ' นำพาหนะ hash = ' .. vehicle.model ..
                              ' ทะเบียน ' .. plate .. ' ออกจาก Garage '
    TriggerServerEvent('azael_discordlogs:sendToDiscord', 'GetVehicleGarage', sendToDiscord,
        GetPlayerServerId(PlayerId()), '^2')
end

function SpawnVehiclePound(vehicle, plate, damage)
    local cb_veh = nil
    ESX.Game.SpawnVehicle(vehicle.model, {
        x = this_Garage.SpawnPoint.x,
        y = this_Garage.SpawnPoint.y,
        z = this_Garage.SpawnPoint.z + 1
    }, this_Garage.SpawnPoint.h, function(callback_vehicle)
        ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
        cb_veh = callback_vehicle
        SetDamage(callback_vehicle, damage)
        SetVehRadioStation(callback_vehicle, "OFF")
        TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
    end)
    TriggerServerEvent(GetCurrentResourceName() .. ':setVehicleState', plate, false)
    local sendToDiscord = '' .. GetPlayerName(PlayerId()) .. ' นำพาหนะ hash = ' .. vehicle.model ..
                              ' ทะเบียน ' .. plate .. ' ออกจาก Garage '
    TriggerServerEvent('azael_discordlogs:sendToDiscord', 'GetVehicleGarage', sendToDiscord,
        GetPlayerServerId(PlayerId()), '^2')
end

DeleteAllCAmVehicel = function()
	for k, v in pairs(oldCars) do
		DeleteEntity(v)
		table.remove(oldCars, k)
	end
end


-- Set Damage Cars
function SetDamage(callback_vehicle, damage)
	SetVehicleEngineHealth(callback_vehicle, damage.health_engine + 0.0 or 1000.0)
	SetVehicleBodyHealth(callback_vehicle, damage.health_body + 0.0 or 1000.0)
	exports["LegacyFuel"]:SetFuel(callback_vehicle, damage.fuel + 0.0 or 1000.0)
	if damage.tyres then
		for tyreId = 1, 7, 1 do
			if damage.tyres[tyreId] ~= false then
				SetVehicleTyreBurst(callback_vehicle, tyreId, true, 1000)
			end
		end
	end

	if damage.doors then
		for doorId = 0, 5, 1 do
			if damage.doors[doorId] ~= false then
				SetVehicleDoorBroken(callback_vehicle, doorId - 1, true)
			end
		end
	end
end

-- Delete for Pounded Cars
RegisterNetEvent(GetCurrentResourceName() .. ':deletePoundCars_CL')
AddEventHandler(GetCurrentResourceName() .. ':deletePoundCars_CL', function(plates)
	SpawnPoundDelete(plates)
end)

-- Spawn Pound Delete
function SpawnPoundDelete(plate)
	for key, vehicle in pairs(ESX.Game.GetVehicles()) do
		if vehicle ~= -1 then
			local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)

			if vehicleProps.plate ~= nil then
				if vehicleProps.plate == plate then
					SetVehicleHasBeenOwnedByPlayer(vehicle, false) 
					SetEntityAsMissionEntity(vehicle, false, false) 
					DeleteVehicle(vehicle)
				end
			end
		end
    end
end

-- Save Damage Cars
function SaveDamage(vehicle, vehicleProps)
	local damage = {}
	damage.tyres = {}
	damage.doors = {}

	for id = 1, 7 do
		local tyreId = IsVehicleTyreBurst(vehicle, id, false)
	
		if tyreId then
			damage.tyres[#damage.tyres + 1] = tyreId
	
			if tyreId == false then
				tyreId = IsVehicleTyreBurst(vehicle, id, true)
				damage.tyres[ #damage.tyres] = tyreId
			end
		else
			damage.tyres[#damage.tyres + 1] = false
		end
	end
	
	for id = 0, 5 do
		local doorId = IsVehicleDoorDamaged(vehicle, id)
	
		if doorId then
			damage.doors[#damage.doors + 1] = doorId
		else
			damage.doors[#damage.doors + 1] = false
		end
	end

	damage.fuel = GetVehicleFuelLevel(vehicle)
	damage.health_engine = GetVehicleEngineHealth(vehicle)
	damage.health_body = GetVehicleBodyHealth(vehicle)
	TriggerServerEvent(GetCurrentResourceName() .. ':modifyDamage', vehicleProps.plate, damage)
end

-- Draw Markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)
		local canSleep  = true
		
		if Config.UseCarGarages == true then
			-- Car Garages
			for k,v in pairs(Config.CarGarages) do
				if (GetDistanceBetweenCoords(coords, v.GaragePoint.x, v.GaragePoint.y, v.GaragePoint.z, true) < Config.DrawDistance) then
					canSleep = false
					if IsPedInAnyVehicle(PlayerPedId(), true) == false then
						DrawMarker(Config.PointMarker.type, v.GaragePoint.x, v.GaragePoint.y, v.GaragePoint.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.PointMarker.x, Config.PointMarker.y, Config.PointMarker.z, Config.PointMarker.r, Config.PointMarker.g, Config.PointMarker.b, 100, false, true, 2, false, false, false, false)	
					else
						if v.DeletePoint then
							DrawMarker(Config.DeleteMarker.type, v.DeletePoint.x, v.DeletePoint.y, v.DeletePoint.z - 1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.DeleteMarker.x, Config.DeleteMarker.y, Config.DeleteMarker.z, Config.DeleteMarker.r, Config.DeleteMarker.g, Config.DeleteMarker.b, 100, true, false, 2, true, false, false, false)	
						end
					end
				end
			end

			if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'police' then				-- Car Pounds
				for k,v in pairs(Config.DeletePointjob) do
					if (GetDistanceBetweenCoords(coords, v.DeletePoint.x, v.DeletePoint.y, v.DeletePoint.z, true) < 10) then
						canSleep = false
						if IsPedInAnyVehicle(PlayerPedId(), true) == false then
						else
							if v.DeletePoint then
								DrawMarker(Config.MarkerDeletejob.type, v.DeletePoint.x, v.DeletePoint.y, v.DeletePoint.z - 1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerDeletejob.x, Config.MarkerDeletejob.y, Config.MarkerDeletejob.z, Config.MarkerDeletejob.r, Config.MarkerDeletejob.g, Config.MarkerDeletejob.b, 100, false, false, 2, true, false, false, false)	
							end
						end
					end
				end
			end
			if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' then				-- Car Pounds
				for k,v in pairs(Config.DeletePointjob) do
					if (GetDistanceBetweenCoords(coords, v.DeletePoint.x, v.DeletePoint.y, v.DeletePoint.z, true) < 10) then
						canSleep = false
						if IsPedInAnyVehicle(PlayerPedId(), true) == false then
						else
							if v.DeletePoint then
								DrawMarker(Config.MarkerDeletejob.type, v.DeletePoint.x, v.DeletePoint.y, v.DeletePoint.z - 1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerDeletejob.x, Config.MarkerDeletejob.y, Config.MarkerDeletejob.z, Config.MarkerDeletejob.r, Config.MarkerDeletejob.g, Config.MarkerDeletejob.b, 100, false, false, 2, true, false, false, false)	
							end
						end
					end
				end
			end
			if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'mechanic' then				-- Car Pounds
				for k,v in pairs(Config.DeletePointjob) do
					if (GetDistanceBetweenCoords(coords, v.DeletePoint.x, v.DeletePoint.y, v.DeletePoint.z, true) < 10) then
						canSleep = false
						if IsPedInAnyVehicle(PlayerPedId(), true) == false then
						else
							if v.DeletePoint then
								DrawMarker(Config.MarkerDeletejob.type, v.DeletePoint.x, v.DeletePoint.y, v.DeletePoint.z - 1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerDeletejob.x, Config.MarkerDeletejob.y, Config.MarkerDeletejob.z, Config.MarkerDeletejob.r, Config.MarkerDeletejob.g, Config.MarkerDeletejob.b, 100, false, false, 2, true, false, false, false)	
							end
						end
					end
				end
			end
			if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'council' then				-- Car Pounds
				for k,v in pairs(Config.DeletePointjob) do
					if (GetDistanceBetweenCoords(coords, v.DeletePoint.x, v.DeletePoint.y, v.DeletePoint.z, true) < 10) then
						canSleep = false
						if IsPedInAnyVehicle(PlayerPedId(), true) == false then
						else
							if v.DeletePoint then
								DrawMarker(Config.MarkerDeletejob.type, v.DeletePoint.x, v.DeletePoint.y, v.DeletePoint.z - 1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerDeletejob.x, Config.MarkerDeletejob.y, Config.MarkerDeletejob.z, Config.MarkerDeletejob.r, Config.MarkerDeletejob.g, Config.MarkerDeletejob.b, 100, false, false, 2, true, false, false, false)	
							end
						end
					end
				end
			end
			
			for k,v in pairs(Config.CarPounds) do
				if (GetDistanceBetweenCoords(coords, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, true) < Config.DrawDistance) then
					canSleep = false
					if IsPedInAnyVehicle(PlayerPedId(), true) == false then
						DrawMarker(Config.PoundMarker.type, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.PoundMarker.x, Config.PoundMarker.y, Config.PoundMarker.z, Config.PoundMarker.r, Config.PoundMarker.g, Config.PoundMarker.b, 100, false, false, 2, true, false, false, false)
					end
				end
			end
			if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' then				-- Car Pounds
				for k,v in pairs(Config.Poundsambulance) do
					if (GetDistanceBetweenCoords(coords, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, true) < 20) then
						canSleep = false
						if IsPedInAnyVehicle(PlayerPedId(), true) == false then
							DrawMarker(Config.Poundambulance.type, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Poundambulance.x, Config.Poundambulance.y, Config.Poundambulance.z, Config.Poundambulance.r, Config.Poundambulance.g, Config.Poundambulance.b, 100, false, false, 2, true, false, false, false)
						end
					end
				end
			end
			if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'police' then				-- Car Pounds
				for k,v in pairs(Config.Poundspolice) do
					if (GetDistanceBetweenCoords(coords, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, true) < 20) then
						canSleep = false
						if IsPedInAnyVehicle(PlayerPedId(), true) == false then
							DrawMarker(Config.Poundpolice.type, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Poundpolice.x, Config.Poundpolice.y, Config.Poundpolice.z, Config.Poundpolice.r, Config.Poundpolice.g, Config.Poundpolice.b, 100, false, false, 2, true, false, false, false)
						end
					end
				end
			end
			if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'mechanic' then				-- Car Pounds
				for k,v in pairs(Config.Poundsmechanic) do
					if (GetDistanceBetweenCoords(coords, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, true) < 20) then
						canSleep = false
						if IsPedInAnyVehicle(PlayerPedId(), true) == false then
							DrawMarker(Config.Poundmechanic.type, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Poundmechanic.x, Config.Poundmechanic.y, Config.Poundmechanic.z, Config.Poundmechanic.r, Config.Poundmechanic.g, Config.Poundmechanic.b, 100, false, false, 2, true, false, false, false)
						end
					end
				end
			end
			if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'council' then				-- Car Pounds
				for k,v in pairs(Config.Poundscouncil) do
					if (GetDistanceBetweenCoords(coords, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, true) < 20) then
						canSleep = false
						if IsPedInAnyVehicle(PlayerPedId(), true) == false then
							DrawMarker(Config.Poundcouncil.type, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Poundcouncil.x, Config.Poundcouncil.y, Config.Poundcouncil.z, Config.Poundcouncil.r, Config.Poundcouncil.g, Config.Poundcouncil.b, 100, false, false, 2, true, false, false, false)
						end
					end
				end
			end

			-- Boat Pounds
			for k,v in pairs(Config.BoatPounds) do
				if (GetDistanceBetweenCoords(coords, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, true) < Config.DrawDistance) then
					canSleep = false
					if IsPedInAnyVehicle(PlayerPedId(), true) == false then
						DrawMarker(Config.PoundMarker.type, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.PoundMarker.x, Config.PoundMarker.y, Config.PoundMarker.z, Config.PoundMarker.r, Config.PoundMarker.g, Config.PoundMarker.b, 100, false, true, 2, false, false, false, false)
					end
				end
			end	

			-- helicopter Pounds
			if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'council' then				-- Car Pounds
				for k,v in pairs(Config.helicopter) do
					if (GetDistanceBetweenCoords(coords, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, true) < 15) then
						canSleep = false
						if IsPedInAnyVehicle(PlayerPedId(), true) == false then
							DrawMarker(Config.helMarker.type, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.helMarker.x, Config.helMarker.y, Config.helMarker.z, Config.helMarker.r, Config.helMarker.g, Config.helMarker.b, 100, false, false, 2, true, false, false, false)
						end
					end
				end
			elseif ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' then				-- Car Pounds
				for k,v in pairs(Config.helicopter) do
					if (GetDistanceBetweenCoords(coords, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, true) < 15) then
						canSleep = false
						if IsPedInAnyVehicle(PlayerPedId(), true) == false then
							DrawMarker(Config.helMarker.type, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.helMarker.x, Config.helMarker.y, Config.helMarker.z, Config.helMarker.r, Config.helMarker.g, Config.helMarker.b, 100, false, false, 2, true, false, false, false)
						end
					end
				end
			elseif ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'police' then				-- Car Pounds
				for k,v in pairs(Config.helicopter) do
					if (GetDistanceBetweenCoords(coords, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, true) < 15) then
						canSleep = false
						if IsPedInAnyVehicle(PlayerPedId(), true) == false then
							DrawMarker(Config.helMarker.type, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.helMarker.x, Config.helMarker.y, Config.helMarker.z, Config.helMarker.r, Config.helMarker.g, Config.helMarker.b, 100, false, false, 2, true, false, false, false)
						end
					end
				end
			end
			
			for k,v in pairs(Config.CarPoundPolice) do
				if (GetDistanceBetweenCoords(coords, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, true) < Config.DrawDistance) then
					canSleep = false
					if IsPedInAnyVehicle(PlayerPedId(), true) == false then
						DrawMarker(Config.PoundNotPolice.type, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.PoundNotPolice.x, Config.PoundNotPolice.y, Config.PoundNotPolice.z, Config.PoundNotPolice.r, Config.PoundNotPolice.g, Config.PoundNotPolice.b, 100, false, false, 2, true, false, false, false)
					end
				end
			end	
		end
		
		if canSleep then
            Citizen.Wait(500)
        end
	end
end)

-- Activate Menu when in Markers
Citizen.CreateThread(function()
	local currentZone = 'garage'
	local zone = 'garage'
	while true do
		Citizen.Wait(1)
		local playerPed  = PlayerPedId()
		local coords     = GetEntityCoords(playerPed)
		local isInMarker = false
		
		if Config.UseCarGarages == true then
			-- Car Garages
			for k,v in pairs(Config.CarGarages) do
				if (GetDistanceBetweenCoords(coords, v.GaragePoint.x, v.GaragePoint.y, v.GaragePoint.z, true) < Config.PointMarker.x) and IsPedInAnyVehicle(PlayerPedId(), true) == false then
					isInMarker  = true
					this_Garage = v
					currentZone = 'car_garage_point'
				end
				
				if v.DeletePoint then
					if(GetDistanceBetweenCoords(coords, v.DeletePoint.x, v.DeletePoint.y, v.DeletePoint.z, true) < Config.DeleteMarker.x+3) and IsPedInAnyVehicle(PlayerPedId(), true) then
						isInMarker  = true
						this_Garage = v
						currentZone = 'car_store_point'
					end
				end

			end		
			-- Car Pounds
			for k,v in pairs(Config.CarPounds) do
				if (GetDistanceBetweenCoords(coords, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, true) < Config.PoundMarker.x) and IsPedInAnyVehicle(PlayerPedId(), true) == false then
					isInMarker  = true
					this_Garage = v
					currentZone = 'car_pound_point'
				end
			end
			for k,v in pairs(Config.Poundspolice) do
				if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'police' then				-- Car Pounds
					if (GetDistanceBetweenCoords(coords, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, true) < Config.PoundMarker.x) and IsPedInAnyVehicle(PlayerPedId(), true) == false then
						isInMarker  = true
						this_Garage = v
						currentZone = 'car_pound_point'
					end
				end
			end
			for k,v in pairs(Config.Poundsambulance) do
				if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' then				-- Car Pounds
					if (GetDistanceBetweenCoords(coords, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, true) < Config.PoundMarker.x) and IsPedInAnyVehicle(PlayerPedId(), true) == false then
						isInMarker  = true
						this_Garage = v
						currentZone = 'car_pound_point'
					end
				end
			end
			for k,v in pairs(Config.Poundsmechanic) do
				if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'mechanic' then				-- Car Pounds
					if (GetDistanceBetweenCoords(coords, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, true) < Config.PoundMarker.x) and IsPedInAnyVehicle(PlayerPedId(), true) == false then
						isInMarker  = true
						this_Garage = v
						currentZone = 'car_pound_point'
					end
				end
			end
			for k,v in pairs(Config.Poundscouncil) do
				if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'council' then				-- Car Pounds
					if (GetDistanceBetweenCoords(coords, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, true) < Config.PoundMarker.x) and IsPedInAnyVehicle(PlayerPedId(), true) == false then
						isInMarker  = true
						this_Garage = v
						currentZone = 'car_pound_point'
					end
				end
			end

			-- Boat Pounds
			for k,v in pairs(Config.BoatPounds) do
				if (GetDistanceBetweenCoords(coords, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, true) < Config.PoundMarker.x) and IsPedInAnyVehicle(PlayerPedId(), true) == false then
					isInMarker  = true
					this_Garage = v
					currentZone = 'boat_pound_point'
				end
			end

			-- Pounds helicopter
			for k,v in pairs(Config.helicopter) do
				if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'police' then				-- Car Pounds
					if (GetDistanceBetweenCoords(coords, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, true) < Config.PoundMarker.x) and IsPedInAnyVehicle(PlayerPedId(), true) == false then
						isInMarker  = true
						this_Garage = v
						currentZone = 'helicopter_pound_point'
					end
				end
				if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' then				-- Car Pounds
					if (GetDistanceBetweenCoords(coords, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, true) < Config.PoundMarker.x) and IsPedInAnyVehicle(PlayerPedId(), true) == false then
						isInMarker  = true
						this_Garage = v
						currentZone = 'helicopter_pound_point'
					end
				end
				if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'council' then				-- Car Pounds
					if (GetDistanceBetweenCoords(coords, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, true) < Config.PoundMarker.x) and IsPedInAnyVehicle(PlayerPedId(), true) == false then
						isInMarker  = true
						this_Garage = v
						currentZone = 'helicopter_pound_point'
					end
				end
			end
			
			-- police car pound
			for k,v in pairs(Config.CarPoundPolice) do
				if (GetDistanceBetweenCoords(coords, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, true) < Config.PoundMarker.x) and IsPedInAnyVehicle(PlayerPedId(), true) == false then
					isInMarker  = true
					this_Garage = v
					currentZone = 'car_pound_police'
				end
			end

			for k,v in pairs(Config.DeletePointjob) do -- เก็บรถหน่วยงาน
				if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'police' then				-- Car Pounds
					if v.DeletePoint then
						if(GetDistanceBetweenCoords(coords, v.DeletePoint.x, v.DeletePoint.y, v.DeletePoint.z, true) < Config.DeleteMarker.x+3) and IsPedInAnyVehicle(PlayerPedId(), true) then
							isInMarker  = true
							this_Garage = v
							currentZone = 'car_store_point'
						end
					end
				end
				if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' then				-- Car Pounds
					if v.DeletePoint then
						if(GetDistanceBetweenCoords(coords, v.DeletePoint.x, v.DeletePoint.y, v.DeletePoint.z, true) < Config.DeleteMarker.x+3) and IsPedInAnyVehicle(PlayerPedId(), true) then
							isInMarker  = true
							this_Garage = v
							currentZone = 'car_store_point'
						end
					end
				end
				if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'mechanic' then				-- Car Pounds
					if v.DeletePoint then
						if(GetDistanceBetweenCoords(coords, v.DeletePoint.x, v.DeletePoint.y, v.DeletePoint.z, true) < Config.DeleteMarker.x+3) and IsPedInAnyVehicle(PlayerPedId(), true) then
							isInMarker  = true
							this_Garage = v
							currentZone = 'car_store_point'
						end
					end
				end
				if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'council' then				-- Car Pounds
					if v.DeletePoint then
						if(GetDistanceBetweenCoords(coords, v.DeletePoint.x, v.DeletePoint.y, v.DeletePoint.z, true) < Config.DeleteMarker.x+3) and IsPedInAnyVehicle(PlayerPedId(), true) then
							isInMarker  = true
							this_Garage = v
							currentZone = 'car_store_point'
						end
					end
				end
			end


		end
		
		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
			LastZone                = currentZone
			zone 					= currentZone

			if zone == 'car_garage_point' then
				CurrentAction     = 'car_garage_point'
				CurrentActionMsg  = _U('press_to_enter')
				CurrentActionData = {}
			elseif zone == 'car_store_point' then
				CurrentAction     = 'car_store_point'
				CurrentActionMsg  = _U('press_to_delete')
				CurrentActionData = {}
			elseif zone == 'car_pound_point' then
				CurrentAction     = 'car_pound_point'
				CurrentActionMsg  = _U('press_to_impound')
				CurrentActionData = {}
			elseif zone == 'boat_pound_point' then
				CurrentAction     = 'boat_pound_point'
				CurrentActionMsg  = _U('press_to_impound_car')
				CurrentActionData = {}
			elseif zone == 'helicopter_pound_point' then
				CurrentAction     = 'helicopter_pound_point'
				CurrentActionMsg  = _U('press_to_impound_helicopter')
				CurrentActionData = {}
			elseif zone == 'car_pound_police' then
				CurrentAction     = 'car_pound_police'
				-- CurrentActionMsg  = 'Press To Impound Helicopter'
				CurrentActionMsg  = _U('press_to_impound_notpolice')

				CurrentActionData = {}
			end
		end
		
		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false		
			ESX.UI.Menu.CloseAll()
			CurrentAction = nil
		end
		
		if not isInMarker then

            Citizen.Wait(500)
        end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		
		if CurrentAction ~= nil then
			exports["Fewthz_TextUI"]:ShowHelpNotification(CurrentActionMsg)
			
			if IsControlJustReleased(0, Keys['E']) then
				if CurrentAction == 'car_garage_point' then
					ListOwnedCarsMenu()
				elseif CurrentAction == 'car_store_point' then
					StoreOwnedCarsMenu()
				elseif CurrentAction == 'car_pound_point' then
					ReturnOwnedCarsMenu()
				elseif CurrentAction == 'boat_pound_point' then
					ReturnOwnedBoatMenu()
				elseif CurrentAction == 'helicopter_pound_point' then
					helicoptermenu()
				elseif CurrentAction == 'car_pound_police' then
					ReturnPoliceOwnedCarsMenu()
				end
				
				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)

-- Blips
function deleteBlips()
	if JobBlips[1] ~= nil then
		for i=1, #JobBlips, 1 do
			RemoveBlip(JobBlips[i])
			JobBlips[i] = nil
		end
	end
end

--Citizen.CreateThread(function()
function refreshBlips()
	local blipList = {}
	local JobBlips = {}

	if Config.UseCarGarages == true then
		-- Car Garages
		for k,v in pairs(Config.CarGarages) do
			if v.Blips then
				table.insert(blipList, {
					coords = { v.GaragePoint.x, v.GaragePoint.y },
					text   = ('<font face="sarabun"> การาจเบิกรถ </font>'),
					sprite = Config.BlipGarage.Sprite,
					color  = Config.BlipGarage.Color,
					scale  = Config.BlipGarage.Scale
				})
			end
		end
		
		-- Car Pounds
		for k,v in pairs(Config.CarPounds) do
			if v.Blips then
				table.insert(blipList, {
					coords = { v.PoundPoint.x, v.PoundPoint.y },
					text   =('<font face="sarabun"> การาจพาวรถ </font>'),
					sprite = Config.BlipPound.Sprite,
					color  = Config.BlipPound.Color,
					scale  = Config.BlipPound.Scale
				})
			end
		end

		-- Boat Pounds
		for k,v in pairs(Config.BoatPounds) do
			if v.Blips then
				table.insert(blipList, {
					coords = { v.PoundPoint.x, v.PoundPoint.y },
					text   =('<font face="sarabun"> การาจพาวเรือ </font>'),
					sprite = Config.BlipBoatPounds.Sprite,
					color  = Config.BlipBoatPounds.Color,
					scale  = Config.BlipBoatPounds.Scale
				})
			end	
		end	
		
		for k,v in pairs(Config.helicopter) do
			if v.Blips then
				table.insert(blipList, {
					coords = { v.PoundPoint.x, v.PoundPoint.y },
					text   =('<font face="sarabun"> พาวเฮลิคอปเตอร์ </font>'),
					sprite = Config.BlipPound.Sprite,
					color  = Config.BlipPound.Color,
					scale  = Config.BlipPound.Scale
				})
			end	
		end	

		for k,v in pairs(Config.CarPoundPolice) do
			if v.Blips then
				table.insert(blipList, {
					coords = { v.PoundPoint.x, v.PoundPoint.y },
					text   =('<font face="sarabun"> พาวรถจากตำรวจยึด </font>'),
					sprite = Config.BlipPolice.Sprite,
					color  = Config.BlipPolice.Color,
					scale  = Config.BlipPolice.Scale
				})
			end
		end		

	end

	for i=1, #blipList, 1 do
		CreateBlip(blipList[i].coords, blipList[i].text, blipList[i].sprite, blipList[i].color,blipList[i].scale)
	end
end

function CreateBlip(coords, text, sprite, color, scale)
	local blip = AddBlipForCoord( table.unpack(coords) )

	SetBlipSprite(blip, sprite)
	SetBlipScale(blip, scale)
	SetBlipColour(blip, color)

	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandSetBlipName(blip)
	table.insert(JobBlips, blip)
end

local entityEnumerator = {
	__gc = function(enum)
	  if enum.destructor and enum.handle then
		enum.destructor(enum.handle)
	  end
	  enum.destructor = nil
	  enum.handle = nil
	end
}
  
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
  
function EnumerateObjects()
	return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function EnumeratePeds()
	return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnumeratePickups()
	return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end

RegisterNUICallback('focusOff', function(data, cb)
	SetNuiFocus(false, false)
end)

RegisterNUICallback('garage', function(data, cb)
	ESX.TriggerServerCallback(GetCurrentResourceName() .. ':getOwnedCars', function(ownedCars)
		if #ownedCars == 0 then
			exports['okokNotify']:Alert("แจ้งเตือน", "คุณไม่มีรถอยู่ในการาจ", 5000, 'error')
		else
			for _, v in pairs(ownedCars) do
				local cb_veh = nil
				local hashVehicule = json.decode(v.vehicle).model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = GetLabelText(aheadVehName)
				local labelvehicle
				local fuelpersen = json.decode(v.health_vehicles).fuel
				local plate = v.plate
				if data.item == json.decode(v.vehicle).plate then
					SpawnVehicle(json.decode(v.vehicle) , v.plate, json.decode(v.health_vehicles))
					--TriggerEvent("xzero_trunk:garageopentrunk", hashVehicule, plate)
					Citizen.Wait(50)
					--HandleCam()
					Hanluehe = true
					-- Citizen.Wait(Config.CheckCarLength * 1000)
					Hanluehe = false
					ClearPedTasks(ped)
				end	
			end
		end
	end)
end)

RegisterNUICallback('helicopter', function(data, cb)
	ESX.TriggerServerCallback(GetCurrentResourceName() .. ':getOutOwnedhelicopter', function(ownedCars)
		if #ownedCars == 0 then
			exports['okokNotify']:Alert("แจ้งเตือน", "คุณไม่มีรถอยู่ในการาจ", 5000, 'error')
		else
			for _,v in pairs(ownedCars) do
				local hashVehicule = json.decode(v.vehicle).model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = GetLabelText(aheadVehName)
				local labelvehicle
				local plate = v.plate
				local hasEnoughMoney = exports["Fewthz_Check"]:Money()
				if hasEnoughMoney > Config.halPoundPrice then
						if not status then
							if data.item == json.decode(v.vehicle).plate then
								TriggerServerEvent(GetCurrentResourceName() .. ':payCar', Config.halPoundPrice)
								TriggerServerEvent(GetCurrentResourceName() .. ':deletePoundCars_SV', v.plate)
								-- Config.SpawnPoundWait()

								--if Config.RepairWhenPounded then
								--	Citizen.Wait(50)
								--	SpawnVehicle2(json.decode(v.vehicle), v.plate)
								--	Citizen.Wait(50)
									--HandleCam()
								--	Hanluehe = true
									-- Citizen.Wait(Config.CheckCarLength * 1000)
								--	Hanluehe = false
								--	ClearPedTasks(ped)
								--else
									exports['mythic_progbar']:Progress({
										name = "unique_action_name",
										duration = 5000,
										label = 'กำลังเรียกยานพาหนะ...',
										useWhileDead = true,
										canCancel = false,
										controlDisables = {
											disableMovement = true,
											disableCarMovement = true,
											disableMouse = false,
											disableCombat = true,
										},
									}, function(cancelled)
										if not cancelled then
										end
									end)
									Citizen.Wait(500)
									SpawnVehicle(json.decode(v.vehicle) , v.plate, json.decode(v.health_vehicles))
									Citizen.Wait(50)
									--HandleCam()
									Hanluehe = true
									-- Citizen.Wait(Config.CheckCarLength * 1000)
									Hanluehe = false
									ClearPedTasks(ped)
								--end
								
							end
						end
				else
					ESX.ShowNotification('คุณไม่มีเงินเพียงพอ', 'error', 3000)	
				end
			end
		end
	end)
end)

RegisterNUICallback('boat', function(data, cb)
	ESX.TriggerServerCallback(GetCurrentResourceName() .. ':getOutOwnedBoat', function(ownedCars)
		if #ownedCars == 0 then
			exports['okokNotify']:Alert("แจ้งเตือน", "คุณไม่มีรถอยู่ในการาจ", 5000, 'error')
		else
			for _,v in pairs(ownedCars) do
				local hashVehicule = json.decode(v.vehicle).model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = GetLabelText(aheadVehName)
				local labelvehicle
				local plate = v.plate
				
				local hasEnoughMoney = exports["Fewthz_Check"]:Money()
				if hasEnoughMoney > Config.BoatPoundPrice then
						if not status then
							if data.item == json.decode(v.vehicle).plate then
								TriggerServerEvent(GetCurrentResourceName() .. ':payCar', Config.BoatPoundPrice)
								TriggerServerEvent(GetCurrentResourceName() .. ':deletePoundCars_SV', v.plate)
								exports['mythic_progbar']:Progress({
									name = "unique_action_name",
									duration = 5000,
									label = 'กำลังเรียกยานพาหนะ...',
									useWhileDead = true,
									canCancel = false,
									controlDisables = {
										disableMovement = true,
										disableCarMovement = true,
										disableMouse = false,
										disableCombat = true,
									},
								}, function(cancelled)
									if not cancelled then
									end
								end)
								Citizen.Wait(5000)
								SpawnVehicle(json.decode(v.vehicle), v.plate, json.decode(v.health_vehicles))
								Citizen.Wait(50)
								--HandleCam()
								Hanluehe = true
								-- Citizen.Wait(Config.CheckCarLength * 1000)
								Hanluehe = false
								ClearPedTasks(ped)
								
							end
						end
				else
					ESX.ShowNotification('คุณไม่มีเงินเพียงพอ', 'error', 3000)	
				end
			end
		end
	end)
end)

RegisterNUICallback('police', function(data, cb)
	ESX.TriggerServerCallback(GetCurrentResourceName() .. ':getOutOwnedCarsNonpolice', function(ownedCars)
		if #ownedCars == 0 then
			exports['okokNotify']:Alert("แจ้งเตือน", "คุณไม่มีรถอยู่ในการาจ", 5000, 'error')
		else
			for _,v in pairs(ownedCars) do

				local hashVehicule = json.decode(v.vehicle).model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				print(aheadVehName)
				local vehicleName = GetLabelText(aheadVehName)
				local labelvehicle
				local plate = v.plate
				if data.item == json.decode(v.vehicle).plate then
					TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(PlayerId()), 'society_police', 'เบิกรถยึดโดยไม่มีตำรวจ', Config.billngPolice)
					Wait(1000)
					TriggerServerEvent(GetCurrentResourceName()  .. ':deletePoundCars_SV', v.plate)
					exports['mythic_progbar']:Progress({
						name = "unique_action_name",
						duration = 5000,
						label = 'กำลังเรียกยานพาหนะ...',
						useWhileDead = true,
						canCancel = false,
						controlDisables = {
							disableMovement = true,
							disableCarMovement = true,
							disableMouse = false,
							disableCombat = true,
						},
					}, function(cancelled)
						if not cancelled then
						end
					end)
					Citizen.Wait(5000)
					SpawnVehiclePolice(json.decode(v.vehicle), v.plate, json.decode(v.health_vehicles))
					Citizen.Wait(50)
					--HandleCam()
					Hanluehe = true
					-- Citizen.Wait(Config.CheckCarLength * 1000)
					Hanluehe = false
					ClearPedTasks(ped)
				end
			end
		end
	end)
end)

RegisterNUICallback('pound', function(data, cb)
	ESX.TriggerServerCallback(GetCurrentResourceName() .. ':getOutOwnedCars', function(ownedCars)
		if #ownedCars == 0 then
			exports['okokNotify']:Alert("แจ้งเตือน", "คุณไม่มีรถอยู่ในการาจ", 5000, 'error')
		else
			for _,v in pairs(ownedCars) do
				local hashVehicule = json.decode(v.vehicle).model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = GetLabelText(aheadVehName)
				local labelvehicle
				local plate = v.plate
				if data.item == json.decode(v.vehicle).plate then
					TriggerServerEvent(GetCurrentResourceName() .. ':payCar', Config.CarPoundPrice )
					TriggerServerEvent(GetCurrentResourceName() .. ':deletePoundCars_SV', v.plate)
					exports['mythic_progbar']:Progress({
						name = "unique_action_name",
						duration = 5000,
						label = 'กำลังเรียกยานพาหนะ...',
						useWhileDead = true,
						canCancel = false,
						controlDisables = {
							disableMovement = true,
							disableCarMovement = true,
							disableMouse = false,
							disableCombat = true,
						},
					}, function(cancelled)
						if not cancelled then
						end
					end)
					Citizen.Wait(5000)
					-- ESX.ShowNotification('~y~Wait For ~g~1 ~y~Second To Pound Cars')
					Citizen.Wait(50)
					SpawnVehicle(json.decode(v.vehicle), v.plate, json.decode(v.health_vehicles))
					Citizen.Wait(50)
					--HandleCam()
					Hanluehe = true
					-- Citizen.Wait(Config.CheckCarLength * 1000)
					Hanluehe = false
					ClearPedTasks(ped)
				end
			end
		end
	end)
end)