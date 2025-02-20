ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local function tsToUnix(vSql_ts)
	local pattern = "(%d+)%-(%d+)%-(%d+) (%d+):(%d+):(%d+)"
	local xyear, xmonth, xday, xhour, xmin, xsec = vSql_ts:match(pattern)
	local unixTs = os.time({year=xyear, month=xmonth, day=xday, hour=xhour, min=xmin, sec=xsec})
	return unixTs
  end

  
ESX.RegisterServerCallback('esx_billing:getBillsIdView', function(source, cb, Id)

	MySQL.Async.fetchAll('SELECT id, identifier, sender, target_type, target, label, amount, date_format(time, "%Y-%m-%d") AS time FROM billing WHERE id = @id', {
		['@id'] = Id
	}, function(result)
		cb({
			id         = result[1].id,
			identifier = result[1].identifier,
			sender     = result[1].sender,
			targetType = result[1].target_type,
			target     = result[1].target,
			label      = result[1].label,
			amount     = result[1].amount,
			time		  = result[1].time
		})

	end)

end)

ESX.RegisterServerCallback('esx_billing:getBillsId', function(source, cb, Id)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT id, identifier, sender, target_type, target, label, amount, date_format(time, "%Y-%m-%d") AS time FROM billing WHERE identifier = @identifier AND id = @id', {
		['@identifier'] = xPlayer.identifier,
		['@id'] = Id
	}, function(result)
		cb({
			id         = result[1].id,
			identifier = result[1].identifier,
			sender     = result[1].sender,
			targetType = result[1].target_type,
			target     = result[1].target,
			label      = result[1].label,
			amount     = result[1].amount,
			time		  = result[1].time
		})

	end)

end)

ESX.RegisterServerCallback('esx_billing:getTargetBills', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)

	MySQL.Async.fetchAll(
		'SELECT id, identifier, sender, target_type, target, label, amount, date_format(time, "%Y-%m-%d") AS time FROM billing WHERE identifier = @identifier',
		{
			['@identifier'] = xPlayer.identifier
		},
		function(result)

			local bills = {}

			for i=1, #result, 1 do
				table.insert(bills, {
					id         = result[i].id,
					identifier = result[i].identifier,
					sender     = result[i].sender,
					targetType = result[i].target_type,
					target     = result[i].target,
					label      = result[i].label,
					amount     = result[i].amount,
					time		  = result[i].time
				})
			end

			cb(bills)

		end
	)

end)

RegisterServerEvent('esx_billing:sendBill')
AddEventHandler('esx_billing:sendBill', function(playerId, sharedAccountName, label, amount)

	local xPlayer  = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()

	TriggerEvent('esx_addonaccount:getSharedAccount', sharedAccountName, function(account)

		if account == nil then

			for i=1, #xPlayers, 1 do

				local xPlayer2 = ESX.GetPlayerFromId(xPlayers[i])

				if xPlayer2.source == playerId then

						MySQL.Async.execute(
							'INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)',
							{
								['@identifier']  = xPlayer2.identifier,
								['@sender']      = xPlayer.identifier,
								['@target_type'] = 'player',
								['@target']      = xPlayer.identifier,
								['@label']       = label,
								['@amount']      = amount
							},
							function(rowsChanged)
								TriggerClientEvent('esx:showNotification', xPlayer2.source, _U('received_invoice'))

								local sendToDiscord = '' .. xPlayer.name .. ' เรียกเก็บเงินค่า ' .. label .. ' กับ ' .. xPlayer2.name .. ' จำนวน $' .. ESX.Math.GroupDigits(amount) .. ''
								TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'SendBill', sendToDiscord, xPlayer.source, '^2')

								Citizen.Wait(100)
																						
								local sendToDiscord2 = '' .. xPlayer2.name .. ' ค้างชำระค่า ' .. label .. ' กับ ' .. xPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(amount) .. ''
								TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'SendBill', sendToDiscord2, xPlayer2.source, '^1')
							end
						)

					break
				end
			end

		else

			for i=1, #xPlayers, 1 do

				local xPlayer2 = ESX.GetPlayerFromId(xPlayers[i])

				if xPlayer2.source == playerId then

						MySQL.Async.execute(
							'INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)',
							{
								['@identifier']  = xPlayer2.identifier,
								['@sender']      = xPlayer.identifier,
								['@target_type'] = 'society',
								['@target']      = sharedAccountName,
								['@label']       = label,
								['@amount']      = amount
							},
							function(rowsChanged)
								TriggerClientEvent('esx:showNotification', xPlayer2.source, _U('received_invoice'))

								local sendToDiscord = '' .. xPlayer.name .. ' เรียกเก็บเงินค่า ' .. label .. ' กับ ' .. xPlayer2.name .. ' จำนวน $' .. ESX.Math.GroupDigits(amount) .. ' Target: [' .. sharedAccountName .. ']'
								TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'SendBill', sendToDiscord, xPlayer.source, '^2')

								Citizen.Wait(100)
																						
								local sendToDiscord2 = '' .. xPlayer2.name .. ' ค้างชำระค่า ' .. label .. ' กับ ' .. xPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(amount) .. ' Target: [' .. sharedAccountName .. ']'
								TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'SendBill', sendToDiscord2, xPlayer2.source, '^1')
							end
						)

					break
				end
			end

		end

	end)

