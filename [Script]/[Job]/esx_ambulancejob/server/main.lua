ESX = nil
local playersHealing = {}
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_ambulancejob:revive')
AddEventHandler('esx_ambulancejob:revive', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('esx_ambulancejob:revive', target)

		local targetXPlayer = ESX.GetPlayerFromId(target)

		local sendToDiscord = ''	.. xPlayer.name .. ' ชุบชีวิต ' .. targetXPlayer.name .. ' ได้รับ $' .. ESX.Math.GroupDigits(Config.Revive) .. ''
		TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'DocRevive', sendToDiscord, xPlayer.source, '^5')

		Citizen.Wait(100)

		local sendToDiscord = ''	.. targetXPlayer.name .. ' ถูก ' .. xPlayer.name .. ' ชุบชีวิต'
		TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'DocRevive', sendToDiscord, targetXPlayer.source, '^3')
	else
		print(('esx_ambulancejob: %s attempted to revive!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_ambulancejob:drag')
AddEventHandler('esx_ambulancejob:drag', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('esx_ambulancejob:drag', target, source)
	else
		print(('esx_ambulancejob: %s attempted to drag (not EMS)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(target, type)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('esx_ambulancejob:heal', target, type)

		local targetXPlayer = ESX.GetPlayerFromId(target)

		local sendToDiscord = ''	.. xPlayer.name .. ' ทำการรักษา ' .. targetXPlayer.name .. ''
		TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'DocHeal', sendToDiscord, xPlayer.source, '^5')

		Citizen.Wait(100)

		local sendToDiscord = ''	.. targetXPlayer.name .. ' ได้รับการรักษา จาก ' .. xPlayer.name .. ''
		TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'DocHeal', sendToDiscord, targetXPlayer.source, '^2')
	else
		print(('esx_ambulancejob: %s attempted to heal!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_ambulancejob:putInVehicle')
AddEventHandler('esx_ambulancejob:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('esx_ambulancejob:putInVehicle', target)
	else
		print(('esx_ambulancejob: %s attempted to put in vehicle!'):format(xPlayer.identifier))
	end
end)

TriggerEvent('esx_phone:registerNumber', 'ambulance', _U('alert_ambulance'), true, true)

TriggerEvent('esx_society:registerSociety', 'ambulance', 'Ambulance', 'society_ambulance', 'society_ambulance', 'society_ambulance', {type = 'public'})

ESX.RegisterServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local itemProtect =  xPlayer.getInventoryItem(Config.ItemProtect)
	local hasItemGuarantee = false
	if itemProtect.count > 0 then
		hasItemGuarantee = true
	end

	local CheckCweaprotect = 0
	print(#Config.WeaponProtect)
	if #Config.WeaponProtect > 0 then
		for k,v in ipairs(Config.WeaponProtect) do
			local weaponProtect =  xPlayer.getInventoryItem(v.itemname)
			if weaponProtect.count > 0 then
				CheckCweaprotect = CheckCweaprotect + 1
			end
		end
	end
	TriggerEvent('esx-qalle-jail:jailPlayer2',source, Config.Jailtime, Config.RespawnPoint["Cellin"], Config.RespawnPoint["OutCell"])
	if hasItemGuarantee and CheckCweaprotect > 0 then
		TriggerClientEvent("chat:addMessage", -1, {
			template = "<div style=\"padding: 0.5vw; margin: 0.5vw; background-color: rgba(247, 202, 24, 1); border-radius: 3px;\"><i class=\"fas fa-balance-scale\"></i> {0}:<a> {1}</div>",
			args = {
			"[ประกาศ]",
			"ตอนนี้ คุณ " .. xPlayer.name .. "ได้ติดคุกด้วยสาเหตุ เอ๋อ(แต่มีประกันของ+อาวุธ)"
			}
		})
	elseif CheckCweaprotect > 0 then
		TriggerClientEvent("chat:addMessage", -1, {
			template = "<div style=\"padding: 0.5vw; margin: 0.5vw; background-color: rgba(247, 202, 24, 1); border-radius: 3px;\"><i class=\"fas fa-balance-scale\"></i> {0}:<a> {1}</div>",
			args = {
			"[ประกาศ]",
			"ตอนนี้ คุณ " .. xPlayer.name .. "ได้ติดคุกด้วยสาเหตุ เอ๋อ(แต่มีประกันอาวุธ)"
			}
		})
	elseif hasItemGuarantee then
		TriggerClientEvent("chat:addMessage", -1, {
			template = "<div style=\"padding: 0.5vw; margin: 0.5vw; background-color: rgba(247, 202, 24, 1); border-radius: 3px;\"><i class=\"fas fa-balance-scale\"></i> {0}:<a> {1}</div>",
			args = {
			"[ประกาศ]",
			"ตอนนี้ คุณ " .. xPlayer.name .. "ได้ติดคุกด้วยสาเหตุ เอ๋อ(แต่มีประกันของ)"
			}
		})
	else
		TriggerClientEvent("chat:addMessage", -1, {
			template = "<div style=\"padding: 0.5vw; margin: 0.5vw; background-color: rgba(247, 202, 24, 1); border-radius: 3px;\"><i class=\"fas fa-balance-scale\"></i> {0}:<a> {1}</div>",
			args = {
			"[ประกาศ]",
			"ตอนนี้ คุณ " .. xPlayer.name .. "ได้ติดคุกด้วยสาเหตุ เอ๋อ"
			}
		})
	end
		local playerLoadout = {}
		if Config.RemoveWeaponsAfterRPDeath then
			local txtweapon = ""
			if #Config.WeaponProtect > 0 then
				for k,v in ipairs(Config.WeaponProtect) do
					for i=1, #xPlayer.loadout, 1 do
						if v.weapon == xPlayer.loadout[i].name then 
							local weaponProtect =  xPlayer.getInventoryItem(v.itemname)
							if weaponProtect.count > 0 then
								xPlayer.removeInventoryItem( v.itemname , 1 )
							else
								txtweapon = txtweapon..ESX.GetWeaponLabel(xPlayer.loadout[i].name).."\n"
								xPlayer.removeWeapon(xPlayer.loadout[i].name)
							end
						end
					end
				end
			else
				for i=1, #xPlayer.loadout, 1 do
					txtweapon = txtweapon..ESX.GetWeaponLabel(xPlayer.loadout[i].name).."\n"
					xPlayer.removeWeapon(xPlayer.loadout[i].name)
				end
			end
			if txtweapon ~= "" then
				local sendToDiscord = '' .. xPlayer.name .. ' เสียชีวิต ถูกลบ ' .. txtweapon .. ''
				TriggerEvent('azael_discordlogs:sendToDiscord', 'DocRemoveRPDeath', sendToDiscord, xPlayer.source, '^1')
				Citizen.Wait(100)
			end
		else -- save weapons & restore em' since spawnmanager removes them
			for i=1, #xPlayer.loadout, 1 do
				table.insert(playerLoadout, xPlayer.loadout[i])
			end

			-- give back wepaons after a couple of seconds
			Citizen.CreateThread(function()
				Citizen.Wait(5000)
				for i=1, #playerLoadout, 1 do
					if playerLoadout[i].label ~= nil then
						xPlayer.addWeapon(playerLoadout[i].name, playerLoadout[i].ammo)
					end
				end
			end)
		end

		if not hasItemGuarantee then
			if Config.RemoveCashAfterRPDeath then
				local xMoney, xDirtyMoney = xPlayer.getMoney(), xPlayer.getAccount('black_money').money
				local sendToDiscord = '' .. xPlayer.name .. ' เสียชีวิต ถูกลบ Money $' .. ESX.Math.GroupDigits(xMoney) .. ' เเละ Dirty Money $' .. ESX.Math.GroupDigits(xDirtyMoney) .. ''
				TriggerEvent('azael_discordlogs:sendToDiscord', 'DocRemoveRPDeath', sendToDiscord, xPlayer.source, '^3')
				if xPlayer.getMoney() > 0 then
					xPlayer.removeMoney(xPlayer.getMoney())
				end
	
				if xPlayer.getAccount('black_money').money > 0 then
					xPlayer.setAccountMoney('black_money', 0)
				end
			end
	
			if Config.RemoveItemsAfterRPDeath then
				local txtitem = ""
				if #Config.WeaponProtect > 0 then
					for k,v in ipairs(Config.WeaponProtect) do
						for i=1, #xPlayer.inventory, 1 do
							if xPlayer.inventory[i].count > 0 then
								if v.itemname ~= xPlayer.inventory[i].name then
									txtitem = txtitem..ESX.GetItemLabel(xPlayer.inventory[i].name) .. ' จำนวน ' .. ESX.Math.GroupDigits(xPlayer.inventory[i].count).."\n"
									xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
								end
							end
						end
					end
				else
					for i=1, #xPlayer.inventory, 1 do
						txtitem = txtitem..ESX.GetItemLabel(xPlayer.inventory[i].name) .. ' จำนวน ' .. ESX.Math.GroupDigits(xPlayer.inventory[i].count).."\n"
						xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
					end
				end
				if txtitem ~= "" then
					local sendToDiscord = '' .. xPlayer.name .. ' เสียชีวิต ถูกลบ ' .. txtitem .. ''
					TriggerEvent('azael_discordlogs:sendToDiscord', 'DocRemoveRPDeath', sendToDiscord, xPlayer.source, '^7')
				end
			end
		end
	

	if hasItemGuarantee then
		xPlayer.removeInventoryItem( Config.ItemProtect , 1 )
	end

	cb()
end)

-- ESX.RegisterServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function(source, cb)
-- 	local xPlayer = ESX.GetPlayerFromId(source)

-- 	if Config.RemoveCashAfterRPDeath then
-- 		local xMoney, xDirtyMoney = xPlayer.getMoney(), xPlayer.getAccount('black_money').money
-- 		local sendToDiscord = '' .. xPlayer.name .. ' เสียชีวิต ถูกลบ Money $' .. ESX.Math.GroupDigits(xMoney) .. ' เเละ Dirty Money $' .. ESX.Math.GroupDigits(xDirtyMoney) .. ''
-- 		TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'DocRemoveRPDeath', sendToDiscord, xPlayer.source, '^3')

-- 		if xPlayer.getMoney() > 0 then
-- 			xPlayer.removeMoney(xPlayer.getMoney())
-- 		end

-- 		if xPlayer.getAccount('black_money').money > 0 then
-- 			xPlayer.setAccountMoney('black_money', 0)
-- 		end
-- 	end

-- 	if Config.RemoveItemsAfterRPDeath then
-- 		for i=1, #xPlayer.inventory, 1 do
-- 			if xPlayer.inventory[i].count > 0 then
-- 				xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)

-- 				local sendToDiscord = '' .. xPlayer.name .. ' เสียชีวิต ถูกลบ ' .. ESX.GetItemLabel(xPlayer.inventory[i].name) .. ' จำนวน ' .. ESX.Math.GroupDigits(xPlayer.inventory[i].count) .. ''
-- 				TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'DocRemoveRPDeath', sendToDiscord, xPlayer.source, '^7')
-- 			end
-- 		end
-- 	end

