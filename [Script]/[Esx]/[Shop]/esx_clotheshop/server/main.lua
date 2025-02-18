ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_clotheshop:saveOutfit')
AddEventHandler('esx_clotheshop:saveOutfit', function(label, skin, type)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.execute('INSERT INTO meeta_accessory_inventory(owner, label, skin, type) VALUES (@owner, @label, @skin, @type)', {
		['@owner'] = xPlayer.identifier,
		['@label'] = label,
		['@skin'] = json.encode(skin),
		['@type'] = 'player_'..type
	}, function(rows)
		if rows then
			TriggerClientEvent("pNotify:SendNotification", _source, {
				text = '<center><strong class="green-text">สำเร็จ</strong> บันทึกชุดเรียบร้อยแล้ว<center>',
				type = "information",
				timeout = 3000,
				layout = "centerRight",
				queue = "global"
			})
			TriggerClientEvent("Fewthz_inventory:getOwnerAccessories", _source)
		end
	end)
end)

ESX.RegisterServerCallback('esx_clotheshop:buyClothes', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= Config.ClothesPrice then
		xPlayer.removeMoney(Config.ClothesPrice)
		TriggerClientEvent("pNotify:SendNotification", source, {
			text = '<center><strong class="green-text">สำเร็จ</strong> ซื้อเสื้อเรียบร้อยแล้ว จ่าย $'..Config.ClothesPrice..'</strong><center>',
			type = "information",
			timeout = 3000,
			layout = "centerRight",
			queue = "global"
		})
		cb(true)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_clotheshop:buypants', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= Config.PantsPrice then
		xPlayer.removeMoney(Config.PantsPrice)
		TriggerClientEvent("pNotify:SendNotification", source, {
			text = '<center><strong class="green-text">สำเร็จ</strong> ซื้อกางเกงเรียบร้อยแล้ว จ่าย $'..Config.PantsPrice..'</strong><center>',
			type = "information",
			timeout = 3000,
			layout = "centerRight",
			queue = "global"
		})
		cb(true)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_clotheshop:buyshoes', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= Config.ShoesPrice then
		xPlayer.removeMoney(Config.ShoesPrice)
		TriggerClientEvent("pNotify:SendNotification", source, {
			text = '<center><strong class="green-text">สำเร็จ</strong> ซื้อรองเท้าเรียบร้อยแล้ว จ่าย $'..Config.ShoesPrice..'</strong><center>',
			type = "information",
			timeout = 3000,
			layout = "centerRight",
			queue = "global"
		})
		cb(true)
	else
		cb(false)
	end
end)



ESX.RegisterServerCallback('esx_clotheshop:buybags', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= Config.BagsPrice then
		xPlayer.removeMoney(Config.BagsPrice)
		TriggerClientEvent("pNotify:SendNotification", source, {
			text = '<center><strong class="green-text">สำเร็จ</strong> ซื้อกระเป๋าเรียบร้อยแล้ว จ่าย $'..Config.BagsPrice..'</strong><center>',
			type = "information",
			timeout = 3000,
			layout = "centerRight",
			queue = "global"
		})
		cb(true)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_clotheshop:buychain', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= Config.ChainPrice then
		xPlayer.removeMoney(Config.ChainPrice)
		TriggerClientEvent("pNotify:SendNotification", source, {
			text = '<center><strong class="green-text">สำเร็จ</strong> ซื้อกระเป๋าเรียบร้อยแล้ว จ่าย $'..Config.ChainPrice..'</strong><center>',
			type = "information",
			timeout = 3000,
			layout = "centerRight",
			queue = "global"
		})
		cb(true)
	else
		cb(false)
	end
end)


ESX.RegisterServerCallback('esx_clotheshop:buywatch', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= Config.WatchPrice then
		xPlayer.removeMoney(Config.WatchPrice)
		TriggerClientEvent("pNotify:SendNotification", source, {
			text = '<center><strong class="green-text">สำเร็จ</strong> ซื้อนาฬิกาเรียบร้อยแล้ว จ่าย $'..Config.WatchPrice..'</strong><center>',
			type = "information",
			timeout = 3000,
			layout = "centerRight",
			queue = "global"
		})
		cb(true)
	else
		cb(false)
	end
end)


ESX.RegisterServerCallback('esx_clotheshop:checkPropertyDataStore', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local foundStore = false

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		foundStore = true
	end)

	cb(foundStore)
end)

RegisterServerEvent('esx_clotheshop:pay')
AddEventHandler('esx_clotheshop:pay', function(count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.getMoney() >= count then
		xPlayer.removeMoney(count)
	end
end)