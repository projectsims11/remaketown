local ClearNpc = {}
local DepositKey  = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)
AddEventHandler('onResourceStop', function(z)
    if z ~= GetCurrentResourceName() then return end
    if ClearNpc then
        for j, _ in pairs(ClearNpc) do
            DeleteEntity(j)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local coords    = GetEntityCoords(playerPed)
        local canSleep  = true
        for k, v in pairs(Config.Position) do
            if IsPedInAnyVehicle(PlayerPedId(), true) == 1 then
                if (GetDistanceBetweenCoords(coords, v.StoreVehicle.Pos.x, v.StoreVehicle.Pos.y, v.StoreVehicle.Pos.z,true) < v.StoreVehicle.DrawMark.Radius + 50) then
                    canSleep = false
                    DrawMarker(v.StoreVehicle.DrawMark.Type, v.StoreVehicle.Pos.x, v.StoreVehicle.Pos.y,
                        v.StoreVehicle.Pos.z - 1.0001, 0, 0, 0, 0,
                        0, 0, v.StoreVehicle.DrawMark.Radius, v.StoreVehicle.DrawMark.Radius,
                        v.StoreVehicle.DrawMark.Radius,
                        v.StoreVehicle.DrawMark.R, v.StoreVehicle.DrawMark.G, v.StoreVehicle.DrawMark.B,
                        v.StoreVehicle.DrawMark.Bold, 0, 0, 2, 0, 0, 0, 0)
                    DrawMarker(v.LeaveVehicle.DrawMark.Type, v.LeaveVehicle.Pos.x, v.LeaveVehicle.Pos.y,
                        v.LeaveVehicle.Pos.z - 1.0001, 0, 0, 0, 0,
                        0, 0, v.LeaveVehicle.DrawMark.Radius, v.LeaveVehicle.DrawMark.Radius,
                        v.LeaveVehicle.DrawMark.Radius,
                        v.LeaveVehicle.DrawMark.R, v.LeaveVehicle.DrawMark.G, v.LeaveVehicle.DrawMark.B,
                        v.LeaveVehicle.DrawMark.Bold, 0, 0, 2, 0, 0, 0, 0)
                end
                if (GetDistanceBetweenCoords(coords, v.StoreVehicle.Pos.x, v.StoreVehicle.Pos.y, v.StoreVehicle.Pos.z,true) < v.StoreVehicle.DrawMark.Radius) then
                    canSleep = false
                   
                    if IsControlJustReleased(0, 38) then
                        StoreVehicle(k)
                    end
                    exports["Fewthz_TextUI"]:ShowHelpNotification("Press ~INPUT_CONTEXT~ Store car")
                end
                if (GetDistanceBetweenCoords(coords, v.LeaveVehicle.Pos.x, v.LeaveVehicle.Pos.y, v.LeaveVehicle.Pos.z,true) < v.LeaveVehicle.DrawMark.Radius) then
                    canSleep = true
                    local veh = GetVehiclePedIsIn(playerPed)
                    TaskLeaveVehicle(playerPed, veh)
					StoreVehicle(k)
                end
            end
        end
        if canSleep then 
			Citizen.Wait(1000) 
		end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local coords    = GetEntityCoords(playerPed)
        local canSleep  = true
        for k, v in pairs(Config.Position) do
            if (GetDistanceBetweenCoords(coords, v.OpenTrunk.Pos.x, v.OpenTrunk.Pos.y, v.OpenTrunk.Pos.z, true) < v.OpenTrunk.Distance) then
                canSleep = false
                exports["Fewthz_TextUI"]:ShowHelpNotification("Press ~INPUT_CONTEXT~ Car Trunk Menu")
                if IsControlJustReleased(0, 38) then
                    if IsPedInAnyVehicle(PlayerPedId(), true) ~= 1 then
                        ListOwnedCarsMenu(k,v.SpawnPoint)
                    end
                end
            end
        end
        if canSleep then Citizen.Wait(1000) end
    end
end)

Citizen.CreateThread(function()
    for _, v in pairs(Config.Position) do
        RequestModel(v.OpenTrunk.Model)
        while not HasModelLoaded(v.OpenTrunk.Model) do
            Wait(100)
        end
        local obj = CreatePed(4, GetHashKey(v.OpenTrunk.Model), v.OpenTrunk.Pos.x, v.OpenTrunk.Pos.y, v.OpenTrunk.Pos.z -
            1, v.OpenTrunk.Heading, false, true)
        SetEntityHeading(obj, v.OpenTrunk.Heading)
        FreezeEntityPosition(obj, true)
        SetEntityInvincible(obj, true)
        SetBlockingOfNonTemporaryEvents(obj, true)
        ClearNpc[obj] = obj
    end
end)

