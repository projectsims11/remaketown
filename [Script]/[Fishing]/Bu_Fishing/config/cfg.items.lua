cfg.Items = {
    -- ["General"] = { -- เมื่อเปิดจะตกได้ทุกที่ที่มีน้ำ อันนี้คือปิดยุ
    --     ItemRod = "fishrod", -- เบ็ด
    --     ItemBaits = {
    --         ["bait"] = true,
       
    --     },
    --     Remove = { -- ลบเบ็ดเหยื่อ | หากไม่ใช้ให้ -- ไว้
    --         -- ItemRod = { Count = 1, Percent = 20.0 },
    --         -- ItemBaits = {
    --         --     ["fishbait"] = { Count = { 1, 2 }, Percent = 100.0 },
    --         --     -- ["bait_rare"] = { Count = { 1, 3 }, Percent = 100.0 }
    --         -- },
    --     },
    --     Receive = { -- ได้อะไรบ้างแต่ละรอบ
    --         -- { Name = "fishing", Count = 1, Percent = 100.0 },
    --     },
    --     AfterReceive = function( xPlayer , Name , Count ) -- ฟังคชั่นหลังจากได้รับสิ่งของ
    --         -- TriggerClientEvent("ชื่อสคริปต์", xPlayer.source, Name, Count)
    --     end,
    -- },
    [1] = {
        ItemRod = "fishrod", -- เบ็ด
        ItemBaits = {
            ["fishbait"] = true,
       
        },
        Remove = { -- ลบเบ็ดเหยื่อ | หากไม่ใช้ให้ -- ไว้
            ItemRod = { Count = 1, Percent = 20.0 },
            ItemBaits = {
                ["fishbait"] = { Count = { 1, 1 }, Percent = 100.0 },
            },
        },
        Receive = { -- ได้อะไรบ้างแต่ละรอบ
            { Name = "stone_a", Count = 1, Percent = 100.0 },
        },
        AfterReceive = function( xPlayer , Name , Count ) -- ฟังคชั่นหลังจากได้รับสิ่งของ
            -- TriggerClientEvent("ชื่อสคริปต์", xPlayer.source, Name, Count)
        end,
    },
    [2] = {
        ItemRod = "fishrod_auto", -- Auto no mini game
        ItemBaits = {
            ["bait"] = true
        },
        Remove = {
            ItemBaits = {
                ["fishbait"] = { Count = 1, Percent = 100.0 },
            },
        },
        Receive = {
            { Name = "wood", Count = 1, Percent = 100.0 },
        },
        AfterReceive = function( xPlayer , Name , Count )
            -- TriggerClientEvent("ชื่อสคริปต์", xPlayer.source, Name, Count)
        end,
    },
    [3] = {
        ItemRod = "fishrod", -- AFK
        Remove = {
            ItemBaits = {
                -- ["baitshark"] = { Count = 1, Percent = 100.0 },
            },
        },
        Receive = {
            { Name = "dolly_fish", Count = 1, Percent = 100.0 },
        },
        AfterReceive = function( xPlayer , Name , Count )
            -- TriggerClientEvent("ชื่อสคริปต์", xPlayer.source, Name, Count)
        end,
    }
}