Config                      = {}


Config.Locale               = "en"
Config.IncludeCash          = true -- แสดงเงินในกระเป๋า ( กระเป๋าผู้เล่นคนอื่น * ตอนปล้น * )
Config.IncludeWeapons       = true -- แสดง Weapons ในกระเป๋า
Config.ExcludeAccountsList  = {'bank'}   -- List of accounts names to exclude from inventory
Config.IncludeAccounts      = true
Config.CacheFastSlot = true -- ออกเข้าเกมใหม่ Fast Slot ยังอยู่เหมือนเดิม
Config.Keys          = 'T'  -- Key ในการเปิดกระเป๋า
Config.BlurBackdrop = false -- เบลอพื้นหลัง
Config.Delay = { -- ดีเลย์การเปิดกระเป๋า หลังจากปิดกระเป๋า
	Enable = true,
	Length = 200
}
------------------------ กุญแจ ------------------------

Config.Items = true -- เปิดปิด บัตรประชาชน / true = เปิด / false = ปิด
Config.EnableVehicleKey = true -- เปิดปิด Key รถ

-- Config.UserLicense = "Fz_1gpi287jb6t64nsnv1jj"

----- ปิดกระเป๋า Command
Config.CloseCommand = 'closebag'

----- ใช้ของปิดกระเป๋า
Config.CloseUiItems = { -- เวลาใช้ของปิดกระเป๋าเอง
 	'reskin_card',
	'sandwich',
	'Pinto_Agency',
	'crab_food',
	'roast_pork',
	'Wagyu_Beef',
	'burger',
	'Wine',
	'new_player',
	'car_brioso',
	'radio',
	'repair_kit',
	'repair_agency',
	'fishing_rod',
    'car_transfer',
	-- 'gacha_02',
	-- 'gacha_03'
}

----- ปิดการทิ้ง
Config.disableDrop      = -- ปิดกระดอป Item
{
    -- อาวุธ --
	WEAPON_BATLV1 		= true,
    WEAPON_GOLFLV1 		= true,
	WEAPON_KNUCKLE 		= true,
    WEAPON_FLASHLIGHT 	= true,
    WEAPON_NIGHTSTICK 	= true,
	WEAPON_HAMMER 		= true,
	WEAPON_MACHETE 		= true,
	WEAPON_BOTTLE 		= true,
	WEAPON_STUNGUN 		= true,
	WEAPON_SWITCHBLADE 	= true,
    WEAPON_POOLCUE 		= true,
    
    -- ไอเท็ม -- 

	-- water 				= true,
}


Config.Dontuse = --ไม่สามารถลากไอเทมอะเข้า slot ได้บ้าง 
{
	-- water = true, --นํ้า
	-- bread = true, --ขนมปัง
}

