ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem(Config.Itemuse, function(source) -- ชุป
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('Autofish', source)
    Citizen.Wait(10000)
end)

RegisterServerEvent('AFKfishadd')
AddEventHandler('AFKfishadd', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem = xPlayer.getInventoryItem(Config.Additem)
    local xItem3 = xPlayer.getInventoryItem(Config.Removeitem)
    if Config.Limit then
        if xItem3.count <= 0 then return end
        if xItem.limit ~= -1 and (xItem.count + 1) >= xItem.limit then
            xPlayer.setInventoryItem(xItem.name, xItem.limit)
        else
            xPlayer.addInventoryItem(Config.Additem, 1)
            xPlayer.removeInventoryItem(Config.Removeitem, 1)
            if Config.Bonus ~= nil then
                for k, v in pairs(Config.Bonus) do
                    if math.random(1, 100) <= v.Percent then
                        local xItemCount =
                            math.random(v.ItemCount[1], v.ItemCount[2])
                        local xItem2 = xPlayer.getInventoryItem(v.ItemName)
                        if xItem2.limit ~= -1 and (xItem2.count + xItemCount) >
                            xItem2.limit then
                            xPlayer.setInventoryItem(v.ItemName, xItem2.limit)
                        else
                            xPlayer.addInventoryItem(v.ItemName, xItemCount)
                        end

                    end
                end
            end
        end

    else
        if xPlayer.canCarryItem(xItem.name, 1) then
            xPlayer.addInventoryItem(Config.Additem, 1)
            xPlayer.removeInventoryItem(Config.Removeitem, 1)
            if Config.Bonus ~= nil then
                for k, v in pairs(Config.Bonus) do
                    if math.random(1, 100) <= v.Percent then
                        local xItemCount =
                            math.random(v.ItemCount[1], v.ItemCount[2])
                        local xItem2 = xPlayer.getInventoryItem(v.ItemName)
                        if xPlayer.canCarryItem(xItem2.name, xItemCount) then
                            xPlayer.addInventoryItem(v.ItemName, xItemCount)
                        end
                    end
                end
            end
        end

    end

end)

