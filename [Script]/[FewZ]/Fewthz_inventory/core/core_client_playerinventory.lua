local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,["~"] = 243, 
    ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, 
    ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,["HOME"] = 213, 
    ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, 
    ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
local Accessory_Items   = {}
local Vehicle_Key       = {}
local House_Key         = {}
local isHotbar          = false;
local fastItemsHotbar   = {};
local fastWeapons       = {
	[1] = nil,
	[2] = nil,
	[3] = nil,
	[4] = nil,
	[5] = nil,
    [6] = nil,
    [7] = nil

}

function openInventory()
    loadPlayerInventoryFix()
    isInInventory = true
    SendNUIMessage(
        {
            action = "display",
            type = "normal",
            config = Config
        }
    )
    SetNuiFocus(true, true)
    TriggerScreenblurFadeIn(0)
end

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(xPlayer)
	if Config["EnableVehicleKey"] then
		TriggerServerEvent("Fewthz_inventory:getOwnerVehicle")
	end
	if Config["EnableHouseKey"] then
		TriggerServerEvent("Fewthz_inventory:getOwnerHouse")
	end
	if Config["EnableAccessory"] then
		TriggerServerEvent("Fewthz_inventory:getOwnerAccessories")
	end
end)

local house_keys AddEventHandler("scotty-housekeys:globalfetchKeys",function(keys) 
	house_keys = keys
end)
function loadPlayerInventoryFix()
	items = {}
	local playerData = ESX.GetPlayerData()
	local items = {}
	local inventory = playerData.inventory
	local accounts = playerData.accounts
	fastItems = {}
	if Config["IncludeAccounts"] and accounts ~= nil then
		for key, value in pairs(accounts) do
			if not shouldSkipAccount(accounts[key].name) then
				local canDrop = accounts[key].name ~= "bank"
				if accounts[key].money > 0 then
					accountData = {
						label = accounts[key].label,
						count = accounts[key].money,
						type = "item_account",
						name = accounts[key].name,
						usable = false,
						rare = false,
						limit = -1,
						canRemove = canDrop
					}
					table.insert(items, accountData)
				end
			end
		end
	end
	if Config["IncludeIDCard"] then
		itemData = {
			label ="ID CARD",
			name = "id_card",
			type = "item_account",
			count = 1,
			limit = 1,
			usable = true,
			rare = false,
			canRemove = false,
			limit = -1
		}

		table.insert(items, itemData)
	end

	if Config["IncludeIDCard"] then
		 itemData = {
			 label ="DRIVER LICENSE",
			 name = "driver_license",
			 type = "item_account",
			 count = 1,
			 limit = 1,
			 usable = true,
			 rare = false,
			 canRemove = false,
			 limit = -1
		 }
	
		 table.insert(items, itemData)
	end
	if inventory ~= nil then
		for key, value in pairs(inventory) do
			if inventory[key].count <= 0 then
				inventory[key] = nil
			else
				inventory[key].type = "item_standard"
				local founditem = false
				for slot, item in pairs(fastWeapons) do
					if item.name == inventory[key].name then
						table.insert(fastItems,{
							label = inventory[key].label,
							count = inventory[key].count,
							limit = -1,
							type = "item_standard",
							name = inventory[key].name,
							usable = inventory[key].usable,
							rare = inventory[key].rare,
							canRemove = true,
							slot = slot
						})
						founditem = true
						break
					end
				end
				if founditem == false then
					table.insert(items, inventory[key])
				end
			end
		end
	end
	if Config["EnableVehicleKey"] == true then
		for i=1, #Vehicle_Key, 1 do
			local founditem = false
			for slot, item in pairs(fastWeapons) do
				if item.label == Vehicle_Key[i].plate then
					table.insert(fastItems, {
						label = Vehicle_Key[i].plate,
						real = Vehicle_Key[i].plate,
						count = 1,
						limit = -1,
						type = "item_key",
						name = "key",
						usable = true,
						rare = false,
						canRemove = true,
						slot = slot
					})
					founditem = true
					break
				end
			end
			if founditem == false then
				table.insert(items, {
					label = Vehicle_Key[i].plate,
					real = Vehicle_Key[i].plate,
					count = 1,
					limit = -1,
					type = "item_key",
					name = "key",
					usable = true,
					rare = false,
					canRemove = true
				})
			end
		end
	end
	if Config["EnableAccessory"] == true then
		for i=1, #Accessory_Items, 1 do
			local founditem = false
			for slot, item in pairs(fastWeapons) do
				if item.label == Accessory_Items[i].label then
					table.insert(fastItems, {
						label = Accessory_Items[i].label,
						count = 1,
						limit = -1,
						type = "item_accessories",
						name = Accessory_Items[i].name,
						usable = true,
						rare = false,
						canRemove = true,
						itemnum = Accessory_Items[i].itemnum,
						itemskin = Accessory_Items[i].itemskin,
						itemarms = Accessory_Items[i].itemarms,
						itemarms2 = Accessory_Items[i].itemarms2,
						itemtshirt = Accessory_Items[i].itemtshirt,
						itemtshirt2 = Accessory_Items[i].itemtshirt2,
						itemchain = Accessory_Items[i].itemchain,
						itemchain2 = Accessory_Items[i].itemchain2,
						slot = slot
					})
					founditem = true
					break
				end
			end
			if founditem == false then
				table.insert(items, {
					label = Accessory_Items[i].label,
					count = 1,
					limit = -1,
					type = "item_accessories",
					name = Accessory_Items[i].name,
					usable = true,
					rare = false,
					canRemove = true,
					itemnum = Accessory_Items[i].itemnum,
					itemskin = Accessory_Items[i].itemskin,
					itemarms = Accessory_Items[i].itemarms,
					itemarms2 = Accessory_Items[i].itemarms2,
					itemtshirt = Accessory_Items[i].itemtshirt,
					itemtshirt2 = Accessory_Items[i].itemtshirt2,
					itemchain = Accessory_Items[i].itemchain,
					itemchain2 = Accessory_Items[i].itemchain2,
				})
			end
		end
	end
	if house_keys then
		for k, v in pairs(house_keys) do
		local info = {
		label = v.name or "UNKNOWN KEY",
		name = "house_keys",
		type = "house_keys_"..v.id,
		count = 1,
		usable = true,
		rare = true,
		limit = -1,
		canRemove = true
		}
		table.insert(items, info)
		end
	end
	if Config["EnableHouseKey"] == true then
		for i=1, #House_Key, 1 do
			table.insert(items, {
				label = House_Key[i].name,
				count = 1,
				limit = -1,
				type = "item_keyhouse",
				name = "keyhouse",
				usable = true,
				rare = false,
				canRemove = true,
				house_id = House_Key[i].id
			})
		end
	end
	for i=1, #Config["Weapons"], 1 do
		local weaponHash = GetHashKey(Config["Weapons"][i].name)
		local playerPed = PlayerPedId()
		if HasPedGotWeapon(playerPed, weaponHash, false) and Config["Weapons"][i].name ~= "WEAPON_UNARMED" then
			local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
			local founditem = false
			for slot, item in pairs(fastWeapons) do
				if item.name == Config["Weapons"][i].name then
					table.insert(fastItems, {
						label = Config["Weapons"][i].label,
						count = ammo,
						limit = -1,
						type = "item_weapon",
						name = Config["Weapons"][i].name,
						usable = false,
						rare = false,
						canRemove = true,
						slot = slot,
						limit = -1
					})
					founditem = true
					break
				end
			end
			if founditem == false then
				table.insert(items, {
					label = Config["Weapons"][i].label,
					count = ammo,
					limit = -1,
					type = "item_weapon",
					name = Config["Weapons"][i].name,
					usable = false,
					rare = false,
					canRemove = true,
					limit = -1
				})
			end
		end
	end

    for k, v in pairs(items) do
        local founditem = false
        for category, value in pairs(Config['Category']) do
            for index, data in pairs(value) do
                if Config['Category'][category][index] == items[k].name then
                    items[k].category = category;
                    founditem = true
                    break
                end
            end
        end
        
        if founditem == false then
            if items[k].type == "item_key" or items[k].type == "item_keyhouse" then
                items[k].category = "inventory_keys";
            elseif items[k].type == "item_weapon" then
                items[k].category = "inventory_weapon";
            elseif items[k].type == "item_accessories" then
                items[k].category = "inventory_clothes";
            else
                items[k].category = "inventory_all";
            end
        end
    end

	SendNUIMessage({
		action = "setItems",
		playerId = GetPlayerServerId(PlayerId()),
		itemList = items,
		text = texts,
		fastItems = fastItems
	})
