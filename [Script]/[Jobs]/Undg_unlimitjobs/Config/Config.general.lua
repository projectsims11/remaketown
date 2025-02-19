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
                Text = '[FARM] STONE',   -- Text ใน Blip
                Sprite = 1,			-- id | รูปลักษณ์
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

            Progress = 2, -- เวลาในการทำงาน 4 = 4 วิ
            Equipment = false, -- เช็คบัตรทำงานไหม หากใช้ให้ใส่แบบนี้ Equipment = 'stone_b',
            AutoFarm = 'jobcard', -- บัตรออโต้ฟาร์ม

            MultiplyItem = { -- ไอเทมคุณ 2 ใส่ได้หลายอัน
                -- ['work_x2'] = 2,
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
                { name = 'exp', count = {1,2}, percent = 75, x2 = false},
                -- { name = 'oc_coin', count = {1,2}, percent = 5, x2 = false},
                -- { name = 'gacha_farm', count = {1,2}, percent = 5, x2 = false},
            },
        },
        ['wood'] = {
            Coords = vector3(-842.3062, 5805.7642, 5.3092),
            Blips = {
                enable = true,			-- เปิด true / ปิด false | แสดง Blips บนแผนที่
                Text = '[FARM] WOOD',   -- Text ใน Bwawlip
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

            Progress = 2, -- เวลาในการทำงาน 4 = 4 วิ
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

            Object = 'likemod_log_anim_props', -- ชื่อ Prop ต่างๆ
            PropLimit = 6, -- จะให้ Prop เกิดกี่ตัวในงานนี้
            MinDistanceBetweenProps = 6.0, -- ระยะห่างขั้นต่ำระหว่าง prop แต่ละตัว
            SpawnRadius = 12.0, -- ระยะรัศมีในการ spawn prop จากจุดกึ่งกลาง

            Items = { -- ใส่ได้ 1 เท่านั้นสำหรับไอเทมหลัก
                { name = 'wood', count = {1,2}},
            },

            Bonus = { -- โบนัสไอเทมใส่ได้เรื่อยๆ
                { name = 'exp', count = {1,2}, percent = 75, x2 = false},
                -- { name = 'gacha_farm', count = {1,2}, percent = 5, x2 = false},
            },
        },
        ['orange'] = {
            Coords = vector3(337.0147,3571.4290,33.3405-1), 
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

            Progress = 2, -- เวลาในการทำงาน 4 = 4 วิ
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
                { name = 'carrot', count = {1,2}},
            },

            Bonus = { -- โบนัสไอเทมใส่ได้เรื่อยๆ
                { name = 'exp', count = {1,2}, percent = 75, x2 = false},
                { name = 'oc_coin', count = {1,2}, percent = 5, x2 = false},
                -- { name = 'gacha_farm', count = {1,2}, percent = 5, x2 = false},
            },
        },
        ['wheat'] = {
            Coords = vector3(570.5230, 6486.4790, 30.6890),
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

            Progress = 2, -- เวลาในการทำงาน 4 = 4 วิ
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
                { name = 'honey', count = {1,2}},
            },

            Bonus = { -- โบนัสไอเทมใส่ได้เรื่อยๆ
                { name = 'exp', count = {1,2}, percent = 75, x2 = false},
                { name = 'oc_coin', count = {1,2}, percent = 5, x2 = false},
                -- { name = 'gacha_farm', count = {1,2}, percent = 5, x2 = false},
            },
        },
        ['rice'] = {
            Coords = vector3(-693.9963, 6076.7842, 2.6592),
            Blips = {
                enable = true,			-- เปิด true / ปิด false | แสดง Blips บนแผนที่
                Text = '[FARM] RICE',   -- Text ใน Blip
                Sprite = 60,			-- id | รูปลักษณ์
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

            Progress = 2, -- เวลาในการทำงาน 4 = 4 วิ
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
                { name = 'pumpkin', count = {1,2}},
            },

            Bonus = { -- โบนัสไอเทมใส่ได้เรื่อยๆ
                { name = 'exp', count = {1,2}, percent = 75, x2 = false},
                { name = 'oc_coin', count = {1,2}, percent = 5, x2 = false},
                -- { name = 'gacha_farm', count = {1,2}, percent = 5, x2 = false},
            },
        },
        
        ['wood'] = {
            Coords = vector3(-1633.8253, 4737.3867, 53.2419),
            Blips = {
                enable = true,			-- เปิด true / ปิด false | แสดง Blips บนแผนที่
                Text = '[FARM] WOOD',   -- Text ใน Blip
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

            Progress = 2, -- เวลาในการทำงาน 4 = 4 วิ
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

            Object = 'un_hope_prop_log', -- ชื่อ Prop ต่างๆ
            PropLimit = 6, -- จะให้ Prop เกิดกี่ตัวในงานนี้
            MinDistanceBetweenProps = 6.0, -- ระยะห่างขั้นต่ำระหว่าง prop แต่ละตัว
            SpawnRadius = 12.0, -- ระยะรัศมีในการ spawn prop จากจุดกึ่งกลาง

            Items = { -- ใส่ได้ 1 เท่านั้นสำหรับไอเทมหลัก
                { name = 'strawberry', count = {1,2}},
            },

            Bonus = { -- โบนัสไอเทมใส่ได้เรื่อยๆ
                { name = 'exp', count = {1,2}, percent = 75, x2 = false},
                { name = 'oc_coin', count = {1,2}, percent = 5, x2 = false},
                -- { name = 'gacha_farm', count = {1,2}, percent = 5, x2 = false},
            },
        },
        ['Cabbage'] = {
            Coords = vector3(-3105.2300, 3241.9221, 2.0250),
            Blips = {
                enable = true,			-- เปิด true / ปิด false | แสดง Blips บนแผนที่
                Text = '[FARM] CABBAGE',   -- Text ใน Blip
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
                Pickup = 2.20, -- ระยะในการเก็บตอนอยู่ใกล้ Prop งาน
                Inzone = 25.0, -- เมื่ออยู่ในระยะนี้จะขึ้น Ui 
            },

            Progress = 2, -- เวลาในการทำงาน 4 = 4 วิ
            Equipment = false, -- เช็คบัตรทำงานไหม หากใช้ให้ใส่แบบนี้ Equipment = 'stone_b',
            AutoFarm = 'jobcard', -- บัตรออโต้ฟาร์ม

            MultiplyItem = { -- ไอเทมคุณ 2 ใส่ได้หลายอัน
                -- ['work_x2'] = 2,
            },

            Animation = { 
                dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                anim = "machinic_loop_mechandplayer",
            
            },
            Prop = {
                enable = false,			-- เปิด true / ปิด false | เปิดใช้งาน Prop ในมือผู้เล่น
                model = "prop_weld_torch", -- Model Prop 
                bone = 57005,  -- กระดูกของมือ
                coords = { x = 0.05, y = 0.0, z = 0.0 },  -- ปรับค่าตำแหน่งให้ใกล้มือมากขึ้น
                rotation = { x = -70.0, y = 0.10, z = 0.0 }   -- หมุน pickaxe ให้อยู่ในท่าจับที่เหมาะสม
            },                     

            Object = 'un_hope_prop_cabbage', -- ชื่อ Prop ต่างๆ
            PropLimit = 6, -- จะให้ Prop เกิดกี่ตัวในงานนี้
            MinDistanceBetweenProps = 6.0, -- ระยะห่างขั้นต่ำระหว่าง prop แต่ละตัว
            SpawnRadius = 12.0, -- ระยะรัศมีในการ spawn prop จากจุดกึ่งกลาง

            Items = { -- ใส่ได้ 1 เท่านั้นสำหรับไอเทมหลัก
                { name = 'steel', count = {1,2}},
            },

            Bonus = { -- โบนัสไอเทมใส่ได้เรื่อยๆ
                { name = 'exp', count = {1,2}, percent = 75, x2 = false},
                -- { name = 'oc_coin', count = {1,2}, percent = 5, x2 = false},
                -- { name = 'gacha_farm', count = {1,2}, percent = 5, x2 = false},
            },
        },
        ['chamomile'] = {
            Coords = vector3(3285.7952, 5157.5752, 18.6212),
            Blips = {
                enable = true,			-- เปิด true / ปิด false | แสดง Blips บนแผนที่
                Text = '[FARM] CHAMOMILE',   -- Text ใน Blip
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

            Progress = 2, -- เวลาในการทำงาน 4 = 4 วิ
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

            Object = 'vip_sunflower_cut', -- ชื่อ Prop ต่างๆ
            PropLimit = 6, -- จะให้ Prop เกิดกี่ตัวในงานนี้
            MinDistanceBetweenProps = 6.0, -- ระยะห่างขั้นต่ำระหว่าง prop แต่ละตัว
            SpawnRadius = 12.0, -- ระยะรัศมีในการ spawn prop จากจุดกึ่งกลาง

            Items = { -- ใส่ได้ 1 เท่านั้นสำหรับไอเทมหลัก
                { name = 'chamomile', count = {1,2}},
            },

            Bonus = { -- โบนัสไอเทมใส่ได้เรื่อยๆ
                { name = 'exp', count = {1,2}, percent = 75, x2 = false},
                { name = 'oc_coin', count = {1,2}, percent = 5, x2 = false},
                -- { name = 'gacha_farm', count = {1,2}, percent = 5, x2 = false},
            },
        },

        ['COKE'] = {
            Coords = vector3(1395.0571, 3613.9897, 34.9809),
            Blips = {
                enable = false,			-- เปิด true / ปิด false | แสดง Blips บนแผนที่
                Text = '[FARM] COKE',   -- Text ใน Blip
                Sprite = 424,			-- id | รูปลักษณ์
                Color = 0,				-- สี
                Scale = 1.2,			-- ขนาด
            },
            ShowMarkerArea = {        
                Show = false,         -- เปิดวงเลี้ยงสัตว์หรือไม่ ถ้าหากเปิดจะเพิ่มการทำงานของสคริป 0.02
                MakerDistance = 1.0, -- ระยะมองเห็นวง
                MakerConfig = { type = 28,  r = 12, g = 128, b = 236, alpha = 100, }, 
            },

            Distance = { -- ระยะต่างๆ
                Pickup = 1.20, -- ระยะในการเก็บตอนอยู่ใกล้ Prop งาน
                Inzone = 1.0, -- เมื่ออยู่ในระยะนี้จะขึ้น Ui 
            },

            Progress = 2, -- เวลาในการทำงาน 4 = 4 วิ
            Equipment = false, -- เช็คบัตรทำงานไหม หากใช้ให้ใส่แบบนี้ Equipment = 'stone_b',
            AutoFarm = 'weed_a', -- บัตรออโต้ฟาร์ม

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

            Object = 'prop_cs_heist_bag_02', -- ชื่อ Prop ต่างๆ
            PropLimit = 1, -- จะให้ Prop เกิดกี่ตัวในงานนี้
            MinDistanceBetweenProps = 6.0, -- ระยะห่างขั้นต่ำระหว่าง prop แต่ละตัว
            SpawnRadius = 0.1, -- ระยะรัศมีในการ spawn prop จากจุดกึ่งกลาง

            Items = { -- ใส่ได้ 1 เท่านั้นสำหรับไอเทมหลัก
                { name = 'cocaine_a', count = {1,2}},
            },

            Bonus = { -- โบนัสไอเทมใส่ได้เรื่อยๆ
                -- { name = 'exp', count = {1,2}, percent = 75, x2 = false},
                -- { name = 'oc_coin', count = {1,2}, percent = 5, x2 = false},
                -- -- { name = 'gacha_farm', count = {1,2}, percent = 5, x2 = false},
            },
        },
    },
}