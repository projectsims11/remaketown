Config = {}

Config.Locale     	 	  	= 'en'
Config.Price 				= 50	-- Price Store.
Config.CarPoundPrice      	= 1500 	-- Car Pound Price.

Config.halPoundPrice      	= 1000 	-- Car Pound Price.
Config.BoatPoundPrice		= 1000 -- Boat Pound Price.
Config.UseCarGarages	    = true 	-- Allows use of Car Garages.
Config.ShowSpacer1 		  	= true 	-- If true it shows Spacer 1 in the List.
Config.ShowSpacer2 			= false -- If true it shows Spacer 2 in the List | Don't use if spacer3 is set to true.
Config.ShowSpacer3 			= true 	-- If true it shows Spacer 3 in the List | Don't use if Spacer2 is set to true.
Config.DrawDistance 		= 55.0	-- Draw Distance To See

Config.billngPolice = 1500
Config.NoPolicePound = 0

Config.BlipGarage = {
	Sprite = 290,
	Color = 38,
	Display = 2,
	Scale = 0.6
}

Config.BlipPound = {
	Sprite =227,
	Color = 64,
	Display = 2,
	Scale = 0.8
}

Config.BlipPolice = {
	Sprite = 67,
	Color = 64,
	Display = 2,
	Scale = 0.8	
}
Config.BlipBoatPounds = {
	Sprite = 427,
	Color = 47,
	Display = 2,
	Scale = 0.7	
}
									--#-- Marker --#--
Config.PointMarker 		= { type = 36, r = 0, g = 255, b = 0, x = 1.5, y = 1.5, z = 1.0 }	--# จุกเบิก 218, 171, 53
Config.DeleteMarker 	= { type = 1,  r = 255, g = 0, b = 0, x = 7.0, y = 7.0, z = 1.0 }		--# จุดเก็บ
Config.PoundMarker 		= { type = 24, r = 255, g = 0, b = 0, x = 1.5, y = 1.5, z = 1.0 }		--# พาวประชาชน
Config.Poundambulance 	= { type = 36, r = 255, g = 0, b = 0, x = 1.5, y = 1.5, z = 1.0 }	--# พาวหมอ
Config.Poundpolice 		= { type = 36, r = 255, g = 0, b = 0, x = 1.5, y = 1.5, z = 1.0 }		--# พาวช่าง
Config.Poundmechanic 	= { type = 36, r = 255, g = 0, b = 0, x = 1.5, y = 1.5, z = 1.0 } 	--# พาวช่าง
Config.Poundcouncil 	= { type = 36, r = 255, g = 0, b = 0, x = 1.5, y = 1.5, z = 1.0 }	--# พาวสภา

Config.helMarker 		= { type = 34, r = 255, g = 0, b = 0, x = 1.5, y = 1.5, z = 1.0 }		--# พาวฮอ
Config.PoundNotPolice	= { type = 24, r = 255, g = 0, b = 0, x = 1.5, y = 1.5, z = 1.0 } 	--# พาวรถที่โดนยึด

