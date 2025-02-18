Config_items = Config_items or {}

-- อาวุธชนิดไหนที่มีอยู่ในตัวผู้เล่นไม่สามารถปล้นเขาได้ เล่น บัตรผู่เล่นใหม่
Config_items['BlacklistNotAllowItem'] = 
{
	"newplayer_card",
}

-- ไม่อนุญาติให้ปล้น ไอเทมชนิดไหน
Config_items['BlacklistItem'] = 
{
	"water",
	--"bread",
}

--  ไม่อนุญาติให้ปล้น อาวุธชนิดไหน
Config_items['BlacklistW'] = true
Config_items['BlacklistWeapon'] = 
{
	"WEAPON_BAT",
	--"WEAPON_BOTTLE",
}