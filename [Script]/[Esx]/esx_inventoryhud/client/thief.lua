local targetPlayer
ESX = exports["es_extended"]:getSharedObject()


RegisterNetEvent("Thiefplayer_GpG:openPlayerInventory")
AddEventHandler("Thiefplayer_GpG:openPlayerInventory",function(target)
    targetPlayer = target
    setPlayerThiefInventoryData()
    openPlayerThiefInventory()
end)

function refreshPlayerThiefInventory()
    setPlayerThiefInventoryData()
    loadPlayerInventory()
end

function setPlayerThiefInventoryData()
        ESX.TriggerServerCallback(
    "Fxw_inventory:PoliceSearch",
    function(data)
        SendNUIMessage(
            {
                action = "setInfoText",
                text = "<strong>" 
            }
        )

        items = {}
        inventory = data.inventory
        accounts = data.accounts
        money = data.money
        weapons = data.weapons

        if Config["IncludeCash"] and money ~= nil and money > 0 then
            for key, value in pairs(accounts) do
                moneyData = {
                    label = "Cash",
                    name = "cash",
                    type = "item_money",
                    count = money,
                    usable = false,
                    rare = false,
                    limit = -1,
                    canRemove = true
                }

                table.insert(items, moneyData)
            end
        end

        if Config["IncludeAccounts"] and accounts ~= nil then
            for key, value in pairs(accounts) do
                if not INVENTORY_ACCOUNT_SKIP(accounts[key].name) then
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

        if Config["ThifePlayerFunction"] then

            if ESX.GetPlayerData().job.name == 'police' then
                if Config["IncludeWeapons"] and weapons ~= nil then
                    for key, value in pairs(weapons) do
                        local weaponHash = GetHashKey(weapons[key].name)
                        local playerPed = PlayerPedId()
                        if weapons[key].name ~= "WEAPON_UNARMED" then
                            local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
                            table.insert(
                                items,
                                {
                                    label = weapons[key].label,
                                    count = ammo,
                                    limit = -1,
                                    type = "item_weapon",
                                    name = weapons[key].name,
                                    usable = false,
                                    rare = false,
                                    canRemove = true
                                }
                            )
                        end
                    end
                end
            end
        else
            if Config["IncludeWeapons"] and weapons ~= nil then
                for key, value in pairs(weapons) do
                    local weaponHash = GetHashKey(weapons[key].name)
                    local playerPed = PlayerPedId()
                    if weapons[key].name ~= "WEAPON_UNARMED" then
                        local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
                        table.insert(
                            items,
                            {
                                label = weapons[key].label,
                                count = ammo,
                                limit = -1,
                                type = "item_weapon",
                                name = weapons[key].name,
                                usable = false,
                                rare = false,
                                canRemove = true
                            }
                        )
                    end
                end
            end
        end

        SendNUIMessage(
            {
                action = "setSecondInventoryItems",
                itemList = items
            }
        )
    end,
    targetPlayer --GetPlayerServerId(PlayerId())
)
end


function openPlayerThiefInventory()
    loadPlayerInventory()
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
        TriggerServerEvent("ThiefPlayer_GpG:stealPlayerItem", targetPlayer, GetPlayerServerId(PlayerId()), data.item.type, data.item.name, count , 65656565892)
    end
    Wait(250)
    refreshPlayerThiefInventory()
    loadPlayerInventory()
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
        
        TriggerServerEvent("ThiefPlayer_GpG:stealPlayerItem", GetPlayerServerId(PlayerId()), targetPlayer, data.item.type, data.item.name, count , 65656565892)

    end
    Wait(250)
    refreshPlayerThiefInventory()
    loadPlayerInventory()
    cb("ok")
end)