ESX = nil
TriggerEvent(Config['esx_routers']['server_shared_obj'], function(obj)
	ESX = obj
end)
AddEventHandler(Config['esx_routers']['server_player_load'], function(playerId)
		if playerId then
			TriggerClientEvent('azael_db-health&armor:playerLoaded', playerId, true)
		end
end)

ESX.RegisterServerCallback('azael_db-health&armor:playerName', function(playerId, cb)
	local xPlayer = ESX.GetPlayerFromId(playerId)
	if xPlayer then
		cb(xPlayer.name)
	else
		cb(false)
	end
end)
RegisterNetEvent('azael_db-health&armor:playerDebug')
AddEventHandler('azael_db-health&armor:playerDebug', function(playerId, status)
	local xPlayer = ESX.GetPlayerFromId(playerId)
	if xPlayer then
		print('[^3'..AZAEL.Resource..'^7] Identifier: '..xPlayer.identifier..' | Status: '..status)
	end
end)