Config.CarGarages = {
	--#--------------------------------------------------------------------#--
	polibox = { -- หน้าโรงบาล
		Blips = true,
		GaragePoint = { x = 243.30773, y = -562.0336, z = 43.278747, },
		SpawnPoint = { x = 243.30773, y = -562.0336, z = 43.278747, h =252.38681},
		DeletePoint = { x = 243.30773, y = -562.0336, z = 43.278747, }
	},
	--#--------------------------------------------------------------------#--
	Center1 = { -- การาจหลัก
		Blips = true,
		GaragePoint = { x = -311.7499, y = -908.3129, z = 31.076822 },
		SpawnPoint = { x = -311.7499, y = -908.3129, z = 31.076822, h =168.39849},
		DeletePoint = { x = -340.7418, y = -902.022, z = 31.074636 }
	},
	Center2 = { -- การาจหลัก
		Blips = false,
		GaragePoint = { x = -315.2216, y = -907.5458, z = 31.077119 },
		SpawnPoint = { x = -315.4039, y = -907.4767, z = 31.077104, h =168.39849},
		-- DeletePoint = { x = -155.33, y = -1033.74, z = 30.3+0.5 }
	},
	Center3 = { -- การาจหลัก
		Blips = false,
		GaragePoint = { x = -318.8618, y = -906.8003, z = 31.077423, },
		SpawnPoint = { x = -318.8618, y = -906.8003, z = 31.077423, h =168.39849},
		-- DeletePoint = { x = -153.84, y = -1030.26, z = 30.3+0.5 }
	},
	--#--------------------------------------------------------------------#--
	Center4 = { -- แลนแดง
		Blips = true,
		GaragePoint = { x = 299.57693, y = -235.2158, z = 53.871395, },
		SpawnPoint = { x = 299.57693, y = -235.2158, z = 53.871395, h =191.99359},
		DeletePoint = { x = 296.47344, y = -270.3223, z = 53.983139, }
	},
	OutCity1 = { -- แลนแดง
		Blips = false,
		GaragePoint = { x = 294.20141, y = -233.1821, z = 53.871395, },
		SpawnPoint = { x = 294.20309, y = -233.1199, z = 53.866462, h =191.99359},
		-- DeletePoint = { x = 1708.52, y = 3774.83, z = 34.5+0.5 }
	},	
	OutCity2 = { -- แลนแดง
		Blips = false,
		GaragePoint = { x = 289.25271, y = -231.3595, z = 53.871395, },
		SpawnPoint = { x = 289.25271, y = -231.3595, z = 53.973411, h =191.99359},
		-- DeletePoint = { x = 114.62, y = 6608.55, z = 31.89+0.5 }
	},	
	--#--------------------------------------------------------------------#--
	purple1 = { -- แลนม่วง
		Blips = true,
		GaragePoint = { x = 854.98022, y = -35.0817, z = 78.764045, },
		SpawnPoint = { x = 854.98022, y = -35.0817, z = 78.764045, h =239.3377},
		DeletePoint = { x = 875.04669, y = 6.6467995, z = 78.764038, }
	},	
	purple11 = { -- แลนม่วง
		Blips = false,
		GaragePoint = { x = 853.23907, y = -37.77999, z = 78.764045, },
		SpawnPoint = { x = 853.2044, y = -37.75598, z = 78.764122, h =239.3377},
	},	
	purple2 = { -- แลนม่วง
		Blips = false,
		GaragePoint = { x = 851.36584, y = -40.77853, z = 78.764045, },
		SpawnPoint = { x = 851.36584, y = -40.77853, z = 78.764045, h =239.3377},
		-- DeletePoint = { x = 114.62, y = 6608.55, z = 31.89+0.5 }
	},	
	purple3 = { -- แลนม่วง
		Blips = false,
		GaragePoint = { x = 908.10699, y = -72.33745, z = 78.76403, },
		SpawnPoint = { x = 908.10699, y = -72.33745, z = 78.76403, h =238.95913},
		DeletePoint = { x = 935.68591, y = -30.74623, z = 78.764022, }-- 
	},	
	purple32 = { -- แลนม่วง
		Blips = false,
		GaragePoint = { x = 906.23205, y = -75.38517, z = 78.76403, },
		SpawnPoint = { x = 906.29852, y = -75.38981, z = 78.764015, h =238.95913},
	},	
	purple33 = { -- แลนม่วง
		Blips = false,
		GaragePoint = { x = 904.42553, y = -78.24767, z = 78.764007, },
		SpawnPoint = { x = 904.2655, y = -78.1199, z = 78.764038, h =238.95913},
	},	
	--#--------------------------------------------------------------------#--
	OutCity3 = { -- แลนเหลือง
		Blips = true,
		GaragePoint = { x = 204.53532, y = -846.1157, z = 30.513093, },
		SpawnPoint = { x = 204.53532, y = -846.1157, z = 30.513093, h =39.16341},
		DeletePoint = { x = 209.19503, y = -807.2574, z = 30.893695, }
	},	
	OutCity4 = { -- แลนเหลือง
		Blips = false,
		GaragePoint = { x = 209.98715, y = -848.0912, z = 30.375835, },
		SpawnPoint = { x = 209.98715, y = -848.0912, z = 30.375835, h =39.16341},
		-- DeletePoint = { x = 114.62, y = 6608.55, z = 31.89+0.5 }
	},	
	OutCity5 = { -- แลนเหลือง
		Blips = false,
		GaragePoint = { x = 215.93771, y = -850.2569, z = 30.225988, },
		SpawnPoint = { x = 215.93771, y = -850.2569, z = 30.225988, h =39.16341},
		-- DeletePoint = { x = -175.7854, y = -897.9848, z = 29.342039, }-- 
	},
	--#--------------------------------------------------------------------#--
	
	REBAL = { -- ทะเลทราย
		Blips = true,
		GaragePoint = { x = 1708.4327, y = 3775.0151, z = 34.507411, },
		SpawnPoint = { x = 1708.4327, y = 3775.0151, z = 34.507411, h =211.12384},
		DeletePoint = { x = 1715.3293, y = 3758.051, z = 34.116325 }-- 
	},
	REBAL2 = { -- ทะเลทราย
		Blips = false,
		GaragePoint = { x = 1712.1956, y = 3777.8706, z = 34.517772, },
		SpawnPoint = { x = 1712.1956, y = 3777.8706, z = 34.517772, h =211.12384},
		-- DeletePoint = { x = 1735.2198, y = 3729.5229, z = 33.935249, }-- 
	},
	--#--------------------------------------------------------------------#--
	toptown = { -- 
		Blips = true,
		GaragePoint = { x = 116.69355, y = 6599.3266, z = 32.009128 },
		SpawnPoint = { x = 116.69355, y = 6599.3266, z = 32.009128, h =272.21633},
		DeletePoint = { x = 123.92496, y = 6594.875, z = 31.985218 }-- 
	},
	--#--------------------------------------------------------------------#--

	AFK = { -- 
		Blips = true,
		GaragePoint = { x = -3023.281, y = 93.235443, z = 11.611223 },
		SpawnPoint = { x = -3023.281, y = 93.235443, z = 11.611223, h =320.54171},
		DeletePoint = { x = -3015.171, y = 86.245079, z = 11.60868 }-- 
	},

	--#--------------------------------------------------------------------#--
	BOAT = { -- 
		Blips = true,
		GaragePoint = { x = 57.460262, y = -2756.288, z = 6.0046548 },
		SpawnPoint = { x = 57.460262, y = -2756.288, z = 6.0046548, h =356.60894},
		DeletePoint = { x = 66.426239, y = -2756.081, z = 6.0046539 }
	},

}
	--#--------------------------------------------------------------------#--

