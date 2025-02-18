local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,["~"] = 243, 
    ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, 
    ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,["HOME"] = 213, 
    ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, 
    ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

isInInventory       = false
ESX                 = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent("esx:getSharedObject",function(obj)ESX = obj end)
        Citizen.Wait(0)
    end
    SetNuiFocus(false,false)
end)

AddEventHandler('esx:onPlayerDeath', function(data)
    closeInventory()
end)

RegisterKeyMapping("openBags", "open Self Inventory", "keyboard", Config["Open"])

RegisterCommand("openBags", function()
	Wait(150)
	if not IsPlayerDead(PlayerId()) then
        if not isInInventory then
    		openInventory()
            isInInventory = true
		end
	end
end, false)

function closeInventory()
    isInInventory = false
    SendNUIMessage({
        action = "hide"
    })

    SetNuiFocus(false, false)
    TriggerScreenblurFadeOut(0)
end

RegisterNUICallback("NUIFocusOff",function()
    closeInventory()
end)

RegisterNUICallback("GetNearPlayers",function(data, cb)
    SendNUIMessage({
        action = "nearPlayers",
        player = data.player,
        item = data.item
    })
end)

RegisterNUICallback("UseItem",function(data, cb)
	if data.item.type == "item_key" then
		TriggerEvent("Fewthz_remote:useKey", data.item.label)
		closeInventory()
	elseif data.item.name == 'id_card' then
		TriggerEvent('jsfour-idcard:id_card', source)
		closeInventory()	
	elseif data.item.name == 'driver_license' then
		TriggerEvent('jsfour-idcard:dv_license', source)
		closeInventory()	
	elseif data.item.type == "item_accessories" then
		local player = GetPlayerPed(-1)
		closeInventory()
		if data.item.name == "helmet" then
			TriggerEvent("skinchanger:getSkin", function(skin)
				if skin["helmet_1"] == -1 then
					if IsPedInAnyVehicle(PlayerPedId(), true) == false then
						local dict = "veh@bicycle@roadfront@base"
						local anim = "put_on_helmet"
						RequestAnimDict(dict)
						while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
						TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
						Citizen.Wait(1000)
					end
					local accessorySkin = {}
					accessorySkin["helmet_1"] = data.item.itemnum
					accessorySkin["helmet_2"] = data.item.itemskin
					TriggerEvent("skinchanger:loadClothes", skin, accessorySkin)
				else
					if IsPedInAnyVehicle(PlayerPedId(), true) == false then
						local dict = "veh@bike@common@front@base"
						local anim = "take_off_helmet_walk"
						RequestAnimDict(dict)
						while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
						TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
						Citizen.Wait(800)
					end
					local accessorySkin = {}
					accessorySkin["helmet_1"] = -1
					accessorySkin["helmet_2"] = 0
					TriggerEvent("skinchanger:loadClothes", skin, accessorySkin)
				end
			end)
	elseif data.item.name == "mask" then
		TriggerEvent("skinchanger:getSkin", function(skin)
			if skin["mask_1"] == -1 then
				if IsPedInAnyVehicle(PlayerPedId(), true) == false then
					local dict = "veh@bicycle@roadfront@base"
					local anim = "put_on_helmet"
					RequestAnimDict(dict)
					while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
					TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
					Citizen.Wait(1000)
				end
				local accessorySkin = {}
				accessorySkin["mask_1"] = data.item.itemnum
				accessorySkin["mask_2"] = data.item.itemskin
				TriggerEvent("skinchanger:loadClothes", skin, accessorySkin)
			else
				if IsPedInAnyVehicle(PlayerPedId(), true) == false then
					local dict = "veh@bike@common@front@base"
					local anim = "take_off_helmet_walk"
					RequestAnimDict(dict)
					while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
					TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
					Citizen.Wait(800)
				end
				local accessorySkin = {}
				accessorySkin["mask_1"] = -1
				accessorySkin["mask_2"] = 0
				TriggerEvent("skinchanger:loadClothes", skin, accessorySkin)
			end
		end)
	elseif data.item.name == "glasses" then
		TriggerEvent("skinchanger:getSkin", function(skin)
			if skin["glasses_1"] == -1 then
				if IsPedInAnyVehicle(PlayerPedId(), true) == false then
					local dict = "clothingspecs"
					local anim = "try_glasses_positive_a"
					RequestAnimDict(dict)
					while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
					TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
					Citizen.Wait(800)
				end
					local accessorySkin = {}
					accessorySkin["glasses_1"] = data.item.itemnum
					accessorySkin["glasses_2"] = data.item.itemskin
					TriggerEvent("skinchanger:loadClothes", skin, accessorySkin)
					ClearPedTasks(player)
			else
				if IsPedInAnyVehicle(PlayerPedId(), true) == false then
					local dict = "clothingspecs"
					local anim = "take_off"
					RequestAnimDict(dict)
					while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
					TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
					Citizen.Wait(1000)
				end
				local accessorySkin = {}
				accessorySkin["glasses_1"] = -1
				accessorySkin["glasses_2"] = 0
				TriggerEvent("skinchanger:loadClothes", skin, accessorySkin)
			end
		end)
	elseif data.item.name == "earring" then
		TriggerEvent("skinchanger:getSkin", function(skin)
			if skin["ears_1"] == -1 then
				if IsPedInAnyVehicle(PlayerPedId(), true) == false then
					local dict = "mini@ears_defenders"
					local anim = "takeoff_earsdefenders_idle"
					RequestAnimDict(dict)
					while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
					TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
					Citizen.Wait(800)
				end
				local accessorySkin = {}
				accessorySkin["ears_1"] = data.item.itemnum
				accessorySkin["ears_2"] = data.item.itemskin
				TriggerEvent("skinchanger:loadClothes", skin, accessorySkin)
			else
				if IsPedInAnyVehicle(PlayerPedId(), true) == false then
					local dict = "mini@ears_defenders"
					local anim = "takeoff_earsdefenders_idle"
					RequestAnimDict(dict)
					while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
					TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
					Citizen.Wait(800)
				end
				local accessorySkin = {}
				accessorySkin["ears_1"] = -1
				accessorySkin["ears_2"] = 0
				TriggerEvent("skinchanger:loadClothes", skin, accessorySkin)
			end
		end)
	elseif data.item.name == "watches" then
		TriggerEvent("skinchanger:getSkin", function(skin)
			if skin["watches_1"] == -1 then
				if IsPedInAnyVehicle(PlayerPedId(), true) == false then
					local dict = "missmic4"
					local anim = "michael_tux_fidget"
					RequestAnimDict(dict)
					while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
					TaskPlayAnim(player, dict, anim, 8.0, 5.0, -1, 48, 2, 0.5, 0, 0 )
					Citizen.Wait(3000)
					ClearPedTasks(player)
				end
				local accessorySkin = {}
				accessorySkin["watches_1"] = data.item.itemnum
				accessorySkin["watches_2"] = data.item.itemskin
				TriggerEvent("skinchanger:loadClothes", skin, accessorySkin)
			else
				if IsPedInAnyVehicle(PlayerPedId(), true) == false then
					local dict = "missmic4"
					local anim = "michael_tux_fidget"
					RequestAnimDict(dict)
					while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
					TaskPlayAnim(player, dict, anim, 8.0, 5.0, -1, 48, 2, 0.5, 0, 0 )
					Citizen.Wait(3000)
					ClearPedTasks(player)
				end
				local accessorySkin = {}
				accessorySkin["watches_1"] = -1
				accessorySkin["watches_2"] = 0
				TriggerEvent("skinchanger:loadClothes", skin, accessorySkin)
			end
		end)
	elseif data.item.name == "bproof" then
		TriggerEvent("skinchanger:getSkin", function(skin)
			if skin["bproof_1"] == -1 then
				if IsPedInAnyVehicle(PlayerPedId(), true) == false then
					local dict = "amb@code_human_police_investigate@idle_a"
					local anim = "idle_b"
					RequestAnimDict(dict)
					while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
					TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0.5, 0, 0 )
					Citizen.Wait(1500)
					ClearPedTasks(player)
				end
				local accessorySkin = {}
				accessorySkin["bproof_1"] = data.item.itemnum
				accessorySkin["bproof_2"] = data.item.itemskin
				TriggerEvent("skinchanger:loadClothes", skin, accessorySkin)
			else
				if IsPedInAnyVehicle(PlayerPedId(), true) == false then
					local dict = "amb@code_human_police_investigate@idle_a"
					local anim = "idle_b"
					RequestAnimDict(dict)
					while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
					TaskPlayAnim(player, dict, anim, 8.0, 5.0, -1, 48, 2, 0.5, 0, 0 )
					Citizen.Wait(1500)
					ClearPedTasks(player)
				end
				local accessorySkin = {}
				accessorySkin["bproof_1"] = -1
				accessorySkin["bproof_2"] = 0
				TriggerEvent("skinchanger:loadClothes", skin, accessorySkin)
			end
		end)
	elseif data.item.name == "torso" then
		TriggerEvent("skinchanger:getSkin", function(skin)
			if skin["torso_1"] == 15 then
				if IsPedInAnyVehicle(PlayerPedId(), true) == false then
					local dict = "mp_safehouseshower@male@"
					local anim = "male_shower_towel_dry_to_get_dressed"
					RequestAnimDict(dict)
					while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
					TaskPlayAnim(player, dict, anim, 8.0, 5.0, -1, 0, 0.6, 0, 0 )
					Citizen.Wait(1100)
					ClearPedTasks(player)
				end
				local accessorySkin = {}
				accessorySkin["torso_1"] = data.item.itemnum
				accessorySkin["torso_2"] = data.item.itemskin
				accessorySkin["arms"] = data.item.itemarms
				accessorySkin["arms2"] = data.item.itemarms2
				accessorySkin["tshirt_1"] = data.item.itemtshirt
				accessorySkin["tshirt_2"] = data.item.itemtshirt2
				TriggerEvent("skinchanger:loadClothes", skin, accessorySkin)
			else
				if IsPedInAnyVehicle(PlayerPedId(), true) == false then
					local dict = "mp_safehouseshower@male@"
					local anim = "male_shower_undress_&_turn_on_water"
					RequestAnimDict(dict)
					while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
					TaskPlayAnim(player, dict, anim, 9.0, 1.0, -1, 0, 0.3, 0, 0 )
					Citizen.Wait(700)
					ClearPedTasks(player)
				end
				local accessorySkin = {}
				accessorySkin["torso_1"] = 15
				accessorySkin["torso_2"] = 0
				accessorySkin["arms"] = 15
				accessorySkin["arms_2"] = 0
				accessorySkin["tshirt_1"] = 15
				accessorySkin["tshirt_2"] = 0
				TriggerEvent("skinchanger:loadClothes", skin, accessorySkin)
			end
		end)
	elseif data.item.name == "pants" then
		TriggerEvent("skinchanger:getSkin", function(skin)
			if skin["pants_1"] == 21 then
				if IsPedInAnyVehicle(PlayerPedId(), true) == false then
					local dict = "mp_safehouseshower@male@"
					local anim = "male_shower_towel_dry_to_get_dressed"
					RequestAnimDict(dict)
					while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
					TaskPlayAnim(player, dict, anim, 8.0, 1.0, -1, 0, 0.5, 0, 0 )
					Citizen.Wait(1500)
					ClearPedTasks(player)
				end
				local accessorySkin = {}
				accessorySkin["pants_1"] = data.item.itemnum
				accessorySkin["pants_2"] = data.item.itemskin
				TriggerEvent("skinchanger:loadClothes", skin, accessorySkin)
			else
				if IsPedInAnyVehicle(PlayerPedId(), true) == false then
					local dict = "mp_safehouseshower@male@"
					local anim = "male_shower_undress_&_turn_on_water"
					RequestAnimDict(dict)
					while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
					TaskPlayAnim(player, dict, anim, 8.0, 1.0, -1, 0, 0.35, 0, 0 )
					Citizen.Wait(2000)
					ClearPedTasks(player)
				end
				local accessorySkin = {}
				accessorySkin["pants_1"] = 21
				accessorySkin["pants_2"] = 0
				TriggerEvent("skinchanger:loadClothes", skin, accessorySkin)
			end
		end)
	elseif data.item.name == "shoes" then
		TriggerEvent("skinchanger:getSkin", function(skin)
			if skin["shoes_1"] == 34 then
				if IsPedInAnyVehicle(PlayerPedId(), true) == false then
					local dict = "mp_safehouseshower@male@"
					local anim = "male_shower_undress_&_turn_on_water"
					RequestAnimDict(dict)
					while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
					TaskPlayAnim(player, dict, anim, 8.0, 1.0, -1, 0, 0.5, 0, 0 )
					Citizen.Wait(1000)
					ClearPedTasks(player)
				end
				local accessorySkin = {}
				accessorySkin["shoes_1"] = data.item.itemnum
				accessorySkin["shoes_2"] = data.item.itemskin
				TriggerEvent("skinchanger:loadClothes", skin, accessorySkin)
				ClearPedTasks(player)
			else
				if IsPedInAnyVehicle(PlayerPedId(), true) == false then
					local dict = "mp_safehouseshower@male@"
					local anim = "male_shower_undress_&_turn_on_water"
					RequestAnimDict(dict)
					while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
					TaskPlayAnim(player, dict, anim, 8.0, 1.0, -1, 0, 0.5, 0, 0 )
					Citizen.Wait(1000)
					ClearPedTasks(player)
				end
				local accessorySkin = {}
				accessorySkin["shoes_1"] = 34
				accessorySkin["shoes_2"] = 0
				TriggerEvent("skinchanger:loadClothes", skin, accessorySkin)
			end
		end)
	elseif data.item.name == "chain" then
		TriggerEvent("skinchanger:getSkin", function(skin)
			if skin["chain_1"] == -1 then
				if IsPedInAnyVehicle(PlayerPedId(), true) == false then
					local dict = "clothingtie"
					local anim = "try_tie_positive_a"
					RequestAnimDict(dict)
					while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
					TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 0.2, 0.2, 0, 0 )
					Citizen.Wait(1700)
				end
				local accessorySkin = {}
				accessorySkin["chain_1"] = data.item.itemnum
				accessorySkin["chain_2"] = data.item.itemskin
				TriggerEvent("skinchanger:loadClothes", skin, accessorySkin)
			else
				if IsPedInAnyVehicle(PlayerPedId(), true) == false then
					local dict = "clothingtie"
					local anim = "try_tie_positive_a"
					RequestAnimDict(dict)
					while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
					TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 0.2, 0.2, 0, 0 )
					Citizen.Wait(1700)
				end
				local accessorySkin = {}
				accessorySkin["chain_1"] = -1
				accessorySkin["chain_2"] = 0
				TriggerEvent("skinchanger:loadClothes", skin, accessorySkin)
			end
		end)
		end
	else
		TriggerServerEvent("esx:useItem", data.item.name)
	end
	if ItemCloseInventory(data.item.name) then
		closeInventory()
	else
		Citizen.Wait(250)
		loadPlayerInventoryFix()
	end
	cb("ok")
