ESX = exports["es_extended"]:getSharedObject()

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

-- local Maxweight = 0
-- local script_name = GetCurrentResourceName()


-- RegisterNetEvent(script_name .. ":client:getdata")
-- AddEventHandler(script_name .. ":client:getdata", function(f)
--     Maxweight = f
-- end)

RegisterNetEvent('blockinventory')
AddEventHandler('blockinventory', function()
	closeInventory()
end)




-- Citizen.CreateThread(function()
--     while true do
--         local ss = 1500

--         if IsControlJustReleased(0, Config.OpenControl) and IsInputDisabled(0) then
--             openInventorys()

--         end
--         Citizen.Wait(ss)
--     end
-- end)





function openInventory()
    isInInventory = true
    if Config.BlurBackdrop then
        TriggerScreenblurFadeIn(1200)
    end
    loadPlayerInventory()
    SendNUIMessage(
        {
            action = 'display',
            type = 'normal'
        }
    )

    SetNuiFocus(true, true)
end

function loadPlayerInventory()
    local playerData = ESX.GetPlayerData()
    local PlayerId = GetPlayerServerId(PlayerId())
    local playerPed = PlayerPedId()
    local items = {}
    local inventory = playerData.inventory -- data.inventory
    local accounts = playerData.accounts -- data.accounts
    fastItems = {}

    if Config.Items then
        local founditem = false
        for slot, item in pairs(fastWeapons) do
            if item.label == "บัตรประชาชน" then
                table.insert(fastItems, {
                    label ="ID CARD",
                    name = "id_card",
                    type = "item_info",
                    count = 1,
                    limit = 1,
                    usable = true,
                    rare = false,
                    canRemove = true,
                    weight = 0,
                    slot = slot
                })
                founditem = true
                break
            end
        end
        if founditem == false then
            table.insert(items, {
                label ="ID CARD",
                name = "id_card",
                type = "item_info",
                count = 1,
                limit = 1,
                usable = true,
                rare = false,
                canRemove = true,
                weight = 0
            })
        end
    end

    if accounts ~= nil then
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
                        weight = 0,
                        canRemove = canDrop
                    }
                    table.insert(items, accountData)
                end
            end
        end
    end

    for i=1, #inventory, 1 do
        if inventory[i].count > 0 then
            local founditem = false
            for slot, item in pairs(fastWeapons) do
                if item.name == inventory[i].name then

                    table.insert(fastItems, {
                        label     = inventory[i].label,
                        count     = inventory[i].count,
                        weight     = inventory[i].weight,
                        limit     = inventory[i].limit,
                        type      = 'item_standard',
                        name      = inventory[i].name,
                        usable    = inventory[i].usable,
                        rare      = true,
                        canRemove = true,
                        slot = slot
                    })
                    founditem = true
                    break
                end
            end
            
            if founditem == false then
                table.insert(items, {
                    label     = inventory[i].label,
                    count     = inventory[i].count,
                    weight     = inventory[i].weight,
                    limit     = inventory[i].limit,
                    type      = 'item_standard',
                    name      = inventory[i].name,
                    usable    = inventory[i].usable,
                    rare      = true,
                    canRemove = true
                })
            end
        end
    end
    Config.Weapons = ESX.GetConfig().Weapons
    if Config.IncludeWeapons then
        for i=1, #Config.Weapons, 1 do
            local weaponHash = GetHashKey(Config.Weapons[i].name)
            local playerPed = PlayerPedId()

            if HasPedGotWeapon(playerPed, weaponHash, false) and Config.Weapons[i].name ~= 'WEAPON_UNARMED' then
                local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
                local founditem = false
                for slot, item in pairs(fastWeapons) do
                    if item.name == Config.Weapons[i].name then
                        table.insert(fastItems, {
                            label     = Config.Weapons[i].label,
                            count     = ammo,
                            limit       = -1,
                            type      = 'item_weapon',
                            name     = Config.Weapons[i].name,
                            usable    = false,
                            rare      = false,
                            canRemove = true,
                            slot = slot,
                        })
                        founditem = true
                        break
                    end
                end
                
                if founditem == false then
                    table.insert(items, {
                        label     = Config.Weapons[i].label,
                        count     = ammo,
                        limit       = -1,
                        type      = 'item_weapon',
                        name     = Config.Weapons[i].name,
                        usable    = false,
                        rare      = false,
                        canRemove = true,
                    })
                end
            end
        end
    end

    if Config.EnableVehicleKey == true then
        for i=1, #Vehicle_Key, 1 do
            local founditem = false
            for slot, item in pairs(fastWeapons) do
                if item.label == Vehicle_Key[i].plate then
                    table.insert(fastItems, {
                        label = Vehicle_Key[i].plate,
                        count = 1,
                        limit = -1,
                        type = "item_key",
                        name = "key",
                        usable = true,
                        rare = false,
                        canRemove = false,
                        slot = slot,
                        weight = 0
                    })
                    founditem = true
                    break
                end
            end
            
            if founditem == false then
                table.insert(items, {
                    label = Vehicle_Key[i].plate,
                    count = 1,
                    limit = -1,
                    type = "item_key",
                    name = "key",
                    usable = true,
                    rare = false,
                    canRemove = false,
                    weight = 0
                })
            end
        end
    end

    for i=1, #Accessory_Items, 1 do
        local founditem = false
        for slot, item in pairs(fastWeapons) do
            if item.id == Accessory_Items[i].id then
                table.insert(fastItems, {
                    id = Accessory_Items[i].id,
                    label = Accessory_Items[i].label,
                    count = 1,
                    limit = -1,
                    type = "item_accessories",
                    name = Accessory_Items[i].name,
                    usable = true,
                    rare = false,
                    canRemove = false,
                    itemnum = Accessory_Items[i].itemnum,
                    itemskin = Accessory_Items[i].itemskin,
                    itemnum2 = Accessory_Items[i].itemnum2,
                    itemskin2 = Accessory_Items[i].itemskin2,
                    itemnum3 = Accessory_Items[i].itemnum3,
                    itemskin3 = Accessory_Items[i].itemskin3,
                    itemnum4 = Accessory_Items[i].itemnum4,
                    itemskin4 = Accessory_Items[i].itemskin4,
                    slot = slot,
                    weight = 0
                })
                founditem = true
                break
            end
        end
        
        if founditem == false then
            table.insert(items, {
                id = Accessory_Items[i].id,
                label = Accessory_Items[i].label,
                count = 1,
                limit = -1,
                type = "item_accessories",
                name = Accessory_Items[i].name,
                usable = true,
                rare = false,
                canRemove = false,
                itemnum = Accessory_Items[i].itemnum,
                itemskin = Accessory_Items[i].itemskin,
                itemnum2 = Accessory_Items[i].itemnum2,
                itemskin2 = Accessory_Items[i].itemskin2,
                itemnum3 = Accessory_Items[i].itemnum3,
                itemskin3 = Accessory_Items[i].itemskin3,
                itemnum4 = Accessory_Items[i].itemnum4,
                itemskin4 = Accessory_Items[i].itemskin4,
                weight = 0
            })
        end
    end

    for k, v in pairs(items) do
        local founditem = false
        for category, value in pairs(Config.Category) do
            for index, data in pairs(value) do
                if Config.Category[category][index] == v.name then
                    v.category = category;
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


    local inventoryWeight = 0
    local moneyinventory = 0
    local xPlayer = ESX.GetPlayerData()
    inventory = ESX.GetPlayerData().inventory
    local tbl = {}
    for k,v in pairs(xPlayer.accounts) do
        if v.name == "money" then
            moneyinventory = v.money
        end
    end
    for k,v in pairs(xPlayer.accounts) do
        if v.name == "black_money" then
            blackmoneys = v.money
        end
    end
    for k,v in pairs(inventory) do
         -- inventoryWeight = inventoryWeight + (v.count * v.weight)
    end    
    

    --    ESX.TriggerServerCallback("getweight", function(x) 

            fastItemsHotbar =  fastItems

            SendNUIMessage({
                action = "setItems",
                itemList = items,
                fastItems = fastItems,
                text = texts,

                -- weight = x.CurrentWeight,
                -- max = x.MaxWeight,
                Id = PlayerId,
                money = moneyinventory,
                blackmoney = blackmoneys
            })
    --    end)
		
