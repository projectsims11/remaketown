ESX = exports["es_extended"]:getSharedObject()

local script_name = GetCurrentResourceName()
ServerItems = {}
itemShopList = {}
ActionStatus = {}

RegisterServerEvent('yield_addon:inventory:setPlayer')
AddEventHandler('yield_addon:inventory:setPlayer', function(status)
    local playerId = source
    ActionStatus[playerId] = status
end)
-- RegisterServerEvent(script_name .. ':server:getdata')
-- AddEventHandler(script_name .. ':server:getdata', function()
-- 	local l = ESX.GetPlayerFromId(source)
-- 	if l ~= nil then
-- 		TriggerClientEvent(script_name .. ':client:getdata', source , l.maxWeight)
-- 	end
-- end)

-- if GetCurrentResourceName() ~= "Fxw_inventory" then
-- 	os.exit()
-- end


RegisterServerEvent('Fxw_inventory:closeInventoryhud')
AddEventHandler('Fxw_inventory:closeInventoryhud', function(target)
	TriggerClientEvent("Fxw_inventory:closeInventory", target)
end)


ESX.RegisterServerCallback('Fxw_inventory:getOwnerVehicle', function (source, cb)
-- RegisterServerEvent('Fxw_inventory:getOwnerVehicle')
-- AddEventHandler('Fxw_inventory:getOwnerVehicle', function()
	local _source = source
	local KeyItems = {}
	local xPlayer = ESX.GetPlayerFromId(source)

	KeyItems = MySQL.Sync.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @identifier', {
		['@identifier'] = xPlayer.identifier
	})

	cb(KeyItems)
	-- TriggerClientEvent("Fxw_inventory:setOwnerVehicle", _source, KeyItems)
end)




-- RegisterServerEvent('IPCH:playerLoad_SV')
-- AddEventHandler('IPCH:playerLoad_SV', function()
-- 	local xPlayer = ESX.GetPlayerFromId(source)

-- 	TriggerClientEvent('IPCH:loadAccounts', xPlayer.source, xPlayer.accounts)
-- end)

-- RegisterServerEvent('Fxw_inventory:getOwnerHouse')
-- AddEventHandler('Fxw_inventory:getOwnerHouse', function()
-- 	local _source = source
-- 	local HouseItems = {}
-- 	local xPlayer = ESX.GetPlayerFromId(source)

-- 	HouseItems = MySQL.Sync.fetchAll('SELECT * FROM owned_properties WHERE owner = @identifier', {
-- 		['@identifier'] = xPlayer.identifier
-- 	})

-- 	TriggerClientEvent("Fxw_inventory:setOwnerHouse", _source, HouseItems)

-- end)

RegisterServerEvent('Fxw_inventory:getOwnerAccessories')
AddEventHandler('Fxw_inventory:getOwnerAccessories', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local AccessoriesItems = {}

	-- Accessories Helmet หมวก
	local Result_Helmet = MySQL.Sync.fetchAll('SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type', {
		['@owner'] = xPlayer.identifier,
		['@type'] = 'player_helmet'
	})

	if Result_Helmet[1] then
		for k,v in pairs(Result_Helmet) do
			local skin = json.decode(v.skin)
			table.insert(AccessoriesItems, {
				label = v.label,
				count = 1,
				limit = -1,
				type = "item_accessories",
				id = v.id,
				name = "helmet",
				usable = true,
				rare = false,
				canRemove = false,
				itemnum = skin["helmet_1"],
				itemskin = skin["helmet_2"]
			})
		end
	end

	-- Accessories Mask หน้ากาก
	local Result_Mask = MySQL.Sync.fetchAll('SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type', {
		['@owner'] = xPlayer.identifier,
		['@type'] = 'player_mask'
	})

	if Result_Mask[1] then
		for k,v in pairs(Result_Mask) do
			local skin = json.decode(v.skin)
			table.insert(AccessoriesItems, {
				label = v.label,
				count = 1,
				limit = -1,
				type = "item_accessories",
				id = v.id,
				name = "mask",
				usable = true,
				rare = false,
				canRemove = false,
				itemnum = skin["mask_1"],
				itemskin = skin["mask_2"]
			})
		end
	end

	-- Accessories Glasses แว่นตา
	local Result_Glasses = MySQL.Sync.fetchAll('SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type', {
		['@owner'] = xPlayer.identifier,
		['@type'] = 'player_glasses'
	})

	if Result_Glasses[1] then
		for k,v in pairs(Result_Glasses) do
			local skin = json.decode(v.skin)
			table.insert(AccessoriesItems, {
				label = v.label,
				count = 1,
				limit = -1,
				type = "item_accessories",
				id = v.id,
				name = "glasses",
				usable = true,
				rare = false,
				canRemove = false,
				itemnum = skin["glasses_1"],
				itemskin = skin["glasses_2"]
			})
		end
	end

	-- Accessories Tshirt เสื้อยึด
	local Result_Tshirt = MySQL.Sync.fetchAll('SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type', {
		['@owner'] = xPlayer.identifier,
		['@type'] = 'player_tshirt'
	})

	if Result_Tshirt[1] then
		for k,v in pairs(Result_Tshirt) do
			local skin = json.decode(v.skin)
			table.insert(AccessoriesItems, {
				label = v.label,
				count = 1,
				limit = -1,
				type = "item_accessories",
				id = v.id,
				name = "tshirt",
				usable = true,
				rare = false,
				canRemove = false,
				itemnum = skin["tshirt_1"],
				itemskin = skin["tshirt_2"],
				itemnum3 = skin["torso_1"],
				itemskin3 = skin["torso_2"],
				itemnum2 = skin["arms"],
				itemskin2 = skin["arms_2"],
				itemnum4 = skin["decals_1"],
				itemskin4 = skin["decals_2"],
			})
		end
	end

	-- Accessories Pants กางเกง
	local Result_Pants = MySQL.Sync.fetchAll('SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type', {
		['@owner'] = xPlayer.identifier,
		['@type'] = 'player_pants'
	})

	if Result_Pants[1] then
		for k,v in pairs(Result_Pants) do
			local skin = json.decode(v.skin)
			table.insert(AccessoriesItems, {
				label = v.label,
				count = 1,
				limit = -1,
				type = "item_accessories",
				id = v.id,
				name = "pants",
				usable = true,
				rare = false,
				canRemove = false,
				itemnum = skin["pants_1"],
				itemskin = skin["pants_2"]
			})
		end
	end

	-- Accessories Shoes รองเท้า
	local Result_Shoes = MySQL.Sync.fetchAll('SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type', {
		['@owner'] = xPlayer.identifier,
		['@type'] = 'player_shoes'
	})

	if Result_Shoes[1] then
		for k,v in pairs(Result_Shoes) do
			local skin = json.decode(v.skin)
			table.insert(AccessoriesItems, {
				label = v.label,
				count = 1,
				limit = -1,
				type = "item_accessories",
				id = v.id,
				name = "shoes",
				usable = true,
				rare = false,
				canRemove = false,
				itemnum = skin["shoes_1"],
				itemskin = skin["shoes_2"]
			})
		end
	end
	
	-- Accessories Bags กระเป๋า
	local Result_Bags = MySQL.Sync.fetchAll('SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type', {
		['@owner'] = xPlayer.identifier,
		['@type'] = 'player_bags'
	})

	if Result_Bags[1] then
		for k,v in pairs(Result_Bags) do
			local skin = json.decode(v.skin)
			table.insert(AccessoriesItems, {
				label = v.label,
				count = 1,
				limit = -1,
				type = "item_accessories",
				id = v.id,
				name = "bags",
				usable = true,
				rare = false,
				canRemove = false,
				itemnum = skin["bags_1"],
				itemskin = skin["bags_2"]
			})
		end
	end

	-- Accessories Earring ต่างหู
	local Result_Earring = MySQL.Sync.fetchAll('SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type', {
		['@owner'] = xPlayer.identifier,
		['@type'] = 'player_ears'
	})

	if Result_Earring[1] then
		for k,v in pairs(Result_Earring) do
			local skin = json.decode(v.skin)
			table.insert(AccessoriesItems, {
				label = v.label,
				count = 1,
				limit = -1,
				type = "item_accessories",
				id = v.id,
				name = "earring",
				usable = true,
				rare = false,
				canRemove = false,
				itemnum = skin["ears_1"],
				itemskin = skin["ears_2"]
			})
		end
	end
	
	-- Accessories Bags เสื้อเกราะ
	local Result_bproof = MySQL.Sync.fetchAll('SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type', {
		['@owner'] = xPlayer.identifier,
		['@type'] = 'player_bproof'
	})

	if Result_bproof[1] then
		for k,v in pairs(Result_bproof) do
			local skin = json.decode(v.skin)
			table.insert(AccessoriesItems, {
				label = v.label,
				count = 1,
				limit = -1,
				type = "item_accessories",
				id = v.id,
				name = "bproof",
				usable = true,
				rare = false,
				canRemove = false,
				itemnum = skin["bproof_1"],
				itemskin = skin["bproof_2"]
			})
		end
	end
	
	-- Accessories Bags กระเป๋า
	local Result_chain = MySQL.Sync.fetchAll('SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type', {
		['@owner'] = xPlayer.identifier,
		['@type'] = 'player_chain'
	})

	if Result_chain[1] then
		for k,v in pairs(Result_chain) do
			local skin = json.decode(v.skin)
			table.insert(AccessoriesItems, {
				label = v.label,
				count = 1,
				limit = -1,
				type = "item_accessories",
				id = v.id,
				name = "chain",
				usable = true,
				rare = false,
				canRemove = false,
				itemnum = skin["chain_1"],
				itemskin = skin["chain_2"]
			})
		end
	end
	
	-- Accessories Bags กระเป๋า
	local Result_watches = MySQL.Sync.fetchAll('SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type', {
		['@owner'] = xPlayer.identifier,
		['@type'] = 'player_watches'
	})

	if Result_watches[1] then
		for k,v in pairs(Result_watches) do
			local skin = json.decode(v.skin)
			table.insert(AccessoriesItems, {
				label = v.label,
				count = 1,
				limit = -1,
				type = "item_accessories",
				id = v.id,
				name = "watches",
				usable = true,
				rare = false,
				canRemove = false,
				itemnum = skin["watches_1"],
				itemskin = skin["watches_2"]
			})
		end
	end
	
	-- Accessories Bags กระเป๋า
	local Result_bracelets = MySQL.Sync.fetchAll('SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type', {
		['@owner'] = xPlayer.identifier,
		['@type'] = 'player_bracelets'
	})

	if Result_bracelets[1] then
		for k,v in pairs(Result_bracelets) do
			local skin = json.decode(v.skin)
			table.insert(AccessoriesItems, {
				label = v.label,
				count = 1,
				limit = -1,
				type = "item_accessories",
				id = v.id,
				name = "bracelets",
				usable = true,
				rare = false,
				canRemove = false,
				itemnum = skin["bracelets_1"],
				itemskin = skin["bracelets_2"]
			})
		end
	end

	TriggerClientEvent("Fxw_inventory:setOwnerAccessories", _source, AccessoriesItems)

end)


