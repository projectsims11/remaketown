Config = Config or {}

--======== [รายละเอียด Framework] ========--

Config['TriggerESX'] = 'esx:getSharedObject'

Config['InventoryCloseUi'] = 'Fewthz_inventory:closeInventory'

Config['TriggerInventory'] = 'Fewthz_ThiefPlayer:openPlayerInventory'

Config['Limit'] = true  --ใช้กระเป๋า limit หรือ น้ำหนัก

--======== [รายละเอียด Framework] ========--

Config['Cops'] = 0 -- ตำรวจใช้ปล้น
Config['AlertPolice'] = true  --ให้แจ้งเตือนตำรวจไหมในข้อความมือถือ
Config['PoliceAlert'] = "Fewthz_policealert:alertNet"
Config['PoliceType'] = "thief"

Config['EventProgbar'] = 'mythic_progbar:client:progress'
Config['TimeProgbar'] = 3500
Config['TextProgbar'] = 'กำลังปล้นผู้เล่น'

Config['DeathBodyTime'] = 150 --หลังจากตาย จะมีเวลากี่วิในการปล้นคนที่ตาย

-- อาวุธชนิดไหนที่อนุญาตให้ใช้ในการปล้น
Config['WeaponToAllowThief'] = { 
	"WEAPON_GOLFCLUB",
	"WEAPON_SWITCHBLADE",
	"WEAPON_BOTTLE",
}

Config['translate'] = {
	['player_have_item'] = 'ผู้เล่นเป็นผู้เล่นใหม่ไม่สามารถปล้นได้!',
	['player_thief_you'] = 'มีคนกำลังปล้นคุณอยู่!',
	['not_hand_up'] = 'ต้องให้ผู้เล่นยกมือก่อน',
	['weapon_use'] = 'ต้องใช้อาวุธที่กำหนดให้เท่านั้น',
	['not_distance'] = 'ไม่มีผู้เล่นอยู่ใกล้ๆ!',
	['not_target'] = 'ไม่มีเป้าหมายอยู่ใกล้ตัวคุณ!',
	['cops'] = 'ต้องการ '..Config['Cops']..' คน',
	---------------------------------------------------
	['cops_alert_sms'] = 'มีคนถูกปล้นที่ตำแหน่ง GPS : '
}
