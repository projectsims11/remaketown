framework = {}

if config.framework == "esx" then
    ESX = exports.es_extended:getSharedObject()
elseif config.framework == "custom" then
    -- Your code here
end

--? Server
if IsDuplicityVersion() then
    framework.GetPlayerFromId = function(playerId) -- สำหรับ webhook.onJailed, functions.announce
        if config.framework == "esx" then
            local xPlayer = ESX.GetPlayerFromId(playerId)
            return xPlayer
        elseif config.framework == "custom" then
            -- Your code here
            return false
        end
    end

    framework.getGroup = function(playerId)
        if config.framework == "esx" then
            local xPlayer = ESX.GetPlayerFromId(playerId)
            return xPlayer and xPlayer.getGroup() or "user"
        elseif config.framework == "custom" then
            -- Your code here
            return false
        end
    end

    framework.getJob = function(playerId)
        if config.framework == "esx" then
            local xPlayer = ESX.GetPlayerFromId(playerId)
            return xPlayer and xPlayer.job.name
        elseif config.framework == "custom" then
            -- Your code here
            return false
        end
    end

    framework.getInventoryItem = function(playerId, itemName)
        if config.framework == "esx" then
            local xPlayer = ESX.GetPlayerFromId(playerId)
            local xItem = xPlayer.getInventoryItem(itemName)
            return xItem.count
        elseif config.framework == "custom" then
            -- Your code here
            return false
        end
    end

    framework.removeInventoryItem = function(playerId, itemName, itemCount)
        if config.framework == "esx" then
            local xPlayer = ESX.GetPlayerFromId(playerId)
            xPlayer.removeInventoryItem(itemName, itemCount)
        elseif config.framework == "custom" then
            -- Your code here
            return false
        end
    end

    framework.IsPlayerAdmin = function(playerId)
        if config.framework == "standalone" then
            return (IsPlayerAceAllowed(playerId, "command") or GetConvar("sv_lan", "") == "true") or false
        elseif config.framework == "esx" then
            local xPlayer = ESX.GetPlayerFromId(playerId)
            return xPlayer and xPlayer.getGroup() == config.commands.group or false
        elseif config.framework == "custom" then
            -- Your code here
            return false
        end
    end
    
else --? Client
    framework.getJob = function()
        if config.framework == "esx" then
            local job = ESX.GetPlayerData().job
            return job
        elseif config.framework == "custom" then
            -- Your code here
        end
    end

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

    framework.loadDefaultSkin = function()
        if config.framework == "esx" then
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                if skin ~= nil then
                    TriggerEvent('skinchanger:loadSkin', skin)
                end
            end)
        elseif config.framework == "custom" then
            -- Your code here
        end
    end
end