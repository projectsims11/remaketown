framework = {}

if config.framework == "esx" then
    ESX = exports.es_extended:getSharedObject()
elseif config.framework == "custom" then
    -- Your code here
end

if IsDuplicityVersion() then
    framework.addInventoryItem = function(playerId, item, count)
        if config.framework == "esx" then
            local xPlayer = ESX.GetPlayerFromId(playerId)
            if xPlayer then
                if item == "money" or item == "bank" or item == "black_money" then
                    xPlayer.addAccountMoney(item, count)
                else
                    xPlayer.addInventoryItem(item, count)
                end
            end
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
end