end)

ESX.RegisterServerCallback('esx_billing:getBills', function(source, cb)

	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll(
		'SELECT * FROM billing WHERE identifier = @identifier',
		{
			['@identifier'] = xPlayer.identifier
		},
		function(result)

			local bills = {}

			for i=1, #result, 1 do
				table.insert(bills, {
					id         = result[i].id,
					identifier = result[i].identifier,
					sender     = result[i].sender,
					targetType = result[i].target_type,
					target     = result[i].target,
					label      = result[i].label,
					amount     = result[i].amount
				})
			end

			cb(bills)

		end
	)

end)

ESX.RegisterServerCallback('esx_billing:payBill', function(source, cb, id)

	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll(
		'SELECT * FROM billing WHERE id = @id',
		{
			['@id'] = id
		},
		function(result)

			local sender      = result[1].sender
			local targetType  = result[1].target_type
			local target      = result[1].target
			local amount      = result[1].amount
			local time     = result[1].time
			local xPlayers    = ESX.GetPlayers()
			local foundPlayer = nil

			for i=1, #xPlayers, 1 do

				local xPlayer2 = ESX.GetPlayerFromId(xPlayers[i])
				
				if xPlayer2.identifier == sender then
					foundPlayer = xPlayer2
					break
				end
			end

			if targetType == 'player' then

				if foundPlayer ~= nil then

					if xPlayer.getMoney() >= amount then

						MySQL.Async.execute(
							'DELETE from billing WHERE id = @id',
							{
								['@id'] = id
							},
							function(rowsChanged)

								xPlayer.removeMoney(amount)
								foundPlayer.addMoney(amount)
								
								TriggerClientEvent('esx_billing:paidBill', xPlayer.source, result[1])
								TriggerClientEvent('esx:showNotification', xPlayer.source, _U('paid_invoice') .. amount)
								TriggerClientEvent('esx:showNotification', foundPlayer.source, _U('received_payment') .. amount)

								local sendToDiscord = '' .. xPlayer.name .. ' ชำระเงินค่า ' .. result[1].label .. ' ให้กับ ' .. foundPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(amount) .. ''
								TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'PayBill', sendToDiscord, xPlayer.source, '^2')

								Citizen.Wait(100)
																							
								local sendToDiscord2 = '' .. foundPlayer.name .. ' ได้รับเงินค่า ' .. result[1].label .. ' จาก ' .. xPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(amount) .. ''
								TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'PayBill', sendToDiscord2, foundPlayer.source, '^5')
							
								cb()

							end
						)

					else
						TriggerClientEvent('esx:showNotification', _source, _U('player_not_logged'))
						cb()
					end

				end

			else
				local cut = amount
				if Config.BillCut and Config.BillCut[target] then
					local per = math.floor(cut * (Config.BillCut[target] / 100))
					cut = cut - per
					if foundPlayer ~= nil then
						foundPlayer.addMoney(per)
						TriggerClientEvent('esx:showNotification', foundPlayer.source, "Received ~r~$"..per.."~s~ ("..Config.BillCut[target].."% of billing)")

						local sendToDiscord2 = '' .. foundPlayer.name .. ' ได้รับเงินค่า ' .. result[1].label .. ' จาก ' .. xPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(amount) .. ' เข้ากระเป๋า $' .. ESX.Math.GroupDigits(per) .. ' เข้าหน่วยงาน $' .. ESX.Math.GroupDigits(cut) .. '  Target: ['.. target .. ']'
						TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'PayBill', sendToDiscord2, foundPlayer.source, '^5')
					else
					
					end
				end
				
				TriggerEvent('esx_addonaccount:getSharedAccount', target, function(account)

					MySQL.Async.execute(
						'DELETE from billing WHERE id = @id',
						{
							['@id'] = id
						},
						function(rowsChanged)

							xPlayer.removeMoney(amount)
							account.addMoney(cut)

							TriggerClientEvent("pNotify:SendNotification", xPlayer.source, {
								text = '<strong class="green-text">สำเร็จ</strong> คุณจ่ายใบแจ้งหนี้จำนวน $'..amount,
								type = "info",
								timeout = 3000,
								layout = "centerRight",
								queue = "global"
							})

							if foundPlayer ~= nil then
								-- TriggerClientEvent('esx:showNotification', foundPlayer.source, _U('received_payment') .. amount)
								TriggerClientEvent("pNotify:SendNotification", foundPlayer.source, {
									text = '<strong class="green-text">สำเร็จ</strong> คุณได้รับการชำระเงินจำนวน $'..amount,
									type = "info",
									timeout = 3000,
									layout = "centerRight",
									queue = "global"
								})
							end

							local sendToDiscord = '' .. xPlayer.name .. ' ชำระเงินค่า ' .. result[1].label .. ' จำนวน $' .. ESX.Math.GroupDigits(amount) .. ' Target: ['.. target .. ']'
							TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'PayBill', sendToDiscord, xPlayer.source, '^2')
																												
							cb()

						end
					)

				end)

			end

		end
	)

end)
