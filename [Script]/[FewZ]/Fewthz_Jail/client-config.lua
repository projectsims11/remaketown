Config = {}

Config.BlurBackdrop = true

Config.UnjailPosition = vector3(1848.969970703125, 2585.989990234375, 45.66999816894531)

Config.JailLocations = {
	['large_prison'] = {
		Label = 'คุก',
		JailPosition = vector3(1680.1700439453125, 2513.1201171875, 46.56000137329101),
	},
	['small_prison'] = {
		Label = 'ตู้ปลา',   
		JailPosition = vector3(135.2899932861328, -919.4400024414064, 30.27000045776367),
	}
}

-- Command /jailer
Config.DevTest = true

Config.Executor = {
	OnUnJailed = function()
		-- alert on player unjailed

		TriggerEvent('mythic_notify:client:SendAlert', {
			type = 'inform',
			text = 'คุณถูกปล่อยจากการขังแล้ว'
		})
	end,

	OnNoPlayerNearby = function()
		TriggerEvent('mythic_notify:client:SendAlert', {
			type = 'inform',
			text = 'ไม่มีผู้เล่นอยู่ใกล้'
		})
	end
}

Config.CutScene = true

Config.Uniforms = {
	prison_wear = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1']  = 146, ['torso_2']  = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms']     = 0,   ['pants_1']  = 3,
			['pants_2']  = 7,   ['shoes_1']  = 12,
			['shoes_2']  = 12,  ['chain_1']  = 50,
			['chain_2']  = 0
		},
		female = {
			['tshirt_1'] = 3,   ['tshirt_2'] = 0,
			['torso_1']  = 38,  ['torso_2']  = 3,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms']     = 2,   ['pants_1']  = 3,
			['pants_2']  = 15,  ['shoes_1']  = 66,
			['shoes_2']  = 5,   ['chain_1']  = 0,
			['chain_2']  = 2
		}
	}
}