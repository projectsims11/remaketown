ESX = SERVER.Framework

local ShopItems = {}
local hasSqlRun = false

function CanOpen( src , zone)
    local xPlayer = ESX.GetPlayerFromId(src)

    local Zone = GlobaConfig["Zones"][zone]

    if Zone == nil then
        return false 
    end

    local Req = Zone.Require
    if Req == nil then
        return true 
    end

    local Items = Req.Items
    local Jobs = Req.Jobs


    local canOpen = false

    local pl_inventory = xPlayer.getInventory(true)
    local pl_job = xPlayer.getJob()

    if Jobs and #Jobs > 0 then
        for _ , job in pairs(Jobs) do
            if pl_job.name == job then
                canOpen = true
                break
            end
        end

        if not canOpen then
            -- ไม่สามารถใช้ได้ เพราะ ไม่มีอาชีพที่ต้องการ
            -- print("Can't use because job")
            return false, "คุณไม่ใช่อาชีพที่สามารถเปิดร้านค้านี้ได้"
        end

    end
    if Items and #Items > 0 then
        for _ , item in pairs(Items) do
            if pl_inventory[item] then
                canOpen = true
                break
            end
        end

        if not canOpen then
            -- ไม่สามารถใช้ได้ เพราะ ไม่มี item ที่ต้องการ
            -- print("Can't use because item")
            return false, "คุณไม่มี ITEM ที่ต้องการในการเปิดร้านค้า"
        end
    end
    

    return canOpen , text 

end

ESX.RegisterServerCallback('FewZ_Shop:canOpen', function(src ,callback ,zone)
    callback( CanOpen(src,zone, text) )
end)

createEvent('FewZ_Shop:balance', function()	
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    balance = xPlayer.getAccount('bank').money
    cash = xPlayer.getMoney()
    TriggerClientEvent('FewZ_Shop:info', _source, balance, cash)
end)


