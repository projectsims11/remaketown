local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX                  = nil
local FirstSpawn     = true
local LastSkin       = nil
local PlayerLoaded   = false
local cam            = nil
local isCameraActive = false
local zoomOffset     = 0.0
local camOffset      = 0.0
local heading        = 90.0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function OpenMenu(submitCb, cancelCb, restrict)
	local playerPed = PlayerPedId()

	TriggerEvent('skinchanger:getSkin', function(skin)
		LastSkin = skin
	end)

	TriggerEvent('skinchanger:getData', function(components, maxVals)
		local elements    = {}
		local _components = {}

		-- Restrict menu
		if restrict == nil then
			for i=1, #components, 1 do
				_components[i] = components[i]
			end
		else
			for i=1, #components, 1 do
				local found = false

				for j=1, #restrict, 1 do
					if components[i].name == restrict[j] then
						found = true
					end
				end

				if found then
					table.insert(_components, components[i])
				end
			end
		end

		-- Insert elements
		for i=1, #_components, 1 do
			local value       = _components[i].value
			local componentId = _components[i].componentId

			if componentId == 0 then
				value = GetPedPropIndex(playerPed, _components[i].componentId)
			end

			local data = {
				label     = _components[i].label,
				name      = _components[i].name,
				value     = value,
				min       = _components[i].min,
				textureof = _components[i].textureof,
				zoomOffset= _components[i].zoomOffset,
				camOffset = _components[i].camOffset,
				type      = 'slider'
			}

			for k,v in pairs(maxVals) do
				if k == _components[i].name then
					data.max = v
					break
				end
			end

			table.insert(elements, data)
		end

		TriggerEvent('openmenuskin', elements, restrict)
		-- CreateSkinCam()
		-- zoomOffset = _components[1].zoomOffset
		-- camOffset = _components[1].camOffset

		-- ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'skin', {
		-- 	title    = _U('skin_menu'),
		-- 	align    = 'top-left',
		-- 	elements = elements
		-- }, function(data, menu)
		-- 	TriggerEvent('skinchanger:getSkin', function(skin)
		-- 		LastSkin = skin
		-- 	end)
		-- 	submitCb(data, menu)
		-- 	DeleteSkinCam()
		-- end, function(data, menu)
		-- 	menu.close()
		-- 	DeleteSkinCam()
		-- 	TriggerEvent('skinchanger:loadSkin', LastSkin)

		-- 	if cancelCb ~= nil then
		-- 		cancelCb(data, menu)
		-- 	end
		-- end, function(data, menu)
		-- 	local skin, components, maxVals

		-- 	TriggerEvent('skinchanger:getSkin', function(getSkin)
		-- 		skin = getSkin
		-- 	end)

		-- 	zoomOffset = data.current.zoomOffset
		-- 	camOffset = data.current.camOffset

		-- 	if skin[data.current.name] ~= data.current.value then
		-- 		-- Change skin element

		-- 		if data.current.name == "tshirt_1" then
		-- 			TriggerEvent('skinchanger:change', "tshirt_2", 0)
					
		-- 		end

		-- 		if data.current.name == "torso_1" then
		-- 			TriggerEvent('skinchanger:change', "torso_2", 0)
					
		-- 		end

		-- 		TriggerEvent('skinchanger:change', data.current.name, data.current.value)

		-- 		-- Update max values
		-- 		TriggerEvent('skinchanger:getData', function(comp, max)
		-- 			components, maxVals = comp, max
		-- 		end)

		-- 		local newData = {}

		-- 		for i=1, #elements, 1 do
		-- 			newData = {}
		-- 			newData.max = maxVals[elements[i].name]

		-- 			if elements[i].textureof ~= nil and data.current.name == elements[i].textureof then
		-- 				newData.value = 0
		-- 			end

		-- 			menu.update({name = elements[i].name}, newData)
		-- 		end

		-- 		menu.refresh()
		-- 	end
		-- end, function(data, menu)
		-- 	DeleteSkinCam()
		-- end)
	end)
end

-- function OpenMenu(submitCb, cancelCb, restrict)
-- 	local playerPed = PlayerPedId()

-- 	TriggerEvent('skinchanger:getSkin', function(skin)
-- 		LastSkin = skin
-- 	end)

