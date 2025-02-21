Config                        = {}

Config.Setiing = {
	ESX = false , -- true == เซิฟน้ำหนัก 1.2 / false == limit 1.1
	CloseInventory = 'Fewthz_inventory:closeInventory' ,
	Progressbar = 'mythic_progbar:client:progress' , --[ EVENTของหลอดโหลด หากไม่ใช้ mythic_progbarสามารถเปลี่ยน EVENTได้ ]
}

Config.Vault = {
	police = {
		coords = vector3(463.19, -985.32, 30.69-0.97),
		heading = 0.25,
		CheckGrade = true,
		JobGrade = 2, -- JobGrade คือ ตำแหน่งยศ ในการ เซ็ท โดยอิงตัวเลขเป็นหลัก
		VaultBox = 'p_v_43_safe_s',
		TEXT = "กด ~INPUT_CONTEXT~ เพื่อเปิด ~y~ตู้เซฟ",
		NotJob = 'คุณไม่ใช่เจ้าหน้าที่ตำรวจ',
	},
	ambulance = {
		coords = vector3(360.27, -1419.16, 32.51-0.97),
		heading = 49.64,
		CheckGrade = false,
		JobGrade = 2, -- JobGrade คือ ตำแหน่งยศ ในการ เซ็ท โดยอิงตัวเลขเป็นหลัก
		VaultBox = 'p_v_43_safe_s',
		TEXT = "กด ~INPUT_CONTEXT~ เพื่อเปิด ~y~ตู้เซฟ",
		NotJob = 'คุณไม่ใช่เจ้าหน้าที่หมอ',
	},
	-- mechanic = {
	-- 	coords = vector3(-41.82, -1064.19, 28.0-0.97),
	-- 	heading = 112.05,
	-- 	--JobGrade = 2, -- JobGrade คือ ตำแหน่งยศ ในการ เซ็ท โดยอิงตัวเลขเป็นหลัก
	-- 	VaultBox = 'p_v_43_safe_s',
	-- 	TEXT = "กด ~INPUT_CONTEXT~ เพื่อเปิด ~y~ตู้เซฟ ",
	-- 	NotJob = 'คุณไม่ใช่เจ้าหน้าที่ช่าง',
	-- },
}

Config.FewZ = {
	Custom = {
		Coords = vector3(1721.5317, 3318.7051, 41.2235),
		heading = 15.00,
		needItem = true, -- ใช้ needItemLicense เป็นการเปิดตู้
		needItemLicense = 'vault', -- ไอเทมในการเปิดตู้
		removeMoney = false, -- ลบเงินเมื่อเปิดตู้
		money = 100, -- จำนวนเงินในการลบในแต่ละครั้ง
		pNotify = 'pNotify:SendNotification',
		VaultBox = 'p_v_43_safe_s',
		TEXT = "กด ~INPUT_CONTEXT~ เพื่อเปิด ~y~ตู้เซฟ",
		P = 'vault' -- vault = ตู้ประชาชน
	},
}

Config.BlackListItemAll = {
	water = true,  -- ตัวอย่าง ชื่อ Item ที่ไม่ให้เก็บในตู้เซฟ
}

-- ใส่ข้อความการแจ้งเตือน
Config.Text = {
	NoItem = "<b style='color:#ffffff'>คุณไม่มี กุญแจ ตู้เซฟ!</b>",
	Nojobs = 'คุณไม่ได้รับอนุญาตเพราะไม่ใช่ยศของคุณ',
	BlacklistItem = "<b style='color:#ffffff'>คุณไม่สามารถเก็บ Item ชนิดนี้ได้ !</b>"
	
}