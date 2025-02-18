ESX = exports['es_extended']:getSharedObject()

Fewthz                   = GetCurrentResourceName()

RegisterServerEvent(Fewthz..'buy')
AddEventHandler(Fewthz..'buy', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeMoney(Config.Money)
end)

RegisterServerEvent(Fewthz..'buyAccount')
AddEventHandler(Fewthz..'buyAccount', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ambulance', function(account)
		xPlayer.removeMoney(Config.Money)
		account.addMoney(Config.Money)
	end)
end)