local KKK = false

ESX = nil
TriggerEvent(
    Config["esx_routers"]["server_shared_obj"],
    function(obj)
        ESX = obj
    end
)
AddEventHandler(
    Config["esx_routers"]["server_player_load"],
    function(source)
        Citizen.Wait(5000)
        local playerId = source
        local xPlayer = ESX.GetPlayerFromId(playerId)
        if xPlayer then
            local message = "**" .. xPlayer.name .. "** เข้าสู่เซิร์ฟเวอร์"
            TriggerEvent("azael_discordlogs:sendToDiscord", "Login", message, playerId, "^2")
        end
    end
)
AddEventHandler(
    "playerDropped",
    function(reason)
        local playerId = source
        local xPlayer = ESX.GetPlayerFromId(playerId)
        local color = "^8"
        if string.match(reason, "Kicked") or string.match(reason, "Banned") then
            color = "^9"
        end
        if xPlayer then
            local message = "**" .. xPlayer.name .. "** ออกจากเซิร์ฟเวอร์ (" .. reason .. ")"
            TriggerEvent("azael_discordlogs:sendToDiscord", "Logout", message, playerId, color)
        end
    end
)
AddEventHandler(
    "chatMessage",
    function(source, name, message)
        local playerId = source
        if playerId and message then
            if string.match(message, "@everyone") then
                message = message:gsub("@everyone", "`@everyone`")
            end
            if string.match(message, "@here") then
                message = message:gsub("@here", "`@here`")
            end
            TriggerEvent("azael_discordlogs:sendChatToDiscord", "Chat", message, playerId, "^7")
        end
    end
)
RegisterNetEvent("azael_discordlogs:sendDeathCause")
AddEventHandler(
    "azael_discordlogs:sendDeathCause",
    function(type, source, target, event)
        local playerId = source
        local sourceXPlayer = ESX.GetPlayerFromId(playerId)
        if target then
            local targetXPlayer = ESX.GetPlayerFromId(target)
            if type == "Melee" and event then
                local message = "" .. sourceXPlayer.name .. " ถูก " .. targetXPlayer.name .. " ฆ่า โดย " .. event .. ""
                TriggerEvent("azael_discordlogs:sendToDiscord", "Dead", message, sourceXPlayer.source, "^1")
                Citizen.Wait(100)
                local message = "" .. targetXPlayer.name .. " ฆ่า " .. sourceXPlayer.name .. " โดย " .. event .. ""
                TriggerEvent("azael_discordlogs:sendToDiscord", "Dead", message, targetXPlayer.source, "^3")
            elseif type == "Bullet" and event then
                local message = "" .. sourceXPlayer.name .. " ถูก " .. targetXPlayer.name .. " ฆ่า โดย " .. event .. ""
                TriggerEvent("azael_discordlogs:sendToDiscord", "Dead", message, sourceXPlayer.source, "^1")
                Citizen.Wait(100)
                local message = "" .. targetXPlayer.name .. " ฆ่า " .. sourceXPlayer.name .. " โดย " .. event .. ""
                TriggerEvent("azael_discordlogs:sendToDiscord", "Dead", message, targetXPlayer.source, "^3")
            elseif type == "Car" and event then
                local message = "" .. sourceXPlayer.name .. " ถูก " .. targetXPlayer.name .. " ฆ่า โดย " .. event .. ""
                TriggerEvent("azael_discordlogs:sendToDiscord", "Dead", message, sourceXPlayer.source, "^1")
                Citizen.Wait(100)
                local message = "" .. targetXPlayer.name .. " ฆ่า " .. sourceXPlayer.name .. " โดย " .. event .. ""
                TriggerEvent("azael_discordlogs:sendToDiscord", "Dead", message, targetXPlayer.source, "^3")
            elseif type == "Explosion" and event then
                local message =
                    "" .. sourceXPlayer.name .. " ถูก " .. targetXPlayer.name .. " ฆ่า โดย " .. event .. " (แรงระเบิด)"
                TriggerEvent("azael_discordlogs:sendToDiscord", "Dead", message, sourceXPlayer.source, "^1")
                Citizen.Wait(100)
                local message =
                    "" .. targetXPlayer.name .. " ฆ่า " .. sourceXPlayer.name .. " โดย " .. event .. " (แรงระเบิด)"
                TriggerEvent("azael_discordlogs:sendToDiscord", "Dead", message, targetXPlayer.source, "^3")
            elseif type == "Gas" and event then
                local message =
                    "" .. sourceXPlayer.name .. " ถูก " .. targetXPlayer.name .. " ฆ่า โดย " .. event .. " (แก๊สพิษ)"
                TriggerEvent("azael_discordlogs:sendToDiscord", "Dead", message, sourceXPlayer.source, "^1")
                Citizen.Wait(100)
                local message =
                    "" .. targetXPlayer.name .. " ฆ่า " .. sourceXPlayer.name .. " โดย " .. event .. " (แก๊สพิษ)"
                TriggerEvent("azael_discordlogs:sendToDiscord", "Dead", message, targetXPlayer.source, "^3")
            elseif type == "Burn" and event then
                local message =
                    "" .. sourceXPlayer.name .. " ถูก " .. targetXPlayer.name .. " ฆ่า โดย " .. event .. " (ไฟคลอก)"
                TriggerEvent("azael_discordlogs:sendToDiscord", "Dead", message, sourceXPlayer.source, "^1")
                Citizen.Wait(100)
                local message =
                    "" .. targetXPlayer.name .. " ฆ่า " .. sourceXPlayer.name .. " โดย " .. event .. " (ไฟคลอก)"
                TriggerEvent("azael_discordlogs:sendToDiscord", "Dead", message, targetXPlayer.source, "^3")
            end
        else
            if type == "Melee" and event then
                local message = "" .. sourceXPlayer.name .. " ถูก ประชาชนพื้นเมือง ฆ่า โดย " .. event .. ""
                TriggerEvent("azael_discordlogs:sendToDiscord", "Dead", message, sourceXPlayer.source, "^6")
            elseif type == "Bullet" and event then
                local message = "" .. sourceXPlayer.name .. " ถูก ประชาชนพื้นเมือง ฆ่า โดย " .. event .. ""
                TriggerEvent("azael_discordlogs:sendToDiscord", "Dead", message, sourceXPlayer.source, "^6")
            elseif type == "Car" and event then
                local message =
                    "" ..
                    sourceXPlayer.name .. " เสียชีวิตโดย " .. event .. " (หล่นจากยานพาหนะ หรือ ประชาชนพื้นเมืองฆ่า)"
                TriggerEvent("azael_discordlogs:sendToDiscord", "Dead", message, sourceXPlayer.source, "^6")
            elseif type == "Explosion" and event then
                local message = "" .. sourceXPlayer.name .. " เสียชีวิตโดย " .. event .. " (แรงระเบิด)"
                TriggerEvent("azael_discordlogs:sendToDiscord", "Dead", message, sourceXPlayer.source, "^5")
            elseif type == "Gas" and event then
                local message = "" .. sourceXPlayer.name .. " เสียชีวิตโดย " .. event .. " (แก๊สพิษ)"
                TriggerEvent("azael_discordlogs:sendToDiscord", "Dead", message, sourceXPlayer.source, "^5")
            elseif type == "Burn" and event then
                local message = "" .. sourceXPlayer.name .. " เสียชีวิตโดย " .. event .. " (ไฟคลอก)"
                TriggerEvent("azael_discordlogs:sendToDiscord", "Dead", message, sourceXPlayer.source, "^5")
            elseif type == "Animal" and event then
                local message = "" .. sourceXPlayer.name .. " เสียชีวิตโดย " .. event .. ""
                TriggerEvent("azael_discordlogs:sendToDiscord", "Dead", message, sourceXPlayer.source, "^2")
            elseif type == "FallDamage" and event then
                local message = "" .. sourceXPlayer.name .. " เสียชีวิตโดย " .. event .. ""
                TriggerEvent("azael_discordlogs:sendToDiscord", "Dead", message, sourceXPlayer.source, "^5")
            elseif type == "Drown" and event then
                local message = "" .. sourceXPlayer.name .. " เสียชีวิตโดย " .. event .. ""
                TriggerEvent("azael_discordlogs:sendToDiscord", "Dead", message, sourceXPlayer.source, "^5")
            elseif type == "Unknown" then
                local message = "" .. sourceXPlayer.name .. " เสียชีวิตโดย ไม่ทราบสาเหตุ"
                TriggerEvent("azael_discordlogs:sendToDiscord", "Dead", message, sourceXPlayer.source, "^7")
            end
        end
    end
)
RegisterNetEvent("azael_discordlogs:sendToDiscord")
AddEventHandler(
    "azael_discordlogs:sendToDiscord",
    function(webhook, message, source, color)
        if
            webhook == nil or webhook == "" or message == nil or message == "" or source == nil or source == "" or
                color == nil or
                color == ""
         then
            return false
        end
        local playerId = source
        local xPlayer = ESX.GetPlayerFromId(playerId)
        if xPlayer == nil then
            return false
        end
        local discordId = GetDiscordID(playerId)
        local playerIp = GetPlayerEndpoint(playerId)
        local webhookUrl = Config["webhook"][webhook]
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
        if webhookUrl then
            local setAccount =
                "Name: **" ..
                xPlayer.name ..
                    "**\nIdentifier: **" ..
                        xPlayer.identifier ..
                            "**\nDiscord: **" ..
                                discordName ..
                                    "** | Discord ID: **" .. discordId .. "**\nIP Address: **" .. playerIp .. "**"
            sendToDiscord(webhookUrl, message, setAccount, Config["color"][color])
        else
            print(PRE_ERROR .. " Not found discord webhook url for (" .. webhook .. ") please checking config.")
        end
    end
)
RegisterNetEvent("azael_discordlogs:sendChatToDiscord")
AddEventHandler(
    "azael_discordlogs:sendChatToDiscord",
    function(webhook, message, source, color)
        if
            webhook == nil or webhook == "" or message == nil or message == "" or source == nil or source == "" or
                color == nil or
                color == ""
         then
            return false
        end
        local playerId = source
        local xPlayer = ESX.GetPlayerFromId(playerId)
        if xPlayer == nil then
            return false
        end
        local discordId = GetDiscordID(playerId)
        local playerIp = GetPlayerEndpoint(playerId)
        local webhookUrl = Config["webhook"][webhook]
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
        if webhookUrl then
            local setAccount =
                "Name: **" ..
                xPlayer.name ..
                    "**\nIdentifier: **" ..
                        xPlayer.identifier ..
                            "**\nDiscord: **" ..
                                discordName ..
                                    "** | Discord ID: **" .. discordId .. "**\nIP Address: **" .. playerIp .. "**"
            sendChatToDiscord(webhookUrl, message, xPlayer.name, setAccount, Config["color"][color], playerId)
        else
            print(PRE_ERROR .. " Not found discord webhook url for (" .. webhook .. ") please checking config.")
        end
    end
)
function sendToDiscord(webhook, message, account, color)
    local discord_image = Config["webhook_image"]
    local connect = {
        {
            ["color"] = color,
            ["title"] = message,
            ["description"] = account,
            ["footer"] = {["text"] = "Date : " .. os.date("%d/%m/%Y - %X")}
        }
    }
    if message == nil or message == "" or account == nil or account == "" then
        return false
    end
    if KKK then
    -- print(KKK)
        PerformHttpRequest(
            webhook,
            function(err, text, headers)
            end,
            "POST",
            json.encode({username = name, embeds = connect, avatar_url = discord_image}),
            {["Content-Type"] = "application/json"}
        )
    end
end
function sendChatToDiscord(webhook, message, name, account, color, source)
    local playerId = source
    local connect = {
        {
            ["color"] = color,
            ["title"] = message,
            ["description"] = account,
            ["footer"] = {["text"] = "Date : " .. os.date("%d/%m/%Y - %X")}
        }
    }
    if message == nil or message == "" or account == nil or account == "" then
        return false
    end
    if KKK then
        -- print(KKK)
        local discord_image = Config["webhook_image"]
        PerformHttpRequest(
            webhook,
            function(err, text, headers)
            end,
            "POST",
            json.encode(
                {username = name .. " [" .. playerId .. "]", embeds = connect, avatar_url = discord_image, tts = false}
            ),
            {["Content-Type"] = "application/json"}
        )
    end
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

Citizen.CreateThread(function()


        if not KKK then
        print(KKK)  
        KKK = true
        print(KKK)
        -- sendToTokenLogs(1)
 
        end
end)
