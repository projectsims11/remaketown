

Config = {}

-- Config.Delay = {
-- 	Enable = true,
-- 	Length = 1000
-- }

-- Config.HelpNotification = function()
-- 	exports["j-textui-main"]:Help("Press ~INPUT_CONTEXT~ To Menu") 
-- end

GarageStore = function()
	exports["Fewthz_TextUI"]:ShowHelpNotification('กด ~INPUT_CONTEXT~ เพื่อเปิดเมนู')
end

StoreCar = function()
	exports["Fewthz_TextUI"]:ShowHelpNotification('กด ~INPUT_CONTEXT~ เพื่อเปิดเมนู')
end

PoundStore = function()
	exports["Fewthz_TextUI"]:ShowHelpNotification('กด ~INPUT_CONTEXT~ เพื่อเปิดเมนู')
end

Config.Locale     	 	  	= 'en'
Config.Price 				= 10	-- ค่าเก็บรถ
Config.PricePound 			= 1500 	-- ค่าพาว
Config.UseCarGarages	    = true 	-- Allows use of Car Garages.
Config.UseBoatGarages     	= true -- Allows use of Boat Garages
Config.ShowSpacer1 		  	= true -- If true it shows Spacer 1 in the List.
Config.ShowSpacer2 			= true -- If true it shows Spacer 2 in the List | Don't use if spacer3 is set to true.
Config.ShowSpacer3 			= true 	-- If true it shows Spacer 3 in the List | Don't use if Spacer2 is set to true.
Config.DrawDistance 		= 45.0	-- Draw Distance To See
Config["Trunk_Event"] = function(plate)
    -- TriggerEvent("xzero_trunk:CL:OnInventoryHudInsObjReceive", plate)
	TriggerEvent("xzero_trunk:CL:On_OpenInventoryMobile", plate)
	TriggerEvent("enjoy_trunk:CL:On_OpenInventoryMobile", openedvehicle)
end

-- Config.Fz = false --เวลาพาวให้ซ่อมไหม
Config.Checkcar = 1 -- วิ


-- Config.OnEffect = false -- ปิด เปิด EFFECT
-- Config.TypePT = 'core' -- ประเภท EFFECT
-- Config.particle = "exp_air_rpg_plane" -- ตัว EFFECT ที่จะใช้ เว็บหา https://vespura.com/fivem/particle-list/
-- Config.Size = 0.2 -- ขนาด


Config.BlipPound = {
	Sprite = 562,
	Color = 64,
	Display = 2,
	Scale = 1.5
}


Config.BlipGarage = {
	Sprite = 290,
	Color = 38,
	Display = 2,
	Scale = 1.2
}

Config.SpawnPoundWait = function()
	SetNotificationTextEntry('STRING')
	AddTextComponentSubstringPlayerName('~y~Wait For ~g~1 ~y~Second To Pound Cars')
	DrawNotification(false, true)
end


Config.PointMarker 	= { 
	type = 36, 
	r = 240, 
	g = 160, 
	b = 0, 
	a = 255, 
	x = 1.7, 
	y = 1.7, 
	z = 1.0,
}

Config.DeleteMarker = { 
	type = 1,
	r = 250, 
	g = 0,
	b = 0, 
	x = 10.0, 
	y = 10.0, 
	z = 1.0 
}


