local loadScript

loadScript = function()

    local IsFirstTime = true

	AddEventHandler(Config.VoiceStateEvent, function(newTalkingRange)  
		SendNUIMessage({
			action = 'send_voice_data',
			voice_mode = newTalkingRange
		})
	end)


	RegisterNetEvent(GetCurrentResourceName() .. ':UpdateStatus')
	AddEventHandler(GetCurrentResourceName() .. ':UpdateStatus' , function(status)
        if IsFirstTime then 
            IsFirstTime = false 
			for i ,v in pairs(Config.Status) do 
				SendNUIMessage({
					action = 'register_status',
					status_name = v.name,
					status_data = v
				})
			end

			SendNUIMessage({
				action = 'setup_department',
				department = Config.DepartMent_Count
			})
        else 
			for i , v in pairs(status) do 
				SendNUIMessage({
					action = 'send_status_data',
					status_name = v.name,
					status_percent = v.percent
				})
			end
        end
    end)

    Citizen.CreateThread(function()
		while true do
			Citizen.Wait(Config.DepartMent_Count.Loop_Tick)
			
			for i , v in pairs(Config.DepartMent_Count.job_list) do 
				local job_count = Config.CheckJob(v.name)
				Wait(Config.DepartMent_Count.Update_delay)
				SendNUIMessage({
					action = 'send_department_data',
					job_name = v.name ,
					job_count = job_count,
				})
			end
		end
	end)

    Citizen.CreateThread(function()
		while true do
			Citizen.Wait(100)
			local playerId = PlayerId()
			local ped = PlayerPedId()
	
			SetPedMaxHealth(ped, Config.SetPlayerUp.SetPedMaxHealth)				
			SetPedMaxTimeUnderwater(ped, Config.SetPlayerUp.SetPedMaxTimeUnderwater) 	


			local playerHealth = GetEntityHealth(ped) - 100	
<<<<<<< HEAD
			--print(playerHealth) -- SHOW HEALTH
=======
			-- print(playerHealth) -- SHOW HEALTHA
>>>>>>> Ruby
			local armor = GetPedArmour(ped)
			local player_id = GetPlayerServerId(PlayerId())
			local FirstName = GetPlayerName(playerId)
			local playerDive = GetPlayerUnderwaterTimeRemaining(playerId) * 100 / Config.SetPlayerUp.SetPedMaxTimeUnderwater

			SendNUIMessage({
				action = 'send_default_data',
				show = IsPauseMenuActive(),
				health = playerHealth,
				dive = playerDive,
				armor = armor,
				id = player_id
			})
		end
	end)

end

Citizen.CreateThread(function()
    print('[^5alonedev_statusbar] ^2Loading Script....')
    Wait(10000)
    if GetCurrentResourceName() == 'alonedev_statusbar' then 
        loadScript()
        print('[^5alonedev_statusbar] ^2Loading Success')
    end
end)




