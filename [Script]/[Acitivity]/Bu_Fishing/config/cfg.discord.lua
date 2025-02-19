cfg.Discord = { -- Log Discord Webhook
    AntiCheat = { -- หากไม่ใช้ให้ -- ไว้
        Webhook = "",
        Color = "16711680",
        SendToLogs = function( xPlayer , Webhook , Title , Color )
            return "Default"
            -- exports["ชื่อสคริปต์"]:Discord({
            --     webhook = Webhook, 
            --     xPlayer = xPlayer, 
            --     title = Title,
            --     color = Color
            -- })
        end,
    },
    Fishing = { -- หากไม่ใช้ให้ -- ไว้
        Webhook = "",
        Text = "ผู้เล่น %s ได้ตกปลาจาก ( %s )",
        Color = "247881",
        SendToLogs = function( xPlayer , Webhook , Title , Color , Description )
            return "Default"
            -- exports["ชื่อสคริปต์"]:Discord({
            --     webhook = Webhook, 
            --     xPlayer = xPlayer, 
            --     title = Title,
            --     description = Description,
            --     color = Color
            -- })
        end,
    }
}