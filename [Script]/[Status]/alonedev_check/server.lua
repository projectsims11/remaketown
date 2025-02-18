local connectedPlayers = {}
local Error_Collect = 0

ESX = exports["es_extended"]:getSharedObject()

if cfg.ResetServer then 
	RegisterCommand('ResetVaule', function(source, args, rawCommand)
		connectedPlayers = {}
		Citizen.Wait(1000)
		AddPlayersToScoreboard()
	end, true)
end

RegisterNetEvent('alonedev_check:Notify')
AddEventHandler('alonedev_check:Notify', function(message , IsCollected)
	if cfg.Debug then 
		local src = source
		print(message .. ' | Player id : ' .. src)
	
		if IsCollected then 
			Error_Collect = Error_Collect + 1
	
			if Error_Collect > cfg.ErrorLimits then 
				print('Error Limits Reached !')
				if cfg.AutoResetValue then 
					Error_Collect = 0
					print('Reseting Value...')
					connectedPlayers = {}
					Citizen.Wait(1000)
					AddPlayersToScoreboard()
				end
			end
		end
	end
end)


AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
	connectedPlayers[xPlayer.getIdentifier()] = {}
	connectedPlayers[xPlayer.getIdentifier()].job = xPlayer.job.name

	TriggerClientEvent('alonedev_check:addplayerconnected', -1, connectedPlayers )
end)

AddEventHandler('esx:setJob', function(playerId, job, lastJob)
	local xPlayer = ESX.GetPlayerFromId(playerId)
	connectedPlayers[xPlayer.getIdentifier()].job = job.name

	TriggerClientEvent('alonedev_check:addplayerconnected', -1, connectedPlayers)
end)

AddEventHandler('esx:playerDropped', function(playerId)
	local xPlayer = ESX.GetPlayerFromId(playerId)
	connectedPlayers[xPlayer.getIdentifier()] = nil

	TriggerClientEvent('alonedev_check:addplayerconnected', -1, connectedPlayers)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.CreateThread(function()
			Citizen.Wait(1500)
			AddPlayersToScoreboard()
		end)
	end
end)

function AddPlayersToScoreboard()
	local players = ESX.GetPlayers()

	for i=1, #players, 1 do
		local src = players[i]
		local xPlayer = ESX.GetPlayerFromId(src)

		connectedPlayers[xPlayer.getIdentifier()] = {}
		connectedPlayers[xPlayer.getIdentifier()].job = xPlayer.job.name
	end

	TriggerClientEvent('alonedev_check:addplayerconnected', -1, connectedPlayers )
end