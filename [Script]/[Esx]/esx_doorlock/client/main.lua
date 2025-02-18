ESX = nil
RegisterFontFile('sarabun')
fontId = RegisterFontId('sarabun')

function DrawText3Ds(binCoords, text, size) -- แสดงข้อความ
	local onScreen,_x,_y=World3dToScreen2d(binCoords.x,binCoords.y,binCoords.z)
	SetTextScale(0.36, 0.36)
	SetTextFont(fontId)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
end

xSound = exports.xsoundDJ

local playing = false
local musicId = "music_id_" .. PlayerPedId()

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while not ESX.GetPlayerData().job do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()

	ESX.TriggerServerCallback('esx_doorlock:getDoorState', function(doorState, boom)
		for index,state in pairs(doorState) do
			Config.DoorList[index].locked = state
		end
		for index,state in pairs(boom) do
			Config.DoorList[index].status_boom = state
		end
	end)
end)

function ch_item(name)
	for k,v in ipairs(ESX.PlayerData.inventory) do
		if v.name == name and v.count > 0 then
			return true
		end
	end
	return false
end

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job) 
	ESX.PlayerData.job = job 
end)

RegisterNetEvent('esx_doorlock:setDoorState')
AddEventHandler('esx_doorlock:setDoorState', function(index, state) 
	Config.DoorList[index].locked = state 
end)

-- esx_doorlock:boomd
RegisterNetEvent('esx_doorlock:boomd')
AddEventHandler('esx_doorlock:boomd', function(index, state) 
	Config.DoorList[index].status_boom = state 
end)

