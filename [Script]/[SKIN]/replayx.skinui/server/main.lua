ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('reskin', function(source)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerClientEvent('esx_skin:openSaveableMenu', source)
	xPlayer.removeInventoryItem('reskin', 1)
end)

RegisterServerEvent('replayx.skinui:pay')
AddEventHandler('replayx.skinui:pay', function(money)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeMoney(money)
end)

RegisterServerEvent('replayx.skinui:saveOutfit')
AddEventHandler('replayx.skinui:saveOutfit', function(label, skin)

	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)

		local dressing = store.get('dressing')

		if dressing == nil then
			dressing = {}
		end

		table.insert(dressing, {
			label = label,
			skin  = skin
		})

		store.set('dressing', dressing)

	end)

end)
RegisterServerEvent('replayx.skinui:saveOutfitaccessory')
AddEventHandler('replayx.skinui:saveOutfitaccessory', function(label, skin, accessory, money)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	local count_item = MySQL.Sync.fetchScalar("SELECT COUNT(1) FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type", {
		['@owner'] = xPlayer.identifier,
		['@type'] = 'player_' ..accessory
	})

	local String_accessory

	if accessory == 'helmet' then
		String_accessory = "หมวก"
	elseif accessory == 'glasses' then
		String_accessory = "แว่นตา"
	elseif accessory == 'ears' then
		String_accessory = "ตุ้มหู"
	elseif accessory == 'mask' then
		String_accessory = "หน้ากาก"
	end

	local itemSkin = {}
	local item1 = string.lower(accessory) .. '_1'
	local item2 = string.lower(accessory) .. '_2'
	itemSkin[item1] = skin[item1]
	itemSkin[item2] = skin[item2]

	if count_item >= 100 then
		TriggerClientEvent("pNotify:SendNotification", _source, {
			text = '<strong class="red-text">กระเป๋าคุณเต็ม</strong>',
			type = "success",
			timeout = 3000,
			layout = "centerRight",
			queue = "global"
		})
		TriggerClientEvent('esx_accessories:loadefaultskin', _source)
	else
		MySQL.Async.execute('INSERT INTO meeta_accessory_inventory(owner, label, skin, type) VALUES (@owner, @label, @skin, @type)', {
			['@owner'] = xPlayer.identifier,
			['@label'] = label,
			['@skin'] = json.encode(itemSkin),
			['@type'] = 'player_' ..accessory
		}, function(rows)
			if rows then
				-- pay(_source, String_accessory)
				TriggerClientEvent("pNotify:SendNotification", _source, {
					text = '<strong class="green-text">บันทึก'..String_accessory..'เรียบร้อยแล้ว</strong>',
					type = "success",
					timeout = 3000,
					layout = "centerRight",
					queue = "global"
				})
				xPlayer.removeMoney(money)
				TriggerClientEvent("esx_inventoryhud:getOwnerAccessories", _source)
			end
		end)
	end

	
end)

ESX.RegisterServerCallback('replayx.skinui:checkMoney', function(source, cb)

	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= Config.Price then
		cb(true)
	else
		cb(false)
	end

end)

ESX.RegisterServerCallback('replayx.skinui:checkMoney2', function(source, cb)

	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= Config.Price2 then
		cb(true)
	else
		cb(false)
	end

end)

ESX.RegisterServerCallback('replayx.skinui:checkMoney3', function(source, cb)

	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= Config.Price3 then
		cb(true)
	else
		cb(false)
	end

end)

ESX.RegisterServerCallback('replayx.skinui:get', function(source, cb, accessory)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'user_' .. string.lower(accessory), xPlayer.identifier, function(store)
		local hasAccessory = (store.get('has' .. accessory) and store.get('has' .. accessory) or false)
		local skin = (store.get('skin') and store.get('skin') or {})

		cb(hasAccessory, skin)
	end)

end)
