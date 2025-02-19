Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded',function(xPlayer)
    ESX.PlayerData = xPlayer
end)

Citizen.CreateThread(function()
	while true do		
        local sleep = 1000
		local coords      = GetEntityCoords(PlayerPedId())

		for k,v in pairs(Config) do
            if v.Enable then
                if (GetDistanceBetweenCoords(coords, v.Coords, true) < v.SeeMarker) then
                    local PedVeh = GetVehiclePedIsIn(PlayerPedId(),false)
                    if PedVeh ~= 0 then
                        sleep = 0
                        DrawMarker(28, v.Coords.x,  v.Coords.y,  v.Coords.z-1 , 0.0,0.0,0.0, 0.0,0.0,0.0, v.Distance, v.Distance, v.Distance, v.Color.r, v.Color.g, v.Color.b, v.Color.a, 0, 0, 0, 0, 0, 0, 0)
                    end
                end
                if (GetDistanceBetweenCoords(coords, v.Coords, true) < v.Distance) then
                    local PedVeh = GetVehiclePedIsIn(PlayerPedId(),false)                   
                    if PedVeh ~= 0 then
                        sleep = 0
                        local playerPed    = GetPlayerPed(-1)
                        local vehicleProps = ESX.Game.GetVehicleProperties(PedVeh)
                        
                        ESX.TriggerServerCallback('lnwza_StoreVehicle:storeVehicle', function(valid)
                            if valid then
                                SaveDamage(PedVeh, vehicleProps)
                                DeleteEntity(PedVeh)
                                TriggerServerEvent('lnwza_StoreVehicle:setVehicleState', vehicleProps.plate, true)
                                exports.pNotify:SendNotification({
                                    text = "เก็บพาหนะทะเบียน "..vehicleProps.plate.."  เรียบร้อยแล้ว",
                                    type = "success",
                                    queue = "gta",
                                    timeout = 5000,
                                    layout = "bottomCenter"
                                })
                            else
                                local vehCoords = GetEntityCoords(PedVeh)
                                local forward = GetEntityForwardVector(PedVeh)
                                SetEntityCoords(PedVeh, (vehCoords.x-(forward.x*5)), (vehCoords.y-(forward.y*5)), vehCoords.z-1)
                                exports.pNotify:SendNotification({
                                    text = "ไม่สามารถเก็บรถได้ เนื่องจากคุณไม่ใช่เจ้าของ",
                                    type = "error",
                                    queue = "gta",
                                    timeout = 5000,
                                    layout = "bottomCenter"
                                })
                            end
                        end, vehicleProps)
                        sleep = 100
                    end
                end
            end
		end
        Citizen.Wait(sleep)
	end
end)

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

	damage.fuel = exports["esx_legacyfuel"]:GetFuel(vehicle)
	damage.health_engine = GetVehicleEngineHealth(vehicle)
	damage.health_body = GetVehicleBodyHealth(vehicle)
	TriggerServerEvent('lnwza_StoreVehicle:SaveDamage', vehicleProps.plate, damage)
end

Citizen.CreateThread(function()
    Citizen.Wait(1000)
print("^1" ..GetCurrentResourceName().. " ^0Resource Verified : ^2Success !! ^0")
end)