end)

RegisterNUICallback("DropItem",function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end
		
		if Config['disableDrop'] and Config['disableDrop'][data.item.name] then
			closeInventory()
			exports.pNotify:SendNotification(
				{
					text = "ไม่สามารถทิ้ง ITEM ชินนี้ได้",
					type = "error",
					timeout = 3000,
					layout = "topRight",
					queue = "inventoryhud"
				})
			return
		end
		
		
		if data.item.type == "item_weapon" then
			closeInventory()
			exports.pNotify:SendNotification(
				{
					text = "ไม่สามารถทิ้ง Weapon ชิ้นนี้ได้",
					type = "error",
					timeout = 3000,
					layout = "topRight",
					queue = "inventoryhud"
				}
			)
			return
		end
		
		-- RequestAnimDict("amb@medic@standing@kneel@base")
		-- TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base", "base", 8.0, -8.0, -1, 1, 0, false, false, false)
		
		local lPed = GetPlayerPed(-1)

        if type(data.number) == "number" and math.floor(data.number) == data.number then
			if not IsPedInAnyVehicle(lPed, false) and not IsPedSwimming(lPed) and not IsPedShooting(lPed) and not IsPedClimbing(lPed) and not IsPedDiving(lPed) and not IsPedFalling(lPed) and not IsPedJumping(lPed) and not IsPedJumpingOutOfVehicle(lPed) and IsPedOnFoot(lPed) and not IsPedRunning(lPed) and not IsPedUsingAnyScenario(lPed) and not IsPedInParachuteFreeFall(lPed) then
				TriggerEvent("Fewthz_inventory:closeInventory")
				
				ESX.UI.Menu.CloseAll()

				ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'Drop_Menu',
				{
				  title    = 'คุณต้องการทิ้ง ['..data.item.label..' x'..data.number..'] , หรือไม่?',
				  align    = 'top-left',
				  elements = {
					{label = ('Yes'), value = 'yes', itemlabel = data.item.label, itemtype = data.item.type, itemname = data.item.name, itemnumber = data.number},
					{label = ('No'), value = 'no'}
				  }
				},
				
				function(datamenu, menu)
				  if datamenu.current.value == 'yes' then
					menu.close()
					ClearPedTasks(PlayerPedId())
					Citizen.CreateThread(function()
						exports.pNotify:SendNotification(
							{
								text = 'You left ['..datamenu.current.itemlabel..' x'..datamenu.current.itemnumber..'] Wait 3 minutes',
								type = "error",
								timeout = 500,
								layout = "topRight",
								queue = "inventoryhud"
							}
						)
						Wait(500)
						if string.find(data.item.type, "car_key_") then
							local plate = string.gsub(data.item.type, "car_key_", "")
							TriggerServerEvent("scotty:dropKey", string.upper(plate))
						elseif data.item.type == "item_accessories" then
							TriggerServerEvent("Fewthz_inventory:deleteOutfit", data.item.label, data.item.name, 1)
							closeInventory()
						else
							TriggerServerEvent("esx:removeInventoryItem", datamenu.current.itemtype, datamenu.current.itemname, datamenu.current.itemnumber)
						end
					end)
				  elseif datamenu.current.value == 'no' then
					menu.close()
					ClearPedTasks(PlayerPedId())
				  end

				end,
				function(data, menu)
				  menu.close()
				  ClearPedTasks(PlayerPedId())
				end)
			end
        end

        Wait(250)
        loadPlayerInventoryFix()

        cb("ok")
    end
)

