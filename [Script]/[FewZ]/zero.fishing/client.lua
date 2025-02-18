ESX	= nil
local useitem = false
local startfish = false
local removeitem = 0
local getitem = 0
local fishingrod = 0
local getitemtime = Config['Timetoadd']
local canFishing = false

FzJob = GetCurrentResourceName()

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if useitem then
			if startfish == false then
				startfish = true
				getitem = getitemtime
				fishingrod = checkcount(Config['Itemuse'])
				if Config['ต้องการให้ลบไอเท็มไหม'] then
					removeitem = checkcount(Config['Removeitem'])
				end
			end
		else
			Wait(500)
		end
	end
end)

RegisterNetEvent(FzJob..':Cancel')
AddEventHandler(FzJob..':Cancel', function()
	CancelFishing()
	ClearPedTasksImmediately(GetPlayerPed(-1))
	Citizen.CreateThread(function()
		while true do
			Wait(0)
			if IsControlJustReleased(0, 38) then
				
				break
			end
		end
	end)
end)

RegisterNetEvent(FzJob..':Useitem')
AddEventHandler(FzJob..':Useitem', function()
	for k,v in pairs(Config['Zone']) do
		if GetDistanceBetweenCoords(v.Coords, GetEntityCoords(PlayerPedId()), true) < v.Distance then
			
			if Config['ต้องการให้ลบไอเท็มไหม'] then
				-- local weight, maxWeight = export GetInventoryWeight 
				-- if weight < maxWeight then
		   
				-- 	Wait(200)
				-- 	TriggerEvent('quest:action', 'fish', 1)
				-- 	TriggerServerEvent('fishing:addItem', faketoken)
				-- else
				-- 	notification('นํ้าหนักเต็ม','error')
				-- end
				if checkHasItem(Config['Removeitem']) then
					if useitem then 
						CancelFishing()
					
					else

						useitem = true
						
						
				      
						RequestAnimDict("mini@tennis")
						if not HasAnimDictLoaded("mini@tennis") then
						Citizen.Wait(100)
						end
						TaskPlayAnim(PlayerPedId(), "mini@tennis", "forehand_ts_md_far", 8.0, 1.0, -1, 48, 0, 0, 0, 0 )
						RequestAnimDict("amb@world_human_stand_fishing@idle_a")
						if not HasAnimDictLoaded("amb@world_human_stand_fishing@idle_a") then
						Citizen.Wait(100)
						end
						TaskPlayAnim(PlayerPedId(), "amb@world_human_stand_fishing@idle_a", "idle_c", 8.0, 1.0, -1, 11, 0, 0, 0, 0 )
						TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_STAND_FISHING", 0, true)
						SendNUIMessage({
							action = "OpenMenu",
						})
					end
				else
					exports.pNotify:SendNotification(
						{
							text = 'ท่านไม่มีเยื่อตกปลา',
							type = "error",
							timeout = 3000,
							layout = "bottomCenter",
							queue = "inventoryhud"
						}
					)
				end
			else
				if useitem then 
					CancelFishing()
				else
					useitem = true
					
					RequestAnimDict("mini@tennis")
					if not HasAnimDictLoaded("mini@tennis") then
					  Citizen.Wait(100)
					end
					TaskPlayAnim(PlayerPedId(), "mini@tennis", "forehand_ts_md_far", 8.0, 1.0, -1, 48, 0, 0, 0, 0 )
					RequestAnimDict("amb@world_human_stand_fishing@idle_a")
					if not HasAnimDictLoaded("amb@world_human_stand_fishing@idle_a") then
					  Citizen.Wait(100)
					end
					TaskPlayAnim(PlayerPedId(), "amb@world_human_stand_fishing@idle_a", "idle_c", 8.0, 1.0, -1, 11, 0, 0, 0, 0 )
					TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_STAND_FISHING", 0, true)
					SendNUIMessage({
						action = "OpenMenu",
					})
				end
			end
		else
			Wait(500)
		end
	end
end)


Citizen.CreateThread(function()
	while true do
		Wait(0)
		if startfish then

			SendNUIMessage({
				getitem = getitem,
				removeitem = removeitem,
				fishingrod = fishingrod
			})
			if getitem == 0 then
				TriggerServerEvent(FzJob..":AddItem")
				TriggerEvent("UpdateQuest","quest_fishing", 1)
				if Config['เพิ่มอาหารไหม'] then
					SetEntityHealth(PlayerPedId(),200)
					TriggerEvent("esx_status:add", "hunger", 2000000)
					-- TriggerEvent("esx_status:add", "thirst", 10000)
					TriggerEvent("esx_status:remove", "stress", -2000000)
				end
				getitem = getitemtime
				if Config['ต้องการให้ลบไอเท็มไหม'] then
					removeitem = removeitem - 1
				end
			elseif removeitem == 0 and Config['ต้องการให้ลบไอเท็มไหม'] then
				CancelFishing()
			end 

			if IsControlJustPressed(0, 73) then
				exports.pNotify:SendNotification(
					{
						text = 'ยกเลิกตกปลา',
						type = "error",
						timeout = 3000,
						layout = "bottomCenter",
						queue = "inventoryhud"
					}
				)
				CancelFishing()
			end
		else
			Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(1000)
		if getitem > 0 then 
			getitem = getitem - 1
		end
	end
end)



function checkHasItem(item_name)
	local inventory = ESX.GetPlayerData().inventory
	for i=1, #inventory do
	  local item = inventory[i]
	  if item_name == item.name and item.count > 0 then
		return true
	end
  end
  return false
end

function checkcount(item_name)
	local inventory = ESX.GetPlayerData().inventory
	for i=1, #inventory do
	  local item = inventory[i]
	  	if item_name == item.name then
			return item.count
		end
  	end
end



function CancelFishing()
	useitem = false
	startfish = false
	removeitem = 0
	getitem = 0
	ClearPedTasksImmediately(GetPlayerPed(-1))

	SendNUIMessage({
		action = 'CloseMenu',
	})
end

Citizen.CreateThread(function()
	for k,v in pairs(Config['Zone']) do
		if v.Blips then
			sleep = false
			local blip = AddBlipForCoord(v.Coords)
			SetBlipSprite (blip, v.Blips.sprite)
			SetBlipDisplay(blip, 4)
			SetBlipScale  (blip, v.Blips.scale)
			SetBlipColour (blip, v.Blips.color)
			SetBlipAsShortRange(blip, true)
			AddTextEntry('BLIP_PROCESS', v.Blips.name)
			BeginTextCommandSetBlipName("BLIP_PROCESS")
			EndTextCommandSetBlipName(blip)
		end
	end
end)


