TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('Fewthz_inventory:closeInventoryhud')
AddEventHandler('Fewthz_inventory:closeInventoryhud', function(target)
	TriggerClientEvent("Fewthz_inventory:closeInventory", target)
end)

RegisterServerEvent("Fewthz_inventory:deleteOutfit")
AddEventHandler("Fewthz_inventory:deleteOutfit", function(name, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	if type == "earring" then
		type = "ears"
	else
		type = type
	end
	MySQL.Async.execute("DELETE FROM meeta_accessory_inventory WHERE label = @label AND owner = @owner AND type = @type ", {
		["@owner"] = xPlayer.identifier,
		["@label"] = name,
		["@type"] = "player_"..type,
	})
	TriggerClientEvent("Fewthz_inventory:getOwnerAccessories", source)
end)

if Config["EnableVehicleKey"] then
	RegisterServerEvent('Fewthz_inventory:getOwnerVehicle')
	AddEventHandler('Fewthz_inventory:getOwnerVehicle', function()
		 local _source = source
		 local KeyItems = {}
		 local xPlayer = ESX.GetPlayerFromId(source)
		 KeyItems = MySQL.Sync.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @identifier', {
		 ['@identifier'] = xPlayer.identifier
		 })
		TriggerClientEvent("Fewthz_inventory:setOwnerVehicle", _source, KeyItems)
	end)
end

if Config["EnableHouseKey"] then
	RegisterServerEvent('Fewthz_inventory:getOwnerHouse')
	AddEventHandler('Fewthz_inventory:getOwnerHouse', function()
		local _source = source
		local HouseItems = {}
		local xPlayer = ESX.GetPlayerFromId(source)
		HouseItems = MySQL.Sync.fetchAll('SELECT * FROM owned_properties WHERE owner = @identifier', {
			['@identifier'] = xPlayer.identifier
		})
		TriggerClientEvent("Fewthz_inventory:setOwnerHouse", _source, HouseItems)
	end)
end

