-- TriggerClientEvent("UpdateQuest", source, "quest_cabbage", 2) // ส่งจาก Server
-- TriggerEvent("UpdateQuest","quest_cabbage", 2) // ส่งจาก Client
Config = {}
Config.BlurMode = true
Config.EnableReset = false
Config.WaitUpdate = 200
Config.TimeReset = {{"17:59"},{"18:00"}} -- ตั้งเวลาในการเปิดกิจกรรม
Config.CommandReset = "resetquest"
Config.Blip = {
    Pos = {
		x = 183.072525, 
		y = -940.865906, 
		z = 30.088623
	},
    Blips = {
        Open = true,
        Id = 94,
        Size = 0.6,
        Color = 2,
        Text = "Quest System"
    },
}
Config.Distance = 10        -- ระยะเห็น Marker
Config.DistancePress = 2    -- ระยะกด E
Config.Position = {
    vector3(183.072525, -940.865906, 30.088623),
}
Config.Quest = {
    ['quest_mining'] = { -- ไอดีของ Quest เวลาจะอัพเดต
        State = true,
        Title = 'เหมือง',
        Detail = 'เก็บเหมือง', -- รายละเอียดเควส
        Count = 20, -- จำนวนครั้งที่ต้องทำ
        Picture = "https://media.discordapp.net/attachments/1030094411150930060/1033325086859591690/random_9.png",
        Reward = {
            {name = 'armor', quantity = 1, type = "item" },
            {name = 'beer', quantity = 1, type = "item"},
            {name = 'money', quantity = 500, type = "money"},
            {name = 'money', quantity = 100, type = "black_money"},
        },
    },
      
}