end

RegisterNetEvent('esx:addWeapon')
AddEventHandler('esx:addWeapon', function(weaponName, ammo)
	local playerPed  = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)
	GiveWeaponToPed(playerPed, weaponHash, ammo, false, false)
end)

RegisterNetEvent('esx:addWeaponComponent')
AddEventHandler('esx:addWeaponComponent', function(weaponName, weaponComponent)
	local playerPed  = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)
	local componentHash = ESX.GetWeaponComponent(weaponName, weaponComponent).hash
	GiveWeaponComponentToPed(playerPed, weaponHash, componentHash)
end)

RegisterNetEvent('esx:removeWeapon')
AddEventHandler('esx:removeWeapon', function(weaponName, ammo)
	local playerPed  = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)
	RemoveWeaponFromPed(playerPed, weaponHash)
	if ammo then
		local pedAmmo = GetAmmoInPedWeapon(playerPed, weaponHash)
		local finalAmmo = math.floor(pedAmmo - ammo)
		SetPedAmmo(playerPed, weaponHash, finalAmmo)
	else
		SetPedAmmo(playerPed, weaponHash, 0) -- remove leftover ammo
	end
end)


RegisterNetEvent('esx:removeWeaponComponent')
AddEventHandler('esx:removeWeaponComponent', function(weaponName, weaponComponent)
	local playerPed  = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)
	local componentHash = ESX.GetWeaponComponent(weaponName, weaponComponent).hash

	RemoveWeaponComponentFromPed(playerPed, weaponHash, componentHash)