RegisterNUICallback("GiveItem",function(data, cb)
        local playerTemp
        local playerPed = PlayerPedId()
        local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 3.0)
        local foundPlayer = false
        for i = 1, #players, 1 do
            if players[i] ~= PlayerId() then
                if GetPlayerServerId(players[i]) == data.player then
                    foundPlayer = true
                end
            end
        end

		if Config['disableGive'] and Config['disableGive'][data.item.name] then
			exports.pNotify:SendNotification(
				{
					text = "This item cannot be given.",
					type = "error",
					timeout = 3000,
					layout = "topRight",
					queue = "inventoryhud"
				})
			return
		end
		
		if data.item.type == "item_weapon" then
			exports.pNotify:SendNotification(
				{
					text = "Cannot give this weapon.",
					type = "error",
					timeout = 3000,
					layout = "topRight",
					queue = "inventoryhud"
				}
			)
			return
		end

        if foundPlayer then
            local count = tonumber(data.number)
			
			if data.item.type == "item_weapon" then
                count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
            end
        
			local lPed = GetPlayerPed(-1)				
			if not IsPedInAnyVehicle(lPed, false) and IsPedOnFoot(lPed) and not IsPedUsingAnyScenario(lPed) then               
				
				if data.item.type == "item_key" then
					if Config["ItemTradeCarkey"] then
						if checkHasItem(Config["ItemTransferCar"]) then
							TriggerServerEvent('Fewthz_inventory:removeitemtradekey', Config["ItemTransferCar"])
							TriggerServerEvent("Fewthz_inventory:updateKey", data.player, data.item.type, data.item.real)
						else
							exports["pNotify"]:SendNotification({
									text = '<strong class="red-text">ไม่สามารถเทรดกุญแจถ้าไม่มีใบโอนรถ</strong>',
									type = "error",
									timeout = 3000,
									layout = "bottomCenter",
									queue = "inventoryhud"
								}
							)
						end
					else
						TriggerServerEvent("Fewthz_inventory:updateKey", data.player, data.item.type, data.item.real)
					end
						Wait(500)
						closeInventory()
					return
					elseif data.item.type == "item_keyhouse" then
						TriggerServerEvent("Fewthz_inventory:updateKey", data.player, data.item.type, data.item.house_id)
					elseif data.item.type == "item_accessories" then
						TriggerServerEvent("Fewthz_inventory:updateOutfit", data.player, data.item.name, data.item.label)
					else
						TriggerEvent('xzero_giveui:client:On_GiveItem', data)
						TriggerServerEvent("esx:giveInventoryItem", data.player, data.item.type, data.item.name, count)
					end
					closeInventory()
					Wait(250)
					loadPlayerInventoryFix()	
			end			
        else
            exports.pNotify:SendNotification(
                {
                    text = '<strong class="red-text">ผู้เล่นอยู่ไกลเกินไป</strong>',
                    type = "error",
                    timeout = 3000,
                    layout = "bottomCenter",
                    queue = "inventoryhud"
                }
            )
        end
    cb("ok")
