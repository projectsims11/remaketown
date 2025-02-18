--[[
    ================== เริ่มต้นพื้นฐาน ==================
    ** weight 1 = 1 กิโลกรัม | สามารถกำหนด 0.50 หรือ 0.01 ได้ **
    -- weight = น้ำหนัก            (0  = ไม่มีน้ำหนัก)
    -- limit = จำนวนไอเทมที่เก็บได้  (-1 = ไม่จำกัดจำนวน)
]]
Config.Item_Info_Weight_Default     = 0.5 -- ค่าเริ่มต้นของไอเทม
Config.Item_Info_Limit_Default      = -1    -- ค่าเริ่มต้นของจำกัดจำนวนไอเทม (-1 = ไม่จำกัดจำนวน)
Config.Item_Info_Cal                = 1000  -- หากใช้ประเป๋าประชารัชให้ปรับเป็น 1


--[[
    ================== ตั้งค่าไอเทม ==================
     ** weight 1 = 1 กิโลกรัม | สามารถกำหนด 0.50 หรือ 0.01 ได้ **
    weight = น้ำหนัก            (0  = ไม่มีน้ำหนัก)
    limit = จำนวนไอเทมที่เก็บได้  (-1 = ไม่จำกัดจำนวน)
]]
Config.Item_Info = {

    --['bread']                   = {weight = 1.00, limit = 10},
    ['water']                 = {weight = 0.500},

    --------------- Money ---------------
    ['money']                   = { weight = 0.00, limit = -1 },
    ['black_money']             = { weight = 0.00, limit = -1 },

    
    --------------- Weapon ---------------
    ['WEAPON_KNIFE']            = { weight = 0.00, limit = 0 },
    ['WEAPON_NIGHTSTICK']       = { weight = 0.00, limit = 0 },
    ['WEAPON_HAMMER']           = { weight = 0.00, limit = 0 },
    ['WEAPON_BAT']              = { weight = 0.00, limit = 0 },
    ['WEAPON_CROWBAR']          = { weight = 0.00, limit = 0 },
    ['WEAPON_GOLFCLUB']         = { weight = 0.00, limit = 0 },
    ['WEAPON_BOTTLE']           = { weight = 0.00, limit = 0 },
    ['WEAPON_DAGGER']           = { weight = 0.00, limit = 0 },
    ['WEAPON_HATCHET']          = { weight = 0.00, limit = 0 },
    ['WEAPON_MACHETE']          = { weight = 0.00, limit = 0 },
    ['WEAPON_FLASHLIGHT']       = { weight = 0.00, limit = 0 },
    ['WEAPON_SWITCHBLADE']      = { weight = 0.00, limit = 0 },
    ['WEAPON_POOLCUE']          = { weight = 0.00, limit = 0 },
    ['WEAPON_WRENCH']           = { weight = 0.00, limit = 0 },
    ['WEAPON_BATTLEAXE']        = { weight = 0.00, limit = 0 },
    ['WEAPON_KNUCKLE']          = { weight = 0.00, limit = 0 },
    ['WEAPON_PETROLCAN']        = { weight = 0.00, limit = 0 },
    ['WEAPON_STUNGUN']          = { weight = 0.00, limit = 0 },
    ['WEAPON_BOTTLE']           = { weight = 0.00, limit = 0 },
    ['WEAPON_MARKSMANPISTOL']   = { weight = 0.00, limit = 0 },
    ['WEAPON_COMBATPDW']        = { weight = 0.00, limit = 0 },
    ['WEAPON_BZGAS']            = { weight = 0.00, limit = 0 },
}


--[[
    ================== BlackList ไอเทมที่จะไม่ให้เก็บในหลังรถ ==================
]]
Config.Item_BlackList_Name = {
    "id_card",
    "id_driver",
    "money",
    "license_vault",
	"badge_authen",
	"badge_dusit",
	"badge_pathumwan",
	"badge_yothin",
	"Fewthz_reskin",
    "WEAPON_BAT",
	"WEAPON_DAGGER",
	"WEAPON_BOTTLE",
	"WEAPON_GOLFCLUB",
	"WEAPON_HATCHET",
	"WEAPON_KNUCKLE",
	"WEAPON_MACHETE",
	"WEAPON_POOLCUE",
	"WEAPON_SWITCHBLADE",
	"WEAPON_KNIFE",
	"WEAPON_NIGHTSTICK",
}