--[[
	file: config.lua
	resource: scotty-gachapon
	author: Scotty1944
	contact: https://www.facebook.com/Scotty1944/
	warning: หากนำไปขายต่อหรือแจกจ่าย หรือใช้ร่วมกันเกิน 1 server จะถูกยกเลิก license ทันที
]]

Config = {}
Config["debug"] = true -- โหมดพัฒนา
Config["wheel_duration"] = 10 -- ระยะเวลาที่ใช้ในการเปิดกาชา
Config["wheel_delay_award"] = true -- ให้ของในกาชาเมื่อจบ wheel_duration
Config["gachapon_broadcast"] = true -- ประกาศลงแชทเมื่อมีคนได้ของไหม ?

Config["gachapon_broadcast_top_message"] = true -- ประกาศรางวัลเป็นข้อความด้านบนแบบ Battle X
Config["gachapon_broadcast_top_message_duration"] = 2500 -- ระยะเวลาที่ประกาศ

Config["gachapon_broadcast_tier_limit"] = { -- ให้ประกาศเมื่อได้ของ tier อะไร

	[1] = false, -- Common ขยะ exp ~ % มากสุดในกาชา
	[2] = false, -- Rare ของทั่วไป แต่ไม่ถึงกับขยะ ~ % ขึ้นอยู่กับจำนวนของในกาชา ของเยอะ % เยอะ ของน้อย % น้อย
	[3] = false, -- Epic ของงานดำ ~ มากกว่า ของคราฟขึ้นอาวุธ แต่น้อยกว่า 5%
	[4] = true, -- Unique ของคราฟขึ้นอาวุธ ~ <5% ขึ้นอยู่กับความยากง่ายในการได้กาชา เช่น กาชา กิจกกรม ได้ง่ายกว่ากาชาโปรโมท
	[5] = true, -- Legendary ของรางวัลใหญ่ รถ, แฟชั่น, บัตร x2, บัตร VIP ~ <1%
}
Config["vehicle_plate_length_text"] = 3 -- ความยาวป้ายทะเบียนรถที่จะได้ ตัวอักษร
Config["vehicle_plate_length_number"] = 3 -- ความยาวป้ายทะเบียนรถที่จะได้ ตัวเลข
Config["vehicle_plate_check"] = true -- เช็คป้ายทะเบียนกับ SQL ว่าซ้ำกันไหม

Config["disable_auto_check_weapon"] = false -- ปิดระบบเช็คว่าไอเทมเป็นอาวุธไหม (ต้องเปิดหากเซิฟคุณเป็นแบบที่อาวุธเหมือนเป็นไอเทมชิ้นนึง)

--Config["vehicle_plate_func"] = function(src, hash) local text = "TEST 123" return text end -- ออกแบบป้ายทะเบียนเอง ใช้ไม่เป็นอย่าเปิดใช้โดยเด็ดขาด
--Config["vehicle_query"] = 'INSERT INTO owned_vehicles (owner, plate, vehicle, type, `stored`) VALUES (@owner, @plate, @vehicle, @type, 1)'

Config["image_source"] = "nui://Fewthz_inventory/html/img/items/"

Config["chance"] = {
	[1] = { name = "Common", rate = 50, color = "#242424", discord_color = 2368548 },
	[2] = { name = "Rare", rate = 40, color = "blue", discord_color = 255 },
	[3] = { name = "Epic", rate = 8, color = "purple", discord_color = 8388736 },
	[4] = { name = "Unique", rate = 1.7, color = "gold", discord_color = 13938487 },
	[5] = { name = "Legendary", rate = 1.0, color = "red", discord_color = 65280 },
}

Config["gachapon"] = {
	
	["gacha_promote"] = {
		name = "Gachapon กาชาแฟชั่น",
		list = {

			{ item = "stone_a", amount = 2, tier = 3 },
			{ money = 2000, tier = 2 },
			
		}
	},
	["gacha_02"] = {
		name = "Gachapon รถ R1",
		list = {

			{ item = "cabinet", amount = 2, tier = 2 },
			{ item = "coke", amount = 2, tier = 2 },
			{ item = "coke_pooch", amount = 5, tier = 3 },
			{ item = "copper_coin", amount = 5, tier = 4 },
			{ item = "diamond", amount = 5, tier = 3 },
			{ item = "gold_coin", amount = 5, tier = 4 },
			{ item = "silver_coin", amount = 5, tier = 4 },
			{ item = "tumra", amount = 10, tier = 4 },
			{ item = "water", amount = 5, tier = 1 },
			{ item = "bread", amount = 5, tier = 1 },
			{ item = "blueprint_Bat", amount = 2, tier = 4 },
			{ item = "blueprint_Pool", amount = 2, tier = 4 },
			{ item = "blueprint_golf", amount = 2, tier = 4 },
			{ item = "token_fail", amount = 1, tier = 3 },
			{ money = 500, tier = 1 },
			{ money = 1000, tier = 2 },
			{ money = 1500, tier = 2 },
			{ money = 2000, tier = 2 },
			{ vehicle = "r1", name = "รถมอไซต์ R1", tier = 5 },
			
		}
	},
	["gacha_03"] = {
		name = "Gachapon รถ R35",
		list = {

			{ item = "cabinet", amount = 2, tier = 2 },
			{ item = "coke", amount = 2, tier = 2 },
			{ item = "coke_pooch", amount = 5, tier = 3 },
			{ item = "copper_coin", amount = 5, tier = 4 },
			{ item = "diamond", amount = 5, tier = 3 },
			{ item = "gold_coin", amount = 5, tier = 4 },
			{ item = "silver_coin", amount = 5, tier = 4 },
			{ item = "tumra", amount = 10, tier = 4 },
			{ item = "water", amount = 5, tier = 1 },
			{ item = "bread", amount = 5, tier = 1 },
			{ item = "blueprint_Bat", amount = 2, tier = 4 },
			{ item = "blueprint_Pool", amount = 2, tier = 4 },
			{ item = "blueprint_golf", amount = 2, tier = 4 },
			{ item = "token_fail", amount = 1, tier = 3 },
			{ money = 500, tier = 1 },
			{ money = 1000, tier = 2 },
			{ money = 1500, tier = 2 },
			{ money = 2000, tier = 2 },
			{ vehicle = "rmodskyline", name = "รถยนต์ R35", tier = 5 },
			
		}
	},
}

Config["discord_bot"] = "Gachapon" -- ชื่อ Bot
Config["gacha_discord"] = {
	["item"] = "",
	["weapon"] = "",
	["money"] = "",
	["vehicle"] = "",
}

Config["translate"] = {
	broadcast_header = "^3^*Gachapon: ",
	broadcast_text = "คุณ ^6^*%s ^7^rได้รับ ^2%s ^7จาก ^3%s",
	broadcast_top_text = 'คุณ <span style="color:gold;">%s</span> ได้รับ <span style="color:lightgreen;">%s</span> จาก <span style="color:gold;">%s</span>',
	discord_gacha_unbox = "คุณ %s เปิดกาชาปอง %s แล้วได้ %s!",
	discord_identifier = "\nSteam Identifier: %s\nเวลา: %s",
	
	ui_you_got = "คุณได้รับ %s!",
	ui_exit = "ออก",
	ui_open_more = "เปิดต่อ (%s)",
	ui_black_money = "เงินแดง",
}