-- 	local playerLoadout = {}
-- 	if Config.RemoveWeaponsAfterRPDeath then
-- 		for i=1, #xPlayer.loadout, 1 do
-- 			xPlayer.removeWeapon(xPlayer.loadout[i].name)

-- 			local sendToDiscord = '' .. xPlayer.name .. ' เสียชีวิต ถูกลบ ' .. ESX.GetWeaponLabel(xPlayer.loadout[i].name) .. ''
-- 			TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'DocRemoveRPDeath', sendToDiscord, xPlayer.source, '^1')
-- 		end
-- 	else -- save weapons & restore em' since spawnmanager removes them
-- 		for i=1, #xPlayer.loadout, 1 do
-- 			table.insert(playerLoadout, xPlayer.loadout[i])
-- 		end

-- 		-- give back wepaons after a couple of seconds
-- 		Citizen.CreateThread(function()
-- 			Citizen.Wait(5000)
-- 			for i=1, #playerLoadout, 1 do
-- 				if playerLoadout[i].label ~= nil then
-- 					xPlayer.addWeapon(playerLoadout[i].name, playerLoadout[i].ammo)
-- 				end
-- 			end
-- 		end)
-- 	end

-- 	cb()
-- end)

if Config.EarlyRespawnFine then
	ESX.RegisterServerCallback('esx_ambulancejob:checkBalance', function(source, cb)
		local xPlayer = ESX.GetPlayerFromId(source)
		local bankBalance = xPlayer.getAccount('bank').money

		cb(bankBalance >= Config.EarlyRespawnFineAmount)
	end)

	RegisterServerEvent('esx_ambulancejob:payFine')
	AddEventHandler('esx_ambulancejob:payFine', function()
		local xPlayer = ESX.GetPlayerFromId(source)
		local fineAmount = Config.EarlyRespawnFineAmount

		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('respawn_bleedout_fine_msg', ESX.Math.GroupDigits(fineAmount)))
		xPlayer.removeAccountMoney('bank', fineAmount)
	end)
