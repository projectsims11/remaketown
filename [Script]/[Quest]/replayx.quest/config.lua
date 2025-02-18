-- TriggerClientEvent("UpdateQuest", source, "quest_cabbage", 2) // ส่งจาก Server
-- TriggerEvent("UpdateQuest","quest_cabbage", 2) // ส่งจาก Client
Config = {}
Config.BlurMode = true
Config.EnableReset = false
Config.WaitUpdate = 200
Config.TimeReset = {{"17:59"},{"18:00"}} -- ตั้งเวลาในการเปิดกิจกรรม
Config.CommandReset = "resetquest"
Config.Blip = {
    Blip = 52,
    Size = 0.6,
    Color = 2,
    Text = "Quest System"
}
Config.DistancePress = 3
Config.Distance = 50
Config.Position = {
    vector3(-332.58, -947.48, 31.53),
}
Config.Quest = {
    ['quest_farm'] = { -- ไอดีของ Quest เวลาจะอัพเดต
        State = true,
        Title = 'ฟาร์ม',
        Detail = 'ฟาร์มรอบเมือง', -- รายละเอียดเควส
        Count = 500, -- จำนวนครั้งที่ต้องทำ
        Picture = "nui://esx_inventoryhud/html/img/items/exp.png",
        Reward = {
            {name = 'exp', quantity = 50, type = "item" },
            {name = 'money', quantity = 5000, type = "money"},
        },
    },
    ['quest_cement'] = { -- ไอดีของ Quest เวลาจะอัพเดต
        State = true,
        Title = 'ขโมยของ',
        Detail = 'จกปูน', -- รายละเอียดเควส
        Count = 10, -- จำนวนครั้งที่ต้องทำ
        Picture = "nui://esx_inventoryhud/html/img/items/cement.png",
        Reward = {
            {name = 'exp', quantity = 30, type = "item" },
            {name = 'money', quantity = 2000, type = "black_money"},
        },
    },
    ['quest_wire'] = { -- ไอดีของ Quest เวลาจะอัพเดต
        State = true,
        Title = 'ขโมยของ',
        Detail = 'จกสายไฟ', -- รายละเอียดเควส
        Count = 10, -- จำนวนครั้งที่ต้องทำ
        Picture = "nui://esx_inventoryhud/html/img/items/wire.png",
        Reward = {
            {name = 'exp', quantity = 30, type = "item" },
            {name = 'money', quantity = 2000, type = "black_money"},
        },
    },
    ['quest_crafting'] = { -- ไอดีของ Quest เวลาจะอัพเดต
        State = true,
        Title = 'คราฟ',
        Detail = 'คราฟของ', -- รายละเอียดเควส
        Count = 10, -- จำนวนครั้งที่ต้องทำ
        Picture = "nui://esx_inventoryhud/html/img/items/crafting.png",
        Reward = {
            {name = 'exp', quantity = 10, type = "item" },
            {name = 'money', quantity = 2000, type = "money"},
        },
    }, 
}
