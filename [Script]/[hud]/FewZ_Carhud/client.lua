Fuel = 0

local isUiOpen = false 
local speedBuffer  = {}
local velBuffer    = {}
local beltOn       = false
local wasInCar     = false
local alertbelt	   = true
local beltAlarm = true

IsCar = function(veh)
    local vc = GetVehicleClass(veh)
    return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20)
end 

Fwv = function (entity)
    local hr = GetEntityHeading(entity) + 90.0
    if hr < 0.0 then
        hr = 360.0 + hr 
    end
    hr = hr * 0.0174533
    return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
end

GetCarTypeToNui = function(veh)
	local vc = GetVehicleClass(veh)
	if vc == 8 then
		return 'moto'
	elseif vc == 14 then
		return 'boat'
	elseif vc == 16 then
		return 'air'
	elseif vc == 15 then
		return 'hall'
	else
		return 'car'
	end
end


Citizen.CreateThread(function()
	while true do 
		Wait(0) 
		if IsNuiFocused() then 
			DisableControlAction(0, 1, true)
			DisableControlAction(0, 2, true)
			DisableControlAction(0, 3, true)
			DisableControlAction(0, 4, true)
			DisableControlAction(0, 5, true)
			DisableControlAction(0, 6, true)

			DisableControlAction(0, 24, true)
			DisableControlAction(0, 64, true)

			if IsPedInAnyVehicle(PlayerPedId(), true) then 
				DisableControlAction(0, 85, true)
			end

			DisableControlAction(0, 200, true)

			DisableControlAction(0, 257, true)
			DisableControlAction(0, 346, true)
		else
			Wait(300)
		end
	end

end)

local Timestep = 1000
local cars
Citizen.CreateThread(function()
	while true do 
		Wait(500) 
		if GetVehiclePedIsIn(PlayerPedId()) ~= 0 then
			cars = GetVehiclePedIsIn(PlayerPedId())
			Timestep = 5			
		else
			cars = GetVehiclePedIsIn(PlayerPedId())
			Timestep = 1000	
		end
	end
end)

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(Timestep) 
		
		if (wasInCar or IsCar(cars)) then
			if isUiOpen == false and not IsPlayerDead(PlayerId()) and not beltOn then
				SendNUIMessage({
					type = 'carhud',
					belt = true
				})
				isUiOpen = true
			end
			
			if beltOn then 
				DisableControlAction(0, 75, true)  -- Disable exit vehicle when stop
				DisableControlAction(27, 75, true) -- Disable exit vehicle when Driving
			end

			speedBuffer[2] = speedBuffer[1]
			speedBuffer[1] = GetEntitySpeed(cars)


		
			if speedBuffer[2] ~= nil 
				and not beltOn
				and GetEntitySpeedVector(cars, true).y > 1.0  
				and speedBuffer[1] > 19.25 
				and (speedBuffer[2] - speedBuffer[1]) > (speedBuffer[1] * 0.255) then
				
				local co = GetEntityCoords(PlayerPedId())
				local fw = Fwv(PlayerPedId())
				SetEntityCoords(PlayerPedId(), co.x + fw.x, co.y + fw.y, co.z - 0.47, true, true, true)
				SetEntityVelocity(PlayerPedId(), velBuffer[2].x, velBuffer[2].y, velBuffer[2].z)
				Citizen.Wait(1)
				SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
			end
			
			velBuffer[2] = velBuffer[1]
			velBuffer[1] = GetEntityVelocity(cars)

				if IsControlJustReleased(0, 305) then
					beltOn = not beltOn 
					if beltOn then
						alertbelt = false
						SendNUIMessage({
							type = 'carhud',
							beltSound = true
						})
						Wait(500)
						  TriggerEvent("mythic_notify:client:SendAlert",{
							    text = '<strong class="red-text">SeatBelt Connected</strong> ',
							    type = "success",
							    timeout = 1000,
							}) 
						SendNUIMessage({
							type = 'carhud',
							belt = false
						})
						isUiOpen = true 
						
					else 
						TriggerEvent("mythic_notify:client:SendAlert",{
							text = '<strong class="red-text">SeatBelt Disonnected</strong> ',
							type = "error",
							timeout = 1000,
						}) 
						
						SendNUIMessage({
							type = 'carhud',
							belt = true
						})
						sUiOpen = true
						Citizen.Wait(2000)
						alertbelt = true
					end
				end
		
		elseif wasInCar then
			wasInCar = false
			beltOn = false
			speedBuffer[1], speedBuffer[2] = 0.0, 0.0
				if isUiOpen == true and not IsPlayerDead(PlayerPedId()) then
					SendNUIMessage({
						type = 'carhud',
						belt = false
					})
					isUiOpen = false 
				end
		end

  	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3000)
		local ped = PlayerPedId()
		local car = GetVehiclePedIsIn(ped)
		if beltOn ==false and IsPedInAnyVehicle(PlayerPedId(), false) and alertbelt and (wasInCar or IsCar(car)) then
			Wait(1500)
			SendNUIMessage({
				type = 'carhud',
				belt = 'alert'
			})
		end
	end
end)


local counter = 0
local Mph = GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(), false)) * 2.236936
local Fuel = 0.0
local uiopen = false
local Gear = 0
local locakstatus = 0



local hide = false

