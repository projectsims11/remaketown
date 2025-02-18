ESX = exports["es_extended"]:getSharedObject()

RegisterCommand("setmodel", function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'admin' then
	    TriggerClientEvent('setpmodel:setmodel',tonumber(args[1]),args[2])
    end
end, true)

RegisterCommand("resetmodel", function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'admin' then
        TriggerClientEvent('setpmodel:resetmodel',tonumber(args[1]))
    end
end, true)