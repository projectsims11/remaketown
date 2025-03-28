function Alert(title, message, time, type)
	SendNUIMessage({
		action = 'open',
		title = title,
		type = type,
		message = message,
		time = time,
	})
end

RegisterNetEvent('okokNotify:Alert')
AddEventHandler('okokNotify:Alert', function(title, message, time, type)
	Alert(title, message, time, type)
end)

AddEventHandler("Fewthz_core:ClientMemoryGarbage", function()
	Citizen.CreateThread(function()
		Wait(math.random(100, 2000))
		collectgarbage()
	end)
end)

-- Example Commands - Delete them

RegisterCommand('success', function()
	--exports['okokNotify']:Alert("SUCCESS", "You have sent <span style='color:#47cf73'>420€</span> to Tommy!", 5000, 'success')
	exports['okokNotify']:Alert("สำเร็จ", "สไลด์พร้อมใช้งานแล้ว", 3000, 'success')
end)

RegisterCommand('info', function()
	exports['okokNotify']:Alert("INFO", "The Casino has opened!", 5000, 'info')
end)

RegisterCommand('error', function()
	exports['okokNotify']:Alert("ผิดพลาด", "ไม่สามารถใช้ได้", 5000, 'error')
end)

RegisterCommand('warning', function()
	exports['okokNotify']:Alert("เตือน", "You are getting nervous!", 5000, 'warning')
end)

RegisterCommand('phone', function()
	exports['okokNotify']:Alert("SMS", "<span style='color:#f38847'>Tommy: </span> Where are you?", 5000, 'phonemessage')
end)

RegisterCommand('longtext', function()
	exports['okokNotify']:Alert("LONG MESSAGE", "Lorem ipsum dolor sit amet, consectetur adipiscing elit e pluribus unum.", 5000, 'neutral')
end)