Citizen.CreateThread(function()
    while true do
		local sleep = 500
		

		if not hide then
			local player = PlayerPedId()
			local x, y, z = table.unpack(GetEntityCoords(player, true))
			if IsPedInAnyVehicle(player, false) then
				sleep = 30
				SetPedConfigFlag(PlayerPedId(), 35, false)
				if IsVehicleEngineOn(GetVehiclePedIsIn(player, false)) then          
					
					if not uiopen then
						uiopen = true
						SendNUIMessage({
							type = 'carhud',
							displayCarhud = true
						})
					end
					local playerPed = PlayerPedId()
					local vehicle = GetVehiclePedIsIn(playerPed, false)
					local currentFuel = GetVehicleFuelLevel(vehicle)
					local cuhealthvehicle = GetVehicleEngineHealth(vehicle)
				
					healthvehicle = cuhealthvehicle / 10
					Fuel = currentFuel
					Gear = GetVehicleCurrentGear(vehicle)

					RPM = GetVehicleCurrentRpm(vehicle)
					if not GetIsVehicleEngineRunning(vehicle) then RPM = 0 end
					if RPM > 0.2 then
						RPM = RPM * 100
						RPM = RPM + math.random(-2, 2)
						RPM = RPM / 100
					end
					RPM = RPM*7000
					
					local l1, l2, l3 = GetVehicleLightsState(vehicle)
					Mph = math.ceil(GetEntitySpeed(GetVehiclePedIsIn(player, false)) * 3.6 )
					locakstatus = GetVehicleDoorLockStatus(vehicle)
					SendNUIMessage({
						type = 'carhud',
						kmh = Mph,
						gear = Gear,
						rpm = round(RPM / 1000),
						rpmPercent = round(RPM / 75),
						light = getLight(l2, l3),
						fuel = math.ceil(Fuel),
						doorlock = locakstatus,
						carfix = healthvehicle,
						wheel_fl = IsVehicleTyreBurst(vehicle, 0, false),
						wheel_fr = IsVehicleTyreBurst(vehicle, 1, false),
						wheel_bl = IsVehicleTyreBurst(vehicle, 4, false),
						wheel_br = IsVehicleTyreBurst(vehicle, 5, false),
						cartype = GetCarTypeToNui(vehicle),
						engine = true
					})
				else
					
					SendNUIMessage({
						type = 'carhud',
						engine = false
					})
 
				end
			else
				if uiopen then
						SendNUIMessage({
							type = 'carhud',
							belt = true
						})
						alertbelt = true
						beltOn = false 
					SendNUIMessage({
						type = 'carhud',
						displayCarhud = false,
					})
					closeVehControl()
					
					uiopen = false
				end
			end

		end
		Citizen.Wait(sleep)
			
    end
end)

getLight = function(n, n2)
	if n == 0 then
		return n2
	else
		return n
	end
end

function round(x)
	return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
end


function drawTxt(x, y, width, height, scale, text, r, g, b, a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

local isInVehControl = false

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(0)
		if IsPedInAnyVehicle(PlayerPedId(), false) then
			if ( IsControlJustReleased( 0, 84 ) or IsDisabledControlJustReleased( 0, 84 ) ) and GetLastInputMethod( 0 ) then
				if not isInVehControl then
					openVehControl()
				else
					closeVehControl()
				end
			end
		else
			Citizen.Wait(500)
		end
    end
end)

function openVehControl()
	isInVehControl = true
	SetNuiFocusKeepInput(true)
	SetNuiFocus(true, true)
	SendNUIMessage({
		type = 'menucar',
		displayMenucar = true
	})
end

function closeVehControl()
	SetNuiFocus(false, false)
	SetNuiFocusKeepInput(false)
	
	SendNUIMessage({
		type = 'menucar',
		displayMenucar = false
	})
	Wait(3000)
	isInVehControl = false
end

RegisterNUICallback('closemenu', function(data, cb)
	isInVehControl = false
	SetNuiFocus(false, false)
	SendNUIMessage({
		type = 'menucar',
		displayMenucar = false
	})
	cb("ok")
end)

RegisterNUICallback('closemenux', function(data, cb)
	isInVehControl = false
	SetNuiFocus(false, false)
	cb("ok")
end)

RegisterNUICallback('menuget', function(data, cb)
    if data.name == 'door' then
		DoorControl(data.num)
	elseif data.name == 'engine' then
		EngineControl()
	elseif data.name == 'chair' then
		SeatControl(data.num)
	end
	cb("ok")
end)

CreateThread(function()
	Wait(1000)
	SendNUIMessage({
		displayPlayer = true
	})
end)

--[[ SEAT SHUFFLE ]]--
--[[ BY JAF ]]--

local actionkey=21 --Lshift (or whatever your sprint key is bound to)
local allowshuffle = false
local playerped=nil
local currentvehicle=nil

--getting vars
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(200)
		--constantly getting the current 
		playerped=PlayerPedId()
		--constantly get player vehicle
		currentvehicle=GetVehiclePedIsIn(playerped, false)
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		if IsPedInAnyVehicle(playerped, false) and allowshuffle == false then
			--if they're trying to shuffle for whatever reason
			SetPedConfigFlag(playerped, 184, true)
			if GetIsTaskActive(playerped, 165) then
				--getting seat player is in 
				seat=0
				if GetPedInVehicleSeat(currentvehicle, -1) == playerped then
					seat=-1
				end
				--if the passenger doesn't shut the door, shut it manually
				--if GetVehicleDoorAngleRatio(currentvehicle,1) > 0.0 and seat == 0 then
					--SetVehicleDoorShut(currentvehicle,1,false)
				--end
				--move ped back into the seat right as the animation starts
				SetPedIntoVehicle(playerped, currentvehicle, seat)
			end
		elseif IsPedInAnyVehicle(playerped, false) and allowshuffle == true then
			SetPedConfigFlag(playerped, 184, false)
		end
	end
end)


function EngineControl()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if vehicle ~= nil and vehicle ~= 0 and GetPedInVehicleSeat(vehicle, 0) then
        SetVehicleEngineOn(vehicle, (not GetIsVehicleEngineRunning(vehicle)), false, true)
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