end

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

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
    for k,v in ipairs(ESX.PlayerData.accounts) do
        if 'black_money' == account.name then
            ESX.PlayerData.accounts[k] = account
            break
        end
    end

    if isInInventory then
		loadPlayerInventory()
	end
end)

RegisterNetEvent('esx:removeInventoryItem')
AddEventHandler('esx:removeInventoryItem', function(item, count)
	for k,v in ipairs(ESX.PlayerData.inventory) do
		if v.name == item.name then
			ESX.PlayerData.inventory[k] = item
			break
		end
    end
	if isInInventory then
		loadPlayerInventory()
	end
end)
RegisterNetEvent('Fxw_inventory:refreshInventory')
AddEventHandler('Fxw_inventory:refreshInventory', function()
	print("refresh")
	loadPlayerInventory()
end)

RegisterNetEvent('esx:addInventoryItem')
AddEventHandler('esx:addInventoryItem', function(item, count)
	for k,v in ipairs(ESX.PlayerData.inventory) do
        if v.name == item.name then
            ESX.PlayerData.inventory[k] = item
			break
		end
	end
	if isInInventory then
		loadPlayerInventory()
	end
end)

RegisterNetEvent('es:activateMoney')
AddEventHandler('es:activateMoney', function(money)
    ESX.PlayerData.money = money
    if isInInventory then
		loadPlayerInventory()
	end
end)



RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	-- ESX.TriggerServerCallback("Fxw_inventory:getOwnerVehicle")
    LoadData()
    TriggerServerEvent("Fxw_inventory:getOwnerHouse")
    TriggerServerEvent("Fxw_inventory:getOwnerAccessories")
    TriggerServerEvent("Fxw_inventory:black_money")
    ESX.PlayerData = xPlayer
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
        -- TriggerServerEvent("Fxw_inventory:getOwnerVehicle")
        LoadData()
        TriggerServerEvent("Fxw_inventory:getOwnerHouse")
        TriggerServerEvent("Fxw_inventory:getOwnerAccessories")
        TriggerServerEvent("Fxw_inventory:black_money")
	end
end)

RegisterNetEvent("Fxw_inventory:getOwnerAccessories")
AddEventHandler("Fxw_inventory:getOwnerAccessories",function()
    TriggerServerEvent("Fxw_inventory:getOwnerAccessories")
end)

RegisterNetEvent("Fxw_inventory:getOwnerVehicle")
AddEventHandler("Fxw_inventory:getOwnerVehicle",function()
    TriggerServerEvent("Fxw_inventory:getOwnerVehicle")
    LoadData()
end)

function LoadDataVehicle()
    TriggerServerEvent("Fxw_inventory:getOwnerVehicle")
    TriggerEvent("Fxw_inventory:getOwnerVehicle")
    LoadData()
end

RegisterNetEvent("Fxw_inventory:getOwnerHouse")
AddEventHandler("Fxw_inventory:getOwnerHouse",function()
    TriggerServerEvent("Fxw_inventory:getOwnerHouse")
end)

RegisterNetEvent("Fxw_inventory:setOwnerVehicle")
AddEventHandler("Fxw_inventory:setOwnerVehicle", function(result)
    Vehicle_Key = result
end)

RegisterNetEvent("Fxw_inventory:setOwnerHouse")
AddEventHandler("Fxw_inventory:setOwnerHouse", function(result)
    House_Key = result
end)

RegisterNetEvent("Fxw_inventory:setOwnerAccessories")
AddEventHandler("Fxw_inventory:setOwnerAccessories", function(result)
    Accessory_Items = result
end)

function LoadData()
    while ESX == nil do
        Wait(10)
    end
      
    print('broke loop')
    ESX.TriggerServerCallback('Fxw_inventory:getOwnerVehicle', function(keyItems)
        -- print(json.encode(keyItems))
        TriggerEvent('Fxw_inventory:setOwnerVehicle', keyItems)
    end)
end


