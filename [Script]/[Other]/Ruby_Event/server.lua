RegisterNetEvent("Ruby_Event:getTime")
AddEventHandler("Ruby_Event:getTime", function()
    local realTime = os.date("%H.%M") -- Get real-world time in HH.MM format
    -- print(realTime)
    TriggerClientEvent("Ruby_Event:updateTime", source, realTime) -- Send it to the client
end)