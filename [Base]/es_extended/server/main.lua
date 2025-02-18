SetMapName('San Andreas')
SetGameType('Xdev Server')

local oneSyncState = GetConvar('onesync', 'off')
local newPlayer = 'INSERT INTO `users` SET `accounts` = ?, `identifier` = ?, `group` = ?'
local loadPlayer = 'SELECT `accounts`, `job`, `job_grade`, `group`, `position`, `inventory`, `skin`, `loadout`, `metadata`, `firstname`, `lastname`, `dateofbirth`, `sex`, `height`'

if Config.StartingInventoryItems then
	newPlayer = newPlayer .. ', `inventory` = ?'
end

loadPlayer = loadPlayer .. ' FROM `users` WHERE identifier = ?'

RegisterNetEvent('esx:onPlayerJoined')
AddEventHandler('esx:onPlayerJoined', function()
    local _source = source
    while not next(ESX.Jobs) do
        Wait(50)
    end

    if not ESX.Players[_source] then
        onPlayerJoined(_source)
    end
end)

function onPlayerJoined(playerId)
	local identifier = ESX.GetIdentifier(playerId)
	if identifier then
		if ESX.GetPlayerFromIdentifier(identifier) then
			DropPlayer(playerId,
				('there was an error loading your character!\nError code: identifier-active-ingame\n\nThis error is caused by a player on this server who has the same identifier as you have. Make sure you are not playing on the same Rockstar account.\n\nYour Rockstar identifier: %s'):format(
					identifier))
		else
			local result = MySQL.scalar.await('SELECT 1 FROM users WHERE identifier = ?', { identifier })
			if result then
				loadESXPlayer(identifier, playerId, false)
			else
				createESXPlayer(identifier, playerId)
			end
		end
	else
		DropPlayer(playerId,
			'there was an error loading your character!\nError code: identifier-missing-ingame\n\nThe cause of this error is not known, your identifier could not be found. Please come back later or report this problem to the server administration team.')
	end
end

function createESXPlayer(identifier, playerId, data)
	local accounts = {}

	for account, money in pairs(Config.StartingAccountMoney) do
		accounts[account] = money
	end

	local defaultGroup = "user"
	if Core.IsPlayerAdmin(playerId) then
		print(('[^2INFO^0] Player ^5%s^0 Has been granted admin permissions via ^5Ace Perms^7.'):format(playerId))
		defaultGroup = "admin"
	end

	local parameters = Config.Multichar and { json.encode(accounts), identifier, defaultGroup, data.firstname, data.lastname, data.dateofbirth, data.sex, data.height } or { json.encode(accounts), identifier, defaultGroup }

	if Config.StartingInventoryItems then
		table.insert(parameters, json.encode(Config.StartingInventoryItems))
	end

	MySQL.prepare(newPlayer, parameters, function()
		loadESXPlayer(identifier, playerId, true)
	end)
end

AddEventHandler('playerConnecting', function(_, _, deferrals)
	deferrals.defer()
	local playerId = source
	local identifier = ESX.GetIdentifier(playerId)

	if oneSyncState == "off" or oneSyncState == "legacy" then
		return deferrals.done(('[ESX] ESX Requires Onesync Infinity to work. This server currently has Onesync set to: %s'):format(oneSyncState))
	end

	if not Core.DatabaseConnected then
		return deferrals.done('[ESX] OxMySQL Was Unable To Connect to your database. Please make sure it is turned on and correctly configured in your server.cfg')
	end

	if identifier then
		if ESX.GetPlayerFromIdentifier(identifier) then
			return deferrals.done(
				('[ESX] There was an error loading your character!\nError code: identifier-active\n\nThis error is caused by a player on this server who has the same identifier as you have. Make sure you are not playing on the same account.\n\nYour identifier: %s'):format(
					identifier))
		else
			return deferrals.done()
		end
	else
		return deferrals.done(
			'[ESX] There was an error loading your character!\nError code: identifier-missing\n\nThe cause of this error is not known, your identifier could not be found. Please come back later or report this problem to the server administration team.')
	end
end)