function ListOwnedCarsMenu(deposit_key, position)
	local elements = {}
	ESX.TriggerServerCallback(GetCurrentResourceName() .. ':getOwnedCarsDeposit', function(ownedCars)

			for _,v in pairs(ownedCars) do
				local hashVehicule = json.decode(v.vehicle).model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local fuelpersen = json.decode(v.health_vehicles).fuel
                local labelfuel = tostring(math.ceil(GetVehicleFuelLevel(fuelpersen)))
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
				local labelvehicle = ('%s - <span style="color:#FFB447;">%s</span> : '):format(vehicleName, props.plate)
				if v.stored == false then
					labelvehicle = labelvehicle .. ('<span style="color:#90C796;" class="green-text">พร้อมใช้งาน</span>')
				end
				table.insert(elements, {label = labelvehicle, vehicle = json.decode(v.vehicle), stored = v.stored, plate = v.plate, damage = json.decode(v.health_vehicles)})
			end

		ESX.UI.Menu.Open('default', 'd', 'vehicle', {
			title    = 'รถที่ฝากไว้ #'..deposit_key..'',
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
            if data.current.vehicle then
                ESX.UI.Menu.CloseAll()
                local packmenu = {
                    { label = "เรียกรถคืน", value = 'restore_vehicle', plate = data.current.plate, vehicle = data.current.vehicle, damage = data.current.damage },
                    { label = "เปิดท้ายรถ", value = 'trunk_vehicle', plate = data.current.plate, vehicle = data.current.vehicle, damage = data.current.damage }
                }
                local check = true
                ESX.UI.Menu.Open('default', 'z', 'vehicle_garage1',
                    {
                        title    = "เมนู",
                        align    = 'center',
                        elements = packmenu,
                    }, function(data, menu)
                        if data.current.value == "trunk_vehicle" then
                            opentrunknow = InvisibleCar(data.current.vehicle)
                            TriggerEvent("xzero_trunk:CL:On_OpenInventoryMobile",  opentrunknow)
							print('เปิดหลังรถ ทะเบียน ' ..data.current.plate .. ' ที่ ' ..deposit_key)
							-- exports.nc_discordlogs:Discord({
							-- 	webhook = 'farmzonetrunk',
							-- 	title = 'ฝากรถ',
							-- 	description = 'เปิดหลังรถ ทะเบียน ' ..data.current.plate .. ' ที่ ' ..deposit_key,
							-- 	color = 'fff',
							-- 	screenshot = true
							-- })
                            ESX.UI.Menu.CloseAll()
                        else
                            if check then
                                check = false
                                SpawnVehicle(data.current.vehicle, data.current.plate, data.current.damage, position , deposit_key)
                                ESX.UI.Menu.CloseAll()
                            end
                        end
                    end, function(data, menu)
                        ESX.UI.Menu.CloseAll()
                end)
            end
		end, function(data, menu)
			menu.close()
		end)
	end, deposit_key)
end

InvisibleCar = function(data)
    RequestModel(data.model)
    repeat Wait(0) until HasModelLoaded(data.model)
    local vehicle = CreateVehicle(data.model, GetEntityCoords(PlayerPedId()), 0.0, false, false)
    ESX.Game.SetVehicleProperties(vehicle, data)
    SetEntityVisible(vehicle, false, 0)
    SetVehicleIsConsideredByPlayer(vehicle, false)
    SetEntityCollision(vehicle, false, false)
    return vehicle
end



local maxViewingDistance = 50.0 -- Define the maximum distance to see the markers

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        --local playerCoords = GetEntityCoords(playerPed)
		local playerCoords, canSleep = GetEntityCoords(PlayerPedId()), true

        for _, v in pairs(Config.Position) do
            local distance = #(playerCoords - vector3(v.OpenTrunk.Pos.x, v.OpenTrunk.Pos.y, v.OpenTrunk.Pos.z))

            if distance <= maxViewingDistance then
				canSleep = false
                DrawMarker(36, v.OpenTrunk.Pos.x, v.OpenTrunk.Pos.y, v.OpenTrunk.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 100, 197, 215, 255, false, false, 2, true, false, false, false)
            end
        end
		if canSleep then
			Wait(500)
		end
    end
end)


