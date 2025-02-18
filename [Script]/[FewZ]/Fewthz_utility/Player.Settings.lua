Config = {}

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118, ["Enter"] = 191
}

Config = {

    ['Hide_Crosshair']	= false,    --เปิด-ปิด เป้ากลางจอ
    ['HideHud']	        = false,	-- HideHud

    ['NoHelmet']	    = true,		-- ไม่ใส่หมวก
	['LoseProp']	    = false,		-- กันต่อยแล้วแว่นหมวกหลุด
    ['DISR']	        = true,		-- ปิดตบปืน
    ['DISCAMAFK']	    = true,		-- ปิดจอ AFK
    ['SIT']         	= true,		-- CTRL นั่งย่อง [ ปรับแต่งปุ่มได้ในเกม ]
    ['HURT']        	= true,		-- เลือดลดขากระเพก
    ['ARREST']      	= false,		-- Y คุกเข่า [ ปรับแต่งปุ่มได้ในเกม ]
    ['POINTING']    	= true,		-- B ชี้นิ้ว [ ปรับแต่งปุ่มได้ในเกม ]
    ['HANDSUP']     	= true,		-- X ยกมือ [ ปรับแต่งปุ่มได้ในเกม ]
    ['SLIDE']       	= true,		-- H สไลด์ [ ปรับแต่งปุ่มได้ในเกม ]
	['MINIMAP']			= true,		-- มินิแมพ มีตอนขึ้นรถ
	['HEALTH-FEMALE']	= false,		-- เลือดผู้หญิง 200
    ['HEALTHRECHARGE']	= true,		-- รีเลือดต่ำกว่า 50

	['DISABLE-WANTED']		= true, -- เปิด/ปิด ใช้งาน [ ติดดาว ]
	['DISABLE-NPCSERVICE']	= true,	-- เปิด/ปิด ใช้งาน [ รถ หมอ NPC , รถดับเพลิง  ]
	['DEAD-REWARD']			= false,-- เปิด/ปิด ใช้งาน [ NPC ตายแล้วปืน ดร็อป ] ** ถ้าเปิดปล้นบ้านให้ false อาวุธที่ NPC ถือจะได้ไม่ลบ
	['VEHICLE-REWARD']		= true,	-- เปิด/ปิด ใช้งาน [ ได้รับปืนจากรถ ]

    ['BAN-VEHICLES'] = { -- รายชื่อ รถ, เครื่องบิน, เรือ ที่ไม่อยากให้มี
        'WORLD_VEHICLE_ATTRACTOR', 'WORLD_VEHICLE_AMBULANCE', 'WORLD_VEHICLE_BICYCLE_BMX', 'WORLD_VEHICLE_BICYCLE_BMX_BALLAS', 'WORLD_VEHICLE_BICYCLE_BMX_FAMILY',
        'WORLD_VEHICLE_BICYCLE_BMX_HARMONY', 'WORLD_VEHICLE_BICYCLE_BMX_VAGOS', 'WORLD_VEHICLE_BICYCLE_MOUNTAIN', 'WORLD_VEHICLE_BICYCLE_ROAD', 'WORLD_VEHICLE_BIKE_OFF_ROAD_RACE',
        'WORLD_VEHICLE_BIKER', 'WORLD_VEHICLE_BOAT_IDLE', 'WORLD_VEHICLE_BOAT_IDLE_ALAMO', 'WORLD_VEHICLE_BOAT_IDLE_MARQUIS', 'WORLD_VEHICLE_BOAT_IDLE_MARQUIS', 'WORLD_VEHICLE_BROKEN_DOWN',
        'WORLD_VEHICLE_BUSINESSMEN', 'WORLD_VEHICLE_HELI_LIFEGUARD', 'WORLD_VEHICLE_CLUCKIN_BELL_TRAILER', 'WORLD_VEHICLE_CONSTRUCTION_SOLO', 'WORLD_VEHICLE_CONSTRUCTION_PASSENGERS',
        'WORLD_VEHICLE_DRIVE_PASSENGERS', 'WORLD_VEHICLE_DRIVE_PASSENGERS_LIMITED', 'WORLD_VEHICLE_DRIVE_SOLO', 'WORLD_VEHICLE_FIRE_TRUCK', 'WORLD_VEHICLE_EMPTY', 'WORLD_VEHICLE_MARIACHI',
        'WORLD_VEHICLE_MECHANIC', 'WORLD_VEHICLE_MILITARY_PLANES_BIG', 'WORLD_VEHICLE_MILITARY_PLANES_SMALL', 'WORLD_VEHICLE_PARK_PARALLEL', 'WORLD_VEHICLE_PARK_PERPENDICULAR_NOSE_IN',
        'WORLD_VEHICLE_PASSENGER_EXIT', 'WORLD_VEHICLE_POLICE_BIKE', 'WORLD_VEHICLE_POLICE_CAR', 'WORLD_VEHICLE_POLICE', 'WORLD_VEHICLE_POLICE_NEXT_TO_CAR', 'WORLD_VEHICLE_QUARRY',
        'WORLD_VEHICLE_SALTON', 'WORLD_VEHICLE_SALTON_DIRT_BIKE', 'WORLD_VEHICLE_SECURITY_CAR', 'WORLD_VEHICLE_STREETRACE', 'WORLD_VEHICLE_TOURBUS', 'WORLD_VEHICLE_TOURIST', 'WORLD_VEHICLE_TANDL',
        'WORLD_VEHICLE_TRACTOR', 'WORLD_VEHICLE_TRACTOR_BEACH', 'WORLD_VEHICLE_TRUCK_LOGS', 'WORLD_VEHICLE_TRUCKS_TRAILERS', 'WORLD_VEHICLE_DISTANT_EMPTY_GROUND'
    },
	-- END NPC CONTROL

}


-- BLACKLIST WEAPON
Config['BLACKLIST']	= false 		-- เปิด/ปิด ใช้งาน
Config['BLACKLIST-WEAPON'] = { 	-- ไม่่ให้ใช้ อาวุธ
	"WEAPON_GRENADE",
}



-- NOTIFY SLIDE
NOTIFY01 = function()
    exports["pNotify"]:SendNotification({
        text = "สไลด์<span style='color:#47cf73'> พร้อม </span>ใช้งานแล้ว !",
        type = "success",
        timeout = 3000,
        layout = "centerRight",
        queue = "global"
    })
end

-- NOTIFY BLACKLIST WEAPON
NOTIFY02 = function()
	TriggerEvent("pNotify:SendNotification", {
		text = '<strong class="red-text">คุณมีอาวุธไม่ได้รับอนุญาติ ระบบได้ลบออกแล้ว!!</span>',
		type = "error",
		timeout = 3000,
		layout = "bottomCenter",
		queue = "global"
	})
end