-- 	TriggerEvent('skinchanger:getData', function(components, maxVals)
-- 		local elements    = {}
-- 		local _components = {}

-- 		-- Restrict menu
-- 		if restrict == nil then
-- 			for i=1, #components, 1 do
-- 				_components[i] = components[i]
-- 			end
-- 		else
-- 			for i=1, #components, 1 do
-- 				local found = false

-- 				for j=1, #restrict, 1 do
-- 					if components[i].name == restrict[j] then
-- 						found = true
-- 					end
-- 				end

-- 				if found then
-- 					table.insert(_components, components[i])
-- 				end
-- 			end
-- 		end

-- 		-- Insert elements
-- 		for i=1, #_components, 1 do
-- 			local value       = _components[i].value
-- 			local componentId = _components[i].componentId

-- 			if componentId == 0 then
-- 				value = GetPedPropIndex(playerPed, _components[i].componentId)
-- 			end

-- 			local data = {
-- 				label     = _components[i].label,
-- 				value     = _components[i].name,
-- 				name      = _components[i].name,
-- 				min       = _components[i].min,
-- 				textureof = _components[i].textureof,
-- 				zoomOffset= _components[i].zoomOffset,
-- 				camOffset = _components[i].camOffset
-- 			}

-- 			for k,v in pairs(maxVals) do
-- 				if k == _components[i].name then
-- 					data.max = v
-- 					break
-- 				end
-- 			end

-- 			table.insert(elements, data)
-- 		end

-- 		CreateSkinCam()
-- 		zoomOffset = _components[1].zoomOffset
-- 		camOffset = _components[1].camOffset

-- 		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'skin', {
-- 			title    = _U('skin_menu'),
-- 			align    = 'top-left',
-- 			elements = elements
-- 		}, function(data, menu)

-- 			local data_label = data.current.label
-- 			local data_name = data.current.name
-- 			local data_max = data.current.max

-- 			zoomOffset = data.current.zoomOffset
-- 			camOffset = data.current.camOffset

-- 			local elements = {}
-- 			for k,v in pairs(maxVals) do
-- 				if k == data_name then
-- 					for i=1, v, 1 do
-- 						table.insert(elements, {
-- 							label = i,
-- 							name = data_name,
-- 							value = i-1
-- 						})
-- 					end
-- 					break
-- 				end
-- 			end

-- 			ESX.UI.Menu.Open('default', GetCurrentResourceName(), data_name, {
-- 				title    = data_label,
-- 				align    = 'top-left',
-- 				elements = elements
-- 			}, function(data2, menu2)

				
				
-- 			end, function(data2, menu2)
	
-- 				menu2.close()
				
-- 			end, function(data2, menu2)
-- 				TriggerEvent('skinchanger:change', data2.current.name, data2.current.value)
-- 			end)

			
-- 		end, function(data, menu)
-- 			menu.close()
-- 			DeleteSkinCam()
-- 			TriggerEvent('skinchanger:loadSkin', LastSkin)

-- 			if cancelCb ~= nil then
-- 				cancelCb(data, menu)
-- 			end
-- 		end)
-- 	end)
-- end


function DeleteSkinCam()
	isCameraActive = false
	SetCamActive(cam, false)
	RenderScriptCams(false, true, 500, true, true)
	cam = nil
end

