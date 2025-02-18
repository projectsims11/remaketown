ESX = exports["es_extended"]:getSharedObject()

local cachedPlant = {}
local closestPlant = Config.Prop
local isPickingUp = false
local duration = Config.Load
ServerEvent = {}
script_name = GetCurrentResourceName()

CreateThread(function()
    if ESX.IsPlayerLoaded() then
		ESX.PlayerData = ESX.GetPlayerData()
	end
	PlayerData = ESX.GetPlayerData()
	Wait(1000)
	TriggerServerEvent(script_name .. ':server:LoadConfig')
end)

RegisterNetEvent(script_name .. ':client:GetConfig')
AddEventHandler(script_name .. ':client:GetConfig',  function(f)
    ServerEvent = f.se
	cachedPlant = f.cp
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(response)
	ESX.PlayerData = response
end)

RegisterNetEvent(script_name .. "fetchCooldown")
AddEventHandler(script_name .. "fetchCooldown", function(netid, time)
	cachedPlant[netid] = GetGameTimer() + (time * 1000)
end)

local bid = {}
local delay = 0
local isPicking = false
local Boom = false
coordsfewthz = {}
CreateThread(function()
    while true do
        local sleep = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
		coordsfewthz = GetEntityCoords(playerPed)
		for i = 1, #closestPlant do
			local x = GetClosestObjectOfType(playerCoords, 1.20, closestPlant[i], false, false, false)
			local entity = nil
			if Config.UseFarfromCity then
				if (GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.Location, true) < Config.FarfromCity) then 
					if DoesEntityExist(x) then
						entity = x
						Plant    = GetEntityCoords(entity)
						sleep  = 0
						local netid = string.format("%.2f%.2f%.2f",Plant.x,Plant.y,Plant.z)
						
						if cachedPlant[netid] and cachedPlant[netid] > GetGameTimer() then
							DrawText3D(Plant.x, Plant.y, Plant.z + 1.5, "There's no ~b~Cement~s~ left")  
						elseif bid[netid] and bid[netid] > GetGameTimer() then
							DrawText3D(Plant.x, Plant.y, Plant.z + 1.5, "There's no ~b~Cement~s~ left")  
						else
							DrawText3D(Plant.x, Plant.y, Plant.z + 1.5, 'Press [~g~E~s~] to steal the ~b~Cement~s~')  
						end
						if IsControlJustReleased(0, 38) and not IsPedInAnyVehicle(PlayerPedId(), false) and IsPedOnFoot(PlayerPedId()) and not isPicking then
							if checkHasItem(Config.ItemNeed.Item) or Config.ItemNeed.Enabel then
								if NoallowJob(Config.NoallowJob) then
									exports['mythic_notify']:SendAlert('error', 'Please Off Duty',  5500)
								else
									if not delay or delay and delay < GetGameTimer() then
										delay = GetGameTimer() + 1000
										if not cachedPlant[netid] or cachedPlant[netid] and cachedPlant[netid] < GetGameTimer() then
											if bid[netid] and bid[netid] > GetGameTimer() then
												ESX.ShowNotification('~r~Someone is stealing this.~s~')
											else
												if exports.Fewthz_Check:CheckPolice(Config.Cops) then
													TriggerServerEvent(script_name..':fetchCement', netid)
													isPicking = true
													Boom = true
													OpenPlant(entity)
												else
													TriggerEvent("pNotify:SendNotification", {
														text = '<strong class="red-text">ต้องการตำรวจจำนวน '  ..Config.Cops..  ' นายในการขโมย</strong>',
														type = "error",
														timeout = 5000,
														layout = "bottomCenter",
														queue = "global"
													})
												end
											end
										else
											TriggerEvent("pNotify:SendNotification", {
												text = 'มีคนขโมยไปเเล้ว',
												type = "error",
												timeout = 5000,
												layout = "bottomCenter",
												queue = "global"
											})
										end
									end
								end
							else
								TriggerEvent("pNotify:SendNotification", {
									text = 'ไม่มีอุปกรณ์ทำงานดำ',
									type = "error",
									timeout = 5000,
									layout = "bottomCenter",
									queue = "global"
								})
							end
						end
						break
					else
						sleep = 1000
					end
				end
			else
				if DoesEntityExist(x) then
					entity = x
					Plant    = GetEntityCoords(entity)
					sleep  = 0
					local netid = string.format("%.2f%.2f%.2f",Plant.x,Plant.y,Plant.z)
					
					if cachedPlant[netid] and cachedPlant[netid] > GetGameTimer() then
						DrawText3D(Plant.x, Plant.y, Plant.z + 1.5, "There's no ~b~Cement~s~ left")  
					elseif bid[netid] and bid[netid] > GetGameTimer() then
						DrawText3D(Plant.x, Plant.y, Plant.z + 1.5, "There's no ~b~Cement~s~ left")  
					else
						DrawText3D(Plant.x, Plant.y, Plant.z + 1.5, 'Press [~g~E~s~] to steal the ~b~Cement~s~')  
					end
					if IsControlJustReleased(0, 38) and not IsPedInAnyVehicle(PlayerPedId(), false) and IsPedOnFoot(PlayerPedId()) and not isPicking then
						if checkHasItem(Config.ItemNeed.Item) or Config.ItemNeed.Enabel then
							if NoallowJob(Config.NoallowJob) then
								exports['mythic_notify']:SendAlert('error', 'Please Off Duty',  5500)
							else
								if not delay or delay and delay < GetGameTimer() then
									delay = GetGameTimer() + 1000
									if not cachedPlant[netid] or cachedPlant[netid] and cachedPlant[netid] < GetGameTimer() then
										if bid[netid] and bid[netid] > GetGameTimer() then
											ESX.ShowNotification('~r~Someone is stealing this.~s~')
										else
											if exports.Fewthz_Check:CheckPolice(Config.Cops) then
												TriggerServerEvent(script_name..':fetchCement', netid)
												isPicking = true
												Boom = true
												OpenPlant(entity)
											else
												TriggerEvent("pNotify:SendNotification", {
													text = '<strong class="red-text">ต้องการตำรวจจำนวน '  ..Config.Cops..  ' นายในการขโมย</strong>',
													type = "error",
													timeout = 5000,
													layout = "bottomCenter",
													queue = "global"
												})
											end
										end
									else
										TriggerEvent("pNotify:SendNotification", {
											text = 'มีคนขโมยไปเเล้ว',
											type = "error",
											timeout = 5000,
											layout = "bottomCenter",
											queue = "global"
										})
									end
								end
							end
						else
							TriggerEvent("pNotify:SendNotification", {
								text = 'ไม่มีอุปกรณ์ทำงานดำ',
								type = "error",
								timeout = 5000,
								layout = "bottomCenter",
								queue = "global"
							})
						end
					end
					break
				else
					sleep = 1000
				end
			end
		end
        Wait(sleep)
    end
