Config = {}
Config.Locale = 'th'
-- mythic_progbar
-- xsound
-- https://github.com/Xogy/xsound
-- เว็บเข้ารหัส  https://ganlvtech.github.io/lua-simple-encrypt/  ไม่ค่อยเเนะนำถอดง่าย
Config.opendoor = 38	-- E
Config.bommdoor = 47	-- G
Config.label = 'กำลังวางระเบิด'  -- เวลาในการวางระเบิด

-- ##### เกั่ยวกับเสียง
Config.sound  	= "https://youtu.be/v71OuBoOu_g"
Config.timesetboom = 20000  -- เวลาในการวางระเบิด
Config.timerA = 10000 -- เวลาก่อนระเบิด
Config.timerB = 3800 -- เวลาก่อนเกิดเสียง		ขึ้นอยู่กับความยาวคริปเสียง
-- #####

-- ##  เกียวกับระเบิด
Config.integer  	= 0 -- ประเภทระเบิด
Config.damage  	= 1065353216 -- ความเสียหาย
Config.sounds  		= true -- เสียง
Config.invisible  	= false -- มองไม่เห็น
Config.camera  	= 1065353216 -- กล้องสั่น

Config.item	= 'BoomDoor'
Config.itemremove	= 1  -- จำนวนเสีย item

Config.repairitem	= 'RepairDoor'
Config.repairremove	= 1  -- จำนวนเสีย item

alertpolice = function() --ฟังชั่นนี้สำหรับเรียกตำรวจ
	TriggerEvent("Fewthz_policealert:alertNet", "boom")
	local PedPosition = GetEntityCoords(playerped)
	local PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z }
	TriggerServerEvent('esx_addons_gcphone:startCall', 'police', 'เกิดเหตุระเบิด', PlayerCoords, {
		PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z },
	})
end

