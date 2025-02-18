Config = {}
Config.Locale = 'en'
Config.AutoBillTime = 30 * 60 -- เวลาในการตัดบิลออโต้

Config.SocietyBill = true  --- true = ปรับบิลเงินเข้าหน่วยงาน false = เข้าตัวคนให้บิล
Config.BillCutUse = true
Config.BillCut = { --แบ่งให้กับคนส่งบิล
	society_police = 50,
	society_mechanic = 50,
	society_ambulance = 50
}

-- หากไม่มีเงินจ่าบบิลออโต้จะส่งเข้าคุก
Config.JailTime = nil -- เวลาควรจะน้อยกว่าเวลาวนรอบตัดบิล เผื่อให้มีโอกาสได้จ่ายบิลก่อน / -- ถ้าไม่ใช้ให้ใส่ nil ถ้าใช้ใส่เวลาไปได้เลย
Config.AnouceText = "บุคคลล้มละลาย" -- ข้อความประกาศข้อหา
Config.JailPositions = { -- พิกัดที่จะให้ เข้า / ออก คุก
	-- ตำแหน่งคุกย่อย
	["CellSpe"] = { ["x"] = 244.63, ["y"] = -813.03, ["z"] = 30.97, ["h"] = 69.72 },
	-- ตำแหน่งจุดออก
	["OutCellSpe"] = { ["x"] = 248.58, ["y"] = -800.07, ["z"] = 31.01, ["h"] = 69.82 },
}