Config.CarGarages = {

	Garage = { -- จุดเบิกรถของผู้เล่นใหม่
		Blips = true,
		Model = GetHashKey("bs_prop_garage"),
		Disable_Model = true,
		GaragePoint = { x = -286.71, y = -979.97, z = 33.53},
		SpawnPoint = { x = -289.53, y = -978.04, z = 32.53, h = 334.53 },
		DeletePoint = { x = -308.76, y = -971.78, z = 33.53}

	},

	Economy_casino = {
		Blips = true,
		GaragePoint = { x = 916.16, y = -74.18, z = 78.95 },
		SpawnPoint = { x = 921.19, y = -68.35, z = 78.95, h = 56.68 },
		-- DeletePoint = { x = 223.797, y = -760.415, z = 30.646 }
	},

	
	Hotpital = {
		Blips = true,
		GaragePoint = { x = 315.32, y = -1369.73, z = 31.82 }, 
		SpawnPoint = { x = 299.51, y = -1363.97, z = 31.82, h = 320.13 },
		DeletePoint = { x = 307.32, y = -1379.02, z = 31.81  }
	},
		
	Rebel = {
		Blips = true,
		GaragePoint = { x = 1727.02, y = 3286.38, z = 41.12 },
		SpawnPoint = { x = 1722.66, y = 3274.90, z = 41.14, h = 260.75 },
		DeletePoint = { x = 1750.18, y = 3293.05, z = 41.11  }
	},

	mechanic = {
		Blips = true,
		GaragePoint = { x = 1103.29, y = -746.29, z = 57.10 }, 
		SpawnPoint = { x = 1105.56, y = -755.00, z = 57.68, h = 342.76 },
		-- DeletePoint = { x = -325.06, y = -980.70, z = 31.08  }
	},


	Garage_Intra3 = {
		Blips = true,
		GaragePoint = { x = -332.15, y = -976.71, z = 31.08 },
		SpawnPoint = { x = -332.15, y = -976.71, z = 31.08, h = 342.76 },
		-- DeletePoint = { x = -304.283, y = -940.541, z = 31.080  }
	},

	Garage_Intra4 = { -- โรงบาล
		Blips = true,
		GaragePoint = { x = 294.86, y = -562.11, z = 43.32  },
		SpawnPoint = { x = 290.34, y = -560.4, z = 43.26, h = 67.49 },
		DeletePoint = { x = 240.84, y = -563.95, z = 42.58  }
	},
	
	Garage_Sandy = {
		Blips = true,
		GaragePoint = { x = 1737.59, y = 3710.2, z = 34.14 },
		SpawnPoint = { x = 1737.84, y = 3719.28, z = 33.04, h = 21.22 },
		DeletePoint = { x = 1722.66, y = 3713.74, z = 34.21 }
	},
	
	Garage_Paleto = {
		Blips = true,
		GaragePoint = { x = 105.359, y = 6613.586, z = 32.3973 },
		SpawnPoint = { x = 128.7822, y = 6622.9965, z = 30.7828, h = 315.01 },
		DeletePoint = { x = 126.3572, y = 6608.4150, z = 31.8565 }
	},
	
	Garage_mechanice = {
		Blips = true,
		GaragePoint = { x = -718.83, y = -1415.25, z = 5.04 },
		SpawnPoint = { x = -718.83, y = -1415.25, z = 5.04, h = 49.21 },
		DeletePoint = { x = -737.38, y =-1412.82, z = 5.04 }
	},
	
	Garage_CarWoolHavert = {
		Blips = true,
		GaragePoint = { x = -579.84, y = -5355504.15, z = 7550.26 },
		SpawnPoint = { x = -592.06, y = 5303.52, z = 75550.21, h = 170.2 },
		DeletePoint = { x = -575.39, y = 5371.46, z = 70.24 }
	},

	Garage_1 = {
		Blips = true,
		GaragePoint = { x = 172.43, y = -937.5, z = 30.39 },
		SpawnPoint = { x = 172.37, y = -945.19, z = 30.39, h = 161.82 },
		DeletePoint = { x = 217.24, y = -966.74, z = 30.41 }
	},

	Garage_a1 = { -- การาจกลาง
		Blips = true,
		GaragePoint = { x = -328.68, y = -977.91, z = 31.08 },
		SpawnPoint = { x = -328.68, y = -977.91, z = 31.08, h = 342.78 },
		-- DeletePoint = { x = 217.24, y = -966.74, z = 30.41 }
	},

	Garage_s2 = { -- การาจกลาง
	Blips = true,
	GaragePoint = { x = -307.99, y = -947.06, z = 31.08 },
	SpawnPoint = { x = -307.99, y = -947.06, z = 31.08, h = 71.37 },
	-- DeletePoint = { x = 217.24, y = -966.74, z = 30.41 }
	},

	Garage_a3 = { -- การาจกลาง
	Blips = true,
	GaragePoint = { x = -309.13, y = -950.46, z = 31.08 },
	SpawnPoint = { x = -309.13, y = -950.46, z = 31.08, h = 71.37 },
	-- DeletePoint = { x = 217.24, y = -966.74, z = 30.41 }
	},

	Garage_a4 = { -- การาจกลาง
	Blips = true,
	GaragePoint = { x = -310.33, y = -953.94, z = 31.08 },
	SpawnPoint = { x = -310.33, y = -953.94, z = 31.08, h = 71.37 },
	-- DeletePoint = { x = 217.24, y = -966.74, z = 30.41 }
	},

	Garage_a5 = { -- เเลนเเดง
	Blips = true,
	GaragePoint = { x = 207.38, y = -798.74, z = 30.98 },
	SpawnPoint = { x = 207.38, y = -798.74, z = 30.98, h = 251.9 },
	-- DeletePoint = { x = 217.24, y = -966.74, z = 30.41 }
	},

	Garage_a6 = { -- เเลนเเดง
	Blips = true,
	GaragePoint = { x = 209.26, y = -793.7, z = 30.98 },
	SpawnPoint = { x = 209.26, y = -793.7, z = 30.98, h = 251.9 },
	-- DeletePoint = { x = 217.24, y = -966.74, z = 30.41 }
	},

	Garage_a7 = { -- เเลนเเดง
	Blips = true,
	GaragePoint = { x = 211.22, y = -788.74, z = 30.98 },
	SpawnPoint = { x = 211.22, y = -788.74, z = 30.98, h = 251.9 },
	-- DeletePoint = { x = 217.24, y = -966.74, z = 30.41 }
	},

	Garage_a8 = { -- เเลนเขียว
	Blips = true,
	GaragePoint = { x = 300.26, y = -235.97, z = 53.99 },
	SpawnPoint = { x = 300.26, y = -235.97, z = 53.99, h = 192.08 },
	DeletePoint = { x = 295.97, y = -272.87, z = 53.66 }
	},

	Garage_a9 = { -- เเลนเขียว
	Blips = true,
	GaragePoint = { x = 294.67, y = -234.05, z = 53.99 },
	SpawnPoint = { x = 294.67, y = -234.05, z = 53.99, h = 192.08 },
	-- DeletePoint = { x = 217.24, y = -966.74, z = 30.41 }
	},

	Garage_a10 = { -- เเลนเขียว
	Blips = true,
	GaragePoint = { x = 289.68, y = -232.23, z = 53.99 },
	SpawnPoint = { x = 289.68, y = -232.23, z = 53.99, h = 192.08 },
	-- DeletePoint = { x = 217.24, y = -966.74, z = 30.41 }
	},

	Garage_a11 = { -- เเลนขาว
	Blips = true,
	GaragePoint = { x = 878.64, y = -61.96, z = 78.76 },
	SpawnPoint = { x = 878.64, y = -61.96, z = 78.76, h = 58.62 },
	-- DeletePoint = { x = 217.24, y = -966.74, z = 30.41 }
	},

	Garage_a12 = { -- เเลนขาว
	Blips = true,
	GaragePoint = { x = 880.37, y = -58.99, z = 78.76 },
	SpawnPoint = { x = 880.37, y = -58.99, z = 78.76, h = 58.62 },
	-- DeletePoint = { x = 217.24, y = -966.74, z = 30.41 }
	},

	Garage_a13 = { -- เเลนขาว
	Blips = true,
	GaragePoint = { x = 882.2, y = -55.98, z = 78.76 },
	SpawnPoint = { x = 882.2, y = -55.98, z = 78.76, h = 58.62 },
	DeletePoint = { x = 871.87, y = -74.83, z = 78.44 }
	},

	Garage_a14 = { -- เเลน ชมพู
	Blips = true,
	GaragePoint = { x = 55.91, y = -1552.34, z = 29.46 },
	SpawnPoint = { x = 55.91, y = -1552.34, z = 29.46, h = 229.83 },
	DeletePoint = { x = 31.19, y = -1592.43, z = 29.46 }
	},

	Garage_a15 = { -- เเลน ชมพู
	Blips = true,
	GaragePoint = { x = 57.86, y = -1550.02, z = 29.46 },
	SpawnPoint = { x = 57.86, y = -1550.02, z = 29.46, h = 229.83 },
	-- DeletePoint = { x = 31.19, y = -1592.43, z = 29.46 }
	},

	Garage_a16 = { -- เเลน ชมพู
	Blips = true,
	GaragePoint = { x = 59.93, y = -1547.69, z = 29.46 },
	SpawnPoint = { x = 59.93, y = -1547.69, z = 29.46, h = 229.83 },
	-- DeletePoint = { x = 31.19, y = -1592.43, z = 29.46 }
	},

	Garage_a17 = { -- เเลน ชมพู
	Blips = true,
	GaragePoint = { x = 40.02, y = -1571.35, z = 29.46 },
	SpawnPoint = { x = 40.02, y = -1571.35, z = 29.46, h = 229.83 },
	-- DeletePoint = { x = 31.19, y = -1592.43, z = 29.46 }
	},

	Garage_a18 = { -- เเลน ชมพู
	Blips = true,
	GaragePoint = { x = 38.08, y = -1573.68, z = 29.46 },
	SpawnPoint = { x = 38.08, y = -1573.68, z = 29.46, h = 229.83 },
	-- DeletePoint = { x = 31.19, y = -1592.43, z = 29.46 }
	},

	Garage_a19 = { -- เเลน ชมพู
	Blips = true,
	GaragePoint = { x = 36.2, y = -1575.91, z = 29.46 },
	SpawnPoint = { x = 36.2, y = -1575.91, z = 29.46, h = 229.83 },
	-- DeletePoint = { x = 31.19, y = -1592.43, z = 29.46 }
	},

	Garage_a20 = { -- เเลน นํ้าเงิน
	Blips = true,
	GaragePoint = { x = -814.13, y = -1310.86, z = 5.0 },
	SpawnPoint = { x = -814.13, y = -1310.86, z = 5.0, h = 351.15 },
	DeletePoint = { x = -798.78, y = -1305.99, z = 5.0 }
	},

	Garage_a21 = { -- เเลน นํ้าเงิน
	Blips = true,
	GaragePoint = { x = -810.97, y = -1311.24, z = 5.0 },
	SpawnPoint = { x = -810.97, y = -1311.24, z = 5.0, h = 351.15 },
	-- DeletePoint = { x = -798.78, y = -1305.99, z = 5.0 }
	},

	Garage_a22 = { -- เเลน นํ้าเงิน
	Blips = true,
	GaragePoint = { x = -807.81, y = -1311.86, z = 5.0 },
	SpawnPoint = { x = -807.81, y = -1311.86, z = 5.0, h = 351.15 },
	-- DeletePoint = { x = -798.78, y = -1305.99, z = 5.0 }
	},

	Garage_a23 = { -- เเลน ม่วง
	Blips = true,
	GaragePoint = { x = -329.42, y = 285.23, z = 86.15 },
	SpawnPoint = { x = -329.42, y = 285.23, z = 86.15, h = 96.3 },
	DeletePoint = { x = -349.36, y = 299.41, z = 84.96 }
	},

	Garage_a24 = { -- เเลน ม่วง
	Blips = true,
	GaragePoint = { x = -329.58, y = 288.95, z = 86.12 },
	SpawnPoint = { x = -329.58, y = 288.95, z = 86.12, h = 96.24 },
	-- DeletePoint = { x = -349.36, y = 299.41, z = 84.96 }
	},

	Garage_a25 = { -- เเลน ม่วง
	Blips = true,
	GaragePoint = { x = -329.75, y = 292.47, z = 86.12 },
	SpawnPoint = { x = -329.75, y = 292.47, z = 86.12, h = 96.24 },
	-- DeletePoint = { x = -349.36, y = 299.41, z = 84.96 }
	},

	Garage_a26 = { -- เเลนนํ้าตาล
	Blips = true,
	GaragePoint = { x = -1339.89, y = 247.59, z = 60.99 },
	SpawnPoint = { x = -1339.89, y = 247.59, z = 60.99, h = 9.63 },
	DeletePoint = { x = -1313.53, y = 282.0, z = 64.05 }
	},

	Garage_a27 = { -- เเลนนํ้าตาล
	Blips = true,
	GaragePoint = { x = -1336.19, y = 248.29, z = 61.17 },
	SpawnPoint = { x = -1336.19, y = 248.29, z = 61.17, h = 9.63 },
	-- DeletePoint = { x = -1313.53, y = 282.0, z = 64.05 }
	},

	Garage_a28 = { -- เเลนนํ้าตาล
	Blips = true,
	GaragePoint = { x = -1332.23, y = 248.83, z = 61.35 },
	SpawnPoint = { x = -1332.23, y = 248.83, z = 61.35, h = 12.26 },
	-- DeletePoint = { x = -1313.53, y = 282.0, z = 64.05 }
	},

	Garage_a29 = { -- เเลนฟ้า
	Blips = true,
	GaragePoint = { x = -2032.89, y = -479.0, z = 11.65 },
	SpawnPoint = { x = -2032.89, y = -479.0, z = 11.65, h = 318.93 },
	DeletePoint = { x = -1996.42, y = -486.92, z = 11.65 }
	},

	Garage_a30 = { -- เเลนฟ้า
	Blips = true,
	GaragePoint = { x = -2030.35, y = -481.03, z = 11.65 },
	SpawnPoint = { x = -2030.35, y = -481.03, z = 11.65, h = 318.93 },
	-- DeletePoint = { x = -1996.42, y = -486.92, z = 11.65 }
	},

	Garage_a31 = { -- เเลนฟ้า
	Blips = true,
	GaragePoint = { x = -2028.18, y = -482.88, z = 11.65 },
	SpawnPoint = { x = -2028.18, y = -482.88, z = 11.65, h = 318.93 },
	-- DeletePoint = { x = -1996.42, y = -486.92, z = 11.65 }
	},


	Garage_Prison = {
		Blips = true,
		GaragePoint = { x = 1853.24, y = 2582.97, z = 45.67 },
		SpawnPoint = { x = 1855.11, y = 2592.72, z = 44.67, h = 274.8 },
		DeletePoint = { x = 1855.21, y = 2615.3, z = 34.67 }
	}

}