if Config["EnableAccessory"] then
	RegisterServerEvent("Fewthz_inventory:getOwnerAccessories")
	AddEventHandler("Fewthz_inventory:getOwnerAccessories", function()
		local _source = source
		local xPlayer = ESX.GetPlayerFromId(source)
		local AccessoriesItems = {}
		local Result_watches = MySQL.Sync.fetchAll("SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type", {
			["@owner"] = xPlayer.identifier,
			["@type"] = "player_watches"
		})
		if Result_watches[1] then
			for k,v in pairs(Result_watches) do
				local skin = json.decode(v.skin)
				table.insert(AccessoriesItems, {
					label = v.label,
					count = 1,
					limit = -1,
					type = "item_accessories",
					name = "watches",
					usable = true,
					rare = false,
					canRemove = false,
					itemnum = skin["watches_1"],
					itemskin = skin["watches_2"]
				})
			end
		end
		local Result_chain = MySQL.Sync.fetchAll("SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type", {
			["@owner"] = xPlayer.identifier,
			["@type"] = "player_chain"
		})
		if Result_chain[1] then
			for k,v in pairs(Result_chain) do
				local skin = json.decode(v.skin)
				table.insert(AccessoriesItems, {
					label = v.label,
					count = 1,
					limit = -1,
					type = "item_accessories",
					name = "chain",
					usable = true,
					rare = false,
					canRemove = false,
					itemnum = skin["chain_1"],
					itemskin = skin["chain_2"]
				})
			end
		end
		local Result_bags = MySQL.Sync.fetchAll("SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type", {
			["@owner"] = xPlayer.identifier,
			["@type"] = "player_bags"
		})
		if Result_bags[1] then
			for k,v in pairs(Result_bags) do
				local skin = json.decode(v.skin)
				table.insert(AccessoriesItems, {
					label = v.label,
					count = 1,
					limit = -1,
					type = "item_accessories",
					name = "bags",
					usable = true,
					rare = false,
					canRemove = false,
					itemnum = skin["bags_1"],
					itemskin = skin["bags_2"]
				})
			end
		end
		local Result_bproof = MySQL.Sync.fetchAll("SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type", {
			["@owner"] = xPlayer.identifier,
			["@type"] = "player_bproof"
		})
		if Result_bproof[1] then
			for k,v in pairs(Result_bproof) do
				local skin = json.decode(v.skin)
				table.insert(AccessoriesItems, {
					label = v.label,
					count = 1,
					limit = -1,
					type = "item_accessories",
					name = "bproof",
					usable = true,
					rare = false,
					canRemove = false,
					itemnum = skin["bproof_1"],
					itemskin = skin["bproof_2"]
				})
			end
		end
		local Result_Helmet = MySQL.Sync.fetchAll("SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type", {
			["@owner"] = xPlayer.identifier,
			["@type"] = "player_helmet"
		})
		if Result_Helmet[1] then
			for k,v in pairs(Result_Helmet) do
				local skin = json.decode(v.skin)
				table.insert(AccessoriesItems, {
					label = v.label,
					count = 1,
					limit = -1,
					type = "item_accessories",
					name = "helmet",
					usable = true,
					rare = false,
					canRemove = false,
					itemnum = skin["helmet_1"],
					itemskin = skin["helmet_2"]
				})
			end
		end
		local Result_Mask = MySQL.Sync.fetchAll("SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type", {
			["@owner"] = xPlayer.identifier,
			["@type"] = "player_mask"
		})
		if Result_Mask[1] then
			for k,v in pairs(Result_Mask) do
				local skin = json.decode(v.skin)
				table.insert(AccessoriesItems, {
					label = v.label,
					count = 1,
					limit = -1,
					type = "item_accessories",
					name = "mask",
					usable = true,
					rare = false,
					canRemove = false,
					itemnum = skin["mask_1"],
					itemskin = skin["mask_2"]
				})
			end
		end
		local Result_Glasses = MySQL.Sync.fetchAll("SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type", {
			["@owner"] = xPlayer.identifier,
			["@type"] = "player_glasses"
		})
		if Result_Glasses[1] then
			for k,v in pairs(Result_Glasses) do
			local skin = json.decode(v.skin)
			table.insert(AccessoriesItems, {
				label = v.label,
				count = 1,
				limit = -1,
				type = "item_accessories",
				name = "glasses",
				usable = true,
				rare = false,
				canRemove = false,
				itemnum = skin["glasses_1"],
				itemskin = skin["glasses_2"]
			})
			end
		end
		local Result_Torso = MySQL.Sync.fetchAll("SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type", {
			["@owner"] = xPlayer.identifier,
			["@type"] = "player_torso"
		})
		if Result_Torso[1] then
			for k,v in pairs(Result_Torso) do
				local skin = json.decode(v.skin)
				table.insert(AccessoriesItems, {
					label = v.label,
					count = 1,
					limit = -1,
					type = "item_accessories",
					name = "torso",
					usable = true,
					rare = false,
					canRemove = false,
					itemnum = skin["torso_1"],
					itemskin = skin["torso_2"],
					itemarms = skin["arms"],
					itemarms2 = skin["arms_2"],
					itemtshirt = skin["tshirt_1"],
					itemtshirt2 = skin["tshirt_2"],
					itemchain = skin["chain_1"],
					itemchain2 = skin["chain_2"],
				})
			end
		end
		local Result_Pants = MySQL.Sync.fetchAll("SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type", {
			["@owner"] = xPlayer.identifier,
			["@type"] = "player_pants"
		})
		if Result_Pants[1] then
			for k,v in pairs(Result_Pants) do
				local skin = json.decode(v.skin)
				table.insert(AccessoriesItems, {
					label = v.label,
					count = 1,
					limit = -1,
					type = "item_accessories",
					name = "pants",
					usable = true,
					rare = false,
					canRemove = false,
					itemnum = skin["pants_1"],
					itemskin = skin["pants_2"]
				})
			end
		end
		local Result_Shoes = MySQL.Sync.fetchAll("SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type", {
			["@owner"] = xPlayer.identifier,
			["@type"] = "player_shoes"
		})
		if Result_Shoes[1] then
			for k,v in pairs(Result_Shoes) do
				local skin = json.decode(v.skin)
				table.insert(AccessoriesItems, {
					label = v.label,
					count = 1,
					limit = -1,
					type = "item_accessories",
					name = "shoes",
					usable = true,
					rare = false,
					canRemove = false,
					itemnum = skin["shoes_1"],
					itemskin = skin["shoes_2"]
				})
			end
		end
		local Result_Earring = MySQL.Sync.fetchAll("SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type", {
			["@owner"] = xPlayer.identifier,
			["@type"] = "player_ears"
		})
		if Result_Earring[1] then
			for k,v in pairs(Result_Earring) do
				local skin = json.decode(v.skin)
				table.insert(AccessoriesItems, {
					label = v.label,
					count = 1,
					limit = -1,
					type = "item_accessories",
					name = "earring",
					usable = true,
					rare = false,
					canRemove = false,
					itemnum = skin["ears_1"],
					itemskin = skin["ears_2"]
				})
			end
		end
		TriggerClientEvent("Fewthz_inventory:setOwnerAccessories", _source, AccessoriesItems)
	end)
end

RegisterServerEvent("Fewthz_inventory:updateOutfit")
AddEventHandler("Fewthz_inventory:updateOutfit", function(target, type, name)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	local identifier = GetPlayerIdentifiers(source)[1]
	local identifier_target = GetPlayerIdentifiers(target)[1]
	MySQL.Async.execute("UPDATE meeta_accessory_inventory SET owner = @newplayer WHERE owner = @identifier AND label = @label AND type = @type ",{
		["@identifier"] = identifier,
		["@newplayer"] = identifier_target,
		["@label"] = name,
		["@type"] = "player_"..type,
	})
	TriggerClientEvent("pNotify:SendNotification", source, {
		text = "<strong class='green-text'>สำเร็จ</strong> ส่ง <strong class='amber-text'>"..name.."</strong> เรียบร้อย",
		type = "information",
		timeout = 3000,
		layout = "centerRight",
		queue = "global"
	})
	TriggerClientEvent("pNotify:SendNotification", target, {
		text = "<strong class='green-text'>สำเร็จ</strong> ได้รับ <strong class='amber-text'>"..name.."</strong> เรียบร้อย",
		type = "information",
		timeout = 3000,
		layout = "centerRight",
		queue = "global"
	})
	TriggerClientEvent("Fewthz_inventory:getOwnerAccessories", _source)
	TriggerClientEvent("Fewthz_inventory:getOwnerAccessories", target)
end)

