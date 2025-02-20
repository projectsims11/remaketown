config = config or {}

config.notification = function(message, type)
    TriggerEvent("pNotify:SendNotification", {
        text = message,
        layout = "centerLeft",
        timeout = 3000,
        type = type,
    })
end

config.notificationServer = function(playerId, message, type)
    TriggerClientEvent("pNotify:SendNotification", playerId, {
        text = message,
        layout = "centerLeft",
        timeout = 3000,
        type = type,
    })
end