function loadESXPlayer(identifier, playerId, isNew)
	local userData = {
		accounts = {},
		inventory = {},
		job = {},
		loadout = {},
		playerName = GetPlayerName(playerId),
		metadata = {}
	}
	local result = MySQL.prepare.await(loadPlayer, { identifier })
	local job, grade, jobObject, gradeObject = result.job, tostring(result.job_grade)
	local foundAccounts, foundItems = {}, {}

	-- Accounts
	if result.accounts and result.accounts ~= '' then
		local accounts = json.decode(result.accounts)

		for account, money in pairs(accounts) do
			foundAccounts[account] = money
		end
	end

	for account, data in pairs(Config.Accounts) do
		if data.round == nil then
			data.round = true
		end
		local index = #userData.accounts + 1
		userData.accounts[index] = {
			name = account,
			money = foundAccounts[account] or Config.StartingAccountMoney[account] or 0,
			label = data.label,
			round = data.round,
			index = index
		}
	end

	-- Job
	if ESX.DoesJobExist(job, grade) then
		jobObject, gradeObject = ESX.Jobs[job], ESX.Jobs[job].grades[grade]
	else
		print(('[^3WARNING^7] Ignoring invalid job for ^5%s^7 [job: ^5%s^7, grade: ^5%s^7]'):format(identifier, job, grade))
		job, grade = 'unemployed', '0'
		jobObject, gradeObject = ESX.Jobs[job], ESX.Jobs[job].grades[grade]
	end

	userData.job.id = jobObject.id
	userData.job.name = jobObject.name
	userData.job.label = jobObject.label

	userData.job.grade = tonumber(grade)
	userData.job.grade_name = gradeObject.name
	userData.job.grade_label = gradeObject.label
	userData.job.grade_salary = gradeObject.salary

	userData.job.skin_male = {}
	userData.job.skin_female = {}

	if gradeObject.skin_male then
		userData.job.skin_male = json.decode(gradeObject.skin_male)
	end
	if gradeObject.skin_female then
		userData.job.skin_female = json.decode(gradeObject.skin_female)
	end

	-- Inventory
	if result.inventory and result.inventory ~= '' then
		local inventory = json.decode(result.inventory)

		for name, count in pairs(inventory) do
			local item = ESX.Items[name]

			if item then
				foundItems[name] = count
			else
				print(('[^3WARNING^7] Ignoring invalid item ^5"%s"^7 for ^5"%s^7"'):format(name, identifier))
			end
		end
	end

	for name, item in pairs(ESX.Items) do
		local count = foundItems[name] or 0

		table.insert(userData.inventory,
			{
				name = name,
				count = count,
				label = item.label,
				limit = item.limit,
				usable = Core.UsableItemsCallbacks[name] ~= nil,
				rare = item.rare,
				canRemove = item.canRemove
			})
	end

	table.sort(userData.inventory, function(a, b)
		return a.label < b.label
	end)

	-- Group
	if result.group then
		if result.group == "superadmin" then
			userData.group = "admin"
			print("[^3WARNING^7] ^5Superadmin^7 detected, setting group to ^5admin^7")
		else
			userData.group = result.group
		end
	else
		userData.group = 'user'
	end

	-- Loadout
	if result.loadout and result.loadout ~= '' then
		local loadout = json.decode(result.loadout)

		for name, weapon in pairs(loadout) do
			local label = ESX.GetWeaponLabel(name)

			if label then
				if not weapon.components then
					weapon.components = {}
				end
				if not weapon.tintIndex then
					weapon.tintIndex = 0
				end

				table.insert(userData.loadout,
					{
						name = name,
						ammo = weapon.ammo,
						label = label,
						components = weapon.components,
						tintIndex = weapon.tintIndex
					})
			end
		end
	end
	-- Position
	userData.coords = json.decode(result.position) or Config.DefaultSpawns[math.random(#Config.DefaultSpawns)]

	-- Skin
	if result.skin and result.skin ~= '' then
		userData.skin = json.decode(result.skin)
	else
		if userData.sex == 'f' then
			userData.skin = { sex = 1 }
		else
			userData.skin = { sex = 0 }
		end
	end

	-- Identity
	if result.firstname and result.firstname ~= '' then
		userData.firstname = result.firstname
		userData.lastname = result.lastname
		userData.playerName = userData.firstname .. ' ' .. userData.lastname
		if result.dateofbirth then
			userData.dateofbirth = result.dateofbirth
		end
		if result.sex then
			userData.sex = result.sex
		end
		if result.height then
			userData.height = result.height
		end
	end

	local xPlayer = CreateExtendedPlayer(playerId, identifier, userData.group, userData.accounts, userData.inventory, userData.job, userData.loadout, userData.playerName, userData.coords, userData.metadata)
	ESX.Players[playerId] = xPlayer
	Core.playersByIdentifier[identifier] = xPlayer

	if userData.firstname then
		xPlayer.set('firstName', userData.firstname)
		xPlayer.set('lastName', userData.lastname)
		if userData.dateofbirth then
			xPlayer.set('dateofbirth', userData.dateofbirth)
		end
		if userData.sex then
			xPlayer.set('sex', userData.sex)
		end
		if userData.height then
			xPlayer.set('height', userData.height)
		end
	end


	TriggerEvent('esx:playerLoaded', playerId, xPlayer, isNew)

	xPlayer.triggerEvent('esx:playerLoaded',
		{
			accounts = xPlayer.getAccounts(),
			coords = userData.coords,
			identifier = xPlayer.getIdentifier(),
			inventory = xPlayer.getInventory(),
			job = xPlayer.getJob(),
			loadout = xPlayer.getLoadout(),
			money = xPlayer.getMoney(),
			sex = xPlayer.get("sex") or "m",
			firstName = xPlayer.get("firstName") or "John",
			lastName = xPlayer.get("lastName") or "Doe",
			dateofbirth = xPlayer.get("dateofbirth") or "01/01/2000",
			height = xPlayer.get("height") or 120,
			dead = false,
		}, isNew,
		userData.skin)

		MySQL.update.await('UPDATE users SET `steam_name` = @name WHERE `identifier` = @identifier', {
			['@identifier'] = identifier,
			['@name'] = GetPlayerName(playerId)
		})

	xPlayer.triggerEvent('esx:registerSuggestions', Core.RegisteredCommands)
	print(('[^2INFO^0] Player ^5"%s"^0 has connected to the server. ID: ^5%s^7'):format(xPlayer.getName(), playerId))
end

AddEventHandler('chatMessage', function(playerId, _, message)
	local xPlayer = ESX.GetPlayerFromId(playerId)
	if message:sub(1, 1) == '/' and playerId > 0 then
		CancelEvent()
		local commandName = message:sub(1):gmatch("%w+")()
		xPlayer.showNotification(TranslateCap('commanderror_invalidcommand', commandName))
	end
end)

AddEventHandler('playerDropped', function(reason)
	local playerId = source
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if xPlayer then
		TriggerEvent('esx:playerDropped', playerId, reason)
        local job = xPlayer.getJob().name
		local currentJob = ESX.JobsPlayerCount[job]
        ESX.JobsPlayerCount[job] = ((currentJob and currentJob > 0) and currentJob or 1) -1
		GlobalState[("%s:count"):format(job)] = ESX.JobsPlayerCount[job]
		Core.playersByIdentifier[xPlayer.identifier] = nil
		Core.SavePlayer(xPlayer, function()
			ESX.Players[playerId] = nil
		end)
	end
end)

AddEventHandler("esx:playerLoaded", function(playerId, xPlayer, isNew)
    local job = xPlayer.getJob().name
	local jobKey = ("%s:count"):format(job)
	
    ESX.JobsPlayerCount[job] = (ESX.JobsPlayerCount[job] or 0) +1
	GlobalState[jobKey] = ESX.JobsPlayerCount[job]
end)

AddEventHandler("esx:setJob", function(src, job, lastJob)
	local lastJobKey = ('%s:count'):format(lastJob.name)
	local jobKey = ('%s:count'):format(job.name)
	local currentLastJob = ESX.JobsPlayerCount[lastJob.name]

    ESX.JobsPlayerCount[lastJob.name] = ((currentLastJob and currentLastJob > 0) and currentLastJob or 1) -1
    ESX.JobsPlayerCount[job.name] = (ESX.JobsPlayerCount[job.name] or 0) + 1

	GlobalState[lastJobKey] = ESX.JobsPlayerCount[lastJob.name]
	GlobalState[jobKey] = ESX.JobsPlayerCount[job.name]
end)

AddEventHandler('esx:playerLogout', function(playerId, cb)
	local xPlayer = ESX.GetPlayerFromId(playerId)
	if xPlayer then
		TriggerEvent('esx:playerDropped', playerId)

		Core.playersByIdentifier[xPlayer.identifier] = nil
		Core.SavePlayer(xPlayer, function()
			ESX.Players[playerId] = nil
			if cb then
				cb()
			end
		end)
	end
	TriggerClientEvent("esx:onPlayerLogout", playerId)
end)

RegisterNetEvent('esx:updateWeaponAmmo')
AddEventHandler('esx:updateWeaponAmmo', function(weaponName, ammoCount)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer then
		xPlayer.updateWeaponAmmo(weaponName, ammoCount)
	end
end)

RegisterNetEvent('esx:giveInventoryItem')
AddEventHandler('esx:giveInventoryItem', function(target, itemType, itemName, itemCount)
	local playerId = source
	local sourceXPlayer = ESX.GetPlayerFromId(playerId)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	local distance = #(GetEntityCoords(GetPlayerPed(playerId)) - GetEntityCoords(GetPlayerPed(target)))
	if not sourceXPlayer or not targetXPlayer or distance > Config.DistanceGive then
		print(('[^3WARNING^7] Player Detected Cheating: ^5%s^7'):format(GetPlayerName(playerId)))
		return
	end

	if itemType == 'item_standard' then
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)

		if itemCount > 0 and sourceItem.count >= itemCount then
			if targetXPlayer.canCarryItem(itemName, itemCount) then
				sourceXPlayer.removeInventoryItem(itemName, itemCount)
				targetXPlayer.addInventoryItem(itemName, itemCount)

				TriggerClientEvent("pNotify:SendNotification", source, { --แจ้งเตือนเรา _source = owned
				text = 'ส่ง ' ..sourceItem.label.. ' จำนวน ' .. itemCount..' ชิ้น',
				type = "success",
				timeout = 5000,
				layout = "bottomRight",
				queue = "global"
			  })
				TriggerClientEvent("pNotify:SendNotification", target, { --แจ้งเตือนเป้าหมาย target = Other players
					text = 'ได้รับ ' ..sourceItem.label.. ' จำนวน ' .. itemCount.. ' ชิ้น',
					type = "success",
					timeout = 5000,
					layout = "bottomRight",
					queue = "global"
				})

				-- sourceXPlayer.showNotification(TranslateCap('gave_item', itemCount, sourceItem.label, targetXPlayer.name))
				-- targetXPlayer.showNotification(TranslateCap('received_item', itemCount, sourceItem.label, sourceXPlayer.name))
			else
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = 'คุณ ' .. targetXPlayer.name ..' ไม่สามารถรับไอเทมได้เนื่องจากไอเทมเกินขีดจำกัด',
					type = "error",
					timeout = 3000,
					layout = "bottomRight",
					queue = "global"
				  })
			end
		else
			TriggerClientEvent("pNotify:SendNotification", source, {
				text = 'จำนวนไม่ถูกต้อง',
				type = "error",
				timeout = 3000,
				layout = "bottomRight",
				queue = "global"
			  })
		end
	elseif itemType == 'item_account' then
		if itemCount > 0 and sourceXPlayer.getAccount(itemName).money >= itemCount then
			sourceXPlayer.removeAccountMoney(itemName, itemCount, "Gave to " .. targetXPlayer.name)
			targetXPlayer.addAccountMoney(itemName, itemCount, "Received from " .. sourceXPlayer.name)

            TriggerClientEvent("pNotify:SendNotification", source, { --แจ้งเตือนเรา _source = owned
            text = 'ส่ง '..Config.Accounts[itemName].. ' จำนวน ' .. itemCount..'$',
            type = "success",
            timeout = 5000,
            layout = "bottomRight",
            queue = "global"
          })
            TriggerClientEvent("pNotify:SendNotification", target, { --แจ้งเตือนเป้าหมาย target = Other players
                text = 'ได้รับ ' ..Config.Accounts[itemName].. ' จำนวน ' .. itemCount.. '$',
                type = "success",
                timeout = 5000,
                layout = "bottomRight",
                queue = "global"
            })

		else
			TriggerClientEvent("pNotify:SendNotification", source, {
				text = 'จำนวนไม่ถูกต้อง',
				type = "error",
				timeout = 5000,
				layout = "bottomRight",
				queue = "global"
			  })
		end
	elseif itemType == 'item_weapon' then
		if sourceXPlayer.hasWeapon(itemName) then
			local weaponLabel = ESX.GetWeaponLabel(itemName)
			if not targetXPlayer.hasWeapon(itemName) then
				local _, weapon = sourceXPlayer.getWeapon(itemName)
				local _, weaponObject = ESX.GetWeapon(itemName)
				itemCount = weapon.ammo
				local weaponComponents = ESX.Table.Clone(weapon.components)
				local weaponTint = weapon.tintIndex
				if weaponTint then
					targetXPlayer.setWeaponTint(itemName, weaponTint)
				end
				if weaponComponents then
					for _, v in pairs(weaponComponents) do
						targetXPlayer.addWeaponComponent(itemName, v)
					end
				end
				sourceXPlayer.removeWeapon(itemName)
				targetXPlayer.addWeapon(itemName, itemCount)

				if weaponObject.ammo and itemCount > 0 then
					local ammoLabel = weaponObject.ammo.label
					TriggerClientEvent("pNotify:SendNotification", source, {
						text = 'ส่ง '.. weaponLabel ..' กระสุน จำนวน ' .. itemCount ..'',
						type = "success",
						timeout = 5000,
						layout = "bottomRight",
						queue = "global"
					  })
  
					  TriggerClientEvent("pNotify:SendNotification", target, {
						text = 'ได้รับ '.. weaponLabel ..' กระสุน จำนวน ' .. itemCount ..'',
						type = "success",
						timeout = 5000,
						layout = "bottomRight",
						queue = "global"
					  })
				  else
					TriggerClientEvent("pNotify:SendNotification", source, {
					  text = 'ส่ง '.. weaponLabel ..'',
					  type = "success",
					  timeout = 5000,
					  layout = "bottomRight",
					  queue = "global"
					})
					TriggerClientEvent("pNotify:SendNotification", target, {
					  text = 'ได้รับ '.. weaponLabel ..'',
					  type = "success",
					  timeout = 5000,
					  layout = "bottomRight",
					  queue = "global"
					})
				end
			else
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = 'ผู้เล่นคนนี้มีอาวุธอยู่แล้ว',
					type = "error",
					timeout = 5000,
					layout = "bottomRight",
					queue = "global"
				  })
					TriggerClientEvent("pNotify:SendNotification", target, {
					  text = 'คุณมีอาวุธอยู่แล้ว',
					  type = "error",
					  timeout = 5000,
					  layout = "bottomRight",
					  queue = "global"
					})
			end
		end
	elseif itemType == 'item_ammo' then
		if sourceXPlayer.hasWeapon(itemName) then
			local _, weapon = sourceXPlayer.getWeapon(itemName)

			if targetXPlayer.hasWeapon(itemName) then
				local _, weaponObject = ESX.GetWeapon(itemName)

				if weaponObject.ammo then
					local ammoLabel = weaponObject.ammo.label

					if weapon.ammo >= itemCount then
						sourceXPlayer.removeWeaponAmmo(itemName, itemCount)
						targetXPlayer.addWeaponAmmo(itemName, itemCount)

						sourceXPlayer.showNotification(TranslateCap('gave_weapon_ammo', itemCount, ammoLabel, weapon.label, targetXPlayer.name))
						targetXPlayer.showNotification(TranslateCap('received_weapon_ammo', itemCount, ammoLabel, weapon.label, sourceXPlayer.name))
					end
				end
			else
				sourceXPlayer.showNotification(TranslateCap('gave_weapon_noweapon', targetXPlayer.name))
				targetXPlayer.showNotification(TranslateCap('received_weapon_noweapon', sourceXPlayer.name, weapon.label))
			end
		end
	end