function showHotbar()
	if not isHotbar then
        
		isHotbar = true
		SendNUIMessage({
			action = "hotbar",
			fastItems = fastItemsHotbar
		})
		isHotbar = false
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
    

        --SetPedCanSwitchWeapon(PlayerPedId(), false)
		HideHudComponentThisFrame(19)
      
		DisableControlAction(1, 37, true)
		DisableControlAction(1, 157, true)
		DisableControlAction(1, 158, true)
		DisableControlAction(1, 160, true)
		DisableControlAction(1, 164, true)
		DisableControlAction(1, 165, true)
		DisableControlAction(1, 73, true)
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
    showHotbar()
    if not IsEntityDead(PlayerPedId()) then
        if fastWeapons[number] ~= nil then
            if fastWeapons[number].name == "key" then
                TriggerServerEvent("meeta_remote:ServerLock", fastWeapons[number].label)
            elseif fastWeapons[number].type == "item_weapon" then
                SetWeapon(fastWeapons[number])
            elseif fastWeapons[number].type == "item_accessories" then
                useItems(fastWeapons[number])
            elseif fastWeapons[number].type == "item_info" then
            else
                TriggerServerEvent("esx:useItem", fastWeapons[number].name)
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

RegisterCommand('fast1', function() 
    OnUseFastSlot(1) 
    loadPlayerInventory()
end, false)
RegisterCommand('fast2', function() 
    OnUseFastSlot(2) 
    loadPlayerInventory()
end, false)
RegisterCommand('fast3', function() 
    OnUseFastSlot(3) 
    loadPlayerInventory()
end, false)
RegisterCommand('fast4', function() 
    OnUseFastSlot(4) 
    loadPlayerInventory()
end, false)
RegisterCommand('fast5', function() 
    OnUseFastSlot(5) 
    loadPlayerInventory()
end, false)
RegisterCommand('fast6', function() 
    OnUseFastSlot(6) 
    loadPlayerInventory()
end, false)
RegisterCommand('fast7', function() 
    OnUseFastSlot(7) 
    loadPlayerInventory()
end, false)



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
    if Config.Dontuse[data.item.name] then
        -- exports['mythic_notify']:SendAlert('error', 'ไม่สามารถเอาไอเท็มชิ้นนี้ใส่ช่องสล็อตได้ ! ! !')
        TriggerEvent("pNotify:SendNotification", {
            text =  "ไม่สามารถเอาไอเท็มชิ้นนี้ใส่ช่องสล็อตได้ ! ! !",
            type = "error",
            timeout = 5000,
            layout = "centerLeft"
        })
    else
        if data.item.slot ~= nil then
            fastWeapons[data.item.slot] = nil
        end

        fastWeapons[data.slot] = data.item
        loadPlayerInventory()
        cb("ok")
    end
end)

RegisterNUICallback("TakeFromFast", function(data, cb)
	fastWeapons[data.item.slot] = nil

	loadPlayerInventory()
	cb("ok")
end)

RegisterNUICallback('GetBrowserCache', function(data, cb)
    if data.cache ~= false then
        print('action : receive-browser-cache')
        fastWeapons = data.cache
    end
    cb('ok')
end)


