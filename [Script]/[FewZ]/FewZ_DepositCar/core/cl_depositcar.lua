local CurrentActionMsg        = ''
local ESX    			 	  = nil
local LastZone                = nil
local CurrentAction           = nil
local DepositKey              = nil
local openedvehicle 		  = nil
local HasAlreadyEnteredMarker = false
local PlayerData 			  = {}
local JobBlips 				  = {}
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

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if CurrentAction ~= nil then

			exports["Fewthz_TextUI"]:ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, Keys['E']) then
                if CurrentAction == 'car_garage_point_deposit' then
                    StoreOwnedCarsMenu(DepositKey)
                elseif CurrentAction == 'car_garage_point_undeposit' then
                    ListOwnedCarsMenu(DepositKey)
                end
			end
		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	local currentZone = 'garage'
	local zone = 'garage'
	while true do
		Citizen.Wait(1)
		local playerPed  = PlayerPedId()
		local coords     = GetEntityCoords(playerPed)
		local isInMarker = false
		
		if Config.DepositCarGarages == true then
			for k,v in pairs(Config.DepositCar) do
				if (GetDistanceBetweenCoords(coords, v.DepositPoint.x, v.DepositPoint.y, v.DepositPoint.z, true) < Config.DepositMarker.x) and IsPedInAnyVehicle(PlayerPedId(), true) then
					isInMarker  = true
					this_Garage = v
					currentZone = 'car_garage_point_deposit'
				end
				
				if v.UnDepositPoint then
					if(GetDistanceBetweenCoords(coords, v.UnDepositPoint.x, v.UnDepositPoint.y, v.UnDepositPoint.z, true) < Config.UnDepositMarker.x) and IsPedInAnyVehicle(PlayerPedId(), true) == false then 
						isInMarker  = true
						this_Garage = v
						currentZone = 'car_garage_point_undeposit'
                        DepositKey = v.key
					end
				end
			end
		end
		
		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
			LastZone                = currentZone
			zone 					= currentZone
			if zone == 'car_garage_point_deposit' then
				CurrentAction     = 'car_garage_point_deposit'
				CurrentActionMsg  = "กด ~INPUT_CONTEXT~ เพื่อฝากรถ"
				CurrentActionData = {}
			elseif zone == 'car_garage_point_undeposit' then
				CurrentAction     = 'car_garage_point_undeposit'
				CurrentActionMsg  = "กด ~INPUT_CONTEXT~ เพื่อเบิกรถ"
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

Citizen.CreateThread(function()
	for k,v in pairs(Config.DepositCar) do
        for k2,v2 in pairs(v.NPC) do
			RequestModel(GetHashKey(v2.ModelName))
			while not HasModelLoaded(GetHashKey(v2.ModelName)) do
				Wait(1)
			end
			ped =  CreatePed(4, GetHashKey(v2.ModelHash) , v.UnDepositPoint.x, v.UnDepositPoint.y, v.UnDepositPoint.z - 1, false, false, true)
			SetEntityHeading(ped, v2.heading)
			FreezeEntityPosition(ped, true)
			SetEntityInvincible(ped, true)
			SetBlockingOfNonTemporaryEvents(ped, true)
			TaskPlayAnim(ped, v2.AnimDictionary, v2.AnimationName, 8.0, 0.0, -1, 1, 0, 0, 0, 0)
		end
	end
	while true do
		Citizen.Wait(1)
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)
		local canSleep  = true
		if Config.DepositCarGarages == true then
			for k,v in pairs(Config.DepositCar) do
				if (GetDistanceBetweenCoords(coords, v.DepositPoint.x, v.DepositPoint.y, v.DepositPoint.z, true) < Config.DrawDistance) then
					canSleep = false
					if IsPedInAnyVehicle(PlayerPedId(), true) == 1 then
						DrawMarker(Config.DepositMarker.type, v.DepositPoint.x, v.DepositPoint.y, v.DepositPoint.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.DepositMarker.x, Config.DepositMarker.y, Config.DepositMarker.z, Config.DepositMarker.r, Config.DepositMarker.g, Config.DepositMarker.b, 100, false, true, 2, false, false, false, false)	
					end
				end
			end
			for k,v in pairs(Config.DepositCar) do
				if v.UnDepositPoint then
					if (GetDistanceBetweenCoords(coords, v.UnDepositPoint.x, v.UnDepositPoint.y, v.UnDepositPoint.z, true) < 10) then
						canSleep = false
						if IsPedInAnyVehicle(PlayerPedId(), true) == false then
							if Config.Control.Open then
								DrawText3D(v.UnDepositPoint.x, v.UnDepositPoint.y, v.UnDepositPoint.z+1.0, "<FONT FACE = 'font4thai'>"..Config.Control.Text)
							else
								DrawMarker(Config.UnDepositMarker.type, v.UnDepositPoint.x, v.UnDepositPoint.y, v.UnDepositPoint.z - 1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.UnDepositMarker.x, Config.UnDepositMarker.y, Config.UnDepositMarker.z, Config.UnDepositMarker.r, Config.UnDepositMarker.g, Config.UnDepositMarker.b, 100, false, true, 2, false, false, false, false)
							end
						end
					end
				end
			end
        end
		if canSleep then
            Citizen.Wait(1000)
        end
	end
