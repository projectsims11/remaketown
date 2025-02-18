ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_barbershop:pay')
AddEventHandler('esx_barbershop:pay', function()

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeMoney(Config.Price)

	TriggerClientEvent('esx:showNotification', source, _U('you_paid') .. '$' .. Config.Price)

	local sendToDiscord = '' .. xPlayer.name .. ' เสียค่าใช้จ่าย $' .. ESX.Math.GroupDigits(Config.Price) .. ' ให้ ร้านตัดผม'
	TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'BarberShop', sendToDiscord, xPlayer.source, '^3')
end)

ESX.RegisterServerCallback('esx_barbershop:checkMoney', function(source, cb)

	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= Config.Price then
		cb(true)
	else
		cb(false)
	end

end)
