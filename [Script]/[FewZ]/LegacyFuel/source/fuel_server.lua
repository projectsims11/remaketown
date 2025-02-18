if Config.UseESX then
	local ESX = nil

	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

	RegisterServerEvent('fuel:pay')
	AddEventHandler('fuel:pay', function(price , status )
		local xPlayer = ESX.GetPlayerFromId(source)
		local amount = ESX.Math.Round(price)
		if status then
			if price > 0 then
				xPlayer.removeMoney(amount)
				xPlayer.removeWeapon("WEAPON_PETROLCAN")
				xPlayer.addWeapon("WEAPON_PETROLCAN", 4500)
			end
		else
			if price > 0 then
				xPlayer.removeMoney(amount)
			end
		end
	end)

	-- RegisterServerEvent('fuel:server:world')
	-- AddEventHandler('fuel:server:world', function(x , type)
	-- 	local xPlayer = ESX.GetPlayerFromId(source)
	-- 	TriggerClientEvent("fuel:world", -1, x , type )
	-- end)

	ESX.RegisterServerCallback('nc:getfuel', function(source, cb, plate)
		xPlayer = ESX.GetPlayerFromId(source)
		local result = MySQL.Sync.fetchAll('SELECT owned_vehicles.health_vehicles FROM owned_vehicles WHERE plate = @plate', {
			['@plate'] = plate
		})
		-- print(json.decode(result[1].health_vehicles).fuel)
		if result[1] ~= nil then 
			cb(json.decode(result[1].health_vehicles).fuel)
		else
			cb(100.0)
		end
	end)

end