Config.CarPounds = { 						-- // พาวรภประชาชน
	Pound1 = { -- 
		Blips = true,
		PoundPoint = { x = 265.64877, y = -1156.021, z = 29.276451, },
		SpawnPoint = { x = 256.20007, y = -1149.714, z = 29.291685, h =179.15119}
	},
	Pound2 = { -- 
		Blips = true,
		PoundPoint = { x = 598.66247, y = 90.771865, z = 92.834846 },
		SpawnPoint = { x = 598.36248, y = 98.491073, z = 92.906311, h =249.08323}
	},
	rebel = { -- 
		Blips = true,
		PoundPoint = { x = 1536.0004, y = 3777.7277, z = 34.516059, },
		SpawnPoint = { x = 1542.5622, y = 3780.7902, z = 34.050098, h =209.01266}
	},
	top = { -- 
		Blips = true,
		PoundPoint = { x = 140.84671, y = 6612.4985, z = 32.011215 },
		SpawnPoint = { x = 140.73423, y = 6607.8642, z = 31.844938, h =178.57862}
	},
}

Config.Poundspolice = {						-- // พาวรภตำรวจ
	police1 = { -- 
		Blips = false,
		PoundPoint = { x = 457.33587, y = -1009.223, z = 28.309896, },
		SpawnPoint = { x = 450.89343, y = -1013.647, z = 28.481281, h =94.956459}
	},
}
Config.Poundsambulance = {     				-- // พาวรภหมอ
	ambulance1 = { -- 
		Blips = false,
		PoundPoint = { x = 300.16308, y = -603.4943, z = 43.386257, },
		SpawnPoint = { x = 292.51324, y = -612.895, z = 43.401599, h =70.31}
	},
}
Config.Poundsmechanic = { 					-- // พาวรภช่าง
	mechanic = { -- 
		Blips = false,
		PoundPoint = { x = 1132.9146, y = -774.6065, z = 57.63005, },
		SpawnPoint = { x = 1122.3193, y = -772.7949, z = 57.764827, h =358.17007}
	},
}
Config.Poundscouncil = {					-- // พาวรภสภา
	council = { -- 
		Blips = false,
		PoundPoint = { x = 319.958, y = -2734.674, z = 5.9876852, },
		SpawnPoint = { x = 315.04797, y = -2731.371, z = 5.9876093, h =106.30319}
	},
}
	--#--------------------------------------------------------------------#--

