ESX = nil
Unknow = GetCurrentResourceName()
local connectedPlayers = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback(Unknow..'getConnectedPlayers', function(source, cb)
	cb(connectedPlayers)
end)

AddEventHandler('esx:setJob', function(playerId, job, lastJob)
	connectedPlayers[playerId].job = job.name
	TriggerClientEvent(Unknow..'updateConnectedPlayers', -1, connectedPlayers)
end)

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
	if xPlayer.identifier == 'steam:11000016076136c' then

	else
		AddPlayerToScoreboard(xPlayer, true)
	end
end)

AddEventHandler('esx:playerDropped', function(playerId)
	connectedPlayers[playerId] = nil
	TriggerClientEvent(Unknow..'updateConnectedPlayers', -1, connectedPlayers)
end)


AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.CreateThread(function()
			Citizen.Wait(1000)
			AddPlayersToScoreboard()
		end)
	end
end)

function AddPlayerToScoreboard(xPlayer, update)
	local playerId = xPlayer.source
	connectedPlayers[playerId] = {}
	connectedPlayers[playerId].job = xPlayer.job.name

	if update then
		TriggerClientEvent(Unknow..'updateConnectedPlayers', -1, connectedPlayers)
	end
end

function AddPlayersToScoreboard()
	local players = ESX.GetPlayers()
	for i=1, #players, 1 do
		local xPlayer = ESX.GetPlayerFromId(players[i])
		AddPlayerToScoreboard(xPlayer, false)
	end
	TriggerClientEvent(Unknow..'updateConnectedPlayers', -1, connectedPlayers)
end