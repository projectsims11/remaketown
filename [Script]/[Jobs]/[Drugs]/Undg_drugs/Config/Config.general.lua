Config = {}

Config.Default = {

    Extended = {
        ['Verion'] = true,	-- สูงกว่า 1.6.0 + = true | ต่ำกว่า 1.6.0 = false
        ['UserLicense'] = 'Undg_47pwdzn7993wl8gflvet', -- KEY USER https://discord.gg/k2DVyt5a
        ['onPlayerDeath'] = 'esx:onPlayerDeath',
        ['onPlayerLoaded'] = 'esx:playerLoaded',
        ['Img-Inventory'] = 'nui://Fewthz_inventory/html/img/items/',
        ['Cancel-Procressbar'] = 'mythic_progbar:client:cancel',

        ['Event'] = 'noevent', -- หากใช้ noevent แล้วไม่ได้รับไอเทมหลังเลี้ยงเสร็จ ให้เปลี่ยนเป็น none ทันที
    },
    
    Manage = {
        Timereset = 900, -- หากครบ 500 วิ จะรีจุดขายยาใหม่
        SpawnMax = 5, -- จะสุ่มเกิดกี่จุด อิงจาก Zone ถ้าตั้งเกินจะอิง จำนวน Npc ทั้งหมด
        OpenDrugs = 'E', 
        Progress = 90, -- เวลาในตอนขาย

        FailRemove = false, -- ถ้า MiniGame() return false | จะให้ลบ Npc ไหม | false ไม่ลบ , true ลบ

        AllowJob = { -- ให้ Job ใครขายยาได้บ้าง
            ['unemployed'],
        },
        
        Listitems = {
            {
                Randomrate = 50, -- % ในการขายยาให้ Npc
                Name = 'stone_a',-- ชื่อไอเทม
                Cop = 1, -- ต้องการตำรวจกี่คนในการขาย
                Checkitem = {'stone_a', false}, -- ไอเทมที่ต้องการ หากปรับเป็น true จะลบไอเทมเมื่อขายสำเร็จ !
                Black_money = {500 , 1000}, -- เงินแดงที่จะได้ 
                Bonus = {
                    { name = 'exp', count = 1, percent = 0},
                },
            },
            {
                Randomrate = 50, -- % ในการขายยาให้ Npc
                Name = 'capsulea',-- ชื่อไอเทม
                Cop = 1, -- ต้องการตำรวจกี่คนในการขาย
                Checkitem = {'stone_a', false}, -- ไอเทมที่ต้องการ หากปรับเป็น true จะลบไอเทมเมื่อขายสำเร็จ !
                Black_money = {500 , 1000}, -- เงินแดงที่จะได้ 
                Bonus = {
                    { },
                },
            },
            {
                Randomrate = 50, -- % ในการขายยาให้ Npc
                Name = 'capsuleb',-- ชื่อไอเทม
                Cop = 1, -- ต้องการตำรวจกี่คนในการขาย
                Checkitem = {'stone_a', false}, -- ไอเทมที่ต้องการ หากปรับเป็น true จะลบไอเทมเมื่อขายสำเร็จ !
                Black_money = {500 , 1000}, -- เงินแดงที่จะได้ 
                Bonus = {
                    { },
                },
            },
            {
                Randomrate = 50, -- % ในการขายยาให้ Npc
                Name = 'capsulec',-- ชื่อไอเทม
                Cop = 1, -- ต้องการตำรวจกี่คนในการขาย
                Checkitem = {'stone_a', false}, -- ไอเทมที่ต้องการ หากปรับเป็น true จะลบไอเทมเมื่อขายสำเร็จ !
                Black_money = {500 , 1000}, -- เงินแดงที่จะได้ 
                Bonus = {
                    {},
                },
            },
            {
                Randomrate = 50, -- % ในการขายยาให้ Npc
                Name = 'capsulep',-- ชื่อไอเทม
                Cop = 1, -- ต้องการตำรวจกี่คนในการขาย
                Checkitem = {'stone_a', false}, -- ไอเทมที่ต้องการ หากปรับเป็น true จะลบไอเทมเมื่อขายสำเร็จ !
                Black_money = {500 , 1000}, -- เงินแดงที่จะได้ 
                Bonus = {
                    { },
                },
            },
       

        },
    },

    Zone = {
        [1] = {
            Coords = vector3(282.8, -1574.08, 30.52),
            Npc = {
                Model = "a_m_o_soucent_03",					
                Heading = 13.12,
            },
            Blips = { 
                Enable = true,
                Name = "NPC SELL DRUGS X10",
                Sprite = 51,
                Color = 0,
                Radius = 100.0,
                ColorRadius = 1,
                Scale = 0.8,
            },
            MultiplyMoney = 10,
        },

        [2] = {
            Coords = vector3(527.24, -1416.8, 29.24),
            Npc = {
                Model = "a_m_m_beach_01",					
                Heading = 219.0,
            },
            Blips = { 
                Enable = true,
                Name = "NPC SELL DRUGS",
                Sprite = 51,
                Color = 0,
                Radius = 100.0,
                ColorRadius = 1,
                Scale = 0.8,
            },        
            MultiplyMoney = 1,
        },

        [3] = {
            Coords = vector3(1248.76, -1456.08, 34.96),
            Npc = {
                Model = "a_f_y_vinewood_01",					
                Heading = 345.8,
            },
            Blips = { 
                Enable = true,
                Name = "NPC SELL DRUGS",
                Sprite = 51,
                Color = 0,
                Radius = 100.0,
                ColorRadius = 1,
                Scale = 0.8,
            },        
            MultiplyMoney = 1,
        },

        [4] = {
            Coords = vector3(1193.8, -630.76, 62.84),
            Npc = {
                Model = "a_f_y_bevhills_04",					
                Heading = 106.64,
            },
            Blips = { 
                Enable = true,
                Name = "NPC SELL DRUGS",
                Sprite = 51,
                Color = 0,
                Radius = 100.0,
                ColorRadius = 1,
                Scale = 0.8,
            },        
            MultiplyMoney = 1,
        },

        [5] = {
            Coords = vector3(751.48, -453.8, 37.16),
            Npc = {
                Model = "a_f_o_indian_01",					
                Heading = 139.8,
            },
            Blips = { 
                Enable = true,
                Name = "NPC SELL DRUGS",
                Sprite = 51,
                Color = 0,
                Radius = 100.0,
                ColorRadius = 1,
                Scale = 0.8,
            },        
            MultiplyMoney = 1,
        },

        [6] = {
            Coords = vector3(-557.88, -672.92, 33.16),
            Npc = {
                Model = "a_f_o_genstreet_01",					
                Heading = 315.68,
            },
            Blips = { 
                Enable = true,
                Name = "NPC SELL DRUGS",
                Sprite = 51,
                Color = 0,
                Radius = 100.0,
                ColorRadius = 1,
                Scale = 0.8,
            },      
            MultiplyMoney = 1,  
        },

        [7] = {
            Coords = vector3(-1082.2, -786.32, 19.24),
            Npc = {
                Model = "a_f_m_bevhills_01",					
                Heading = 354.92,
            },
            Blips = { 
                Enable = true,
                Name = "NPC SELL DRUGS",
                Sprite = 51,
                Color = 0,
                Radius = 100.0,
                ColorRadius = 1,
                Scale = 0.8,
            },
            MultiplyMoney = 1,
        },

        [8] = {
            Coords = vector3(-1411.04, -385.72, 36.64),
            Npc = {
                Model = "a_f_m_bevhills_02",					
                Heading = 271.92,
            },
            Blips = { 
                Enable = true,
                Name = "NPC SELL DRUGS",
                Sprite = 51,
                Color = 0,
                Radius = 100.0,
                ColorRadius = 1,
                Scale = 0.8,
            },
            MultiplyMoney = 1,
        },

        [9] = {
            Coords = vector3(78.96, -705.44, 44.24),
            Npc = {
                Model = "a_m_m_genfat_01",					
                Heading = 73.52,
            },
            Blips = { 
                Enable = true,
                Name = "NPC SELL DRUGS",
                Sprite = 51,
                Color = 0,
                Radius = 100.0,
                ColorRadius = 1,
                Scale = 0.8,
            },
            MultiplyMoney = 1,
        },
        
        [10] = {
            Coords = vector3(808.56, -1730.64, 29.24),
            Npc = {
                Model = "a_m_o_soucent_03",					
                Heading = 226.48,
            },
            Blips = { 
                Enable = true,
                Name = "NPC SELL DRUGS",
                Sprite = 51,
                Color = 0,
                Radius = 100.0,
                ColorRadius = 1,
                Scale = 0.8,
            },
            MultiplyMoney = 1,
        },
        [11] = {
            Coords = vector3(-307.5965, -46.1161, 48.5559),
            Npc = {
                Model = "a_m_o_soucent_03",					
                Heading = 335.9835,
            },
            Blips = { 
                Enable = true,
                Name = "NPC SELL DRUGS",
                Sprite = 51,
                Color = 0,
                Radius = 100.0,
                ColorRadius = 1,
                Scale = 0.8,
            },
            MultiplyMoney = 1,
        },
        [12] = {
            Coords = vector3(-661.0932, 242.2007, 81.3005),
            Npc = {
                Model = "a_m_o_soucent_03",					
                Heading =  314.7166,
            },
            Blips = { 
                Enable = true,
                Name = "NPC SELL DRUGS",
                Sprite = 51,
                Color = 0,
                Radius = 100.0,
                ColorRadius = 1,
                Scale = 0.8,
            },
            MultiplyMoney = 1,
        },
        [13] = {
            Coords = vector3(-252.5439, -324.4444, 29.9682),
            Npc = {
                Model = "a_m_o_soucent_03",					
                Heading =  95.3665,
            },
            Blips = { 
                Enable = true,
                Name = "NPC SELL DRUGS",
                Sprite = 51,
                Color = 0,
                Radius = 100.0,
                ColorRadius = 1,
                Scale = 0.8,
            },
            MultiplyMoney = 1,
        },
        [14] = {
            Coords = vector3(-403.9041, -1861.5069, 20.5033),
            Npc = {
                Model = "a_m_o_soucent_03",					
                Heading =  18.2368,
            },
            Blips = { 
                Enable = true,
                Name = "NPC SELL DRUGS",
                Sprite = 51,
                Color = 0,
                Radius = 100.0,
                ColorRadius = 1,
                Scale = 0.8,
            },
            MultiplyMoney = 1,
        },
        [15] = {
            Coords = vector3(-668.0211, -1444.8005, 10.5207),
            Npc = {
                Model = "a_m_o_soucent_03",					
                Heading =  255.3205,
            },
            Blips = { 
                Enable = true,
                Name = "NPC SELL DRUGS",
                Sprite = 51,
                Color = 0,
                Radius = 100.0,
                ColorRadius = 1,
                Scale = 0.8,
            },
            MultiplyMoney = 1,
        },
        [16] = {
            Coords = vector3(-926.8731, -843.7273, 15.5165),
            Npc = {
                Model = "a_m_o_soucent_03",					
                Heading =  88.4580,
            },
            Blips = { 
                Enable = true,
                Name = "NPC SELL DRUGS",
                Sprite = 51,
                Color = 0,
                Radius = 100.0,
                ColorRadius = 1,
                Scale = 0.8,
            },
            MultiplyMoney = 1,
        },
        [17] = {
            Coords = vector3(-1170.6945, -863.2391, 14.093),
            Npc = {
                Model = "a_m_o_soucent_03",					
                Heading =  357.1417,
            },
            Blips = { 
                Enable = true,
                Name = "NPC SELL DRUGS",
                Sprite = 51,
                Color = 0,
                Radius = 100.0,
                ColorRadius = 1,
                Scale = 0.8,
            },
            MultiplyMoney = 1,
        },
        [18] = {
            Coords = vector3(-615.4653, -513.7148, 34.7634),
            Npc = {
                Model = "a_m_o_soucent_03",					
                Heading =  91.3924,
            },
            Blips = { 
                Enable = true,
                Name = "NPC SELL DRUGS",
                Sprite = 51,
                Color = 0,
                Radius = 100.0,
                ColorRadius = 1,
                Scale = 0.8,
            },
            MultiplyMoney = 1,
        },
        [19] = {
            Coords = vector3(-449.7629, -361.4294, 33.6520),
            Npc = {
                Model = "a_m_o_soucent_03",					
                Heading =   174.0865,
            },
            Blips = { 
                Enable = true,
                Name = "NPC SELL DRUGS",
                Sprite = 51,
                Color = 0,
                Radius = 100.0,
                ColorRadius = 1,
                Scale = 0.8,
            },
            MultiplyMoney = 1,
        },
        [20] = {
            Coords = vector3(-1266.3003, -92.8871, 44.9302),
            Npc = {
                Model = "a_m_o_soucent_03",					
                Heading =   333.9783,
            },
            Blips = { 
                Enable = true,
                Name = "NPC SELL DRUGS",
                Sprite = 51,
                Color = 0,
                Radius = 100.0,
                ColorRadius = 1,
                Scale = 0.8,
            },
            MultiplyMoney = 1,
        },
        [21] = {
            Coords = vector3(-1561.6448, -207.9002, 55.5091),
            Npc = {
                Model = "a_m_o_soucent_03",					
                Heading =   1.8579,
            },
            Blips = { 
                Enable = true,
                Name = "NPC SELL DRUGS",
                Sprite = 51,
                Color = 0,
                Radius = 100.0,
                ColorRadius = 1,
                Scale = 0.8,
            },
            MultiplyMoney = 1,
        },
        [22] = {
            Coords = vector3(-1380.3988, -579.6322, 30.1209),
            Npc = {
                Model = "a_m_o_soucent_03",					
                Heading =   339.9634,
            },
            Blips = { 
                Enable = true,
                Name = "NPC SELL DRUGS",
                Sprite = 51,
                Color = 0,
                Radius = 100.0,
                ColorRadius = 1,
                Scale = 0.8,
            },
            MultiplyMoney = 1,
        },
        [23] = {
            Coords = vector3(-1277.8639, -996.4789, 1.7962),
            Npc = {
                Model = "a_m_o_soucent_03",					
                Heading =   4.8132,
            },
            Blips = { 
                Enable = true,
                Name = "NPC SELL DRUGS",
                Sprite = 51,
                Color = 0,
                Radius = 100.0,
                ColorRadius = 1,
                Scale = 0.8,
            },
            MultiplyMoney = 1,
        },
        [24] = {
            Coords = vector3(-1164.1725, -1496.6248, 4.3794),
            Npc = {
                Model = "a_m_o_soucent_03",					
                Heading =   257.0988,
            },
            Blips = { 
                Enable = true,
                Name = "NPC SELL DRUGS",
                Sprite = 51,
                Color = 0,
                Radius = 100.0,
                ColorRadius = 1,
                Scale = 0.8,
            },
            MultiplyMoney = 1,
        },
        [25] = {
            Coords = vector3(-1029.7998, -1426.6141, 5.4265),
            Npc = {
                Model = "a_m_o_soucent_03",					
                Heading = 257.6572,
            },
            Blips = { 
                Enable = true,
                Name = "NPC SELL DRUGS",
                Sprite = 51,
                Color = 0,
                Radius = 100.0,
                ColorRadius = 1,
                Scale = 0.8,
            },
            MultiplyMoney = 1,
        },
        [26] = {
            Coords = vector3(-1508.8722, 67.8129, 61.0668),
            Npc = {
                Model = "a_m_o_soucent_03",					
                Heading = 154.5005,
            },
            Blips = { 
                Enable = true,
                Name = "NPC SELL DRUGS",
                Sprite = 51,
                Color = 0,
                Radius = 100.0,
                ColorRadius = 1,
                Scale = 0.8,
            },
            MultiplyMoney = 1,
        },
        [27] = {
            Coords = vector3(-713.6783, 491.4992, 109.1985),
            Npc = {
                Model = "a_m_o_soucent_03",					
                Heading = 201.2202,
            },
            Blips = { 
                Enable = true,
                Name = "NPC SELL DRUGS",
                Sprite = 51,
                Color = 0,
                Radius = 100.0,
                ColorRadius = 1,
                Scale = 0.8,
            },
            MultiplyMoney = 1,
        },
        [28] = {
            Coords = vector3(249.4110, 276.7431, 105.5357),
            Npc = {
                Model = "a_m_o_soucent_03",					
                Heading = 9.9206,
            },
            Blips = { 
                Enable = true,
                Name = "NPC SELL DRUGS",
                Sprite = 51,
                Color = 0,
                Radius = 100.0,
                ColorRadius = 1,
                Scale = 0.8,
            },
            MultiplyMoney = 1,
        },



    },

}
