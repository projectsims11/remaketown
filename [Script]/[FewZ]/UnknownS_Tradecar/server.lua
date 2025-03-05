ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local Webhook = ''

RegisterServerEvent('UnknownS_Tradecar:changeVehicleOwner')
AddEventHandler('UnknownS_Tradecar:changeVehicleOwner', function(data)
	_source = data.sourceIDSeller
	target = data.targetIDSeller
	plate = data.plateNumberSeller
	model = data.modelSeller
	source_name = data.sourceNameSeller
	target_name = data.targetNameSeller
	vehicle_price = tonumber(data.vehicle_price)

	local xPlayer = ESX.GetPlayerFromId(_source)
	local tPlayer = ESX.GetPlayerFromId(target)
	local webhookData = {
		model = model,
		plate = plate,
		target_name = target_name,
		source_name = source_name,
		vehicle_price = vehicle_price
	}
	local result = MySQL.Sync.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @identifier AND plate = @plate', {
		['@identifier'] = xPlayer.identifier,
		['@plate'] = plate
	})

	if Config.RemoveMoneyOnSign then
		local bankMoney = tPlayer.getAccount('bank').money

		if result[1] ~= nil  then
			if bankMoney >= vehicle_price then
				MySQL.Async.execute('UPDATE owned_vehicles SET owner = @target WHERE owner = @owner AND plate = @plate', {
					['@owner'] = xPlayer.identifier,
					['@target'] = tPlayer.identifier,
					['@plate'] = plate
				}, function (result2)
					if result2 ~= 0 then	
						tPlayer.removeAccountMoney('bank', vehicle_price)
						xPlayer.addAccountMoney('bank', vehicle_price)
						
					TriggerClientEvent("nc_notify:PushNotification", source, {
						title = 'โอนรถ',
						description = "คุณขายรถสำเร็จแล้ว <b>"..model.."</b> พร้อมเลขทะเบียน <b>"..plate.."</b>",
						icon = 'car_key',
						type = 'success',
						duration = 5000
					})
					TriggerClientEvent("nc_notify:PushNotification", target, {
						title = 'โอนรถ',
						description = "คุณซื้อรถสำเร็จแล้ว <b>"..model.."</b> พร้อมเลขทะเบียน <b>"..plate.."</b>",
						icon = 'car_key',
						type = 'success',
						duration = 5000
					})

						exports.nc_inventory:UpdateItems(_source, 'key')
						exports.nc_inventory:UpdateItems(target, 'key')
						TriggerClientEvent('nc_inventory:UpdateAPUKeys', _source)
						TriggerClientEvent('nc_inventory:UpdateAPUKeys', target)

										
						exports.nc_discordlogs:Discord({
							webhook = 'GiveCar',
							xPlayer = source,
							description =  '**ชื่อรถ: **'..model..'**\nป้ายทะเบียน: **'..plate..'**\nชื่อผู้ซื้อ: **'..target_name..'**\nชื่อผู้ขาย: **'..source_name..'**\nราคา: **'..vehicle_price..'€',  -- คำอธิบายรายละเอียด (optional)
						})
										

						if Webhook ~= '' then
							sellVehicleWebhook(webhookData)
						end
					end
				end)
			else
					
				TriggerClientEvent("nc_notify:PushNotification", _source, {
					title = 'โอนรถ',
					description = target_name.." ไม่มีเงินพอที่จะซื้อรถของคุณ",
					icon = 'car_key',
					type = 'error',
					duration = 5000
				})
				TriggerClientEvent("nc_notify:PushNotification", target, {
					title = 'โอนรถ',
					description = "มีเงินไม่พอซื้อ "..source_name.."",
					icon = 'car_key',
					type = 'error',
					duration = 5000
				})
			end
		else
			TriggerClientEvent("nc_notify:PushNotification", _source, {
				title = 'โอนรถ',
				description = "รถที่มีเลขทะเบียน <b>"..plate.."</b> ไม่ใช่ของคุณ",
				icon = 'car_key',
				type = 'error',
				duration = 5000
			})

			TriggerClientEvent("nc_notify:PushNotification", target, {
				title = 'โอนรถ',
				description = source_name.." พยายามขายรถที่เขาไม่ได้เป็นเจ้าของให้คุณ",
				icon = 'car_key',
				type = 'error',
				duration = 5000
			})
		end
	else
		if result[1] ~= nil then
			MySQL.Async.execute('UPDATE owned_vehicles SET owner = @target WHERE owner = @owner AND plate = @plate', {
				['@owner'] = xPlayer.identifier,
				['@target'] = tPlayer.identifier,
				['@plate'] = plate
			}, function (result2)
				if result2 ~= 0 then
								
					TriggerClientEvent("nc_notify:PushNotification", source, {
						title = 'โอนรถ',
						description = "คุณขายรถสำเร็จแล้ว <b>"..model.."</b> พร้อมเลขทะเบียน <b>"..plate.."</b>",
						icon = 'car_key',
						type = 'success',
						duration = 5000
					})
					TriggerClientEvent("nc_notify:PushNotification", target, {
						title = 'โอนรถ',
						description = "คุณซื้อรถสำเร็จแล้ว <b>"..model.."</b> พร้อมเลขทะเบียน <b>"..plate.."</b>",
						icon = 'car_key',
						type = 'success',
						duration = 5000
					})
					exports.nc_inventory:UpdateItems(_source, 'key')
					exports.nc_inventory:UpdateItems(target, 'key')
					TriggerClientEvent('nc_inventory:UpdateAPUKeys', _source)
					TriggerClientEvent('nc_inventory:UpdateAPUKeys', target)
					exports['AFU-Pat6900.Carlock']:refreshOwnedCar()

					if Webhook ~= '' then
						sellVehicleWebhook(webhookData)
					end
				end
			end)
		else
			
			TriggerClientEvent("nc_notify:PushNotification", _source, {
				title = 'โอนรถ',
				description = "รถที่มีเลขทะเบียน <b>"..plate.."</b> ไม่ใช่ของคุณ",
				icon = 'car_key',
				type = 'error',
				duration = 5000
			})

			TriggerClientEvent("nc_notify:PushNotification", target, {
				title = 'โอนรถ',
				description = source_name.." พยายามขายรถที่เขาไม่ได้เป็นเจ้าของให้คุณ",
				icon = 'car_key',
				type = 'error',
				duration = 5000
			})
		end
	end
