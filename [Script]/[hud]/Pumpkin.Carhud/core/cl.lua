local isInVehicle = false
local seatbeltOn = false

Citizen.CreateThread(function()
    Wait(1000)
    while true do
        local veh = GetVehiclePedIsIn(PlayerPedId())
        if veh ~= 0 and not isInVehicle then
            startLoopSeatbelt()
            startLoopSendData()
        end
        Wait(500)
    end
end)

startLoopSendData = function()
    isInVehicle = true
    SendNUIMessage({ action = "open" })

    Citizen.CreateThread(function()
        while isInVehicle do
            local ped = PlayerPedId()
            local veh = GetVehiclePedIsIn(ped)

            if veh ~= 0 then
                local vehData = {}
                vehData.fuel = math.floor(GetVehicleFuelLevel(veh))
                vehData.speed = math.floor(GetEntitySpeed(veh) * 3.6)
                vehData.rpm = math.floor(GetVehicleCurrentRpm(veh) * 105)
                vehData.engine = math.floor(GetVehicleEngineHealth(veh) / 10)
                vehData.gear = GetVehicleCurrentGear(veh)
                vehData.type = getVehType2NUI(GetVehicleClass(veh))
                vehData.wheel1 = getVehWheelStatus2NUI(veh, 0)
                vehData.wheel2 = getVehWheelStatus2NUI(veh, 1)
                vehData.wheel3 = getVehWheelStatus2NUI(veh, 4)
                vehData.wheel4 = getVehWheelStatus2NUI(veh, 5)
                vehData.pauseMenu = IsPauseMenuActive()
                vehData.isBelt = seatbeltOn
                vehData.isLocked = GetVehicleDoorLockStatus(veh)
                vehData.steering = GetVehicleSteeringAngle(veh)
                vehData.car = IsCar2(veh)
                vehData.IsCar = IsCar(veh)
                
                SendNUIMessage({
                    action = "update",
                    data = vehData
                })
            else
                SendNUIMessage({ action = "close" })
                isInVehicle = false
            end

            Wait(10)
        end
    end)
end

----------------------------------
--          CHECK CAR           --
----------------------------------

function IsCar2(vehicle)
    local vc = GetVehicleClass(vehicle)
    if (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20) then
        return "car"
    elseif (vc == 8) then
        return "motorcycles"
    elseif (vc == 14) then
        return "boat"
    elseif (vc == 13) then
        return "bike"
    elseif (vc == 15 or vc == 16) then
        return "Helicopters"
    end
end	

function IsCar(veh)
    local vc = GetVehicleClass(veh)
    return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20)
end	

----------------------------------
--         SEND DATA2UI         --
----------------------------------
getVehType2NUI = function(class)
    if (class == 8) then
        return 1
    elseif (class == 13) then
        return 4
    elseif (class == 15 or class == 16) then
        return 2
    elseif (class == 14) then
        return 3
    else 
        return 0
    end
end
getVehWheelStatus2NUI = function(veh, wheel)
    if IsVehicleTyreBurst(veh, wheel, true) then
        return 2
    elseif IsVehicleTyreBurst(veh, wheel, false) then
        return 1
    else
        return 0
    end
end

----------------------------------
--          BELT SYSTEM         --
----------------------------------
startLoopSeatbelt = function()
    seatbeltOn = false
    SetFlyThroughWindscreenParams(Config["Belt"]["ejectVelocity"], Config["Belt"]["ejectVelocity"] + 10.0, 17.0, Config["Belt"]["minDamage"])

    Citizen.CreateThread(function()
        while isInVehicle do
            Citizen.Wait(10)
            if IsPedInAnyVehicle(PlayerPedId()) then
                if seatbeltOn then
                    DisableControlAction(0, 75, true)
                    DisableControlAction(27, 75, true)
                end
            end
        end
    end)
end

toggleSeatbelt = function()
    seatbeltOn = not seatbeltOn
    if not seatbeltOn then
        SetFlyThroughWindscreenParams(Config["Belt"]["ejectVelocity"], Config["Belt"]["ejectVelocity"] + 10.0, 17.0, Config["Belt"]["minDamage"])
        SendNUIMessage({ action="playSound", sound="unbuckle.ogg", volume=0.4 })
        exports['mythic_notify']:SendAlert('error', 'ถอดเข็มขัด เรียบร้อย !')

    else
        SetFlyThroughWindscreenParams(10000.0, 10000.0, 17.0, 0.0);
        SendNUIMessage({ action="playSound", sound="buckle.ogg", volume=0.4 })
        exports['mythic_notify']:SendAlert('success', 'รัดเข็มขัด เรียบร้อย !')
    end
end

RegisterKeyMapping("toggleseatbelt", "Toggle Seatbelt", "keyboard", Config["Belt"]["Key"])
RegisterCommand("toggleseatbelt", function()
    if IsPedInAnyVehicle(PlayerPedId(), false) then
        local class = GetVehicleClass(GetVehiclePedIsIn(PlayerPedId()))
        if class ~= 8 and class ~= 13 and class ~= 14 then
            toggleSeatbelt()
        end
    end
end)