RegisterServerEvent('FewZ_Shop:buyItem')
AddEventHandler('FewZ_Shop:buyItem', function(itemName, amount, class, zone)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local sourceItem = xPlayer.getInventoryItem(itemName)

    if amount < 0 then
        return
    end

    local Zone = GlobaConfig["Zones"][zone]

    if Zone == nil then
        return
    end

    local Items = Zone.Items

    if Items == nil then
        return
    end

    if not CanOpen(_source,zone) then
        print("This user can't buy from this zone")
        return
    end


    local Item

    for k , item in pairs(Items) do
        if item.item == itemName then
            Item = item
            break
        end
    end

    if Item == nil then
        return
    end

    if amount > Item.limit then
        return
    end

    local price = Item.price * amount
        if Secure.Extended == "limit" then

            if itemName:sub(1,7) == 'weapon_' then
                if xPlayer.getWeapon(itemName) then
                    -- ผู้เล่นมีปืนนี่อยู่แล้ว
                    TriggerClientEvent("pNotify:SendNotification", source, {
                        text = PNOTIFY_SETTING.HAVEGUN,
                        type = PNOTIFY_SETTING.HAVEGUNYPE,
                        timeout = PNOTIFY_SETTING.TIME * 1000,
                        layout = PNOTIFY_SETTING.LAYOUT
                    })
                    print("Player already own this weapon")
                else
                    xPlayer.addWeapon(itemName,0)
                    DiscordSend(itemName, "กำหนดไม่ได้")

                    local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. ESX.GetWeaponLabel(itemName) .. ' จำนวน 1'
                    TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'MarketBuyItems', sendToDiscord, xPlayer.source, '^3')
                end
            elseif sourceItem.limit ~= -1 and (sourceItem.count + amount) > sourceItem.limit then
                TriggerClientEvent("pNotify:SendNotification", source, {
                        text = PNOTIFY_SETTING.NOFREE,
                        type = PNOTIFY_SETTING.NOFREETYPE,
                        timeout = PNOTIFY_SETTING.TIME * 1000,
                        layout = PNOTIFY_SETTING.LAYOUT
                    })
            else
                if sourceItem.limit ~= -1 and (sourceItem.count + amount) > sourceItem.limit then
                else
                    if class == "Cash" then 
                        if xPlayer.getMoney() >= price  then
                            xPlayer.removeMoney(price)
                            xPlayer.addInventoryItem(itemName, amount)
                            DiscordSend(itemName, amount)
                            TriggerClientEvent("pNotify:SendNotification", source, {
                                text = PNOTIFY_SETTING.BUY,
                                type = PNOTIFY_SETTING.BUYTYPE,
                                timeout = PNOTIFY_SETTING.TIME * 1000,
                                layout = PNOTIFY_SETTING.LAYOUT
                            })

                            local sendToDiscord = '' .. xPlayer.name .. ' ซื้อ ' .. ESX.GetItemLabel(itemName) .. ' จำนวน ' .. amount .. ' เสียค่าใช้จ่าย Cash จำนวน $' .. ESX.Math.GroupDigits(price) .. ''
                            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'MarketBuyItems', sendToDiscord, xPlayer.source, '^2')
                        else
                            TriggerClientEvent("pNotify:SendNotification", source, {
                                text = PNOTIFY_SETTING.NOMONEY,
                                type = PNOTIFY_SETTING.NOMONEYTYPE,
                                timeout = PNOTIFY_SETTING.TIME * 1000,
                                layout = PNOTIFY_SETTING.LAYOUT
                            })
                        end
                    elseif class == "Bank" then
                        if xPlayer.getAccount('bank').money >= price then
                            local Frist = (price * 7) / 100
                            local second = price +Frist
                            xPlayer.removeAccountMoney('bank', second)
                            xPlayer.addInventoryItem(itemName, amount)
                            DiscordSend(itemName, amount)
                            TriggerClientEvent("pNotify:SendNotification", source, {
                                text = PNOTIFY_SETTING.BUY,
                                type = PNOTIFY_SETTING.BUYTYPE,
                                timeout = PNOTIFY_SETTING.TIME * 1000,
                                layout = PNOTIFY_SETTING.LAYOUT
                            })

                            local sendToDiscord = '' .. xPlayer.name .. ' ซื้อ ' .. ESX.GetItemLabel(itemName) .. ' จำนวน ' .. amount .. ' เสียค่าใช้จ่าย Bank Money จำนวน $' .. ESX.Math.GroupDigits(second) .. ''
                            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'MarketBuyItems', sendToDiscord, xPlayer.source, '^5')
                        else 
                            TriggerClientEvent("pNotify:SendNotification", source, {
                                text = PNOTIFY_SETTING.NOMONEY,
                                type = PNOTIFY_SETTING.NOMONEYTYPE,
                                timeout = PNOTIFY_SETTING.TIME * 1000,
                                layout = PNOTIFY_SETTING.LAYOUT
                            })
                        end
                    end
                    
                    
                end
            end
        elseif Secure.Extended == "weight" then

            if itemName:sub(1,7) == 'weapon_' then
                if xPlayer.getWeapon(itemName) then
                    -- ผู้เล่นมีปืนนี่อยู่แล้ว
                    TriggerClientEvent("pNotify:SendNotification", source, {
                        text = PNOTIFY_SETTING.HAVEGUN,
                        type = PNOTIFY_SETTING.HAVEGUNYPE,
                        timeout = PNOTIFY_SETTING.TIME * 1000,
                        layout = PNOTIFY_SETTING.LAYOUT
                    })
                    -- print("Player already own this weapon")
                else
                    xPlayer.addWeapon(itemName,0)

                    local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. ESX.GetWeaponLabel(itemName) .. ' จำนวน 1'
                    TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'MarketBuyItems', sendToDiscord, xPlayer.source, '^3')
                end
            else
                --if  xPlayer.canCarryItem(itemName, amount) then
                if sourceItem.weight ~= -1 and (sourceItem.count + amount) > sourceItem.weight then
                    exports.nc_notify:PushNotification(source,{
                        title = "ไอเท็มเต็ม !!",
                        description = "ไอเท็ม "..sourceItem.label.." เกินจำนวน",
                        priority = 'high',
                        type = 'warning',
                        icon = 'error',
                        duration = 6000
                    })
                else
                    if class == "Cash" then 
                        if xPlayer.getMoney() >= price  then
                            xPlayer.removeMoney(price)
                            xPlayer.addInventoryItem(itemName, amount)
                            DiscordSend(itemName, amount)
                            TriggerClientEvent("pNotify:SendNotification", source, {
                                text = PNOTIFY_SETTING.BUY,
                                type = PNOTIFY_SETTING.BUYTYPE,
                                timeout = PNOTIFY_SETTING.TIME * 1000,
                                layout = PNOTIFY_SETTING.LAYOUT
                            })

                            local sendToDiscord = '' .. xPlayer.name .. ' ซื้อ ' .. ESX.GetItemLabel(itemName) .. ' จำนวน ' .. amount .. ' เสียค่าใช้จ่าย Cash จำนวน $' .. ESX.Math.GroupDigits(price) .. ''
                            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'MarketBuyItems', sendToDiscord, xPlayer.source, '^2')
                        else 
                            TriggerClientEvent("pNotify:SendNotification", source, {
                                text = PNOTIFY_SETTING.NOMONEY,
                                type = PNOTIFY_SETTING.NOMONEYTYPE,
                                timeout = PNOTIFY_SETTING.TIME * 1000,
                                layout = PNOTIFY_SETTING.LAYOUT
                            })
                        end
                    elseif class == "Bank" then
                        if xPlayer.getAccount('bank').money >= price then
                            local Frist = (price * 7) / 100
                            local second = price +Frist
                            xPlayer.removeAccountMoney('bank', second)
                            xPlayer.addInventoryItem(itemName, amount)
                            DiscordSend(itemName, amount)
                            TriggerClientEvent("pNotify:SendNotification", source, {
                                text = PNOTIFY_SETTING.BUY,
                                type = PNOTIFY_SETTING.BUYTYPE,
                                timeout = PNOTIFY_SETTING.TIME * 1000,
                                layout = PNOTIFY_SETTING.LAYOUT
                            })

                            local sendToDiscord = '' .. xPlayer.name .. ' ซื้อ ' .. ESX.GetItemLabel(itemName) .. ' จำนวน ' .. amount .. ' เสียค่าใช้จ่าย Bank Money จำนวน $' .. ESX.Math.GroupDigits(second) .. ''
                            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'MarketBuyItems', sendToDiscord, xPlayer.source, '^5')
                        else 
                            TriggerClientEvent("pNotify:SendNotification", source, {
                                text = PNOTIFY_SETTING.NOMONEY,
                                type = PNOTIFY_SETTING.NOMONEYTYPE,
                                timeout = PNOTIFY_SETTING.TIME * 1000,
                                layout = PNOTIFY_SETTING.LAYOUT
                            })
                        end
                        
                    end                           
                end

            end

        end		
