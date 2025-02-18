LocalVault = {}
SharedVault = {}
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback(GetCurrentResourceName() .. ':getOwnedCars', function(source, cb)
	local ownedCars = {}

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND Type = @Type', {
		['@owner']  = GetPlayerIdentifiers(source)[1],
		['@Type']   = 'car',
	}, function(data)
		for _,v in pairs(data) do
			table.insert(ownedCars, v)
		end
		cb(ownedCars)
	end)
end)