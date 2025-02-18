ESX = exports["es_extended"]:getSharedObject()

Citizen.CreateThread(function()
	while true do
		local sleepThread = 500
		local player = PlayerPedId()
		if IsPedInAnyVehicle(player, false) then
			local vehicle = GetVehiclePedIsIn(player, false)
			local CarModel = GetEntityModel(vehicle)
			local driver = GetPedInVehicleSeat(vehicle, -1)
			if driver == player then
				sleepThread = 0
				local displaytext = GetDisplayNameFromVehicleModel(CarModel)
				for k, v in pairs(Config['limitCar']) do
					if displaytext == k then
						SetVehicleMaxSpeed(vehicle, (v.Speed/3.6)) 
					end
				end
			end
		end
		Citizen.Wait(sleepThread)
	end
end)

