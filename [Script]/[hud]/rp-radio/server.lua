ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('radio', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerClientEvent('mail3ee-radio:startRadio', source)

end)