Config = {}

Config.Default = {

    Extended = {
        ['Verion'] = ture,	-- สูงกว่า 1.6.0 + = true | ต่ำกว่า 1.6.0 = false
        ['UserLicense'] = 'Undg_g5w8ekrm7hscneeibkp8', -- KEY USER https://discord.gg/k2DVyt5a
        ['Base'] = '1.2', -- 1.1 จะใช้เช็คไอเทมแบบ item.limit | 1.2 จะใช้เช็คไอเทมแบบ canCarryItem
        ['onPlayerDeath'] = 'esx:onPlayerDeath',
        ['onPlayerLoaded'] = 'esx:playerLoaded',
        ['Img-Inventory'] = 'nui://Fewthz_inventory/html/img/items/',

        ['Event'] = 'noevent', -- หากใช้ noevent แล้วไม่ได้รับไอเทม ให้เปลี่ยนเป็น none ทันที
    },

    Action = {
        Keyboard = 'E',
        Cancel = 'X',
    },

    Manage = {
        ['stone'] = {
            Coords = vector3(2947.8, 2789.16, 40.64),
            Blips = {
                enable = true,			-- เปิด true / ปิด false | แสดง Blips บนแผนที่
                Text = '[CRAFT] STONE',   -- Text ใน Blip
                Sprite = 409,			-- id | รูปลักษณ์
                Color = 0,				-- สี
                Scale = 1.2,			-- ขนาด
            },
            ShowMarkerArea = {        
                Show = false,         -- เปิดวงเลี้ยงสัตว์หรือไม่ ถ้าหากเปิดจะเพิ่มการทำงานของสคริป 0.02
                MakerDistance = 50.0, -- ระยะมองเห็นวง
                MakerConfig = { type = 28,  r = 12, g = 128, b = 236, alpha = 100, }, 
            },

            Distance = { -- ระยะต่างๆ
                Pickup = 2.20, -- ระยะในการเก็บตอนอยู่ใกล้ Prop งาน
                Inzone = 25.0, -- เมื่ออยู่ในระยะนี้จะขึ้น Ui 
            },

            Progress = nil, -- เวลาในการทำงาน 4 = 4 วิ
            Equipment = false, -- เช็คบัตรทำงานไหม หากใช้ให้ใส่แบบนี้ Equipment = 'stone_b',
            -- AutoFarm = 'jobcard', -- บัตรออโต้ฟาร์ม

            MultiplyItem = { -- ไอเทมคุณ 2 ใส่ได้หลายอัน
                ['work_x2'] = 2,
            },

            Animation = { 
                dict = "melee@large_wpn@streamed_core",
                anim = "ground_attack_on_spot",
                flag = 1
            },
            Prop = {
                enable = true,			-- เปิด true / ปิด false | เปิดใช้งาน Prop ในมือผู้เล่น
                model = "prop_tool_pickaxe", -- Model Prop 
                bone = 57005,  -- กระดูกของมือ
                coords = { x = 0.05, y = 0.0, z = 0.0 },  -- ปรับค่าตำแหน่งให้ใกล้มือมากขึ้น
                rotation = { x = -70.0, y = 0.10, z = 0.0 }   -- หมุน pickaxe ให้อยู่ในท่าจับที่เหมาะสม
            },                     

            Object = 'un_hope_prop_stone', -- ชื่อ Prop ต่างๆ
            PropLimit = 6, -- จะให้ Prop เกิดกี่ตัวในงานนี้
            MinDistanceBetweenProps = 6.0, -- ระยะห่างขั้นต่ำระหว่าง prop แต่ละตัว
            SpawnRadius = 12.0, -- ระยะรัศมีในการ spawn prop จากจุดกึ่งกลาง

            Items = { -- ใส่ได้ 1 เท่านั้นสำหรับไอเทมหลัก
                { name = 'stone_a', count = {1,2}},
            },

            Bonus = { -- โบนัสไอเทมใส่ได้เรื่อยๆ
                { name = 'exp', count = {1,2}, percent = 50, x2 = true},
                -- { name = 'oc_coin', count = {1,2}, percent = 5, x2 = false},
                -- { name = 'gacha_farm', count = {1,2}, percent = 5, x2 = false},
            },
        },
        ['steel'] = {
            Coords = vector3(2722.7400, 1362.1624, 24.5210),
            Blips = {
                enable = true,			-- เปิด true / ปิด false | แสดง Blips บนแผนที่
                Text = '[CRAFT] STEEL',   -- Text ใน Bwawlip
                Sprite = 119,			-- id | รูปลักษณ์
                Color = 0,				-- สี
                Scale = 1.2,			-- ขนาด
            },
            ShowMarkerArea = {        
                Show = false,         -- เปิดวงเลี้ยงสัตว์หรือไม่ ถ้าหากเปิดจะเพิ่มการทำงานของสคริป 0.02
                MakerDistance = 50.0, -- ระยะมองเห็นวง
                MakerConfig = { type = 28,  r = 12, g = 128, b = 236, alpha = 100, }, 
            },

            Distance = { -- ระยะต่างๆ
                Pickup = 4.20, -- ระยะในการเก็บตอนอยู่ใกล้ Prop งาน
                Inzone = 25.0, -- เมื่ออยู่ในระยะนี้จะขึ้น Ui 
            },

            Progress = nil, -- เวลาในการทำงาน 4 = 4 วิ
            Equipment = false, -- เช็คบัตรทำงานไหม หากใช้ให้ใส่แบบนี้ Equipment = 'stone_b',
            -- AutoFarm = 'jobcard', -- บัตรออโต้ฟาร์ม

            MultiplyItem = { -- ไอเทมคุณ 2 ใส่ได้หลายอัน
                ['work_x2'] = 2,
            },

            Animation = { 
                dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                anim = "machinic_loop_mechandplayer",
                flag = 1
            },
            Prop = {
                enable = false,			-- เปิด true / ปิด false | เปิดใช้งาน Prop ในมือผู้เล่น
                model = "prop_tool_pickaxe", -- Model Prop 
                bone = 57005,  -- กระดูกของมือ
                coords = { x = 0.05, y = 0.0, z = 0.0 },  -- ปรับค่าตำแหน่งให้ใกล้มือมากขึ้น
                rotation = { x = -70.0, y = 0.10, z = 0.0 }   -- หมุน pickaxe ให้อยู่ในท่าจับที่เหมาะสม
            },                     

            Object = 'un_hope_prop_scrap', -- ชื่อ Prop ต่างๆ
            PropLimit = 6, -- จะให้ Prop เกิดกี่ตัวในงานนี้
            MinDistanceBetweenProps = 6.0, -- ระยะห่างขั้นต่ำระหว่าง prop แต่ละตัว
            SpawnRadius = 12.0, -- ระยะรัศมีในการ spawn prop จากจุดกึ่งกลาง

            Items = { -- ใส่ได้ 1 เท่านั้นสำหรับไอเทมหลัก
                { name = 'steelscrap', count = {1,2}},
            },

            Bonus = { -- โบนัสไอเทมใส่ได้เรื่อยๆ
                { name = 'exp', count = {1,2}, percent = 50, x2 = true},
                -- { name = 'gacha_farm', count = {1,2}, percent = 5, x2 = false},
            },
        },
        ['wood'] = {
            Coords = vector3(-1820.3399658203127, 2635.25, 2.85999989509582),
            Blips = {
                enable = true,			-- เปิด true / ปิด false | แสดง Blips บนแผนที่
                Text = '[CRAFT] WOOD',   -- Text ใน Bwawlip
                Sprite = 89,			-- id | รูปลักษณ์
                Color = 0,				-- สี
                Scale = 1.2,			-- ขนาด  
            },
            ShowMarkerArea = {        
                Show = false,         -- เปิดวงเลี้ยงสัตว์หรือไม่ ถ้าหากเปิดจะเพิ่มการทำงานของสคริป 0.02
                MakerDistance = 50.0, -- ระยะมองเห็นวง
                MakerConfig = { type = 28,  r = 12, g = 128, b = 236, alpha = 100, }, 
            },

            Distance = { -- ระยะต่างๆ
                Pickup = 4.20, -- ระยะในการเก็บตอนอยู่ใกล้ Prop งาน
                Inzone = 25.0, -- เมื่ออยู่ในระยะนี้จะขึ้น Ui 
            },
            Progress = nil, -- เวลาในการทำงาน 4 = 4 วิ
            Equipment = false, -- เช็คบัตรทำงานไหม หากใช้ให้ใส่แบบนี้ Equipment = 'stone_b',
            -- AutoFarm = 'jobcard', -- บัตรออโต้ฟาร์ม

            MultiplyItem = { -- ไอเทมคุณ 2 ใส่ได้หลายอัน
                ['work_x2'] = 2,
            },

            Animation = { 
                dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                anim = "machinic_loop_mechandplayer",
                flag = 1
            },
            Prop = {
                enable = false,			-- เปิด true / ปิด false | เปิดใช้งาน Prop ในมือผู้เล่น
                model = "prop_tool_pickaxe", -- Model Prop 
                bone = 57005,  -- กระดูกของมือ
                coords = { x = 0.05, y = 0.0, z = 0.0 },  -- ปรับค่าตำแหน่งให้ใกล้มือมากขึ้น
                rotation = { x = -70.0, y = 0.10, z = 0.0 }   -- หมุน pickaxe ให้อยู่ในท่าจับที่เหมาะสม
            },                     

            Object = 'un_hope_prop_log', -- ชื่อ Prop ต่างๆ
            PropLimit = 6, -- จะให้ Prop เกิดกี่ตัวในงานนี้
            MinDistanceBetweenProps = 6.0, -- ระยะห่างขั้นต่ำระหว่าง prop แต่ละตัว
            SpawnRadius = 12.0, -- ระยะรัศมีในการ spawn prop จากจุดกึ่งกลาง

            Items = { -- ใส่ได้ 1 เท่านั้นสำหรับไอเทมหลัก
                { name = 'wood', count = {1,2}},
            },

            Bonus = { -- โบนัสไอเทมใส่ได้เรื่อยๆ
                { name = 'exp', count = {1,2}, percent = 50, x2 = true},
                -- { name = 'gacha_farm', count = {1,2}, percent = 5, x2 = false},
            },
        },
        ['orange'] = {
            Coords = vector3(-678.3200073242188, 2592.699951171875, 46.20999908447265), 
            Blips = {
                enable = true,			-- เปิด true / ปิด false | แสดง Blips บนแผนที่
                Text = '[FARM] ORANGE',   -- Text ใน Blip
                Sprite = 56,			-- id | รูปลักษณ์
                Color = 0,				-- สี
                Scale = 1.2,			-- ขนาด
            },
            ShowMarkerArea = {        
                Show = false,         -- เปิดวงเลี้ยงสัตว์หรือไม่ ถ้าหากเปิดจะเพิ่มการทำงานของสคริป 0.02
                MakerDistance = 50.0, -- ระยะมองเห็นวง
                MakerConfig = { type = 28,  r = 12, g = 128, b = 236, alpha = 100, }, 
            },

            Distance = { -- ระยะต่างๆ
                Pickup = 2.20, -- ระยะในการเก็บตอนอยู่ใกล้ Prop งาน
                Inzone = 25.0, -- เมื่ออยู่ในระยะนี้จะขึ้น Ui 
            },

            Progress = nil, -- เวลาในการทำงาน 4 = 4 วิ
            Equipment = false, -- เช็คบัตรทำงานไหม หากใช้ให้ใส่แบบนี้ Equipment = 'stone_b',
            AutoFarm = 'jobcard', -- บัตรออโต้ฟาร์ม

            MultiplyItem = { -- ไอเทมคุณ 2 ใส่ได้หลายอัน
                -- ['work_x2'] = 2,
            },

            Animation = { 
                dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                anim = "machinic_loop_mechandplayer",
                flag = 1
            },
            Prop = {
                enable = false,			-- เปิด true / ปิด false | เปิดใช้งาน Prop ในมือผู้เล่น
                model = "prop_tool_pickaxe", -- Model Prop 
                bone = 57005,  -- กระดูกของมือ
                coords = { x = 0.05, y = 0.0, z = 0.0 },  -- ปรับค่าตำแหน่งให้ใกล้มือมากขึ้น
                rotation = { x = -70.0, y = 0.10, z = 0.0 }   -- หมุน pickaxe ให้อยู่ในท่าจับที่เหมาะสม
            },                     

            Object = 'un_hope_prop_orange', -- ชื่อ Prop ต่างๆ
            PropLimit = 6, -- จะให้ Prop เกิดกี่ตัวในงานนี้
            MinDistanceBetweenProps = 6.0, -- ระยะห่างขั้นต่ำระหว่าง prop แต่ละตัว
            SpawnRadius = 12.0, -- ระยะรัศมีในการ spawn prop จากจุดกึ่งกลาง

            Items = { -- ใส่ได้ 1 เท่านั้นสำหรับไอเทมหลัก
                { name = 'orange', count = {1,1}},
            },

            Bonus = { -- โบนัสไอเทมใส่ได้เรื่อยๆ
                { name = 'exp', count = {1,2}, percent = 50, x2 = true},
                { name = 'oc_coin', count = {1,2}, percent = 5, x2 = false},
                -- { name = 'gacha_farm', count = {1,2}, percent = 5, x2 = false},
            },
        },
        ['wheat'] = {
            Coords = vector3(-393.8399963378906, 4345.4599609375, 55.7599983215332),
            Blips = {
                enable = true,			-- เปิด true / ปิด false | แสดง Blips บนแผนที่
                Text = '[FARM] WHEAT',   -- Text ใน Blip
                Sprite = 59,			-- id | รูปลักษณ์
                Color = 0,				-- สี
                Scale = 1.2,			-- ขนาด
            },
            ShowMarkerArea = {        
                Show = false,         -- เปิดวงเลี้ยงสัตว์หรือไม่ ถ้าหากเปิดจะเพิ่มการทำงานของสคริป 0.02
                MakerDistance = 50.0, -- ระยะมองเห็นวง
                MakerConfig = { type = 28,  r = 12, g = 128, b = 236, alpha = 100, }, 
            },

            Distance = { -- ระยะต่างๆ
                Pickup = 4.20, -- ระยะในการเก็บตอนอยู่ใกล้ Prop งาน
                Inzone = 25.0, -- เมื่ออยู่ในระยะนี้จะขึ้น Ui 
            },

            Progress = nil, -- เวลาในการทำงาน 4 = 4 วิ
            Equipment = false, -- เช็คบัตรทำงานไหม หากใช้ให้ใส่แบบนี้ Equipment = 'stone_b',
            AutoFarm = 'jobcard', -- บัตรออโต้ฟาร์ม

            MultiplyItem = { -- ไอเทมคุณ 2 ใส่ได้หลายอัน
                -- ['work_x2'] = 2,
            },
            Animation = { 
                dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                anim = "machinic_loop_mechandplayer",
                flag = 1
            },
            Prop = {
                enable = false,			-- เปิด true / ปิด false | เปิดใช้งาน Prop ในมือผู้เล่น
                model = "prop_tool_pickaxe", -- Model Prop 
                bone = 57005,  -- กระดูกของมือ
                coords = { x = 0.05, y = 0.0, z = 0.0 },  -- ปรับค่าตำแหน่งให้ใกล้มือมากขึ้น
                rotation = { x = -70.0, y = 0.10, z = 0.0 }   -- หมุน pickaxe ให้อยู่ในท่าจับที่เหมาะสม
            },                     

            Object = 'un_hope_prop_wheat', -- ชื่อ Prop ต่างๆ
            PropLimit = 6, -- จะให้ Prop เกิดกี่ตัวในงานนี้
            MinDistanceBetweenProps = 6.0, -- ระยะห่างขั้นต่ำระหว่าง prop แต่ละตัว
            SpawnRadius = 12.0, -- ระยะรัศมีในการ spawn prop จากจุดกึ่งกลาง

            Items = { -- ใส่ได้ 1 เท่านั้นสำหรับไอเทมหลัก
                { name = 'wheat', count = {1,1}},
            },

            Bonus = { -- โบนัสไอเทมใส่ได้เรื่อยๆ
                { name = 'exp', count = {1,2}, percent = 50, x2 = true},
                { name = 'oc_coin', count = {1,2}, percent = 5, x2 = false},
                -- { name = 'gacha_farm', count = {1,2}, percent = 5, x2 = false},
            },
        },
        ['rice'] = {
            Coords = vector3(-1639.5899658203125, 4585.759765625, 43.25),
            Blips = {
                enable = true,			-- เปิด true / ปิด false | แสดง Blips บนแผนที่
                Text = '[FARM] RICE',   -- Text ใน Blip
                Sprite = 61,			-- id | รูปลักษณ์
                Color = 0,				-- สี
                Scale = 1.2,			-- ขนาด
            },
            ShowMarkerArea = {        
                Show = false,         -- เปิดวงเลี้ยงสัตว์หรือไม่ ถ้าหากเปิดจะเพิ่มการทำงานของสคริป 0.02
                MakerDistance = 50.0, -- ระยะมองเห็นวง
                MakerConfig = { type = 28,  r = 12, g = 128, b = 236, alpha = 100, }, 
            },

            Distance = { -- ระยะต่างๆ
                Pickup = 2.20, -- ระยะในการเก็บตอนอยู่ใกล้ Prop งาน
                Inzone = 25.0, -- เมื่ออยู่ในระยะนี้จะขึ้น Ui 
            },

            Progress = nil, -- เวลาในการทำงาน 4 = 4 วิ
            Equipment = false, -- เช็คบัตรทำงานไหม หากใช้ให้ใส่แบบนี้ Equipment = 'stone_b',
            AutoFarm = 'jobcard', -- บัตรออโต้ฟาร์ม

            MultiplyItem = { -- ไอเทมคุณ 2 ใส่ได้หลายอัน
                -- ['work_x2'] = 2,
            },

            Animation = { 
                dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                anim = "machinic_loop_mechandplayer",
                flag = 1
            },
            Prop = {
                enable = false,			-- เปิด true / ปิด false | เปิดใช้งาน Prop ในมือผู้เล่น
                model = "prop_tool_pickaxe", -- Model Prop 
                bone = 57005,  -- กระดูกของมือ
                coords = { x = 0.05, y = 0.0, z = 0.0 },  -- ปรับค่าตำแหน่งให้ใกล้มือมากขึ้น
                rotation = { x = -70.0, y = 0.10, z = 0.0 }   -- หมุน pickaxe ให้อยู่ในท่าจับที่เหมาะสม
            },                     

            Object = 'un_hope_prop_wheat_rice', -- ชื่อ Prop ต่างๆ
            PropLimit = 6, -- จะให้ Prop เกิดกี่ตัวในงานนี้
            MinDistanceBetweenProps = 6.0, -- ระยะห่างขั้นต่ำระหว่าง prop แต่ละตัว
            SpawnRadius = 12.0, -- ระยะรัศมีในการ spawn prop จากจุดกึ่งกลาง

            Items = { -- ใส่ได้ 1 เท่านั้นสำหรับไอเทมหลัก
                { name = 'rice', count = {1,1}},
            },

            Bonus = { -- โบนัสไอเทมใส่ได้เรื่อยๆ
                { name = 'exp', count = {1,2}, percent = 50, x2 = true},
                { name = 'oc_coin', count = {1,2}, percent = 5, x2 = false},
                -- { name = 'gacha_farm', count = {1,2}, percent = 5, x2 = false},
            },
        },
        ['cabbage'] = {
            Coords = vector3(302.2000122070313, 4311.9599609375, 46.93000030517578),
            Blips = {
                enable = true,			-- เปิด true / ปิด false | แสดง Blips บนแผนที่
                Text = '[FARM] CABBAGE',   -- Text ใน Blip
                Sprite = 124,			-- id | รูปลักษณ์
                Color = 0,				-- สี
                Scale = 1.2,			-- ขนาด
            },
            ShowMarkerArea = {        
                Show = false,         -- เปิดวงเลี้ยงสัตว์หรือไม่ ถ้าหากเปิดจะเพิ่มการทำงานของสคริป 0.02
                MakerDistance = 50.0, -- ระยะมองเห็นวง
                MakerConfig = { type = 28,  r = 12, g = 128, b = 236, alpha = 100, }, 
            },

            Distance = { -- ระยะต่างๆ
                Pickup = 2.20, -- ระยะในการเก็บตอนอยู่ใกล้ Prop งาน
                Inzone = 25.0, -- เมื่ออยู่ในระยะนี้จะขึ้น Ui 
            },

            Progress = nil, -- เวลาในการทำงาน 4 = 4 วิ
            Equipment = false, -- เช็คบัตรทำงานไหม หากใช้ให้ใส่แบบนี้ Equipment = 'stone_b',
            AutoFarm = 'jobcard', -- บัตรออโต้ฟาร์ม

            MultiplyItem = { -- ไอเทมคุณ 2 ใส่ได้หลายอัน
                -- ['work_x2'] = 2,
            },

            Animation = { 
                dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                anim = "machinic_loop_mechandplayer",
                flag = 1
            },
            Prop = {
                enable = false,			-- เปิด true / ปิด false | เปิดใช้งาน Prop ในมือผู้เล่น
                model = "vip_strawberry_cut01", -- Model Prop 
                bone = 57005,  -- กระดูกของมือ
                coords = { x = 0.05, y = 0.0, z = 0.0 },  -- ปรับค่าตำแหน่งให้ใกล้มือมากขึ้น
                rotation = { x = -70.0, y = 0.10, z = 0.0 }   -- หมุน pickaxe ให้อยู่ในท่าจับที่เหมาะสม
            },                     

            Object = 'un_hope_prop_cabbage', -- ชื่อ Prop ต่างๆ
            PropLimit = 6, -- จะให้ Prop เกิดกี่ตัวในงานนี้
            MinDistanceBetweenProps = 6.0, -- ระยะห่างขั้นต่ำระหว่าง prop แต่ละตัว
            SpawnRadius = 12.0, -- ระยะรัศมีในการ spawn prop จากจุดกึ่งกลาง

            Items = { -- ใส่ได้ 1 เท่านั้นสำหรับไอเทมหลัก
                { name = 'cabbage', count = {1,1}},
            },

            Bonus = { -- โบนัสไอเทมใส่ได้เรื่อยๆ
                { name = 'exp', count = {1,2}, percent = 50, x2 = true},
                { name = 'oc_coin', count = {1,2}, percent = 5, x2 = false},
                -- { name = 'gacha_farm', count = {1,2}, percent = 5, x2 = false},
            },
        },
        ['chemical'] = {
            Coords = vector3(-65.62000274658203, 1901.3900146484375, 196.07000732421875),
            Blips = {
                enable = true,			-- เปิด true / ปิด false | แสดง Blips บนแผนที่
                Text = '[FARM] CHEMICAL',   -- Text ใน Blip
                Sprite = 424,			-- id | รูปลักษณ์
                Color = 0,				-- สี
                Scale = 1.2,			-- ขนาด
            },
            ShowMarkerArea = {        
                Show = false,         -- เปิดวงเลี้ยงสัตว์หรือไม่ ถ้าหากเปิดจะเพิ่มการทำงานของสคริป 0.02
                MakerDistance = 50.0, -- ระยะมองเห็นวง
                MakerConfig = { type = 28,  r = 12, g = 128, b = 236, alpha = 100, }, 
            },

            Distance = { -- ระยะต่างๆ
                Pickup = 3.20, -- ระยะในการเก็บตอนอยู่ใกล้ Prop งาน
                Inzone = 25.0, -- เมื่ออยู่ในระยะนี้จะขึ้น Ui 
            },

            Progress = nil, -- เวลาในการทำงาน 4 = 4 วิ
            Equipment = false, -- เช็คบัตรทำงานไหม หากใช้ให้ใส่แบบนี้ Equipment = 'stone_b',
            AutoFarm = 'jobcard', -- บัตรออโต้ฟาร์ม

            MultiplyItem = { -- ไอเทมคุณ 2 ใส่ได้หลายอัน
                -- ['work_x2'] = 2,
            },

            Animation = { 
                dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                anim = "machinic_loop_mechandplayer",
                flag = 1
            },
            Prop = {
                enable = false,			-- เปิด true / ปิด false | เปิดใช้งาน Prop ในมือผู้เล่น
                model = "prop_tool_pickaxe", -- Model Prop 
                bone = 57005,  -- กระดูกของมือ
                coords = { x = 0.05, y = 0.0, z = 0.0 },  -- ปรับค่าตำแหน่งให้ใกล้มือมากขึ้น
                rotation = { x = -70.0, y = 0.10, z = 0.0 }   -- หมุน pickaxe ให้อยู่ในท่าจับที่เหมาะสม
            },                     

            Object = 'un_hope_prop_chemical', -- ชื่อ Prop ต่างๆ
            PropLimit = 6, -- จะให้ Prop เกิดกี่ตัวในงานนี้
            MinDistanceBetweenProps = 6.0, -- ระยะห่างขั้นต่ำระหว่าง prop แต่ละตัว
            SpawnRadius = 12.0, -- ระยะรัศมีในการ spawn prop จากจุดกึ่งกลาง

            Items = { -- ใส่ได้ 1 เท่านั้นสำหรับไอเทมหลัก
                { name = 'chemical', count = {1,1}},
            },

            Bonus = { -- โบนัสไอเทมใส่ได้เรื่อยๆ
                { name = 'exp', count = {1,2}, percent = 50, x2 = true},
                { name = 'oc_coin', count = {1,2}, percent = 5, x2 = false},
                -- { name = 'gacha_farm', count = {1,2}, percent = 5, x2 = false},
            },
        },
        ['herb'] = {
            Coords = vector3(3288.9263, 5152.6387, 18.3919),
            Blips = {
                enable = true,			-- เปิด true / ปิด false | แสดง Blips บนแผนที่
                Text = '[CRAFT] HERB',   -- Text ใน Blip
                Sprite = 78,			-- id | รูปลักษณ์
                Color = 0,				-- สี
                Scale = 1.2,			-- ขนาด
            },
            ShowMarkerArea = {        
                Show = false,         -- เปิดวงเลี้ยงสัตว์หรือไม่ ถ้าหากเปิดจะเพิ่มการทำงานของสคริป 0.02
                MakerDistance = 50.0, -- ระยะมองเห็นวง
                MakerConfig = { type = 28,  r = 12, g = 128, b = 236, alpha = 100, }, 
            },

            Distance = { -- ระยะต่างๆ
                Pickup = 3.20, -- ระยะในการเก็บตอนอยู่ใกล้ Prop งาน
                Inzone = 25.0, -- เมื่ออยู่ในระยะนี้จะขึ้น Ui 
            },

            Progress = nil, -- เวลาในการทำงาน 4 = 4 วิ
            Equipment = false, -- เช็คบัตรทำงานไหม หากใช้ให้ใส่แบบนี้ Equipment = 'stone_b',
            AutoFarm = 'jobcard', -- บัตรออโต้ฟาร์ม

            MultiplyItem = { -- ไอเทมคุณ 2 ใส่ได้หลายอัน
                -- ['work_x2'] = 2,
            },

            Animation = { 
                dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                anim = "machinic_loop_mechandplayer",
                flag = 1
            },
            Prop = {
                enable = false,			-- เปิด true / ปิด false | เปิดใช้งาน Prop ในมือผู้เล่น
                model = "prop_tool_pickaxe", -- Model Prop 
                bone = 57005,  -- กระดูกของมือ
                coords = { x = 0.05, y = 0.0, z = 0.0 },  -- ปรับค่าตำแหน่งให้ใกล้มือมากขึ้น
                rotation = { x = -70.0, y = 0.10, z = 0.0 }   -- หมุน pickaxe ให้อยู่ในท่าจับที่เหมาะสม
            },                     

            Object = 'un_hope_prop_herb', -- ชื่อ Prop ต่างๆ
            PropLimit = 6, -- จะให้ Prop เกิดกี่ตัวในงานนี้
            MinDistanceBetweenProps = 6.0, -- ระยะห่างขั้นต่ำระหว่าง prop แต่ละตัว
            SpawnRadius = 12.0, -- ระยะรัศมีในการ spawn prop จากจุดกึ่งกลาง

            Items = { -- ใส่ได้ 1 เท่านั้นสำหรับไอเทมหลัก
                { name = 'herb', count = {1,2}},
            },

            Bonus = { -- โบนัสไอเทมใส่ได้เรื่อยๆ
                { name = 'exp', count = {1,2}, percent = 50, x2 = true},
                { name = 'oc_coin', count = {1,2}, percent = 5, x2 = false},
                -- { name = 'gacha_farm', count = {1,2}, percent = 5, x2 = false},
            },
        },
        ['treasure'] = {
            Coords = vector3(729.2716, 3943.5093, 6.8712),
            Blips = {
                enable = true,			-- เปิด true / ปิด false | แสดง Blips บนแผนที่
                Text = '[FARM] TREASURE',   -- Text ใน Blip
                Sprite = 137,			-- id | รูปลักษณ์
                Color = 0,				-- สี
                Scale = 1.2,			-- ขนาด
            },
            ShowMarkerArea = {        
                Show = false,         -- เปิดวงเลี้ยงสัตว์หรือไม่ ถ้าหากเปิดจะเพิ่มการทำงานของสคริป 0.02
                MakerDistance = 70.0, -- ระยะมองเห็นวง
                MakerConfig = { type = 28,  r = 12, g = 128, b = 236, alpha = 100, }, 
            },

            Distance = { -- ระยะต่างๆ
                Pickup = 3.50, -- ระยะในการเก็บตอนอยู่ใกล้ Prop งาน
                Inzone = 25.0, -- เมื่ออยู่ในระยะนี้จะขึ้น Ui 
            },

            Progress = 4, -- เวลาในการทำงาน 4 = 4 วิ
            Equipment = false, -- เช็คบัตรทำงานไหม หากใช้ให้ใส่แบบนี้ Equipment = 'stone_b',

            MultiplyItem = { -- ไอเทมคุณ 2 ใส่ได้หลายอัน
                -- ['work_x2'] = 2,
            },

            Animation = { 
                dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                anim = "machinic_loop_mechandplayer",
                flag = 1
            },
            Prop = {
                enable = false,			-- เปิด true / ปิด false | เปิดใช้งาน Prop ในมือผู้เล่น
                model = "prop_tool_pickaxe", -- Model Prop 
                bone = 57005,  -- กระดูกของมือ
                coords = { x = 0.05, y = 0.0, z = 0.0 },  -- ปรับค่าตำแหน่งให้ใกล้มือมากขึ้น
                rotation = { x = -70.0, y = 0.10, z = 0.0 }   -- หมุน pickaxe ให้อยู่ในท่าจับที่เหมาะสม
            },                     

            Object = 'un_hope_prop_tresure', -- ชื่อ Prop ต่างๆ
            PropLimit = 6, -- จะให้ Prop เกิดกี่ตัวในงานนี้
            MinDistanceBetweenProps = 6.0, -- ระยะห่างขั้นต่ำระหว่าง prop แต่ละตัว
            SpawnRadius = 12.0, -- ระยะรัศมีในการ spawn prop จากจุดกึ่งกลาง

            Items = { -- ใส่ได้ 1 เท่านั้นสำหรับไอเทมหลัก
                { name = 'treasure', count = {1,1}},
            },

            Bonus = { -- โบนัสไอเทมใส่ได้เรื่อยๆ
                { name = 'exp', count = {1,2}, percent = 50, x2 = true},
                { name = 'oc_coin', count = {1,2}, percent = 5, x2 = false},
                -- { name = 'gacha_farm', count = {1,2}, percent = 5, x2 = false},
            },
        },
        
    },
}