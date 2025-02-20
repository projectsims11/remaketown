

local GUI = {}

local Faketimer = 0
ESX = exports['es_extended']:getSharedObject()

local balance = 0
local Cash = 0
local bill = 0

function accounts_to_data()
	for k,v in ipairs(ESX.PlayerData.accounts) do
		-- if v.name == account.name then
			-- ESX.PlayerData.accounts[k] = account
			if v.name == 'money' then
				Cash = v.money
			elseif v.name == 'bank' then
				balance = v.money
			end
		-- end
	end
	SendNUIMessage({
		message = "updateBalance",
		balance = balance,
		Money = Cash
	})
end

CreateThread(function()
	if ESX.PlayerLoaded then
		ESX.PlayerData =  ESX.GetPlayerData()
		accounts_to_data()
	end
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer, isNew, skin)
	ESX.PlayerLoaded = true
	ESX.PlayerData = xPlayer
	accounts_to_data()
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
	for k,v in ipairs(ESX.PlayerData.accounts) do
		if v.name == account.name then
			ESX.PlayerData.accounts[k] = account
			break
		end
	end
	accounts_to_data()
end)

AddEventHandler('o-billing:create', function(player)
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'dialog_createbill', {
		title = "ใส่ชื่อบิล",
	}, function(data, menu)
		if not data.value then
			TriggerEvent("pNotify:SendNotification", {
				text = "กรุณาใส่รายละเอียดบิล",
				layout = "centerRight",
				type = "error",
				timeout = 3000,
				queue = "global",
				theme = "mint",
			})
		else
			CreateBillingPrice(player, data.value)
			menu.close()
		end
	end, function(data, menu)
		menu.close()
	end)
end)

function CreateBillingPrice(player, value)
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'dialog_createbill_price', {
		title = "ใส่จำนวนเงิน",
	}, function(data, menu)
		local amount = tonumber(data.value)
		if amount then
			if amount > 30000 then
				TriggerEvent("pNotify:SendNotification", {
					text = "จำนวนเงินมากเกินไป : "..amount,
					type = "error",
					timeout = 3000,
					layout = "centerRight",
					queue = "global",
				})
				return
			end

			TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_'..ESX.GetPlayerData().job.name, "ค่าปรับ: "..value, amount)
			menu.close()
			TriggerEvent("pNotify:SendNotification", {
				text = "<strong class='green-text'>สร้างบิลเรียบร้อยแล้ว</strong>",
				type = "success",
				timeout = 3000,
				layout = "centerRight",
				queue = "global",
			})
		else
			TriggerEvent("pNotify:SendNotification", {
				text = "กรุณาใส่จำนวนเงิน",
				type = "error",
				timeout = 3000,
				layout = "centerRight",
				queue = "global",
			})
		end
	end, function(data2, menu2)
		menu2.close()
	end)
end

function ShowBillsMenu()
	ESX.TriggerServerCallback('esx_billing:getBills', function(bills)
		ESX.UI.Menu.CloseAll()
		SendNUIMessage({
			message = "openNUI",
			display = "true",
			name    = GetPlayerName(PlayerId()),
			Billall = bills or {}
		})
	
		if Config.MoneyBillpay.enable then
			SendNUIMessage({
				message = "Billalllist",
				listBilling = bills or {},
				limit   = Config.MoneyBillpay.limit
			})
		else
			SendNUIMessage({
				message = "Billalllist",
				listBilling = bills or {}
			})
		end
		
		SetNuiFocus(true, true)
	end)
end

Citizen.CreateThread(function() -- Thread for  timer
	while true do 
		Citizen.Wait(10000)
		Faketimer = Faketimer + 1 
	end 
end)

-- Key controls
if Config.Billpayauto.enable then
	Citizen.CreateThread(function()
		while true do

		Wait(10000)
			if Faketimer >= 60 then
				Faketimer = 0
				payAllBills()

				if Config.Billpayauto.pNotify then
					TriggerEvent("pNotify:SendNotification",{
						text = "ทำการจ่ายเงิน ออโต้เรียบร้อย",
						type = "error",
						timeout = (3000),
						layout = "centerRight",
						queue = "global"
					})
				end
			end 
		end
	end)
end

function payAllBills()
	ESX.TriggerServerCallback('esx_billing:getBills', function(bills)
		for i=1, #bills, 1 do
						ESX.TriggerServerCallback('esx_billing:payBill', function()
				end, bills[i].id)
		end
	end)
end


RegisterKeyMapping('Billing', 'Billing', 'KEYBOARD', 'F7')

RegisterCommand('Billing', function()
	if not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'billing') then
		ShowBillsMenu()
	end
end)


RegisterNUICallback('quit', function(data)
	SendNUIMessage({
		message = "openNUI",
		display = "false"
	})
	SetNuiFocus(false, false)
end)

RegisterNUICallback('Paybill', function(data)
	ESX.TriggerServerCallback('esx_billing:payBill', function()
		ESX.TriggerServerCallback('esx_billing:getBills', function(bills)
			ESX.UI.Menu.CloseAll()
			SendNUIMessage({
				message = "openNUI",
				display = "true",
				name    = GetPlayerName(PlayerId()),
				Billall = bills or {}
			})
		
			SendNUIMessage({
				message = "Billalllist",
				listBilling = bills or {}
			})
			
			SetNuiFocus(true, true)
		end)
	end, data.idbill)
end)

exports('Paymant', function(cb)
	bill = 0
	if Config.MoneyBillpay.enable then
		ESX.TriggerServerCallback('esx_billing:getBills', function(bills)
			for k,v in ipairs(bills) do
				bill = bill + v.amount
			end
			if Config.MoneyBillpay.limit <= bill then
				cb(true)
			else
				cb(false)
			end
		end)
	else
		ESX.TriggerServerCallback('esx_billing:getBills', function(bills)
			cb(false)
		end)
	end
end)

AddEventHandler("Starsation_core:ClientMemoryGarbage", function()
	Citizen.CreateThread(function()
		Wait(math.random(100, 2000))
		collectgarbage()
	end)
end)