Config.helicopter = { 					-- // พาวฮอหน่วยงาน
	police1 = {
		Blips = false,
		PoundPoint = { x = 459.0527, y = -979.8255, z = 43.691902, },
		SpawnPoint = { x = 449.58621, y = -981.276, z = 43.691654, h =93.868995}
	},
	polibox = {
		Blips = false,
		PoundPoint = { x = 323.60, y = -1464.41, z = 46.50, },
		SpawnPoint = { x = 314.04, y = -1465.5, z = 46.40, h = 216.61856}
	},
	council = {
		Blips = false,
		PoundPoint = { x = 308.20434, y = -2766.181, z = 6.0822281, },
		SpawnPoint = { x = 293.43518, y = -2768.149, z = 5.9999485, h =103.28973}
	},
}
	--#--------------------------------------------------------------------#--

Config.CarPoundPolice = {
	CarPound = {
		Blips = false,
		PoundPoint = { x = 457.03759, y = -1024.875, z = 28.434516, },
		SpawnPoint = { x = 457.03759, y = -1024.875, z = 28.434516, h =100.62828}		
	}
}
	--#--------------------------------------------------------------------#--

Config.BoatPounds = {
	Boat1 = {
		Blips = true,
		PoundPoint = { x = 9.3766593, y = -2749.882, z = 6.0043072 },
		SpawnPoint = { x = -7.25516, y = -2762.787, z = 2.5043072, h =182.74647}
	},
	Boat2 = {
		Blips = false,
		PoundPoint = { x = 1241.4456, y = -5886.666, z = 2.9407045, h =339.30615},
		SpawnPoint = { x = 1286.3762, y = -5809.639, z = -0.471372, h =333.40432}
	},
}
	--#--------------------------------------------------------------------#--

Config.MarkerDeletejob 	= { type = 1, r = 255, g = 0, b = 0, x = 5.0, y = 5.0, z = 0.2 } 	--# Marker จุดเก็บหน่วยงาน
Config.DeletePointjob = {																	--# พิกัด จุดเก็บหน่วยงาน
	ambulance = { -- 
		Blips = false,
		DeletePoint = { x = 288.29229, y = -612.712, z = 43.404499, }-- 
	},	
	police = { -- 
		Blips = false,
		DeletePoint = { x = 448.83468, y = -1014.306, z = 28.504072, }-- 
	},	
	mechanic = { -- 
		Blips = false,
		DeletePoint = { x = 1122.2451, y = -773.8606, z = 57.729946, }-- 
	},	
	council = { -- 
		Blips = false,
		DeletePoint = { x = 314.14553, y = -2731.277, z = 5.9876117, }-- 
	},	

}
	
