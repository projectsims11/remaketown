NotifyClient = function(text) -- แจ้งเตือน
    TriggerEvent('notify:message',{
        msg = text,
        wait = 5,
    })
end