function StoreVehicle(DepositKey)
	local playerPed  = GetPlayerPed(-1)
	local vehicle =	GetVehiclePedIsIn(playerPed, false)
	local DSMSS = GetVehiclePedIsIn(playerPed, false)
	local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
	
	ESX.TriggerServerCallback(GetCurrentResourceName() .. ':UndepositstoreVehicle',function(valid)
		if(valid) then
			ESX.TriggerServerCallback(GetCurrentResourceName() .. ':checkMoneyUndeposit', function(hasEnoughMoney)
				if hasEnoughMoney then
					print('เบิกรถ ทะเบียน ' ..vehicleProps.plate .. ' ที่ ' ..DepositKey)
					-- exports.nc_discordlogs:Discord({
					-- 	webhook = 'farmzonestore',
					-- 	title = 'ฝากรถ',
					-- 	description = 'เบิกรถ ทะเบียน ' ..vehicleProps.plate .. ' ที่ ' ..DepositKey,
					-- 	color = 'fff',
					-- 	screenshot = true
					-- })

					SaveDamage(vehicle, vehicleProps)
					DeleteEntity(vehicle)
					TriggerServerEvent(GetCurrentResourceName() .. ':RemoveMoney', Config.Money)
					TriggerServerEvent(GetCurrentResourceName() .. ':setDepositVehicleState', vehicleProps.plate, 99)
					TriggerServerEvent(GetCurrentResourceName() .. ':setDepositVehicleDepositCar', vehicleProps.plate, DepositKey)
                    TriggerEvent("pNotify:SendNotification", {
						text = "  ฝากพาหนะของคุณเรียบร้อย ",
						type = "info",
						timeout = 3000,
						layout = "centerRight",
						queue = "global"
					})
				else
					TriggerEvent("pNotify:SendNotification", {
						text = "  เงินของคุณไม่เพียงพอ ",
						type = "info",
						timeout = 3000,
						layout = "centerRight",
						queue = "global"
					})
				end
			end, Config.Money)
		else
			local vehCoords = GetEntityCoords(vehicle)
			local forward = GetEntityForwardVector(vehicle)
			SetEntityCoords(vehicle, (vehCoords.x-(forward.x*1)), (vehCoords.y-(forward.y*1)), vehCoords.z-1)
			TriggerEvent("pNotify:SendNotification", {
				text = "  คุณไม่สามารถฝากยานพาหนะนี้ได้ เนื่องจากคุณไม่ใช่เจ้าของ ",
				type = "info",
				timeout = 3000,
				layout = "centerRight",
				queue = "global"
			})
		end
	end, vehicleProps)
end

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

function SpawnVehicle(vehicle, plate, damage, position , DepositKey)
	local cb_veh = nil
	ESX.Game.SpawnVehicle(vehicle.model, {
		x = position.x,
		y = position.y,
		z = position.z + 1
	}, position.h, function(callback_vehicle)
		print('ฝากรถ ทะเบียน ' ..plate .. ' ที่ ' ..DepositKey)
	-- exports.nc_discordlogs:Discord({
	-- 	webhook = 'farmzonespawn',
	-- 	title = 'ฝากรถ',
	-- 	description = 'เบิกรถ ทะเบียน ' ..plate .. ' ที่ ' ..DepositKey,
	-- 	color = 'fff',
	-- 	screenshot = true
	-- })
		ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
		cb_veh = callback_vehicle
		SetDamage(callback_vehicle, damage)
		SetVehRadioStation(callback_vehicle, "OFF")
		TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
	end)

	TriggerServerEvent(GetCurrentResourceName() .. ':setDepositVehicleState', plate, false)
    TriggerServerEvent(GetCurrentResourceName() .. ':setDepositVehicleDepositCar', plate, nil)

	Wait(500)
	print("damage.fuel = ",damage.fuel)
	-- SetVehicleFuelLevel(cb_veh, damage.fuel or 1000)
	SetVehicleFuelLevel(cb_veh, damage.fuel)
	DecorSetFloat(cb_veh, '_FUEL_LEVEL', GetVehicleFuelLevel(cb_veh))

end

SetDamage = function(callback_vehicle, damage)
	SetVehicleEngineHealth(callback_vehicle, damage.health_engine + 0.0 or 1000.0)
	SetVehicleBodyHealth(callback_vehicle, damage.health_body + 0.0 or 1000.0)
	SetVehicleFuelLevel(cb_veh, damage.fuel)
	DecorSetFloat(cb_veh, '_FUEL_LEVEL', GetVehicleFuelLevel(cb_veh))
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



AddEventHandler("Zion_Core:ClearMemoryCl", function()
    Citizen.CreateThread(function()
        local rdm = math.random(100, 2000)
        Wait(rdm)
        collectgarbage()
    end)
  end)
