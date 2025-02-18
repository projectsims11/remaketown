RegisterServerEvent('chat:init')
RegisterServerEvent('chat:addTemplate')
RegisterServerEvent('chat:addMessage')
RegisterServerEvent('chat:addSuggestion')
RegisterServerEvent('chat:removeSuggestion')
--RegisterServerEvent('_chat:messageEntered')
RegisterServerEvent('chat:clear')
RegisterServerEvent('__cfx_internal:commandFallback')

AddEventHandler('_chat:messageEntered', function(author, color, message)
    if not message or not author then
        return
    end

    TriggerEvent('chatMessage', source, author, message)

    if not WasEventCanceled() then
        TriggerClientEvent('chatMessage', -1, author,  { 255, 255, 255 }, message)
    end

end)

AddEventHandler('__cfx_internal:commandFallback', function(command)
    local name = GetPlayerName(source)

    TriggerEvent('chatMessage', source, name, '/' .. command)

    if not WasEventCanceled() then
      --  TriggerClientEvent('chatMessage', -1, name, { 255, 255, 255 }, '/' .. command) 
    end

    CancelEvent()
end)
--[[
-- player join messages
AddEventHandler('chat:init', function()
   -- TriggerClientEvent('chatMessage', -1, '', { 255, 255, 255 }, '^2* ' .. GetPlayerName(source) .. ' เข้าเซิฟเวอร์.')
	
	TriggerClientEvent("pNotify:SendNotification", source, {
            text = '<center>' .. GetPlayerName(source) .. ' เข้าเซิฟเวอร์.<center>',
            queue = "global", 
            type = "success",
		    timeout = 2000,
		    layout = "centerLeft"
		})
end)

AddEventHandler('playerDropped', function(reason)
  --  TriggerClientEvent('chatMessage', -1, '', { 255, 255, 255 }, '^2* ' .. GetPlayerName(source) ..' ออกจากเซิฟเวอร์ (' .. reason .. ')')
	TriggerClientEvent("pNotify:SendNotification", source, {
            text = '<center>' .. GetPlayerName(source) ..' ออกจากเซิฟเวอร์ (' .. reason .. ')<center>',
            queue = "global", 
		    type = "error",
		    timeout = 2000,
		    layout = "centerLeft"
		})
end)
]]
RegisterServerEvent('chat:playerlogin')
AddEventHandler('chat:playerlogin', function()
	
end)