ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_billing:getTargetBills', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)

	if xPlayer then
		MySQL.query('SELECT amount, id, label FROM billing WHERE identifier = ?', {xPlayer.identifier},
		function(result)
			cb(result)
		end)
	else
		cb({})
	end
end)

RegisterServerEvent('esx_billing:sendBill')
AddEventHandler('esx_billing:sendBill', function(playerId, sharedAccountName, label, amount)

	local xPlayer  = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()

	if Config.SocietyBill then
		if sharedAccountName == nil then
			sharedAccountName = "society_"..xPlayer.job.name
		else
			sharedAccountName = "society_"..xPlayer.job.name
		end
	else
		sharedAccountName = ''
	end

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
								local sendToDiscord = "คุณ "..xPlayer2.getName().." ได้รับบิลจำนวน "..amount.." จาก "..xPlayer.getName()
								TriggerEvent('azael_discordlogs:sendToDiscord', 'Getbill', sendToDiscord, _source, '^2')
								TriggerClientEvent("pNotify:SendNotification", xPlayer2.source, {
									text = '<strong class="blue-text">ช่วยเหลือ</strong> คุณได้รับใบแจ้งหนี้',
									type = "information",
									timeout = 3000,
									layout = "centerRight",
									queue = "global"
								})

								--TriggerClientEvent('esx_billing:havebills', xPlayer2.source,true)
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
								local sendToDiscord = "คุณ "..xPlayer2.getName().." ได้รับบิลจำนวน "..amount.." จาก "..xPlayer.getName()
								TriggerEvent('azael_discordlogs:sendToDiscord', 'Getbill', sendToDiscord, _source, '^2')
								TriggerClientEvent("pNotify:SendNotification", xPlayer2.source, {
									text = '<strong class="blue-text">ช่วยเหลือ</strong> คุณได้รับใบแจ้งหนี้',
									type = "information",
									timeout = 3000,
									layout = "centerRight",
									queue = "global"
								})
								--TriggerClientEvent('esx_billing:havebills', xPlayer2.source,true)
							end
						)

					break
				end
			end

		end

	end)

end)





RegisterServerEvent('esx_billing:getBills:sv')
AddEventHandler('esx_billing:getBills:sv', function()
	local bills = {}
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll(
		'SELECT * FROM billing WHERE identifier = @identifier',
		{
			['@identifier'] = xPlayer.identifier
		},
		function(result)
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
			TriggerClientEvent("esx_billing:getBills:cl", xPlayer.source, bills)
		end
	)
end)


RegisterServerEvent('esx_billing:getBillsToPay:sv')
AddEventHandler('esx_billing:getBillsToPay:sv', function()
	local bills = {}
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll(
		'SELECT * FROM billing WHERE identifier = @identifier',
		{
			['@identifier'] = xPlayer.identifier
		},
		function(result)
			for i=1, #result, 1 do
				local checkcanpay = false
				if xPlayer.getMoney() >= tonumber(result[i].amount) then
					checkcanpay = true
				elseif xPlayer.getAccount('bank').money >= tonumber(result[i].amount) then
					checkcanpay = true
				end
				table.insert(bills, {
					id         = result[i].id,
					identifier = result[i].identifier,
					sender     = result[i].sender,
					targetType = result[i].target_type,
					target     = result[i].target,
					label      = result[i].label,
					amount     = result[i].amount,
					canpay     = checkcanpay,
				})
			end
			TriggerClientEvent("esx_billing:getBillsToPay:cl", xPlayer.source, bills)
		end
	)
end)








