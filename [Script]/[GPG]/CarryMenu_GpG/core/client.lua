ESX = exports["es_extended"]:getSharedObject()

	local cardOpen 					= false
	local PiggyInProgress = false
	local CarryInProgress = false
	local TargetSource      = 0
	local OnBodybag         = false

	AddEventHandler("Fewthz_core:ClientMemoryGarbage", function()
		Citizen.CreateThread(function()
		  Wait(math.random(100, 2000))
		  collectgarbage()
		end)
	end)

	RegisterCommand('MenuCarry', function()
		if not IsPlayerDead(PlayerId()) and not IsPedInAnyVehicle(PlayerPedId(), false) then
			OpenCivilianActionsMenu()
		end
	end, false)
	RegisterKeyMapping('MenuCarry', 'Open Carry Menu', 'keyboard', Config['Key'])

	function OpenCivilianActionsMenu()
		ESX.UI.Menu.CloseAll()

		ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'civilian_actions',
		{
			title    = Config['translateMenu']['TitleText'],
			align    = Config['translateMenu']['Position'],
			elements = {
			{label = (Config['translateMenu']['SubText']), value = 'menu_carry'},
			}
		},
			
			function(data, menu)
				if data.current.value == 'menu_carry' then
					OpenActionMenuInteraction()
				end
			end,
			function(data, menu)
			menu.close()
			end
		)
	end

	local isCarry 				  = false
	function OpenActionMenuInteraction(target)
		local elements = {}
		local target = nil
		if not CarryInProgress then
			table.insert(elements, {label = (Config['translateMenu']['Carry1']), value = 'carry2'})
			table.insert(elements, {label = (Config['translateMenu']['Carry2']), value = 'carry1'})
		else
			table.insert(elements, {label = ('ยกเลิกการอุ้ม'), value = 'cancel'})
		end

		ESX.UI.Menu.CloseAll()

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'action_menu',
			{
				title    = (Config['translateMenu']['SubText']),
				align    = Config['translateMenu']['Position'],
				elements = elements
			},
		function(data, menu)

			local player, distance = ESX.Game.GetClosestPlayer()

			ESX.UI.Menu.CloseAll()	
			local CheckArea = false
			local coords = GetEntityCoords(PlayerPedId())

			if Config['CoordsOutDamage'] ~= nil then
				for k,v in pairs(Config['CoordsOutDamage']) do
					if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < v.size) then
						CheckArea = true
					else
						CheckArea = false
					end
				end
			end

			if CheckArea then
				TriggerEvent("pNotify:SendNotification", {
								text = "ไม่อนุญาติให้อุ้มบริเวณนี้!!",
								type = "error",
								queue = "carry",
								timeout = 3000,
								layout = "bottomCenter"
							})
				--print("[ Area ] Not Allow")
				return
			end
			
			if data.current.value == 'carry1' then	
				if not PiggyInProgress then
					CarryInProgress = true
					local player = PlayerPedId()	
					lib2 = 'amb@prop_human_seat_computer@male@react_shock'
					anim2 =  'forward'
					distans = -0.40
					distans2 = 0.0
					height = 0.10
					spin = 0.0		
					length = 100000
					controlFlagMe = 49
					controlFlagTarget = 33
					animFlagTarget = 1
					local closestPlayer = GetClosestPlayer(3)
					target = GetPlayerServerId(closestPlayer)
					if closestPlayer ~= -1 and closestPlayer ~= nil then
						TriggerServerEvent(GetCurrentResourceName()..':sync', closestPlayer, lib, lib2, anim1, anim2, distans, distans2, height,target,length,spin,controlFlagMe,controlFlagTarget,animFlagTarget,'carry1')
					else
						CarryInProgress = false
						TriggerEvent("pNotify:SendNotification", {
							text = "ไม่พบคนอยู่ใกล้ๆ!!",
							type = "error",
							queue = "carry",
							timeout = 3000,
							layout = "bottomCenter"
						})
					end
				else
					CarryInProgress = false
					ClearPedSecondaryTask(GetPlayerPed(-1))
					DetachEntity(GetPlayerPed(-1), true, false)
					local closestPlayer = GetClosestPlayer(3)
					target = GetPlayerServerId(closestPlayer)
					if closestPlayer ~= nil then
						TriggerServerEvent(GetCurrentResourceName()..":cl_down1",target)
					end
				end		
				menu.close()
			elseif data.current.value == 'carry2' then	
					if not CarryInProgress then
						CarryInProgress = true
						local player = PlayerPedId()	
						lib = 'missfinale_c2mcs_1'
						anim1 = 'fin_c2_mcs_1_camman'
						lib2 = 'nm'
						anim2 = 'firemans_carry'
						distans = 0.15
						distans2 = 0.27
						height = 0.63
						spin = 0.0		
						length = 100000
						controlFlagMe = 49
						controlFlagTarget = 33
						animFlagTarget = 1
						local closestPlayer = GetClosestPlayer(3)
						target = GetPlayerServerId(closestPlayer)
						if closestPlayer ~= -1 and closestPlayer ~= nil then
							TriggerServerEvent(GetCurrentResourceName()..':sync', closestPlayer, lib,lib2, anim1, anim2, distans, distans2, height,target,length,spin,controlFlagMe,controlFlagTarget,animFlagTarget,'carry2')
						else
							CarryInProgress = false
							TriggerEvent("pNotify:SendNotification", {
								text = "ไม่พบคนอยู่ใกล้ๆ!!",
								type = "error",
								queue = "carry",
								timeout = 3000,
								layout = "bottomCenter"
							})
						end
					else
						CarryInProgress = false
						ClearPedSecondaryTask(GetPlayerPed(-1))
						DetachEntity(GetPlayerPed(-1), true, false)
						local closestPlayer = GetClosestPlayer(3)
						target = GetPlayerServerId(closestPlayer)
						if closestPlayer ~= nil then
							TriggerServerEvent(GetCurrentResourceName()..":cl_down2",target)
						end
					end	
				menu.close()
			elseif data.current.value == 'cancel' then
				local closestPlayer = GetClosestPlayer(1)
				target = GetPlayerServerId(closestPlayer)
				if closestPlayer ~= nil then	
					TriggerServerEvent(GetCurrentResourceName()..":cl_down2", target)
					TriggerEvent(GetCurrentResourceName()..":cl_down2")
				else
					TriggerEvent(GetCurrentResourceName()..":cl_down2")
				end
			end
		end,
		function(data, menu)
			menu.close()
			OpenCivilianActionsMenu()
		end)
	end

	RegisterNetEvent(GetCurrentResourceName()..':syncMe')
	AddEventHandler(GetCurrentResourceName()..':syncMe', function(type)
		local playerPed = GetPlayerPed(-1)

		local lib22,anim22
		if type == 'carry1' then
			lib22 = 'move_m@hiking'
			anim22 = 'idle'
		elseif type == 'carry2' then
			lib22 = 'missfinale_c2mcs_1'
			anim22 =  'fin_c2_mcs_1_camman'
		end

		RequestAnimDict(lib22)
		
		while not HasAnimDictLoaded(lib22) do
			Citizen.Wait(10)
		end

		Wait(500)

		TaskPlayAnim(playerPed, lib22, anim22, 8.0, -8.0, -1, 49, 0, false, false, false)
	end)

	RegisterNetEvent(GetCurrentResourceName()..':cl_down1')
	AddEventHandler(GetCurrentResourceName()..':cl_down1', function()
		CarryInProgress = false
		ClearPedSecondaryTask(GetPlayerPed(-1))
		DetachEntity(GetPlayerPed(-1), true, false)
		FreezeEntityPosition(GetPlayerPed(-1),false)
	end)

	RegisterNetEvent('CarryMenu_GpG:SetStatus')
	AddEventHandler('CarryMenu_GpG:SetStatus', function(Status)
		OnBodybag = Status
	end)

	RegisterNetEvent(GetCurrentResourceName()..":errordead")
	AddEventHandler(GetCurrentResourceName()..":errordead", function()
		TriggerEvent("pNotify:SendNotification", {
			text = Config['TextAlert'],
			type = "error",
			queue = "carry",
			timeout = 5000,
			layout = "bottomCenter"
		})
		CarryInProgress = false
	--	print("[ Area ] Not Allow")
	end)

	local isdead = false
	local getbag = false

	function OnPlayerDeath()
		isdead = true
	end

	if Config["framwork"] ~= nil and Config["framwork"]['onPlayerDeath'] ~= nil then 
		AddEventHandler(Config["framwork"]['onPlayerDeath'], function(data)
			OnPlayerDeath()
		end)
	end

	AddEventHandler('esx:onPlayerSpawn', function(first_spawn)
		isdead = false
		getbag = false
	end)

	RegisterNetEvent('nc:getbagcarry')
	AddEventHandler('nc:getbagcarry', function()
		getbag = true
	end)

	RegisterNetEvent('nc:getbagcarryoff')
	AddEventHandler('nc:getbagcarryoff', function()
		getbag = false
	end)

	RegisterNetEvent(GetCurrentResourceName()..':syncTarget')
	AddEventHandler(GetCurrentResourceName()..':syncTarget', function(target, animationLib, animation2, distans, distans2, height, length,spin,controlFlag, department,typecarry)
		
		local EnableRequset = department

		if not Config['ConnectDeadbag'] then
			if isdead or IsEntityInWater(GetPlayerPed(-1)) then
				TargetSource = 0
				EnableRequset = false
			end
		else
			if isdead and OnBodybag == true or IsEntityInWater(GetPlayerPed(-1)) then
				TargetSource = 0
				EnableRequset = false
			elseif isdead and OnBodybag == false or IsEntityInWater(GetPlayerPed(-1)) then
				TriggerServerEvent(GetCurrentResourceName()..":errordead", target)
				return
			end
		end

		if EnableRequset then
			if not isdead and not getbag then
				ESX.UI.Menu.CloseAll()

				ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'Request_Menu',
				{
					title    = 'ตกลงที่จะโดนอุ้มรึป่าว ?',
					align    = 'center',
					elements = {
					{label = ('Yes'), value = 'yes'},
					{label = ('No'), value = 'no'}
					}
				},
				function(data, menu)
				
					local coords = GetEntityCoords(PlayerPedId())
					local targetcoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target)))
					if (GetDistanceBetweenCoords(coords, targetcoords.x, targetcoords.y, targetcoords.z, true) > 5.0) then
						menu.close()
						return
					end

					if data.current.value == 'yes' then
							TargetSource = target
							TriggerServerEvent(GetCurrentResourceName()..':accept', TargetSource , typecarry )
							local playerPed = GetPlayerPed(-1)
							local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
							CarryInProgress = true
							
							RequestAnimDict(animationLib)

							while not HasAnimDictLoaded(animationLib) do
								Citizen.Wait(10)
							end
							if spin == nil then spin = 180.0 end
							FreezeEntityPosition(GetPlayerPed(-1),true)
							AttachEntityToEntity(GetPlayerPed(-1), targetPed, 0, distans2, distans, height, 0.5, 0.5, spin, false, false, false, false, 2, false)
							ClearPedTasksImmediately(GetPlayerPed(-1))
							if controlFlag == nil then controlFlag = 0 end
							TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
							menu.close()
						elseif data.current.value == 'no' then
							menu.close()
					end

				end,
				function(data, menu)
					menu.close()
				end
				)
			else 
				if OnBodybag == true or IsEntityInWater(GetPlayerPed(-1)) or not isdead then
					local playerPed = GetPlayerPed(-1)
					local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
					CarryInProgress = true

					RequestAnimDict(animationLib)

					while not HasAnimDictLoaded(animationLib) do
						Citizen.Wait(10)
					end
					if spin == nil then 
						spin = 180.0 
					end
					TargetSource = target
					TriggerServerEvent(GetCurrentResourceName()..':accept', TargetSource , typecarry )
					FreezeEntityPosition(GetPlayerPed(-1),true)
					AttachEntityToEntity(GetPlayerPed(-1), targetPed, 0, distans2, distans, height, 0.5, 0.5, spin, false, false, false, false, 2, false)
					ClearPedTasksImmediately(GetPlayerPed(-1))
					if controlFlag == nil then 
						controlFlag = 0 
					end
					TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
				end
			end
		else
			if not Config['ConnectDeadbag'] then
				local playerPed = GetPlayerPed(-1)
				local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
				CarryInProgress = true

				RequestAnimDict(animationLib)

				while not HasAnimDictLoaded(animationLib) do
					Citizen.Wait(10)
				end
				if spin == nil then spin = 180.0 end
				FreezeEntityPosition(GetPlayerPed(-1),true)
				AttachEntityToEntity(GetPlayerPed(-1), targetPed, 0, distans2, distans, height, 0.5, 0.5, spin, false, false, false, false, 2, false)
				ClearPedTasksImmediately(GetPlayerPed(-1))
				if controlFlag == nil then controlFlag = 0 end
				TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
			else
				if OnBodybag == true or IsEntityInWater(GetPlayerPed(-1)) or not isdead then
					local playerPed = GetPlayerPed(-1)
					local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
					CarryInProgress = true

					RequestAnimDict(animationLib)

					while not HasAnimDictLoaded(animationLib) do
						Citizen.Wait(10)
					end
					if spin == nil then 
						spin = 180.0 
					end
					TargetSource = target
					TriggerServerEvent(GetCurrentResourceName()..':accept', TargetSource , typecarry )
					FreezeEntityPosition(GetPlayerPed(-1),true)
					AttachEntityToEntity(GetPlayerPed(-1), targetPed, 0, distans2, distans, height, 0.5, 0.5, spin, false, false, false, false, 2, false)
					ClearPedTasksImmediately(GetPlayerPed(-1))
					if controlFlag == nil then 
						controlFlag = 0 
					end
					TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
				end
			end
		end 
	end)

	RegisterNetEvent(GetCurrentResourceName()..':cl_down2')
	AddEventHandler(GetCurrentResourceName()..':cl_down2', function()
		CarryInProgress = false
		ClearPedSecondaryTask(GetPlayerPed(-1))
		DetachEntity(GetPlayerPed(-1), true, false)
		FreezeEntityPosition(GetPlayerPed(-1),false)
	end)

	function GetPlayers()
		local players = {}

		for _, player in ipairs(GetActivePlayers()) do
			if NetworkIsPlayerActive(player) then
				table.insert(players, player)
			end
		end

		return players
	end

	function GetClosestPlayer(radius)
		local players = GetPlayers()
		local closestDistance = -1
		local closestPlayer = -1
		local ply = GetPlayerPed(-1)
		local plyCoords = GetEntityCoords(ply, 0)

		for index,value in ipairs(players) do
			local target = GetPlayerPed(value)
			if(target ~= ply) then
				local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
				local distance = GetDistanceBetweenCoords(targetCoords['x'], targetCoords['y'], targetCoords['z'], plyCoords['x'], plyCoords['y'], plyCoords['z'], true)
				if(closestDistance == -1 or closestDistance > distance) then
					closestPlayer = value
					closestDistance = distance
				end
			end
		end
		-- print("closest player is dist: " .. tostring(closestDistance))
		if closestDistance <= radius then
			return closestPlayer
		else
			return nil
		end
	end

	function LoadAnimationDictionary(animationD)
		while(not HasAnimDictLoaded(animationD)) do
			RequestAnimDict(animationD)
			Citizen.Wait(1)
		end
	end

	RegisterNetEvent('esx_barbie_lyftupp:upplyft')
	AddEventHandler('esx_barbie_lyftupp:upplyft', function(target)
		local playerPed = GetPlayerPed(-1)
		local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
		local lPed = GetPlayerPed(-1)
		local dict = "amb@code_human_in_car_idles@low@ps@"
		
		if isCarry == false then
			LoadAnimationDictionary("amb@code_human_in_car_idles@generic@ps@base")
			
			FreezeEntityPosition(GetPlayerPed(-1),true)
			AttachEntityToEntity(GetPlayerPed(-1), targetPed, 9816, 0.015, 0.38, 0.11, 0.9, 0.30, 90.0, false, false, false, false, 2, false)
			ClearPedTasksImmediately(GetPlayerPed(-1))
			TaskPlayAnim(lPed, "amb@code_human_in_car_idles@generic@ps@base", "base", 8.0, -8, -1, 33, 0, 0, 40, 0)
			isCarry = true
		else
			DetachEntity(GetPlayerPed(-1), true, false)
			ClearPedTasksImmediately(targetPed)
			ClearPedTasksImmediately(GetPlayerPed(-1))
			FreezeEntityPosition(GetPlayerPed(-1),false)
			
			isCarry = false
		end
	end)