Config.DoorList = {

	{
		objHash = GetHashKey('gabz_mrpd_room13_parkingdoor'),
		objHeading = 90.0,
		objCoords = vector3(463.74, -997.55, 26.28),
		textCoords = vector3(463.74, -997.55, 26.28),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		maxDistance = 1.25
	},

	{
		objHash = GetHashKey('gabz_mrpd_room13_parkingdoor'),
		objHeading = 270.0,
		objCoords = vector3(464.63, -974.77, 26.27),
		textCoords = vector3(464.63, -974.77, 26.27),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		maxDistance = 1.25
	},

	{
		objHash = GetHashKey('gabz_mrpd_door_04'),
		objHeading = 0.0,
		objCoords = vector3(440.48, -978.05, 30.69),
		textCoords = vector3(441.28, -977.98, 31.69),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		maxDistance = 1.25
	},

	{
		objHash = GetHashKey('gabz_mrpd_door_05'),
		objHeading = 180.0,
		objCoords = vector3(440.5, -985.84, 30.69),
		textCoords = vector3(441.28, -986.98, 31.69),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		maxDistance = 1.25
	},

	{
		textCoords = vector3(434.7, -982.0, 31.5),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true, -- ล็อคประตู
		boom = true, -- เปิดใช้ วางระเบิดประตู
		item = true, -- เปิดใช้ ไอเทมสำหรับ คนที่ไม่ใช่หน่วยงาน
		itemname = '7day',	-- ไอเทมสำหรับคนที่ไม่ใช่หน่วยงาน
		remove = false, -- ลบไอเทมสำหรับคนที่ไม่ใช่หน่วยงานเมื่อเปิดประตู
		maxDistance = 2.5,
		doors = {
			{objHash = GetHashKey('gabz_mrpd_reception_entrancedoor'), objHeading = 270.0, objCoords = vector3(434.7, -980.6, 30.8)},
			{objHash = GetHashKey('gabz_mrpd_reception_entrancedoor'), objHeading = 90.0, objCoords = vector3(434.7, -983.2, 30.8)}
		}
	},

	{
		textCoords = vector3(457.02, -972.08, 30.71),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		boom = false, -- เปิดใช้ วางระเบิดประตู
		item = false, -- เปิดใช้ ไอเทมสำหรับ คนที่ไม่ใช่หน่วยงาน
		itemname = '7day',	-- ไอเทมสำหรับคนที่ไม่ใช่หน่วยงาน
		remove = false, -- ลบไอเทมสำหรับคนที่ไม่ใช่หน่วยงานเมื่อเปิดประตู
		maxDistance = 2.5,
		doors = {
			{objHash = GetHashKey('gabz_mrpd_reception_entrancedoor'), objHeading = 0.0, objCoords = vector3(456.08, -971.7, 30.71)},
			{objHash = GetHashKey('gabz_mrpd_reception_entrancedoor'), objHeading = 180.0, objCoords = vector3(457.83, -971.72, 30.71)}
		}
	},


	{
		textCoords = vector3(441.89, -998.81, 31.73),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		boom = false, -- เปิดใช้ วางระเบิดประตู
		item = false, -- เปิดใช้ ไอเทมสำหรับ คนที่ไม่ใช่หน่วยงาน
		itemname = '7day',	-- ไอเทมสำหรับคนที่ไม่ใช่หน่วยงาน
		remove = false, -- ลบไอเทมสำหรับคนที่ไม่ใช่หน่วยงานเมื่อเปิดประตู
		maxDistance = 2.5,
		doors = {
			{objHash = GetHashKey('gabz_mrpd_reception_entrancedoor'), objHeading = 180.0, objCoords = vector3(442.75, -998.86, 30.73)},
			{objHash = GetHashKey('gabz_mrpd_reception_entrancedoor'), objHeading = 0.0, objCoords = vector3(440.73, -998.64, 30.73)}
		}
	},



	{
		objHash = GetHashKey('gabz_mrpd_cells_door'),
		objHeading = 180.0,
		objCoords = vector3(484.86, -1007.8, 26.29),
		textCoords = vector3(484.86, -1007.8, 26.29),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		maxDistance = 1.25
	},
	{
		objHash = GetHashKey('gabz_mrpd_cells_door'),
		objHeading = -90.0,
		objCoords = vector3(476.17, -1008.9, 26.27),
		textCoords = vector3(476.17, -1008.9, 26.27),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		maxDistance = 1.25
	},

	{
		objHash = GetHashKey('gabz_mrpd_cells_door'),
		objHeading = 180.0,
		objCoords = vector3(481.04, -1003.67, 26.27),
		textCoords = vector3(481.04, -1003.67, 26.27),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		maxDistance = 1.25
	},
	{
		textCoords = vector3(470.9, -1009.01, 26.27),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		boom = false, -- เปิดใช้ วางระเบิดประตู
		item = false, -- เปิดใช้ ไอเทมสำหรับ คนที่ไม่ใช่หน่วยงาน
		itemname = '7day',	-- ไอเทมสำหรับคนที่ไม่ใช่หน่วยงาน
		remove = false, -- ลบไอเทมสำหรับคนที่ไม่ใช่หน่วยงานเมื่อเปิดประตู
		maxDistance = 2.5,
		doors = {
			{objHash = GetHashKey('gabz_mrpd_door_02'), objHeading = 90.0, objCoords = vector3(470.95, -1010.29, 26.27)},
			{objHash = GetHashKey('gabz_mrpd_door_02'), objHeading = 270.0, objCoords = vector3(470.95, -1007.69, 26.27)}
		}
	},

	{
		textCoords = vector3(468.72, -1000.97, 26.27),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		boom = false, -- เปิดใช้ วางระเบิดประตู
		item = false, -- เปิดใช้ ไอเทมสำหรับ คนที่ไม่ใช่หน่วยงาน
		itemname = '7day',	-- ไอเทมสำหรับคนที่ไม่ใช่หน่วยงาน
		remove = false, -- ลบไอเทมสำหรับคนที่ไม่ใช่หน่วยงานเมื่อเปิดประตู
		maxDistance = 2.5,
		doors = {
			{objHash = GetHashKey('gabz_mrpd_door_01'), objHeading = 180.0, objCoords = vector3(469.9, -1001.07, 26.27)},
			{objHash = GetHashKey('gabz_mrpd_door_01'), objHeading = 0.0, objCoords = vector3(467.37, -1001.02, 26.27)}
		}
	},


	{
		textCoords = vector3(468.78, -1014.81, 26.39),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		boom = false, -- เปิดใช้ วางระเบิดประตู
		item = false, -- เปิดใช้ ไอเทมสำหรับ คนที่ไม่ใช่หน่วยงาน
		itemname = '7day',	-- ไอเทมสำหรับคนที่ไม่ใช่หน่วยงาน
		remove = false, -- ลบไอเทมสำหรับคนที่ไม่ใช่หน่วยงานเมื่อเปิดประตู
		maxDistance = 2.5,
		doors = {
			{objHash = GetHashKey('gabz_mrpd_door_03'), objHeading = 180.0, objCoords = vector3(469.75, -1014.88, 26.39)},
			{objHash = GetHashKey('gabz_mrpd_door_03'), objHeading = 0.0, objCoords = vector3(467.48, -1014.88, 26.39)}
		}
	},
	
	------------------------- บ้านแก๊ง 1
	{
		textCoords = vector3(-3044.800048828125, 1514.3800048828125, 31.10000038146972), --
		authorizedJobs = { },
		locked = true, -- ล็อคประตู
		boom = true, -- เปิดใช้ วางระเบิดประตู
		item = true, -- เปิดใช้ ไอเทมสำหรับ คนที่ไม่ใช่หน่วยงาน
		itemname = '7day',	-- ไอเทมสำหรับคนที่ไม่ใช่หน่วยงาน
		remove = false, -- ลบไอเทมสำหรับคนที่ไม่ใช่หน่วยงานเมื่อเปิดประตู
		maxDistance = 2.5,
		doors = {
			{objHash = GetHashKey('left_ilev_fh_frontdoor'), objHeading = 65.0, objCoords = vector3(-3044.85009765625, 1513.25, 31.10000038146972)},
			{objHash = GetHashKey('right_ilev_fh_frontdoor'), objHeading = 65.0, objCoords = vector3(-3043.8798828125, 1515.3499755859375, 31.10000038146972)}
		}
	},

	{
		textCoords = vector3(-3054.909912109375, 1519.1600341796875, 31.68000030517578), --
		authorizedJobs = { },
		locked = true, -- ล็อคประตู
		boom = true, -- เปิดใช้ วางระเบิดประตู
		item = true, -- เปิดใช้ ไอเทมสำหรับ คนที่ไม่ใช่หน่วยงาน
		itemname = '7day',	-- ไอเทมสำหรับคนที่ไม่ใช่หน่วยงาน
		remove = false, -- ลบไอเทมสำหรับคนที่ไม่ใช่หน่วยงานเมื่อเปิดประตู
		maxDistance = 2.5,
		doors = {
			{objHash = GetHashKey('left_ilev_fh_frontdoor'), objHeading = -115.0, objCoords = vector3(-3054.590087890625, 1520.22998046875, 31.68000030517578)},
			{objHash = GetHashKey('right_ilev_fh_frontdoor'), objHeading = -115.0, objCoords = vector3(-3055.5400390625, 1518.1300048828125, 31.68000030517578)}
		}
	},
	------------------------- บ้านแก๊ง 2
	{
		textCoords = vector3(-22.09000015258789, 2106.1201171875, 163.94000244140625), --
		authorizedJobs = { },
		locked = true, -- ล็อคประตู
		boom = true, -- เปิดใช้ วางระเบิดประตู
		item = true, -- เปิดใช้ ไอเทมสำหรับ คนที่ไม่ใช่หน่วยงาน
		itemname = '7day',	-- ไอเทมสำหรับคนที่ไม่ใช่หน่วยงาน
		remove = false, -- ลบไอเทมสำหรับคนที่ไม่ใช่หน่วยงานเมื่อเปิดประตู
		maxDistance = 2.5,
		doors = {
			{objHash = GetHashKey('left_ilev_fh_frontdoor'), objHeading = 37.0, objCoords = vector3(-22.94000053405761, 2105.389892578125, 163.94000244140625)},
			{objHash = GetHashKey('right_ilev_fh_frontdoor'), objHeading = 37.0, objCoords = vector3(-21.23999977111816, 2106.72998046875, 163.94000244140625)}
		}
	},

	{
		textCoords = vector3(-28.8700008392334, 2115.010009765625, 164.6199951171875), --
		authorizedJobs = { },
		locked = true, -- ล็อคประตู
		boom = true, -- เปิดใช้ วางระเบิดประตู
		item = true, -- เปิดใช้ ไอเทมสำหรับ คนที่ไม่ใช่หน่วยงาน
		itemname = '7day',	-- ไอเทมสำหรับคนที่ไม่ใช่หน่วยงาน
		remove = false, -- ลบไอเทมสำหรับคนที่ไม่ใช่หน่วยงานเมื่อเปิดประตู
		maxDistance = 2.5,
		doors = {
			{objHash = GetHashKey('left_ilev_fh_frontdoor'), objHeading = -143.0, objCoords = vector3(-28.09000015258789, 2115.669921875, 164.6199951171875)},
			{objHash = GetHashKey('right_ilev_fh_frontdoor'), objHeading = -143.0, objCoords = vector3(-29.80999946594238, 2114.340087890625, 164.6199951171875)}
		}
	},
	------------------------- บ้านแก๊ง 3
	{
		textCoords = vector3(1090.0999755859375, 1513.550048828125, 178.1300048828125), --
		authorizedJobs = { },
		locked = true, -- ล็อคประตู
		boom = true, -- เปิดใช้ วางระเบิดประตู
		item = true, -- เปิดใช้ ไอเทมสำหรับ คนที่ไม่ใช่หน่วยงาน
		itemname = '7day',	-- ไอเทมสำหรับคนที่ไม่ใช่หน่วยงาน
		remove = false, -- ลบไอเทมสำหรับคนที่ไม่ใช่หน่วยงานเมื่อเปิดประตู
		maxDistance = 2.5,
		doors = {
			{objHash = GetHashKey('left_ilev_fh_frontdoor'), objHeading = -60.0, objCoords = vector3(1089.5400390625, 1514.6500244140625, 178.1300048828125)},
			{objHash = GetHashKey('right_ilev_fh_frontdoor'), objHeading = -60.0, objCoords = vector3(1090.6099853515625, 1512.56005859375, 178.1300048828125)}
		}
	},

	{
		textCoords = vector3(1099.8800048828125, 1519.280029296875, 178.52999877929688), --
		authorizedJobs = { },
		locked = true, -- ล็อคประตู
		boom = true, -- เปิดใช้ วางระเบิดประตู
		item = true, -- เปิดใช้ ไอเทมสำหรับ คนที่ไม่ใช่หน่วยงาน
		itemname = '7day',	-- ไอเทมสำหรับคนที่ไม่ใช่หน่วยงาน
		remove = false, -- ลบไอเทมสำหรับคนที่ไม่ใช่หน่วยงานเมื่อเปิดประตู
		maxDistance = 2.5,
		doors = {
			{objHash = GetHashKey('left_ilev_fh_frontdoor'), objHeading = 120.0, objCoords = vector3(1100.5799560546875, 1518.56005859375, 178.52999877929688)},
			{objHash = GetHashKey('right_ilev_fh_frontdoor'), objHeading = 120.0, objCoords = vector3(1099.18994140625, 1520.25, 178.52999877929688)}
		}
	},

	------------------------- บ้านแก๊ง 4
	{
		textCoords = vector3(1377.280029296875, -2622.239990234375, 52.22000122070312), --
		authorizedJobs = { },
		locked = true, -- ล็อคประตู
		boom = true, -- เปิดใช้ วางระเบิดประตู
		item = true, -- เปิดใช้ ไอเทมสำหรับ คนที่ไม่ใช่หน่วยงาน
		itemname = '7day',	-- ไอเทมสำหรับคนที่ไม่ใช่หน่วยงาน
		remove = false, -- ลบไอเทมสำหรับคนที่ไม่ใช่หน่วยงานเมื่อเปิดประตู
		maxDistance = 2.5,
		doors = {
			{objHash = GetHashKey('left_ilev_fh_frontdoor'), objHeading = -170.0, objCoords = vector3(1378.64648, -2622.28955, 52.39042)},
			{objHash = GetHashKey('right_ilev_fh_frontdoor'), objHeading = -170.0, objCoords = vector3(1376.09253, -2622.73975, 52.39042)}
		}
	},

	{
		textCoords = vector3(1379.3299560546875, -2633.6298828125, 52.79000091552734), --
		authorizedJobs = { },
		locked = true, -- ล็อคประตู
		boom = true, -- เปิดใช้ วางระเบิดประตู
		item = true, -- เปิดใช้ ไอเทมสำหรับ คนที่ไม่ใช่หน่วยงาน
		itemname = '7day',	-- ไอเทมสำหรับคนที่ไม่ใช่หน่วยงาน
		remove = false, -- ลบไอเทมสำหรับคนที่ไม่ใช่หน่วยงานเมื่อเปิดประตู
		maxDistance = 2.5,
		doors = {
			{objHash = GetHashKey('left_ilev_fh_frontdoor'), objHeading = 10.0, objCoords = vector3(1378.03345, -2633.8147, 52.95304)},
			{objHash = GetHashKey('right_ilev_fh_frontdoor'), objHeading = 10.0, objCoords = vector3(1380.588, -2633.365, 52.95304)}
		}
	},

	------------------------- บ้านแก๊ง 5
	{
		textCoords = vector3(-1230.8199462890625, 2627.2900390625, 18.95000076293945), --
		authorizedJobs = { },
		locked = true, -- ล็อคประตู
		boom = true, -- เปิดใช้ วางระเบิดประตู
		item = true, -- เปิดใช้ ไอเทมสำหรับ คนที่ไม่ใช่หน่วยงาน
		itemname = '7day',	-- ไอเทมสำหรับคนที่ไม่ใช่หน่วยงาน
		remove = false, -- ลบไอเทมสำหรับคนที่ไม่ใช่หน่วยงานเมื่อเปิดประตู
		maxDistance = 2.5,
		doors = {
			{objHash = GetHashKey('left_ilev_fh_frontdoor'), objHeading = 46.0, objCoords = vector3(-1231.84436, 2626.41138, 19.1249542)},
			{objHash = GetHashKey('right_ilev_fh_frontdoor'), objHeading = 46.0, objCoords = vector3(-1230.04285, 2628.27686, 19.1249542)}
		}
	},

	{
		textCoords = vector3(-1239.1300048828125, 2635.25, 19.23999977111816), --
		authorizedJobs = { },
		locked = true, -- ล็อคประตู
		boom = true, -- เปิดใช้ วางระเบิดประตู
		item = true, -- เปิดใช้ ไอเทมสำหรับ คนที่ไม่ใช่หน่วยงาน
		itemname = '7day',	-- ไอเทมสำหรับคนที่ไม่ใช่หน่วยงาน
		remove = false, -- ลบไอเทมสำหรับคนที่ไม่ใช่หน่วยงานเมื่อเปิดประตู
		maxDistance = 2.5,
		doors = {
			{objHash = GetHashKey('left_ilev_fh_frontdoor'), objHeading = -134.0, objCoords = vector3(-1238.12244, 2636.09546, 19.6875763)},
			{objHash = GetHashKey('right_ilev_fh_frontdoor'), objHeading = -134.0, objCoords = vector3(-1239.92444, 2634.22974, 19.6875763)}
		}
	},

}