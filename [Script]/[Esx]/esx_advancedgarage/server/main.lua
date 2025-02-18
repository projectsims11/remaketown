ESX                	= nil
PoundList = {}
PoundListAllow = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand('carrestored', function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getGroup() == 'admin' then
		ParkVehicles()
	end
end)

-- Make sure all Vehicles are Stored on restart
function ParkVehicles()
	MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = true WHERE `stored` = @stored', {
		['@stored'] = false
	}, function(rowsChanged)
		if rowsChanged > 0 then
			print(('esx_advancedgarage: %s vehicle(s) have been stored!'):format(rowsChanged))
		end
	end)
end

-- Fetch Owned Cars
ESX.RegisterServerCallback(GetCurrentResourceName() .. ':getOwnedCars', function(source, cb)
	local ownedCars = {}

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND Type = @Type AND stored = @stored', {
		['@owner']  = GetPlayerIdentifiers(source)[1],
		['@Type']   = 'car',
		['@stored'] = true
	}, function(data)
		for _,v in pairs(data) do
			table.insert(ownedCars, v)
		end
		cb(ownedCars)
	end)
end)

-- Store Vehicles
ESX.RegisterServerCallback(GetCurrentResourceName() .. ':storeVehicle', function (source, cb, vehicleProps)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local vehplate = vehicleProps.plate
	local vehiclemodel = vehicleProps.model

	MySQL.Async.fetchAll("SELECT * FROM `owned_vehicles` where `plate`=@plate and `owner`=@identifier",{
		['@plate'] = vehplate, 
		['@identifier'] = xPlayer.identifier
	}, function(result)  
		if result[1] ~= nil then
			local veh = json.decode(result[1].vehicle)
			if veh.model == vehiclemodel then
				local vehprop = json.encode(vehicleProps)
				MySQL.Async.execute("UPDATE `owned_vehicles` SET `vehicle`=@vehprop WHERE plate=@plate",{
					['@vehprop'] = vehprop, 
					['@plate'] = vehplate
				})
				cb(true)
			end	
		else
			cb(false)
		end
	end)
end)

-- Fetch Pounded Cars
ESX.RegisterServerCallback(GetCurrentResourceName() .. ':getOutOwnedCars', function(source, cb)
	local ownedCars = {}

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND Type = @Type AND stored = @stored AND police = 0', {
		['@owner']  = GetPlayerIdentifiers(source)[1],
		['@Type']   = 'car',
		['@stored'] = false
	}, function(data)
		for _,v in pairs(data) do
			table.insert(ownedCars, v)
		end
		cb(ownedCars)
	end)
end)

-- @Fetch Pound Police Car
ESX.RegisterServerCallback(GetCurrentResourceName() .. ':getOutOwnedCarsNonpolice', function(source, cb)
	local ownedCars = {}
	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = @owner AND Type = @Type AND job = @job  AND police = @police", {
		["@owner"] = GetPlayerIdentifiers(source)[1],
		["@Type"] = "car",
		["@job"] = "",
		["@police"] = 1,
	}, function(data) 
		for _,v in pairs(data) do
			table.insert(ownedCars, v)
		end
		cb(ownedCars)
	end)
end)

-- Fetch Pounded Boat
ESX.RegisterServerCallback(GetCurrentResourceName() .. ':getOutOwnedBoat', function(source, cb)
	local ownedBoat = {}

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND Type = @Type AND stored = @stored AND police = 0', {
		['@owner']  = GetPlayerIdentifiers(source)[1],
		['@Type']   = 'boat',
		['@stored'] = false
	}, function(data)
		for _,v in pairs(data) do
			table.insert(ownedBoat, v)
		end
		cb(ownedBoat)
	end)
end)

-- Fetch helicopter Boat
ESX.RegisterServerCallback(GetCurrentResourceName() .. ':getOutOwnedhelicopter', function(source, cb)
	local ownedBoat = {}

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND Type = @Type AND stored = @stored AND police = 0', {
		['@owner']  = GetPlayerIdentifiers(source)[1],
		['@Type']   = 'helicopter',
		['@stored'] = false
	}, function(data)
		for _,v in pairs(data) do
			table.insert(ownedBoat, v)
		end
		cb(ownedBoat)
	end)
end)

-- Pay for Pounded Cars
RegisterServerEvent(GetCurrentResourceName() .. ':payCar')
AddEventHandler(GetCurrentResourceName() .. ':payCar', function(priceS)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeMoney(priceS)
end)

-- Delete for Pounded Cars
RegisterServerEvent(GetCurrentResourceName() .. ':deletePoundCars_SV')
AddEventHandler(GetCurrentResourceName() .. ':deletePoundCars_SV', function(plates)
	TriggerClientEvent(GetCurrentResourceName() .. ':deletePoundCars_CL', -1, plates)
end)

-- Modift Damage Of Vehicles
RegisterServerEvent(GetCurrentResourceName() .. ':modifyDamage')
AddEventHandler(GetCurrentResourceName() .. ':modifyDamage', function(plate, damage)
	local plate = plate
	local health = json.encode(damage)

	MySQL.Async.execute("UPDATE `owned_vehicles` SET `health_vehicles` = @health WHERE `plate`=@plate", {
		['@plate'] = plate,
		['@health'] = health
	})
end)

-- Modify State of Vehicles
RegisterServerEvent(GetCurrentResourceName() .. ':setVehicleState')
AddEventHandler(GetCurrentResourceName() .. ':setVehicleState', function(plate, state)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE owned_vehicles SET stored = @stored WHERE plate = @plate', {
		['@stored'] = state,
		['@plate'] = plate
	}, function(rowsChanged)
		if rowsChanged == 0 then
			print((GetCurrentResourceName() .. ': %s exploited the garage!'):format(xPlayer.identifier))
		end
	end)
end)

RegisterServerEvent(GetCurrentResourceName() .. ':setVehicleStatePolice')
AddEventHandler(GetCurrentResourceName() .. ':setVehicleStatePolice', function(plate, state)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE owned_vehicles SET police = @police AND stored = @stored WHERE plate = @plate', {
		['@police'] = state,
		['@stored'] = state,
		['@plate'] = plate
	}, function(rowsChanged)
		if rowsChanged == 0 then
			print((GetCurrentResourceName() .. ': %s exploited the garage!'):format(xPlayer.identifier))
		end
	end)
end)

-- @Fetch Pound Police Car
ESX.RegisterServerCallback(GetCurrentResourceName() .. ':getOutOwnedCarsNonpolice', function(source, cb)
	local ownedCars = {}
	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = @owner AND Type = @Type AND job = @job  AND police = @police", {
		["@owner"] = GetPlayerIdentifiers(source)[1],
		["@Type"] = "car",
		["@job"] = "",
		["@police"] = 1,
	}, function(data) 
		for _,v in pairs(data) do
			table.insert(ownedCars, v)
		end
		cb(ownedCars)
	end)
end)