end

ESX.RegisterServerCallback('esx_ambulancejob:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem(item).count

	cb(quantity)
end)

ESX.RegisterServerCallback('esx_ambulancejob:buyJobVehicle', function(source, cb, vehicleProps, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = getPriceFromHash(vehicleProps.model, xPlayer.job.grade_name, type)

	-- vehicle model not found
	if price == 0 then
		print(('esx_ambulancejob: %s attempted to exploit the shop! (invalid vehicle model)'):format(xPlayer.identifier))
		cb(false)
	end

	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)
	
		MySQL.Async.execute('INSERT INTO owned_vehicles (owner, vehicle, plate, type, job, `stored`) VALUES (@owner, @vehicle, @plate, @type, @job, @stored)', {
			['@owner'] = xPlayer.identifier,
			['@vehicle'] = json.encode(vehicleProps),
			['@plate'] = vehicleProps.plate,
			['@type'] = type,
			['@job'] = xPlayer.job.name,
			['@stored'] = true
		}, function (rowsChanged)
			cb(true)
		end)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_ambulancejob:storeNearbyVehicle', function(source, cb, nearbyVehicles)
	local xPlayer = ESX.GetPlayerFromId(source)
	local foundPlate, foundNum

	for k,v in ipairs(nearbyVehicles) do
		local result = MySQL.Sync.fetchAll('SELECT plate FROM owned_vehicles WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = v.plate,
			['@job'] = xPlayer.job.name
		})

		if result[1] then
			foundPlate, foundNum = result[1].plate, k
			break
		end
	end

	if not foundPlate then
		cb(false)
	else
		MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = true WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = foundPlate,
			['@job'] = xPlayer.job.name
		}, function (rowsChanged)
			if rowsChanged == 0 then
				print(('esx_ambulancejob: %s has exploited the garage!'):format(xPlayer.identifier))
				cb(false)
			else
				cb(true, foundNum)
			end
		end)
	end

