
-- Giant Dev 
-- https://discord.gg/AgutpzcVzv
-- Custom ui for your Server 
-- 19 - 8 - 65 


Config = {}

Config.Price = 500		-- ร้านทำผม
Config.Price2 = 250			-- ร้านเสื้อ
Config.Price3 = 1000			-- ร้านเครื่องประดับ

Config.wardrobePrice = 1500   -- ราคาค่าเก็บเสื้อผ้า
Config.wardrobeslot = 10000       -- ค่าเพิ่ม slot เสื้อผ้า


Config.logo = '' -- ใส่ลิงค์รูปภาพ discord

Config.nameskin = 'Skin Menu'
Config.nameClothes = 'Clothes Menu'
Config.nameBarber = 'Barber Menu'
Config.nameCostume = 'Costume Shop'  -- accessory





-- เปิดให้บันทึก true ข้อมูล แว่น หมวก ตุ้มหู ลงกระเป๋าหรือไม่ เชื่อมกับกระเป๋า nc
-- ถ้า false ปิด จะบันทึก แว่น หมวก ตุ้มหู แต่ยังบันทึกหน้ากากอยู่ ในหมวดรีสกิน
Config.accessoriesNcsave = true
-- เชื่อมตู้เสื้อผ้า 
Config.outlet = false

Config.blockCloth = false

--  limit จำนวนตู้เสื้อผ้า
Config.limitWardrobe = 10



-- รายการที่จะบันทึกใน ตู้เสื้อผ้า เปิดปิดตามรายการร้านเสื้อผ้าจะเข้ากันกับระบบมากที่สุด
Config.listofSaveCloth = function(skin)
    

    local itemSkin = {}
    itemSkin['sex'] = skin['sex'] -- ห้ามลบ

    itemSkin['tshirt_1'] = skin['tshirt_1']
    itemSkin['tshirt_2'] = skin['tshirt_2']
    itemSkin['torso_1'] = skin['torso_1']
    itemSkin['torso_2'] = skin['torso_2']
    itemSkin['bproof_1'] = skin['bproof_1']
    itemSkin['bproof_2'] = skin['bproof_2']
    itemSkin['decals_1'] = skin['decals_1']
    itemSkin['decals_2'] = skin['decals_2']
    itemSkin['arms'] = skin['arms']
    -- itemSkin['arms_2'] = skin['arms_2']
    itemSkin['pants_1'] = skin['pants_1']
    itemSkin['pants_2'] = skin['pants_2']
    itemSkin['shoes_1'] = skin['shoes_1']
    itemSkin['shoes_2'] = skin['shoes_2']
    itemSkin['bags_1'] = skin['bags_1']
    itemSkin['bags_2'] = skin['bags_2']
    itemSkin['watches_1'] = skin['watches_1']
    itemSkin['watches_2'] = skin['watches_2']
    itemSkin['bracelets_1'] = skin['bracelets_1']
    itemSkin['bracelets_2'] = skin['bracelets_2']
	itemSkin['chain_1'] = skin['chain_1']
	itemSkin['chain_2'] = skin['chain_2']
	-- itemSkin['helmet_1'] = skin['helmet_1']
	-- itemSkin['helmet_2'] = skin['helmet_2']
	-- itemSkin['glasses_1'] = skin['glasses_1']
	-- itemSkin['glasses_1'] = skin['glasses_1']

    return itemSkin


end


Config.Texts = "Press ~INPUT_CONTEXT~ To Enter Shop"

