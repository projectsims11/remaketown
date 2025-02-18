ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('skateboard', function(source)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    
    TriggerClientEvent('meow_skateboard', source, 'meow_skateboard')
end)