end)

function getPriceFromHash(hashKey, jobGrade, type)
	if type == 'helicopter' then
		local vehicles = Config.AuthorizedHelicopters[jobGrade]

		for k,v in ipairs(vehicles) do
			if GetHashKey(v.model) == hashKey then
				return v.price
			end
		end
	elseif type == 'car' then
		local vehicles = Config.AuthorizedVehicles[jobGrade]

		for k,v in ipairs(vehicles) do
			if GetHashKey(v.model) == hashKey then
				return v.price
			end
		end
	end

	return 0
end

RegisterServerEvent('esx_ambulancejob:removeItem')
AddEventHandler('esx_ambulancejob:removeItem', function(item)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem(item, 1)

	if item == 'bandage' then
		TriggerClientEvent('esx:showNotification', _source, _U('used_bandage'))
	elseif item == 'medikit' then
		TriggerClientEvent('esx:showNotification', _source, _U('used_medikit'))
	end

	local sendToDiscord = '' .. xPlayer.name .. ' ใช้ ' .. ESX.GetItemLabel(item) .. ' จำนวน 1'
	TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'DocRemoveItem', sendToDiscord, xPlayer.source, '^2')
end)

RegisterServerEvent('esx_ambulancejob:giveItem')
AddEventHandler('esx_ambulancejob:giveItem', function(itemName)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'ambulance' then
		print(('esx_ambulancejob: %s attempted to spawn in an item!'):format(xPlayer.identifier))
		return
	elseif (itemName ~= 'medikit' and itemName ~= 'bandage' and itemName ~= 'fixkit' and itemName ~= 'antistress'and itemName ~= 'anesthetic1'and itemName ~= 'anesthetic2') then
		print(('esx_ambulancejob: %s attempted to spawn in an item!'):format(xPlayer.identifier))
		return
	end

	local xItem = xPlayer.getInventoryItem(itemName)
	local count = 1

	if xItem.limit ~= -1 then
		count = 1
	end

	if xItem.count < xItem.limit then
		xPlayer.addInventoryItem(itemName, count)
		xPlayer.removeMoney(50)
	
		local sendToDiscord = '' .. xPlayer.name .. ' เบิก ' .. xItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(count) .. ''
		TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'DocGiveItem', sendToDiscord, xPlayer.source, '^2')
	else
		TriggerClientEvent('esx:showNotification', source, _U('max_item'))
	end
