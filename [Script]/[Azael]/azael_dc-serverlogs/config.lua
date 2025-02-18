-----------------------------------------------
-----------------------------------------------
--  Script    : DC - Server logs (Webhook)   --
--  Developer : Azael Dev 	                 --
--  Website   : www.azael.dev                --
--  Facebook  : www.fb.com/AzaelDev.78       --
-----------------------------------------------
-----------------------------------------------
Config = {}

Config['esx_routers'] = {								-- เส้นทางกิจกรรมของทรัพยากร ESX Framework
	['server_shared_obj'] = 'esx:getSharedObject',		-- หาก es_extended เซิร์ฟเวอร์ของคุณ มีการแก้ไขชื่อกิจกรรมของทรัพยากร เพื่อป้องกันโปรแกรมโกงต่าง ๆ
	['client_shared_obj'] = 'esx:getSharedObject',		-- คุณสามารถแก้ไขการตั้งค่าในส่วนนี้ให้ตรงกับชื่อกิจกรรมของทรัพยากรนั้น ๆ ได้
	['server_player_load'] = 'esx:playerLoaded'			-- หมายเหตุ: ห้ามแก้ไขการตั้งค่าในส่วนนี้โดยเด็ดขาด หากคุณไม่เข้าใจว่าสิ่งนี้คืออะไร เพราะอาจจะทำให้ทรัพยากรเกิดข้อผิดพลาดได้
}

Config['webhook_image'] = 'https://cdn.discordapp.com/attachments/732506382300872724/825340212095483904/Fewthz.png'		-- ลิ้งค์ที่อยู่รูปภาพ

Config['color'] = {							-- Decimal Colors: https://convertingcolors.com
	['^0'] = 16777215,						-- White #ffffff
	['^1'] = 16729156,						-- Light Red #ff4444
	['^2'] = 10079232,						-- Strong Green #99cc00
	['^3'] = 16759603,						-- Vivid Orange #ffbb33
	['^4'] = 39372,							-- Strong Blue #0099cc
	['^5'] = 3388901,						-- Bright Blue #33b5e5
	['^6'] = 11167436,						-- Moderate Violet #aa66cc
	['^7'] = 10070709,						-- Grayish Blue #99aab5
	['^8'] = 13369344,						-- Strong Red #cc0000
	['^9'] = 13369448						-- Strong Pink #cc0068
}


Config['color'] = {							-- Decimal Colors: https://convertingcolors.com
	['^0'] = 16777215,						-- White #ffffff
	['^1'] = 16729156,						-- Light Red #ff4444
	['^2'] = 10079232,						-- Strong Green #99cc00
	['^3'] = 16759603,						-- Vivid Orange #ffbb33
	['^4'] = 39372,							-- Strong Blue #0099cc
	['^5'] = 3388901,						-- Bright Blue #33b5e5
	['^6'] = 11167436,						-- Moderate Violet #aa66cc
	['^7'] = 10070709,						-- Grayish Blue #99aab5
	['^8'] = 13369344,						-- Strong Red #cc0000
	['^9'] = 13369448						-- Strong Pink #cc0068
}

Config['webhook'] = {										-- ลิ้งค์ Discord Webhook (บรรทัดสุดท้ายจะต้องไม่มีเครื่องหมาย , เพราะอาจจะทำให้สคริปต์ Error)
	['Login'] = '#',					-- เชื่อมต่อกับเซิร์ฟเวอร์
	['Logout'] = '#',					-- ตัดการเชื่อมต่อเซิร์ฟเวอร์
	['Chat'] = '#',					-- ข้อความแชท
	['Dead'] = '#',					-- สาเหตุการเสียชีวิต
	['AdminCommands'] = '#',			-- ใช้คำสั่ง-แอดมิน
	['GiveItem'] = '#',				-- ไอเทม-รับ-ส่ง
	['GiveMoney'] = '#',			-- เงินเขียว-รับ-ส่ง
	['GiveDirtyMoney'] = '#',			-- เงินแดง-รับ-ส่ง
	['GiveWeapon'] = '#',				-- อาวุธ-รับ-ส่ง
	['RemoveItem'] = '#',				-- ไอเทม-ทิ้ง
	['itemCount'] = '#',				-- เงินเขียว-ทิ้ง
	['RemoveDirtyMoney'] = '#',		-- เงินแดง-ทิ้ง
	['UseItem'] = '#',				-- ใช้งาน-ไอเทม
	['PickupItem'] = '#',				-- ไอเทม-เก็บจากพื้น
	['PickupMoney'] = '#',			-- เงินเขียว-เก็บจากพื้น 
}
