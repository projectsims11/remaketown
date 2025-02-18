--[[
	resource: Fewthz_policealert
    warning: หากนำไปขายต่อหรือแจกจ่าย จะหยุดการ Support ทันที
]]
Config = {}
Config["base_key"] = 19 				-- ปุ่มหลักในการใช้ร่วมกับปุ่มตัวเลข เช่น ALT + 1
Config["base_key_text"] = "<b>ALT</b>" 	-- ชื่อปุ่มที่แสดงในแจ้งเตือน
Config["duration"] = 10 				-- ระยะเวลาที่จะตอบรับ
Config["red_radius"] = 60.0 			-- ขนาดของวงที่จะขึ้นบนแมพ เมื่อมีการแจ้งเตือน
Config["worker_name"] = true			-- แสดงชื่อผู้รับเคส
Config["alert_section"] = {
	carjacking = false,
	melee = false,
	gunshot = false,
}

-- การ Setup โดยการวาง Event ที่ระบบหลัก
-- ถ้าเป็นไฟล์ Client ให้ TriggerEvent("Fewthz_policealert:alertNet", "cement") -- เปลี่ยน event ได้
-- ถ้าเป็นไฟล์ Server ให้ TriggerClientEvent("Fewthz_policealert:getalertNet", source, "cement") -- เปลี่ยน event ได้

Config["alert_position"] = "topRight"
Config["translate"] = {
	title = "",
	male = "<span  style=\"font-size:20px;color:blue;\">ผู้ชาย</span>",
	female = "<span  style=\"font-size:20px;color:red;\">ผู้หญิง</span>",--[[ </b><br> ]]
	text = "<span  style=\"color:white;\"></span> <span style=\"color:green;\"><b>%s</b></span> <span style=\"color:white;\"><br>เพศ <b>%s อยู่ที่ 📌</span> <span style=\"color:orange;\"><b>%s</b></span>",
	tip = "<b> เพื่อไปจุดมาร์ค</b>",
	action_carjacking = "<span style=\"font-size:22px;color:red;\">โจรกรรมรถยนต์</span>",
	action_melee = "<span style=\"font-size:22px;color:red;\">ทำร้ายร่างกายผู้อื่น</span>",
	action_gunshot = "<span style=\"font-size:22px;color:red;\">ยิงปืน</span>",
}

Config["alert"] = {
	carjacking = {
		type = 'carjacking',																-- Event Name
		action = "<span style=\"font-size:22px;color:red;\">โจรกรรมรถยนต์</span>"			-- ตอนขึ้นแจ้งเตือน
	},
	drug = {
		type = 'drug',																-- Event Name
		action = "<span style=\"font-size:22px;color:red;\">ขายยา</span>"			-- ตอนขึ้นแจ้งเตือน
	},
	cement = {
		type = 'cement',
		action = "<span style=\"font-size:22px;color:red;\">ขโมยปูน</span>"
	},
	wire = {
		type = 'wire',
		action = "<span style=\"font-size:22px;color:pink;\">ขโมยสายไฟ</span>"
	},
	oil = {
		type = 'oil',
		action = "<span style=\"font-size:22px;color:pink;\">ขโมยน้ำมันดิบ</span>"
	},
	solution = {
		type = 'cabinet',
		action = "<span style=\"font-size:22px;color:pink;\">ขโมยของร้านค้า</span>"
	},
	thief = {
		type = 'thief',
		action = "<span style=\"font-size:22px;color:pink;\">ถูกปล้น</span>"
	},
	fishing = {
		type = 'fishing',
		action = "<span style=\"font-size:22px;color:white;\">มีคนตกเต๋า</span>"
	},
	burglary = {
		type = 'burglary',
		action = "<span style=\"font-size:22px;color:white;\">ปล้นบ้าน</span>"
	},
	capsule = {
		type = 'capsule',
		action = "<span style=\"font-size:22px;color:white;\">ขโมยแคปซูล</span>"
	},
	deadbag = {
		type = 'deadbag',
		action = "<span style=\"font-size:22px;color:white;\">อุ้มฆ่า</span>"
	},
	callpolice = {
		type = 'callpolice',
		action = "<span style=\"font-size:22px;color:white;\">ต้องการความช่วยเหลือ</span>"
	},
}

function alertNotification(text)					-- แจ้งเตือนตอนคนทำผิด
	TriggerEvent("FewthzNotify:SendNotification", {
		text = text,
		layout = Config["alert_position"],
		queue = "police_alert", 
		type = "alert",
		theme = "gta",
		timeout = Config["duration"] * 800,
	})
end

function worker_nameNotification(textaccept)		-- ตอนมีตำรวจรับงาน
	TriggerEvent("FewthzNotify:SendNotification", {
		text = textaccept,
		layout = Config["alert_position"],
		queue = "police_alert", 
		type = "alert",
		theme = "gta",
		timeout = Config["duration"] * 800,
	})
end

function SendGps()									-- ตอนขึ้นกดรับงาน gps
	TriggerEvent("FewthzNotify:SendNotification",  {
		text = "ตั้ง GPS ไปยังจุดเกิดเหตุแล้ว",
		type = "alert",
		timeout = 2000,
		layout = Config["alert_position"]
	})
end