-- RegisterServerEvent('Fxw_inventory:updatemask')
-- AddEventHandler('Fxw_inventory:updatemask', function(target, type, itemName)
-- 	print('asdasd')
-- 	local _source = source

-- 	local sourceXPlayer = ESX.GetPlayerFromId(_source)
-- 	local targetXPlayer = ESX.GetPlayerFromId(target)

-- 	local identifier = sourceXPlayer.identifier
-- 	local identifier_target = targetXPlayer.identifier

-- 	if type == "inventory_clothes" then

-- 		MySQL.Async.execute("UPDATE FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type",
-- 		{
-- 			['@owner'] = xPlayer.identifier,
-- 			['@type'] = 'player_glasses'
-- 		})
	
		
-- 		TriggerClientEvent("Fxw_inventory:getOwnerAccessories", targetXPlayer.source)
-- 		TriggerClientEvent("Fxw_inventory:getOwnerAccessories", sourceXPlayer.source)
		
-- 		Citizen.Wait(1000)

-- 		TriggerClientEvent("Fxw_inventory:refreshInventory", targetXPlayer.source)
-- 		TriggerClientEvent("Fxw_inventory:refreshInventory", sourceXPlayer.source)


	
-- 	end
-- end)

















RegisterServerEvent('Fxw_inventory:updateKey')
AddEventHandler('Fxw_inventory:updateKey', function(target, type, itemName)

	local _source = source

	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	local identifier = sourceXPlayer.identifier
	local identifier_target = targetXPlayer.identifier
	if type == "item_key" then

		MySQL.Async.execute("UPDATE owned_vehicles SET owner = @newplayer WHERE owner = @identifier AND plate = @plate",
		{
			['@identifier']		= identifier,
			['@newplayer']		= identifier_target,
			['@plate']		= itemName
		})
		
		TriggerClientEvent("pNotify:SendNotification", sourceXPlayer.source, {
			text = 'ส่ง <strong class="amber-text">กุญแจรถ</strong> ทะเบียน <strong class="yellow-text">'..itemName..'</strong>',
			type = "success",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		})
		TriggerClientEvent("pNotify:SendNotification", targetXPlayer.source, {
			text = 'ได้รับ <strong class="amber-text">กุญแจรถ</strong> ทะเบียน <strong class="yellow-text">'..itemName..'</strong>',
			type = "success",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		})
		
		TriggerClientEvent("Fxw_inventory:getOwnerVehicle", targetXPlayer.source)
		TriggerClientEvent("Fxw_inventory:getOwnerVehicle", sourceXPlayer.source)
		
		Citizen.Wait(1000)

		TriggerClientEvent("Fxw_inventory:refreshInventory", targetXPlayer.source)
		TriggerClientEvent("Fxw_inventory:refreshInventory", sourceXPlayer.source)

		local sendToDiscord = '' .. sourceXPlayer.name .. ' ส่ง กุญแจรถ ทะเบียน ' .. itemName .. ' ไปยัง ' .. targetXPlayer.name .. ''
		--TriggerEvent('azael_discordlogs:sendToDiscord', 'GiveKey', sendToDiscord, _source, '^3')
		Discord(sourceXPlayer.identifier,targetXPlayer.identifier, sendToDiscord, 15158332)
		Citizen.Wait(100)

		
		local sendToDiscord2 = '' .. targetXPlayer.name .. ' ได้รับ กุญแจรถ ทะเบียน ' .. itemName .. ' จาก ' .. sourceXPlayer.name .. ''
		Discord(sourceXPlayer.identifier,targetXPlayer.identifier, sendToDiscord2, 6737152)
		--TriggerEvent('azael_discordlogs:sendToDiscord', 'GiveKey', sendToDiscord2, target, '^2')
	elseif type == "item_keyhouse" then -- MEETA GiveKeyHouse

		MySQL.Async.execute("UPDATE owned_properties SET owner = @newplayer WHERE owner = @identifier AND id = @id",
		{
			['@identifier']		= identifier,
			['@newplayer']		= identifier_target,
			['@id']		= itemName
		})

		TriggerClientEvent("pNotify:SendNotification", source, {
			text = 'ส่ง <strong class="amber-text">กุญแจบ้าน</strong>',
			type = "success",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		})
		TriggerClientEvent("pNotify:SendNotification", target, {
			text = 'ได้รับ <strong class="amber-text">กุญแจบ้าน</strong>',
			type = "success",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		})
		
		TriggerClientEvent("Fxw_inventory:getOwnerHouse", targetXPlayer.source)
		TriggerClientEvent("Fxw_inventory:getOwnerHouse", sourceXPlayer.target)

		Citizen.Wait(1000)

		local sendToDiscord = '' .. sourceXPlayer.name .. ' ส่ง กุญแจบ้าน ' .. itemName .. ' ไปยัง ' .. targetXPlayer.name .. ''
		--TriggerEvent('azael_discordlogs:sendToDiscord', 'GiveKey', sendToDiscord, _source, '^3')
		Discord(sourceXPlayer.identifier,targetXPlayer.identifier, sendToDiscord, 15158332)
		Citizen.Wait(100)

		local sendToDiscord2 = '' .. targetXPlayer.name .. ' ได้รับ กุญแจบ้าน ' .. itemName .. ' จาก ' .. sourceXPlayer.name .. ''
		Discord(sourceXPlayer.identifier,targetXPlayer.identifier, sendToDiscord2, 6737152)
		--TriggerEvent('azael_discordlogs:sendToDiscord', 'GiveKey', sendToDiscord2, target, '^2')
	end
end)

RegisterNetEvent("esx:onAddInventoryItem")
AddEventHandler("esx:onAddInventoryItem",function(souce,items,count)
    TriggerClientEvent("Fxw_inventory:addInventoryItem",souce,items.name,count,ESX.GetItemLabel(items))
end)

RegisterNetEvent("esx:onRemoveInventoryItem")
AddEventHandler("esx:onRemoveInventoryItem",function(souce,items,count)
	TriggerClientEvent("Fxw_inventory:removeInventoryItem",souce,items.name,count,ESX.GetItemLabel(items))
end)

