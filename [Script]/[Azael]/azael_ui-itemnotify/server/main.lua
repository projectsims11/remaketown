
ESX = nil
TriggerEvent(Config['esx_routers']['server_shared_obj'], function(obj)
	ESX = obj
end)
RegisterNetEvent('azael_ui-itemnotify:sendMoney')
AddEventHandler('azael_ui-itemnotify:sendMoney', function(type, money, source)
		TriggerClientEvent('azael_ui-itemnotify:sendNotification', source, {
			text = type,
			name = 'cash',
			label = Config['money'],
			count = '$'..ESX.Math.GroupDigits(money)
		})
end)
RegisterNetEvent('azael_ui-itemnotify:sendAccountMoney')
AddEventHandler('azael_ui-itemnotify:sendAccountMoney', function(type, account, money, source)
		TriggerClientEvent('azael_ui-itemnotify:sendNotification', source, {
			text = type,
			name = account,
			label = Config[''..account..''],
			count = '$'..ESX.Math.GroupDigits(money)
		})
end)
RegisterNetEvent('azael_ui-itemnotify:sendInventoryItem')
AddEventHandler('azael_ui-itemnotify:sendInventoryItem', function(type, item, count, source)
		local itemLabel = ESX.GetItemLabel(item)
		TriggerClientEvent('azael_ui-itemnotify:sendNotification', source, {
			text = type,
			name = item,
			label = itemLabel,
			count = ESX.Math.GroupDigits(count)
		})
end)
RegisterNetEvent('azael_ui-itemnotify:sendWeapon')
AddEventHandler('azael_ui-itemnotify:sendWeapon', function(type, weapon, count, source)
		local weaponLabel = ESX.GetWeaponLabel(weapon)
		if count ~= nil and count > 0 then
			TriggerClientEvent('azael_ui-itemnotify:sendNotification', source, {
				text = type,
				name = weapon,
				label = weaponLabel,
				count = '✐'..ESX.Math.GroupDigits(count)
			})
		else
			TriggerClientEvent('azael_ui-itemnotify:sendNotification', source, {
				text = type,
				name = weapon,
				label = weaponLabel,
				count = 1
			})
		end
end)
RegisterNetEvent('azael_ui-itemnotify:sendWeaponComponent')
AddEventHandler('azael_ui-itemnotify:sendWeaponComponent', function(type, component, componentLabel, source)
		TriggerClientEvent('azael_ui-itemnotify:sendNotification', source, {
			text = type,
			name = component,
			label = componentLabel,
			count = 1
		})
end)
RegisterNetEvent('azael_ui-itemnotify:sendWeaponAmmo')
AddEventHandler('azael_ui-itemnotify:sendWeaponAmmo', function(type, weapon, count, source)
		TriggerClientEvent('azael_ui-itemnotify:sendNotification', source, {
			text = type,
			name = weapon,
			label = Config['ammo'],
			count = '✐'..ESX.Math.GroupDigits(count)
		})
end)
