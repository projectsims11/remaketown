function Alert(message, time, type)
	SendNUIMessage({
		action = 'open',
		type = type,
		message = message,
		time = time,
	})
end

RegisterNetEvent('notify:Alert')
AddEventHandler('notify:Alert', function(message, time, type)
	Alert(message, time, type)
end)