end)

ESX.RegisterServerCallback('UnknownS_Tradecar:GetTargetName', function(source, cb, targetid)
	local target = ESX.GetPlayerFromId(targetid)
	local targetname = target.getName()

	cb(targetname)
end)

RegisterServerEvent('UnknownS_Tradecar:SendVehicleInfo')
AddEventHandler('UnknownS_Tradecar:SendVehicleInfo', function(description, price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerClientEvent('UnknownS_Tradecar:GetVehicleInfo', _source, xPlayer.getName(), os.date(Config.DateFormat), description, price, _source)
end)

RegisterServerEvent('UnknownS_Tradecar:SendContractToBuyer')
AddEventHandler('UnknownS_Tradecar:SendContractToBuyer', function(data)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerClientEvent("UnknownS_Tradecar:OpenContractOnBuyer", data.targetID, data)
	TriggerClientEvent('UnknownS_Tradecar:startContractAnimation', data.targetID)

	if Config.RemoveContractAfterUse then
		xPlayer.removeInventoryItem('tradecar', 1)
	end
end)

ESX.RegisterUsableItem('tradecar', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerClientEvent('UnknownS_Tradecar:OpenContractInfo', _source)
	TriggerClientEvent('UnknownS_Tradecar:startContractAnimation', _source)
end)

-------------------------- SELL VEHICLE WEBHOOK

function sellVehicleWebhook(data)
	local information = {
		{
			["color"] = Config.sellVehicleWebhookColor,
			["author"] = {
				["icon_url"] = Config.IconURL,
				["name"] = Config.ServerName..' - Logs',
			},
			["title"] = 'VEHICLE SALE',
			["description"] = '**ชื่อรถ: **'..data.model..'**\nป้ายทะเบียน: **'..data.plate..'**\nชื่อผู้ซื้อ: **'..data.target_name..'**\nชื่อผู้ขาย: **'..data.source_name..'**\nราคา: **'..data.vehicle_price..'€',

			["footer"] = {
				["text"] = os.date(Config.WebhookDateFormat),
			}
		}
	}
	PerformHttpRequest(Webhook, function(err, text, headers) end, 'POST', json.encode({username = Config.BotName, embeds = information}), {['Content-Type'] = 'application/json'})
end