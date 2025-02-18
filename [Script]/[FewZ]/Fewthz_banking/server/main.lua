ESX = exports["es_extended"]:getSharedObject()
local FewZ = GetCurrentResourceName()

RegisterServerEvent(FewZ..'balance')
AddEventHandler(FewZ..'balance', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	money = xPlayer.getAccount('bank').money
	monneyacount = xPlayer.getAccount('money').money
	TriggerClientEvent('updateKonto', _source, money, monneyacount)
end)

RegisterServerEvent(FewZ..'deposit')
AddEventHandler(FewZ..'deposit', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if amount == nil or amount <= 0 or amount > xPlayer.getMoney() then
		TriggerClientEvent(FewZ..'bank:notify', _source, "error", "จำนวนเงินไม่ถูกต้อง")
	else
		xPlayer.removeMoney(amount)
		xPlayer.addAccountMoney('bank', tonumber(amount))

		TriggerClientEvent(FewZ..'bank:notify', _source, "success", "คุณฝากเงินสำเร็จ $" .. amount)

		local sendToDiscord = '' .. xPlayer.name .. ' ฝากเงิน จำนวน $' .. ESX.Math.GroupDigits(amount) .. ' คงเหลือในกระเป๋า $' .. ESX.Math.GroupDigits(xPlayer.getMoney()) .. ' มีเงินในบัญชี $' .. ESX.Math.GroupDigits(xPlayer.getAccount('bank').money) .. ''
        TriggerEvent('azael_discordlogs:sendToDiscord', 'BankDeposit', sendToDiscord, xPlayer.source, '^2')
	end
end)

RegisterServerEvent(FewZ..'withdraw')
AddEventHandler(FewZ..'withdraw', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local base = 0
	amount = tonumber(amount)
	base = xPlayer.getAccount('bank').money
	if amount == nil or amount <= 0 or amount > base then
	 TriggerClientEvent(FewZ..'bank:notify', _source, "error", "จำนวนเงินไม่ถูกต้อง")
	else
		xPlayer.removeAccountMoney('bank', amount)
		xPlayer.addMoney(amount)

		TriggerClientEvent(FewZ..'bank:notify', _source, "success", "คุณถอนเงินสำเร็จ $" .. amount)

		local sendToDiscord = '' .. xPlayer.name .. ' ถอนเงิน จำนวน $' .. ESX.Math.GroupDigits(amount) .. ' ในบัญชีคงเหลือ $' .. ESX.Math.GroupDigits(xPlayer.getAccount('bank').money) .. ' มีเงินในกระเป๋า $' .. ESX.Math.GroupDigits(xPlayer.getMoney()) .. ''
		TriggerEvent('azael_discordlogs:sendToDiscord', 'BankWithdraw', sendToDiscord, xPlayer.source, '^1')
			 
	end
end)


RegisterServerEvent(FewZ..'transfer')
AddEventHandler(FewZ..'transfer', function(transferIdInput, transferAmountInput)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local zPlayer = ESX.GetPlayerFromId(transferIdInput)
	local balance = 0

	if(zPlayer == nil or zPlayer == -1) then
		TriggerClientEvent(FewZ..'bank:notify', _source, "error", "ไม่พบผู้รับ")
	else
		balance = xPlayer.getAccount('bank').money
		zbalance = zPlayer.getAccount('bank').money
		
		if tonumber(_source) == tonumber(transferIdInput) then
			TriggerClientEvent(FewZ..'bank:notify', _source, "error", "คุณไม่สามารถโอนเงินให้กับตัวเอง")
		else
			if balance <= 0 or balance < tonumber(transferAmountInput) or tonumber(transferAmountInput) <= 0 then
				TriggerClientEvent(FewZ..'bank:notify', _source, "error", "คุณไม่มีเงินเพียงพอสำหรับการโอนนี้")
			else
				xPlayer.removeAccountMoney('bank', tonumber(transferAmountInput))
				zPlayer.addAccountMoney('bank', tonumber(transferAmountInput))

				TriggerClientEvent(FewZ..'bank:notify', _source, "success", "คุณโอนเงินสำเร็จ $" .. amount)
				TriggerClientEvent(FewZ..'bank:notify', transferIdInput, "success", "คุณเพิ่งได้รับเงิน $" .. amount .. ' จากการโอน')

				local sendToDiscord = '' .. xPlayer.name .. ' โอนเงิน ไปยัง ' .. zPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(amountt) .. ' ในบัญชีคงเหลือ $' .. ESX.Math.GroupDigits(xPlayer.getAccount('bank').money) .. ''
				TriggerEvent('azael_discordlogs:sendToDiscord', 'BankTransfer', sendToDiscord, xPlayer.source, '^3')
			end
		end
	end
end)