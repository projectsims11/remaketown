Config = {}

--@ ป้องกันบัค
Config['ป้องกันการบัคจากผู้เล่น'] = true  --@ ถ้าผู้เล่นบัค อุ้มออกจุด ระเบิดตามลงหัวทันที

Config.esx = 'limit' -- limit, weight

Config.Item = 'cement'          --[ไอเทมที่จะได้รับ ชื่อไอเทมต้องตรงกับ SQL]
Config.ItemCount = 1            --[จำนวน ไอเทมที่จะได้รับ]

Config.ItemNeed = {             --[ไอเทมที่ต้องใช้ในการขโมย]
    Enabel = false ,             --[true ไม่ใช้ / false ใช้]
    Item = 'stone_a' ,            --[ไอเทมที่กำหนด]
}

Config.UseFarfromCity = true	--[กำหนดขอบเขตการขโมยปูน false ปิดขโมยได้ทุกที่ true กำหนดขอบเขต]
Config.Location = vector3(-258.0, -978.2, 31.2)
Config.FarfromCity = 1200  	    --[ระยะห่างจากเมืองหลวง JobCenter]

Config.Cops = 1                 --[จำนวน ตำรวจ]

Config.Duration = 60 * 5        --[ระยะเวลา คูลดาว จุดที่ขโมยไปแล้ว ตัวอย่าง 60 * 1 = 1 นาที]
Config.Load   = 30000           --[ระยะเวลาหลอดโหลด ในขณะที่กำลังจก 1000 = 1 วิ ]

Config.AlertPolice = {          --[Eventแจ้งเตือนตำรวจ]
	script = { 
        Alert = true,
		Event = "Fewthz_policealert:alertNet",     --[Eventแจ้งเตือนตำรวจ ใช้ EVENT ของฝั่ง Client]
		source = "cement"
    }, 
}

Config.NoallowJob = {           --[ไม่อนุญาตงาน]
    'police',
    'ambulance',
}

Config.Prop = {                 -- Prop
    GetHashKey("prop_cementbags01"),
	GetHashKey("prop_cons_cements01")
}