end)

RegisterNetEvent('esx:addInventoryItem')
AddEventHandler('esx:addInventoryItem', function(item, count)
    Wait(150)
    loadPlayerInventoryFix()
end)

RegisterNetEvent('esx:removeInventoryItem')
AddEventHandler('esx:removeInventoryItem', function(item, count)
	Wait(150)
    loadPlayerInventoryFix()
end)

RegisterNetEvent('es:activateMoney')
AddEventHandler('es:activateMoney', function(money)
	Wait(150)
	loadPlayerInventoryFix()
end)

RegisterNetEvent('Fewthz_inventory:refreshInventory')
AddEventHandler('Fewthz_inventory:refreshInventory', function()
	Wait(150)
	loadPlayerInventoryFix()
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
        if Config["EnableVehicleKey"] then
            TriggerServerEvent("Fewthz_inventory:getOwnerVehicle")
        end
        if Config["EnableHouseKey"] then
            TriggerServerEvent("Fewthz_inventory:getOwnerHouse")
        end
        if Config["EnableAccessory"] then
        TriggerServerEvent("Fewthz_inventory:getOwnerAccessories")
        end
	end
end)

AddEventHandler("onResourceStop", function(resource)
	if resource == GetCurrentResourceName() then
		closeInventory()
		TriggerEvent("chat:removeSuggestion", "/openinventory")
	end
end)

RegisterNetEvent("Fewthz_inventory:getOwnerAccessories")
AddEventHandler("Fewthz_inventory:getOwnerAccessories",function()
    TriggerServerEvent("Fewthz_inventory:getOwnerAccessories")
end)

RegisterNetEvent("Fewthz_inventory:getOwnerVehicle")
AddEventHandler("Fewthz_inventory:getOwnerVehicle",function()
    TriggerServerEvent("Fewthz_inventory:getOwnerVehicle")
end)