function useItems(data)
    local player = GetPlayerPed(-1)	
    closeInventory()			 
   
    if data.name == "helmet" then
        TriggerEvent('skinchanger:getSkin', function(skin)
            if skin["helmet_1"] == -1 then

                local dict = "veh@bicycle@roadfront@base"
                local anim = "put_on_helmet"
    
                RequestAnimDict(dict)
                while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
                
                TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
    
                Wait(1000)

                local accessorySkin = {}
                accessorySkin['helmet_1'] = data.itemnum
                accessorySkin['helmet_2'] = data.itemskin

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
    elseif data.name == "mask" then
        TriggerEvent('skinchanger:getSkin', function(skin)
            if skin["mask_1"] == -1 then

                local dict = "veh@bicycle@roadfront@base"
                local anim = "put_on_helmet"
    
                RequestAnimDict(dict)
                while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
                
                TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
    
                Wait(1000)

                local accessorySkin = {}
                accessorySkin['mask_1'] = data.itemnum
                accessorySkin['mask_2'] = data.itemskin
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
    elseif data.name == "glasses" then
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
                accessorySkin['glasses_1'] = data.itemnum
                accessorySkin['glasses_2'] = data.itemskin
                TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)

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
    -------------------------------------------------------------------[1]-------------------------------------------------------------------           
    -- tshirt
elseif data.name == "tshirt" then
    TriggerEvent('skinchanger:getSkin', function(skin)

        if skin["tshirt_1"] == -1 then

        if Config.Options.enabled and IsPedInAnyVehicle(PlayerPedId(), true) == false then
            RequestAnimDict(Config.Options.dicton)
            while (not HasAnimDictLoaded(Config.Options.dicton)) do Citizen.Wait(0) end
            TaskPlayAnim(player, Config.Options.dicton, Config.Options.animon, 8.0, 1.0, -1, 0, 0.5, 0, 0)
            Wait(2000)
        end

        local accessorySkin = {}
        accessorySkin['tshirt_1']  = data.itemnum
        accessorySkin['tshirt_2']  = data.itemskin
        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
        exports['mythic_notify']:DoHudText('success', Config.Text.torsoon)              
    else

        if Config.Options.enabledoff and IsPedInAnyVehicle(PlayerPedId(), true) == false then
            RequestAnimDict(Config.Options.dictoff)
            while (not HasAnimDictLoaded(Config.Options.dictoff)) do Citizen.Wait(0) end
            TaskPlayAnim(player, Config.Options.dictoff, Config.Options.animoff, 8.0, 1.0, -1, 0, 0.3, 0, 0)
            Wait(2000)
        end

        local accessorySkin = {}
        accessorySkin['tshirt_1'] = -1
        accessorySkin['tshirt_2'] = 0
        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
        exports['mythic_notify']:DoHudText('error', Config.Text.torsooff) 
    end
    
end)
-- Torso
elseif data.name == "torso" then
    TriggerEvent('skinchanger:getSkin', function(skin)

        if skin["torso_1"] == -1 then

        if Config.Options.enabled and IsPedInAnyVehicle(PlayerPedId(), true) == false then
            RequestAnimDict(Config.Options.dicton)
            while (not HasAnimDictLoaded(Config.Options.dicton)) do Citizen.Wait(0) end
            TaskPlayAnim(player, Config.Options.dicton, Config.Options.animon, 8.0, 1.0, -1, 0, 0.5, 0, 0)
            Wait(2000)
        end

        local accessorySkin = {}
        accessorySkin['torso_1']   = data.itemnum
        accessorySkin['torso_2']   = data.itemskin
        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin) 
        exports['mythic_notify']:DoHudText('success',  Config.Text.torsoon)             
    else

        if Config.Options.enabledoff and IsPedInAnyVehicle(PlayerPedId(), true) == false then
            RequestAnimDict(Config.Options.dictoff)
            while (not HasAnimDictLoaded(Config.Options.dictoff)) do Citizen.Wait(0) end
            TaskPlayAnim(player, Config.Options.dictoff, Config.Options.animoff, 8.0, 1.0, -1, 0, 0.3, 0, 0)
            Wait(2000)
        end

        local accessorySkin = {}
        accessorySkin['torso_1'] = -1
        accessorySkin['torso_2'] = 0
        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
        exports['mythic_notify']:DoHudText('error',  Config.Text.torsooff)      
    end
    
end)
-- arms
elseif data.name == "arms" then
TriggerEvent('skinchanger:getSkin', function(skin)

    if skin["arms"] == 15 then

    if Config.Options.enabled and IsPedInAnyVehicle(PlayerPedId(), true) == false then
        RequestAnimDict(Config.Options.dicton)
        while (not HasAnimDictLoaded(Config.Options.dicton)) do Citizen.Wait(0) end
        TaskPlayAnim(player, Config.Options.dicton, Config.Options.animon, 8.0, 1.0, -1, 0, 0.5, 0, 0)
        Wait(2000)
    end

    local accessorySkin = {}
    accessorySkin['arms']   = data.itemnum
    accessorySkin['arms_2']   = data.itemskin
    TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)  
    exports['mythic_notify']:DoHudText('success',  Config.Text.torsoon)              
else

    if Config.Options.enabledoff and IsPedInAnyVehicle(PlayerPedId(), true) == false then
        RequestAnimDict(Config.Options.dictoff)
        while (not HasAnimDictLoaded(Config.Options.dictoff)) do Citizen.Wait(0) end
        TaskPlayAnim(player, Config.Options.dictoff, Config.Options.animoff, 8.0, 1.0, -1, 0, 0.3, 0, 0)
        Wait(2000)
    end

    local accessorySkin = {}
    accessorySkin['arms'] = 15
    accessorySkin['arms_2'] = 0
    TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
    exports['mythic_notify']:DoHudText('error',  Config.Text.torsooff)  
