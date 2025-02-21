Config                            = {}

Config.DrawDistance               = 100.0

Config.Marker                     = { type = 20, x = 1.0, y = 1.0, z = 1.0, r = 50, g = 50, b = 204, a = 100, rotate = false }

Config.billrevive			= 1000  -- บิลที่ผู้เล่นจะได้ ปั้มหัวใจ ในเมือง
Config.billhealbig 			= 800  -- บิลที่ผู้เล่นจะได้ ฉีดยา
Config.billhealsmall 		= 800  -- บิลที่ผู้เล่นจะได้ ฉีดยา

Config.cooldownBody = 3000
Config.cooldownSignal = (1000 * 60 * 5)   -- แก้ที่เลข หลังสุด -- แจ้งเตือนหมอ
Config.cooldowntalk = (1000 * 60 * 1)   -- แก้ที่เลข หลังสุด -- แจ้งเตือนหมอ
Config.cooldownpolice = (1000 * 60 * 5)   -- แก้ที่เลข หลังสุด -- แจ้งเตือนหมอ
Config.Theme = '#0026B4'
Config.keySignal = 'G'
Config.keyClearbody = 'X'
Config.keyTalk = 'R'
Config.keyPolice = 'K'
Config.hearRate = true

Config.itemRevive = 'medikit' -- อุปกรณ์ที่ใช้ในการชุบ
Config.itemHeal1 = 'bandage' -- อุปกรณ์ฮิลเล็ก
Config.itemHeal2 = 'medikit' -- อุปกรณ์ฮิลใหญ่

Config.Talk1 = {
	Time = 5, -- 5 นาที
	Lable = "อนุญาตให้พูด 5 นาที",
	Notify = "ได้รับอนุญาตให้พูด 5 นาที",
}

Config.Talk2 = {
	Time = 10, -- 10 นาที
	Lable = "อนุญาตให้พูด 10 นาที",
	Notify = "ได้รับอนุญาตให้พูด 10 นาที",
}

Config.Talk3 = {
	Lable = "อนุญาตให้พูด",
	Notify = "ได้รับอนุญาตให้พูดแล้ว",
}

Config.Talk4 = {
	Lable = "ไม่อนุญาตให้พูด...",
	Notify = "ไม่ได้รับอนุญาตให้พูด",
}

alertambulance = function() --ฟังชั่นนี้สำหรับเรียกหมอ
	TriggerEvent("Fewthz_ambulancealert:alertNet", "dead")
	TriggerEvent('pNotify:SendNotification', { type = 'success', text ='ส่งสัญญาณขอความช่วยเหลือไปยังคุณหมอแล้ว',})
end

alertpolice = function() --ฟังชั่นนี้สำหรับเรียกหมอ
	TriggerEvent("Fewthz_policealert:alertNet", "dead")
	TriggerEvent('pNotify:SendNotification', { type = 'success', text ='ส่งสัญญาณขอความช่วยเหลือไปยังคุณตำรวจแล้ว',})
end

Config.AntiCombatLog              = true -- enable anti-combat logging?
Config.LoadIpl                    = true -- disable if you're using fivem-ipl or other IPL loaders

Config.Locale                     = 'th'

local second = 1000
local minute = 60 * second

Config.AutoRespawn				  = true
Config.AutoRespawnTimer           = 2 * minute --ไม่มีหมอ
Config.EarlyRespawnTimer          = 45 * minute  -- เวลาจริง
Config.BleedoutTimer              = 45 * minute -- เวลาเอ๋อ

Config.Jailtime = 15  --- เวลาในการเจลตู้ปลา (นาที)

Config.ItemProtect = "phone"  --- ไอเท็มที่จะหักออกเพื่อกันของหายเวลาเอ๋อ (บัตรประกันของหายทั้งตั้ว)

