
--[[

    @ Include Side

]]--

-- @ Function Reference ]
function createEvent(eventName, eventRoutine)
    return RegisterNetEvent(eventName), AddEventHandler(eventName, eventRoutine)
end 

-- @ Lua Reference ]
write = print
js = json
triggerNui = SendNUIMessage
Nuicallback = RegisterNUICallback


-- @ Debug Refernce ]  
--[[
    debug('var1', var1)
    debug('var2', var2)
--]]
debugMode = true -- For Developer

debug = function(self, key, ...)
    if not debugMode then return end
    write(('^0[ ^3Debug^0. ^4%s^0 ]'):format(key),...)
end