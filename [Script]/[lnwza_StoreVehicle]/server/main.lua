TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('lnwza_StoreVehicle:storeVehicle', function (source, cb, vehicleProps)
	local ownedCars = {}
	local vehplate = vehicleProps.plate:match("^%s*(.-)%s*$")
	local vehiclemodel = vehicleProps.model
	local xPlayer = ESX.GetPlayerFromId(source)
	
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate', {
		['@owner'] = xPlayer.identifier,
		['@plate'] = vehicleProps.plate
	}, function (result)
		if result[1] ~= nil then
				MySQL.Async.execute('UPDATE owned_vehicles SET vehicle = @vehicle WHERE owner = @owner AND plate = @plate', {
					['@owner']  = GetPlayerIdentifiers(source)[1],
					['@vehicle'] = json.encode(vehicleProps),
					['@plate']  = vehicleProps.plate
				}, function (rowsChanged)
					cb(true)
				end)
		else
			cb(false)
		end
	end)
end)

RegisterServerEvent('lnwza_StoreVehicle:setVehicleState')
AddEventHandler('lnwza_StoreVehicle:setVehicleState', function(plate, state)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE owned_vehicles SET stored = @stored WHERE plate = @plate', {
		['@stored'] = state,
		['@plate'] = plate
	}, function(rowsChanged)
	end)
end)

RegisterServerEvent('lnwza_StoreVehicle:SaveDamage')
AddEventHandler('lnwza_StoreVehicle:SaveDamage', function(plate, damage)
	local plate = plate
	local health = json.encode(damage)

	MySQL.Async.execute("UPDATE `owned_vehicles` SET `health_vehicles` = @health WHERE `plate`=@plate", {
		['@plate'] = plate,
		['@health'] = health
	})
end)

Citizen.CreateThread(function()
    Citizen.Wait(1000)
print("^1" ..GetCurrentResourceName().. " ^0Resource Verified : ^2Success !! ^0")
end)