ESX = exports['es_extended']:getSharedObject()
FewZ = GetCurrentResourceName()

function CreateEvent(EventName, EventRoutine)
	return RegisterNetEvent(EventName), AddEventHandler(EventName, EventRoutine)
end

CreateEvent(FewZ..":Register", function()
    local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.scalar('SELECT register FROM users WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    }, function(result)
        if result == 0 then
            for k , v in pairs(Config.Setting.Item) do
                local GetItem = xPlayer.getInventoryItem(v.Name)
                xPlayer.addInventoryItem(v.Name, v.Count)
            end
            MySQL.update.await("UPDATE users SET register=1 WHERE identifier = @identifier", {
                ['@identifier'] = xPlayer.identifier
            })
        else
            xPlayer.triggerEvent('pNotify:SendNotification', {
    	        text = "คุณได้รับของไปแล้ว🥺",
    	        type = "error",
    	        queue = "center",
    	        timeout = 5000,
    	        layout = "bottomCenter"
    	    })
        end
    end)
end)