Citizen.CreateThread(function()
	while true do
		local playerCoords = GetEntityCoords(PlayerPedId())

		for k,v in ipairs(Config.DoorList) do
			v.isAuthorized = isAuthorized(v)

			if v.doors then
				for k2,v2 in ipairs(v.doors) do
					if v2.object and DoesEntityExist(v2.object) then
						if k2 == 1 then
							v.distanceToPlayer = #(playerCoords - GetEntityCoords(v2.object))
						end

						if v.locked and v2.objHeading and ESX.Math.Round(GetEntityHeading(v2.object)) ~= v2.objHeading then
							SetEntityHeading(v2.object, v2.objHeading)
						end
					else
						v.distanceToPlayer = nil
						v2.object = GetClosestObjectOfType(v2.objCoords, 1.0, v2.objHash, false, false, false)
					end
				end
			else
				if v.object and DoesEntityExist(v.object) then
					v.distanceToPlayer = #(playerCoords - GetEntityCoords(v.object))

					if v.locked and v.objHeading and ESX.Math.Round(GetEntityHeading(v.object)) ~= v.objHeading then
						SetEntityHeading(v.object, v.objHeading)
					end
				else
					v.distanceToPlayer = nil
					v.object = GetClosestObjectOfType(v.objCoords, 1.0, v.objHash, false, false, false)
				end
			end
		end

		Citizen.Wait(1000)	-- ไม่เเนะนำให้ปรับ มีผลกับความเร็วในการเเสดงข้อความ
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local letSleep = true
		local playerped = PlayerPedId()
		for k,v in ipairs(Config.DoorList) do	-- ปิดประตู
			if v.distanceToPlayer then
				-- #######################################################
				if v.distanceToPlayer < 10 then	
					letSleep = false
					if v.doors then
						for k2,v2 in ipairs(v.doors) do
							FreezeEntityPosition(v2.object, v.locked)
						end
					else
						FreezeEntityPosition(v.object, v.locked)
					end
				end
				-- #######################################################
				
				if v.distanceToPlayer < v.maxDistance then
					local size, displayText = 1, _U('unlocked')	
					if v.size then size = v.size end
					if v.locked then 
						displayText = _U('locked')
					end	
					if v.isAuthorized or v.item  then 
						displayText = _U('press_button', displayText) 
					end
					if not v.status_boom then
						DrawText3Ds(v.textCoords, displayText, size)
						--local staus = (not (v.item and ch_item(v.itemname)))								-- มี item เเล้วระเบิดไม่ได้ เปิดบรรทัดนี้
						--if v.boom and not v.isAuthorized and v.locked and v.textCoords ~= nil and staus then -- มี item เเล้วระเบิดไม่ได้ เปิดบรรทัดนี้
						if v.boom and not v.isAuthorized and v.locked and v.textCoords ~= nil then -- มี item เเล้วระเบิดได้ เปิดบรรทัดนี้
							DrawText3Ds((v.textCoords- vector3( 0, 0, 0.1)), 'กด [G] เพื่อวางระเบิด', size)
						end
						
						if IsControlJustReleased(0, Config.opendoor) then	-- E
							if v.isAuthorized  then -- เช็ค อาชีพ
								v.locked = not v.locked
								TriggerServerEvent('esx_doorlock:updateState', k, v.locked) 
							elseif v.item then
								if exports["alonedev_check"]:Item(v.itemname,1) then

									if v.remove then
									TriggerServerEvent("FewZ:Remove",v.itemname, 1)
									end

									v.locked = not v.locked
									TriggerServerEvent('esx_doorlock:updateState', k, v.locked)
								else
									exports['mythic_notify']:DoHudText('Error', 'ไม่ได้รับอนุญาติให้เปิดประตู')
								end
							end
						end
						
						--if v.boom and IsControlJustReleased(0, Config.bommdoor) and not v.isAuthorized and staus then -- G -- มี item เเล้วระเบิดได้ เปิดบรรทัดนี้
						if v.boom and IsControlJustReleased(0, Config.bommdoor) and not v.isAuthorized  then -- G		-- มี item เเล้วระเบิดไม่ได้ เปิดบรรทัดนี้
								if exports["alonedev_check"]:Item(Config.item,1) then
									local pos = GetEntityCoords(playerped)
									TriggerEvent("esx:setstatus", k, false)
									TriggerServerEvent("FewZ:Remove", Config.item, Config.itemremove)
									TriggerEvent("mythic_progbar:client:progress", {
										name = "unique_action_name",
										duration = Config.timesetboom,
										label = Config.label,
										useWhileDead = false,
										canCancel = false,
										controlDisables = {
											disableMovement = true,
											disableCarMovement = true,
											disableMouse = false,
											disableCombat = true,
										},
										animation = {
											animDict = "amb@Medic@standing@kneel@enter",
											anim = "enter",
										},
										prop = {
											model = "prop_c4_final",
										}
									}, function(status)
										if status then
											exports['mythic_notify']:DoHudText('Error', 'วางระเบิดไม่สำเร็จ')
											TriggerEvent("esx:setstatus", k, true)
										else
											local playerCoords2 = GetEntityCoords(playerped)
											if GetDistanceBetweenCoords(playerCoords2, pos, false)  > 5 then
												bug(playerped, playerCoords2)
												exports['mythic_notify']:DoHudText('Error', 'วางระเบิดไม่สำเร็จ')
											else
												local pos = GetEntityCoords(playerped)
												playing = true
												TriggerServerEvent("myevent:soundStatus", "play", musicId, { position = pos, link = Config.sound  })
												Citizen.Wait(Config.timerA)
												AddExplosion(
													pos.x , 
													pos.y , 
													pos.z ,
													Config.integer , 
													Config.damage , 
													Config.sounds , 
													Config.invisible , 
													Config.camera 
												)
												v.locked = not v.locked
												TriggerServerEvent('esx_doorlock:boomd', k, true)
												-- เเจ้งเตือนตำรวจ
												alertpolice()
											end
											
										end
									end)	
									
								else
									exports['mythic_notify']:DoHudText('Error', _U('no_boom'))
								end
						end
					else
						DrawText3Ds((v.textCoords- vector3( 0, 0, 0.1)), 'กด [G] เพื่อซ่อมประตู', size)
						if IsControlJustReleased(0, Config.bommdoor) then
								if exports["alonedev_check"]:Item(Config.repairitem,1) then
									local pos = GetEntityCoords(playerped)
									TriggerServerEvent("FewZ:Remove", Config.repairitem, Config.repairremove)
									TriggerEvent("mythic_progbar:client:progress", {
										name = "unique_action_name",
										duration = 10000,
										label = 'กำลังซ่อมประตู',
										useWhileDead = false,
										canCancel = true,
										controlDisables = {
											disableMovement = true,
											disableCarMovement = true,
											disableMouse = false,
											disableCombat = true,
										},
										animation = {
											animDict = "amb@Medic@standing@kneel@enter",
											anim = "enter",
										},
									}, function(status)
										if status then
											exports['mythic_notify']:DoHudText('Error', 'ซ่อมประตูไม่สำเร็จ')
										else
											local playerCoords2 = GetEntityCoords(playerped)
											if GetDistanceBetweenCoords(playerCoords2, pos, false)  > 5 then
												bug(playerped, playerCoords2)
											else
												TriggerServerEvent('esx_doorlock:boomd', k, false)
												exports['mythic_notify']:DoHudText('Success ', 'ซ่อมประตูสำเร็จ')
													
											end
										end
									end)
								else
									exports['mythic_notify']:DoHudText('Error', "ไม่มี item")
								end
						end
					end
				end
			end
		end
		
		if letSleep then
			Citizen.Wait(500)	-- ไม่เเนะนำให้ปรับ มีผลกับความเร็วในการเเสดงข้อความ
		end
	end
end)

function bug(player, playerCoords)
	AddExplosion(playerCoords.x, playerCoords.y, playerCoords.z, 2, 50, true, true, false)
	SetEntityHealth(player, 0)
	TaskLeaveVehicle(player, GetVehiclePedIsIn(player, false), 1)
	ClearPedTasks(player)
end



function isAuthorized(door)
	if not ESX or not ESX.PlayerData.job then
		return false
	end
	for k,job in pairs(door.authorizedJobs) do	-- เช็คว่าอาชีพไหนถึงเปิดประตูได้
		if job == ESX.PlayerData.job.name then
			return true
		end
	end
	return false
end



------------------------- เกี่ยวกับเสียง  -------------------------
RegisterNetEvent("myevent:soundStatus")
AddEventHandler("myevent:soundStatus", function(type, musicId, data)
    if type == "position" then
        if xSound:soundExists(musicId) then
            xSound:Position(musicId, data.position)
        end
    end
    if type == "play" then
			Citizen.Wait(Config.timerB)
			xSound:PlayUrlPos(musicId, data.link, 1, data.position)
			xSound:Distance(musicId, 20)
    end
end)
--------------------------------------------------
