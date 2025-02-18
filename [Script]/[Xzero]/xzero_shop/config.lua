Config_xZC_Shop = {}

-- Base Extended
Config_xZC_Shop.Base = {
    getSharedObject = 'esx:getSharedObject',
    setJob = 'esx:setJob'
}

------------------------------ Config Settings
Config_xZC_Shop.URL_Images = "nui://Fewthz_inventory/html/img/items/" -- ที่อยู่ของรูปภาพไอเทม (กำหนดตามสคิปกระเป๋าที่ใช้อยู่)
Config_xZC_Shop.ESX_CheckWeight = false -- สำหรับ es_extended ตัวใหม่และใช้งานระบบน้ำหนักสามารถคั้งค่า true เปิดใช้งานได้

------------------------------- Default
Config_xZC_Shop.Default = {
    limit = 10,
    item_type = "item_standard",
    price_account_name = "money",

    -- Blip
    Blip = {
        Sprite = 52,
        Colour = 25,
        Scale = 0.4
    },
    -- Marker
    Marker = {
        Distance = 30,
        Type = 1,
        Size = { x = 1.5, y = 1.5, z = 1.5 },
        Color = { r = 0, g = 128, b = 255 }
    }
}

-------------------------------- Zones กำหนดสร้างร้านซื้อไอเทม
Config_xZC_Shop.Zones = {
    {
        Name = "General Shop", -- กำหนดชื่ออ้างอิงตั้งอะไรก็ได้ (ภาษาอังกฤษเท่านั้น, แนะนำอย่าซ้ำกับชื่อร้านอื่น)
        Label = "ร้านค้าสัตว์", -- ชื่อร้านเวลาแสดงตอนเปิดหน้าซื้อไอเทมตามใจสามารถตั้งซ้ำได้ (สามารถใช้ภาษาไทยได้)
        Job = { 
            -- กำหนดอาชีพที่จะให้ซื้อในร้านนี้ได้เท่านั้น (ถ้าจะให้ซื้อได้ทุกคนไม่ต้องใส่อะไร)
			--"police",
			--"ambulance"
        }, 
        ItemsRequire = {
            -- กำหมดชื่อไอเทมที่ต้องมีในตัวก่อนถึงจะสามารถเปิดร้านได้
            --"phone",
            --"credit"
        },
        Items = {  -- สร้างรายการไอเทมในร้าน (ข้อมูลไอเทมจะอ้างอิงจาก database items)
            {
                name = "Pig",
                --label = "ขนมปัง", -- กำหนดชื่อไอเทมที่แสดงในร้านค้า (ถ้าไม่ใส่จะกำหนดตามข้อมูลใน database items)
                price = 200
            },
            {
                name = "Cow",
                --label = "ขนมปัง", -- กำหนดชื่อไอเทมที่แสดงในร้านค้า (ถ้าไม่ใส่จะกำหนดตามข้อมูลใน database items)
                price = 200
            },
            {
                name = "foodPig",
                --label = "ขนมปัง", -- กำหนดชื่อไอเทมที่แสดงในร้านค้า (ถ้าไม่ใส่จะกำหนดตามข้อมูลใน database items)
                price = 200
            },
            {
                name = "foodCow",
                --label = "ขนมปัง", -- กำหนดชื่อไอเทมที่แสดงในร้านค้า (ถ้าไม่ใส่จะกำหนดตามข้อมูลใน database items)
                price = 200
            },
        },
        ItemsInclude = { }, -- ดึงรายไอเทมที่เราสร้างเซ็ทไอเทมไว้มาลงในร้านนี้
        Blip = { -- Blip Map
			-- ประเภทของ Blip ดูจากได้ https://wiki.rage.mp/index.php?title=Blips
            Show = true, -- true = แสดง Blip ใน Map (ถ้า false = ไม่แสดง)
            Name = '<font face="sarabun">ร้านค้าสัตว์</font>', -- ชื่อ Blip ใน Map
            Sprite = 52, -- รูป Blip
            Colour = 8, -- สี Blip
            Scale = 0.8 -- ขนาด Blip
        },
        Marker = { -- Marker
            -- ประเภท Marker ดูได้จาก https://docs.fivem.net/docs/game-references/markers/
            Show = true, -- true = แสดง Marker (false = ไม่แสดง)
            Type = 29, -- ประเภท Marker
            Size = { x = 1.5, y = 1.5, z = 1.5 }, -- ขนาด Marker
			Color = { r = 0, g = 128, b = 255 }, -- สี Marker
            Pos_Z_up = 1.0, -- จะกำหนดให้สูงจากตำแหน่งเดิมเท่าไหร่ (เอาไว้กรณีมันจมลงไปในพื้นสามารถเพิ่มค่าตรงนี้ได้)
            Pos_Z_down = 0 -- จะกำหนดให้ต่ำจากตำแหน่งเดิมเท่าไหร่
        },
        Pos = { -- สร้างจุดสำหรับกดเปิดร้าน (ตำแหน่งในเกม x y z)
            {x = 562.3400268554688, y = 2741.330078125, z = 41.86999893188476},
        }
    },

    {
        Name = "General Shop", -- กำหนดชื่ออ้างอิงตั้งอะไรก็ได้ (ภาษาอังกฤษเท่านั้น, แนะนำอย่าซ้ำกับชื่อร้านอื่น)
        Label = "ร้านค้าทั่วไป", -- ชื่อร้านเวลาแสดงตอนเปิดหน้าซื้อไอเทมตามใจสามารถตั้งซ้ำได้ (สามารถใช้ภาษาไทยได้)
        Job = { 
            -- กำหนดอาชีพที่จะให้ซื้อในร้านนี้ได้เท่านั้น (ถ้าจะให้ซื้อได้ทุกคนไม่ต้องใส่อะไร)
			--"police",
			--"ambulance"
        }, 
        ItemsRequire = {
            -- กำหมดชื่อไอเทมที่ต้องมีในตัวก่อนถึงจะสามารถเปิดร้านได้
            --"phone",
            --"credit"
        },
        Items = {  -- สร้างรายการไอเทมในร้าน (ข้อมูลไอเทมจะอ้างอิงจาก database items)
            {
                name = "bread",
                label = "ขนมปัง", -- กำหนดชื่อไอเทมที่แสดงในร้านค้า (ถ้าไม่ใส่จะกำหนดตามข้อมูลใน database items)
                price = 200
            },
            {
                name = "water", -- ชื่อไอเทม
				label = "น้ำเปล่า", -- กำหนดชื่อไอเทมที่แสดงในร้านค้า (ถ้าไม่ใส่จะกำหนดตามข้อมูลใน database items)
                --item_type = "item_weapon", -- หากไอเทมเป็นประเภทอาวุธให้ใส่บรรทัดนี้เข้าไปด้วย (ถ้าไอเทมปกติไม่ต้องใส่บรรทัดนี้)
                --price_account_name = "black_money", -- หากต้องการให้ใช้เงินแดงซื้อให้ใส่บรรทัดนี้ลงไป (ถ้าเงินเขียวไม่ต้องใส่บรรทัดนี้)
                price = 200 -- ราคา
            },
            {
                name = "phone",
				label = "โทรศัพท์มือถือ", -- กำหนดชื่อไอเทมที่แสดงในร้านค้า (ถ้าไม่ใส่จะกำหนดตามข้อมูลใน database items)
                price = 5000
		    },
            {
                name = "speaker",
				label = "ลำโพง 1", -- กำหนดชื่อไอเทมที่แสดงในร้านค้า (ถ้าไม่ใส่จะกำหนดตามข้อมูลใน database items)
                price = 1500
		    },
            {
                name = "music_box_2",
				label = "ลำโพง 2", -- กำหนดชื่อไอเทมที่แสดงในร้านค้า (ถ้าไม่ใส่จะกำหนดตามข้อมูลใน database items)
                price = 1500
		    },
            {
                name = "music_box_3",
				label = "ลำโพง 3", -- กำหนดชื่อไอเทมที่แสดงในร้านค้า (ถ้าไม่ใส่จะกำหนดตามข้อมูลใน database items)
                price = 1500
		    },
            {
                name = "music_box_4",
				label = "ลำโพง 4", -- กำหนดชื่อไอเทมที่แสดงในร้านค้า (ถ้าไม่ใส่จะกำหนดตามข้อมูลใน database items)
                price = 1500
		    },
            {
                name = "music_box_5",
				label = "ลำโพง 5", -- กำหนดชื่อไอเทมที่แสดงในร้านค้า (ถ้าไม่ใส่จะกำหนดตามข้อมูลใน database items)
                price = 1500
		    },
            {
                name = "fixkit",
				label = "กล่องซ่อมรถ", -- กำหนดชื่อไอเทมที่แสดงในร้านค้า (ถ้าไม่ใส่จะกำหนดตามข้อมูลใน database items)
                price = 4000
		    },
            {
                name = "radio",
				label = "วิทยุสื่อสาร", -- กำหนดชื่อไอเทมที่แสดงในร้านค้า (ถ้าไม่ใส่จะกำหนดตามข้อมูลใน database items)
                price = 2000
		    },
            {
                name = "rag",
				--label = "ไฟแช๊ก", -- กำหนดชื่อไอเทมที่แสดงในร้านค้า (ถ้าไม่ใส่จะกำหนดตามข้อมูลใน database items)
                price = 5000
		    },
            {
                name = "wash",
				--label = "ไฟแช๊ก", -- กำหนดชื่อไอเทมที่แสดงในร้านค้า (ถ้าไม่ใส่จะกำหนดตามข้อมูลใน database items)
                price = 100
		    },
            {
                name = "contract",
				--label = "ไฟแช๊ก", -- กำหนดชื่อไอเทมที่แสดงในร้านค้า (ถ้าไม่ใส่จะกำหนดตามข้อมูลใน database items)
                price = 20000
		    },
            {
                name = "nos",
				--label = "ไฟแช๊ก", -- กำหนดชื่อไอเทมที่แสดงในร้านค้า (ถ้าไม่ใส่จะกำหนดตามข้อมูลใน database items)
                price = 50000
		    },
             {
                name = "weapon_pistol50", -- ชื่อไอเทม
                item_type = "item_weapon",
                ammo = 100, -- กระสุนที่ได้ตอนซื้อ
                price_account_name = "black_money", -- เงินแดงให้ใส่บรรทัดนี้ลงไป
                price = 1500, -- ราคา
             },
            --[[{
                name = "tuning_laptop",
				label = "กล่องจูน ECU", -- กำหนดชื่อไอเทมที่แสดงในร้านค้า (ถ้าไม่ใส่จะกำหนดตามข้อมูลใน database items)
                price = 100000
		    },--]]
        },
        ItemsInclude = { }, -- ดึงรายไอเทมที่เราสร้างเซ็ทไอเทมไว้มาลงในร้านนี้
        Blip = { -- Blip Map
			-- ประเภทของ Blip ดูจากได้ https://wiki.rage.mp/index.php?title=Blips
            Show = true, -- true = แสดง Blip ใน Map (ถ้า false = ไม่แสดง)
            Name = '<font face="sarabun">ร้านขายของชำ</font>', -- ชื่อ Blip ใน Map
            Sprite = 52, -- รูป Blip
            Colour = 43, -- สี Blip
            Scale = 0.4 -- ขนาด Blip
        },
        Marker = { -- Marker
            -- ประเภท Marker ดูได้จาก https://docs.fivem.net/docs/game-references/markers/
            Show = true, -- true = แสดง Marker (false = ไม่แสดง)
            Type = 29, -- ประเภท Marker
            Size = { x = 1.5, y = 1.5, z = 1.5 }, -- ขนาด Marker
			Color = { r = 0, g = 128, b = 255 }, -- สี Marker
            Pos_Z_up = 1.0, -- จะกำหนดให้สูงจากตำแหน่งเดิมเท่าไหร่ (เอาไว้กรณีมันจมลงไปในพื้นสามารถเพิ่มค่าตรงนี้ได้)
            Pos_Z_down = 0 -- จะกำหนดให้ต่ำจากตำแหน่งเดิมเท่าไหร่
        },
        Pos = { -- สร้างจุดสำหรับกดเปิดร้าน (ตำแหน่งในเกม x y z)
            {x = -1814.0699462890625, y = -725.8300170898438, z = 9.35999965667724}, --ขวามือของเมือง
			--{x = -1222.915, y = -906.983,  z = 11.326}, ใกล้ทะเล
			--{x = -1487.553, y = -379.107,  z = 39.163}, ใกล้ทะเล
			--{x = -2968.243, y = 390.910,   z = 14.043}, ออกเมืองซ้าย
			--{x = 1166.024,  y = 2708.930,  z = 37.157}, กลางทะเลทรายขวา
			--{x = 1392.562,  y = 3604.684,  z = 33.980}, ใกล้การาจทะเลทราย
			--{x = 25.723,   y = -1346.966, z = 28.497},  ร้านเหล้า
			--{x = -1393.409, y = -606.624,  z = 29.319}, ใกล้ทะเล
            --{x = -1037.618,  y = -2737.399,   z = 19.169}, สนามบิน
            --{x = 373.875,   y = 325.896,  z = 102.566}, กลางเมือง downtown vinewood
			--{x = 2557.458,  y = 382.282,  z = 107.622}, ออกเมืองขวาสุด
			--{x = -3038.939, y = 585.954,  z = 6.908}, ออกเมืองซ้าย
			--{x = -3241.927, y = 1001.462, z = 11.830}, ออกเมืองซ้าย
			--{x = 547.431,   y = 2671.710, z = 41.156}, กลางทะเลทรายซ้าย
			{x = 1961.464,  y = 3740.672, z = 31.343},  --การาจทะเลทราย
			--{x = 2678.916,  y = 3280.671, z = 54.241}, --หน้าเหมือง
			--{x = 1729.216,  y = 6414.131, z = 34.037}, --เมืองบนเก็บปู
            --{x = -1820.55,  y = 792.15, z = 137.12}, ออกเมืองเกือบซ้ายสุด
            --{x = -707.68,  y = -914.64, z = 18.22}, ลิตเติ้ลโซล
            --{x = 1163.42,  y = -323.96, z = 68.21}, ปั้มขวามือของเมือง
            --{x = -48.66,  y = -1757.54, z = 28.42}, กลางเมือง groove street
            {x = -93.33,  y = 6410.16, z = 30.64}, -- เมืองบนสุด
            --{x = 1698.21,  y = 4924.86, z = 41.06}, --เมืองบน ไร่เก็บผัก
            --{x = 439.32,  y = -978.68, z = 29.69}, -- ทางเข้าสน
			{x = 317.69,  y = -1401.98, z = 31.51}, -- รพ.
			{x = -247.30999755859375, y = -946.7899780273438, z = 31.43000030517578}, -- การาจหลังจ๊อบ
            {x = -156.94, y = -1306.40, z = 30.43}, -- อู่ช่าง
            {x = -290.0, y = -1037.64, z = 29.39},-- คุก
            --{x = -1336.2, y = -3044.3, z = 12.94},-- วอโซนคลาสสิค
            --{x = 1062.99, y = 146.39, z = 79.99}, -- วอโซนเด้ง
            {x = 4992.8, y = -5193.12, z = 1.51},
        }
    },

    {
        Name = "Bar Shop", -- กำหนดชื่ออ้างอิงตั้งอะไรก็ได้ (ภาษาอังกฤษเท่านั้น, แนะนำอย่าซ้ำกับชื่อร้านอื่น)
        Label = "ร้านเหล้า", -- ชื่อร้านเวลาแสดงตอนเปิดหน้าซื้อไอเทมตามใจสามารถตั้งซ้ำได้ (สามารถใช้ภาษาไทยได้)
        Job = { 
            -- กำหนดอาชีพที่จะให้ซื้อในร้านนี้ได้เท่านั้น (ถ้าจะให้ซื้อได้ทุกคนไม่ต้องใส่อะไร)
			--"police",
			--"ambulance"
        }, 
        ItemsRequire = {
            -- กำหมดชื่อไอเทมที่ต้องมีในตัวก่อนถึงจะสามารถเปิดร้านได้
            --"phone",
            --"credit"
        },
        Items = {  -- สร้างรายการไอเทมในร้าน (ข้อมูลไอเทมจะอ้างอิงจาก database items)
            {
                name = "lighter",
				label = "ไฟแช๊ก", -- กำหนดชื่อไอเทมที่แสดงในร้านค้า (ถ้าไม่ใส่จะกำหนดตามข้อมูลใน database items)
                price = 1000
		    },
            {
                name = "cigarette",
				label = "บุหรี่", -- กำหนดชื่อไอเทมที่แสดงในร้านค้า (ถ้าไม่ใส่จะกำหนดตามข้อมูลใน database items)
                price = 250
		    },
            {
                name = "beer",
				label = "เบียร์", -- กำหนดชื่อไอเทมที่แสดงในร้านค้า (ถ้าไม่ใส่จะกำหนดตามข้อมูลใน database items)
                price = 1000
		    },
        },
        ItemsInclude = { }, -- ดึงรายไอเทมที่เราสร้างเซ็ทไอเทมไว้มาลงในร้านนี้
        Blip = { -- Blip Map
			-- ประเภทของ Blip ดูจากได้ https://wiki.rage.mp/index.php?title=Blips
            Show = true, -- true = แสดง Blip ใน Map (ถ้า false = ไม่แสดง)
            Name = '<font face="sarabun">ผับๆ</font>', -- ชื่อ Blip ใน Map
            Sprite = 93, -- รูป Blip
            Colour = 27, -- สี Blip
            Scale = 0.8 -- ขนาด Blip
        },
        Marker = { -- Marker
            -- ประเภท Marker ดูได้จาก https://docs.fivem.net/docs/game-references/markers/
            Show = true, -- true = แสดง Marker (false = ไม่แสดง)
            Type = 29, -- ประเภท Marker
            Size = { x = 1.5, y = 1.5, z = 1.5 }, -- ขนาด Marker
			Color = { r = 0, g = 128, b = 255 }, -- สี Marker
            Pos_Z_up = 1.0, -- จะกำหนดให้สูงจากตำแหน่งเดิมเท่าไหร่ (เอาไว้กรณีมันจมลงไปในพื้นสามารถเพิ่มค่าตรงนี้ได้)
            Pos_Z_down = 0 -- จะกำหนดให้ต่ำจากตำแหน่งเดิมเท่าไหร่
        },
        Pos = { -- สร้างจุดสำหรับกดเปิดร้าน (ตำแหน่งในเกม x y z)
            {x = -1394.51, y = -607.14, z = 29.32},
        }
    },

    {
        Name = "Fishing Shops", -- กำหนดชื่ออ้างอิงตั้งอะไรก็ได้ (ภาษาอังกฤษเท่านั้น, แนะนำอย่าซ้ำกับชื่อร้านอื่น)
        Label = "อุปกรณ์ตกปลา", -- ชื่อร้านเวลาแสดงตอนเปิดหน้าซื้อไอเทมตามใจสามารถตั้งซ้ำได้ (สามารถใช้ภาษาไทยได้)
        Job = { }, -- กำหนดอาชีพที่จะให้ซื้อในร้านนี้ได้เท่านั้น (ถ้าจะให้ซื้อได้ทุกคนไม่ต้องใส่อะไร)
        ItemsRequire = {

        },
        Items = {  -- สร้างรายการไอเทมในร้าน (ข้อมูลไอเทมจะอ้างอิงจาก database items)
            {
                name = "fishbait", -- ชื่อไอเทม
				label = "เหยื่อหนอน", -- กำหนดชื่อไอเทมที่แสดงในร้านค้า (ถ้าไม่ใส่จะกำหนดตามข้อมูลใน database itemsอ
                price = 5, -- ราคา
            },
            {
                name = "fishingrod", -- ชื่อไอเทม
				label = "เบ็ดตกปลา", -- กำหนดชื่อไอเทมที่แสดงในร้านค้า (ถ้าไม่ใส่จะกำหนดตามข้อมูลใน database itemsอ
                price = 100, -- ราคา
            }
        },
        Blip = { -- Blip Map
            Show = true, -- true = แสดง Blip ใน Map (ถ้า false = ไม่แสดง)
            Name = '<font face="sarabun">งาน | ตกปลา</font>', -- ชื่อ Blip ใน Map
            Sprite = 68, -- รูป Blip
            Colour = 27, -- สี Blip
            Scale = 0.8 -- ขนาด Blip
        },
        Marker = { -- Marker
            Show = true, -- true = แสดง Marker (false = ไม่แสดง)
            Type = 29, -- ประเภท Marker
            Size = { x = 1.5, y = 1.5, z = 1.5 }, -- ขนาด Marker
            Color = { r = 255, g = 0, b = 0 }, -- สี Marker
            Pos_Z_up = 0, -- จะกำหนดให้สูงจากตำแหน่งเดิมเท่าไหร่ (เอาไว้กรณีมันจมลงไปในพื้นสามารถเพิ่มค่าตรงนี้ได้)
            Pos_Z_down = 0 -- จะกำหนดให้ต่ำจากตำแหน่งเดิมเท่าไหร่
        },
        Pos = { -- สร้างจุดสำหรับกดเปิดร้าน (ตำแหน่งในเกม x y z)
            {x = -881.530029296875, y = 5833.5, z = 1.67999994754791}, -- จุดตกปลา
			--{x = -711.79,  y = -1298.9, z = 5.25} -- รพ กลาง

        }
    },

    --[[{
        Name = "Smoke Shops", -- กำหนดชื่ออ้างอิงตั้งอะไรก็ได้ (ภาษาอังกฤษเท่านั้น, แนะนำอย่าซ้ำกับชื่อร้านอื่น)
        Label = "ร้านสายควัน", -- ชื่อร้านเวลาแสดงตอนเปิดหน้าซื้อไอเทมตามใจสามารถตั้งซ้ำได้ (สามารถใช้ภาษาไทยได้)
        Job = { }, -- กำหนดอาชีพที่จะให้ซื้อในร้านนี้ได้เท่านั้น (ถ้าจะให้ซื้อได้ทุกคนไม่ต้องใส่อะไร)
        ItemsRequire = {

        },
        Items = {  -- สร้างรายการไอเทมในร้าน (ข้อมูลไอเทมจะอ้างอิงจาก database items)
            {
                name = "weed_seed", -- ชื่อไอเทม
				label = "เมล็ดกัญชา", -- กำหนดชื่อไอเทมที่แสดงในร้านค้า (ถ้าไม่ใส่จะกำหนดตามข้อมูลใน database itemsอ
                price = 100, -- ราคา
            },
            {
                name = "lighter", -- ชื่อไอเทม
				label = "ไฟแช๊ก", -- กำหนดชื่อไอเทมที่แสดงในร้านค้า (ถ้าไม่ใส่จะกำหนดตามข้อมูลใน database itemsอ
                price = 1000, -- ราคา
            },
            {
                name = "cigarette", -- ชื่อไอเทม
				label = "บุหรี่", -- กำหนดชื่อไอเทมที่แสดงในร้านค้า (ถ้าไม่ใส่จะกำหนดตามข้อมูลใน database itemsอ
                price = 250, -- ราคา
            }

        },
        Blip = { -- Blip Map
            Show = true, -- true = แสดง Blip ใน Map (ถ้า false = ไม่แสดง)
            Name = '<font face="sarabun">ร้านเราเพื่อนกัญ</font>', -- ชื่อ Blip ใน Map
            Sprite = 496, -- รูป Blip
            Colour = 69, -- สี Blip
            Scale = 0.4 -- ขนาด Blip
        },
        Marker = { -- Marker
            Show = true, -- true = แสดง Marker (false = ไม่แสดง)
            Type = 29, -- ประเภท Marker
            Size = { x = 1.5, y = 1.5, z = 1.5 }, -- ขนาด Marker
            Color = { r = 255, g = 0, b = 0 }, -- สี Marker
            Pos_Z_up = 0, -- จะกำหนดให้สูงจากตำแหน่งเดิมเท่าไหร่ (เอาไว้กรณีมันจมลงไปในพื้นสามารถเพิ่มค่าตรงนี้ได้)
            Pos_Z_down = 0 -- จะกำหนดให้ต่ำจากตำแหน่งเดิมเท่าไหร่
        },
        Pos = { -- สร้างจุดสำหรับกดเปิดร้าน (ตำแหน่งในเกม x y z)
            {x = -1172.07, y = -1572.13, z = 4.66}, -- ร้านกัญชา

        }
    },--]]
	
	{
        Name = "Medic Shops",
        Label = "เบิกของหมอ",
        Job = { 
		"ambulance"
		}, 
        ItemsRequire = {

        },
        Items = {  
            {
                name = "medikit", 
				label = "ชุดปฐมพยาบาล", 
                price = 200, 
            },
            --[[{
                name = "bandage", 
				label = "ผ้าพันแผล", 
                price = 50, 
            },--]]
            {
                name = "oxygen_mask", 
				label = "ถังอ๊อกซิเจน", 
                price = 0, 
            },
			{
                name = "reskin", 
				label = "บัตรศัลยกรรม", 
                price = 50000,
            },
			--[[{
                name = "water_amd", 
				label = "น้ำยาทางการแพทย์", 
                price = 200,
            }--]]
        },
        Blip = { -- Blip Map
            Show = false, -- true = แสดง Blip ใน Map (ถ้า false = ไม่แสดง)
            Name = "Ambulance", -- ชื่อ Blip ใน Map
            Sprite = 496, -- รูป Blip
            Colour = 25, -- สี Blip
            Scale = 0.4 -- ขนาด Blip
        },
        Marker = { 
            Show = true, 
            Type = 29, 
            Size = { x = 1.5, y = 1.5, z = 1.5 }, 
            Color = { r = 200, g = 0, b = 0 }, 
            Pos_Z_up = 0, 
            Pos_Z_down = 0 
        },
        Pos = { 
            {x = 366.41, y = -1419.37, z = 32.51},    

        }
    },

    {
        Name = "Police Shops",
        Label = "เบิกของตำรวจ",
        Job = { 
		"police"
		}, 
        ItemsRequire = {

        },
        Items = {  
            {
                name = "oxygen_mask", 
				label = "ถังอ๊อกซิเจน", 
                price = 0, 
            }    
        },
        Blip = { -- Blip Map
            Show = false, -- true = แสดง Blip ใน Map (ถ้า false = ไม่แสดง)
            Name = "Police", -- ชื่อ Blip ใน Map
            Sprite = 496, -- รูป Blip
            Colour = 25, -- สี Blip
            Scale = 0.4 -- ขนาด Blip
        },
        Marker = { 
            Show = true, 
            Type = 29, 
            Size = { x = 1.5, y = 1.5, z = 1.5 }, 
            Color = { r = 200, g = 0, b = 0 }, 
            Pos_Z_up = 0, 
            Pos_Z_down = 0 
        },
        Pos = { 
            {x = 460.92, y = -982.22, z = 30.69}, 

        }
    },

    --[[{
        Name = "Chef Shops",
        Label = "เบิกของเชฟ",
        Job = { 
		"chef"
		}, 
        ItemsRequire = {

        },
        Items = {  
            {
                name = "pan_chef", 
				label = "กระทะทำอาหาร", 
                price = 0, 
            },
            {
                name = "blender", 
				label = "เครื่องปั่น", 
                price = 0, 
            }
        },
        Blip = { -- Blip Map
            Show = false, -- true = แสดง Blip ใน Map (ถ้า false = ไม่แสดง)
            Name = "Chef", -- ชื่อ Blip ใน Map
            Sprite = 496, -- รูป Blip
            Colour = 25, -- สี Blip
            Scale = 0.4 -- ขนาด Blip
        },
        Marker = { 
            Show = true, 
            Type = 29, 
            Size = { x = 1.5, y = 1.5, z = 1.5 }, 
            Color = { r = 200, g = 0, b = 0 }, 
            Pos_Z_up = 0, 
            Pos_Z_down = 0 
        },
        Pos = { 
            {x = 234.61, y = -726.58, z = 39.08}, 

        }
    },--]]

    {
        Name = "Mechanic Shops",
        Label = "ร้านค้าช่าง",
        Job = { 
		"mechanic"
		}, 
        ItemsRequire = {

        },
        Items = {
            {
                name = "tool_mechanic", 
				label = "น้ำยาหล่อเย็น", 
                price = 50, 
            }
            --[[{
                name = "notebook", 
				label = "คอมแต่งรถช่าง", 
                price = 5000, 
            }--]]
        },
        Blip = { -- Blip Map
            Show = false, -- true = แสดง Blip ใน Map (ถ้า false = ไม่แสดง)
            Name = "mechanic", -- ชื่อ Blip ใน Map
            Sprite = 496, -- รูป Blip
            Colour = 25, -- สี Blip
            Scale = 0.4 -- ขนาด Blip
        },
        Marker = { 
            Show = true, 
            Type = 29, 
            Size = { x = 1.5, y = 1.5, z = 1.5 }, 
            Color = { r = 200, g = 0, b = 0 }, 
            Pos_Z_up = 0, 
            Pos_Z_down = 0 
        },
        Pos = { 
            {x = -779.08, y = -1476.07, z = 5.19}, 

        }
    },

    {
        Name = "Chef Shops",
        Label = "ร้านค้าเซฟ",
        Job = { 
		"chef"
		}, 
        ItemsRequire = {

        },
        Items = {
            {
                name = "water", 
				label = "น้ำเปล่า", 
                price = 50, 
            }
            --[[{
                name = "notebook", 
				label = "คอมแต่งรถช่าง", 
                price = 5000, 
            }--]]
        },
        Blip = { -- Blip Map
            Show = false, -- true = แสดง Blip ใน Map (ถ้า false = ไม่แสดง)
            Name = "chef", -- ชื่อ Blip ใน Map
            Sprite = 496, -- รูป Blip
            Colour = 25, -- สี Blip
            Scale = 0.4 -- ขนาด Blip
        },
        Marker = { 
            Show = true, 
            Type = 29, 
            Size = { x = 1.5, y = 1.5, z = 1.5 }, 
            Color = { r = 200, g = 0, b = 0 }, 
            Pos_Z_up = 0, 
            Pos_Z_down = 0 
        },
        Pos = { 
            {x = -176.12, y = 309.8, z = 96.99}, 

        }
    },
     
    --[[{
        Name = "Milk Shops",
        Label = "เครื่องรีดนมวัว",
        Job = { }, 
        ItemsRequire = {

        },
        Items = {  
            {
                name = "milk_engine", 
				label = "เครื่องรีดนมวัว", 
                price = 1000, 
            }       
        },
        Blip = { -- Blip Map
            Show = false, -- true = แสดง Blip ใน Map (ถ้า false = ไม่แสดง)
            Name = "Milking", -- ชื่อ Blip ใน Map
            Sprite = 496, -- รูป Blip
            Colour = 25, -- สี Blip
            Scale = 0.4 -- ขนาด Blip
        },
        Marker = { 
            Show = true, 
            Type = 29, 
            Size = { x = 1.5, y = 1.5, z = 1.5 }, 
            Color = { r = 200, g = 0, b = 0 }, 
            Pos_Z_up = 0, 
            Pos_Z_down = 0 
        },
        Pos = { 
            {x = 2415.06, y = 4794.04, z = 35.06}, 

        }
    },--]]

    --[[{
        Name = "Drug Dealer",
        Label = "เปิดตัวค้ายา",
        Job = { }, 
        ItemsRequire = {

        },
        Items = {  
            {
                name = "seller", 
				label = "บัตรเอเย่นค้ายา", 
                price = 10000, 
            }       
        },
        Blip = { -- Blip Map
            Show = false, -- true = แสดง Blip ใน Map (ถ้า false = ไม่แสดง)
            Name = "DrugDealer", -- ชื่อ Blip ใน Map
            Sprite = 496, -- รูป Blip
            Colour = 25, -- สี Blip
            Scale = 0.4 -- ขนาด Blip
        },
        Marker = { 
            Show = true, 
            Type = 29, 
            Size = { x = 1.5, y = 1.5, z = 1.5 }, 
            Color = { r = 200, g = 0, b = 0 }, 
            Pos_Z_up = 0, 
            Pos_Z_down = 0 
        },
        Pos = { 
            {x = 127.91, y = -2493.5, z = 6.0}, 

        }
    },--]]

    --[[{
        Name = "Prison Shops",
        Label = "ร้านค้าในเรือนจำ",
        Job = { }, 
        ItemsRequire = {

        },
        Items = {  
            {
                name = "moodang_box", 
				label = "ข้าวหมูแดง", 
                price = 100, 
            },
            {
                name = "cola", 
				label = "น้ำอัดลม", 
                price = 100, 
            }          
        },
        Blip = { -- Blip Map
            Show = false, -- true = แสดง Blip ใน Map (ถ้า false = ไม่แสดง)
            Name = "Prison", -- ชื่อ Blip ใน Map
            Sprite = 496, -- รูป Blip
            Colour = 25, -- สี Blip
            Scale = 0.4 -- ขนาด Blip
        },
        Marker = { 
            Show = true, 
            Type = 29, 
            Size = { x = 1.5, y = 1.5, z = 1.5 }, 
            Color = { r = 200, g = 0, b = 0 }, 
            Pos_Z_up = 0, 
            Pos_Z_down = 0 
        },
        Pos = { 
            {x = 1779.6, y = 2589.71, z = 45.8}, 

        }
    },--]]

    --[[{
        Name = "McDonald Shops",
        Label = "แมคโดนอล",
        Job = { }, 
        ItemsRequire = {

        },
        Items = {  
            {
                name = "mcdonald", 
				label = "ชุดแมคโดนอล", 
                price = 500, 
            },
            {
                name = "cha_green", 
				label = "ชาเขียว", 
                price = 300, 
            }     
        },
        Blip = { -- Blip Map
            Show = true, -- true = แสดง Blip ใน Map (ถ้า false = ไม่แสดง)
            Name = '<font face="sarabun">ร้านMcDonald</font>', -- ชื่อ Blip ใน Map
            Sprite = 105, -- รูป Blip
            Colour = 0, -- สี Blip
            Scale = 0.4 -- ขนาด Blip
        },
        Marker = { 
            Show = true, 
            Type = 29, 
            Size = { x = 1.5, y = 1.5, z = 1.5 }, 
            Color = { r = 200, g = 0, b = 0 }, 
            Pos_Z_up = 0, 
            Pos_Z_down = 0 
        },
        Pos = { 
            {x = 280.39, y = -971.51, z = 29.37}, 

        }
    },--]]

    --[[{
        Name = "Kfc Shops",
        Label = "ไก่เคเอฟซี",
        Job = { }, 
        ItemsRequire = {

        },
        Items = {  
            {
                name = "kfc", 
				label = "ชุดไก่ kfc", 
                price = 500, 
            },
            {
                name = "pepsi", 
				label = "เปปซี่", 
                price = 300, 
            }     
        },
        Blip = { -- Blip Map
            Show = true, -- true = แสดง Blip ใน Map (ถ้า false = ไม่แสดง)
            Name = '<font face="sarabun">ร้านKFC</font>', -- ชื่อ Blip ใน Map
            Sprite = 104, -- รูป Blip
            Colour = 0, -- สี Blip
            Scale = 0.4 -- ขนาด Blip
        },
        Marker = { 
            Show = true, 
            Type = 29, 
            Size = { x = 1.5, y = 1.5, z = 1.5 }, 
            Color = { r = 200, g = 0, b = 0 }, 
            Pos_Z_up = 0, 
            Pos_Z_down = 0 
        },
        Pos = { 
            {x = 346.05, y = -882.88, z = 29.34}, 

        }
    }--]]

}

------------------------ ItemsInclude กำหนดสร้างเซ็ทไอเทม (เอาไว้สำหรับลงขายในร้าน)

Config_xZC_Shop.ItemsInclude = {
    
    ["SET_WEAPON_01"] = {
        {
            name = "weapon_doubleaction",
            item_type = "item_weapon",
            ammo = 100,
            price_account_name = "black_money",
            price = 1000
        },
        {
            name = "weapon_assaultsmg",
            item_type = "item_weapon",
            ammo = 100,
            price_account_name = "black_money",
            price = 5000
        },
        {
            name = "weapon_heavyshotgun",
            item_type = "item_weapon",
            price_account_name = "black_money",
            ammo = 100,
            price = 5000
        }
    }
}