Config.WeaponProtect = { --- ไอเท็มที่จะหักออกเพื่อกันอาวุธหายเวลาเอ๋อ (บัตรประกันอาวุธหายตามชิ้น)
	{ itemname = 'water', weapon = 'WEAPON_BAT'},
	{ itemname = 'bread', weapon = 'WEAPON_POOLCUE'},
	{ itemname = 'bread', weapon = 'WEAPON_BOTTLE'},
}

Config.RespawnPoint = { --- พิกัดจุดคุกตู้ปลาที่ต้องการส่งเข้าไป

	["Cellin"] = { ["x"] = 134.0599, ["y"] = -923.07000, ["z"] = 30.2199, ["h"] = 80.09 }, -- จุดเข้าคุก
	["OutCell"] = { ["x"] = -249.3374, ["y"] = -960.5099, ["z"] = 32.335121, ["h"] = 80.09 }, heading = 80.09 -- จุดออกคุก

}

Config.EnablePlayerManagement     = true
Config.EnableJobBlip              = false
Config.MaxInService               = -1

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = false
Config.RemoveItemsAfterRPDeath    = false

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = false
Config.EarlyRespawnFineAmount     = 10000

Config.Hospitals = {

	
	Pillbox = {

		Blip = {
			coords = vector3(1154.9182, -1521.2485, 34.8439),
			sprite = 383,
			scale  = 0.8,
			color  = 0
		},

		AmbulanceActions = {
			vector3(357.55999755859375, -1423.43994140625, 32.5099983215332) -- 359.3998, -598.8563, 43.2840, 252.4042
		},

		Pharmacies = {
			vector3( 0, 0, 0)    
		},

		Vehicles = {
			{
				Spawner = vector3(397.9100036621094, -1428.6199951171875, 29.45000076293945),
				InsideShop = vector3(446.7, -1355.6, 43.5),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(405.5899963378906, -1439.6400146484375, 28.5300006866455), heading = 28.34, radius = 4.0 },
					{ coords = vector3(409.2000122070313, -1437.3399658203125, 28.5300006866455), heading = 28.34, radius = 4.0 },
					{ coords = vector3(413.1300048828125, -1435.2099609375, 28.5300006866455), heading = 28.34, radius = 4.0 },
					{ coords = vector3(416.5299987792969, -1433.300048828125, 28.5300006866455), heading = 28.34, radius = 4.0 }
				}
			}
		},

		Helicopters = {
			{ 
				Spawner = vector3(316.28, -1454.97, 46.51),
				InsideShop = vector3(305.6, -1419.7, 41.5),
				Marker = { type = 34, x = 1.5, y = 1.5, z = 1.5, r = 117, g = 26, b = 255, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(300.1, -1453.83, 46.51), heading = 63.96, radius = 10.0 }
				}
			}
		},

		FastTravels = {
			{
				From = vector3(294.73, -1448.02, 29.97),
				To = { coords = vector3(330.23, -1438.04, 46.51), heading = 67.3 },
				Marker = { type = 22, x = 1.0, y = 1.0, z = 1.0, r = 255, g = 51, b = 51, a = 100, rotate = false },
			},

			{
				From = vector3(333.49, -1434.13, 46.51),
				To = { coords = vector3(296.35, -1445.93, 29.97), heading = 253.5 },
				Marker = { type = 22, x = 1.0, y = 1.0, z = 1.0, r = 255, g = 51, b = 51, a = 100, rotate = false },
			}
		},
				
				FastTravelsPrompt = {
					-- {
					-- 	From = vector3(328.12, -594.8, 43.29),
					-- 	To = { coords = vector3(339.22, -589.47, 74.17), heading = 296.05 },
					-- 	Marker = { type = 21, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 150, b = 150, a = 100, rotate = true },
					-- 	Prompt = 'Press ~INPUT_CONTEXT~ to fast travel to the roof.'
					-- },
					-- {
					-- 	From = vector3(339.15, -583.98, 74.17),
					-- 	To = { coords = vector3(295.19, -601.49, 43.3), heading = 117.67 },
					-- 	Marker = { type = 21, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 150, b = 150, a = 100, rotate = true },
					-- 	Prompt = 'Press ~INPUT_CONTEXT~ to fast travel to the roof.'
					-- },
				}
				
		},
		PillboxNew = {

			Blip = {
				coords = vector3( 1828.7, 3680.67, 34.27),
				sprite = 61,
				scale  = 0.8,
				color  = 0
			},
	
			AmbulanceActions = {
				-- vector3(359.3998, -598.8563, 43.2840) -- 359.3998, -598.8563, 43.2840, 252.4042
			},
	
			Pharmacies = {
				-- vector3( 0, 0, 0)    
			},
	
			Vehicles = {
				-- {
				-- 	Spawner = vector3( 298.8, -604.33, 43.36), --300.13 -579.26 43.26
				-- 	InsideShop = vector3(283.01, -604.47, 43.15),
				-- 	Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true },
				-- 	SpawnPoints = {
				-- 		-- { coords = vector3(290.03, -1429.67, 29.8), heading = 49.94, radius = 10.0 }, --288.85 -584.88 43.14
				-- 		{ coords = vector3(283.01, -604.47, 43.15), heading = 95.22, radius = 10.0 }
				-- 	}
				-- }
			},
	
			Helicopters = {
				-- {
				-- 	Spawner = vector3(342.43, -580.51, 74.17),
				-- 	InsideShop = vector3(350.83, -587.92, 74.17),
				-- 	Marker = { type = 34, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true },
				-- 	SpawnPoints = {
				-- 		{ coords = vector3(350.83, -587.92, 74.17), heading = 206.58, radius = 10.0 },
				-- 		--{ coords = vector3(299.5, -1453.2, 46.5), heading = 357.9, radius = 10.0 }
				-- 	}
				-- 	}
				},
	
				FastTravels = {
						-- {
						-- 	From = vector3(328.12, -594.8, 42.29),
						-- 	To = { coords = vector3(338.38, -587.74, 74.17), heading = 0.0 },
						-- 	Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
						-- },
						-- {
						-- 	From = vector3(339.14, -583.96, 73.17),
						-- 	To = { coords = vector3(300.39, -603.38, 43.39), heading = 108.32 },
						-- 	Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
						-- },
					},
					
					FastTravelsPrompt = {
						-- {
						-- 	From = vector3(328.12, -594.8, 43.29),
						-- 	To = { coords = vector3(339.22, -589.47, 74.17), heading = 296.05 },
						-- 	Marker = { type = 21, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 150, b = 150, a = 100, rotate = true },
						-- 	Prompt = 'Press ~INPUT_CONTEXT~ to fast travel to the roof.'
						-- },
						-- {
						-- 	From = vector3(339.15, -583.98, 74.17),
						-- 	To = { coords = vector3(295.19, -601.49, 43.3), heading = 117.67 },
						-- 	Marker = { type = 21, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 150, b = 150, a = 100, rotate = true },
						-- 	Prompt = 'Press ~INPUT_CONTEXT~ to fast travel to the roof.'
						-- },
					}
					
			}
	} 

