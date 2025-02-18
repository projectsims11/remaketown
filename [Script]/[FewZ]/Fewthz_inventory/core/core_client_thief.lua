local targetPlayer
    
RegisterNetEvent("Fewthz_ThiefPlayer:openPlayerInventory")
AddEventHandler("Fewthz_ThiefPlayer:openPlayerInventory",function(target)
    targetPlayer = target
    setPlayerThiefInventoryData()
    openPlayerThiefInventory()
end)

function refreshPlayerThiefInventory()
    setPlayerThiefInventoryData()
end

function setPlayerThiefInventoryData()
    ESX.TriggerServerCallback("Fewthz_ThiefPlayer:getOtherPlayerData",function(data)
        SendNUIMessage({
            action = "setInfoText",
            text = "<strong>" .. "กระเป๋า" .. "</strong>> ID (" .. tostring(targetPlayer) ..")"
        })
        items = {}
        inventory = data.inventory
        accounts = data.accounts
        money = data.money
        weapons = data.weapons
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
                            weight = 0,
                            canRemove = canDrop
                        }
                        table.insert(items, accountData)
                    end
                end
            end
        end
        if inventory ~= nil then
            for key, value in pairs(inventory) do
                if inventory[key].count <= 0 then
                    inventory[key] = nil
                else
                    inventory[key].type = "item_standard"
                    table.insert(items, inventory[key])
                end
            end
        end
        if Config["IncludeWeapons"] and weapons ~= nil then
            for key, value in pairs(weapons) do
                local weaponHash = GetHashKey(weapons[key].name)
                local playerPed = PlayerPedId()
                if weapons[key].name ~= "WEAPON_UNARMED" then
                    local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
                    table.insert(items,{
                        label = weapons[key].label,
                        count = ammo,
                        weight = 0,
                        type = "item_weapon",
                        name = weapons[key].name,
                        usable = false,
                        rare = false,
                        canRemove = true
                    })
                end
            end
        end
        SendNUIMessage({
            action = "setSecondInventoryItems",
            itemList = items
        })
        end,targetPlayer)
    end

function openPlayerThiefInventory()
    loadPlayerInventoryFix()
    isInInventory = true
    SendNUIMessage(
        {
            action = "display",
            type = "thief"
        }
    )

    SetNuiFocus(true, true)
end


RegisterNUICallback("ThiefFromPlayer",function(data, cb)
    if IsPedSittingInAnyVehicle(PlayerPedId()) then
        return
    end
    if type(data.number) == "number" and math.floor(data.number) == data.number then
        local count = tonumber(data.number)
        if data.item.type == "item_weapon" then
            count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
        end
        TriggerServerEvent("Fewthz_ThiefPlayer:stealPlayerItem", targetPlayer, GetPlayerServerId(PlayerId()), data.item.type, data.item.name, count , 65656565892)
    end
    Wait(250)
    refreshPlayerThiefInventory()
    loadPlayerInventoryFix()
    cb("ok")
end)

RegisterNUICallback("PutIntoThief",function(data, cb)
    if IsPedSittingInAnyVehicle(PlayerPedId()) then
        return
    end

    if type(data.number) == "number" and math.floor(data.number) == data.number then
        local count = tonumber(data.number)
        if data.item.type == "item_weapon" then
            count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
        end
        
        TriggerServerEvent("Fewthz_ThiefPlayer:stealPlayerItem", GetPlayerServerId(PlayerId()), targetPlayer, data.item.type, data.item.name, count , 65656565892)

    end
    Wait(250)
    refreshPlayerThiefInventory()
    loadPlayerInventoryFix()
    cb("ok")
end)