end)

-- RegisterCommand('heal', function(source, args, user)
-- 	local xPlayer = ESX.GetPlayerFromId(source)
-- 	if xPlayer.getGroup() == 'admin' then
-- 		-- heal another player - don't heal source
-- 		if args[1] then
-- 			local target = tonumber(args[1])
-- 			
-- 			-- is the argument a number?
-- 			if target ~= nil then
-- 				
-- 				-- is the number a valid player?
-- 				if GetPlayerName(target) then
-- 					--print('คุณถูกฮิวโดยแอดมิน : ' .. GetPlayerName(source) .. ' เลือดคุณเต็มแล้ว')
-- 					TriggerClientEvent('esx_basicneeds:healPlayer', target)
-- 					TriggerClientEvent('chatMessage', target, "Server", {223, 66, 244}, "เลี้ยงข้าวเลี้ยงน้ำฟรี!")
-- 				else
-- 					TriggerClientEvent('chatMessage', source, "Server", {255, 0, 0}, "ไม่พบผู้เล่นที่ออนไลน์!")
-- 				end
-- 			else
-- 				TriggerClientEvent('chatMessage', source, "HEAL", {255, 0, 0}, "Incorrect syntax! You must provide a valid player ID")
-- 			end
-- 		else
-- 			-- heal source
-- 			print('esx_basicneeds: ' .. GetPlayerName(source) .. ' is healing!')
-- 			TriggerClientEvent('esx_basicneeds:healPlayer', source)
-- 		end
-- 	end
-- end)

RegisterCommand('revive', function(source, args, user)
		local xPlayer = ESX.GetPlayerFromId(source)
		if xPlayer.getGroup() == 'admin' then
		if args[1] ~= nil then
			if GetPlayerName(tonumber(args[1])) ~= nil then
				print(('คุณถูกชุบโดยแอดมิน'):format(GetPlayerIdentifiers(source)[1]))
				TriggerClientEvent('esx_ambulancejob:revive', tonumber(args[1]))
			end
		else
			TriggerClientEvent('esx_ambulancejob:revive', source)
		end
	end
end)

RegisterCommand('reviveall', function(source, args, user)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getGroup() == 'admin' then
		TriggerClientEvent('esx_ambulancejob:revive', -1)
	end
end)

RegisterCommand('rv', function(source, args, user)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.job.name == 'ambulance' then
    TriggerClientEvent('esx_ambulancejob:revive', _source)
    else
    TriggerClientEvent("pNotify:SendNotification",source,
        {text = " <center><b style ='color:yellow'>คุณไม่ใช่หมอใช้คำสั่งนี้ไม่ได้นะครับ ",
        type = "alert", timeout = 5000, 
        layout = "bottomCenter"})
    end
end)

