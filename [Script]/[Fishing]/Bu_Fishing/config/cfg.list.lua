cfg.List = {
    ["General"] = { -- เมื่อเปิดจะตกได้ทุกจุดที่มีน้ำ ยกเว้น Zone เช่น [1] , [2]
        Title = "ริมทะเล", -- หัวข้อ
        Mode = "Default", -- Default = Minigame / AFK = ทิ้งตัวไว้ AFK
        NeedPolice = 0, -- ต้องการตำรวจกี่คน
        Status = { "hunger", "stress" }, -- บันทึกค่าสเตตัส
    },
    [1] = { --- Zone ที่จะตกปลาได้
        Title = "ตกปลาธรรมดา", -- หัวข้อ
        Mode = "Default", -- Default = Minigame / AFK = ทิ้งตัวไว้ AFK
        Coords = vector3( -2147.49, -526.150, -0.281 ), -- ตำแหน่งในการตกปลาของจุดนี้
        NeedPolice = 0, -- ต้องการตำรวจกี่คน
        Distance = 50.0, -- ระยะในการกดใช้เบ็ดตกปลา
        IsInWater = false, -- เช็คว่าผู้เล่นอยู่ในน้ำหรือไม่
        Blips = { -- Icon บน Map
            Id = 68, -- Blip Id
            Color = 0, -- Blip Size
            Size = 0.8, -- Blip Color
            Name = "<font face='Sarabun'>ตกปลาน้ำตื่น/font>", -- Blip Name
            Radius = true, -- Blip Radius
        },
        Status = {}, -- บันทึกค่าสเตตัส
    },
    [2] = {
        Title = "ตกปลา - auto",
        Mode = "AFK",
        Coords = vector3( -1979.6627, -704.7554, 2.9717), 
        Distance = 50.0, 
        IsInWater = false,
        CustomText = false,
        Passive = true,
        Blips = {
            Id = 68,
            Color = 0,
            Size = 0.8,
            Name = "<font face='Sarabun'>ตกปลา - auto</font>",
            Radius = true,
        },
        Status = { "hunger", "stress" },
    },
    [3] = {
        Title = "ตก AFK",
        Mode = "AFK",
        Coords = vector3( -1888.7744, -834.9020, 1.6429 ), 
        Distance = 50.0, 
        IsInWater = false,
        Anchor = true,
        CustomText = false,
        Passive = false,
        Blips = {
            Id = 68,
            Color = 0,
            Size = 0.8,
            Name = "<font face='Sarabun'>ตกปลา AFK</font>",
            Radius = true,
        },
        Status = { },
    },
}