RegisterServerEvent('Fewthz_inventory:updateKey')
AddEventHandler('Fewthz_inventory:updateKey', function(target, type, itemName)

	local _source = source

	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	local identifier = GetPlayerIdentifiers(source)[1]
	local identifier_target = GetPlayerIdentifiers(target)[1]
	if type == "item_key" then -- MEETA GiveKey

		MySQL.Async.execute("UPDATE owned_vehicles SET owner = @newplayer WHERE owner = @identifier AND plate = @plate",
		{
			['@identifier']		= identifier,
			['@newplayer']		= identifier_target,
			['@plate']		    = itemName
		})
		
		TriggerClientEvent("pNotify:SendNotification", source, {
			text = 'ส่ง <strong class="amber-text">กุญแจรถ</strong> ทะเบียน <strong class="yellow-text">'..itemName..'</strong>',
			type = "success",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		})
		TriggerClientEvent("pNotify:SendNotification", target, {
			text = 'ได้รับ <strong class="amber-text">กุญแจรถ</strong> ทะเบียน <strong class="yellow-text">'..itemName..'</strong>',
			type = "success",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		})
		
		TriggerClientEvent("Fewthz_inventory:getOwnerVehicle", source)
		TriggerClientEvent("Fewthz_inventory:getOwnerVehicle", target)
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

		TriggerClientEvent("Fewthz_inventory:getOwnerHouse", source)
		TriggerClientEvent("Fewthz_inventory:getOwnerHouse", target)

	end
end)

RegisterServerEvent('Fewthz_inventory:removeitemtradekey')
AddEventHandler('Fewthz_inventory:removeitemtradekey', function(itemname)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem(itemname, 1)
end)

ESX.RegisterServerCallback("Fewthz_inventory:getPlayerInventory", function(source, cb, target)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	local Inventory = targetXPlayer.inventory
	if targetXPlayer ~= nil then
		cb({inventory = Inventory, money = targetXPlayer.getMoney(), accounts = targetXPlayer.accounts, weapons = targetXPlayer.loadout})
	else
		cb(nil)
	end
end)


RegisterServerEvent("Fewthz_inventory:tradePlayerItem")
AddEventHandler("Fewthz_inventory:tradePlayerItem",function(from, target, type, itemName, itemCount)
	local _source = from
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	if type == "item_standard" then
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)
		local targetItem = targetXPlayer.getInventoryItem(itemName)
		if itemCount > 0 and sourceItem.count >= itemCount then
			sourceXPlayer.removeInventoryItem(itemName, itemCount)
			targetXPlayer.addInventoryItem(itemName, itemCount)
			local sendToDiscord = "".. sourceXPlayer.name .. " และ ".. targetXPlayer.name .. " เทรดไอเท็ม " ..itemName .. " จำนวน " .. itemCount .. " ชิ้น"
			TriggerEvent("azael_discordlogs:sendToDiscord", "OtherInventory", sendToDiscord, source, "^3")
		end
	elseif type == "item_money" then
		if itemCount > 0 and sourceXPlayer.getMoney() >= itemCount then
			sourceXPlayer.removeMoney(itemCount)
			targetXPlayer.addMoney(itemCount)
			local sendToDiscord = "".. sourceXPlayer.name .. " และ ".. targetXPlayer.name .. " เทรดเงินสด จำนวน " .. itemCount .. ""
			TriggerEvent("azael_discordlogs:sendToDiscord", "OtherInventory", sendToDiscord, source, "^3")
		end
	elseif type == "item_account" then
		if itemCount > 0 and sourceXPlayer.getAccount(itemName).money >= itemCount then
			sourceXPlayer.removeAccountMoney(itemName, itemCount)
			targetXPlayer.addAccountMoney(itemName, itemCount)
			local sendToDiscord = "".. sourceXPlayer.name .. " และ ".. targetXPlayer.name .. " เทรด " ..itemName .. " จำนวน " .. itemCount .. ""
			TriggerEvent("azael_discordlogs:sendToDiscord", "OtherInventory", sendToDiscord, source, "^3")
		end
	elseif type == "item_weapon" then
		if not targetXPlayer.hasWeapon(itemName) then
			sourceXPlayer.removeWeapon(itemName)
			targetXPlayer.addWeapon(itemName, itemCount)
			local sendToDiscord = "".. sourceXPlayer.name .. " และ ".. targetXPlayer.name .. " เทรด " ..itemName .. " จำนวน " .. itemCount .. ""
			TriggerEvent("azael_discordlogs:sendToDiscord", "OtherInventory", sendToDiscord, source, "^3")
		end
	end
end)