-- ===================================================================================

local openpanel = false
RegisterKeyMapping('open_menu_mycar', 'Open Menu Car', 'keyboard', 'G')	
RegisterCommand('open_menu_mycar', function()
    if not openpanel and IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
        openpanel = true
        SetNuiFocus(true,true)
        SendNUIMessage({
            action = 'panel',
        })
        checkpanel()
    end
end)

RegisterNUICallback('NUIFocusOff', function()
    openpanel = false
    SetNuiFocus(false,false)
end)

function checkpanel()
    Wait(1000)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    SendNUIMessage({
        action = 'panel-status',
        frontHood = GetVehicleDoorAngleRatio(vehicle, 4) > 0.0,
        windowFrontLeft = not windowState1,
        doorFrontLeft = GetVehicleDoorAngleRatio(vehicle, 0) > 0.0,
        seatFrontLeft = GetPedInVehicleSeat(vehicle, -1) > 0.0,
        seatFrontRight = GetPedInVehicleSeat(vehicle, 0) > 0.0,
        doorFrontRight = GetVehicleDoorAngleRatio(vehicle, 1) > 0.0,
        windowFrontRight = not windowState2,
        interiorLight = IsVehicleInteriorLightOn(vehicle),
        rearHood = GetVehicleDoorAngleRatio(vehicle, 5) > 0.0,
        windowRearLeft = not windowState3,
        doorRearLeft = GetVehicleDoorAngleRatio(vehicle, 2) > 0.0,
        seatRearLeft = GetPedInVehicleSeat(vehicle, 1) > 0.0,
        seatRearRight = GetPedInVehicleSeat(vehicle, 2) > 0.0,
        doorRearRight = GetVehicleDoorAngleRatio(vehicle, 3) > 0.0,
        windowRearRight = not windowState4,
        rearHood2 = GetVehicleDoorAngleRatio(vehicle, 6) > 0.0,
        ignition = GetIsVehicleEngineRunning(vehicle),
    })
end

RegisterNUICallback('ignition', function()
    EngineControl()
    checkpanel()
end)

RegisterNUICallback('interiorLight', function()
	InteriorLightControl()
    checkpanel()
end)

RegisterNUICallback('doors', function(data, cb)
	DoorControl(data.door)
    checkpanel()
end)

RegisterNUICallback('seatchange', function(data, cb)
	SeatControl(data.seat)
    checkpanel()
end)

RegisterNUICallback('windows', function(data, cb)
	WindowControl(data.window, data.door)
    checkpanel()
end)

function EngineControl()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if vehicle ~= nil and vehicle ~= 0 and GetPedInVehicleSeat(vehicle, 0) then
        SetVehicleEngineOn(vehicle, (not GetIsVehicleEngineRunning(vehicle)), false, true)
    end
end

function InteriorLightControl()
	local playerPed = GetPlayerPed(-1)
	if (IsPedSittingInAnyVehicle(playerPed)) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		if IsVehicleInteriorLightOn(vehicle) then
			SetVehicleInteriorlight(vehicle, false)
		else
			SetVehicleInteriorlight(vehicle, true)
		end
	end
end

function DoorControl(door)
	local playerPed = GetPlayerPed(-1)
	if (IsPedSittingInAnyVehicle(playerPed)) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		if GetVehicleDoorAngleRatio(vehicle, door) > 0.0 then
			SetVehicleDoorShut(vehicle, door, false)
		else
			SetVehicleDoorOpen(vehicle, door, false)
		end
	end
end

function SeatControl(seat)
	local playerPed = GetPlayerPed(-1)
	if (IsPedSittingInAnyVehicle(playerPed)) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		if IsVehicleSeatFree(vehicle, seat) then
			SetPedIntoVehicle(GetPlayerPed(-1), vehicle, seat)
		end
	end
end

function WindowControl(window, door)
	local playerPed = GetPlayerPed(-1)
	if (IsPedSittingInAnyVehicle(playerPed)) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		if window == 0 then
			if windowState1 == true and DoesVehicleHaveDoor(vehicle, door) then
				RollDownWindow(vehicle, window)
				windowState1 = false
			else
				RollUpWindow(vehicle, window)
				windowState1 = true
			end
		elseif window == 1 then
			if windowState2 == true and DoesVehicleHaveDoor(vehicle, door) then
				RollDownWindow(vehicle, window)
				windowState2 = false
			else
				RollUpWindow(vehicle, window)
				windowState2 = true
			end
		elseif window == 2 then
			if windowState3 == true and DoesVehicleHaveDoor(vehicle, door) then
				RollDownWindow(vehicle, window)
				windowState3 = false
			else
				RollUpWindow(vehicle, window)
				windowState3 = true
			end
		elseif window == 3 then
			if windowState4 == true and DoesVehicleHaveDoor(vehicle, door) then
				RollDownWindow(vehicle, window)
				windowState4 = false
			else
				RollUpWindow(vehicle, window)
				windowState4 = true
			end
		end
	end
end