end)



RegisterNUICallback("UseMask",function(data, cb)
    if data.item.type == "item_accessories" then
        local player = GetPlayerPed(-1)

        closeInventory()
       
        if data.item.name == "helmet" then
            TriggerEvent('skinchanger:getSkin', function(skin)
                if skin["helmet_1"] == -1 then

                    local dict = "veh@bicycle@roadfront@base"
                    local anim = "put_on_helmet"
        
                    RequestAnimDict(dict)
                    while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
                    
                    TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
        
                    Wait(1000)

                    local accessorySkin = {}
                    accessorySkin['helmet_1'] = data.item.itemnum
                    accessorySkin['helmet_2'] = data.item.itemskin

                    TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
                else

                     if IsPedInAnyVehicle(PlayerPedId(), true) == false then
                        local dict = "veh@bike@common@front@base"
                        local anim = "take_off_helmet_walk"

                        RequestAnimDict(dict)
                        while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
                        
                        TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
            
                        Wait(800)
                    end

                    local accessorySkin = {}
                    accessorySkin['helmet_1'] = -1
                    accessorySkin['helmet_2'] = 0
                    TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
                end
                
            end)
        elseif data.item.name == "mask" then
            TriggerEvent('skinchanger:getSkin', function(skin)
                if skin["mask_1"] == -1 then

                    local dict = "veh@bicycle@roadfront@base"
                    local anim = "put_on_helmet"
        
                    RequestAnimDict(dict)
                    while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
                    
                    TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
        
                    Wait(1000)

                    local accessorySkin = {}
                    accessorySkin['mask_1'] = data.item.itemnum
                    accessorySkin['mask_2'] = data.item.itemskin
                    TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
                else

                    if IsPedInAnyVehicle(PlayerPedId(), true) == false then
                        local dict = "veh@bike@common@front@base"
                        local anim = "take_off_helmet_walk"

                        RequestAnimDict(dict)
                        while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
                        
                        TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
            
                        Wait(800)
                    end

                    local accessorySkin = {}
                    accessorySkin['mask_1'] = -1
                    accessorySkin['mask_2'] = 0
                    TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
                end
                
            end)
        elseif data.item.name == "glasses" then
            TriggerEvent('skinchanger:getSkin', function(skin)
                if skin["glasses_1"] == -1 then

                    if IsPedInAnyVehicle(PlayerPedId(), true) == false then
                        local dict = "clothingspecs"
                        local anim = "try_glasses_positive_a"
            
                        RequestAnimDict(dict)
                        while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
                        
                        TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
            
                        Wait(800)
                    end

                    local accessorySkin = {}
                    accessorySkin['glasses_1'] = data.item.itemnum
                    accessorySkin['glasses_2'] = data.item.itemskin
                    TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)

                    ClearPedTasks(player)
                else

                    if IsPedInAnyVehicle(PlayerPedId(), true) == false then
                        local dict = "clothingspecs"
                        local anim = "take_off"
            
                        RequestAnimDict(dict)
                        while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
                        
                        TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
            
                        Wait(1000)
                    end

                    local accessorySkin = {}
                    accessorySkin['glasses_1'] = -1
                    accessorySkin['glasses_2'] = 0
                    TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
                end
                
            end)
        elseif data.item.name == "earring" then
            TriggerEvent('skinchanger:getSkin', function(skin)
                if skin["ears_1"] == -1 then

                    if IsPedInAnyVehicle(PlayerPedId(), true) == false then
                        local dict = "mini@ears_defenders"
                        local anim = "takeoff_earsdefenders_idle"
            
                        RequestAnimDict(dict)
                        while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
                        
                        TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
            
                        Wait(800)
                    end

                    local accessorySkin = {}
                    accessorySkin['ears_1'] = data.item.itemnum
                    accessorySkin['ears_2'] = data.item.itemskin
                    TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
                else

                    if IsPedInAnyVehicle(PlayerPedId(), true) == false then
                        local dict = "mini@ears_defenders"
                        local anim = "takeoff_earsdefenders_idle"
            
                        RequestAnimDict(dict)
                        while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
                        
                        TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
            
                        Wait(800)
                    end

                    local accessorySkin = {}
                    accessorySkin['ears_1'] = -1
                    accessorySkin['ears_2'] = 0
                    TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
                end 
            end)
        end
    end