end)

local _isPick = false

function OpenPlant(entity, delay)
	if Config.AlertPolice.script.Alert then
		TriggerEvent(Config.AlertPolice.script.Event, Config.AlertPolice.script.source)
	end
	FreezeEntityPosition(entity, true)
	_isPick = true
	isPicking = true
	Boom = true
	LoadDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
	TaskPlayAnim(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 3.0, 1.0, -1, 49, 0, 0, 0, 0)	
	exports['mythic_progbar']:Progress({
		name = "unique_action_name",
		duration = duration,
		label = "Please Wait...",
		useWhileDead = false,
		canCancel = true,
		removemoney = true,
		countremove = 500,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true
		},
	}, function(status)
		if not status then
			local netid = string.format("%.2f%.2f%.2f",Plant.x,Plant.y,Plant.z)
			if cachedPlant[netid] and cachedPlant[netid] > GetGameTimer() then
				TriggerEvent("pNotify:SendNotification", {
					text = 'ช้าไปวัยรุ่น',
					type = "error",
					timeout = 5000,
					layout = "bottomCenter",
					queue = "global"
				})
				isPicking = false
				Boom = false
				_isPick = false
				return
			end
			TriggerServerEvent(script_name .. ServerEvent[1], netid)
			ClearPedTasksImmediately(PlayerPedId())
			FreezeEntityPosition(entity, false)
			isPicking = false
			Boom = false
			_isPick = false
		else
			isPicking = false
			Boom = false
			_isPick = false
		end
	end)
end

RegisterNetEvent(script_name..":fetchCement")
AddEventHandler(script_name..":fetchCement", function(netid)
	bid[netid] = GetGameTimer() + duration
end)

CreateThread(function()
	while Config['ป้องกันการบัคจากผู้เล่น'] do 
		Wait(0)
		if Boom then 
			local PlayerCoords = GetEntityCoords(PlayerPedId())
			if GetDistanceBetweenCoords(PlayerCoords,coordsfewthz.x,coordsfewthz.y,coordsfewthz.z) <= 5 then
			else
				local ped = GetPlayerPed(-1)
				local PedPos = GetEntityCoords(ped)  				
                AddExplosion(PedPos.x, PedPos.y, PedPos.z+1.00, 34, 1.00, true, false, 5.00)
                Wait(1000)
			end
		else
			Wait(1000)
		end 
	end 
end)

CreateThread(function()
	while true do
		Wait(0)
		if isPicking then
			DisableControlAction(0, 29, true) -- B
			DisableControlAction(0, 73, true) -- X
			DisableControlAction(0, 323, true) -- X
			DisableControlAction(0, 245, true) -- T
			DisableControlAction(0, 246, true) -- Y
			DisableControlAction(0, 170, true) -- F3
			DisableControlAction(0, 23, true) -- F
			DisableControlAction(0, 44, true) -- Q
			DisableControlAction(0, 21, true) -- LEFT SHIFT
			DisableControlAction(0, 74, true) -- H
			DisableControlAction(0, 22, true) -- SPACEBAR
		else
			Wait(1000)
		end
	end
end)

DrawText3D = function(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
  
	local scale = 0.45
   
	if onScreen then
		SetTextScale(scale, scale)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 370
        DrawRect(_x, _y + 0.0150, 0.030 + factor , 0.030, 66, 66, 66, 150)
	end
end

function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Wait(10)
    end
end

function NoallowJob(joblist)
	if #joblist < 1 then
		return true
	end
	local playerJob = ESX.GetPlayerData().job
	for _, job in ipairs(joblist) do
		if job == playerJob.name then
			return true
		end
	end
	return false
end

function checkHasItem (item_name)
	local inventory = ESX.GetPlayerData().inventory
	for i=1, #inventory do
	  local item = inventory[i]
	  if item_name == item.name and item.count > 0 then
		return true
	  end
	end
	return false
end

AddEventHandler("Fewthz_core:ClientMemoryGarbage", function()
	Citizen.CreateThread(function()
		Wait(math.random(100, 2000))
		collectgarbage()
	end)
end)