RegisterNetEvent("Fewthz_inventory:getOwnerHouse")
AddEventHandler("Fewthz_inventory:getOwnerHouse",function()
    TriggerServerEvent("Fewthz_inventory:getOwnerHouse")
end)

RegisterNetEvent("Fewthz_inventory:setOwnerVehicle")
AddEventHandler("Fewthz_inventory:setOwnerVehicle", function(result)
    Vehicle_Key = result
end)

RegisterNetEvent("Fewthz_inventory:setOwnerHouse")
AddEventHandler("Fewthz_inventory:setOwnerHouse", function(result)
    House_Key = result
end)

RegisterNetEvent("Fewthz_inventory:setOwnerAccessories")
AddEventHandler("Fewthz_inventory:setOwnerAccessories", function(result)
    Accessory_Items = result
end)

RegisterKeyMapping('openQuickSlotBar', 'Open quick slot bar', 'keyboard', Config["OpenQuickSlotBar"])
RegisterCommand('openQuickSlotBar', function()
    if not isHotbar then
		isHotbar = true
		SendNUIMessage({
			action = 'showhotbar',
			fastItems = fastItemsHotbar
		})
		isHotbar = false
	end
end, false)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(7)
		HudForceWeaponWheel(false)
		HudWeaponWheelIgnoreSelection()
		DisableControlAction(1, 37, true)
		DisableControlAction(1, 157, true)
		DisableControlAction(1, 158, true)
		DisableControlAction(1, 160, true)
		DisableControlAction(1, 164, true)
		DisableControlAction(1, 165, true)
		DisableControlAction(2, 157, true)-- disable changing weapon
		DisableControlAction(2, 158, true)-- disable changing weapon
		DisableControlAction(2, 159, true)-- disable changing weapon
		DisableControlAction(2, 160, true)-- disable changing weapon
		DisableControlAction(2, 161, true)-- disable changing weapon
		DisableControlAction(2, 162, true)-- disable changing weapon
		DisableControlAction(2, 163, true)-- disable changing weapon
		DisableControlAction(2, 164, true)-- disable changing weapon
		DisableControlAction(2, 165, true)-- disable changing weapon
	end
end)

function OnUseFastSlot(number)
    if not IsEntityDead(PlayerPedId()) then
        if fastWeapons[number] ~= nil then
            if fastWeapons[number].name == 'key' then
                TriggerServerEvent('scotty:keyTrigger', fastWeapons[number].label)
            elseif fastWeapons[number].type == 'item_weapon' then
                SetWeapon(fastWeapons[number])
            elseif fastWeapons[number].type == 'item_accessories' then
                useItems(fastWeapons[number])
            else
                TriggerServerEvent('esx:useItem', fastWeapons[number].name)
            end
        end
    end
end

RegisterKeyMapping('fast1', 'Use Fast Slot (1)', 'keyboard', '1')
RegisterKeyMapping('fast2', 'Use Fast Slot (2)', 'keyboard', '2')
RegisterKeyMapping('fast3', 'Use Fast Slot (3)', 'keyboard', '3')
RegisterKeyMapping('fast4', 'Use Fast Slot (4)', 'keyboard', '4')
RegisterKeyMapping('fast5', 'Use Fast Slot (5)', 'keyboard', '5')
RegisterKeyMapping('fast6', 'Use Fast Slot (6)', 'keyboard', '6')
RegisterKeyMapping('fast7', 'Use Fast Slot (7)', 'keyboard', '7')

RegisterCommand('fast1', function() OnUseFastSlot(1) end, false)
RegisterCommand('fast2', function() OnUseFastSlot(2) end, false)
RegisterCommand('fast3', function() OnUseFastSlot(3) end, false)
RegisterCommand('fast4', function() OnUseFastSlot(4) end, false)
RegisterCommand('fast5', function() OnUseFastSlot(5) end, false)
RegisterCommand('fast6', function() OnUseFastSlot(6) end, false)
RegisterCommand('fast7', function() OnUseFastSlot(7) end, false)

IsSetWeapon = false
SetWeapon = function(data)
    if not IsSetWeapon then
        SetCurrentPedWeapon(PlayerPedId(), GetHashKey(data.name), true)
        IsSetWeapon = true
    else
        IsSetWeapon = false
        SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)
    end
