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

ESX								= nil
local HasAlreadyEnteredMarker	= false
local LastZone					= nil
local CurrentAction				= nil
local CurrentActionMsg			= ''
local CurrentActionData			= {}
local isDead					= false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function OpenAccessoryMenu()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'set_unset_accessory',
	{
		title = _U('set_unset'),
		align = 'top-left',
		elements = {
			{label = _U('helmet'), value = 'Helmet'},
			{label = _U('ears'), value = 'Ears'},
			{label = _U('mask'), value = 'Mask'},
			{label = _U('glasses'), value = 'Glasses'}
		}
	}, function(data, menu)
		menu.close()
		SetUnsetAccessory(data.current.value)

	end, function(data, menu)
		menu.close()
	end)
end

function SetUnsetAccessory(accessory)
	ESX.TriggerServerCallback('esx_accessories:get', function(hasAccessory, accessorySkin)
		local _accessory = string.lower(accessory)

		if hasAccessory then
			TriggerEvent('skinchanger:getSkin', function(skin)
				local mAccessory = -1
				local mColor = 0

				if _accessory == "mask" then
					mAccessory = 0
				end

				if skin[_accessory .. '_1'] == mAccessory then
					mAccessory = accessorySkin[_accessory .. '_1']
					mColor = accessorySkin[_accessory .. '_2']
				end

				local accessorySkin = {}
				accessorySkin[_accessory .. '_1'] = mAccessory
				accessorySkin[_accessory .. '_2'] = mColor
				TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
			end)
		else
			ESX.ShowNotification(_U('no_' .. _accessory))
		end

	end, accessory)
end

function OpenShopMenu(accessory)
	local _accessory = string.lower(accessory)
	local restrict = {}

	restrict = { _accessory .. '_1', _accessory .. '_2' }
	
	TriggerEvent('esx_skin:openRestrictedMenu', function(data, menu)

		menu.close()

		local hasEnoughMoney = exports["Fewthz_Check"]:Money()
			if hasEnoughMoney > Config.Price then

				local String_accessory

				if _accessory == 'helmet' then
					String_accessory = "หมวก"
				elseif _accessory == 'glasses' then
					String_accessory = "แว่นตา"
				elseif _accessory == 'ears' then
					String_accessory = "ตุ้มหู"
				elseif _accessory == 'mask' then
					String_accessory = "หน้ากาก"
				end

				TriggerEvent('skinchanger:getSkin', function(skin)
					ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'outfit_name_acessory', {
						title = "ใส่ชื่อ"..String_accessory..'(4-30 ตัวอักษร) ราคา $' .. Config.Price
					}, function(data3, menu3)

						if data3.value == nil then
							TriggerEvent("pNotify:SendNotification", {
								text = '<strong class="red-text">กรุณาใส่ชื่อชุดของคุณด้วย</strong>',
								type = "success",
								timeout = 3000,
								layout = "bottomCenter",
								queue = "global"
							})
						else
							if utf8.len(data3.value) >= 30 then
								TriggerEvent("pNotify:SendNotification", {
									text = '<strong class="red-text">ชื่อชุดของคุณยาวเกินไป</strong>',
									type = "success",
									timeout = 3000,
									layout = "bottomCenter",
									queue = "global"
								})
							elseif utf8.len(data3.value) < 4 then
								TriggerEvent("pNotify:SendNotification", {
									text = '<strong class="red-text">ชื่อชุดของคุณสั้นเกินไป</strong>',
									type = "success",
									timeout = 3000,
									layout = "bottomCenter",
									queue = "global"
								})	
							else
								TriggerEvent('skinchanger:getSkin', function(skin)
									TriggerServerEvent('esx_accessories:saveOutfit', data3.value, skin, _accessory)
								end)
								menu3.close()
							end
							
						end

					end, function(data3, menu3)
						menu3.close()
					end)
				end)
			else

				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
					TriggerEvent('skinchanger:loadSkin', skin)
				end)
				
				TriggerEvent("pNotify:SendNotification", {
					text = '<strong class="red-text">คุณมีเงินไม่เพียงพอ</strong>',
					type = "success",
					timeout = 3000,
					layout = "bottomCenter",
					queue = "global"
				})

				local player = PlayerPedId()
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
					TriggerEvent('skinchanger:loadSkin', skin)
				end)

				CurrentAction     = 'shop_menu'
			CurrentActionMsg  = _U('press_access')
			CurrentActionData = {}

			end
	end, function(data, menu)
		menu.close()
		CurrentAction     = 'shop_menu'
		CurrentActionMsg  = _U('press_access')
		CurrentActionData = {}
	end, restrict)