ESX.RegisterServerCallback("Fz_inventoryhud:getPlayerInventory", function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)
	local Inventory = xPlayer.inventory

	if xPlayer ~= nil then
		cb({inventory = Inventory, money = xPlayer.getMoney(), accounts = xPlayer.accounts, weapons = xPlayer.loadout})
	else
		cb(nil)
	end
end)


------- ค้นตัว  --------
-- ESX.RegisterServerCallback("Fxw_inventory:getPlayerSearchInventory", function(source, cb, target)
-- 	local xPlayer = ESX.GetPlayerFromId(target)
-- 	local Inventory = xPlayer.inventory

-- 	if xPlayer ~= nil then
-- 		cb({inventory = Inventory, money = xPlayer.getMoney(), accounts = xPlayer.accounts, weapons = xPlayer.loadout})
-- 	else
-- 		cb(nil)
-- 	end
-- end)

------- ค้นตัว  --------
-- end add

ESX.RegisterServerCallback(
	"Fxw_inventory:getPlayerInventory",
	function(source, cb, target)
		local targetXPlayer = ESX.GetPlayerFromId(target)

		if targetXPlayer ~= nil then
			cb({inventory = targetXPlayer.getInventory(true), money = targetXPlayer.getMoney(), accounts = targetXPlayer.accounts, weapons = targetXPlayer.loadout})
		else
			cb(nil)
		end
	end
)





-- ESX.RegisterServerCallback("Fxw_inventory:getPlayerInventory", function(source, cb, target)
-- 	local xPlayer = ESX.GetPlayerFromId(target)
-- 	-- local Inventory = xPlayer.inventory

-- 	if xPlayer ~= nil then
		
-- 		cb({inventory = xPlayer.Inventory, money = xPlayer.getMoney(), accounts = xPlayer.accounts, weapons = xPlayer.loadout})
-- 	else
-- 		cb(nil)
-- 	end
-- end)



-- TriggerEvent('es:addGroupCommand', 'openinventory', "admin", function(source, args, user)
-- 	if args[1] then
-- 		local xPlayer = ESX.GetPlayerFromId(args[1])

-- 		if xPlayer then
-- 			TriggerClientEvent("Fxw_inventory:openPlayerInventory", source, xPlayer)
-- 		else
-- 			TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, _U('player_not_online'))
-- 		end
-- 	else
-- 		TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, _U('id_not_number'))
-- 	end
-- end, function(source, args, user)
-- 	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, _U('no_permission'))
-- end)

RegisterServerEvent('Fxw_inventory:black_money')
AddEventHandler('Fxw_inventory:black_money', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeAccountMoney('black_money', 0)
end)

