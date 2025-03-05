Config = {}

Config.Default = {

    Extended = {
        ['Verion'] = true,	-- สูงกว่า 1.6.0 + = true | ต่ำกว่า 1.6.0 = false
        ['Base'] = '1.2', -- 1.1 จะใช้เช็คไอเทมแบบ item.limit | 1.2 จะใช้เช็คไอเทมแบบ canCarryItem
        ['UserLicense'] = 'Undg_xpxp8u5o5hena5rytmx4', -- KEY USER https://discord.gg/k2DVyt5a
        ['onPlayerSpawn'] = 'playerSpawned',
        ['onPlayerDeath'] = 'esx:onPlayerDeath',
        ['onPlayerLoaded'] = 'esx:playerLoaded',
        ['Img-Inventory'] = 'nui://Fewthz_inventory/html/img/items/',
        ['Cancel-Procressbar'] = 'mythic_progbar:client:cancel',
        ['Event'] = 'noevent', -- หากใช้ noevent แล้วไม่ได้รับไอเทมหลังเลี้ยงเสร็จ ให้เปลี่ยนเป็น none ทันที
    },
    
    Key = 'F4',
    CloseUiairdrop = 'J',
    Group = 'admin',

    Command = 'airdrop',
    ExitAirdrop = 'exitairdrop',

    DeleteAirdrops = 1800, -- เวลาครุมทุกอย่าง หากไม่มีคนเก็บแอร์ดรอปรึตีกันไม่เสร็จ เวลานี้หมดจะลบแอร์ดรอปทุกลูกทันที | เป็นวินาที
    -- Progress = 60, -- เวลาในการเก็บ
    Progress = 60, -- เวลาในการเก็บ

    Radiu = { -- ตั้งค่าเกี่ยวกับวง
        MakerConfig = { type = 28, r = 12, g = 128, b = 236, alpha = 100, }, -- สีของวง
        Delete = 0.17, -- จะให้วงลดทีละเท่าไหร่ ยิ่งใส่เยอะจะลดไวและกดพื้นที่ตอนลดมาก 
        LastCircle = 10.0, -- ระยะวงสุดท้าย เมื่อถึงระยะ 5.0 วงจะหยุดบีบ

        Bypass = { -- สำหรับ admin เท่านั้น !
            ['steam:11000013ca30d29'], 
        },
    },
    Airdrop = {


        [1] = {
            Name = 'ห้ามเข้า', -- ชื่อ Airdrop
            Prop = 'likemod_gyroscope_anim_props', 
            Coords = vector3(-3879.6855, -670.8354, 1352.9934),
            Auto = {"03:11"},
            Prepare = 60, -- เวลาตอนเริ่ม Airdrop หากเวลา Prepare หมดจะไม่เข้าร่วม Airdrop ได้ | เป็นวินาที
            Start = 10, -- หากเวลา Start หมดวงจะเริ่มบีบทันที | เป็นวินาที

            -- Prepare = 30, -- เวลาตอนเริ่ม Airdrop หากเวลา Prepare หมดจะไม่เข้าร่วม Airdrop ได้ | เป็นวินาที
            -- Start = 10, -- หากเวลา Start หมดวงจะเริ่มบีบทันที | เป็นวินาที

            Radius = 60.0, -- ระยะวงกลม
            TypeBox = 'teleport',
            MaxPlayer = 100,
            AllowJob = {
                ['unemployed'],
                ['police']
            },
            CheckItem = { -- หากไม่ใช้ Checkitem ให้ปรับเป็น CheckItem = false,
               ['phone'],
             },
            CheckItem = false,
            Items = {
                ['cement'] = 1,
                ['gacha_caps'] = 1,
                ['armor'] = 1,
                ['aed'] = 1,
                ['promethazine'] = 1,
                ['bandage'] = 1,
                ['black_money'] = 1,
                ['event_coin'] = 1,
            },
            ParticipationRewards = {
                ['bandage'] = 1,
                ['aed'] = 1,
                ['armor'] = 1,
                ['event_coin'] = 1,
            },
            Givethesameitemtothejob = false, -- ถ้าผู้เล่นที่เก็บเป็น job police ทุกคนที่เป็น job เดียวกันจะได้ไอเทมด้วยไหม ไม่ใช้ ปรับเป็น false
            Ui = { -- เปลี่ยนรูปกล่อง Airdrop แต่ละกล่อง 
                Alert = { -- ตอนแอร์ดรอปขึ้น
                    Img = 'box.png',
                },
                Menu = { -- ตอนเปิดเมนูแอร์ดรอป หากใส่แค่ Img(รูปภาพ) ให้ลบ Icon ออก ** หากใส่ 2 อัน จะจับ Icon แทน
                    Img = 'box.png',
                    Icon = 'fa-solid fa-parachute-box', -- https://fontawesome.com/icons
                },
            },
            Revive = true,
            DrawMarker = true,
        },






        -- [1] = {
        --     Name = 'Citizen', -- ชื่อ Airdrop
        --     Prop = 'prop_mb_cargo_04a', 
        --     Coords = vector3(-402.4238, 1207.0151, 325.9417),
        --     Auto = {"15:30","22:30"}, 
        --     Prepare = 600, -- เวลาตอนเริ่ม Airdrop หากเวลา Prepare หมดจะไม่เข้าร่วม Airdrop ได้ | เป็นวินาที
        --     Start = 180, -- หากเวลา Start หมดวงจะเริ่มบีบทันที | เป็นวินาที

        --     -- Prepare = 30, -- เวลาตอนเริ่ม Airdrop หากเวลา Prepare หมดจะไม่เข้าร่วม Airdrop ได้ | เป็นวินาที
        --     -- Start = 10, -- หากเวลา Start หมดวงจะเริ่มบีบทันที | เป็นวินาที

        --     Radius = 60.0, -- ระยะวงกลม
        --     TypeBox = 'teleport',
        --     MaxPlayer = 100,
        --     AllowJob = {
        --         ['unemployed'],
        --         ['police']
        --     },
        --     --[[CheckItem = { -- หากไม่ใช้ Checkitem ให้ปรับเป็น CheckItem = false,
        --         ['phone'],
        --     },]]--
        --     CheckItem = false,
        --     Items = {
        --         ['cement'] = 7,
        --         ['gacha_caps'] = 2,
        --         ['armor'] = 10,
        --         ['aed'] = 5,
        --         ['promethazine'] = 1,
        --         ['bandage'] = 15,
        --         ['black_money'] = 1000,
        --         ['event_coin'] = 3,
        --     },
        --     ParticipationRewards = {
        --         ['bandage'] = 5,
        --         ['aed'] = 3,
        --         ['armor'] = 5,
        --         ['event_coin'] = 1,
        --     },
        --     Givethesameitemtothejob = false, -- ถ้าผู้เล่นที่เก็บเป็น job police ทุกคนที่เป็น job เดียวกันจะได้ไอเทมด้วยไหม ไม่ใช้ ปรับเป็น false
        --     Ui = { -- เปลี่ยนรูปกล่อง Airdrop แต่ละกล่อง 
        --         Alert = { -- ตอนแอร์ดรอปขึ้น
        --             Img = 'box.png',
        --         },
        --         Menu = { -- ตอนเปิดเมนูแอร์ดรอป หากใส่แค่ Img(รูปภาพ) ให้ลบ Icon ออก ** หากใส่ 2 อัน จะจับ Icon แทน
        --             Img = 'box.png',
        --             Icon = 'fa-solid fa-parachute-box', -- https://fontawesome.com/icons
        --         },
        --     },
        --     Revive = true,
        --     DrawMarker = true,
        -- },

        -- [2] = {
        --     Name = 'Family',
        --     Prop = 'prop_mb_cargo_04a',
        --     Coords = vector3(2227.64, 2285.72, 32.68),
        --     Auto = {"15:30","21:30"}, 
        --     Prepare = 600, -- เวลาตอนเริ่ม Airdrop หากเวลา Prepare หมดจะไม่เข้าร่วม Airdrop ได้ | เป็นวินาที
        --     Start = 180, -- หากเวลา Start หมดวงจะเริ่มบีบทันที | เป็นวินาที
        --     Radius = 60.0, -- ระยะวงกลม
        --     TypeBox = 'teleport',
        --     MaxPlayer = 100,
        --     AllowJob = {  -- จำเป็นต้องใช้ห้ามลบ
        --         ['unemployed'], 
        --     },
        --     CheckItem = { -- หากไม่ใช้ Checkitem ให้ปรับเป็น CheckItem = false,
        --         ['familly_card'],
        --      },
        --     Items = {
        --         ['cement'] = 10,
        --         ['gacha_caps'] = 3,
        --         ['armor_pack'] = 2,
        --         ['aed_pack'] = 2,
        --         ['promethazine'] = 3,
        --         ['painkiller_pack'] = 2,
        --         ['black_money'] = 1500,
        --         ['event_coin'] = 5,
        --     },
        --     ParticipationRewards = {
        --         ['painkiller'] = 10,
        --         ['aed'] = 5,
        --         ['armor'] = 5,
        --         ['event_coin'] = 1,
        --     },
        --     Givethesameitemtothejob = false, -- ถ้าผู้เล่นที่เก็บเป็น job police ทุกคนที่เป็น job เดียวกันจะได้ไอเทมด้วยไหม ไม่ใช้ปรับเป็น false
        --     Ui = { -- เปลี่ยนรูปกล่อง Airdrop แต่ละกล่อง 
        --         Alert = { -- ตอนแอร์ดรอปขึ้น
        --             Img = 'box.png',
        --         },
        --         Menu = { -- ตอนเปิดเมนูแอร์ดรอป หากใส่แค่ Img(รูปภาพ) ให้ลบ Icon ออก ** หากใส่ 2 อัน จะจับ Icon แทน
        --             Img = 'box.png',
        --             Icon = 'fa-solid fa-parachute-box', -- https://fontawesome.com/icons
        --         },
        --     },
        --     Revive = true,
        --     DrawMarker = true,
        -- },

        -- [3] = {
        --     Name = 'Gang Tier 1',
        --     Coords = vector3(-2616.88, 3210.44, 32.8),
        --     Auto = {"15:30","21:30"}, 
        --     Prop = 'prop_mb_cargo_04a',
        --     Prepare = 600, -- เวลาตอนเริ่ม Airdrop หากเวลา Prepare หมดจะไม่เข้าร่วม Airdrop ได้ | เป็นวินาที
        --     Start = 300, -- หากเวลา Start หมดวงจะเริ่มบีบทันที | เป็นวินาที
        --     Radius = 60.0, -- ระยะวงกลม
        --     TypeBox = 'teleport',
        --     MaxPlayer = 100,
        --     AllowJob = { -- จำเป็นต้องใช้ห้ามลบ
        --         ['unemployed'],
        --     },
        --     CheckItem = { -- หากไม่ใช้ Checkitem ให้ปรับเป็น CheckItem = false,
        --         ['gang_card'],
        --     },
        --     Items = {
        --         ['cement'] = 15,
        --         ['gacha_caps'] = 6,
        --         ['armor_pack'] = 4,
        --         ['aed_pack'] = 4,
        --         ['promethazine'] = 5,
        --         ['painkiller_pack'] = 4,
        --         ['black_money'] = 2000,
        --         ['event_coin'] = 10,
        --     },
        --     ParticipationRewards = {
        --         ['painkiller'] = 10,
        --         ['aed'] = 5,
        --         ['armor'] = 5,
        --         ['event_coin'] = 1,
        --     },
        --     Givethesameitemtothejob = false, -- ถ้าผู้เล่นที่เก็บเป็น job police ทุกคนที่เป็น job เดียวกันจะได้ไอเทมด้วยไหม ไม่ใช้ปรับเป็น false
        --     Ui = { -- เปลี่ยนรูปกล่อง Airdrop แต่ละกล่อง 
        --         Alert = { -- ตอนแอร์ดรอปขึ้น
        --             Img = 'box.png',
        --         },
        --         Menu = { -- ตอนเปิดเมนูแอร์ดรอป หากใส่แค่ Img(รูปภาพ) ให้ลบ Icon ออก ** หากใส่ 2 อัน จะจับ Icon แทน
        --             Img = 'box.png',
        --             Icon = 'fa-solid fa-parachute-box', -- https://fontawesome.com/icons
        --         },
        --     },
        --     Revive = true,
        --     DrawMarker = true,
        -- },
        -- [4] = {
        --     Name = 'Agency',
        --     Coords = vector3(-2616.88, 3210.44, 32.8),
        --     Auto = {"23.00"}, 
        --     Prop = 'prop_mb_cargo_04a',
        --     Prepare = 600, -- เวลาตอนเริ่ม Airdrop หากเวลา Prepare หมดจะไม่เข้าร่วม Airdrop ได้ | เป็นวินาที
        --     Start = 300, -- หากเวลา Start หมดวงจะเริ่มบีบทันที | เป็นวินาที
        --     Radius = 60.0, -- ระยะวงกลม
        --     TypeBox = 'teleport',
        --     MaxPlayer = 100,
        --     AllowJob = { -- จำเป็นต้องใช้ห้ามลบ
        --         ['unemployed'], -- ยังไม่ได้ set
        --     },
        --     CheckItem = false,
        --     Items = {
        --         ['cement'] = 10,
        --         ['uranium'] = 2,
        --         ['event_coin'] = 20,
        --     },
        --     ParticipationRewards = {
        --         ['bandage'] = 10,
        --         ['aed'] = 5,
        --         ['armor'] = 5,
        --         ['event_coin'] = 10,
        --     },
        --     Givethesameitemtothejob = true, -- ถ้าผู้เล่นที่เก็บเป็น job police ทุกคนที่เป็น job เดียวกันจะได้ไอเทมด้วยไหม ไม่ใช้ปรับเป็น false
        --     Ui = { -- เปลี่ยนรูปกล่อง Airdrop แต่ละกล่อง 
        --         Alert = { -- ตอนแอร์ดรอปขึ้น
        --             Img = 'box.png',
        --         },
        --         Menu = { -- ตอนเปิดเมนูแอร์ดรอป หากใส่แค่ Img(รูปภาพ) ให้ลบ Icon ออก ** หากใส่ 2 อัน จะจับ Icon แทน
        --             Img = 'box.png',
        --             Icon = 'fa-solid fa-parachute-box', -- https://fontawesome.com/icons
        --         },
        --     },
        --     Revive = true,
        --     DrawMarker = true,
        -- },



-- ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



        -- [4] = {
        --     Name = 'Gang Tier 2',
        --     Coords = vector3(-2139.12, 3095.6, 32.8),
        --     Auto = {"03:49","21:00"}, 
        --     Prop = 'prop_mb_cargo_04a',
        --     Prepare = 60, -- เวลาตอนเริ่ม Airdrop หากเวลา Prepare หมดจะไม่เข้าร่วม Airdrop ได้ | เป็นวินาที
        --     Start = 10, -- หากเวลา Start หมดวงจะเริ่มบีบทันที | เป็นวินาที
        --     Radius = 60.0, -- ระยะวงกลม
        --     TypeBox = 'teleport',
        --     MaxPlayer = 100,
        --     AllowJob = { -- จำเป็นต้องใช้ห้ามลบ
        --         ['unemployed'],
        --     },
        --     CheckItem = { -- หากไม่ใช้ Checkitem ให้ปรับเป็น CheckItem = false,
        --         ['phone'],
        --     },
        --     Items = {
        --         ['phone'] = 1,
        --     },
        --     ParticipationRewards = {
        --         ['stone'] = 1,
        --     },
        --     Givethesameitemtothejob = true, -- ถ้าผู้เล่นที่เก็บเป็น job police ทุกคนที่เป็น job เดียวกันจะได้ไอเทมด้วยไหม ไม่ใช้ปรับเป็น false
        --     Ui = { -- เปลี่ยนรูปกล่อง Airdrop แต่ละกล่อง 
        --         Alert = { -- ตอนแอร์ดรอปขึ้น
        --             Img = 'box.png',
        --         },
        --         Menu = { -- ตอนเปิดเมนูแอร์ดรอป หากใส่แค่ Img(รูปภาพ) ให้ลบ Icon ออก ** หากใส่ 2 อัน จะจับ Icon แทน
        --             Img = 'box.png',
        --             Icon = 'fa-solid fa-parachute-box', -- https://fontawesome.com/icons
        --         },
        --     },
        --     Revive = true,
        --     DrawMarker = true,
        -- },

        -- [5] = {
        --     Name = 'Gang Tier 3',
        --     Coords = vector3(254.96, -1555.08, 29.36),
        --     Auto = {"03:50","21:00"}, 
        --     Prop = 'prop_box_wood07a',
        --     Prepare = 10, -- เวลาตอนเริ่ม Airdrop หากเวลา Prepare หมดจะไม่เข้าร่วม Airdrop ได้ | เป็นวินาที
        --     Start = 10, -- หากเวลา Start หมดวงจะเริ่มบีบทันที | เป็นวินาที
        --     Radius = 30.0, -- ระยะวงกลม
        --     TypeBox = 'gps',
        --     MaxPlayer = 100,
        --     AllowJob = { -- จำเป็นต้องใช้ห้ามลบ
        --         ['unemployed'],
        --     },
        --     CheckItem = false,
        --     Items = {
        --         ['stone'] = 5,
        --     },
        --     ParticipationRewards = {
        --         ['stone'] = 1,
        --     },
        --     Givethesameitemtothejob = true, -- ถ้าผู้เล่นที่เก็บเป็น job police ทุกคนที่เป็น job เดียวกันจะได้ไอเทมด้วยไหม ไม่ใช้ปรับเป็น false
        --     Ui = { -- เปลี่ยนรูปกล่อง Airdrop แต่ละกล่อง 
        --         Alert = { -- ตอนแอร์ดรอปขึ้น
        --             Img = 'box.png',
        --         },
        --         Menu = { -- ตอนเปิดเมนูแอร์ดรอป หากใส่แค่ Img(รูปภาพ) ให้ลบ Icon ออก ** หากใส่ 2 อัน จะจับ Icon แทน
        --             Img = 'box.png',
        --             Icon = 'fa-solid fa-parachute-box', -- https://fontawesome.com/icons
        --         },
        --     },
        --     Revive = true,
        --     DrawMarker = true,
        -- },
    },

}
