_Cache_Inventory = {}
_Cache_Weapons = {}

Citizen.CreateThread(function()
	esxGetPlayerDataInit()
	CacheWeaponsInit()
end)

esxGetPlayerDataInit = function()
    while true do
        local at = ESX.GetPlayerData() or nil
        if at and at.inventory and #at.inventory > 0 then
            break
        end
        Wait(1)
    end
    local au = ESX.GetPlayerData().inventory
    for Y = 1, #au do
        local G = au[Y]
        _Cache_Inventory[G.name] = G
    end
    au = nil
end

CacheWeaponsInit = function()
    local av = ESX.GetWeaponList()
    local aw = av and #av or 0
    if aw > 0 then
        for Y = 1, aw do
            local G = av[Y]
            _Cache_Weapons[G.name] = G.label
        end
    end
end

getItemLabel = {
    ['item_account'] = function(az)
        return CT[az] or nil
    end, 

    ['item_standard'] = function(az)
        return _Cache_Inventory[az].label
    end, 
    
    ['item_weapon'] = function(az)
        return _Cache_Weapons[az] or nil
    end
}

RegisterNetEvent('FewZ_vault:openVaultInventory')
AddEventHandler('FewZ_vault:openVaultInventory',function(data)
    setVaultInventoryData(data)
    openVaultInventory()
end)

RegisterNetEvent('FewZ:UpdataVault')
AddEventHandler('FewZ:UpdataVault',function(data)
    setVaultInventoryData(data)
    openVaultInventory()
end)

local vaultType

function setVaultInventoryData(inventory)
    items = {}

    SendNUIMessage(
        {
            action = 'setInfoText',
            text = inventory.job
        }
    )

    local blackMoney = inventory.blackMoney
    local vaultItems = inventory.items
    local vaultWeapons = inventory.weapons
    vaultType = inventory.job
    if blackMoney ~= 0 then
        for k,v in pairs(blackMoney) do
            if v.name == 'black_money' then
                accountData = {
                    label = 'เงินแดง',
                    count = v.count,
                    type = 'item_account',
                    name = 'black_money',
                    usable = false,
                    rare = false,
                    weight = -1,
                    canRemove = false
                }
                table.insert(items, accountData)
            end
        end
    end

    for i = 1, #vaultItems, 1 do
        local item = vaultItems[i]
        if item.count > 0 then
            --item.label = item.name
            item.label = getItemLabel['item_standard'](item.name)
            item.type = 'item_standard'
            item.usable = false
            item.rare = false
            item.weight = -1
            item.canRemove = false
            table.insert(items, item)
        end
    end

    for i = 1, #vaultWeapons, 1 do
        local weapon = vaultWeapons[i]

        if vaultWeapons[i].name ~= 'WEAPON_UNARMED' then
            table.insert(
                items,
                {
                    label = ESX.GetWeaponLabel(weapon.name),
                    count = weapon.ammo or weapon.count,
                    weight = -1,
                    type = 'item_weapon',
                    name = weapon.name,
                    usable = false,
                    rare = false,
                    canRemove = false
                }
            )
        end
    end

    SendNUIMessage(
        {
            action = 'setSecondInventoryItems',
            itemList = items
        }
    )
end

function openVaultInventory()
    loadPlayerInventoryFix()
    isInInventory = true

    SendNUIMessage(
        {
            action = 'display',
            type = 'vault'
        }
    )


    SetNuiFocus(true, true)
end

local Deley = false
RegisterNUICallback(
    'PutIntoVault',
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end
        if type(data.number) == 'number' and math.floor(data.number) == data.number then
            local count = 0
            if data.item.type == 'item_weapon' then
                if not Deley then
                    Deley = true
                    count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
                    TriggerServerEvent('FewZ_vault:putItem', vaultType, data.item.type, data.item.name, count)
                    ESX.SetTimeout(2*1000,function()
                        Deley = false
                    end)
                else
                    exports.pNotify:SendNotification(
                    {
                        text = 'กรุณารอเวลา',
                        type = 'error',
                        timeout = 3000,
                        layout = 'bottomCenter',
                        queue = 'inventoryhud'
                    })
                end
            else
                if data.number > data.item.count or data.number == 0 then
                    count = tonumber(data.item.count)
                else
                    count = tonumber(data.number)
                end
				TriggerServerEvent('FewZ_vault:putItem', vaultType, data.item.type, data.item.name, count)
            end
        end
        loadPlayerInventoryFix()
    cb('ok')
end)


RegisterNUICallback(
    'TakeFromVault',
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end
		
        if type(data.number) == 'number' and math.floor(data.number) == data.number then
            local count = 0
            if data.item.type == 'item_weapon' then
                if not Deley then
                    Deley = true
                    count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
                    TriggerServerEvent('FewZ_vault:getItem', vaultType, data.item.type, data.item.name, count)
                    ESX.SetTimeout(2*1000,function()
                        Deley = false
                    end)
                else
                    exports.pNotify:SendNotification(
                    {
                        text = 'กรุณารอเวลา',
                        type = 'error',
                        timeout = 3000,
                        layout = 'bottomCenter',
                        queue = 'inventoryhud'
                    })
                end
            else
                if data.number > data.item.count or data.number == 0 then
                    count = tonumber(data.item.count)
                else
                    count = tonumber(data.number)
                end
                TriggerServerEvent('FewZ_vault:getItem', vaultType, data.item.type, data.item.name, count)
            end
        end
        loadPlayerInventoryFix()
    cb('ok')
end)