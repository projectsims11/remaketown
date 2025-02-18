--[[
	code generated using luamin.js, Herrtt#3868
--]]


ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent(Config['esx_routers']['client_shared_obj'], function(obj)
			ESX = obj
		end)
		Citizen.Wait(0)
	end
end)
function SetQueueMax(queue, max)
	local tmp = {
		queue = tostring(queue),
		max = tonumber(max)
	}
	SendNUIMessage({
		maxNotifications = tmp
	})
end
function SendNotification(options)
	options.animation = options.animation or {}
	options.sounds = options.sounds or {}
	options.docTitle = options.docTitle or {}
	local options = {
		text = options.text or 'Error',
		name = options.name or 'unknown',
		label = options.label or 'Unknown',
		count = options.count or '',
		layout = options.layout or Config['position'],
		theme = options.theme or 'azael',
		timeout = Config['timeout'] * 1000,
		progressBar = options.progressBar ~= false and true or false,
		queue = 'global',
		inventoryImage = Config['inventory_image'],
		inventoryLink = Config['inventory_link']
	}
	SendNUIMessage({
		options = options
	})
end
RegisterNetEvent('azael_ui-itemnotify:sendNotification')
AddEventHandler('azael_ui-itemnotify:sendNotification', function(options)
	SendNotification(options)
	SetQueueMax('global', Config['maximum'])
end)