end)

function ListOwnedCarsMenu(deposit_key)
	local elements = {}
	ESX.TriggerServerCallback(GetCurrentResourceName() .. ':getOwnedCarsDeposit', function(ownedCars)
		if #ownedCars == 0 then
			ESX.ShowNotification('You dont own any Cars!')
		else
			for _,v in pairs(ownedCars) do
				local hashVehicule = json.decode(v.vehicle).model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local labelfuel = 0
				local plate = v.plate
				local kuys = json.decode(v.health_vehicles)
				if kuys then
					labelfuel = Round(kuys.fuel,1)
				end
				local props = json.decode(v.vehicle)
				local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(props.model))
				if vehicleName == 'NULL' then
					vehicleName = 'Mod car'
				end
				local labelvehicle = ('%s - <span style="color:#001bbe;">%s</span> : '):format(vehicleName, props.plate)
				if v.stored ~= 1 then
					labelvehicle = labelvehicle .. ('<span style="color:#001bbe;" class="green-text">พร้อมใช้งาน</span><span style="color:#4F9EC4;" class="green-text">| น้ำมัน : '..labelfuel..'%</span>')
				else
					labelvehicle = labelvehicle .. ('<span style="color:#001bbe;" class="red-text">%s</span>') : format('ไม่พร้อมใช้งาน')
				end
				if v.police ~= 0 then
					labelvehicle = labelvehicle .. ('<span style="color:#001bbe;" class="red-text">%s</span>') : format('รถคันนี้ถูกยึด')
				end
				table.insert(elements, {label = labelvehicle, vehicle = json.decode(v.vehicle), stored = v.stored, plate = v.plate, damage = json.decode(v.health_vehicles)})
			end
		end
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_owned_car_deposit', {
			title    = 'รถที่ฝากไว้ #'..deposit_key..'',
			align    = 'center',
			elements = elements
		}, function(data, menu)
			if data.current.stored ~= 1 then
				menu.close()

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_owned_car_action', {
					title	= "ระบบฝากรถ",
					align	= 'center',
					elements = {
						{ label = "เบิกรถ", value = "spawn", },
						{ label = "เปิดท้ายรถ", value = "opentrunk", },
					},
				}, function(data2, menu2)
					if data2.current.value == "spawn" then
						menu2.close()
						SpawnVehicle(data.current.vehicle, data.current.plate, data.current.damage)
					elseif data2.current.value == "opentrunk" then
						openedvehicle = CreateInvisible(data.current.vehicle)
                        Config["TRUNK_EVENT"](openedvehicle)
						menu2.close()
					end
				end, function(data2, menu2)
					menu2.close()
				end)

			else
				TriggerEvent("pNotify:SendNotification", {
					text = "รถคันนี้ไม่พร้อมใช้งาน",
					type = "info",
					timeout = 3000,
					layout = "centerRight",
					queue = "global"
				})
			end
		end, function(data, menu)
			menu.close()
		end)
	end, deposit_key)
