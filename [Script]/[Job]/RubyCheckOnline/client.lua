
local onlineTime = 0
local Timecount = 0 
local OnlinePeroid = 60  -- 60 minutes 
local itemInterval = 1 * 60 * 1000 -- 1 minutes in milliseconds 60 = 60 sec

-- Items to give the player
local itemsToGive = {
    {item = "online_coin", amount = 1},
}

-- Function to check online time and give items when it matches the configured interval
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000) -- Wait 1 second to increment time
        onlineTime = onlineTime + 1000 -- Increment by 1 second
        -- print("onlineTime   - "..onlineTime)
        -- print("itemInterval - "..itemInterval)
        -- Check if onlineTime matches the itemInterval
        if onlineTime >= itemInterval then
            -- Send callback to server to add points
            TriggerServerEvent('swift_quest:addPoints', 4, 1)
            -- Reset online time after the interval
            onlineTime = 0
            Timecount = Timecount + 1
        end
        -- Time Count inc every 1 min.
        -- print(Timecount)
        if Timecount == OnlinePeroid then
            for _, item in ipairs(itemsToGive) do
                TriggerServerEvent('rewardPlayer', item.item, item.amount)
            end
            Timecount = 0
        end

    end
end)