end       
end)
elseif data.name == "pants" then
TriggerEvent('skinchanger:getSkin', function(skin)
    if skin["pants_1"] == 21 then

        if Config.Options.enabled and IsPedInAnyVehicle(PlayerPedId(), true) == false then
            RequestAnimDict(Config.Options.dicton)
            while (not HasAnimDictLoaded(Config.Options.dicton)) do Citizen.Wait(0) end
            TaskPlayAnim(player, Config.Options.dicton, Config.Options.animon, 8.0, 1.0, -1, 0, 0.5, 0, 0)
            Wait(2000)
        end

        local accessorySkin = {}
        accessorySkin['pants_1'] = data.itemnum
        accessorySkin['pants_2'] = data.itemskin
        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
        exports['mythic_notify']:DoHudText('success', Config.Text.pantson)  

    else

        if Config.Options.enabledoff and IsPedInAnyVehicle(PlayerPedId(), true) == false then
            RequestAnimDict(Config.Options.dictoff)
            while (not HasAnimDictLoaded(Config.Options.dictoff)) do Citizen.Wait(0) end
            TaskPlayAnim(player, Config.Options.dictoff, Config.Options.animoff, 8.0, 1.0, -1, 0, 0.3, 0, 0)
            Wait(2000)
        end

        local accessorySkin = {}
        accessorySkin['pants_1'] = 21
        accessorySkin['pants_2'] = 0
        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
        exports['mythic_notify']:DoHudText('error',  Config.Text.pantsoff)  
    end
    
end)
elseif data.name == "shoes" then
TriggerEvent('skinchanger:getSkin', function(skin)
    if skin["shoes_1"] == 34 then

        if Config.Options.enabled and IsPedInAnyVehicle(PlayerPedId(), true) == false then
            RequestAnimDict(Config.Options.dicton)
            while (not HasAnimDictLoaded(Config.Options.dicton)) do Citizen.Wait(0) end
            TaskPlayAnim(player, Config.Options.dicton, Config.Options.animon, 8.0, 1.0, -1, 0, 0.5, 0, 0)
            Wait(2000)
        end

        local accessorySkin = {}
        accessorySkin['shoes_1'] = data.itemnum
        accessorySkin['shoes_2'] = data.itemskin
        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
        exports['mythic_notify']:DoHudText('success',  Config.Text.shoeson)  

        ClearPedTasks(player)
    else

        if Config.Options.enabledoff and IsPedInAnyVehicle(PlayerPedId(), true) == false then
            RequestAnimDict(Config.Options.dictoff)
            while (not HasAnimDictLoaded(Config.Options.dictoff)) do Citizen.Wait(0) end
            TaskPlayAnim(player, Config.Options.dictoff, Config.Options.animoff, 8.0, 1.0, -1, 0, 0.3, 0, 0)
            Wait(2000)
        end

        local accessorySkin = {}
        accessorySkin['shoes_1'] = 34
        accessorySkin['shoes_2'] = 0
        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
        exports['mythic_notify']:DoHudText('error',  Config.Text.shoesoff)  
    end
    
end)			
    elseif data.name == "earring" then
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
                accessorySkin['ears_1'] = data.itemnum
                accessorySkin['ears_2'] = data.itemskin
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
elseif data.name == "decals" then
    TriggerEvent('skinchanger:getSkin', function(skin)

        if skin["decals_1"] == -1 then

        if Config.Options.enabled and IsPedInAnyVehicle(PlayerPedId(), true) == false then
            RequestAnimDict(Config.Options.dicton)
            while (not HasAnimDictLoaded(Config.Options.dicton)) do Citizen.Wait(0) end
            TaskPlayAnim(player, Config.Options.dicton, Config.Options.animon, 8.0, 1.0, -1, 0, 0.5, 0, 0)
            Wait(2000)
        end

        local accessorySkin = {}
        accessorySkin['decals_1']   = data.itemnum
        accessorySkin['decals_2']   = data.itemskin
        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin) 
        exports['mythic_notify']:DoHudText('success',  Config.Text.torsoon)             
    else

        if Config.Options.enabledoff and IsPedInAnyVehicle(PlayerPedId(), true) == false then
            RequestAnimDict(Config.Options.dictoff)
            while (not HasAnimDictLoaded(Config.Options.dictoff)) do Citizen.Wait(0) end
            TaskPlayAnim(player, Config.Options.dictoff, Config.Options.animoff, 8.0, 1.0, -1, 0, 0.3, 0, 0)
            Wait(2000)
        end

        local accessorySkin = {}
        accessorySkin['decals_1'] = -1
        accessorySkin['decals_2'] = 0
        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
        exports['mythic_notify']:DoHudText('error',  Config.Text.torsooff)      
    end
