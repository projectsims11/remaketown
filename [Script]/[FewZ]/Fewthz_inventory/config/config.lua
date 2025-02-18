Config                      = {}

Config.Locale               = "en"

Config["IncludeIDCard"] = true				-- เปิด/ปิด หนังสือเดินทาง ในช่องเก็บของ
Config["IncludeWeapons"] = true				-- เปิด/ปิด อาวุธในช่องเก็บของ
Config["IncludeAccounts"] = true			-- เปิด/ปิด Accounts ในช่องเก็บของ
Config["ExcludeAccountsList"] = {"bank"}	-- อย่าแตะ
Config["EnableVehicleKey"] = true			-- เปิด/ปิด กุญแจยานพาหนะ ในช่องเก็บของ
Config["EnableHouseKey"] = false			-- เปิด/ปิด กุญแจบ้าน ในช่องเก็บของ
Config["EnableAccessory"] = true			-- เปิด/ปิด Accessory ในช่องเก็บของ
Config["EnableGiveUI"] = true				-- เปิด/ปิด UI การให้ของ
Config["EnableCommand"] = true				-- เปิด/ปิด คำสั่งปิดกระเป๋า
Config["ItemTradeCarkey"] = true			-- เปิด/ปิด ใช้ไอเทม ให้กุญแจ
Config["ItemTransferCar"] ='contract'		-- ไอเทมโอนรถ
Config["Command"] = "inv"					-- คำสั่งปิดกระเป๋า
Config["Open"] = "F2"						-- F2
Config["OpenQuickSlotBar"] = "TAB"			-- F2

Config['Category'] = {
    ["inventory_food"] = {
        "water",
        "bread",
    },
}

Config['CloseUiItems'] = { 					-- เวลาใช้ของปิดกระเป๋าเอง
	'bread',
	'water',
}

Config["DisableVault"] = { 					--บล็อกของตู้เซฟ
	-- Weapons
	WEAPON_BAT 			= true,
    WEAPON_GOLFCLUB 	= true,
	WEAPON_KNUCKLE 		= true,
    WEAPON_FLASHLIGHT 	= true,
    WEAPON_NIGHTSTICK 	= true,
	WEAPON_HAMMER 		= true,
	WEAPON_MACHETE 		= true,
	WEAPON_BOTTLE 		= false,
	WEAPON_STUNGUN 		= true,
	WEAPON_SWITCHBLADE 	= true,
    WEAPON_POOLCUE 		= true,
}

Config['disableDrop']          = 			-- ปิดกระดอป Item
{
	key 				= true,
    -- Weapons
	WEAPON_BAT 			= true,
    WEAPON_GOLFCLUB 	= true,
	WEAPON_KNUCKLE 		= true,
    WEAPON_FLASHLIGHT 	= true,
    WEAPON_NIGHTSTICK 	= true,
	WEAPON_HAMMER 		= true,
	WEAPON_MACHETE 		= true,
	WEAPON_BOTTLE 		= false,
	WEAPON_STUNGUN 		= true,
	WEAPON_SWITCHBLADE 	= true,
    WEAPON_POOLCUE 		= true,
}

Config['disableGive']          = 			-- ปิดการ Give Item
{
    -- Weapons
	 WEAPON_BAT 	    = true,
	 WEAPON_GOLFCLUB 	= true,
	 WEAPON_KNUCKLE 	= true,
	 WEAPON_FLASHLIGHT 	= true,
	 WEAPON_NIGHTSTICK 	= true,
	 WEAPON_HAMMER 		= true,
	 WEAPON_MACHETE 	= true,
	 WEAPON_BOTTLE 		= false,
	 WEAPON_STUNGUN 	= true,
	 WEAPON_SWITCHBLADE = true,
	 WEAPON_POOLCUE 	= true,
}