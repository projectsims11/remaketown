--[[
	resource: Fewthz_ambulancealert
    warning: หากนำไปขายต่อหรือแจกจ่าย จะหยุดการ Support ทันที
]]
Config = {}
Config["base_key"] = 19
Config["base_key_text"] = "<b>ALT</b>" -- ชื่อปุ่มที่แสดงในแจ้งเตือน
Config["duration"] = 15 
Config["durationALT"] = 5
Config["worker_name"] = true			-- แสดงชื่อผู้รับเคส
Config["red_radius"] = 60.0 

Config["alert_section"] = {
	dead = true,
	call = true,
}

-- การ Setup โดยการวาง Event ที่ระบบหลัก
-- ถ้าเป็นไฟล์ Client ให้ TriggerEvent("Fewthz_ambulancealert:alertNet", "dead") -- เปลี่ยน event ได้
-- ถ้าเป็นไฟล์ Server ให้ TriggerClientEvent("Fewthz_ambulancealert:getalertNet", source, "dead") -- เปลี่ยน event ได้

Config["alert_position"] = "topRight" 

Config["translate"] = {
	title = "",
	male = "<span  style=\"color:red;\">ชาย</span>",
	female = "<span  style=\"color:red;\">หญิง</span>",
	text = "<span  style=\"color:white;\"></span> <span style=\"color:green;\"><b>%s</b></span> <span style=\"color:white;\"><br>เพศ <b>%s อยู่ที่ 📌 </span> <span style=\"color:orange;\"><b>%s</b></span>",
	tip = "<b> เพื่อรับงานนี้</b>",
	action_dead = "<span style=\"font-size:22px;color:pink;\">มีคนกำลังสลบ</span>",
	action_call = "<span style=\"font-size:22px;color:pink;\">ต้องการความช่วยเหลือ</span>",
}

function alertNotification(text)					-- แจ้งเตือนตอนมีคนตาย
	TriggerEvent("FewthzNotify:SendNotification", {
		text = text,
		layout = Config["alert_position"],
		queue = "ambulance_alert", 
		type = "alert2",
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
		timeout = Config["durationALT"] * 800,
	})
end

function SendGps()									-- ตอนขึ้นกดรับงาน gps
	TriggerEvent("FewthzNotify:SendNotification",  {
		text = "ตั้ง GPS ไปยังจุดเกิดเหตุแล้ว",
		queue = "ambulance_alert",
		type = "alert2",
		timeout = Config["durationALT"] * 800,
		layout = Config["alert_position"]
	})
end