-- ESX.RegisterServerCallback('esx_billing:getBills', function(source, cb)

-- 	local xPlayer = ESX.GetPlayerFromId(source)

-- 	MySQL.Async.fetchAll(
-- 		'SELECT * FROM billing WHERE identifier = @identifier',
-- 		{
-- 			['@identifier'] = xPlayer.identifier
-- 		},
-- 		function(result)

-- 			local bills = {}

-- 			for i=1, #result, 1 do
-- 				table.insert(bills, {
-- 					id         = result[i].id,
-- 					identifier = result[i].identifier,
-- 					sender     = result[i].sender,
-- 					targetType = result[i].target_type,
-- 					target     = result[i].target,
-- 					label      = result[i].label,
-- 					amount     = result[i].amount
-- 				})
-- 			end

-- 			cb(bills)

-- 		end
-- 	)

-- end)


RegisterServerEvent('esx_billing:payBill:sv')
AddEventHandler('esx_billing:payBill:sv', function(id)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source
	local foundPlayer = nil
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
			local xPlayers    = ESX.GetPlayers()
			

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
								
								local sendToDiscord = "คุณ "..xPlayer.getName().." ได้จ่ายบิล จำนวน "..amount.." ให้ "..foundPlayer.getName()
								TriggerEvent('azael_discordlogs:sendToDiscord', 'Paybill', sendToDiscord, _source, '^2')

								TriggerClientEvent("pNotify:SendNotification", xPlayer.source, {
									text = '<strong class="green-text">สำเร็จ</strong> คุณจ่ายใบแจ้งหนี้จำนวน $'..amount,
									type = "information",
									timeout = 3000,
									layout = "centerRight",
									queue = "global"
								})
								TriggerClientEvent("pNotify:SendNotification", foundPlayer.source, {
									text = '<strong class="green-text">สำเร็จ</strong> คุณได้รับการชำระเงินจำนวน $'..amount,
									type = "information",
									timeout = 3000,
									layout = "centerRight",
									queue = "global"
								})
							

							end
						)

					elseif xPlayer.getAccount('bank').money >= amount then
						MySQL.Async.execute(
							'DELETE from billing WHERE id = @id',
							{
								['@id'] = id
							},
							function(rowsChanged)

								xPlayer.removeMoney(amount)
								foundPlayer.addMoney(amount)
								
								local sendToDiscord = "คุณ "..xPlayer.getName().." ได้จ่ายบิล จำนวน "..amount.." ให้ "..foundPlayer.getName()
								TriggerEvent('azael_discordlogs:sendToDiscord', 'Paybill', sendToDiscord, _source, '^2')

								TriggerClientEvent("pNotify:SendNotification", xPlayer.source, {
									text = '<strong class="green-text">สำเร็จ</strong> คุณจ่ายใบแจ้งหนี้จำนวน $'..amount,
									type = "information",
									timeout = 3000,
									layout = "centerRight",
									queue = "global"
								})
								TriggerClientEvent("pNotify:SendNotification", foundPlayer.source, {
									text = '<strong class="green-text">สำเร็จ</strong> คุณได้รับการชำระเงินจำนวน $'..amount,
									type = "information",
									timeout = 3000,
									layout = "centerRight",
									queue = "global"
								})
							

							end
						)
					else
						TriggerClientEvent("pNotify:SendNotification", foundPlayer.source, {
							text = '<strong class="red-text">ล้มเหลว</strong> ผู้เล่นไม่มีเงินพอจะจ่ายบิล',
							type = "information",
							timeout = 3000,
							layout = "centerRight",
							queue = "global"
						})
						TriggerClientEvent("pNotify:SendNotification", xPlayer.source, {
							text = '<strong class="red-text">ล้มเหลว</strong> คุณมีเงินไม่พอจพจ่ายบิล',
							type = "information",
							timeout = 3000,
							layout = "centerRight",
							queue = "global"
						})
					end

				else
				
					TriggerClientEvent("pNotify:SendNotification", _source, {
						text = '<strong class="red-text">ล้มเหลว</strong> ผู้เล่นไม่ได้เข้าสู่ระบบ',
						type = "information",
						timeout = 3000,
						layout = "centerRight",
						queue = "global"
					})
					
					

				end

			else
				

				TriggerEvent('esx_addonaccount:getSharedAccount', target, function(account)

					if xPlayer.getMoney() >= amount then

						if Config.BillCutUse then
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
						end

						MySQL.Async.execute(
							'DELETE from billing WHERE id = @id',
							{
								['@id'] = id
							},
							function(rowsChanged)

								xPlayer.removeMoney(amount)
								account.addMoney(amount)
								local sendToDiscord = "คุณ "..xPlayer.getName().." ได้จ่ายบิล จำนวน "..amount.." ให้ "..foundPlayer.getName()
								TriggerEvent('azael_discordlogs:sendToDiscord', 'Paybill', sendToDiscord, _source, '^2')
								-- TriggerClientEvent('esx:showNotification', xPlayer.source, _U('paid_invoice') .. amount)
								TriggerClientEvent("pNotify:SendNotification", xPlayer.source, {
									text = '<strong class="green-text">สำเร็จ</strong> คุณจ่ายใบแจ้งหนี้จำนวน $'..amount,
									type = "information",
									timeout = 3000,
									layout = "centerRight",
									queue = "global"
								})

								if foundPlayer ~= nil then
									-- TriggerClientEvent('esx:showNotification', foundPlayer.source, _U('received_payment') .. amount)
									TriggerClientEvent("pNotify:SendNotification", foundPlayer.source, {
										text = '<strong class="green-text">สำเร็จ</strong> คุณได้รับการชำระเงินจำนวน $'..amount,
										type = "information",
										timeout = 3000,
										layout = "centerRight",
										queue = "global"
									})
								end

								-- cb()

							end
						)

					elseif xPlayer.getAccount('bank').money >= amount then
						if Config.BillCutUse then
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
						end

						MySQL.Async.execute(
							'DELETE from billing WHERE id = @id',
							{
								['@id'] = id
							},
							function(rowsChanged)

								xPlayer.removeMoney(amount)
								account.addMoney(amount)
								local sendToDiscord = "คุณ "..xPlayer.getName().." ได้จ่ายบิล จำนวน "..amount.." ให้ "..foundPlayer.getName()
								TriggerEvent('azael_discordlogs:sendToDiscord', 'Paybill', sendToDiscord, _source, '^2')
								-- TriggerClientEvent('esx:showNotification', xPlayer.source, _U('paid_invoice') .. amount)
								TriggerClientEvent("pNotify:SendNotification", xPlayer.source, {
									text = '<strong class="green-text">สำเร็จ</strong> คุณจ่ายใบแจ้งหนี้จำนวน $'..amount,
									type = "information",
									timeout = 3000,
									layout = "centerRight",
									queue = "global"
								})

								if foundPlayer ~= nil then
									-- TriggerClientEvent('esx:showNotification', foundPlayer.source, _U('received_payment') .. amount)
									TriggerClientEvent("pNotify:SendNotification", foundPlayer.source, {
										text = '<strong class="green-text">สำเร็จ</strong> คุณได้รับการชำระเงินจำนวน $'..amount,
										type = "information",
										timeout = 3000,
										layout = "centerRight",
										queue = "global"
									})
								end

								-- cb()

							end
						)

					else
						if foundPlayer ~= nil then
							TriggerClientEvent("pNotify:SendNotification", foundPlayer.source, {
								text = '<strong class="red-text">ล้มเหลว</strong> ผู้เล่นไม่มีเงินพอจะจ่ายบิล',
								type = "information",
								timeout = 3000,
								layout = "centerRight",
								queue = "global"
							})
						end
						TriggerClientEvent("pNotify:SendNotification", xPlayer.source, {
							text = '<strong class="red-text">ล้มเหลว</strong> คุณมีเงินไม่พอจะจ่ายบิล',
							type = "information",
							timeout = 3000,
							layout = "centerRight",
							queue = "global"
						})
					end

				end)

			end

		end
	)
end)