end)

RegisterNetEvent('esx:removeInventoryItem')
AddEventHandler('esx:removeInventoryItem', function(itemType, itemName, itemCount)
	local playerId = source
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if itemType == 'item_standard' then
		if itemCount == nil or itemCount < 1 then
			TriggerClientEvent("pNotify:SendNotification", source, {
                text = 'จำนวนไม่ถูกต้อง',
                type = "error",
                timeout = 5000,
                layout = "bottomRight",
                queue = "global"
              })
		else
			local xItem = xPlayer.getInventoryItem(itemName)

			if (itemCount > xItem.count or xItem.count < 1) then
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = 'จำนวนไม่ถูกต้อง',
					type = "error",
					timeout = 5000,
					layout = "bottomRight",
					queue = "global"
				  })
			else
				xPlayer.removeInventoryItem(itemName, itemCount)
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = 'ทิ้ง '..xItem.label..' จำนวน '..itemCount..' เรียบร้อย',
					type = "success",
					timeout = 5000,
					layout = "bottomRight",
					queue = "global"
				  })
			end
		end
	elseif itemType == 'item_account' then
		if itemCount == nil or itemCount < 1 then
			TriggerClientEvent("pNotify:SendNotification", source, {
				text = 'จำนวนไม่ถูกต้อง',
				type = "error",
				timeout = 5000,
				layout = "bottomRight",
				queue = "global"
			  })
		else
			local account = xPlayer.getAccount(itemName)

			if (itemCount > account.money or account.money < 1) then
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = 'จำนวนไม่ถูกต้อง',
					type = "error",
					timeout = 5000,
					layout = "bottomRight",
					queue = "global"
				  })
			else
				xPlayer.removeAccountMoney(itemName, itemCount, "Threw away")
				TriggerClientEvent("pNotify:SendNotification", source, {
					text = 'ทิ้ง '..string.lower(account.label)..' จำนวน '..ESX.Math.GroupDigits(itemCount)..' เรียบร้อย',
					type = "success",
					timeout = 5000,
					layout = "bottomRight",
					queue = "global"
				  })
			end
		end
	elseif itemType == 'item_weapon' then
		itemName = string.upper(itemName)

		if xPlayer.hasWeapon(itemName) then
			local _, weapon = xPlayer.getWeapon(itemName)
			local _, weaponObject = ESX.GetWeapon(itemName)
			local components = ESX.Table.Clone(weapon.components)
			xPlayer.removeWeapon(itemName)

			if weaponObject.ammo and weapon.ammo > 0 then
				local ammoLabel = weaponObject.ammo.label
				xPlayer.showNotification(TranslateCap('threw_weapon_ammo', weapon.label, weapon.ammo, ammoLabel))
			else
				xPlayer.showNotification(TranslateCap('threw_weapon', weapon.label))
			end
		end
	end
