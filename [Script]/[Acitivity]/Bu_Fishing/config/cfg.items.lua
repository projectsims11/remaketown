cfg.Items = {
    ["General"] = { -- เมื่อเปิดจะตกได้ทุกที่ที่มีน้ำ อันนี้คือปิดยุ
        ItemRod = "rod", -- เบ็ด
        ItemBaits = {
            ["bait"] = true,
            ["bait_rare"] = true, -- เหยื่อ
        },
        Remove = { -- ลบเบ็ดเหยื่อ | หากไม่ใช้ให้ -- ไว้
            ItemRod = { Count = 1, Percent = 20.0 },
            ItemBaits = {
                ["bait"] = { Count = { 1, 3 }, Percent = 100.0 },
                -- ["bait_rare"] = { Count = { 1, 3 }, Percent = 100.0 }
            },
        },
        Receive = { -- ได้อะไรบ้างแต่ละรอบ
            { Name = "fishing", Count = 1, Percent = 100.0 },
        },
        AfterReceive = function( xPlayer , Name , Count ) -- ฟังคชั่นหลังจากได้รับสิ่งของ
            -- TriggerClientEvent("ชื่อสคริปต์", xPlayer.source, Name, Count)
        end,
    },
    [1] = {
        ItemRod = "rodturtle",
        -- ItemBaits = {
        --     ["baitturtle"] = true
        -- },
        Remove = {
            ItemRod = { Count = 1, Percent = 20.0 },
            ItemBaits = {
                -- ["baitturtle"] = { Count = 1, Percent = 100.0 },
            },
        },
        Receive = {
            { Name = "turtle", Count = 1, Percent = 100.0 },
        },
        AfterReceive = function( xPlayer , Name , Count )
            -- TriggerClientEvent("ชื่อสคริปต์", xPlayer.source, Name, Count)
        end,
    },
    [2] = {
        ItemRod = "rodafk",
        -- ItemBaits = {
        --     ["baitafk"] = true
        -- },
        Remove = {
            ItemRod = { Count = 1, Percent = 20.0 },
            ItemBaits = {
                -- ["baitafk"] = { Count = 1, Percent = 100.0 },
            },
        },
        Receive = {
            { Name = "fishafk", Count = 1, Percent = 100.0 },
        },
        AfterReceive = function( xPlayer , Name , Count )
            -- TriggerClientEvent("ชื่อสคริปต์", xPlayer.source, Name, Count)
        end,
    },
    [3] = {
        ItemRod = "rodshark",
        -- ItemBaits = {
        --     ["baitshark"] = true
        -- },
        Remove = {
            ItemRod = { Count = 1, Percent = 20.0 },
            ItemBaits = {
                -- ["baitshark"] = { Count = 1, Percent = 100.0 },
            },
        },
        Receive = {
            { Name = "fishshark", Count = 1, Percent = 100.0 },
        },
        AfterReceive = function( xPlayer , Name , Count )
            -- TriggerClientEvent("ชื่อสคริปต์", xPlayer.source, Name, Count)
        end,
    }
}