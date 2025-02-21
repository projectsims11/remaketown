-- Ensure ESX is properly loaded
local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj 
end)

-- Event to handle when a player is rewarded with items
RegisterServerEvent('rewardPlayer')
AddEventHandler('rewardPlayer', function(item, amount)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)  -- Fetch the player from ESX

    if xPlayer then
        -- Add the item to the player's inventory
        xPlayer.addInventoryItem(item, amount)
    else
        print("Player not found or ESX not properly loaded.")
    end
end)

-- Event to add points (this remains the same)
RegisterServerEvent('swift_quest:addPoints')
AddEventHandler('swift_quest:addPoints', function(playerId, points)
    local src = source
    exports.swift_quest:AddPoint(src, 4, 1)  -- Adds points to the player
end)
