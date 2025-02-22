Config = {};SERVER = {}; GlobaConfig = {};  --[ @ Settings *

--[ @ BASE FRAME WORK
SERVER.Framework = exports["es_extended"]:getSharedObject()

--[ @ DEBUG / EXTENDED
Secure = {
	Debug_mode = false, -- @ DEBUG ของทรัพยากร
    Extended = "limit", -- @ EXTENDED VERSION | weight or limit
	DiscordAPI = { -- @ BOTWEBHOOK
		Buylog = "" -- @ WEBHOOK SHOP
	}
}

MARKET_SETTING = {
    PATH_IMG = 'Fewthz_inventory/html/img/items',  -- @ ที่อยู่ไฟล์รูปภาพของกระเป๋า #จำเป็นต้องมี / อยู่ด้านหลังสุด 
	BOXING = false, -- @ ถ้าเปิด true จะสามารถใช้คำสั่งด้านล่างได้ 
	COMMAND = 'shop', -- @ Command ที่จะใช้เปิดร้านค้า เหมาะกับ Boxing
	OPENTEXTUI = true, -- @ TEXT UI
	TEXT = "Press ~INPUT_CONTEXT~ to Open" -- @ ข้อความ
}

MARKER_SETTING = {
	SIZE = {x = 0.8, y = 0.5, z = 0.8},
	TYPE = 29,
	COLOR = {r = 255, g = 255, b = 255},
	Distance = 10
}

--[[ 
    -- +> PNOTIFY <+--
    @ INFO ( 1 )
    + TIME  --> เวลาในการแสดง UI ( วินาที )
    + LAYOUT --> ตำแหน่งที่แสดง UI
	# ทั้งหมดอิงจาก pNotify
--]]

PNOTIFY_SETTING = {  
	TIME = 4,
	LAYOUT = "topRight",

	NOMONEY = "Not Enough Money",
	NOMONEYTYPE = "error",

	NOFREE = "Not Enough Space",
	NOFREETYPE = "error",

	BUY = "You just Brought it",
	BUTTYPE = "info",

	HAVEGUN = "คุณมีปืนนี้อยู่แล้ว",
	HAVEGUNTYPE = "warning",
}

--[[ 
    -- +> BLIP <+--
    @ INFO ( 1 )
    + Text  --> ชื่อที่แสดงบน MAP  
    + color --> สีที่แสดงบน MAP อิงจาก https://docs.fivem.net/docs/game-references/blips/
	+ Blip    --> BLIP อิงจาก https://docs.fivem.net/docs/game-references/blips/
	+ Size --> ขนาดของ BLIP
--]]

GlobaConfig["Zones"] = {
    TwentyFourSeven = {
		Items = {
			{ 
				item = 'fixkit' , 
				label = 'กล่องซ่อม' , 
				price = 2500 , 
				limit = 100
			},
			{ 
				item = 'phone' , 
				label = 'มือถือ' , 
				price = 10000 , 
				limit = 1
			},
			{ 
				item = 'fishbait' , 
				label = 'เหยื่อตกปลา' , 
				price = 20 , 
				limit = 100
			},
			{ 
				item = 'skateboard' , 
				label = 'สเกตบอร์ด' , 
				price = 20000 , 
				limit = 100
			},
			{ 
				item = 'jobcard' , 
				label = 'บัตรทำงาน' , 
				price = 5000 , 
				limit = 100
			},
			{ 
				item = 'fixkit' , 
				label = ' กล่องซ่อม' , 
				price = 2500 , 
				limit = 100
			},
			{ 
				item = 'fixkit' , 
				label = ' กล่องซ่อม' , 
				price = 2500 , 
				limit = 100
			},
			{ 
				item = 'fixkit' , 
				label = ' กล่องซ่อม' , 
				price = 2500 , 
				limit = 100
			},
			{ 
				item = 'fixkit' , 
				label = ' กล่องซ่อม' , 
				price = 2500 , 
				limit = 100
			},
		},
		-- Require = { -- ไม่ต้องการปิดได้เลย
			-- ITEM ที่ต้องมีถึงจะเปิด SHOP ได้ ( มีแค่อย่างได้อย่างนึงก็เปิดได้ )
			-- Items = { 'bread', },
			-- อาชีพที่ต้องเป็ฯถึงจะเปิด shop ได้
			-- Jobs = {'police'}
		-- }, 

		--[[ 
			x พิกัด x
			y พิกัด y
			z พิกัด z
			Distance ระยะในการกด
		--]]

		Pos = {
			-- {x = 373.875,   y = 325.896,  z = 103.666, Distance = 1},
			-- {x = 2557.458,  y = 382.282,  z = 108.722 , Distance = 1},
			-- {x = -3038.939, y = 585.954,  z = 7.999, Distance = 1},
			{x = -3241.927, y = 1001.462, z = 12.930 ,Distance = 1},
			{x = 547.431,   y = 2671.710, z = 42.256 ,Distance = 1},
			{x = 1961.464,  y = 3740.672, z = 32.443 ,Distance = 1},
			{x = 2678.99, y = 3280.34, z = 55.24 ,Distance = 1},
			{x = 1729.216,  y = 6414.131, z = 35.100 ,Distance = 1},
			-- {x = 1135.808,  y = -982.281,  z = 46.515 ,Distance = 1},
			-- {x = -1222.915, y = -906.983,  z = 12.426 ,Distance = 1},
			-- {x = -1487.553, y = -379.107,  z = 40.263 ,Distance = 1},
			-- {x = -2968.243, y = 390.910,   z = 15.143 ,Distance = 1},
			{x = 1166.024,  y = 2708.930,  z = 38.257 ,Distance = 1},
			-- {x = 1392.562,  y = 3604.684,  z = 35.000 ,Distance = 1},
			 {x =-300.85, y = -921.90, z = 31.34 ,Distance = 1}, 
			 {x = 310.23, y = -585.82,  z = 43.27 ,Distance = 1}, 
			{x = -48.519,   y = -1757.514, z = 29.521,Distance = 1},
			{x = 1163.373,  y = -323.801,  z = 69.305,Distance = 1},
			{x = -707.501,  y = -914.260,  z = 19.315,Distance = 1},
			{x = -1820.523, y = 792.518,   z = 138.218,Distance = 1},
			{x = 1698.388,  y = 4924.404,  z = 42.163,Distance = 1},
			-- {x = -823.15,  y = -1361.59,  z = 5.15,Distance = 1},
			-- {x = -493.75,  y = -339.94,  z = 42.32,Distance = 1},
			--{x = 316.85,  y = -588.76,  z = 43.29,Distance = 2},
		},

		DistanceMarker = 10, -- @ ระยะการมองเห็น Market 

		-- CustomBlip = { -- ตั้งค่า BLIP เอง ShowBlip = false หรือลบไปเลย
		-- 	Text = "SHOP",
		-- 	Blip = 59,
		-- 	Color = 2,
		-- 	Size = 0.6
		-- },

		

		ShowBlip = true,
	},
	WeedShop = {
		Items = {
			-- item = ชื่อใน ITEM IN DATABASE
			-- label = ชื่อที่แสดงในร้านค้า
			-- price = ราคา
			-- limit = ซื้อ ITEM ได้ทีล่ะกี่อัน  coin_sergeant2
			{ 
				item = 'weed_seed' , 
				label = 'เมล็ดกัญชา' , 
				price = 20 , 
				limit = 20
			},
			
		
		},
		-- Require = { -- ไม่ต้องการปิดได้เลย
			-- ITEM ที่ต้องมีถึงจะเปิด SHOP ได้ ( มีแค่อย่างได้อย่างนึงก็เปิดได้ )
			-- Items = { 'bread', },
			-- อาชีพที่ต้องเป็ฯถึงจะเปิด shop ได้
			-- Jobs = {'police'}
		-- }, 

		--[[ 
			x พิกัด x
			y พิกัด y
			z พิกัด z
			Distance ระยะในการกด
		--]]

		Pos = {
			{x = -1172.18, y = -1571.73, z = 4.66 ,Distance = 1},
		},

		DistanceMarker = 10, -- @ ระยะการมองเห็น Market 

		-- --[[CustomBlip = { -- ตั้งค่า BLIP เอง ShowBlip = false หรือลบไปเลย
		-- 	Text = "SHOP",
		-- 	Blip = 318,
		-- 	Color = 28,
		-- 	Size = 0.6
		-- },]]

		Blip = {
			{
			        Text = "WeedShop",
					Blip = 140,
					Color = 0,
					Size = 0.6
			},
		},

		ShowBlip = false,
	},

	ambu_shop = {
		Items = {
			-- item = ชื่อใน ITEM IN DATABASE
			-- label = ชื่อที่แสดงในร้านค้า
			-- price = ราคา
			-- limit = ซื้อ ITEM ได้ทีล่ะกี่อัน
			{ 
				item = 'medikit' , 
				label = 'ชุดปฐมพยาบาล' , 
				price = 50 , 
				limit = 40 
			},
			{ 
				item = 'radio' , 
				label = 'วิทยุสื่อสาร' , 
				price = 200 , 
				limit = 1 
			},
			{ 
				item = 'fixkitEX' , 
				label = 'Repair kit Agency' , 
				price = 10 , 
				limit = 1
			},
			{ 
				item = 'mre' , 
				label = 'mre' , 
				price = 10 , 
				limit = 100 
			},
			{ 
				item = 'soap' , 
				label = 'soap' , 
				price = 10 , 
				limit = 100 
			},
			{ 
				item = 'vestEx' , 
				label = 'Vest Agency', 
				price = 10 , 
				limit = 100 
			},
			{ 
				item = 'OxygenEx' , 
				label = 'OxygenEx',
				price = 100 , 
				limit = 100 
			},
		},
		Pos = {
			{x = 302.10, y =  -598.84, z= 43.27,Distance = 2},
		},
		ShowBlip = false,
		DistanceMarker = 10, -- @ ระยะการมองเห็น Market 
		Require = { -- ไม่ต้องการปิดได้เลย
			--ITEM ที่ต้องมีถึงจะเปิด SHOP ได้ ( มีแค่อย่างได้อย่างนึงก็เปิดได้ )
			--Items = { 'bread', },
			--อาชีพที่ต้องเป็ฯถึงจะเปิด shop ได้
			Jobs = {'ambulance'}
		}, 
	},

	police_shop = {
		Items = {
			-- item = ชื่อใน ITEM IN DATABASE
			-- label = ชื่อที่แสดงในร้านค้า
			-- price = ราคา
			-- limit = ซื้อ ITEM ได้ทีล่ะกี่อัน
			{ 
				item = 'weapon_stungun' , 
				label = 'เทเซอร์' , 
				price = 200 , 
				limit = 1 
			},
		
			{ 
				item = 'fixkitEX' , 
				label = 'Repair kit Agency' , 
				price = 10 , 
				limit = 1 
			},
			{ 
				item = 'mre' , 
				label = 'mre' , 
				price = 10 , 
				limit = 10 
			},
			{ 
				item = 'am_Carbine' , 
				label = 'Carbine Rifle Ammo' , 
				price = 1 , 
				limit = 100 
			},
			{ 
				item = 'soap' , 
				label = 'soap' , 
				price = 10 , 
				limit = 10
			},
			{ 
				item = 'vestEx' , 
				label = 'Vest Agency', 
				price = 10 , 
				limit = 10 
			},
			{ 
				item = 'OxygenEx' , 
				label = 'Oxygen Tank' , 
				price = 10 , 
				limit = 1 
			},
		},
		Pos = {
			{x = 463.18,  y = -999.01, z = 30.69,Distance = 2},
		},
		ShowBlip = false,
		DistanceMarker = 10, -- @ ระยะการมองเห็น Market 
		Require = { -- ไม่ต้องการปิดได้เลย
			--ITEM ที่ต้องมีถึงจะเปิด SHOP ได้ ( มีแค่อย่างได้อย่างนึงก็เปิดได้ )
			--Items = { 'bread', },
			--อาชีพที่ต้องเป็ฯถึงจะเปิด shop ได้
			Jobs = {'police'}
		}, 
	},
}