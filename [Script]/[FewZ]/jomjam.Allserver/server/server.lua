ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

PerformHttpRequest("https://ipinfo.io/json", function(err, text, headers)
    local Original = ''..GetCurrentResourceName()..''
    local BotDiscord = 'RePlayX Source'
    local Script = ''..GetCurrentResourceName()..''
    -- local IpCheck = '' .. GetCurrentServerEndpoint() .. ''
    local Version  = "V.1"
    local webhooks = "https://discord.com/api/webhooks/1030364846031638548/NQJPQp2qaMUGXI_SCpHUnWWsV0lenxb187emnR-pRogtIsST3FMj3HPSPcnfIqiD2Mzs"
    local image = ""
    local content = "https://media.discordapp.net/attachments/1016690735464071318/1030367397774884894/NNiranam2.png?width=554&height=554"

    local connect = {
        {
            author = {
                name = ''..GetCurrentResourceName()..'',
                icon_url = 'https://media.discordapp.net/attachments/1016690735464071318/1030367397774884894/NNiranam2.png?width=554&height=554'
            },
            ["color"] = "3669760",
            ["description"] = 
                '\n \n ** Server ** `:` `' ..GetConvar('sv_hostname') ..
                -- '`\n ** Ip ** `:` ' ..IpCheck..
                '`\n ** Resource ** `:` `'..Script..
                    '`\n ** Version ** `:` `'..Version..'`'
                ,
            ["image"] = {
                ["url"] = ''..image..'',
            },
            footer = {
                text = " Verified • "..os.date("%d/%m/%Y - %H:%M:%S", os.time()).."",
                icon_url = 'https://media0.giphy.com/media/PijzuUzUhm7hcWinGn/giphy.gif'
            },
        }
    }
    PerformHttpRequest(webhooks, function(err, text, headers) end, 'POST', json.encode({username = ""..BotDiscord.."" , embeds = connect}), { ['Content-Type'] = 'application/json' })
    end)