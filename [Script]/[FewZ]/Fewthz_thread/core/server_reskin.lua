ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('Fewthz_reskin', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerClientEvent('esx_skin:openSaveableMenu', source)
	xPlayer.removeInventoryItem("Fewthz_reskin", 1)
end)

RegisterServerEvent('removemoney:pay')
AddEventHandler('removemoney:pay', function(count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.getMoney() >= count then
		xPlayer.removeMoney(count)
	end
end)