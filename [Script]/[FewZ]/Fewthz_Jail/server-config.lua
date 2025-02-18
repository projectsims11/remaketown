Config = {}

Config.JailTimeSyncInterval = 60000 * 60

Config.Executor = {
	OnJailed = function(playerId, reason)
		TriggerClientEvent('chat:addMessage', -1, {
            template = [[
                <div style="display: flex; align-items: center; position: relative; padding: 0.45vw 0.45vw; margin: 1.0vw; background: rgba(0, 24, 64, 0.7);border-radius:8px;">
                    <span style="display: flex; align-items: center; background: rgba(255, 255, 255, 0.8); color: #222; padding: 2px 6px; border-radius: 8px; font-size: 0.85rem;">
                        <ion-icon name="business-outline"></ion-icon>&nbsp;{0}
                    </span>
                    <span style="margin-left: 8px;">{1} : {2}</span>
                </div>
            ]],
            args = { 'ศาลพิพากษา', GetPlayerName(playerId), reason }
        })
	end,
    OnAlertTiming = function(playerId, millisec)
        TriggerClientEvent('pNotify:SendNotification', playerId, {
            type = 'success',
            text = 'เหลือเวลาอยู่ ' .. ESX.Math.Round(millisec) / 1000 .. ' วินาที',
            layout = "centerRight",
            length = 5000
        })
    end
}

Config.InitExtended = function()
    ESX.RegisterCommand('unjail', 'admin', function(xPlayer, args, showError)
        unjailPlayer(args.playerId)
    end, true, {
        help = 'Unjail a player', 
        validate = true, 
        arguments = {
            {
                name = 'playerId', 
                help = 'player id', 
                type = 'playerId'
            }
        }
    })
end