Config = {}
Config.DepositCarBlip		= 'Deposit Car'
Config.DepositCarGarages	= true
Config.DrawDistance 		= 20.0
Config.DepositMarker 	= { type = 1, r = 49, g = 118, b = 245, x = 15.0, y = 15.0, z = 1.5 }
Config.UnDepositMarker = { type = 1, r = 49, g = 118, b = 245, x = 5.0, y = 5.0, z = 1.5 }
Config.BlipDepositCar = {
	Sprite = 58,
	Color = 1,
	Scale = 2.0
}

Config.Control = {
	Open	  = true,		-- true ใช้ ข้อความ Text / false ใช้ Marker
    Text   = "(~g~จัดการฝากรถ~w~)",
}

Config.TRUNK_EVENT = function(plate)
    TriggerEvent("xzero_trunk:CL:On_OpenInventoryMobile",plate)
end

Config.Progbar = function()
    TriggerEvent("mythic_progbar:client:progress" , {
		name = "unique_action_name",
		label = 'กำลังเบิกรถ . . .' ,
		duration = 2000,
		useWhileDead = false,
		canCancel = false,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,	
		},
		animation = {
			animDict = "anim@amb@nightclub@mini@dance@dance_paired@dance_h@",
			anim = "ped_b_dance_idle",
		},
	})
	Wait(2000)
end

Config.DepositCar = {
	deposit1 = {
		Blips = false,
		DepositPoint = { x = 2967.659912109375, y= 2817.75, z= 43.72000122070312 }, -- จุดเก็บ
		SpawnDepositPoint = { x = 2982.25, y = 2808.97, z = 43.54, h = 13.7 }, -- SpawnCAR
		UnDepositPoint = { x = 2985.510009765625, y = 2803.739990234375, z = 43.86000061035156 }, -- จุดเบิก & เปิดท้ายรถ
		NPC = {
			{
				heading = 115.00,	-- จะให้ NPC หันไปทางไหน
				ModelName = "u_m_y_juggernaut_01"; -- Model ของ NPC จะใส่เป็น (https://forge.plebmasters.de/peds) <--หาได้จากเว็บไซต์นี้
            	ModelHash = "u_m_y_juggernaut_01";
            	AnimDictionary = "mini@strip_club@idles@bouncer@base";
            	AnimationName = "base";
			}
		},
        key = "deposit1"
	},
	deposit2 = {
		Blips = false,
		DepositPoint = { x = 2627.68994140625, y=4434.56005859375, z=40.88999938964844 },
		SpawnDepositPoint = { x = -1044.0319, y = -2943.2080, z = 14.9596, h = 225.93 },
		UnDepositPoint = { x = 2627.68994140625, y=4434.56005859375, z=40.88999938964844 },
		NPC = {
			{
				heading = 115.00,	-- จะให้ NPC หันไปทางไหน
				ModelName = "A_F_M_FatCult_01"; -- Model ของ NPC จะใส่เป็น (https://forge.plebmasters.de/peds) <--หาได้จากเว็บไซต์นี้
            	ModelHash = "A_F_M_FatCult_01";
            	AnimDictionary = "mini@strip_club@idles@bouncer@base";
            	AnimationName = "base";
			}
		},
        key = "deposit2"
	},
}
