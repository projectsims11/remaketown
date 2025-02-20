framework = {}
framework.events = {
    ["setPlayerData"] = "esx_identity:setPlayerData"
}

if config.framework == "esx" then
    ESX = exports.es_extended:getSharedObject()
elseif config.framework == "custom" then
    -- Your code here
end

--? Server
if IsDuplicityVersion() then
    framework.GetPlayerName = function(playerId)
        if config.framework == "standalone" then
            return GetPlayerName(playerId)
        elseif config.framework == "esx" then
            local xPlayer = ESX.GetPlayerFromId(playerId)
            return xPlayer and xPlayer.getName() or "unknown"
        elseif config.framework == "custom" then
            local playerName = "Dummy"
            return playerName
        end
    
        return "unknown"
    end
else --? Client
    framework.getInventory = function()
        local inventory = {} -- ต้องมี name, count, label

        if config.framework == "esx" then
            local playerInventory = ESX.GetPlayerData().inventory
            for _, item in pairs(playerInventory) do
                table.insert(inventory, {
                    name = item.name,
                    count = item.count,
                    label = item.label or item.name
                })
            end
        elseif config.framework == "custom" then
            -- Your code here
        end

        return inventory
    end
end