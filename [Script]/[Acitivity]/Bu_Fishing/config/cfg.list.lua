cfg.List = {
    ["General"] = { -- เมื่อเปิดจะตกได้ทุกจุดที่มีน้ำ ยกเว้น Zone เช่น [1] , [2]
        Title = "ริมทะเล", -- หัวข้อ
        Mode = "Default", -- Default = Minigame / AFK = ทิ้งตัวไว้ AFK
        NeedPolice = 0, -- ต้องการตำรวจกี่คน
        Status = { "hunger", "thirst" }, -- บันทึกค่าสเตตัส
    },
    [1] = { --- Zone ที่จะตกปลาได้
        Title = "ตกเต่า", -- หัวข้อ
        Mode = "Default", -- Default = Minigame / AFK = ทิ้งตัวไว้ AFK
        Coords = vector3( -2147.49, -526.150, -0.281 ), -- ตำแหน่งในการตกปลาของจุดนี้
        NeedPolice = 0, -- ต้องการตำรวจกี่คน
        Distance = 50.0, -- ระยะในการกดใช้เบ็ดตกปลา
        IsInWater = false, -- เช็คว่าผู้เล่นอยู่ในน้ำหรือไม่
        Blips = { -- Icon บน Map
            Id = 86, -- Blip Id
            Color = 26, -- Blip Size
            Size = 0.8, -- Blip Color
            Name = "<font face='Sarabun'>ตกเต่า - MINIGAME</font>", -- Blip Name
            Radius = true, -- Blip Radius
        },
        Status = {}, -- บันทึกค่าสเตตัส
    },
    [2] = {
        Title = "ตกปลา - AFK",
        Mode = "AFK",
        Coords = vector3( -3077.08, 27.02849, 1.3723 ), 
        Distance = 50.0, 
        IsInWater = true,
        CustomText = true,
        Passive = true,
        Blips = {
            Id = 86,
            Color = 26,
            Size = 0.8,
            Name = "<font face='Sarabun'>ตกปลา - AFK</font>",
            Radius = true,
        },
        Status = { "hunger", "thirst" },
    },
    [3] = {
        Title = "ตกฉลาม",
        Mode = "Default",
        Coords = vector3( -3689.10, 802.5145, 4.28 ), 
        Distance = 50.0, 
        IsInWater = false,
        Anchor = true,
        CustomText = true,
        Passive = false,
        Blips = {
            Id = 86,
            Color = 26,
            Size = 0.8,
            Name = "<font face='Sarabun'>ตกฉลาม - MINIGAME</font>",
            Radius = true,
        },
        Status = { "hunger", "thirst" },
    },
}