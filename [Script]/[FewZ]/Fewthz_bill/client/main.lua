local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX       = nil
local GUI = {}
GUI.Time  = 0
local Faketimer = 0
local x = false
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx_billing:getBills:cl')
AddEventHandler('esx_billing:getBills:cl', function(f)
	local bills = f
	local elements = {}
	ESX.UI.Menu.CloseAll()

		if #bills > 0 then
			for i=1, #bills, 1 do
				table.insert(elements, {label = '[ รหัส '..bills[i].id..' ] '..bills[i].label .. ' <strong class="red-text">$' .. bills[i].amount..' </strong>', value = bills[i].id})
			end
		else
			table.insert(elements, {
				label = '<strong class="red-text">ไม่มีบิล</strong>'
			})
		end

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'billing',
			{
				title    = 'ใบแจ้งหนี้',
				align = 'center',
				elements = elements
			},
			function(data, menu)

				menu.close()

				local billId = data.current.value

				if billId ~= nil then
					TriggerServerEvent('esx_billing:payBill:sv', billId)
					
					Wait(100)
					ShowBillsMenu()
				end

			end,
			function(data, menu)
				menu.close()
			end
		)
end)

RegisterNetEvent('esx_billing:getBillsToPay:cl')
AddEventHandler('esx_billing:getBillsToPay:cl', function(f)
	local bills = f
	if bills ~= nil then
		local countcheck = 0 
		for i=1, #bills, 1 do
			TriggerServerEvent('esx_billing:payBill:sv', bills[i].id)
			if not bills[i].canpay then
				countcheck = countcheck + 1
			end
			if (i == #bills) and (countcheck > 0) then
				if Config.JailTime ~= nil then
					TriggerServerEvent("esx-qalle-jail:jailPlayer2", GetPlayerServerId(PlayerId()), Config.JailTime, Config.AnouceText, Config.JailPositions["CellSpe"], Config.JailPositions["OutCellSpe"])
			
				end
			end
		end
	end
end)


function ShowBillsMenu()
	TriggerServerEvent('esx_billing:getBills:sv')
end

--Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		Faketimer = Faketimer + 1 
		if Faketimer >= Config.AutoBillTime then
			Faketimer = 0
			TriggerServerEvent('esx_billing:getBillsToPay:sv')
		end
	end
end)

RegisterCommand('xBilling', function()
	ShowBillsMenu()
end)

RegisterKeyMapping('xBilling', 'xBilling', 'keyboard', 'F7')
