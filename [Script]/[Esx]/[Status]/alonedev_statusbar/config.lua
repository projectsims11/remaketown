Config = Config or {}

Config.VoiceStateEvent = 'pma-voice:setTalkingMode'

Config.Command = {
	OpenHealthPercent = 'remake_town'
}

Config.SetPlayerUp = {
	SetPedMaxHealth = 200 ,
	SetPedMaxTimeUnderwater = 10.0
}

Config.CheckJob = function(job_name)
	return exports.alonedev_check:CheckJobOnline(job_name)
end

Config.Status = {
    {
		name = 'hunger',
		max_val = 1000000,
		color1 = '#1F7AE2',
		color2 = '#96C0F0',
        image = 'food.png'
	},
    {
		name = 'stress',
		max_val = 1000000,
		color1 = '#1F7AE2',
		color2 = '#96C0F0',
        image = 'stress.png'
	},
	{ -- ลบไม่ได้ หลอดดำน้ำ
		name = 'dive',
		color1 = '#1F7AE2',
		color2 = '#96C0F0',
        image = 'dive.png'
	},
}

Config.DepartMent_Count = {
	Loop_Tick = 10000 ,
	Update_delay = 500 ,
	position = {
		x = 1,
		y = 10
	},
	job_list = {
		{
			name = 'police',
			image = 'police.png'
		},
		{
			name = 'ambulance',
			image = 'ambulance.png'
		},
		{
			name = 'council',
			image = 'council.png'
		},
	}
}