RegisterServerEvent("Fxw_inventory:tradePlayerItem")
AddEventHandler("Fxw_inventory:tradePlayerItem",function(from, target, type, itemName, itemCount, eventType)
	local _source = from
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if xPlayer.job.name == 'police' or xPlayer.job.name == "gouvernment" or xPlayer.group == 'admin' or xPlayer.group == 'superadmin' then
		if type == "item_standard" then
			local sourceItem = sourceXPlayer.getInventoryItem(itemName)
			local targetItem = targetXPlayer.getInventoryItem(itemName) 

			if itemCount > 0 and sourceItem.count >= itemCount then
				if targetItem.limit ~= -1 and (targetItem.count + itemCount) > targetItem.limit then
				-- if not targetXPlayer.canCarryItem(itemName, itemCount) then
				 print('Weight not')
				-- 	-- ข้อความ
				-- 	-- exports['mythic_notify']:SendAlert('error', 'กระเป๋าของคุณนํ้าหนักเต็ม ! ! !', 3000)
					xPlayer.triggerEvent("mythic_notify:client:SendAlert",{
						text = 'ไม่สามารถดึงของได้ เนื่องจากกระเป๋าผู้รับเต็ม',
						type = "error",
						timeout = 3000,
					})
				else
					sourceXPlayer.removeInventoryItem(itemName, itemCount)
					TriggerClientEvent('pNotify:SendNotification', sourceXPlayer, { type = 'true', text = _U('item_removed') .. itemName})
					targetXPlayer.addInventoryItem(itemName, itemCount)
					TriggerClientEvent('pNotify:SendNotification', targetXPlayer, { type = 'true', text = _U('item_added') .. itemName})

					if eventType == 'police_take' then -- ตำรวจ-ยึด-ไอเทม
						local sendToDiscord = '' .. targetXPlayer.name .. ' ยึด ' .. targetItem.label .. ' จาก ' .. sourceXPlayer.name .. ' จำนวน ' .. ESX.Math.GroupDigits(itemCount) .. ''
						TriggerEvent('azael_discordlogs:sendToDiscord', 'PoliceTakeItem', sendToDiscord, targetXPlayer.source, '^2')
		
						Citizen.Wait(100)
					
						local sendToDiscord2 = '' .. sourceXPlayer.name .. ' ถูกยึด ' .. targetItem.label .. ' โดย ' .. targetXPlayer.name .. ' จำนวน ' .. ESX.Math.GroupDigits(itemCount) .. ''
						TriggerEvent('azael_discordlogs:sendToDiscord', 'PoliceTakeItem', sendToDiscord2, sourceXPlayer.source, '^3')
					elseif eventType == 'police_put' then -- ตำรวจ-ยัด-ไอเทม

						local sendToDiscord = '' .. sourceXPlayer.name .. ' ยัด ' .. targetItem.label .. ' ไปยัง ' .. targetXPlayer.name .. ' จำนวน ' .. ESX.Math.GroupDigits(itemCount) .. ''
						TriggerEvent('azael_discordlogs:sendToDiscord', 'PolicePutItem', sendToDiscord, sourceXPlayer.source, '^2')
		
						Citizen.Wait(100)
																
						local sendToDiscord2 = '' .. targetXPlayer.name .. ' ถูกยัด ' .. targetItem.label .. ' โดย ' .. sourceXPlayer.name .. ' จำนวน ' .. ESX.Math.GroupDigits(itemCount) .. ''
						TriggerEvent('azael_discordlogs:sendToDiscord', 'PolicePutItem', sendToDiscord2, targetXPlayer.source, '^3')
					end
				end
			end
		elseif type == "item_money" then
			if itemCount > 0 and sourceXPlayer.getMoney() >= itemCount then
				sourceXPlayer.removeMoney(itemCount)
				TriggerClientEvent('pNotify:SendNotification', sourceXPlayer, { type = 'true', text = _U('money_removed') .. itemCount})
				targetXPlayer.addMoney(itemCount)
				TriggerClientEvent('pNotify:SendNotification', targetXPlayer, { type = 'true', text = _U('money_added') .. itemCount})

				if eventType == 'police_take' then -- ตำรวจ-ยึด-เงินเขียว
					local sendToDiscord = '' .. targetXPlayer.name .. ' ยึด ' .. itemName .. ' จาก ' .. sourceXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
					TriggerEvent('azael_discordlogs:sendToDiscord', 'PoliceTakeMoney', sendToDiscord, targetXPlayer.source, '^3')
	
					Citizen.Wait(100)
										
					local sendToDiscord2 = '' .. sourceXPlayer.name .. ' ถูกยึด ' .. itemName .. ' โดย ' .. targetXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
					TriggerEvent('azael_discordlogs:sendToDiscord', 'PoliceTakeMoney', sendToDiscord2, sourceXPlayer.source, '^2')
				elseif eventType == 'police_put' then -- ตำรวจ-ยัด-เงินเขียว
					local sendToDiscord = '' .. sourceXPlayer.name .. ' ยัด ' .. itemName .. ' ไปยัง ' .. targetXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
					TriggerEvent('azael_discordlogs:sendToDiscord', 'PolicePutMoney', sendToDiscord, sourceXPlayer.source, '^3')
	
					Citizen.Wait(100)
										
					local sendToDiscord2 = '' .. targetXPlayer.name .. ' ถูกยัด ' .. itemName .. ' โดย ' .. sourceXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
					TriggerEvent('azael_discordlogs:sendToDiscord', 'PolicePutMoney', sendToDiscord2, targetXPlayer.source, '^2')
				end
			end
		elseif type == "item_account" then
			if itemCount > 0 and sourceXPlayer.getAccount(itemName).money >= itemCount then
				sourceXPlayer.removeAccountMoney(itemName, itemCount)
				TriggerClientEvent('pNotify:SendNotification', sourceXPlayer, { type = 'true', text = _U('money_removed') .. itemCount .. itemName})
				targetXPlayer.addAccountMoney(itemName, itemCount)
				TriggerClientEvent('pNotify:SendNotification', targetXPlayer, { type = 'true', text = _U('money_added') .. itemCount .. itemName})

				if eventType == 'police_take' then -- ตำรวจ-ยึด-เงินแดง
					local sendToDiscord = '' .. targetXPlayer.name .. ' ยึด ' .. itemName .. ' จาก ' .. sourceXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
					TriggerEvent('azael_discordlogs:sendToDiscord', 'PoliceTakeMoney', sendToDiscord, targetXPlayer.source, '^3')
	
					Citizen.Wait(100)
										
					local sendToDiscord2 = '' .. sourceXPlayer.name .. ' ถูกยึด ' .. itemName .. ' โดย ' .. targetXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
					TriggerEvent('azael_discordlogs:sendToDiscord', 'PoliceTakeMoney', sendToDiscord2, sourceXPlayer.source, '^2')
				elseif eventType == 'police_put' then -- ตำรวจ-ยัด-เงินแดง
					local sendToDiscord = '' .. sourceXPlayer.name .. ' ยัด ' .. itemName .. ' ไปยัง ' .. targetXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
					TriggerEvent('azael_discordlogs:sendToDiscord', 'PolicePutMoney', sendToDiscord, sourceXPlayer.source, '^3')
	
					Citizen.Wait(100)
										
					local sendToDiscord2 = '' .. targetXPlayer.name .. ' ถูกยัด ' .. itemName .. ' โดย ' .. sourceXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
					TriggerEvent('azael_discordlogs:sendToDiscord', 'PolicePutMoney', sendToDiscord2, targetXPlayer.source, '^2')
				end
			end
		elseif type == "item_weapon" then	
			print(eventType)    
			if not targetXPlayer.hasWeapon(itemName, itemCount) then
				sourceXPlayer.removeWeapon(itemName, itemCount)
				TriggerClientEvent('pNotify:SendNotification', sourceXPlayer, { type = 'true', text = _U('weapon_removed') .. itemName})
				targetXPlayer.addWeapon(itemName, itemCount)
				TriggerClientEvent('pNotify:SendNotification', targetXPlayer, { type = 'true', text = _U('waepon_added') .. itemName})
				
				if eventType == 'police_take' then -- ตำรวจ-ยึด-อาวุธ
					local weaponLabel = ESX.GetWeaponLabel(itemName)
					if itemCount >= 0 then
						local sendToDiscord = '' .. targetXPlayer.name .. ' ยึด ' .. weaponLabel .. ' จาก ' .. sourceXPlayer.name .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(itemCount) .. ''
						TriggerEvent('azael_discordlogs:sendToDiscord', 'PoliceTakeWeapon', sendToDiscord, targetXPlayer.source, '^3')
					
						Citizen.Wait(100)
									
						local sendToDiscord2 = '' .. sourceXPlayer.name .. ' ถูกยึด ' .. weaponLabel .. ' โดย ' .. targetXPlayer.name .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(itemCount) .. ''
						TriggerEvent('azael_discordlogs:sendToDiscord', 'PoliceTakeWeapon', sendToDiscord2, sourceXPlayer.source, '^2')
					else
						local sendToDiscord = '' .. targetXPlayer.name .. ' ยึด ' .. weaponLabel .. ' จาก ' .. sourceXPlayer.name .. '  จำนวน 1'
						TriggerEvent('azael_discordlogs:sendToDiscord', 'PoliceTakeWeapon', sendToDiscord, targetXPlayer.source, '^3')
					
						Citizen.Wait(100)
									
						local sendToDiscord2 = '' .. sourceXPlayer.name .. ' ถูกยึด ' .. weaponLabel .. ' โดย ' .. targetXPlayer.name .. ' จำนวน 1'
						TriggerEvent('azael_discordlogs:sendToDiscord', 'PoliceTakeWeapon', sendToDiscord2, sourceXPlayer.source, '^2')
					end
				elseif eventType == 'police_put' then -- ตำรวจ-ยัด-อาวุธ
					local weaponLabel = ESX.GetWeaponLabel(itemName)
					if itemCount >= 0 then
						local sendToDiscord = '' .. sourceXPlayer.name .. ' ยัด ' .. weaponLabel .. ' ไปยัง ' .. targetXPlayer.name .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(itemCount) .. ''
						TriggerEvent('azael_discordlogs:sendToDiscord', 'PolicePutWeapon', sendToDiscord, sourceXPlayer.source, '^3')
					
						Citizen.Wait(100)
									
						local sendToDiscord2 = '' .. targetXPlayer.name .. ' ถูกยัด ' .. weaponLabel .. ' โดย ' .. sourceXPlayer.name .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(itemCount) .. ''
						TriggerEvent('azael_discordlogs:sendToDiscord', 'PolicePutWeapon', sendToDiscord2, targetXPlayer.source, '^2')
					else
						local sendToDiscord = '' .. sourceXPlayer.name .. ' ยัด ' .. weaponLabel .. ' ไปยัง ' .. targetXPlayer.name .. '  จำนวน 1'
						TriggerEvent('azael_discordlogs:sendToDiscord', 'PolicePutWeapon', sendToDiscord, sourceXPlayer.source, '^3')
					
						Citizen.Wait(100)
									
						local sendToDiscord2 = '' .. targetXPlayer.name .. ' ถูกยัด ' .. weaponLabel .. ' โดย ' .. sourceXPlayer.name .. ' จำนวน 1'
						TriggerEvent('azael_discordlogs:sendToDiscord', 'PolicePutWeapon', sendToDiscord2, targetXPlayer.source, '^2')
					end
				end
			end
		end
	else 
		for k,v in ipairs(Config.NewPlayer) do 
			if sourceXPlayer.getInventoryItem(v) ~= nil then 
				local countitemguarantee  = sourceXPlayer.getInventoryItem(v).count
				if countitemguarantee > 0 then
					-- TriggerClientEvent("pNotify:SendNotification", target, {
					-- 	text = 'ผู้เล่นเป็นผู้เล่นใหม่ไม่สามารถปล้นได้!',
					-- 	type = "error",
					-- 	queue = "global",
					-- 	timeout = 3000,
					-- 	layout = "bottomCenter"
					-- })
					-- exports['mythic_notify']:SendAlert('error', 'ผู้เล่นเป็นผู้เล่นใหม่ไม่สามารถปล้นได้ ! ! !', 3000)
					xPlayer.triggerEvent("mythic_notify:client:SendAlert",{
						text = 'ผู้เล่นเป็นผู้เล่นใหม่ไม่สามารถปล้นได้',
						type = "error",
						timeout = 3000,
					})
					return
				end
			end
		end
		if type == "item_standard" then ---------------------------------------------------------------- log ปล้น
			local sourceItem = sourceXPlayer.getInventoryItem(itemName)
			local targetItem = targetXPlayer.getInventoryItem(itemName)
			if itemCount > 0 and sourceItem.count >= itemCount then
				if itemAllow[targetItem.name] then
					-- TriggerClientEvent("pNotify:SendNotification", target, {
					-- 	text = "ของชิ้นนี้ไม่สามารถปล้นได้!",
					-- 	type = "error",
					-- 	queue = "global",
					-- 	timeout = 3000,
					-- 	layout = "bottomCenter"
					-- })
					-- exports['mythic_notify']:SendAlert('error', 'ของชิ้นนี้ไม่สามารถปล้นได้ ! ! !', 3000)
					xPlayer.triggerEvent("mythic_notify:client:SendAlert",{
						text = 'ของชิ้นนี้ไม่สามารถปล้นได้',
						type = "error",
						timeout = 3000,
					})
				else
					sourceXPlayer.removeInventoryItem(itemName, itemCount)
					TriggerClientEvent('pNotify:SendNotification', sourceXPlayer, { type = 'true', text = _U('item_removed') .. itemName})
					targetXPlayer.addInventoryItem(itemName, itemCount)
					TriggerClientEvent('pNotify:SendNotification', targetXPlayer, { type = 'true', text = _U('item_added') .. itemName})

					if eventType == 'police_take' then -- ตำรวจ-ยึด-ไอเทม
						local sendToDiscord = '' .. targetXPlayer.name .. ' ยึด ' .. targetItem.label .. ' จาก ' .. sourceXPlayer.name .. ' จำนวน ' .. ESX.Math.GroupDigits(itemCount) .. ''
						TriggerEvent('azael_discordlogs:sendToDiscord', 'thiefTakeItem', sendToDiscord, targetXPlayer.source, '^2')
		
						Citizen.Wait(100)
																
						local sendToDiscord2 = '' .. sourceXPlayer.name .. ' ถูกยึด ' .. targetItem.label .. ' โดย ' .. targetXPlayer.name .. ' จำนวน ' .. ESX.Math.GroupDigits(itemCount) .. ''
						TriggerEvent('azael_discordlogs:sendToDiscord', 'thiefTakeItem', sendToDiscord2, sourceXPlayer.source, '^3')
					elseif playerType == 'police_put' then -- ตำรวจ-ยัด-ไอเทม
						local sendToDiscord = '' .. sourceXPlayer.name .. ' ยัด ' .. targetItem.label .. ' ไปยัง ' .. targetXPlayer.name .. ' จำนวน ' .. ESX.Math.GroupDigits(itemCount) .. ''
						TriggerEvent('azael_discordlogs:sendToDiscord', 'thiefPutItem', sendToDiscord, sourceXPlayer.source, '^2')
		
						Citizen.Wait(100)
																
						local sendToDiscord2 = '' .. targetXPlayer.name .. ' ถูกยัด ' .. targetItem.label .. ' โดย ' .. sourceXPlayer.name .. ' จำนวน ' .. ESX.Math.GroupDigits(itemCount) .. ''
						TriggerEvent('azael_discordlogs:sendToDiscord', 'thiefPutItem', sendToDiscord2, targetXPlayer.source, '^3')
					end
				end
			end
		elseif type == "item_money" then
			if itemCount > 0 and sourceXPlayer.getMoney() >= itemCount then
				sourceXPlayer.removeMoney(itemCount)
				TriggerClientEvent('pNotify:SendNotification', sourceXPlayer, { type = 'true', text = _U('money_removed') .. itemCount})
				targetXPlayer.addMoney(itemCount)
				TriggerClientEvent('pNotify:SendNotification', targetXPlayer, { type = 'true', text = _U('money_added') .. itemCount})

				if eventType == 'police_take' then -- ตำรวจ-ยึด-เงินเขียว
					local sendToDiscord = '' .. targetXPlayer.name .. ' ยึด ' .. itemName .. ' จาก ' .. sourceXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
					TriggerEvent('azael_discordlogs:sendToDiscord', 'PoliceTakeMoney', sendToDiscord, targetXPlayer.source, '^3')
	
					Citizen.Wait(100)
										
					local sendToDiscord2 = '' .. sourceXPlayer.name .. ' ถูกยึด ' .. itemName .. ' โดย ' .. targetXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
					TriggerEvent('azael_discordlogs:sendToDiscord', 'PoliceTakeMoney', sendToDiscord2, sourceXPlayer.source, '^2')
				elseif playerType == 'police_put' then -- ตำรวจ-ยัด-เงินเขียว
					local sendToDiscord = '' .. sourceXPlayer.name .. ' ยัด ' .. itemName .. ' ไปยัง ' .. targetXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
					TriggerEvent('azael_discordlogs:sendToDiscord', 'thiefPutMoney', sendToDiscord, sourceXPlayer.source, '^3')
	
					Citizen.Wait(100)
										
					local sendToDiscord2 = '' .. targetXPlayer.name .. ' ถูกยัด ' .. itemName .. ' โดย ' .. sourceXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
					TriggerEvent('azael_discordlogs:sendToDiscord', 'thiefPutMoney', sendToDiscord2, targetXPlayer.source, '^2')
				end
			end
		elseif type == "item_account" then
			if itemCount > 0 and sourceXPlayer.getAccount(itemName).money >= itemCount then
				sourceXPlayer.removeAccountMoney(itemName, itemCount)
				TriggerClientEvent('pNotify:SendNotification', sourceXPlayer, { type = 'true', text = _U('money_removed') .. itemCount .. itemName})
				targetXPlayer.addAccountMoney(itemName, itemCount)
				TriggerClientEvent('pNotify:SendNotification', targetXPlayer, { type = 'true', text = _U('money_added') .. itemCount .. itemName})

				if eventType == 'police_take' then -- ตำรวจ-ยึด-เงินแดง
					local sendToDiscord = '' .. targetXPlayer.name .. ' ยึด ' .. itemName .. ' จาก ' .. sourceXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
					TriggerEvent('azael_discordlogs:sendToDiscord', 'thiefTakeMoney', sendToDiscord, targetXPlayer.source, '^3')
	
					Citizen.Wait(100)
										
					local sendToDiscord2 = '' .. sourceXPlayer.name .. ' ถูกยึด ' .. itemName .. ' โดย ' .. targetXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
					TriggerEvent('azael_discordlogs:sendToDiscord', 'thiefTakeMoney', sendToDiscord2, sourceXPlayer.source, '^2')
				elseif playerType == 'police_put' then -- ตำรวจ-ยัด-เงินแดง
					local sendToDiscord = '' .. sourceXPlayer.name .. ' ยัด ' .. itemName .. ' ไปยัง ' .. targetXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
					TriggerEvent('azael_discordlogs:sendToDiscord', 'thiefPutMoney', sendToDiscord, sourceXPlayer.source, '^3')
	
					Citizen.Wait(100)
										
					local sendToDiscord2 = '' .. targetXPlayer.name .. ' ถูกยัด ' .. itemName .. ' โดย ' .. sourceXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
					TriggerEvent('azael_discordlogs:sendToDiscord', 'thiefPutMoney', sendToDiscord2, targetXPlayer.source, '^2')
				end
			end ----------------------------------------------------------------
		elseif type == "item_weapon" then	 
			TriggerClientEvent("pNotify:SendNotification", target, {
				text = "อาวุธทุกชิ้นไม่สามารถปล้นได้",
				type = "error",
				queue = "global",
				timeout = 3000,
				layout = "bottomCenter"
			})
		end
	end
end)

