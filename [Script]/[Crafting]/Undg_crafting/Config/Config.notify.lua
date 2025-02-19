NotifyClient = function(text) -- แจ้งเตือน
    TriggerEvent('notify:message',{
        msg = text,
        wait = 5,
    })
end

NotifyServer = function(text, source) -- แจ้งเตือน
    TriggerClientEvent('notify:message', source,{
        msg = text,
        wait = 5,
    })
end
