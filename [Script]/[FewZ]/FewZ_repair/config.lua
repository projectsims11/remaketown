Config = {}

Config.Time = 10 -- เวลาระบุเป็นวินาที

Config.Ped = 's_m_m_gaffer_01' -- NPC

Config.Blip ='<font face="sarabun">จุดซ่อมรถ</font>'

Config.Coords = { -- จุดซ่อม
    { x = 170.7516, y = -1078.43, z = 29.192, h = 73.981 },
    { x = 1704.106, y = 3773.828, z = 34.536, h = 217.02 },
    { x = 45.98354, y = 6602.658, z = 32.016, h = 238.65 },
    { x = -373.366, y = -104.320, z = 38.692, h = 160.891 },
}

Config.Type = {
    Repair = {
        Case = Repair,
		text = 'ซ่อมเครื่องยนต์ ( 1500 )',
        price = 1500,
	},
    Repairout = {
        Case = Repairout,
		text = 'ซ่อมภายนอก ( 1000 )',
        price = 1000,
	},
    Repairall = {
        Case = Repairall,
		text = 'ซ่อมทั้งหมด ( 2000 )',
        price = 2000,
	},
    Check = {
        Case = Check,
		text = 'เช็คค่ารถ ( 1 )',
        price = 1,
	},
    Wash ={
        Case = Wash,
		text = 'ล้างรถ ( 500 )',
        price = 500,
    },
}

Config['Blacklist'] = { -- รถที่ซ่อมไม่ได้
    'BMX',
    'ACTROS',
    'DAF',
    'MAN',
    'T680',
}