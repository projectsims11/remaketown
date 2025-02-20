cfg.Discord = { -- Log Discord Webhook
    Expire = { -- สำหรับ สิ่งของหมดอายุ | หากไม่ใช้ให้ -- ไว้
        Usable = { -- กดใช้สิ่งของ | หากไม่ใช้ให้ -- ไว้
            Webhook = "",
            Text = "ผู้เล่น %s ได้เช่า %s จาก %s",
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
        },
        TimeOut = { -- สิ่งของหมดอายุ | หากไม่ใช้ให้ -- ไว้
            Webhook = "",
            Text = "%s ของผู้เล่น %s ได้หมดเวลาแล้ว",
            Color = "16711680",
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
        },
        ExtraTime = { -- ต่อเวลาของสิ่งของ | หากไม่ใช้ให้ -- ไว้
            Webhook = "",
            Text = "ผู้เล่น %s ได้ต่อเวลา %s",
            Color = "16759603",
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
        },
    },
    Redeem = { -- สำหรับ กรอกโค้ดและสร้างโค้ด | หากไม่ใช้ให้ -- ไว้
        Invite = { -- กรอกโค้ดของเพื่อน | หากไม่ใช้ให้ -- ไว้
            Webhook = "",
            Text = "ผู้เล่น %s ได้รับสิ่งของจากการ กรอกโค้ดของ %s",
            Color = "43775",
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
        },
        Usable = { -- กรอกโค้ดของประเทศ | หากไม่ใช้ให้ -- ไว้
            Webhook = "",
            Text = "ผู้เล่น %s ได้รับสิ่งของจากการ กรอกโค้ดของประเทศ",
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
        },
        Admin = { -- สำหรับ แอดมิน | หากไม่ใช้ให้ -- ไว้
            Create = { -- สร้างโค้ด | หากไม่ใช้ให้ -- ไว้
                Webhook = "",
                Text = "แอดมิน %s ได้สร้างโค้ด จำกัดจำนวน %s คน",
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
            },
            Delete = { -- ลบโค้ด | หากไม่ใช้ให้ -- ไว้
                Webhook = "",
                Text = "แอดมิน %s ได้ลบโค้ดรับสิ่งของ",
                Color = "16711680",
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
    }
}