ESX.RegisterUsableItem('medikit', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('medikit', 1)
	
		playersHealing[source] = true
		TriggerClientEvent('esx_ambulancejob:useItem', source, 'medikit')

		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterUsableItem('bandage', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('bandage', 1)
	
		playersHealing[source] = true
		TriggerClientEvent('esx_ambulancejob:useItem', source, 'bandage')

		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterServerCallback('esx_ambulancejob:getDeathStatus', function(source, cb)
	local identifier = GetPlayerIdentifiers(source)[1]

	MySQL.Async.fetchScalar('SELECT is_dead FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(isDead)
		if isDead then
			print(('esx_ambulancejob: %s attempted combat logging!'):format(identifier))
		end

		cb(isDead)
	end)
end)

RegisterServerEvent('esx_ambulancejob:setDeathStatus')
AddEventHandler('esx_ambulancejob:setDeathStatus', function(isDead)
	local identifier = GetPlayerIdentifiers(source)[1]

	if type(isDead) ~= 'boolean' then
		print(('esx_ambulancejob: %s attempted to parse something else than a boolean to setDeathStatus!'):format(identifier))
		return
	end

	MySQL.Sync.execute('UPDATE users SET is_dead = @isDead WHERE identifier = @identifier', {
		['@identifier'] = identifier,
		['@isDead'] = isDead
	})
end)



RegisterServerEvent('MedicxD:ReviveMe')
AddEventHandler('MedicxD:ReviveMe', function()
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	TriggerClientEvent('esx_ambulancejob:revive', source)
end)

RegisterServerEvent('esx_ambulancejob:removeblips')
AddEventHandler('esx_ambulancejob:removeblips', function(target)
	TriggerClientEvent('esx_ambulancejob:removeblips', target)
end)

AddEventHandler('playerDropped', function()
	-- Save the source in case we lose it (which happens a lot)
	local _source = source
	
	-- Did the player ever join?
	if _source ~= nil then
		local xPlayer = ESX.GetPlayerFromId(_source)
		
		-- Is it worth telling all clients to refresh?
		if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'ambulance' then
			Citizen.Wait(5000)
			TriggerClientEvent('esx_ambulancejob:updateBlip', -1)
		end
	end	
end)

RegisterServerEvent('esx_ambulancejob:spawned')
AddEventHandler('esx_ambulancejob:spawned', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'ambulance' then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_policejob:updateBlip', -1)
	end
end)

RegisterServerEvent('esx_ambulancejob:forceBlip')
AddEventHandler('esx_ambulancejob:forceBlip', function()
	TriggerClientEvent('esx_ambulancejob:updateBlip', -1)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_ambulancejob:updateBlip', -1)
	end
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_ambulancejob:updateBlip', -1)
	end
end)

ESX.RegisterServerCallback('esx_ambulancejob:getOtherPlayerData', function(source, cb, target)

	if Config.EnableESXIdentity then

		local xPlayer = ESX.GetPlayerFromId(target)

		local result = MySQL.Sync.fetchAll('SELECT firstname, lastname, sex, dateofbirth, height FROM users WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		})

		local firstname = result[1].firstname
		local lastname  = result[1].lastname
		local sex       = result[1].sex
		local dob       = result[1].dateofbirth
		local height    = result[1].height

		local data = {
			name      = GetPlayerName(target),
			job       = xPlayer.job,
			inventory = xPlayer.inventory,
			accounts  = xPlayer.accounts,
			weapons   = xPlayer.loadout,
			firstname = firstname,
			lastname  = lastname,
			sex       = sex,
			dob       = dob,
			height    = height
		}

		TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)
			if status ~= nil then
				data.drunk = math.floor(status.percent)
			end
		end)

		if Config.EnableLicenses then
			TriggerEvent('esx_license:getLicenses', target, function(licenses)
				data.licenses = licenses
				cb(data)
			end)
		else
			cb(data)
		end

	else

		local xPlayer = ESX.GetPlayerFromId(target)

		local data = {
			name       = GetPlayerName(target),
			job        = xPlayer.job,
			inventory  = xPlayer.inventory,
			accounts   = xPlayer.accounts,
			weapons    = xPlayer.loadout
		}

		TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)
			if status ~= nil then
				data.drunk = math.floor(status.percent)
			end
		end)

		TriggerEvent('esx_license:getLicenses', target, function(licenses)
			data.licenses = licenses
		end)

		cb(data)

	end

end)


ESX.RegisterServerCallback('esx_ambulancejob:getOnduty', function(source, cb)
	local AmbulanceCount = 0
	
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

		if xPlayer.job.name == 'ambulance' then
			AmbulanceCount = AmbulanceCount + 1
		end

	end

	cb(AmbulanceCount)
end)



RegisterServerEvent('esx_ambulancejob:requestTalk')
AddEventHandler('esx_ambulancejob:requestTalk', function(target)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	-- print(target)
		TriggerClientEvent('esx_ambulancejob:requesToTalk', target,_source)
    	-- TriggerClientEvent('esx_ambulancejob:doarrested', _source)
	

end)

RegisterServerEvent('esx_ambulancejob:requestAccept')
AddEventHandler('esx_ambulancejob:requestAccept', function(target,status,time)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if status then 
		if time == 5 then 
			TriggerClientEvent('esx_ambulancejob:updateTalk', target,time)
		elseif time == 10 then
			TriggerClientEvent('esx_ambulancejob:updateTalk', target,time)
		elseif time == 500 then
			TriggerClientEvent('esx_ambulancejob:updateTalk', target,time)
		end
	else
		TriggerClientEvent('esx_ambulancejob:updateTalk', target,0)
	end
end)