end)

RegisterNetEvent('esx:useItem')
AddEventHandler('esx:useItem', function(itemName)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local count = xPlayer.getInventoryItem(itemName).count

	if count > 0 then
		ESX.UseItem(source, itemName)
	else
		TriggerClientEvent("pNotify:SendNotification", source, {
			text = 'ไม่สามารถทำสิ่งนี้ได้',
			type = "error",
			timeout = 5000,
			layout = "bottomRight",
			queue = "global"
		})
	end
end)

ESX.RegisterServerCallback('esx:getPlayerData', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb({
		identifier = xPlayer.identifier,
		accounts = xPlayer.getAccounts(),
		inventory = xPlayer.getInventory(),
		job = xPlayer.getJob(),
		loadout = xPlayer.getLoadout(),
		money = xPlayer.getMoney(),
		position = xPlayer.getCoords(true),
	})
end)

ESX.RegisterServerCallback('esx:isUserAdmin', function(source, cb)
	cb(Core.IsPlayerAdmin(source))
end)

ESX.RegisterServerCallback('esx:getGameBuild', function(_, cb)
	cb(tonumber(GetConvar("sv_enforceGameBuild", 2699
	)))
end)

ESX.RegisterServerCallback('esx:getOtherPlayerData', function(_, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)

	cb({
		identifier = xPlayer.identifier,
		accounts = xPlayer.getAccounts(),
		inventory = xPlayer.getInventory(),
		job = xPlayer.getJob(),
		loadout = xPlayer.getLoadout(),
		money = xPlayer.getMoney(),
		position = xPlayer.getCoords(true),
	})
end)