-- RegisterServerEvent("Fxw_inventory:tradePlayerItem")
-- AddEventHandler("Fxw_inventory:tradePlayerItem",function(from, target, type, itemName, itemCount, eventType)
-- 	local _source = from
-- 	local xPlayer = ESX.GetPlayerFromId(source)
-- 	local sourceXPlayer = ESX.GetPlayerFromId(_source)
-- 	local targetXPlayer = ESX.GetPlayerFromId(target)

-- 	if xPlayer.job.name == 'police' or xPlayer.job.name == "gouvernment" or xPlayer.group == 'admin' or xPlayer.group == 'superadmin' then
-- 		if type == "item_standard" then
-- 			local sourceItem = sourceXPlayer.getInventoryItem(itemName)
-- 			local targetItem = targetXPlayer.getInventoryItem(itemName) 

-- 			if itemCount > 0 and sourceItem.count >= itemCount then
-- 			if targetItem.limit ~= -1 and (targetItem.count + itemCount) > targetItem.limit then
-- 				-- if not targetXPlayer.canCarryItem(itemName, itemCount) then
-- 				-- 	-- print('Weight not')
-- 				-- 	-- ข้อความ
-- 				-- 	-- exports['mythic_notify']:SendAlert('error', 'กระเป๋าของคุณนํ้าหนักเต็ม ! ! !', 3000)
-- 					xPlayer.triggerEvent("mythic_notify:client:SendAlert",{
-- 						text = 'ไอเท็มเต็ม ! ! !',
-- 						type = "error",
-- 						timeout = 3000,
-- 					})

					
-- 			-- TriggerClientEvent("pNotify:SendNotification", {
-- 			-- 	text ='กระเป๋านํ้าหนักเต็ม!! ' ,
-- 			-- 	type = "error",
-- 			-- 	timeout = 5000,
-- 			-- 	layout = "bottomCenter" 
-- 			-- })


-- 				else
-- 					sourceXPlayer.removeInventoryItem(itemName, itemCount)
-- 					TriggerClientEvent('pNotify:SendNotification', sourceXPlayer, { type = 'true', text = _U('item_removed') .. itemName})
-- 					targetXPlayer.addInventoryItem(itemName, itemCount)
-- 					TriggerClientEvent('pNotify:SendNotification', targetXPlayer, { type = 'true', text = _U('item_added') .. itemName})

-- 					if eventType == 'police_take' then -- ตำรวจ-ยึด-ไอเทม
-- 						local sendToDiscord = '' .. targetXPlayer.name .. ' ยึด ' .. sourceItem.label .. ' จาก ' .. sourceXPlayer.name .. ' จำนวน ' .. ESX.Math.GroupDigits(itemCount) .. ''
-- 						--TriggerEvent('azael_discordlogs:sendToDiscord', 'SeizeItem', sendToDiscord, targetXPlayer.source, '^2')
-- 						Discord(sourceXPlayer.identifier,targetXPlayer.identifier, sendToDiscord, 1752220)
-- 						Citizen.Wait(100)
																
-- 						local sendToDiscord2 = '' .. sourceXPlayer.name .. ' ถูกยึด ' .. sourceItem.label .. ' โดย ' .. targetXPlayer.name .. ' จำนวน ' .. ESX.Math.GroupDigits(itemCount) .. ''
-- 						--TriggerEvent('azael_discordlogs:sendToDiscord', 'SeizeItem', sendToDiscord2, sourceXPlayer.source, '^3')
-- 						Discord(sourceXPlayer.identifier,targetXPlayer.identifier, sendToDiscord2, 1752220)
-- 					elseif eventType == 'police_put' then -- ตำรวจ-ยัด-ไอเทม
-- 						--TriggerEvent('azael_discordlogs:sendToDiscord', 'SeizeItem', sendToDiscord, targetXPlayer.source, '^2')
-- 						Discord(sourceXPlayer.identifier,targetXPlayer.identifier, sendToDiscord, 1752220)
-- 						Citizen.Wait(100)
																
-- 						local sendToDiscord2 = '' .. sourceXPlayer.name .. ' ถูกยึด ' .. sourceItem.label .. ' โดย ' .. targetXPlayer.name .. ' จำนวน ' .. ESX.Math.GroupDigits(itemCount) .. ''
-- 						--TriggerEvent('azael_discordlogs:sendToDiscord', 'SeizeItem', sendToDiscord2, sourceXPlayer.source, '^3')
-- 						Discord(sourceXPlayer.identifier,targetXPlayer.identifier, sendToDiscord2, 1752220)
-- 					end
-- 				end
-- 			end
-- 		elseif type == "item_money" then
-- 			if itemCount > 0 and sourceXPlayer.getMoney() >= itemCount then
-- 				sourceXPlayer.removeMoney(itemCount)
-- 				TriggerClientEvent('pNotify:SendNotification', sourceXPlayer, { type = 'true', text = _U('money_removed') .. itemCount})
-- 				targetXPlayer.addMoney(itemCount)
-- 				TriggerClientEvent('pNotify:SendNotification', targetXPlayer, { type = 'true', text = _U('money_added') .. itemCount})

-- 				if eventType == 'police_take' then -- ตำรวจ-ยึด-เงินเขียว
-- 					local sendToDiscord = '' .. targetXPlayer.name .. ' ยึด ' .. itemName .. ' จาก ' .. sourceXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
-- 					TriggerEvent('azael_discordlogs:sendToDiscord', 'PoliceTakeMoney', sendToDiscord, targetXPlayer.source, '^3')
	
-- 					Citizen.Wait(100)
										
-- 					local sendToDiscord2 = '' .. sourceXPlayer.name .. ' ถูกยึด ' .. itemName .. ' โดย ' .. targetXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
-- 					TriggerEvent('azael_discordlogs:sendToDiscord', 'PoliceTakeMoney', sendToDiscord2, sourceXPlayer.source, '^2')
-- 				elseif eventType == 'police_put' then -- ตำรวจ-ยัด-เงินเขียว
-- 					local sendToDiscord = '' .. sourceXPlayer.name .. ' ยัด ' .. itemName .. ' ไปยัง ' .. targetXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
-- 					TriggerEvent('azael_discordlogs:sendToDiscord', 'PolicePutMoney', sendToDiscord, sourceXPlayer.source, '^3')
	
-- 					Citizen.Wait(100)
										
-- 					local sendToDiscord2 = '' .. targetXPlayer.name .. ' ถูกยัด ' .. itemName .. ' โดย ' .. sourceXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
-- 					TriggerEvent('azael_discordlogs:sendToDiscord', 'PolicePutMoney', sendToDiscord2, targetXPlayer.source, '^2')
-- 				end
-- 			end
-- 		elseif type == "item_account" then
-- 			if itemCount > 0 and sourceXPlayer.getAccount(itemName).money >= itemCount then
-- 				sourceXPlayer.removeAccountMoney(itemName, itemCount)
-- 				TriggerClientEvent('pNotify:SendNotification', sourceXPlayer, { type = 'true', text = _U('money_removed') .. itemCount .. itemName})
-- 				targetXPlayer.addAccountMoney(itemName, itemCount)
-- 				TriggerClientEvent('pNotify:SendNotification', targetXPlayer, { type = 'true', text = _U('money_added') .. itemCount .. itemName})

-- 				if eventType == 'police_take' then -- ตำรวจ-ยึด-เงินแดง
-- 					local sendToDiscord = '' .. targetXPlayer.name .. ' ยึด ' .. itemName .. ' จาก ' .. sourceXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
-- 					TriggerEvent('azael_discordlogs:sendToDiscord', 'PoliceTakeMoney', sendToDiscord, targetXPlayer.source, '^3')
	
-- 					Citizen.Wait(100)
										
-- 					local sendToDiscord2 = '' .. sourceXPlayer.name .. ' ถูกยึด ' .. itemName .. ' โดย ' .. targetXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
-- 					TriggerEvent('azael_discordlogs:sendToDiscord', 'PoliceTakeMoney', sendToDiscord2, sourceXPlayer.source, '^2')
-- 				elseif eventType == 'police_put' then -- ตำรวจ-ยัด-เงินแดง
-- 					local sendToDiscord = '' .. sourceXPlayer.name .. ' ยัด ' .. itemName .. ' ไปยัง ' .. targetXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
-- 					TriggerEvent('azael_discordlogs:sendToDiscord', 'PolicePutMoney', sendToDiscord, sourceXPlayer.source, '^3')
	
-- 					Citizen.Wait(100)
										
-- 					local sendToDiscord2 = '' .. targetXPlayer.name .. ' ถูกยัด ' .. itemName .. ' โดย ' .. sourceXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
-- 					TriggerEvent('azael_discordlogs:sendToDiscord', 'PolicePutMoney', sendToDiscord2, targetXPlayer.source, '^2')
-- 				end
-- 			end
-- 		elseif type == "item_weapon" then	
-- 			print(eventType)    
-- 			if not targetXPlayer.hasWeapon(itemName, itemCount) then
-- 				sourceXPlayer.removeWeapon(itemName, itemCount)
-- 				TriggerClientEvent('pNotify:SendNotification', sourceXPlayer, { type = 'true', text = _U('weapon_removed') .. itemName})
-- 				targetXPlayer.addWeapon(itemName, itemCount)
-- 				TriggerClientEvent('pNotify:SendNotification', targetXPlayer, { type = 'true', text = _U('waepon_added') .. itemName})
				
-- 				if eventType == 'police_take' then -- ตำรวจ-ยึด-อาวุธ
-- 					local weaponLabel = ESX.GetWeaponLabel(itemName)
-- 					if itemCount >= 0 then
-- 						local sendToDiscord = '' .. targetXPlayer.name .. ' ยึด ' .. weaponLabel .. ' จาก ' .. sourceXPlayer.name .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(itemCount) .. ''
-- 						TriggerEvent('azael_discordlogs:sendToDiscord', 'PoliceTakeWeapon', sendToDiscord, targetXPlayer.source, '^3')
					
-- 						Citizen.Wait(100)
									
-- 						local sendToDiscord2 = '' .. sourceXPlayer.name .. ' ถูกยึด ' .. weaponLabel .. ' โดย ' .. targetXPlayer.name .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(itemCount) .. ''
-- 						TriggerEvent('azael_discordlogs:sendToDiscord', 'PoliceTakeWeapon', sendToDiscord2, sourceXPlayer.source, '^2')
-- 					else
-- 						local sendToDiscord = '' .. targetXPlayer.name .. ' ยึด ' .. weaponLabel .. ' จาก ' .. sourceXPlayer.name .. '  จำนวน 1'
-- 						TriggerEvent('azael_discordlogs:sendToDiscord', 'PoliceTakeWeapon', sendToDiscord, targetXPlayer.source, '^3')
					
-- 						Citizen.Wait(100)
									
-- 						local sendToDiscord2 = '' .. sourceXPlayer.name .. ' ถูกยึด ' .. weaponLabel .. ' โดย ' .. targetXPlayer.name .. ' จำนวน 1'
-- 						TriggerEvent('azael_discordlogs:sendToDiscord', 'PoliceTakeWeapon', sendToDiscord2, sourceXPlayer.source, '^2')
-- 					end
-- 				elseif eventType == 'police_put' then -- ตำรวจ-ยัด-อาวุธ
-- 					local weaponLabel = ESX.GetWeaponLabel(itemName)
-- 					if itemCount >= 0 then
-- 						local sendToDiscord = '' .. sourceXPlayer.name .. ' ยัด ' .. weaponLabel .. ' ไปยัง ' .. targetXPlayer.name .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(itemCount) .. ''
-- 						TriggerEvent('azael_discordlogs:sendToDiscord', 'PolicePutWeapon', sendToDiscord, sourceXPlayer.source, '^3')
					
-- 						Citizen.Wait(100)
									
-- 						local sendToDiscord2 = '' .. targetXPlayer.name .. ' ถูกยัด ' .. weaponLabel .. ' โดย ' .. sourceXPlayer.name .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(itemCount) .. ''
-- 						TriggerEvent('azael_discordlogs:sendToDiscord', 'PolicePutWeapon', sendToDiscord2, targetXPlayer.source, '^2')
-- 					else
-- 						local sendToDiscord = '' .. sourceXPlayer.name .. ' ยัด ' .. weaponLabel .. ' ไปยัง ' .. targetXPlayer.name .. '  จำนวน 1'
-- 						TriggerEvent('azael_discordlogs:sendToDiscord', 'PolicePutWeapon', sendToDiscord, sourceXPlayer.source, '^3')
					
-- 						Citizen.Wait(100)
									
-- 						local sendToDiscord2 = '' .. targetXPlayer.name .. ' ถูกยัด ' .. weaponLabel .. ' โดย ' .. sourceXPlayer.name .. ' จำนวน 1'
-- 						TriggerEvent('azael_discordlogs:sendToDiscord', 'PolicePutWeapon', sendToDiscord2, targetXPlayer.source, '^2')
-- 					end
-- 				end
-- 			end
-- 		end
-- 	else 
-- 		for k,v in ipairs(Config.NewPlayer) do 
-- 			if sourceXPlayer.getInventoryItem(v) ~= nil then 
-- 				local countitemguarantee  = sourceXPlayer.getInventoryItem(v).count
-- 				if countitemguarantee > 0 then
-- 					-- TriggerClientEvent("pNotify:SendNotification", target, {
-- 					-- 	text = 'ผู้เล่นเป็นผู้เล่นใหม่ไม่สามารถปล้นได้!',
-- 					-- 	type = "error",
-- 					-- 	queue = "global",
-- 					-- 	timeout = 3000,
-- 					-- 	layout = "bottomCenter"
-- 					-- })
-- 					-- exports['mythic_notify']:SendAlert('error', 'ผู้เล่นเป็นผู้เล่นใหม่ไม่สามารถปล้นได้ ! ! !', 3000)
-- 					xPlayer.triggerEvent("mythic_notify:client:SendAlert",{
-- 						text = 'ผู้เล่นเป็นผู้เล่นใหม่ไม่สามารถปล้นได้ ! ! !',
-- 						type = "error",
-- 						timeout = 3000,
-- 					})
-- 					return
-- 				end
-- 			end
-- 		end
-- 		if type == "item_standard" then ---------------------------------------------------------------- log ปล้น
-- 			local sourceItem = sourceXPlayer.getInventoryItem(itemName)
-- 			local targetItem = targetXPlayer.getInventoryItem(itemName)
-- 			if itemCount > 0 and sourceItem.count >= itemCount then
-- 				if itemAllow[targetItem.name] then
-- 					-- TriggerClientEvent("pNotify:SendNotification", target, {
-- 					-- 	text = "ของชิ้นนี้ไม่สามารถปล้นได้!",
-- 					-- 	type = "error",
-- 					-- 	queue = "global",
-- 					-- 	timeout = 3000,
-- 					-- 	layout = "bottomCenter"
-- 					-- })
-- 					-- exports['mythic_notify']:SendAlert('error', 'ของชิ้นนี้ไม่สามารถปล้นได้ ! ! !', 3000)
-- 					xPlayer.triggerEvent("mythic_notify:client:SendAlert",{
-- 						text = 'ของชิ้นนี้ไม่สามารถปล้นได้ ! ! !',
-- 						type = "error",
-- 						timeout = 3000,
-- 					})
-- 				else
-- 					sourceXPlayer.removeInventoryItem(itemName, itemCount)
-- 					TriggerClientEvent('pNotify:SendNotification', sourceXPlayer, { type = 'true', text = _U('item_removed') .. itemName})
-- 					targetXPlayer.addInventoryItem(itemName, itemCount)
-- 					TriggerClientEvent('pNotify:SendNotification', targetXPlayer, { type = 'true', text = _U('item_added') .. itemName})

-- 					if eventType == 'police_take' then -- ตำรวจ-ยึด-ไอเทม
				
-- 						local sendToDiscord = '' .. targetXPlayer.name .. ' ยึด ' .. sourceItem.label .. ' จาก ' .. sourceXPlayer.name .. ' จำนวน ' .. ESX.Math.GroupDigits(itemCount) .. ''
-- 						--TriggerEvent('azael_discordlogs:sendToDiscord', 'SeizeItem', sendToDiscord, targetXPlayer.source, '^2')
-- 						Discord(sourceXPlayer.identifier,targetXPlayer.identifier, sendToDiscord, 1752220)
-- 						Citizen.Wait(100)
																
-- 						local sendToDiscord2 = '' .. sourceXPlayer.name .. ' ถูกยึด ' .. sourceItem.label .. ' โดย ' .. targetXPlayer.name .. ' จำนวน ' .. ESX.Math.GroupDigits(itemCount) .. ''
-- 						--TriggerEvent('azael_discordlogs:sendToDiscord', 'SeizeItem', sendToDiscord2, sourceXPlayer.source, '^3')
-- 						Discord(sourceXPlayer.identifier,targetXPlayer.identifier, sendToDiscord2, 1752220)
-- 					elseif playerType == 'police_put' then -- ตำรวจ-ยัด-ไอเทม
	
-- 						local sendToDiscord = '' .. targetXPlayer.name .. ' ยึด ' .. sourceItem.label .. ' จาก ' .. sourceXPlayer.name .. ' จำนวน ' .. ESX.Math.GroupDigits(itemCount) .. ''
-- 						--TriggerEvent('azael_discordlogs:sendToDiscord', 'SeizeItem', sendToDiscord, targetXPlayer.source, '^2')
-- 						Discord(sourceXPlayer.identifier,targetXPlayer.identifier, sendToDiscord, 1752220)
-- 						Citizen.Wait(100)
																
-- 						local sendToDiscord2 = '' .. sourceXPlayer.name .. ' ถูกยัด ' .. sourceItem.label .. ' โดย ' .. targetXPlayer.name .. ' จำนวน ' .. ESX.Math.GroupDigits(itemCount) .. ''
-- 						--TriggerEvent('azael_discordlogs:sendToDiscord', 'SeizeItem', sendToDiscord2, sourceXPlayer.source, '^3')
-- 						Discord(sourceXPlayer.identifier,targetXPlayer.identifier, sendToDiscord2, 1752220)
-- 					end
-- 				end
-- 			end
-- 		elseif type == "item_money" then
-- 			if itemCount > 0 and sourceXPlayer.getMoney() >= itemCount then
-- 				sourceXPlayer.removeMoney(itemCount)
-- 				TriggerClientEvent('pNotify:SendNotification', sourceXPlayer, { type = 'true', text = _U('money_removed') .. itemCount})
-- 				targetXPlayer.addMoney(itemCount)
-- 				TriggerClientEvent('pNotify:SendNotification', targetXPlayer, { type = 'true', text = _U('money_added') .. itemCount})

-- 				if eventType == 'police_take' then -- ตำรวจ-ยึด-เงินเขียว
-- 					local sendToDiscord = '' .. targetXPlayer.name .. ' ยึด ' .. itemName .. ' จาก ' .. sourceXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
-- 					TriggerEvent('azael_discordlogs:sendToDiscord', 'PoliceTakeMoney', sendToDiscord, targetXPlayer.source, '^3')
	
-- 					Citizen.Wait(100)
										
-- 					local sendToDiscord2 = '' .. sourceXPlayer.name .. ' ถูกยึด ' .. itemName .. ' โดย ' .. targetXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
-- 					TriggerEvent('azael_discordlogs:sendToDiscord', 'PoliceTakeMoney', sendToDiscord2, sourceXPlayer.source, '^2')
-- 				elseif playerType == 'police_put' then -- ตำรวจ-ยัด-เงินเขียว
-- 					local sendToDiscord = '' .. sourceXPlayer.name .. ' ยัด ' .. itemName .. ' ไปยัง ' .. targetXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
-- 					TriggerEvent('azael_discordlogs:sendToDiscord', 'thiefPutMoney', sendToDiscord, sourceXPlayer.source, '^3')
	
-- 					Citizen.Wait(100)
										
-- 					local sendToDiscord2 = '' .. targetXPlayer.name .. ' ถูกยัด ' .. itemName .. ' โดย ' .. sourceXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
-- 					TriggerEvent('azael_discordlogs:sendToDiscord', 'thiefPutMoney', sendToDiscord2, targetXPlayer.source, '^2')
-- 				end
-- 			end
-- 		elseif type == "item_account" then
-- 			if itemCount > 0 and sourceXPlayer.getAccount(itemName).money >= itemCount then
-- 				sourceXPlayer.removeAccountMoney(itemName, itemCount)
-- 				TriggerClientEvent('pNotify:SendNotification', sourceXPlayer, { type = 'true', text = _U('money_removed') .. itemCount .. itemName})
-- 				targetXPlayer.addAccountMoney(itemName, itemCount)
-- 				TriggerClientEvent('pNotify:SendNotification', targetXPlayer, { type = 'true', text = _U('money_added') .. itemCount .. itemName})

-- 				if eventType == 'police_take' then -- ตำรวจ-ยึด-เงินแดง
-- 					local sendToDiscord = '' .. targetXPlayer.name .. ' ยึด ' .. itemName .. ' จาก ' .. sourceXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
-- 					--TriggerEvent('azael_discordlogs:sendToDiscord', 'SeizeDirtyMoney', sendToDiscord, targetXPlayer.source, '^3')
-- 					Discord(sourceXPlayer.identifier,targetXPlayer.identifier, sendToDiscord, 1752220)
-- 					Citizen.Wait(100)
										
-- 					local sendToDiscord2 = '' .. sourceXPlayer.name .. ' ถูกยึด ' .. itemName .. ' โดย ' .. targetXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
-- 					--TriggerEvent('azael_discordlogs:sendToDiscord', 'SeizeDirtyMoney', sendToDiscord2, sourceXPlayer.source, '^2')
-- 					Discord(sourceXPlayer.identifier,targetXPlayer.identifier, sendToDiscord2, 1752220)
-- 				elseif playerType == 'police_put' then -- ตำรวจ-ยัด-เงินแดง
-- 					local sendToDiscord = '' .. targetXPlayer.name .. ' ยึด ' .. itemName .. ' จาก ' .. sourceXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
-- 					--TriggerEvent('azael_discordlogs:sendToDiscord', 'SeizeDirtyMoney', sendToDiscord, targetXPlayer.source, '^3')
-- 					Discord(sourceXPlayer.identifier,targetXPlayer.identifier, sendToDiscord, 1752220)
-- 					Citizen.Wait(100)
										
-- 					local sendToDiscord2 = '' .. sourceXPlayer.name .. ' ถูกยัด ' .. itemName .. ' โดย ' .. targetXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
-- 					--TriggerEvent('azael_discordlogs:sendToDiscord', 'SeizeDirtyMoney', sendToDiscord2, sourceXPlayer.source, '^2')
-- 					Discord(sourceXPlayer.identifier,targetXPlayer.identifier, sendToDiscord2, 1752220)
-- 				end
-- 			end ----------------------------------------------------------------
-- 		elseif type == "item_weapon" then	 
-- 			TriggerClientEvent("pNotify:SendNotification", target, {
-- 				text = "อาวุธทุกชิ้นไม่สามารถปล้นได้",
-- 				type = "error",
-- 				queue = "global",
-- 				timeout = 3000,
-- 				layout = "bottomCenter"
-- 			})
-- 		end
-- 	end
-- end)

