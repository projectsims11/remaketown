Config = {}

Config.Default = {

    Extended = {
        ['Verion'] = true,	-- สูงกว่า 1.6.0 + = true | ต่ำกว่า 1.6.0 = false
        ['Base'] = '1.2', -- 1.1 จะใช้เช็คไอเทมแบบ item.limit | 1.2 จะใช้เช็คไอเทมแบบ canCarryItem
        ['UserLicense'] = 'Undg_5e8t7dt6irlembl3bo39', -- KEY USER https://discord.gg/k2DVyt5a
        ['getSharedObject'] = 'esx:getSharedObject', -- หากใช้ตรงนี้แนะนำให้ปรับ ['Verion'] = false,
        ['setAccountMoney'] = 'esx:setAccountMoney',
        ['addInventoryItem'] = 'esx:addInventoryItem',
        ['removeInventoryItem'] = 'esx:removeInventoryItem',
        ['setJob'] = 'esx:setJob',
        ['onPlayerDeath'] = 'esx:onPlayerDeath',
        ['onPlayerLoaded'] = 'esx:playerLoaded',
        ['Img-Inventory'] = 'nui://Fewthz_inventory/html/img/items/',

        ['Event'] = 'noevent', -- หากใช้ noevent แล้วไม่ได้รับไอเทมหลังเลี้ยงเสร็จ ให้เปลี่ยนเป็น none ทันที
    },
    
    Manage = {
        Keyboard = {'E', false}, -- ถ้าใช้เป็น KeyMapping ให้ใส่ค้างหลังเป็น false ข้างหน้าเป็น ปุ่มที่จะใช้กด | ถ้าหากจะใช้เป็นกดไอเทมเพื่อเปิดเมนู ใส่ตรงตัว E เป็นชื่อไอเทมและ ข้างหลังเป็น true 
        SpawnPointsInPlayer = false, -- หากปรับเป็น true สัตว์เลี้ยงจะออกมาตรงที่ผู้เล่นยืน หากเป็น false จะอิงจากจุด  Coords = ที่เซ็ตใน Animals
        SpawnMax = 5,               -- สามารถเลี้ยงสัตว์ได้กี่ตัว

        Vip = { -- ถ้าอยากให้คนทั่วไปใช้ Auto ได้ ปรับแบบนี้ Vip = nil,
            [1] = {
                Item = 'vip_3day', -- ชื่อไอเทม Vip
                Spawn = 10,     -- สามารถเลี้ยงสัตว์ได้กี่ตัว
                Auto = true,    -- สามารถเลี้ยง Auto ได้ไหม
            },
        },
    },

    Animals = {
        [1] = {
            Zone = 'Pig',     -- ชื่อโซนเลี้ยงสัตว์         
            Icon = 'pig.png', -- รูป Icon อิงจากไฟล์ Img ภายในสคริป
            Ped = 'a_c_pig',  -- ชื่อ Ped ในการ Spawn
            Blips = {
                enable = true,			-- เปิด true / ปิด false | แสดง Blips บนแผนที่
                Text = '[FARM] Pigs',   -- Text ใน Blip
                Sprite = 606,			-- id | รูปลักษณ์
                Color = 45,				-- สี
                Scale = 1.2,			-- ขนาด
            },
            Price = 500,      -- ราคาในการซื้อ
            Coords = vector3(2378.9563, 5053.0083, 46.4446),
            Distance = 20.0,  -- ระยะในการเปิดเมนู
            AllowJob = false,

            Growth = 1800,                 -- เป็นค่าหลอดการเติบโตหากปรับเป็น 100 แล้ว Growspeed = 1 Loop จะเพิ่มทีละ 1 จนครบ 100 ถึงจะเก็บได้
            Growspeed = 1,                -- เติบโตทีละกี่เปอร์เซ็นต์ แนะนำเป็น 1 ไม่งั้นเวลาจะไม่ตรง
            Feed = {360, 720, 1080, 1440, 1710},  -- หากสัตว์เลี้ยงโตถึง 5 หรือ 20 จะต้องให้อาหาร
            Dead = 30,                    -- หากไม่ให้อาหารภายใน 10 วิสัตว์เลี้ยงจะตาย

            itemFeed = 'food_pig', -- ไอเทมอาหารสัตว์เลี้ยง
            Items = {
                { name = 'pig_meat', count = 1, percent = 100 },
                { name = 'pig_skin', count = 1, percent = 30 },
            },
            ShowMarkerArea = {        
                Show = false,         -- เปิดวงเลี้ยงสัตว์หรือไม่ ถ้าหากเปิดจะเพิ่มการทำงานของสคริป 0.02
                MakerDistance = 50.0, -- ระยะมองเห็นวง
                MakerConfig = { type = 28, r = 250, g = 163, b = 25, alpha = 100, }, 
            },
        },

    },

}
