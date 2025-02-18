local trunkData = nil
ESX = exports["es_extended"]:getSharedObject()

function openTrunkInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "trunk"
        }
    )

    SetNuiFocus(true, true)
end

RegisterNetEvent("Fxw_inventory:openTrunkInventory")
AddEventHandler("Fxw_inventory:openTrunkInventory", function(data, cash, blackMoney, inventory, weapons)
    setTrunkInventoryData(data, cash, blackMoney, inventory, weapons)
    openTrunkInventory()
end)

RegisterNetEvent("Fxw_inventory:refreshTrunkInventory")
AddEventHandler("Fxw_inventory:refreshTrunkInventory", function(data, cash, blackMoney, inventory, weapons)
    setTrunkInventoryData(data, cash, blackMoney, inventory, weapons)
end)

function setTrunkInventoryData(data, cash, blackMoney, inventory, weapons)
    trunkData = data

    SendNUIMessage(
        {
            action = "setInfoText",
			text = data.text,
			plate = data.plate
        }
    )

    items = {}

    if blackMoney > 0 then
        accountData = {
            label = "Dirty Money",
            count = blackMoney,
            type = "item_account",
            name = "black_money",
            usable = false,
            rare = false,
            limit = -1,
            canRemove = false
        }
        table.insert(items, accountData)
    end
    
    if cash > 0 then
        moneyData = {
            label = "Cash",
            name = "cash",
            type = "item_money",
            count = cash,
            usable = false,
            rare = false,
            limit = -1,
            canRemove = true
        }

        table.insert(items, moneyData)
    end

    if inventory ~= nil then
        for key, value in pairs(inventory) do
            if inventory[key].count <= 0 then
                inventory[key] = nil
            else
                if inventory[key].name ~= "black_money" then
                    inventory[key].type = "item_standard"
                    inventory[key].usable = false
                    inventory[key].rare = false
                    inventory[key].limit = -1
                    inventory[key].weight = false
                    inventory[key].canRemove = false
                    table.insert(items, inventory[key])
                end
            end
        end
    end

    if Config.IncludeWeapons and weapons ~= nil then
        for key, value in pairs(weapons) do
            local weaponHash = GetHashKey(weapons[key].name)
            local playerPed = PlayerPedId()
            if weapons[key].name ~= "WEAPON_UNARMED" then
                table.insert(
                    items,
                    {
						id = weapons[key].id,
                        label = weapons[key].label,
                        count = weapons[key].count,
                        limit = -1,
                        type = "item_weapon",
                        name = weapons[key].name,
                        usable = false,
                        rare = false,
                        canRemove = false
                    }
                )
            end
        end
    end

    SendNUIMessage({
        action = "setSecondInventoryItems",
        itemList = items,
        fastItems = fastItems,
        pWeight = data.weight,
        pWeightMax = data.max / 1000,
    })
end

RegisterNUICallback("PutIntoTrunk", function(data, cb)
    if IsPedSittingInAnyVehicle(playerPed) then
        return
    end
	

	if Config.BlacklistItemTrunk and Config.BlacklistItemTrunk[data.item.name] then
			-- exports.pNotify:SendNotification(
            --     {
			-- 		text = (Config.Text.Trunk),
            --         type = "error",
            --         timeout = 3000,
            --         layout = "bottomCenter",
            --         queue = "inventoryhud"
            --     }
            -- )
            TriggerEvent("mythic_notify:client:SendAlert",{
                text = 'ไม่สามารถเอาไอเท็มชิ้นนี้ใส่ท้ายรถได้ ',
                type = "error",
                timeout = 4000,
            })
	    return
    end

    if type(data.number) == "number" and math.floor(data.number) == data.number then
        local count = tonumber(data.number)
		
        if data.item.type == "item_weapon" then
            count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
        end
        -- TriggerServerEvent("meeta_carinventory:putItem", trunkData.plate, data.item.type, data.item.name, count, data.item.label, trunkData.max)

    end

    local player = GetPlayerPed(-1)
    local dict = "mp_am_hold_up"

    RequestAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
    
    TaskPlayAnim(player, dict, "purchase_beerbox_shopkeeper", 8.0, 2.0, -1, 48, 2, 0, 0, 0 )

    Wait(250)
    loadPlayerInventory()

    cb("ok")
end)


RegisterNUICallback("TakeFromTrunk", function(data, cb)
    if IsPedSittingInAnyVehicle(playerPed) then
        return
    end
	
    if type(data.number) == "number" and math.floor(data.number) == data.number then
        -- TriggerServerEvent("meeta_carinventory:getItem", trunkData.plate, data.item.type, data.item.name, tonumber(data.number), data.item.label, trunkData.max)
    end

    local player = GetPlayerPed(-1)
    local dict = "mp_am_hold_up"

    RequestAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end

    TaskPlayAnim(player, dict, "purchase_beerbox_shopkeeper", 8.0, 2.0, -1, 48, 2, 0, 0, 0 )

    Wait(250)
    loadPlayerInventory()

    cb("ok")
end)