end

RegisterNetEvent('esx_accessories:loadefaultskin')
AddEventHandler('esx_accessories:loadefaultskin', function()
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
	end)
end)

AddEventHandler('playerSpawned', function()
	isDead = false
end)

AddEventHandler('esx:onPlayerDeath', function()
	isDead = true
end)

AddEventHandler('esx_accessories:hasEnteredMarker', function(zone)
	CurrentAction     = 'shop_menu'
	CurrentActionMsg  = _U('press_access')
	CurrentActionData = { accessory = zone }
end)

AddEventHandler('esx_accessories:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
	end)
end)

-- Create Blips --
CreateThread(function()
	for k,v in pairs(Config.ShopsBlips) do
		if v.Pos then
			for i=1, #v.Pos, 1 do
				local blip = AddBlipForCoord(v.Pos[i])

				SetBlipSprite (blip, v.Blip.sprite)
				SetBlipDisplay(blip, 4)
				SetBlipScale  (blip, 0.7)
				SetBlipColour (blip, v.Blip.color)
				SetBlipAsShortRange(blip, true)

				BeginTextCommandSetBlipName("STRING")
				AddTextComponentSubstringPlayerName(_U('shop', _U(string.lower(k))))
				EndTextCommandSetBlipName(blip)
			end
		end
	end
end)


local nearMarker = false
-- Display markers
CreateThread(function()
	while true do
		local sleep = 1500
		local coords = GetEntityCoords(PlayerPedId())
		for k,v in pairs(Config.Zones) do
			for i = 1, #v.Pos, 1 do
				if(Config.Type ~= -1 and #(coords - v.Pos[i]) < Config.DrawDistance) then
					DrawMarker(Config.Type, v.Pos[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 255, true, false, 2, true, false, false, false)
					sleep = 0
					break
				end
			end
		end
		if sleep == 0 then nearMarker = true else nearMarker = false end
		Wait(sleep)
	end
end)

CreateThread(function()
	while true do
		local sleep = 1500
		if nearMarker then
			sleep = 0
			local coords = GetEntityCoords(PlayerPedId())
			local isInMarker = false
			local currentZone = nil
			for k,v in pairs(Config.Zones) do
				for i = 1, #v.Pos, 1 do
					if #(coords - v.Pos[i]) < Config.Size.x then
						isInMarker  = true
						currentZone = k
						break
					end
				end
			end

			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker = true
				LastZone = currentZone
				TriggerEvent('esx_accessories:hasEnteredMarker', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_accessories:hasExitedMarker', LastZone)
			end
		end
		Wait(sleep)
	end
end)

-- Key controls
CreateThread(function()
	while true do
		local Sleep = 1500
		
		if CurrentAction then
			Sleep = 0
			exports["Fewthz_TextUI"]:ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) and CurrentActionData.accessory then
				OpenShopMenu(CurrentActionData.accessory)
				CurrentAction = nil
			end
		end
		Wait(Sleep)
	end
end)

if Config.EnableControls then
	RegisterCommand("accessory", function(src)
		if not ESX.PlayerData.dead then
			OpenAccessoryMenu()
		end
	end)

	RegisterKeyMapping("accessory", "Open Accessory Menu", "keyboard", "k")
end