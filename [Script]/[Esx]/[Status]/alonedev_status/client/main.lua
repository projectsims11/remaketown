ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do 
		ESX = exports["es_extended"]:getSharedObject()
		Wait(100)
	end
end)
local Status, isPaused = {}, false

function GetStatusData(minimal)
	local status = {}

	for i=1, #Status, 1 do
		if minimal then
			table.insert(status, {
				name    = Status[i].name,
				val     = Status[i].val,
				percent = (Status[i].val / Config.StatusMax) * 100
			})
		else
			table.insert(status, {
				name    = Status[i].name,
				val     = Status[i].val,
				color   = Status[i].color,
				visible = Status[i].visible(Status[i]),
				max     = Status[i].max,
				percent = (Status[i].val / Config.StatusMax) * 100
			})
		end
	end

	return status
end

AddEventHandler('alonedev_status:registerStatus', function(name, default, color, visible, tickCallback)
	local status = CreateStatus(name, default, color, visible, tickCallback)
	table.insert(Status, status)
end)

AddEventHandler('alonedev_status:unregisterStatus', function(name)
	for k,v in ipairs(Status) do
		if v.name == name then
			table.remove(Status, k)
			break
		end
	end
end)

RegisterNetEvent('alonedev_status:load')
AddEventHandler('alonedev_status:load', function(status)
	TriggerEvent('alonedev_status:loaded' , status)

	Citizen.CreateThread(function()
		while true do
			for i=1, #Status, 1 do
				Status[i].onTick()
			end

			Config.OnTickStatus(GetStatusData(true))
			Citizen.Wait(Config.TickTime)
		end
	end)

end)

RegisterNetEvent('alonedev_status:set')
AddEventHandler('alonedev_status:set', function(name, val)
	for i=1, #Status, 1 do
		if Status[i].name == name then
			Status[i].set(val)
			break
		end
	end

end)

RegisterNetEvent('alonedev_status:add')
AddEventHandler('alonedev_status:add', function(name, val)
	for i=1, #Status, 1 do
		if Status[i].name == name then
			Status[i].add(val)
			break
		end
	end

end)

RegisterNetEvent('alonedev_status:remove')
AddEventHandler('alonedev_status:remove', function(name, val)
	for i=1, #Status, 1 do
		if Status[i].name == name then
			Status[i].remove(val)
			break
		end
	end
end)

AddEventHandler('alonedev_status:getStatus', function(name, cb)
	for i=1, #Status, 1 do
		if Status[i].name == name then
			cb(Status[i])
			return
		end
	end
end)

-- Update server
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(Config.UpdateInterval)

		TriggerServerEvent('alonedev_status:update', GetStatusData(true))
	end
end)


-- BASIC NEEDS COLLAP 

RegisterFontFile("ThaiFont")
fontId = RegisterFontId("ThaiFont") 


local IsDead = false
local IsAnimated = false
local IsEating = false

AddEventHandler('esx:onPlayerDeath', function()
	IsDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	IsDead = false
end)


AddEventHandler('alonedev_status:loaded', function(status2)
	for status_name , val in pairs(Config.Status) do 
		TriggerEvent('alonedev_status:registerStatus', status_name, val.max_val, val.color , function(status)
			return false
		end, function(status)
			if val.onTick.type == 'remove' then 
				status.remove(val.onTick.val) 
			elseif val.onTick.type == 'add' then 
				status.add(val.onTick.val) 
			end
		end)
	end
	
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(Config.EffectTick)
			for status_name , val in pairs(Config.Status) do 
				TriggerEvent('alonedev_status:getStatus', status_name, function(status)
					val.Effect(status)
				end)
			end
		end
	end)
end)



function checkHasItem (item_name)
	local inventory = ESX.GetPlayerData().inventory
	for i=1, #inventory do
	  local item = inventory[i]
	  if item_name == item.name and item.count > 0 then
		HaveItem = true
		return true
	  end
	end

	HaveItem = false
	return false
end

RegisterNetEvent('alonedev_status:EatAll')  --- สำหรับ อาหารที่ต้องการเอาออกไปกินนอกโซนให้ Server Trigger มาใช้อันนี้
AddEventHandler('alonedev_status:EatAll', function(item)

	local t = Config.Food[item]
	local zone_pass = true
	local pcoords = GetEntityCoords(PlayerPedId())

	if t.zone.enable then 
		local distance = GetDistanceBetweenCoords(t.zone.coords , pcoords)

		if distance > t.zone.radius then 
			zone_pass = false
		end
	end
	
	if not IsEating then

		if not zone_pass then
			Config.Noti('<strong class="blue-text">ไปที่ โซนคลายเครียด ก่อน!!!</strong>' , "error")
			return
		end

		local ped = PlayerPedId()

		local Anim_Dict = t.emote.anim_dict
		local Anim_Start = t.emote.anim_start
		local Anim_Loop = t.emote.anim_loop
		local Anim_End = t.emote.Anim_End
		local prop_name = t.emote.prop

		if (DoesEntityExist(ped) and not IsEntityDead(ped)) then 

			IsEating = true

			local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
			local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(prop_name), false, false, false)
			if object ~= 0 then
				DeleteObject(object)
			end

			local x,y,z = table.unpack(GetEntityCoords(ped))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)

			t.emote.attach(prop , ped)

			loadAnimDict(Anim_Dict)

			TaskPlayAnim(ped, Anim_Dict, Anim_Start, 8.0, 1.0, -1, 2, 0, 0, 0, 0)

			while (GetEntityAnimCurrentTime(ped, Anim_Dict, Anim_Start) < 0.999999) do 
				Citizen.Wait(0)
			end 

			ClearPedTasks(ped)

			TaskPlayAnim(ped, Anim_Dict, Anim_Loop, 8.0, 1.0, -1, 49, 0, 0, 0, 0)

			Config.Process(item , t.eating_duration)

			Citizen.Wait(t.eating_duration)
			TaskPlayAnim(ped, Anim_Dict, Anim_End, 8.0, 1.0, -1, 49, 0, 0, 0, 0)	
			ClearPedTasks(ped)
			DeleteObject(prop)

			IsEating = false

			local HaveItem = checkHasItem(item)

			if HaveItem then
				for _,status in pairs(t.status_add) do 
					TriggerEvent('alonedev_status:' .. status.type, status.status, status.percent)
				end
				TriggerServerEvent('alonedev_status:removeItem', item)
			else
				SetEntityHealth(PlayerPedId(), 0)
				Config.Noti("ใบเหลือง 1 ใบ จุ๊บ" , "warning")
			end

		end
	else
		Config.Noti("อย่าพึ่ง กำลังกินอยู่" , "warning")
	end

end)

loadAnimDict = function(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end 

function DrawGenericText(text)
	SetTextColour(186, 186, 186, 255)
	SetTextFont(fontId)
	SetTextScale(0.800, 0.800)
	SetTextWrap(0.0, 1.0)
	SetTextCentre(true)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextOutline()
	SetTextEdge(1, 0, 0, 0, 205)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(0.5, 0.07)
end

FormatCoord = function(coord)
	if coord == nil then
		return "unknown"
	end

	return tonumber(string.format("%.2f", coord))
end

if GetEntityMaxHealth(GetPlayerPed(-1)) ~= 200 then
	SetEntityMaxHealth(GetPlayerPed(-1), 200)
	SetEntityHealth(GetPlayerPed(-1), 200)
end


RegisterNetEvent('alonedev_status:CL:notifromserver')
AddEventHandler('alonedev_status:CL:notifromserver' , function(message)
	Config.Noti(message , 'error')
end)