config = config or {}
config.security = {
    AllowAddPointOnClient = true, --! อนุญาติให้ client สามารถใช้ exports.swift_quest:addPoint() / TriggerEvent("swift_quest:addPoint") ได้ (ไม่ปลอดภัย)
}
config.framework = "esx" --? standalone, esx, custom, etc (สำหรับให้ของรางวัล)
config.images_path = "nui://Fewthz_inventory/html/img/items" -- path ของรูปไอเทม

config.commands = {
    AddMissionPoint = "amp", --? ตัวอย่าง /amp [playerId] [taskId] [count]
    reset = "resetmission", --? ตัวอย่าง /resetmission
    group = "admin" 
}

config.KeyBindings = {
    MainMenu = { --! หมายเหตุ: อนิเมชั่นซูมกล้องเข้าจะใช้งานได้แค่ที่เควสบอร์ด (config.boards) เท่านั้น
        enabled = false, -- เปิด Keybinding สำหรับเมนูเควส
        key = "F3"
    },
    MiniQuestMenu = {
        enabled = true, -- เปิด Keybinding สำหรับเมนูเควสขนาดเล็ก (ไม่สามารถกดรับ/ยกเลิก/รับรางวัลได้)
        key = "F4"
    }
}

config.boards = {
    enabled = true, -- เปิดให้กดรับเควสที่บอร์ด
    openKey = 38, -- ปุ่มเปิดเมนู
    list = {
        {
            model = "tr_prop_tr_planning_board_01a",
            heading =  340.0,
            -- coords = vector3(-415.22, 1161.05, 324.86),
            coords = vector3(-300.7934, -931.9169, 31.0606),

            
            radius = 3.0,
            drawText3D = {
                enabled = false,
                drawDistance = 10.0,
                title = "~g~กระดานเควส~w~",
                subtitle = "รับเควสประจำวันได้ที่นี่",
                factor = vector3(0.0, 0.0, 2.0),
                subtitle_factor = vector3(0.0, 0.0, 1.9),
                font = "font4thai"
            }
        },
    }
}

config.quests = {
    AutoRefresh = {
        enabled = true, -- เปิด/ปิด รีเซ็ตเควสทั้งเซิฟเวอร์อัตโนมัติตามเวลา
        time = "00:00" -- เวลาที่จะรีเซ็ต
    },
    MaxActiveQuests = 5, -- สามารถรับเควสพร้อมกันได้กี่เควส
    MaxCompletedQuestsPerRefresh = 10, -- สามารถทำเควสได้สูงสุดกี่เควส
    SetupOptions = {
        SortTasksByOrder = true -- เรียงเควสตามลำดับจากบนลงล่างหรือไม่
    },
    tasks = { -- Key ต้องเป็นตัวเลขเท่านั้น (ไม่งั้นอาจทำให้เกิด Error ได้)
        [1] = {
            label = "ทำเควสสำเร็จ",
            count = 10,
            rewards = {
                {item = "money", count = 1000}
            }
        },
        [2] = {
            label = "เก็บส้ม 100 ครั้ง",
            count = 100,
            rewards = {
                {item = "money", count = 1000}
            }
        },
        [3] = {
            label = "ขโมยปูน 5 ถุง",
            count = 5,
            rewards = {
                {item = "money", count = 1000}
            }
        },
        [4] = {
            label = "Online 2 HR.",
            count = 120,
            rewards = {
                {item = "money", count = 1000}
            }
        }
    }
}