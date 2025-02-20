--[[
	developed by MRB

	discord: https://discord.gg/WQmuWdz46k
]]

Config["license_key"] = "MRB:GS5112T"

Config['Object_attach'] = {
	{
		Model = "ta_santabag", 
		Bone = 24818, 
		xPos = -1.055,
		yPos = -0.075,
		zPos = -0.05,
		xRot = 192.4,
		yRot = -92.4,
		zRot = 0.0,
	},
	{
		Model = "ta_santahat",
		Bone = 31086, 
		xPos = -0.02,
		yPos = -0.085,
		zPos = 0.005,
		xRot = 180.8,
		yRot = -89.6,
		zRot = 0.0,
	},
}

Config['BlacklistJobs'] = { --* อาชีพที่จะไม่โดน สุ่ม
	"police",
	"ambulance"
}

Config['BlacklistGroup'] = { --* ยศที่จะไม่โดนสุ่ม
	-- "superadmin"
}

Config['BlacklistZones'] = { --* จุดที่จะไม่ถูกสุ่ม
	{
		coords 	= vector3(-310.1400146484375, -935.25, 31.06999969482422),
		range 	= 66,
	},
	{
		coords 	= vector3(-5225.68017578125, 3210.530029296875, 782.469970703125),
		range 	= 150,
	},
	{
		coords 	= vector3(-4268.1298828125, -4312.66015625, 150.7299957275391),
		range 	= 100,
	},
	{
		coords 	= vector3(-2820.860107421875, -761.5499877929688, 6.65000009536743),
		range 	= 80,
	},
}


Config['Set_DefaultCommands'] = { --* วิธีใช้คำสั่ง  [/hunt เวลา เลขid] | แต่สามารถ เขียน [/hunt] ได้เวลาจะอ้างอิงจาก ที่ set ไว้ และ ผู้เล่นจะถูกสุ่ม 
	['command'] = 'hunt',
	['time'] 	= 1800,
	['timeShow'] 	= 20, --*  เวลาแจ้งเตือนตอนจบบ
	['Group_Allow'] = {
		"superadmin",
		"admin"
	}
}

Config['Systems'] = {
	['Onesync_Legacy_Or_Infinity'] = true, --* ถ้าใช้ Onesync Infinity ให้ปรับ true ถ้าใช้ Legacy ให้ปรับ false
	['Keys'] = 'E',
	['Show_Big_wanted'] = '/', --* โชว์รูปให้ใหญ่ขึ้น
	['Object'] = "ta_prop_treasure", --* ชื่อ Object ของ กล่อง
	['CustomMarker'] = "marker", --* ถ้าไม่ใช้ custom marker ใส่ nil
	['Show_Myself_Marker'] = true, --* ถ้าตั้งเป็น true จะมองเห็น marker บนหัวตัวเองด้วย
	['Show_Myself_Blip'] = true, --* ถ้าตั้งเป็น true จะมองเห็น blip ตัวเองบนแมพ
	['TimeLoot'] = 10, --* เวลาเก็บกล่อง
	['img_box'] = "img/box.png", --* รูปกล่อง
	['clientcoords'] = false, --* ถ้าปรับ true จะใช้การหาพิกัดจุดจากฝั่ง client
}


Config['ability'] = { --* จะมีผลสำหรับผู้ที่มี ค่าหัวเท่านั้น
	['onwater'] = { --* ถ้าเท้าเหยียบน้ำเลือดจะลด
		Enable = false,
		health = 2
	},
	['invehicle'] = { --* ถ้าอยู่บนรถเลือดจะลด
		Enable = false,
		health = 10
	},
	['Zones_Blacklist'] = { --* ถ้าอยู่ใน Zone ที่กำหนดเลือดจะลด
		{
			coords 	= vector3(-310.1400146484375, -935.25, 31.06999969482422),
			range 	= 65,
			health 	= 2 
		},
	}
}

Config['Sounds'] = {
	['Begin'] = "sounds/start.mp3",
	['Finish'] = "sounds/end.mp3"
}

Config['Blips'] = {
	Id = 458,
	Color = 1,
	Size = 1.2,
	Text = "~y~WANTED"
}

--[[
	สามารถเพิ่ม Type ให้กับ Reward ได้ Type จะมี 
	[ weapon | item | money | black_money ]
]]

Config['Reward'] = {
	['Gets'] = {
		{
			Type = "item",
			Itemname = "fixkit",
			count = {3,3},
			Percent = 100
		},
		{
			Itemname = "Box_1",
			count = {15,15},
			Percent = 100
		},
		{
			Type = "money",
			Itemname = "money",
			count = 5000,
			Percent = 100
		}
	},
	['Bonus'] = {
		-- {
		-- 	Type = "money",
		-- 	Itemname = "",
		-- 	count = {1,10},
		-- 	Percent = 30
		-- },
		-- {
		-- 	Itemname = "water",
		-- 	count = {1,2},
		-- 	Percent = 20
		-- },
		-- {
		-- 	Itemname = "bread",
		-- 	count = {1,1},
		-- 	Percent = 30
		-- },
	}
}

Config['Time']= { --ไม่รู้ใช้ได้ไหมนะ By Ruby
		{
			Hour = {12, 14},        -- Randomly picks an hour between 12 and 14
			Min = {30, 45},         -- Randomly picks a minute between 30 and 45
			Time = {300, 900}       -- Event duration between 300 and 900 seconds
		},
		{
			Hour = 18,              -- Fixed hour at 18 (6 PM)
			Min = 0,                -- Fixed minute at 0 (00 minutes)
			Time = 600              -- Event duration fixed at 600 seconds
		},
		{
			Hour = {20, 22},        -- Random hour between 8 PM and 10 PM
			Min = {15, 30},         -- Random minute between 15 and 30
			Time = {500, 1000}      -- Random duration between 500 and 1000 seconds
		}
	}
