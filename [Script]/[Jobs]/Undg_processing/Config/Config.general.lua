Config = {}

Config.Default = {

    Extended = {
        ['Verion'] = true,	-- สูงกว่า 1.6.0 + = true | ต่ำกว่า 1.6.0 = false
        ['UserLicense'] = 'Undg_al79orbv288zhzae96h6', -- KEY USER https://discord.gg/k2DVyt5a
        ['Base'] = '1.2', -- 1.1 จะใช้เช็คไอเทมแบบ item.limit | 1.2 จะใช้เช็คไอเทมแบบ canCarryItem
        ['onPlayerDeath'] = 'esx:onPlayerDeath',
        ['onPlayerLoaded'] = 'esx:playerLoaded',
        ['Img-Inventory'] = 'nui://Fewthz_inventory/html/img/items/',
        ['Discord-Log'] = '',
    },

    Action = {
        Keyboard = 'E',
        Cancel = 'X',

        Vip = {
            {
                Item = 'work_x2', -- ชื่อไอเทม
                Process = 1, -- เวลาที่ใช้ในการ Process เมื่อมีไอเทม Vip
            }, 
        },
    },

    Manage = {
        ['orange'] = {
            Coords = vector3(1141.6539, 2654.7253, 38.1509),

            Text = 'Press ~b~E~w~ to Process ~y~orange',
            NPC = {
                Model = "a_m_o_soucent_03",					
                Heading = 87.8518,
            },
            Blips = {
                enable = true,			-- เปิด true / ปิด false | แสดง Blips บนแผนที่
                Text = '[orange] - Process',   -- Text ใน Blip
                Sprite = 318,			-- id | รูปลักษณ์
                Color = 70,				-- สี
                Scale = 1.0,			-- ขนาด
            },

            Distance = { -- ระยะต่างๆ
                Pickup = 4.0, -- ระยะในการเก็บตอนอยู่ใกล้ Prop งาน
            },

            Progress = 4, -- เวลาในการทำงาน 4 = 4 วิ
            Animation = { -- ท่าทาง
                dict = "anim@gangops@facility@servers@bodysearch@",
                anim = "player_search",
                flag = 49
            },                 

            Required = { 
                { name = 'orange', count = 2},

            },
            Bonus = { 
                { name = 'orange_process', count = {1,1}, percent = 100},
            },
        },
        ['wheat'] = {
            Coords = vector3(1106.8005, 2652.8713, 38.1409),

            Text = 'Press ~b~E~w~ to Process ~y~wheat',
            NPC = {
                Model = "a_m_o_soucent_03",					
                Heading = 272.8933,
            },
            Blips = {
                enable = true,			-- เปิด true / ปิด false | แสดง Blips บนแผนที่
                Text = '[wheat] - Process',   -- Text ใน Blip
                Sprite = 318,			-- id | รูปลักษณ์
                Color = 70,				-- สี
                Scale = 1.0,			-- ขนาด
            },

            Distance = { -- ระยะต่างๆ
                Pickup = 4.0, -- ระยะในการเก็บตอนอยู่ใกล้ Prop งาน
            },

            Progress = 4, -- เวลาในการทำงาน 4 = 4 วิ
            Animation = { -- ท่าทาง
                dict = "anim@gangops@facility@servers@bodysearch@",
                anim = "player_search",
                flag = 49
            },                 

            Required = { 
                { name = 'wheat', count = 2},

            },
            Bonus = { 
                { name = 'wheat_process', count = {1,1}, percent = 100},
            },
        },
        ['rice'] = {
            Coords = vector3(1106.2808, 2643.0898, 38.1437),

            Text = 'Press ~b~E~w~ to Process ~y~rice',
            NPC = {
                Model = "a_m_o_soucent_03",					
                Heading = 273.2101,
            },
            Blips = {
                enable = true,			-- เปิด true / ปิด false | แสดง Blips บนแผนที่
                Text = '[rice] - Process',   -- Text ใน Blip
                Sprite = 318,			-- id | รูปลักษณ์
                Color = 70,				-- สี
                Scale = 1.0,			-- ขนาด
            },

            Distance = { -- ระยะต่างๆ
                Pickup = 4.0, -- ระยะในการเก็บตอนอยู่ใกล้ Prop งาน
            },

            Progress = 4, -- เวลาในการทำงาน 4 = 4 วิ
            Animation = { -- ท่าทาง
                dict = "anim@gangops@facility@servers@bodysearch@",
                anim = "player_search",
                flag = 49
            },                 

            Required = { 
                { name = 'rice', count = 2},

            },
            Bonus = { 
                { name = 'rice_process', count = {1,1}, percent = 100},
            },
        },
        ['cabbage'] = {
            Coords = vector3(1128.9358, 2642.9226, 38.1437), 

            Text = 'Press ~b~E~w~ to Process ~y~cabbage',
            NPC = {
                Model = "a_m_o_soucent_03",					
                Heading = 0.1704,
            },
            Blips = {
                enable = true,			-- เปิด true / ปิด false | แสดง Blips บนแผนที่
                Text = '[cabbage] - Process',   -- Text ใน Blip
                Sprite = 318,			-- id | รูปลักษณ์
                Color = 70,				-- สี
                Scale = 1.0,			-- ขนาด
            },

            Distance = { -- ระยะต่างๆ
                Pickup = 4.0, -- ระยะในการเก็บตอนอยู่ใกล้ Prop งาน
            },

            Progress = 4, -- เวลาในการทำงาน 4 = 4 วิ
            Animation = { -- ท่าทาง
                dict = "anim@gangops@facility@servers@bodysearch@",
                anim = "player_search",
                flag = 49
            },                 

            Required = { 
                { name = 'cabbage', count = 2},

            },
            Bonus = { 
                { name = 'cabbage_process', count = {1,1}, percent = 100},
            },
        },
        ['chemical'] = {
            Coords = vector3(1141.4600, 2643.6409, 38.1437),

            Text = 'Press ~b~E~w~ to Process ~y~chemical',
            NPC = {
                Model = "a_m_o_soucent_03",					
                Heading = 90.5553,
            },
            Blips = {
                enable = true,			-- เปิด true / ปิด false | แสดง Blips บนแผนที่
                Text = '[chemical] - Process',   -- Text ใน Blip
                Sprite = 318,			-- id | รูปลักษณ์
                Color = 70,				-- สี
                Scale = 1.0,			-- ขนาด
            },

            Distance = { -- ระยะต่างๆ
                Pickup = 4.0, -- ระยะในการเก็บตอนอยู่ใกล้ Prop งาน
            },

            Progress = 4, -- เวลาในการทำงาน 4 = 4 วิ
            Animation = { -- ท่าทาง
                dict = "anim@gangops@facility@servers@bodysearch@",
                anim = "player_search",
                flag = 49
            },                 

            Required = { 
                { name = 'chemical', count = 2},

            },
            Bonus = { 
                { name = 'chemi_process', count = {1,1}, percent = 100},
            },
        },

    },

}
