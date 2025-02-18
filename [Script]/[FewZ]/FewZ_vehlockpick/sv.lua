ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem(Config.Item.Item, function(source)
	TriggerClientEvent(GetCurrentResourceName() ..':start', source)
end)

RegisterServerEvent(GetCurrentResourceName() ..':remove')
AddEventHandler(GetCurrentResourceName() ..':remove', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem(Config.Item.Item, Config.Item.Remove)
end)