end

RegisterNUICallback("PutIntoFast", function(data, cb)
	if data.item.slot ~= nil then
		fastWeapons[data.item.slot] = nil
	end

	fastWeapons[data.slot] = data.item
	loadPlayerInventoryFix()
	cb("ok")
end)

RegisterNUICallback("TakeFromFast", function(data, cb)
	fastWeapons[data.item.slot] = nil

	loadPlayerInventoryFix()
	cb("ok")
end)

function useItems(data)
	local player = GetPlayerPed(-1)	
	closeInventory()			 
	if data.name == "helmet" then
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
				accessorySkin["helmet_1"] = data.itemnum
				accessorySkin["helmet_2"] = data.itemskin
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
	elseif data.name == "mask" then
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
				accessorySkin["mask_1"] = data.itemnum
				accessorySkin["mask_2"] = data.itemskin
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
	elseif data.name == "glasses" then
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
				accessorySkin["glasses_1"] = data.itemnum
				accessorySkin["glasses_2"] = data.itemskin
				TriggerEvent("skinchanger:loadClothes", skin, accessorySkin)
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
	elseif data.name == "tshirt" then
		TriggerEvent("skinchanger:getSkin", function(skin)
			if skin["tshirt_1"] == -1 then
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
				accessorySkin["tshirt_1"] = data.itemnum
				accessorySkin["tshirt_2"] = data.itemskin
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
				accessorySkin["tshirt_1"] = -1
				accessorySkin["tshirt_2"] = 0
				TriggerEvent("skinchanger:loadClothes", skin, accessorySkin)
			end
		end)
	elseif data.name == "torso" then
		TriggerEvent("skinchanger:getSkin", function(skin)
			if skin["torso_1"] == -1 then
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
				accessorySkin["torso_1"] = data.itemnum
				accessorySkin["torso_2"] = data.itemskin
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
				accessorySkin["torso_1"] = -1
				accessorySkin["torso_2"] = 0
				TriggerEvent("skinchanger:loadClothes", skin, accessorySkin)
			end
		end)
	elseif data.name == "arms" then
		TriggerEvent("skinchanger:getSkin", function(skin)
			if skin["arms"] == 15 then
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
				accessorySkin["arms"] = data.itemnum
				accessorySkin["arms_2"] = data.itemskin
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
				accessorySkin["arms"] = 15
				accessorySkin["arms_2"] = 0
				TriggerEvent("skinchanger:loadClothes", skin, accessorySkin)
			end
		end)
	elseif data.name == "pants" then
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
				accessorySkin["pants_1"] = data.itemnum
				accessorySkin["pants_2"] = data.itemskin
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
	elseif data.name == "shoes" then
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
				accessorySkin["shoes_1"] = data.itemnum
				accessorySkin["shoes_2"] = data.itemskin
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
	elseif data.name == "earring" then
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
				accessorySkin["ears_1"] = data.itemnum
				accessorySkin["ears_2"] = data.itemskin
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
	elseif data.name == "watches" then
		TriggerEvent("skinchanger:getSkin", function(skin)
			if skin["watches_1"] == -1 then
				if IsPedInAnyVehicle(PlayerPedId(), true) == false then
					local dict = "missmic4"
					local anim = "michael_tux_fidget"
					RequestAnimDict(dict)
					while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
					TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
					Citizen.Wait(800)
				end
				local accessorySkin = {}
				accessorySkin["watches_1"] = data.itemnum
				accessorySkin["watches_2"] = data.itemskin
				TriggerEvent("skinchanger:loadClothes", skin, accessorySkin)
			else
				if IsPedInAnyVehicle(PlayerPedId(), true) == false then
					local dict = "missmic4"
					local anim = "michael_tux_fidget"
					RequestAnimDict(dict)
					while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
					TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
					Citizen.Wait(800)
				end
				local accessorySkin = {}
				accessorySkin["watches_1"] = -1
				accessorySkin["watches_2"] = 0
				TriggerEvent("skinchanger:loadClothes", skin, accessorySkin)
			end
		end)
	elseif data.name == "decals" then
		TriggerEvent("skinchanger:getSkin", function(skin)
			if skin["decals_1"] == -1 then
				if IsPedInAnyVehicle(PlayerPedId(), true) == false then
					RequestAnimDict("clothingtie")
					while (not HasAnimDictLoaded("clothingtie")) do Citizen.Wait(0) end
					TaskPlayAnim(player, "clothingtie", "try_tie_positive_a", 8.0, 1.0, -1, 0, 0.5, 0, 0)
					Citizen.Wait(2000)
				end
				local accessorySkin = {}
				accessorySkin["decals_1"] = data.itemnum
				accessorySkin["decals_2"] = data.itemskin
				TriggerEvent("skinchanger:loadClothes", skin, accessorySkin)
			else
				if IsPedInAnyVehicle(PlayerPedId(), true) == false then
					RequestAnimDict("clothingtie")
					while (not HasAnimDictLoaded("clothingtie")) do Citizen.Wait(0) end
					TaskPlayAnim(player, "clothingtie", "try_tie_positive_a", 8.0, 1.0, -1, 0, 0.3, 0, 0)
					Citizen.Wait(2000)
				end
				local accessorySkin = {}
				accessorySkin["decals_1"] = -1
				accessorySkin["decals_2"] = 0
				TriggerEvent("skinchanger:loadClothes", skin, accessorySkin)
			end
		end)
	elseif data.name == "chain" then
		TriggerEvent("skinchanger:getSkin", function(skin)
			if skin["chain_1"] == -1 then
				if IsPedInAnyVehicle(PlayerPedId(), true) == false then
					local dict = "clothingtie"
					local anim = "try_tie_positive_a"
					RequestAnimDict(dict)
					while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
					TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 0.2, 0.2, 0, 0 )
					Citizen.Wait(2000)
				end
				local accessorySkin = {}
				accessorySkin["chain_1"] = data.itemnum
				accessorySkin["chain_2"] = data.itemskin
				TriggerEvent("skinchanger:loadClothes", skin, accessorySkin)
			else
				if IsPedInAnyVehicle(PlayerPedId(), true) == false then
					local dict = "clothingtie"
					local anim = "try_tie_positive_a"
					RequestAnimDict(dict)
					while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
					TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 0.2, 0.2, 0, 0 )
					Citizen.Wait(2000)
				end
				local accessorySkin = {}
				accessorySkin["chain_1"] = -1
				accessorySkin["chain_2"] = 0
				TriggerEvent("skinchanger:loadClothes", skin, accessorySkin)
			end
		end)
	elseif data.name == "bags" then
		TriggerEvent("skinchanger:getSkin", function(skin)
			if skin["bags_1"] == -1 then
				if IsPedInAnyVehicle(PlayerPedId(), true) == false then
					RequestAnimDict("clothingtie")
					while (not HasAnimDictLoaded("clothingtie")) do Citizen.Wait(0) end
					TaskPlayAnim(player, "clothingtie", "try_tie_positive_a", 8.0, 1.0, -1, 0, 0.5, 0, 0)
					Citizen.Wait(2000)
				end
				local accessorySkin = {}
				accessorySkin["bags_1"] = data.itemnum
				accessorySkin["bags_2"] = data.itemskin
				TriggerEvent("skinchanger:loadClothes", skin, accessorySkin)
			else
				if IsPedInAnyVehicle(PlayerPedId(), true) == false then
					RequestAnimDict("clothingtie")
					while (not HasAnimDictLoaded("clothingtie")) do Citizen.Wait(0) end
					TaskPlayAnim(player, "clothingtie", "try_tie_positive_a", 8.0, 1.0, -1, 0, 0.3, 0, 0)
					Citizen.Wait(2000)
				end
				local accessorySkin = {}
				accessorySkin["bags_1"] = -1
				accessorySkin["bags_2"] = 0
				TriggerEvent("skinchanger:loadClothes", skin, accessorySkin)
			end
		end)
	end
end