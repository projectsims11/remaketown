ESX = nil

local playersInJail = {}

	TriggerEvent('esx:getSharedObject', function(obj) 
		ESX = obj

		Citizen.Wait(50)
		Config.InitExtended()
	end)

	RegisterServerEvent(GetCurrentResourceName() .. ':requestAuth')
    AddEventHandler(GetCurrentResourceName() .. ':requestAuth', function()
        TriggerClientEvent(GetCurrentResourceName() .. ':getAuth', source, ENV.get('__Registered'))
    end)

	AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
		MySQL.Async.fetchAll('SELECT jail_time, jail_position FROM users WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		}, function(result)
			if result[1] and result[1].jail_time > 0 then
				TriggerEvent(GetCurrentResourceName() .. ':sendToJail', xPlayer.source, result[1].jail_time, true, result[1].jail_position)
			end
		end)
	end)

	AddEventHandler('esx:playerDropped', function(playerId, reason)
		playersInJail[playerId] = nil
	end)

	MySQL.ready(function()
		Citizen.Wait(2000)
		local xPlayers = ESX.GetExtendedPlayers()

		for k, xPlayer in pairs(xPlayers) do
			Citizen.Wait(100)

			MySQL.Async.fetchAll('SELECT jail_time, jail_position FROM users WHERE identifier = @identifier', {
				['@identifier'] = xPlayer.identifier
			}, function(result)
				if result[1] and result[1].jail_time > 0 then
					TriggerEvent(GetCurrentResourceName() .. ':sendToJail', xPlayer.source, result[1].jail_time, true, result[1].jail_position)
				end
			end)
		end
	end)

	RegisterNetEvent(GetCurrentResourceName() .. ':sendToJail')
	AddEventHandler(GetCurrentResourceName() .. ':sendToJail', function(playerId, jailTime, quiet, jailPosition, jailReason)
		local xPlayer = ESX.GetPlayerFromId(playerId)

		if xPlayer then
			if not playersInJail[playerId] then
				MySQL.Async.execute('UPDATE users SET jail_time = @jail_time, jail_position = @jail_position WHERE identifier = @identifier', {
					['@identifier'] = xPlayer.identifier,
					['@jail_time'] = jailTime,
					['@jail_position'] = jailPosition
				}, function(rowsChanged)
					-- xPlayer.triggerEvent('esx_policejob:unrestrain')
					xPlayer.triggerEvent(GetCurrentResourceName() .. ':jailPlayer', jailTime, jailPosition, quiet)
					
					playersInJail[playerId] = {
						timeRemaining = jailTime * 60000, 
						identifier = xPlayer.getIdentifier()
					}

					if not quiet then
						Config.Executor.OnJailed(playerId, jailReason)
					end
				end)

			end
		end
	end)

	function unjailPlayer(playerId)
		local xPlayer = ESX.GetPlayerFromId(playerId)

		if xPlayer then
			if playersInJail[playerId] then
				MySQL.Async.execute('UPDATE users SET jail_time = 0 WHERE identifier = @identifier', {
					['@identifier'] = xPlayer.identifier
				}, function(rowsChanged)
					playersInJail[playerId] = nil
					xPlayer.triggerEvent(GetCurrentResourceName() .. ':unjailPlayer')
				end)
			end
		end
	end

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(60000)

			for playerId, data in pairs(playersInJail) do
				playersInJail[playerId].timeRemaining = data.timeRemaining - 60000

				Config.Executor.OnAlertTiming(playerId, data.timeRemaining)

				if data.timeRemaining == 0 then
					unjailPlayer(playerId, false)
				end
			end
		end
	end)

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(Config.JailTimeSyncInterval)
			local tasks = {}

			for playerId, data in pairs(playersInJail) do
				local task = function(cb)
					MySQL.Async.execute('UPDATE users SET jail_time = @time_remaining WHERE identifier = @identifier', {
						['@identifier'] = data.identifier,
						['@time_remaining'] = data.timeRemaining / 60000
					}, function(rowsChanged)
						cb(rowsChanged)
					end)
				end

				table.insert(tasks, task)
			end

			Async.parallelLimit(tasks, 4, function(results) end)
		end
	end)