Config.clotheslist = {
		'torso_1',
		  'torso_2',
		'tshirt_1',
		 'tshirt_2',
		'decals_1',
		 'decals_2',
		'arms', 
		-- 'arms_2',
		'pants_1',
		 'pants_2',
		'shoes_1',
		 'shoes_2',
		'watches_1',
		'watches_2',
		'bags_1',
		   'bags_2',
		'bproof_1',
		 'bproof_2',
		'chain_1', 
		 'chain_2',
		'bracelets_1',
		  'bracelets_2'
}
Config.barberlist = {
	'beard_1',
	'beard_2',
	'beard_3',
	'beard_4',
	'hair_1',
	'hair_2',
	'hair_color_1',
	'hair_color_2',
	'eyebrows_1',
	'eyebrows_2',
	'eyebrows_3',
	'eyebrows_4',
	'makeup_1',
	'makeup_2',
	'makeup_3',
	'makeup_4',
	'lipstick_1',
	'lipstick_2',
	'lipstick_3',
	'lipstick_4',
	'ears_1',
	'ears_2',
}


-- กรุณากรอกจำนวน รายการในร้านดังนี้ เพื่อให้ระบบเช็คว่า คำนวณเงินให้ถูกต้อง
-- เช่น ร้าน เสื้อผ้ามี 22 รายการใส่ / ร้านทำผม มี 20
-- Config.itemreskin = 'reskins'
Config.checklist = false
-- จำนวน item skin
-- ไม่ควรให้จำนวน barber and clotheshop เท่ากัน
-- จำนวน item barbershop
-- จำนวน item clotheshop
-- ของ legacy มี list 96 / ของ 1.1 มี 72
Config.reskin = 96
Config.barbershop = #Config.barberlist
Config.clotheshop = #Config.clotheslist 