ESX.RegisterServerCallback('esx:getPlayerNames', function(source, cb, players)
	players[source] = nil

	for playerId, _ in pairs(players) do
		local xPlayer = ESX.GetPlayerFromId(playerId)

		if xPlayer then
			players[playerId] = xPlayer.getName()
		else
			players[playerId] = nil
		end
	end

	cb(players)
end)

ESX.RegisterServerCallback("esx:spawnVehicle", function(source, cb, vehData)
	local ped = GetPlayerPed(source)
	ESX.OneSync.SpawnVehicle(vehData.model or `ADDER`, vehData.coords or GetEntityCoords(ped), vehData.coords.w or 0.0, vehData.props or {}, function(id)
		if vehData.warp then
			local vehicle = NetworkGetEntityFromNetworkId(id)
			local timeout = 0
			while GetVehiclePedIsIn(ped) ~= vehicle and timeout <= 15 do
				Wait(0)
				TaskWarpPedIntoVehicle(ped, vehicle, -1)
				timeout += 1
			end
		end
		cb(id)
	end)
end)

AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
	if eventData.secondsRemaining == 60 then
		CreateThread(function()
			Wait(50000)
			Core.SavePlayers()
		end)
	end
end)

AddEventHandler('txAdmin:events:serverShuttingDown', function()
	Core.SavePlayers()
end)