--[[	if isCameraActive then
	_drawText2D(0.90, 1.45, 0.3, 1.0, 1.0, "~w~กด ~r~x ~w~เพื่อยกเลิก", 255, 255, 255, 255)
	if IsControlJustPressed(0, 47) then
		ESX.ShowHelpNotification(_U('use_rotate_view'))
	end
end--]]

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if isCameraActive then
			if isCameraActive then
				_drawText2D(0.95  --[[แนวนอน]], 1.38--[[แนวตั้ง]], 0.35, 1.0, 1.0, "~w~กด ~g~[G] ~w~หมุน", 255, 255, 255, 255)
				_drawText2D(0.951 --[[แนวนอน]], 1.40--[[แนวตั้ง]], 0.35, 1.0, 1.0, "~w~กด ~g~[V] ~w~ขยาย", 255, 255, 255, 255)
				--_drawText2D(0.951 --[[แนวนอน]], 1.42--[[แนวตั้ง]], 0.35, 1.0, 1.0, "~w~กุหลาบที่ปาก ญ  อยู่ที่ ~g~[หน้ากาก]", 255, 255, 255, 255)
				--_drawText2D(0.951 --[[แนวนอน]], 1.44--[[แนวตั้ง]], 0.35, 1.0, 1.0, "~w~แว่น  ช  อยู่ที่ ~g~[กระเป๋า]", 255, 255, 255, 255)
				if IsControlJustPressed(0, 47) then
					RenderScriptCams(false, true, 500, true, true)
					print("work")
				end
			end
			DisableControlAction(2, 30, true)
			DisableControlAction(2, 31, true)
			DisableControlAction(2, 32, true)
			DisableControlAction(2, 33, true)
			DisableControlAction(2, 34, true)
			DisableControlAction(2, 35, true)
			DisableControlAction(0, 25, true) -- Input Aim
			DisableControlAction(0, 24, true) -- Input Attack

			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)

			local angle = heading * math.pi / 180.0
			local theta = {
				x = math.cos(angle),
				y = math.sin(angle)
			}

			local pos = {
				x = coords.x + (zoomOffset * theta.x),
				y = coords.y + (zoomOffset * theta.y)
			}

			local angleToLook = heading - 140.0
			if angleToLook > 360 then
				angleToLook = angleToLook - 360
			elseif angleToLook < 0 then
				angleToLook = angleToLook + 360
			end

			angleToLook = angleToLook * math.pi / 180.0
			local thetaToLook = {
				x = math.cos(angleToLook),
				y = math.sin(angleToLook)
			}

			local posToLook = {
				x = coords.x + (zoomOffset * thetaToLook.x),
				y = coords.y + (zoomOffset * thetaToLook.y)
			}

			SetCamCoord(cam, pos.x, pos.y, coords.z + camOffset)
			PointCamAtCoord(cam, posToLook.x, posToLook.y, coords.z + camOffset)

		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	local angle = 90

	while true do
		Citizen.Wait(0)

		if isCameraActive then
			if IsControlPressed(0, Keys['N4']) then
				angle = angle - 1
			elseif IsControlPressed(0, 109) then
				angle = angle + 1
			end

			if angle > 360 then
				angle = angle - 360
			elseif angle < 0 then
				angle = angle + 360
			end

			heading = angle + 0.0
		else
			Citizen.Wait(500)
		end
	end
end)

function OpenSaveableMenu(submitCb, cancelCb, restrict) --------------------------------------------------------------------------
	TriggerEvent('skinchanger:getSkin', function(skin)
		LastSkin = skin
	end)

	OpenMenu(function(data, menu)
		menu.close()
		DeleteSkinCam()
		TriggerEvent('skinchanger:getSkin', function(skin)
			TriggerServerEvent('esx_skin:save', skin)

			if submitCb ~= nil then
				submitCb(data, menu)
			end
		end)

	end, cancelCb, restrict)
end

AddEventHandler('playerSpawned', function()
	Citizen.CreateThread(function()
		while not PlayerLoaded do
			Citizen.Wait(10)
		end

		if FirstSpawn then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin == nil then
					TriggerEvent('skinchanger:loadSkin', {sex = 0})
				else
					TriggerEvent('skinchanger:loadSkin', skin)
					TriggerEvent('esx_tattooshop:loadTattoos')
				end
			end)

			FirstSpawn = false
		end
	end)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerLoaded = true
end)

AddEventHandler('esx_skin:getLastSkin', function(cb)
	cb(LastSkin)
end)

AddEventHandler('esx_skin:setLastSkin', function(skin)
	LastSkin = skin
end)

RegisterNetEvent('esx_skin:openMenu')
AddEventHandler('esx_skin:openMenu', function(submitCb, cancelCb)
	OpenMenu(submitCb, cancelCb, nil)
end)

RegisterNetEvent('esx_skin:openRestrictedMenu')
AddEventHandler('esx_skin:openRestrictedMenu', function(submitCb, cancelCb, restrict)
	OpenMenu(submitCb, cancelCb, restrict)
end)

RegisterNetEvent('esx_skin:openSaveableMenu')
AddEventHandler('esx_skin:openSaveableMenu', function(submitCb, cancelCb)
	OpenSaveableMenu(submitCb, cancelCb, nil)
end)

RegisterNetEvent('esx_skin:openSaveableRestrictedMenu')
AddEventHandler('esx_skin:openSaveableRestrictedMenu', function(submitCb, cancelCb, restrict)
	OpenSaveableMenu(submitCb, cancelCb, restrict)
end)

RegisterNetEvent('esx_skin:requestSaveSkin')
AddEventHandler('esx_skin:requestSaveSkin', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
		TriggerServerEvent('esx_skin:responseSaveSkin', skin)
	end)
end)

_drawText2D = function(x, y, scale, width, height, text, r, g, b, a, outline)
    SetTextFont(fontId)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(0, 0, 0, 0, 255)
    SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(1)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2.3, y - height/2 + 0.005)
end

RegisterFontFile('font4thai')
fontId = RegisterFontId('font4thai')