end

function CreateInvisible(props)
    RequestModel(props.model)
    repeat Wait(0) until HasModelLoaded(props.model)
	local vehicle = CreateVehicle(props.model, GetEntityCoords(PlayerPedId()), 0.0, false, false)
    ESX.Game.SetVehicleProperties(vehicle, props)
    SetEntityVisible(vehicle, false, 0)
	SetVehicleIsConsideredByPlayer(vehicle, false)
	SetEntityCollision(vehicle, false, false)
	return vehicle
end

function SpawnVehicle(vehicle, plate, damage)
	local cb_veh = nil
	Config["Progbar"]()
	ESX.Game.SpawnVehicle(vehicle.model, {
		x = this_Garage.SpawnDepositPoint.x,
		y = this_Garage.SpawnDepositPoint.y,
		z = this_Garage.SpawnDepositPoint.z + 1
	}, this_Garage.SpawnDepositPoint.h, function(callback_vehicle)
		ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
		cb_veh = callback_vehicle
		SetDamage(callback_vehicle, damage)
		SetVehRadioStation(callback_vehicle, "OFF")
		TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
	end)

	TriggerServerEvent(GetCurrentResourceName() .. ':setDepositVehicleState', plate, false)
    TriggerServerEvent(GetCurrentResourceName() .. ':setDepositVehicleDepositCar', plate, nil)

	Wait(500)
	SetVehicleFuelLevel(cb_veh, damage.fuel)
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
	TriggerServerEvent(GetCurrentResourceName() .. ':modifyDepositDamage', vehicleProps.plate, damage)
end


-- Store Owned Cars Menu
function StoreOwnedCarsMenu(DepositKey)
	local playerPed  = GetPlayerPed(-1)
	local vehicle =	GetVehiclePedIsIn(playerPed, false)
	local DSMSS = GetVehiclePedIsIn(playerPed, false)
	local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
	
	ESX.TriggerServerCallback(GetCurrentResourceName() .. ':UndepositstoreVehicle',function(valid)
		if(valid) then
			SaveDamage(vehicle, vehicleProps)
			DeleteEntity(vehicle)
			TriggerServerEvent(GetCurrentResourceName() .. ':setDepositVehicleState', vehicleProps.plate, 99)
			TriggerServerEvent(GetCurrentResourceName() .. ':setDepositVehicleDepositCar', vehicleProps.plate, DepositKey)
			
            TriggerEvent("pNotify:SendNotification", {
				text = "ฝากพาหนะของคุณเรียบร้อย",
				type = "info",
				timeout = 3000,
				layout = "centerRight",
				queue = "global"
			})
		else
			TriggerEvent("pNotify:SendNotification", {
				text = "คุณไม่สามารถฝากยานพาหนะนี้ได้ เนื่องจากคุณไม่ใช่เจ้าของ",
				type = "info",
				timeout = 3000,
				layout = "centerRight",
				queue = "global"
			})
		end
	end, vehicleProps)
end


function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.45, 0.45)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end

function deleteBlips()
	if JobBlips[1] ~= nil then
		for i=1, #JobBlips, 1 do
			RemoveBlip(JobBlips[i])
			JobBlips[i] = nil
		end
	end
end

function refreshBlips()
	local blipList = {}
	local JobBlips = {}
	if Config.DepositCarGarages == true then
		for k,v in pairs(Config.DepositCar) do
			if v.Blips then
				table.insert(blipList, {
					coords = { v.DepositPoint.x, v.DepositPoint.y },
					text   = Config.DepositCarBlip,
					sprite = Config.BlipDepositCar.Sprite,
					color  = Config.BlipDepositCar.Color,
					scale  = Config.BlipDepositCar.Scale
				})
			end
		end
	end
	for i=1, #blipList, 1 do
		CreateBlip(blipList[i].coords, blipList[i].text, blipList[i].sprite, blipList[i].color, 0.6)
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