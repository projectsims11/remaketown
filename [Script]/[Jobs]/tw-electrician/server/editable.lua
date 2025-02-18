bot_Token = "MTE3OTcyNjQzOTc3NjUzNDUyOA.G5pQMW.02rTQTdjhsgE38ieHcqsX_2OZvA85_1tf9ZwiY"
bot_logo = "https://r2.fivemanage.com/biv23I9cFWICSObhZsr4C/LogoNEW.png"
bot_name = "Tworst Store"

-- ██████╗  ██████╗ ██╗  ██╗   ██╗    ██╗     ███████╗ █████╗ ██╗  ██╗███████╗ 
-- ██╔══██╗██╔═══██╗██║  ╚██╗ ██╔╝    ██║     ██╔════╝██╔══██╗██║ ██╔╝██╔════╝ 
-- ██████╔╝██║   ██║██║   ╚████╔╝     ██║     █████╗  ███████║█████╔╝ ███████╗ 
-- ██╔═══╝ ██║   ██║██║    ╚██╔╝      ██║     ██╔══╝  ██╔══██║██╔═██╗ ╚════██║ 
-- ██║     ╚██████╔╝███████╗██║       ███████╗███████╗██║  ██║██║  ██╗███████║ 
-- ╚═╝      ╚═════╝ ╚══════╝╚═╝       ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝ 
-- [discord.gg/gaJJjnKGpg] 
discord_webhook = {
    ['jobfinish'] =
    "https://discord.com/api/webhooks/1272507836458598544/PaDVD8U2MJVk7aHo9EeWQWjcMpjfLtEHydB0DX--Y8oJnRUgFB60cf4p6D0e501-JUH3",
}

local Caches = {
    Avatars = {}
}
local FormattedToken = "Bot " .. bot_Token
function DiscordRequest(method, endpoint, jsondata)
    local data = nil
    PerformHttpRequest(
        "https://discordapp.com/api/" .. endpoint,
        function(errorCode, resultData, resultHeaders)
            data = { data = resultData, code = errorCode, headers = resultHeaders }
        end,
        method,
        #jsondata > 0 and json.encode(jsondata) or "",
        { ["Content-Type"] = "application/json", ["Authorization"] = FormattedToken }
    )

    while data == nil do
        Citizen.Wait(0)
    end

    return data
end

function GetDiscordAvatar(user)
    local discordId = nil
    local imgURL = nil
    for _, id in ipairs(GetPlayerIdentifiers(user)) do
        if string.match(id, "discord:") then
            discordId = string.gsub(id, "discord:", "")
            break
        end
    end

    if discordId then
        if Caches.Avatars[discordId] == nil then
            local endpoint = ("users/%s"):format(discordId)
            local member = DiscordRequest("GET", endpoint, {})

            if member.code == 200 then
                local data = json.decode(member.data)
                if data ~= nil and data.avatar ~= nil then
                    if (data.avatar:sub(1, 1) and data.avatar:sub(2, 2) == "_") then
                        imgURL = "https://media.discordapp.net/avatars/" .. discordId .. "/" .. data.avatar .. ".gif"
                    else
                        imgURL = "https://media.discordapp.net/avatars/" .. discordId .. "/" .. data.avatar .. ".png"
                    end
                end
            end
            Caches.Avatars[discordId] = imgURL
        else
            imgURL = Caches.Avatars[discordId]
        end
    end
    return imgURL
end

function sendDiscordLogHistory(data)
    local message = {
        username = bot_name,
        embeds = {
            {
                title = botname,
                color = 0xFFA500,
                author = {
                    name = 'Tworst  Electrician - JOB FINISH',
                },
                thumbnail = {
                    url = data.avatar
                },
                fields = {
                    { name = "Player Name", value = data.name or false,            inline = true },
                    { name = "Player ID",   value = data.id or false,              inline = true },
                    { name = "Owner ID",    value = data.owneridentifier or false, inline = true },
                    {
                        name = "──────────Job Information──────────",
                        value = "",
                        inline = false
                    },
                    { name = "Job Price", value = string.format("%s%d", Config.MoneyType, tonumber(data.money) or 'undefined'), inline = true },

                },
                footer = {
                    text = "Tworst Store - https://discord.gg/tworst",
                    icon_url =
                    "https://r2.fivemanage.com/biv23I9cFWICSObhZsr4C/LogoNEW.png"
                },

                timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
            }
        },
        avatar_url = bot_logo
    }

    PerformHttpRequest(discord_webhook['jobfinish'], function(err, text, headers) end,
        "POST",
        json.encode(message),
        { ["Content-Type"] = "application/json" })
end

AddEventHandler('playerDropped', function(reason)
    local src = source
    local owneridentifier = GetIdentifier(src)
    local lobby = coopData[owneridentifier]
    if not lobby then return end
    if lobby.roomSetting.startJob then
        for _, player in ipairs(lobby.players) do
            if player.src == src then
                local vehiclesToDelete = {}
                for k, v in pairs(lobby.roomSetting.Vehicle) do
                    table.insert(vehiclesToDelete, v)
                end
                for _, vehicle in ipairs(vehiclesToDelete) do
                    if DoesEntityExist(vehicle) then
                        DeleteEntity(vehicle)
                    end
                end
                for _, vehicle in ipairs(vehiclesToDelete) do
                    for i, v in ipairs(lobby.roomSetting.Vehicle) do
                        if v == vehicle then
                            table.remove(lobby.roomSetting.Vehicle, i)
                            break
                        end
                    end
                end

                coopData[owneridentifier] = nil
                JoobTask[owneridentifier] = nil
                syncedCounts = {}

                for _, remainingPlayer in ipairs(lobby.players) do
                    if remainingPlayer.src ~= src then
                        SetPlayerRoutingBucket(tonumber(remainingPlayer.src), 0)
                        TriggerClientEvent('tworst-electrician:client:resetjob', remainingPlayer.src)
                        TriggerClientEvent('tw-electrician:client:sendNotification', remainingPlayer.src,
                            Config.NotificationText['playerleftlobby'].text,
                            Config.NotificationText['playerleftlobby'].type)
                    end
                end
                break
            end
        end
    end
end)