ESX = nil
ServerItems = {}
itemShopList = {}
local hasSqlRun = false

TriggerEvent(
	"esx:getSharedObject",
	function(obj)
		ESX = obj
	end
)
-- taeratto add
-- Load items
AddEventHandler('onMySQLReady', function()
	hasSqlRun = true
end)

-- extremely useful when restarting script mid-game
Citizen.CreateThread(function()
	Citizen.Wait(2000) -- hopefully enough for connection to the SQL server

	if not hasSqlRun then
		hasSqlRun = true
	end
end)
-- end add



RegisterServerEvent("Fxw_inventory:tradePlayerItemx")
AddEventHandler("Fxw_inventory:tradePlayerItemx",function(from, target, type, itemName, itemCount)
		local _source = from
		local sourceXPlayer = ESX.GetPlayerFromId(_source)
		local targetXPlayer = ESX.GetPlayerFromId(target)

		if type == "item_standard" then
			local sourceItem = sourceXPlayer.getInventoryItem(itemName)
			local targetItem = targetXPlayer.getInventoryItem(itemName)

			if itemCount > 0 and sourceItem.count >= itemCount then
				if  targetXPlayer.canCarryItem(itemName, itemCount) then
					sourceXPlayer.removeInventoryItem(itemName, itemCount)
					targetXPlayer.addInventoryItem(itemName, itemCount)
				else
					-- print('asdasdasd')
					TriggerClientEvent("pNotify:SendNotification", target, {
						text = '<strong class="red-text">ล้มเหลว</strong> ไม่สามารถรับได้เนื่องจากน้ำหนักเกินขีดจำกัด',
						type = "error",
						timeout = 3000,
						layout = "centerRight",
						queue = "global"
					})
				end
			end
		elseif type == "item_account" then
			if itemCount > 0 and sourceXPlayer.getAccount(itemName).money >= itemCount then
				sourceXPlayer.removeAccountMoney(itemName, itemCount)
				targetXPlayer.addAccountMoney(itemName, itemCount)
			end
		elseif type == "item_weapon" then
			if not targetXPlayer.hasWeapon(itemName) then
				sourceXPlayer.removeWeapon(itemName)
				targetXPlayer.addWeapon(itemName, itemCount)
			end
		end
	end
)

