Config = {}

Config['Itemuse'] = "fishrod" -- คันเบ็ด
Config['Additem'] = "shrimp" -- ดรอปอะไร
Config['Drop'] = {1, 1} -- ดรอปเท่าไหร
Config['ต้องการให้ลบไอเท็มไหม'] = true -- true ต่องการ false ไม่ต้องการ
Config['Removeitem'] = "fishbait" -- ลบไอเท็มอะไร
Config['Timetoadd'] = 12 -- เวลาที่ได้ของ
Config['AddStatus'] = true -- ปิดลดอาหารระหว่าง afk
Config['เพิ่มอาหารไหม'] = false

Config['เปอร์เซ็นที่เบ็ดจะเเตก'] = 0 -- เปอร์เซนเป็นขาด

Config['BonusDrop'] = {
    {
        ItemName = "squid", -- ไอเท้ม
        ItemCount = {1, 1}, -- จำนวน
        Percent = 10 -- %.
	},
    {
        ItemName = "dolly_fish", -- ไอเท้ม
        ItemCount = {1, 1}, -- จำนวน
        Percent = 20 -- %
	},
    {
        ItemName = "shrimp", -- ไอเท้ม
        ItemCount = {1, 1}, -- จำนวน
        Percent = 100 -- %
	},

}

Config['Zone'] = {
    {
        Coords = vector3(3864.4756, 4464.0054, 2.7240),
        Distance = 25,
        Blips = {
            sprite = 68,
            scale = 1.2,
            color = 0,
            name = "<font face='font4thai'>สถานที่ตกปลา</font>"
        }
    },
}