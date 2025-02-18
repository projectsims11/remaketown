Config = Config or {}

Config.StatusMax      = 1000000
Config.TickTime       = 1000 -- เวลาอัพเดท กี่ ms
Config.UpdateInterval = 150000  
Config.EffectTick      = 1000

Config.OnTickStatus = function(data)
	TriggerEvent('alonedev_statusbar:UpdateStatus' , data)
end 

Config.Status = {
	hunger = {
		max_val = 1000000,
		onTick = {
			type = 'remove',
			val = 50
		},
		Effect = function(status)
			if status.val == 0 then
				local player = PlayerPedId()
				SetEntityHealth(player , GetEntityHealth(player) - 1)
			end
		end
	},
	stress = {
		max_val = 0,
		color = '#CFAD0F',
		onTick = {
			type = 'add', 
			val = 50
		},
		Effect = function(status)
			if status.val == 1000000 then
				local player = PlayerPedId()
				SetEntityHealth(player , GetEntityHealth(player) - 1)
			end
		end
	},
}