-- ESX.RegisterServerCallback("getweight", function(source, cb)
-- 	local data = {CurrentWeight = nil, MaxWeight = nil}
-- 	local xPlayer = ESX.GetPlayerFromId(source)
-- 	data.CurrentWeight = xPlayer.getWeight()
-- 	data.MaxWeight = xPlayer.getMaxWeight()
	
-- 	cb(data)
-- end)

-- ESX.RegisterServerCallback("dataweight", function(source, cb)
-- 	local xPlayer = ESX.GetPlayerFromId(source)
-- 	cb(xPlayer.itemWeight())
-- end)



-- taeratto add shop

-- RegisterCommand(
-- 	"openinventory",
-- 	function(source, args, rawCommand)
-- 		if IsPlayerAceAllowed(source, "inventory.openinventory") then
-- 			local target = tonumber(args[1])
-- 			local targetXPlayer = ESX.GetPlayerFromId(target)

-- 			if targetXPlayer ~= nil then
-- 				TriggerClientEvent("Fxw_inventory:openPlayerInventory", source, target, targetXPlayer.name)
-- 			else
-- 				TriggerClientEvent("chatMessage", source, "^1" .. _U("no_player"))
-- 			end
-- 		else
-- 			TriggerClientEvent("chatMessage", source, "^1" .. _U("no_permissions"))
-- 		end
-- 	end
-- )

