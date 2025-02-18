
--[[
	Author: CanonX2
	Special: Fivem Server
    Discord : https://discord.gg/Ns9jcjvuxc
	Readme : ระบบถูกออกแบบมาให้ใช้กับ extended 1.2 90% บางฟังชั้น 1.1 อาจจะตั้องแก้ไขเองเพิ่มเติม
--]]

NEXZ = {
    ["ESX"] = nil,
    ["ServerEvent"] = RegisterServerEvent,["Handler"] = AddEventHandler,["Event"] = TriggerEvent,["EventCl"] = TriggerClientEvent,
    ["RsName"] = GetCurrentResourceName(),["RsVer"] = "0.1",["CList"] = {},
    ["StartScrip"] = function()

        NEXZ["Event"](ConfigSv["Routers"]["getSharedObject"], function(obj) NEXZ["ESX"] = obj end)

        NEXZ["ServerEvent"]('nexz_crafting:GetSetupResources')
        NEXZ["Handler"]('nexz_crafting:GetSetupResources', function()
            TriggerClientEvent("nexz_crafting:SetConfigData", source, ConfigSv["Category"], ConfigSv["Extended"], ConfigSv["Routers"])
        end)

        NEXZ["ESX"].RegisterServerCallback('nexz_crafting:ChackMoney', function(source ,cb)
            local _source = source
            local xPlayer = NEXZ["ESX"].GetPlayerFromId(_source)
            local accounts = {
                { 
                    name = "black_money" ,
                    money = xPlayer.getAccount('black_money').money
                },
                { 
                    name = "cash" ,
                    money = xPlayer.getMoney()
                }
            }
            cb(accounts)
        end) 

        NEXZ["ESX"].RegisterServerCallback('nexz_crafting:ChackItem', function(source ,cb ,listitem)
            local _source = source
            local xPlayer = NEXZ["ESX"].GetPlayerFromId(_source)
            local Status = true
            for k, v in pairs(listitem) do
                local xItem = xPlayer.getInventoryItem(v.name)
                if xItem.count < v.amox then
                    Status = false
                end    
            end
            cb(Status)
        end) 

        NEXZ["ServerEvent"]('nexz_crafting:CraftItem')
        NEXZ["Handler"]('nexz_crafting:CraftItem', function(type, item, money, give, count ,statuscount ,failitem, custom_percent_failitem,weaponrequest ,persentremove_fail)
            local _source = source
            local xPlayer = NEXZ["ESX"].GetPlayerFromId(_source)
            local ChackStatus = rnd()     
            local statuscount = math.format(statuscount, 2)
            local checkcount = tonumber(count)
            if checkcount >= 1 then
                if ChackStatus >= statuscount then
                    if type == "item_standard" then
                        local StatusWeightLimit = false

                        if ConfigSv["NoItemLimit"] == true then
                            if ConfigSv["Extended"] == "1.2" then
                                if xPlayer.canCarryItem(give, count) then
                                    StatusWeightLimit = true
                                else
                                    NEXZ["EventCl"](ConfigSv["Routers"]["getNotify"], _source,{ type = 'error', text = 'น้ำหนักเต็มพื้นที่ไม่เพียงพอที่จะเก็บไอเทม '..xMax.label..' ' })    
                                end    
                            elseif ConfigSv["Extended"] == "1.1" then
                                local xMax = xPlayer.getInventoryItem(give)
                                if xMax.limit == nil then
                                    return
                                end
                                if xMax.limit ~= -1 and xMax.count >= xMax.limit then 
                                    NEXZ["EventCl"](ConfigSv["Routers"]["getNotify"], _source,{ type = 'error', text = ' มีสล็อตพื้นที่ไม่เพียงพอที่จะเก็บไอเทม '..xMax.label..' ' })      
                                else 
                                    StatusWeightLimit = true
                                end    
                            end
                        else
                            StatusWeightLimit = true
                        end

                        if StatusWeightLimit == true then
                            if ConfigSv["DiscordCraftingLog"] then     
                                SetDistcordItem(_source ,"Success" ,65280 ,give ,count ,ChackStatus, statuscount)
                            else
                                NEXZ["Event"]('nexz_crafting:logother',_source ,"Success" ,give ,1 ,ChackStatus, statuscount, type) 
                            end
                             NEXZ["EventCl"]('nexz_crafting:PlayWithinDistanceCl', -1, source, ConfigSv["Craft_Table_Sound_Distance"], ConfigSv["Craft_Table_Sound"]["Success"], 0.5)
                             NEXZ["EventCl"](ConfigSv["Routers"]["getNotify"], _source, { type = 'success', text = 'ยินดีด้วยคราฟไอเทมสำเร็จ' })     
                            if ConfigSv["Extended"] == "1.2" then
                                for k, v in pairs(money) do
                                    xPlayer.removeAccountMoney(v.name, v.amox * count)
                                end
                            elseif ConfigSv["Extended"] == "1.1" then
                                for k, v in pairs(money) do
                                    if v.name == "black_money" then
                                        xPlayer.removeAccountMoney(v.name, v.amox * count)
                                    end
                                    if v.name == "cash" then
                                        xPlayer.removeMoney(v.amox * count)
                                    end
                                end
                            end
                            for k, v in pairs(item) do
                                xPlayer.removeInventoryItem(v.name, v.amox * count)
                            end
                            xPlayer.addInventoryItem(give, count)
                        end
                    elseif type == "item_weapon" then 
                        if ConfigSv["DiscordCraftingLog"] then   
                            SetDistcordWeapon(_source ,"Success" ,9749506 ,string.upper(give) ,ChackStatus, statuscount)
                        else
                            NEXZ["Event"]('nexz_crafting:logother',_source ,"Success" ,string.upper(give) ,1 ,ChackStatus, statuscount, type) 
                        end
                         NEXZ["EventCl"]('nexz_crafting:PlayWithinDistanceCl', -1, source, ConfigSv["Craft_Table_Sound_Distance"], ConfigSv["Craft_Table_Sound"]["Success"], 0.5)
                         NEXZ["EventCl"](ConfigSv["Routers"]["getNotify"], _source, { type = 'success', text = 'ยินดีด้วยคราฟไอเทมสำเร็จ' })     
                        if ConfigSv["Extended"] == "1.2" then
                            for k, v in pairs(money) do
                                xPlayer.removeAccountMoney(v.name, v.amox * count)
                            end
                        elseif ConfigSv["Extended"] == "1.1" then
                            for k, v in pairs(money) do
                                if v.name == "black_money" then
                                    xPlayer.removeAccountMoney(v.name, v.amox * count)
                                end
                                if v.name == "cash" then
                                    xPlayer.removeMoney(v.amox * count)
                                end
                            end
                        end
                        for k, v in pairs(item) do
                            xPlayer.removeInventoryItem(v.name, v.amox * count)
                        end
                        xPlayer.addWeapon(string.upper(give), 1)
                    end    

                    if weaponrequest ~= nil then
                        for k, v in pairs(weaponrequest) do
                            if v.status == true then
                                if v.type == "item_standard" then
                                    xPlayer.removeInventoryItem(v.name, 1)
                                elseif v.type == "item_weapon" then
                                    xPlayer.removeWeapon(string.upper(v.name))
                                     NEXZ["EventCl"]("nexz_crafting:RemoveWeaponCl", _source, string.upper(v.name))
                                end 
                            end 
                        end 
                    end 
                else
                    if type == "item_standard" then
                        if ConfigSv["DiscordCraftingLog"] then                 
                            SetDistcordItem(_source ,"Failed" ,12845619 ,give ,count ,ChackStatus, statuscount)
                        else
                            NEXZ["Event"]('nexz_crafting:logother',_source ,"Failed" ,give ,count ,ChackStatus, statuscount, type)
                        end
                    elseif type == "item_weapon" then 
                        if ConfigSv["DiscordCraftingLog"] then     
                            SetDistcordWeapon(_source ,"Failed" ,12845587 ,string.upper(give) ,ChackStatus, statuscount)
                        else
                            NEXZ["Event"]('nexz_crafting:logother',_source ,"Failed" ,string.upper(give) ,1 ,ChackStatus, statuscount, type)
                        end
                    end

                     NEXZ["EventCl"]('nexz_crafting:PlayWithinDistanceCl', -1, source, ConfigSv["Craft_Table_Sound_Distance"], ConfigSv["Craft_Table_Sound"]["Failed"], 0.8)
                     NEXZ["EventCl"](ConfigSv["Routers"]["getNotify"], _source, { type = 'error', text = 'เสียใจด้วยคราฟไอเทมไม่สำเร็จ' })

                    if ConfigSv["Extended"] == "1.2" then
                        for k, v in pairs(money) do
                            xPlayer.removeAccountMoney(v.name, v.amox * count)
                        end
                    elseif ConfigSv["Extended"] == "1.1" then
                        for k, v in pairs(money) do
                            if v.name == "black_money" then
                                xPlayer.removeAccountMoney(v.name, v.amox * count)
                            end
                            if v.name == "cash" then
                                xPlayer.removeMoney(v.amox * count)
                            end
                        end
                    end

                    for k, v in pairs(item) do
                        xPlayer.removeInventoryItem(v.name, v.amox * count)
                    end

                    if persentremove_fail ~= nil then
                        for k, v in pairs(persentremove_fail) do
                            local rsl = math.random(1,100)
                            if v.protectfollwblackitem ~= nil then
                                local Item = xPlayer.getInventoryItem(v.protectfollwblackitem)
                                if Item.count > 0 then
                                    NEXZ["EventCl"](ConfigSv["Routers"]["getNotify"], _source, { type = 'error', text = 'การป้องกันสำเร็จ' })
                                    xPlayer.removeInventoryItem(v.protectfollwblackitem, 1 * count)
                                    return
                                end    
                            end   
                            if rsl > v.persent then
                                if v.type == "item_standard" then
                                    xPlayer.removeInventoryItem(v.name, 1)
                                    xPlayer.addInventoryItem(v.itrmlosblack, 1)
                                elseif v.type == "item_weapon" then
                                    xPlayer.addWeapon(string.upper(v.itrmlosblack)) 
                                    xPlayer.removeWeapon(string.upper(v.name)) 
                                    NEXZ["EventCl"]("nexz_crafting:RemoveWeaponCl", _source, string.upper(v.name))
                                end  
                            end
                        end
                    end 

                    if failitem ~= nil then
                        local rnd = rnd()  
                        local indel = 50
                        if custom_percent_failitem ~= nil then
                            indel = custom_percent_failitem
                        end
                        if rnd >= indel then
                            for k, v in pairs(failitem) do
                                xPlayer.addInventoryItem(v.name, v.amox)
                            end
                        end
                    end
                end
            else
                NEXZ["EventCl"](ConfigSv["Routers"]["getNotify"], _source,{ type = 'error', text = 'อย่าทำบัคเลยหนุ่ม' })    
            end    
        end) 

        function math.format(g, h)
            if h then
                local j = 10^h
                return math.floor((g * j) + 0.5) / (j)
            else
                return math.floor(g + 0.5)
            end
        end

        function rnd()
            return math.format(math.random() + math.random(1, 99), 2)
        end

        function SetDistcordItem(id ,status ,discord_color ,item ,count ,percentrs ,percent)
            local _source = id
            local name = GetPlayerName(_source)
            local steam = GetPlayerIdentifier(_source)
            local avatar = "https://i.pinimg.com/originals/51/f6/fb/51f6fb256629fc755b8870c801092942.png"
            local webhook_name 	= "Nexz Console Log  [".. os.date("%d/%m/%Y - %X") .."]"
            local embeds = {
                {
                    ["title"]= 'Log Event Crafting Item [ '..status..' ]',
                    ["type"]= "rich",
                    ["color"] = discord_color,
                    ["description"] = 'Name : '.. name ..' \n Steam : '.. steam ..' \n Item : '.. NEXZ["ESX"].GetItemLabel(item) ..' Count : '..count..' \n Percent Craftitem : '..percentrs..' / '..percent..' %',
                    ["footer"] = {
                        ["text"] = '🔴 ==> Nexz Coding',
                    },
                    ["author"] = {
                        ["name"] = ' Nexz Crafting ',
                        ["icon_url"] = "https://media.discordapp.net/attachments/641717879858921503/767445777303470130/shield.png",
                    },	
                    ["thumbnail"] = {
                        ["url"] = "https://cdn.pixabay.com/photo/2012/04/11/11/55/letter-n-27733_960_720.png",
                    },		
                }
            }
            PerformHttpRequest(ConfigSv["Craft_Discord_Log"]["Item"], function(err, text, headers) end, 'POST', json.encode({username = webhook_name, embeds = embeds, avatar_url = avatar}), { ['Content-Type'] = 'application/json' })
        end

        function SetDistcordWeapon(id ,status ,discord_color ,item ,percentrs, percent)
            local _source = id
            local name = GetPlayerName(_source)
            local steam = GetPlayerIdentifier(_source)
            local avatar = "https://i.pinimg.com/originals/51/f6/fb/51f6fb256629fc755b8870c801092942.png"
            local webhook_name 	= "Nexz Console Log  [".. os.date("%d/%m/%Y - %X") .."]"
            local embeds = {
                {
                    ["title"]= 'Log Event Crafting Item [ '..status..' ]',
                    ["type"]= "rich",
                    ["color"] = discord_color,
                    ["description"] = 'Name : '.. name ..' \n Steam : '.. steam ..' \n Weapon : '.. NEXZ["ESX"].GetWeaponLabel(item) ..' \n Percent Craftitem : '..percentrs..' / '..percent..' %',
                    ["footer"] = {
                        ["text"] = '🔴 ==> Nexz Coding',
                    },
                    ["author"] = {
                        ["name"] = ' Nexz Crafting ',
                        ["icon_url"] = "https://media.discordapp.net/attachments/641717879858921503/767445777303470130/shield.png",
                    },	
                    ["thumbnail"] = {
                        ["url"] = "https://cdn.pixabay.com/photo/2012/04/11/11/55/letter-n-27733_960_720.png",
                    },		
                }
            }
            PerformHttpRequest(ConfigSv["Craft_Discord_Log"]["Weapon"], function(err, text, headers) end, 'POST', json.encode({username = webhook_name, embeds = embeds, avatar_url = avatar}), { ['Content-Type'] = 'application/json' })
        end

        NEXZ["ServerEvent"]('nexz_crafting:logother')
        NEXZ["Handler"]('nexz_crafting:logother', function(source ,status ,item ,count ,percent , percentrs,type)
            local xPlayer = NEXZ["ESX"].GetPlayerFromId(source)
            if ConfigSv["Other_Discord_LogEvent"] ~= nil then
                ConfigSv["Other_Discord_LogEvent"](xPlayer, source ,status ,item ,count ,percent ,percentrs ,type)
            end
        end)   

        print("\27[0m[\27[31mSLP\27[0m]\27[33m\27[0m[\27[42m ".. GetCurrentResourceName() .." \27[0m]\27[0m - The resource check and verify (\27[32mSUCCES\27[0m)")	
    end
}

NEXZ["StartScrip"]()