end)
elseif data.name == "chain" then
    TriggerEvent('skinchanger:getSkin', function(skin)

        if skin["chain_1"] == -1 then

        if Config.Options.enabled and IsPedInAnyVehicle(PlayerPedId(), true) == false then
            RequestAnimDict(Config.Options.dicton)
            while (not HasAnimDictLoaded(Config.Options.dicton)) do Citizen.Wait(0) end
            TaskPlayAnim(player, Config.Options.dicton, Config.Options.animon, 8.0, 1.0, -1, 0, 0.5, 0, 0)
            Wait(2000)
        end

        local accessorySkin = {}
        accessorySkin['chain_1']   = data.itemnum
        accessorySkin['chain_2']   = data.itemskin
        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin) 
        exports['mythic_notify']:DoHudText('success',  Config.Text.torsoon)             
    else

        if Config.Options.enabledoff and IsPedInAnyVehicle(PlayerPedId(), true) == false then
            RequestAnimDict(Config.Options.dictoff)
            while (not HasAnimDictLoaded(Config.Options.dictoff)) do Citizen.Wait(0) end
            TaskPlayAnim(player, Config.Options.dictoff, Config.Options.animoff, 8.0, 1.0, -1, 0, 0.3, 0, 0)
            Wait(2000)
        end

        local accessorySkin = {}
        accessorySkin['chain_1'] = -1
        accessorySkin['chain_2'] = 0
        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
        exports['mythic_notify']:DoHudText('error',  Config.Text.torsooff)      
    end
end)
elseif data.name == "bags" then
    TriggerEvent('skinchanger:getSkin', function(skin)

        if skin["bags_1"] == -1 then

        if Config.Options.enabled and IsPedInAnyVehicle(PlayerPedId(), true) == false then
            RequestAnimDict(Config.Options.dicton)
            while (not HasAnimDictLoaded(Config.Options.dicton)) do Citizen.Wait(0) end
            TaskPlayAnim(player, Config.Options.dicton, Config.Options.animon, 8.0, 1.0, -1, 0, 0.5, 0, 0)
            Wait(2000)
        end

        local accessorySkin = {}
        accessorySkin['bags_1']   = data.itemnum
        accessorySkin['bags_2']   = data.itemskin
        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin) 
        exports['mythic_notify']:DoHudText('success',  Config.Text.torsoon)             
    else

        if Config.Options.enabledoff and IsPedInAnyVehicle(PlayerPedId(), true) == false then
            RequestAnimDict(Config.Options.dictoff)
            while (not HasAnimDictLoaded(Config.Options.dictoff)) do Citizen.Wait(0) end
            TaskPlayAnim(player, Config.Options.dictoff, Config.Options.animoff, 8.0, 1.0, -1, 0, 0.3, 0, 0)
            Wait(2000)
        end

        local accessorySkin = {}
        accessorySkin['bags_1'] = -1
        accessorySkin['bags_2'] = 0
        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
        exports['mythic_notify']:DoHudText('error',  Config.Text.torsooff)      
    end
end)
end
end

-- function setHurt()
--     FreezeEntityPosition(GetPlayerPed(-1), true)
--     XenonBlock()
--     canmove = true
-- end

-- function setNotHurt()
--     FreezeEntityPosition(GetPlayerPed(-1), false)
--     canmove = false
-- end

-- function XenonBlock()
--     Citizen.CreateThread(function()
--         repeat  
--             Wait(5)       
--             DisableControlAction(0, Keys['F'], true)
--             DisableControlAction(0, Keys['LEFTSHIFT'], true)         
--         until canmove == false     
--     end)
-- end