ESX.RegisterServerCallback(
	"Fxw_inventory:getPlayerInventory",
	function(source, cb, target)
		local targetXPlayer = ESX.GetPlayerFromId(target)

		if targetXPlayer ~= nil then
			cb({inventory = targetXPlayer.inventory, money = targetXPlayer.getMoney(), accounts = targetXPlayer.accounts, weapons = targetXPlayer.loadout})
		else
			cb(nil)
		end
	end
)

RegisterCommand(
	"openinventory",
	function(source, args, rawCommand)
		if IsPlayerAceAllowed(source, "inventory.openinventory") then
			local target = tonumber(args[1])
			local targetXPlayer = ESX.GetPlayerFromId(target)

			if targetXPlayer ~= nil then
				TriggerClientEvent("Fxw_inventory:openPlayerInventory", source, target, targetXPlayer.name)
			else
				TriggerClientEvent("chatMessage", source, "^1" .. _U("no_player"))
			end
		else
			TriggerClientEvent("chatMessage", source, "^1" .. _U("no_permissions"))
		end
	end
)



function Discord(name,steam, message, color)
    local connect = {
          {
              ["color"] = color,
              ["title"] = "**".. name .."**".." : "..steam.."",
              ["description"] = message,
              ["footer"] = {
				["text"] = "Mairu Develop"..(' เวลา: %s'):format(os.date('%d/%m/%Y | %H:%M:%S', os.time()))
              },
          }
      }
    PerformHttpRequest("https://discordapp.com/api/webhooks/1081897338815139880/-HVRMz6y2bG84yjhVF04jWIBAXj-1OJ1bhLJG5KfQVs652aNwHQQs0qwtt3d0pIPzIO0", function(err, text, headers) end, 'POST', json.encode({username = "เนตรวงแหวน", embeds = connect, avatar_url = "https://media.discordapp.net/attachments/880835869429346315/934772592420716574/657200d7b9954462d809666999dd3e75.jpg"}), { ['Content-Type'] = 'application/json' })
end