--------------------- POUND -----------------





Config.PoundMarker 	= { type = 24, r = 255, g = 0, b = 0, a = 255, x = 1.5, y = 1.5, z = 1.0 }

Config.CarPounds = {
	Pound_LosSantos = {
		PoundPoint = { x = 495.76, y = -1340.55, z = 29.31 },
		SpawnPoint = { x = 493.5, y = -1329.61, z = 29.02, h = 156.72 }
	},
	Pound_drugs = {
		PoundPoint = { x = 1695.75, y = 3771.43, z = 34.7 },
		SpawnPoint = { x = 1703.33, y = 3764.33, z = 34.36, h = 309.31 }
	},
	-- Pound_garage = {
	-- 	PoundPoint = { x = -343.58, y = -875.41, z = 31.07 },
	-- 	SpawnPoint = { x = -343.58, y = -875.41, z = 31.07, h = 162.47 }
	-- },
	Pound_police = {
		PoundPoint = { x = 452.5408, y = -996.883, z = 25.765 },
		SpawnPoint = { x = 454.17, y = -1024.61, z = 28.49, h = 94.84 }
	},
	Pound_Paleto = {
		PoundPoint = { x = -234.82, y = 6198.65, z = 31.94 },
		SpawnPoint = { x = -230.08, y = 6190.24, z = 30.49, h = 140.24 }
	}
}


--------------------- POLICE -----------------

Config.PoPoint = {
	police = {
		PoPoint = { x = 456.0661, y = -1017.37, z = 28.402 },
		SpawnPoint = { x = 441.8519, y = -1017.76, z = 28.687, h = 60.72 }
	},
}

Config.PoMarker 	= { type = 36, r = 0, g = 130, b = 255, x = 1.5, y = 1.5, z = 1.0 }

--------------------- AMBULANCE -----------------

Config.AmPoint = {
	ambulance = {
		AmPoint = { x = 303.7733, y = -1392.86, z = 31.384 },
		SpawnPoint = { x = 299.4866, y = -1387.79, z = 31.351, h = 50.25 },
	},
}



Config.AmMarker 	= { type = 36, r = 0, g = 130, b = 255, x = 1.5, y = 1.5, z = 1.0 }