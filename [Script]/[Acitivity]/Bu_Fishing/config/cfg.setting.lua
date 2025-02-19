cfg = {}

cfg.FrameWork = {  ---- รายละเอียด Framework
    Main = "esx:getSharedObject",
    Dropped = "esx:playerDropped",
    Death = "esx:onPlayerDeath",
    Spawned = "playerSpawned",
    Job = "esx:setJob",
    Account = {
        Set = "esx:setAccountMoney",
        -- สำหรับเบส 1.1
        Add = "es:addedMoney",
        Remove = "es:removedMoney",
    },
    Inventory = {
        Add = "esx:addInventoryItem",
        Remove = "esx:removeInventoryItem",
        ItemType = "limit", -- limit / weight
    },
    AntiCheat = {
        Enabled = true,
        Dropped = false,
        Distance = 2.0,
        Allow = {
            ["superadmin"] = true,
            ["admin"] = true,
            ["steam:xxx"] = true
        }
    },
    UpdateStatus = 10000,
}

cfg.PressKey = {
    CustomText = "C", -- เขียน Text บนหัว
    Cancel = "X", -- ยกเลิกการตกปลา
    OpenMenuAndKeep = "E", -- เปิดเมนูเช่าเรือ และ เก็บเรือ
    Anchor = "B", -- การใช้งานสมอเรือ
}

cfg.Mode = {
    Afk = 10, -- เวลาในการ AFK ( วินาที )
    Minigame = {
        PressKey = { "W", "Q", "R", "S" }, -- ปุ่ม MINIGAME สุ่ม
        Time = { 5, 7, 9 }, -- เวลาในการ Show ปุ่ม Minigame
        Close = 10, -- หากไม่ได้กดปุ่ม Minigame ภายในเวลา Close จะสุ่ม Minigame ใหม่
        AnitiKey = 5, -- หากผู้เล่นกดปุ่มรัวๆครบจำนวนที่กำหนด จะยกเลิกการตกปลาทันที
    }
}

cfg.RentalSystem = { -- เช่าเรือ
    Repay = 20, -- เสียตังตอนเก็บกี่เปอร์เซนต์ของราคาเช่า | หากไม่ใช้ให้ -- ไว้
    ProgressBar = {
        OpenMenu = { Text = "กำลังเบิก %s", Delay = 2 },
        Keep = { Text = "กำลังเก็บ %s", Delay = 2 },
    },
    Marker = {
        OpenMenu = {
            Id = 2,
            Size = { x = 0.3, y = 0.3, z = 0.3 },
            Color = { r = 62, g = 192, b = 252, a = 100 },
            Distance = 1.0,
            RotY = 180.0,
        },
        Keep = {
            Id = 1,
            Size = { x = 15.0, y = 15.0, z = 5.0 },
            Color = { r = 62, g = 192, b = 252, a = 200 },
            RotY = 0.0,
        },
    },
    TextUi = { -- Text ต่างๆ
        Rental = { -- การเช่าเรือ
            OpenMenu = {
                Default = "กด ~INPUT_CONTEXT~ เพื่อเปิดเมนู",
                Custom = "เพื่อเปิดเมนู",
            },
            Keep = {
                Default = "กด ~INPUT_CONTEXT~ เพื่อเก็บเรือ",
                Custom = "เพื่อเก็บเรือ",
            },
        },
        Anchor = { -- การใช้สมอเรือ
            Default = "กด ~INPUT_CONTEXT~ เพื่อวางสมอเรือ",
            Custom = "เพื่อวางสมอเรือ",
        },
    }
}