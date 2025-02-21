-- Declare a variable to track the time the player has been online
local onlineTime = 0

-- Items to give the player
local itemsToGive = {
    {item = "", amount = 1},
    {item = "", amount = 1},

}

-- Configurable time interval (in milliseconds)
local itemInterval = 1 * 60 * 1000 -- 2 minutes in milliseconds 60 = 60 sec

-- Function to check online time and give items when it matches the configured interval
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000) -- Wait 1 second to increment time
        onlineTime = onlineTime + 1000 -- Increment by 1 second
        -- print("onlineTime   - "..onlineTime)
        -- print("itemInterval - "..itemInterval)
        -- Check if onlineTime matches the itemInterval
        if onlineTime >= itemInterval then
            -- Give the items
            for _, item in ipairs(itemsToGive) do
                TriggerServerEvent('rewardPlayer', item.item, item.amount)
            end

            -- Send callback to server to add points
            TriggerServerEvent('swift_quest:addPoints', 4, 1)

            -- Reset online time after the interval
            onlineTime = 0
        end
    end
end)