end)

function shouldSkipAccount(accountName)
    for index, value in ipairs(Config["ExcludeAccountsList"]) do
        if value == accountName then
            return true
        end
    end
    return false
end

RegisterNetEvent("Fewthz_inventory:closeHud")
AddEventHandler("Fewthz_inventory:closeHud",function()
    closeInventory()
end)

AddEventHandler("Fewthz_inventory:closeInventory", function()
    closeInventory()
end) 

RegisterCommand(Config["Command"], function()
    TriggerEvent('Fewthz_inventory:closeInventory')
    exports.pNotify:SendNotification(
        {
            text = "You Close Inventory!!!!!",
            type = "success",
            timeout = 3000,
            layout = "bottomCenter"
        }
    )
end)

Citizen.CreateThread(function()
    while isInInventory do
        Citizen.Wait(1000)
		local playerPed = PlayerPedId()
		DisableControlAction(0, 1, true) -- Disable pan
		DisableControlAction(0, 2, true) -- Disable tilt
		DisableControlAction(0, 24, true) -- Attack
		DisableControlAction(0, 257, true) -- Attack 2
		DisableControlAction(0, 25, true) -- Aim
		DisableControlAction(0, 263, true) -- Melee Attack 1
		DisableControlAction(0, Keys["W"], true) -- W
		DisableControlAction(0, Keys["A"], true) -- A
		DisableControlAction(0, 31, true) -- S (fault in Keys table!)
		DisableControlAction(0, 30, true) -- D (fault in Keys table!)
		DisableControlAction(0, Keys["R"], true) -- Reload
		DisableControlAction(0, Keys["SPACE"], true) -- Jump
		DisableControlAction(0, Keys["Q"], true) -- Cover
		DisableControlAction(0, Keys["TAB"], true) -- Select Weapon
		DisableControlAction(0, Keys["F"], true) -- Also 'enter'?
		DisableControlAction(0, Keys["F1"], true) -- Disable phone
		DisableControlAction(0, Keys["F2"], true) -- Inventory
		DisableControlAction(0, Keys["F3"], true) -- Animations
		DisableControlAction(0, Keys["F6"], true) -- Job
		DisableControlAction(0, Keys["V"], true) -- Disable changing view
		DisableControlAction(0, Keys["C"], true) -- Disable looking behind
		DisableControlAction(0, Keys["X"], true) -- Disable clearing animation
		DisableControlAction(2, Keys["P"], true) -- Disable pause screen
		DisableControlAction(0, 59, true) -- Disable steering in vehicle
		DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
		DisableControlAction(0, 72, true) -- Disable reversing in vehicle
		DisableControlAction(2, Keys["LEFTCTRL"], true) -- Disable going stealth
		DisableControlAction(0, 47, true) -- Disable weapon
		DisableControlAction(0, 264, true) -- Disable melee
		DisableControlAction(0, 257, true) -- Disable melee
		DisableControlAction(0, 140, true) -- Disable melee
		DisableControlAction(0, 141, true) -- Disable melee
		DisableControlAction(0, 142, true) -- Disable melee
		DisableControlAction(0, 143, true) -- Disable melee
		DisableControlAction(0, 75, true) -- Disable exit vehicle
		DisableControlAction(27, 75, true) -- Disable exit vehicle
		DisableControlAction(0, 288, true) -- Disable exit vehicle
	end
end)

function ItemCloseInventory(itemName)
    for index, value in ipairs(Config['CloseUiItems']) do
        if value == itemName then
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