cfg = cfg or {}

cfg.KeyLicense = ''

cfg.Extended = {

    Client = function()
        Citizen.CreateThread( function()
            ESX = nil
            while ESX == nil do
                ESX = exports["es_extended"]:getSharedObject()
                Citizen.Wait(0)
            end

            return ESX
        end)
    end,

    Server = function()
        return exports["es_extended"]:getSharedObject()
    end,

    PlayerSpawned = "playerSpawned" 
}

cfg.Noti = function(text)
    print(text)
end

cfg.Logs = function(tye , code , data1 , data2 )
    local text = ''
    if tye == 'limit' then 
        text = ("โค้ด: `%s`\n ถูกใช้ไปจนถึงลิมิต จำนวน: `%s`\nเวลา : `%s`"):format(code, data1, data2)
    elseif tye == 'expired' then 
        text = ("โค้ด: `%s`\n หมดอายุ เวลา : `%s`"):format(code, data1)
    end
    
    local logo = "" 
    local webhook = ""
    local color = 5763719
    local embed = {
        {
            ["title"] = "โค้ดถูกลบ",
            ["type"] = "rich",
            ["color"] = color,
            ["thumbnail"] = {
                ["url"] = logo
            },
            ['fields'] = {
                {
                    ['name'] = "Delete Code Information",
                    ['value'] = text,
                    ['inline'] = true
                },
            },
            ["footer"] = {
                text = " Verified • "..data2.."",
                ["icon_url"] = logo
            }
        }
    }
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({ username = TokenUsername, embeds = embed}), { ['Content-Type'] = 'application/json' })
end