local DoNotUse = {
    ['essentialmode'] = true,
    ['es_admin2'] = true,
    ['basic-gamemode'] = true,
    ['mapmanager'] = true,
    ['fivem-map-skater'] = true,
    ['fivem-map-hipster'] = true,
    ['qb-core'] = true,
    ['default_spawnpoint'] = true,
}

AddEventHandler('onResourceStart', function(key)
    if DoNotUse[string.lower(key)] then
        while GetResourceState(key) ~= 'started' do 
            Wait(0)
        end 
        
		StopResource(key)
        print(("[^1ERROR^7] WE STOPPED A RESOURCE THAT WILL BREAK ^1ESX^7, PLEASE REMOVE ^5%s^7"):format(key))
    end 
end)

for key in pairs(DoNotUse) do
    if GetResourceState(key) == 'started' or GetResourceState(key) == 'starting' then
		StopResource(key)
        print(("[^1ERROR^7] WE STOPPED A RESOURCE THAT WILL BREAK ^1ESX^7, PLEASE REMOVE ^5%s^7"):format(key))
    end
end

if Config["Function_Base"]['Update_Weapon'] then
	RegisterNetEvent('esx:updateLoadout')
	AddEventHandler('esx:updateLoadout', function(loadout)
	  local xPlayer = ESX.GetPlayerFromId(source)
	  xPlayer.loadout = loadout
	end)
end

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
    Citizen.Wait(5 * 1000)
    MySQL.single("SELECT metadata FROM users WHERE identifier = @identifier" , {
        ['@identifier'] = xPlayer.identifier
    }, function(result)
        local data = result
        for k , v in pairs(data) do
            local x = json.decode(v)
            TriggerClientEvent('update:data:players', playerId, tonumber(x.health) , tonumber(x.armour))
        end
    end)
end)

AddEventHandler('esx:playerDropped', function(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    local health = GetEntityHealth(GetPlayerPed(xPlayer.source))
    local armour = GetPedArmour(GetPlayerPed(xPlayer.source))
    data = {
        health = health,
        armour = armour
    }
    MySQL.update('UPDATE users SET metadata = @metadata WHERE identifier = @identifier', {
        ['@metadata'] = json.encode(data),
        ['@identifier'] = xPlayer.identifier
    })
    Wait(100)
    data = {}
end)