Config.Zones = {

	Ears = {

		Pos = {

			vector3( 80.374,		 -1389.493,	 28.406),
			vector3( -709.426,    -153.829,	 36.535),
			vector3( -163.093,    -302.038,	 38.853),
			vector3( 420.787,	 -809.654,	 28.611),
			vector3( -817.070,	 -1075.96,	 10.448),
			vector3( -1451.300,   -238.254,	 48.929),
			vector3( -0.756,		 6513.685,	 30.997),
			vector3( 123.431,	 -208.060,	 53.677),
			vector3( 1200.085,    2705.428,	 37.342),
			vector3( -1199.959,   -782.534,	 16.452),
			vector3( -3171.867,   1059.632,	 19.983),
			vector3( 457.3134, -990.7662, 30.6896)
			
			

		},
		Marker = {
            Type = 27,
			r = 102,
			g = 102,
			b = 204,
			Size = { 
                x = 1.5,  
                y = 1.5,  
                z = 1.0
            }
		},
	},
	
	Helmet = {

		Pos = {

			vector3( 81.576,		 -1400.602,	 28.406),
			vector3( -705.845,    -159.015,	  36.535),
			vector3( -161.349,    -295.774,	  38.853),
			vector3( 419.319,	 -800.647,	  28.611),
			vector3( -824.362,    -1081.741,	 10.448),
			vector3( -1454.888,   -242.911,	  48.931),
			vector3( 4.770,		 6520.935,	  30.997),
			vector3( 121.071,	 -223.266,	  53.377),
			vector3( 1189.513,    2703.947,	  37.342),
			vector3( -1204.025,   -774.439,	  16.452),
			vector3( -3164.280,   1054.705,	  19.983)
			

		},
		Marker = {
            Type = 27,
			r = 102,
			g = 102,
			b = 204,
			Size = { 
                x = 1.5,  
                y = 1.5,  
                z = 1.0
            }
		},
	},
	
	Glasses = {

		Pos = {

			vector3( 75.287,		 -1391.131,	 28.406),
			vector3( -713.102,    -160.116,	  36.535),
			vector3( -156.171,    -300.547,	  38.853),
			vector3( 425.478,	 -807.866,	  28.611),
			vector3( -820.853,    -1072.940,	 10.448),
			vector3( -1458.052,   -236.783,	  48.918),
			vector3( 3.587,		 6511.585,	  30.997),
			vector3( 131.335,	 -212.336,	  53.677),
			vector3( 1198.678,    2711.011,	  37.342),
			vector3( -1188.227,   -764.594,	  16.452),
			vector3( -3173.192,   1038.228,	  19.983)

		},
		Marker = {
            Type = 27,
			r = 102,
			g = 102,
			b = 204,
			Size = { 
                x = 1.5,  
                y = 1.5,  
                z =1.0
            }
		},
	},

	Mask = {

		Pos = {
			vector3(-1338.129, -1278.200, 3.872)

		},
		Marker = {
            Type = 27,
			r = 102,
			g = 102,
			b = 204,
			Size = { 
                x = 1.5,  
                y = 1.5,  
                z = 1.0
            }
		},
		Blip = {
        	Text = "ร้านซือหน้ากาก",
            Scale = 0.5,
			Colour = 51,
			Sprite = 362,
			Display = 4,
		},
	},

	Clothes = {
	-- รายการที่อยู่ของร้านเสื้อ
		Pos = {

			vector3(72.3, -1399.1, 28.4),
			vector3(-703.8, -152.3, 36.4),
			vector3(-167.9, -299.0, 38.7),
			vector3(428.7, -800.1, 28.5),
			vector3(-829.4, -1073.7, 10.3),
			vector3(-1447.8, -242.5, 48.8),
			vector3(11.6, 6514.2, 30.9),
			vector3(123.6, -219.4, 53.6),
			vector3(1190.6, 2713.4, 37.3),
			vector3(-1193.4, -772.3, 16.3),
			vector3(933.42, -49.34, 77.92),
			vector3(-3172.5, 1048.1, 19.9)

		},
		Marker = {
            Type = 27,
			r = 102,
			g = 102,
			b = 204,
			Size = { 
                x = 1.5,  
                y = 1.5,  
                z = 1.0
            }
		},
		Blip = {
        	Text = "ร้านเสื้อผ้า",
            Scale = 0.5,
			Colour = 51,
			Sprite = 73,
			Display = 4,
		},
	},
	
	-- ร้าน ตู้เสื้อผ้า / สำหรับบ้านแก๊งหรือหน่วยงาน หรือเป็นวง ตู้เสื้อผ้า
	Villa = {

		Pos = {
			
			vector3(674.8637, 747.5621, 212.25),
			vector3(-1213.77, 2628.906, 22.257)


		},
		Marker = {
            Type = 27,
			r = 102,
			g = 102,
			b = 204,
			Size = { 
                x = 1.5,  
                y = 1.5,  
                z = 1.0
            }
		},
	},
	Barber = {
-- รายการที่อยู่ของร้านทำผม
		Pos = {

			vector3( -814.308,   -183.823,   36.568),
			vector3( 136.826,    -1708.373,  28.291),
			vector3( -1282.604,  -1116.757,  5.990),
			vector3( 1931.513,   3729.671,   31.844),
			vector3( 1212.840,   -472.921,   65.208),
			vector3( -32.885,    -152.319,   56.076)

		},
		Blip = {
        	Text = "ร้านตัดผม",
            Scale = 0.5,
			Colour = 51,
			Sprite = 71,
			Display = 4,
		},
		Marker = {
            Type = 27,
			r = 102,
			g = 102,
			b = 204,
			Size = { 
                x = 1.5,  
                y = 1.5,  
                z = 1.0
            }
		},
	},
}


function AlertnotifiEntermarker()
	-- textui ตอนเดินเข้า  Config.Texts
	-- exports["replayx.textui"]:ShowHelpNotification(Config.Texts,true)
	
	exports["Tn_Textui"]:ShowHelpNotification("กด ~INPUT_CONTEXT~ เพื่อเปิด")
end

function Alertnotifiexitmarker()
	-- textui ตอนเดินออก Config.Texts
	-- exports["replayx.textui"]:ShowHelpNotification(Config.Texts,false)
	-- exports["replayx.textui"]:ShowHelpNotification("กด ~INPUT_CONTEXT~ เพื่อเปิด")
end

