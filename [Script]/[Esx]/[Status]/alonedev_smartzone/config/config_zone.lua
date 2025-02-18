SmartZone = SmartZone or {}

SmartZone.Zone = {}


-- ตัวอย่าง Zone
SmartZone.Zone['Fishing'] = {

	-- กำหนด Area ของ Zone 
    area = {
		coords = vector3(-3411.2102, 967.5818, 8.3467), -- จุดกึ่งกลาง สามารถตั้งเป็น table ได้ด้วย
		radius = 100.0 -- รัศมี
    },

	-- กำหนดเวลาเปิด Zone
	zone_time = false, -- เปิดตลอดเวลา

	-- zone_time = {
	-- 	{'18:00' , 10}, -- เปิดเวลา 18:00 เป็นเวลา 10 นาที 
	-- }

	-- กัน Status ต่างๆ ใน Zone
	anti = {
		--[[
			วิธีการใช้งาน :
			exports.alonedev_smartzone:GetZoneAnti(Status)

			return true / false ตาม การกัน anti Status ที่ตั้งไว้

			ตัวอย่าง กันเรียกเคสหมอ :
		
			function SendDistressSignal() -- ฟังชั่นเรียกเคส
				local playerPed = PlayerPedId()
				PedPosition		= GetEntityCoords(playerPed)
				local PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z }

				if exports.alonedev_smartzone:GetZoneAnti("ambulanceCase") then return end -- ( เพิ่มไว้สำหรับกันการเรียกในzone )
				
			end
		]]
	},


	-- ผู้เล่นข้างใน Zone
	player = { 
		invincible = false , -- เปิดอมตะ ตอนอยู่ในโซน
		-- fade = 100 ,        -- ตัวจาง ขนาดไหนตอนอยู่ในโซน (0 ~ 255) ถ้าไม่ใช้ให้ปิดไว้ ไม่งั้นจะเพิ่ม resmon
		collide = true ,    -- ชนกันได้ไหม ตอนอยู่ในโซน
		-- regenhealth = 0.0   -- รีเลือด ตอนอยู่ในโซน
	},

	-- block_keys = {38},

	-- ฟังชั่นนี้ จะทำงานตอนเข้า Zone 
	SendNuiMessage = function()
		SendNUIMessage({
			action = 'show_ui',
			Zone = 'โซนตกปลา'
		})
	end,

	-- ฟังชั่นนี้ จะทำงานตอนเข้า Zone ( ห้ามเอาลูปมาใส่ ไม่งั้น block_key กับ Zone_loop จะใช้ไม่ได้ )
	GetInZone = function()

	end,

	-- ฟังชั่นนี้ จะทำงานตอนออก Zone
	GetOutZone = function()
		SendNUIMessage({
			action = 'close_ui'
		})
	end,

	-- ลูปตอนอยู่ในโซน
	Zone_Loop = function()
		-- ตัวอย่าง เพิ่มหลอดอาหาร น้ำ ตอนอยู่ใน zone
		-- TriggerEvent('esx_status:add', 'hunger', 1000000)
		-- TriggerEvent('esx_status:add', 'thirst', 1000000)
		
		-- Wait(5000) -- Loop ทุกๆ 5 วินาที
	end,

}


--[[
	function ไหน ไม่ใช้ ให้ลบออกไปเลย เช่น 

	-- ลูปตอนอยู่ในโซน
	Zone_Loop = function()
		TriggerEvent('esx_status:add', 'hunger', 1000000)
		TriggerEvent('esx_status:add', 'thirst', 1000000)

		Wait(5000)
	end,

	ถ้าไม่ใช้ก็ให้ลบไปทั้งหมดเลย	
]]