end)

DiscordSend = function(iname, icount)
    local playerId = source
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer == nil then
        return false
    end
    local discordId = GetDiscordID(playerId)
    local playerIp = GetPlayerEndpoint(playerId)
    if not discordId then
        discordId = "N/A"
        discordName = "N/A"
    else
        discordId = string.gsub(discordId, "discord:", "")
        discordName = "<@" .. discordId .. ">"
    end
    if not playerIp then
        playerIp = "N/A"
    end
    local desc = ("**Name**: `%s`\n**Identifier**: `%s`\n**Discord**: %s\n**Discord ID**: `%s`\n**IP Address**: `%s`"):format(GetPlayerName(playerId), xPlayer.identifier, discordName, discordId, playerIp)

    PerformHttpRequest(Secure.DiscordAPI.Buylog, function(err, text, headers) end, 'POST', json.encode({
        username = 'SHOP SYSTEM',
        avatar_url = 'https://media.discordapp.net/attachments/954847106894540891/954847302730809444/MZ3.gif',
        content = '',
        embeds = {
            {
                color = 16777215,
                title = ("ได้ซื้อ `%s` จำนวน `%s`"):format(iname, icount),
                description = desc,
                footer = {
                    text = " MZ TEAM "..os.date("%d/%m/%Y - %H:%M:%S", os.time()).."",
                }

            }
        }
    }), { ['Content-Type'] = 'application/json' })
end
function GetDiscordID(src)
    local discordId = nil
    for k, v in ipairs(GetPlayerIdentifiers(src)) do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            discordId = v
            break
        end
    end
    if discordId == nil or discordId:sub(1, 8) ~= "discord:" then
        return false
    end
    return discordId
end