Config.AuthorizedVehicles = {
	ambulance = {
		{ model = 'polaa', label = 'ambulance', price = 2500}
	},
	doctor = {
		{ model = 'polaa', label = 'ambulance', price = 2500}
	},
	chief_doctor = {
		{ model = 'polaa', label = 'ambulance', price = 2500}
	},
	boss = {
		{ model = 'polaa', label = 'ambulance', price = 2500}
	}

}

Config.AuthorizedHelicopters = {

	ambulance = {
		-- { model = 'buzzard2', label = 'buzzard2', price = 2500}
	},
	doctor = {
		-- { model = 'buzzard2', label = 'buzzard2', price = 2500}
	},
	chief_doctor = {
		-- { model = 'buzzard2', label = 'buzzard2', price = 2500}
	},
	boss = {
		{ model = 'buzzard2', label = 'buzzard2', price = 2500}
	}

}


Config.Uniforms = {
	ambulance = {
		male = {
			tshirt_1 = 15,  tshirt_2 = 0,
			torso_1 = 250,  torso_2 = 0,
			decals_1 = 58,  decals_2 = 0,
			arms = 85,
			pants_1 = 49,   pants_2 = 0,
			shoes_1 = 77,	shoes_2 = 0,
			glasses_1 = -1, glasses_2 = 0,
			helmet_1 = 8, 	helmet_2 = 0,
			chain_1 = 126,	chain_2 = 0,
		},
		female = {
			tshirt_1 = 14,	tshirt_2 = 0,
			torso_1 = 258,	torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 109,
			pants_1 = 5,	pants_2 = 1,
			shoes_1 = 81,	shoes_2 = 0,
			glasses_1 = -1,	glasses_2 = 0,
			helmet_1 = -1,	helmet_2 = 0,
			chain_1 = 96,	chain_2 = 0,
		}
	},

	doctor = {
		male = {
			tshirt_1 = 15,  tshirt_2 = 0,
			torso_1 = 250,  torso_2 = 0,
			decals_1 = 58,  decals_2 = 0,
			arms = 85,
			pants_1 = 49,   pants_2 = 0,
			shoes_1 = 77,	shoes_2 = 0,
			glasses_1 = -1, glasses_2 = 0,
			helmet_1 = 8, 	helmet_2 = 0,
			chain_1 = 126,	chain_2 = 0,
		},
		female = {
			tshirt_1 = 14,	tshirt_2 = 0,
			torso_1 = 258,	torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 109,
			pants_1 = 5,	pants_2 = 1,
			shoes_1 = 81,	shoes_2 = 0,
			glasses_1 = -1,	glasses_2 = 0,
			helmet_1 = -1,	helmet_2 = 0,
			chain_1 = 96,	chain_2 = 0,
		}
	},

	chief_doctor = {
		male = {
			tshirt_1 = 15,  tshirt_2 = 0,
			torso_1 = 250,  torso_2 = 0,
			decals_1 = 58,  decals_2 = 0,
			arms = 85,
			pants_1 = 49,   pants_2 = 0,
			shoes_1 = 77,	shoes_2 = 0,
			glasses_1 = -1, glasses_2 = 0,
			helmet_1 = 8, 	helmet_2 = 0,
			chain_1 = 126,	chain_2 = 0,
		},
		female = {
			tshirt_1 = 14,	tshirt_2 = 0,
			torso_1 = 258,	torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 109,
			pants_1 = 5,	pants_2 = 1,
			shoes_1 = 81,	shoes_2 = 0,
			glasses_1 = -1,	glasses_2 = 0,
			helmet_1 = -1,	helmet_2 = 0,
			chain_1 = 96,	chain_2 = 0,
		}
	},

	boss = {
		male = {
			tshirt_1 = 15,  tshirt_2 = 0,
			torso_1 = 250,  torso_2 = 0,
			decals_1 = 58,  decals_2 = 0,
			arms = 85,
			pants_1 = 49,   pants_2 = 0,
			shoes_1 = 77,	shoes_2 = 0,
			glasses_1 = -1, glasses_2 = 0,
			helmet_1 = 8, 	helmet_2 = 0,
			chain_1 = 126,	chain_2 = 0,
		},
		female = {
			tshirt_1 = 14,	tshirt_2 = 0,
			torso_1 = 258,	torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 109,
			pants_1 = 5,	pants_2 = 1,
			shoes_1 = 81,	shoes_2 = 0,
			glasses_1 = -1,	glasses_2 = 0,
			helmet_1 = -1,	helmet_2 = 0,
			chain_1 = 96,	chain_2 = 0,
		}
	},

	bullet_wear = {
		male = {
			bproof_1 = 11,  bproof_2 = 1
		},
		female = {
			bproof_1 = 13,  bproof_2 = 1
		}
	},

	gilet_wear = {
		male = {
			tshirt_1 = 59,  tshirt_2 = 1
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1
		}
	}
}