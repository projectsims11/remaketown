ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

RegisterServerEvent('FewZ_vault:getItem')
AddEventHandler('FewZ_vault:getItem', function(job, type, item, count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayerOwner = ESX.GetPlayerFromIdentifier(xPlayer.identifier)
    if type == 'item_standard' then

        local sourceItem = xPlayer.getInventoryItem(item)

        if xPlayer.job.name == job then
            for k, v in pairs(Config.Vault) do
                if k == job then
                    local Checkgrade = false
                    if v.CheckGrade and xPlayer.job.grade >= v.JobGrade then
                        Checkgrade = true
                    else
                        if not v.CheckGrade then
                            Checkgrade = true
                        end 
                    end

                    if Checkgrade then
                        if Config.Setiing.ESX then
                            if xPlayer.canCarryItem(item, count) then
                                TriggerEvent('FewZ_vault:getSharedInventory', 'society_' .. job, function(store)
                                    local coffre = (store.get("item") or {})
                                    for i = 1, #coffre, 1 do
                                        if coffre[i].name == item then
                                            if (coffre[i].count >= count and count > 0) then
                                                xPlayer.addInventoryItem(item, count)
                                                if (coffre[i].count - count) == 0 then
                                                    table.remove(coffre, i)
                                                else
                                                    coffre[i].count = coffre[i].count - count
                                                end
                                                break
                                            else
                                                TriggerClientEvent("pNotify:SendNotification", _source, {
                                                    text = "จำนวนผิดพลาด",
                                                    type = "error",
                                                    queue = "trunk",
                                                    timeout = 3000,
                                                    layout = "bottomCenter"
                                                })
                                            end
                                        end
                                    end
                                    store.set("item", coffre)
                                    TriggerEvent('FewZ:Updata', job, xPlayer)
                                    sendToDiscord((Config_Webhook["Job"].Take.item.Title),
                                        xPlayer.name .. "  " .. ("\nID Steam :") .. " " .. xPlayer.identifier .. "  " ..
                                            (Config_Webhook["Job"].Take.item.t1) .. "   " .. sourceItem.label .. "   " ..
                                            (Config_Webhook["Job"].Take.item.t2) .. "   " .. count .. "   " ..
                                            (Config_Webhook["Job"].Take.item.t3) .. " " ..
                                            (Config_Webhook["Job"].Take.item.t4) .. "  " .. xPlayer.job.name .. " " ..
                                            (Config_Webhook["Job"].Take.item.t5) .. " ", "16711680",
                                        Config_Webhook["Job"].Take.item.webhook)
                                end)
                            else
                                TriggerClientEvent("pNotify:SendNotification", _source, {
                                    text = "Item เกิน / Weight เกิน",
                                    type = "error",
                                    queue = "trunk",
                                    timeout = 3000,
                                    layout = "bottomCenter"
                                })
                            end
                        else
                            local ItemMustUse = xPlayer.getInventoryItem(item)
                            local ItemMustUseCount = count
                            if ItemMustUse.limit ~= -1 and (ItemMustUse.count + ItemMustUseCount) > ItemMustUse.limit then
                                TriggerClientEvent('esx:showNotification', xPlayer.source, 'Inventory ~r~Full')
                            else
                                TriggerEvent('FewZ_vault:getSharedInventory', 'society_' .. job, function(store)
                                    local coffre = (store.get("item") or {})
                                    for i = 1, #coffre, 1 do
                                        if coffre[i].name == item then
                                            if (coffre[i].count >= count and count > 0) then
                                                xPlayer.addInventoryItem(item, count)
                                                if (coffre[i].count - count) == 0 then
                                                    table.remove(coffre, i)
                                                else
                                                    coffre[i].count = coffre[i].count - count
                                                end
                                                break
                                            else
                                                TriggerClientEvent("pNotify:SendNotification", _source, {
                                                    text = "จำนวนผิดพลาด",
                                                    type = "error",
                                                    queue = "trunk",
                                                    timeout = 3000,
                                                    layout = "bottomCenter"
                                                })
                                            end
                                        end
                                    end
                                    store.set("item", coffre)
                                    TriggerEvent('FewZ:Updata', job, xPlayer)
                                    sendToDiscord((Config_Webhook["Job"].Take.item.Title),
                                        xPlayer.name .. "  " .. ("\nID Steam :") .. " " .. xPlayer.identifier .. "  " ..
                                            (Config_Webhook["Job"].Take.item.t1) .. "   " .. ItemMustUse.label .. "   " ..
                                            (Config_Webhook["Job"].Take.item.t2) .. "   " .. count .. "   " ..
                                            (Config_Webhook["Job"].Take.item.t3) .. " " ..
                                            (Config_Webhook["Job"].Take.item.t4) .. "  " .. xPlayer.job.name .. " " ..
                                            (Config_Webhook["Job"].Take.item.t5) .. " ", "16711680",
                                        Config_Webhook["Job"].Take.item.webhook)
                                end)
                            end
                        end
                    else
                    	TriggerClientEvent("pNotify:SendNotification", source, {type = 'error', text = 'ตำแหน่งของท่านไม่สามารถนำสิ่งของออกได้', length = 5500})
                    end
                end
            end
        elseif job == 'vault' then
            if Config.Setiing.ESX then
                if xPlayer.canCarryItem(item, count) then
                    TriggerEvent('FewZ_vault:getInventory', 'vault', xPlayerOwner.identifier, function(store)
                        local coffre = (store.get("item") or {})
                        for i = 1, #coffre, 1 do
                            if coffre[i].name == item then
                                if (coffre[i].count >= count and count > 0) then
                                    xPlayer.addInventoryItem(item, count)
                                    if (coffre[i].count - count) == 0 then
                                        table.remove(coffre, i)
                                    else
                                        coffre[i].count = coffre[i].count - count
                                    end
                                    break
                                else
                                    TriggerClientEvent("pNotify:SendNotification", _source, {
                                        text = "จำนวนผิดพลาด",
                                        type = "error",
                                        queue = "trunk",
                                        timeout = 3000,
                                        layout = "bottomCenter"
                                    })
                                end
                            end
                        end
                        store.set("item", coffre)
                        TriggerEvent('FewZ:Updata', job, xPlayer)
                        sendToDiscord((Config_Webhook["Vault"].Take.item.Title),
                            xPlayer.name .. "  " .. ("\nID Steam :") .. " " .. xPlayer.identifier .. "  " ..
                                (Config_Webhook["Vault"].Take.item.t1) .. "   " .. sourceItem.label .. "   " ..
                                (Config_Webhook["Vault"].Take.item.t2) .. "   " .. count .. "   " ..
                                (Config_Webhook["Vault"].Take.item.t3) .. " " .. (Config_Webhook["Vault"].Take.item.t4) ..
                                "  " .. xPlayer.job.name .. " " .. (Config_Webhook["Vault"].Take.item.t5) .. " ",
                            "16711680", Config_Webhook["Vault"].Take.item.webhook)
                    end)
                else
                    TriggerClientEvent("pNotify:SendNotification", _source, {
                        text = "Item เกิน / Weight เกิน",
                        type = "error",
                        queue = "trunk",
                        timeout = 3000,
                        layout = "bottomCenter"
                    })
                end
            else
                local ItemMustUse = xPlayer.getInventoryItem(item)
                local ItemMustUseCount = count
                if ItemMustUse.limit ~= -1 and (ItemMustUse.count + ItemMustUseCount) > ItemMustUse.limit then
                    TriggerClientEvent('esx:showNotification', xPlayer.source, 'Inventory ~r~Full')
                else
                    TriggerEvent('FewZ_vault:getInventory', 'vault', xPlayerOwner.identifier, function(store)
                        local coffre = (store.get("item") or {})
                        for i = 1, #coffre, 1 do
                            if coffre[i].name == item then
                                if (coffre[i].count >= count and count > 0) then
                                    xPlayer.addInventoryItem(item, count)
                                    if (coffre[i].count - count) == 0 then
                                        table.remove(coffre, i)
                                    else
                                        coffre[i].count = coffre[i].count - count
                                    end
                                    break
                                else
                                    TriggerClientEvent("pNotify:SendNotification", _source, {
                                        text = "จำนวนผิดพลาด",
                                        type = "error",
                                        queue = "trunk",
                                        timeout = 3000,
                                        layout = "bottomCenter"
                                    })
                                end
                            end
                        end
                        store.set("item", coffre)
                        TriggerEvent('FewZ:Updata', job, xPlayer)
                        sendToDiscord((Config_Webhook["Vault"].Take.item.Title),
                            xPlayer.name .. "  " .. ("\nID Steam :") .. " " .. xPlayer.identifier .. "  " ..
                                (Config_Webhook["Vault"].Take.item.t1) .. "   " .. ItemMustUse.label .. "   " ..
                                (Config_Webhook["Vault"].Take.item.t2) .. "   " .. count .. "   " ..
                                (Config_Webhook["Vault"].Take.item.t3) .. " " .. (Config_Webhook["Vault"].Take.item.t4) ..
                                "  " .. xPlayer.job.name .. " " .. (Config_Webhook["Vault"].Take.item.t5) .. " ",
                            "16711680", Config_Webhook["Vault"].Take.item.webhook)
                    end)
                end
            end
        end
    elseif type == 'item_account' then
        if xPlayer.job.name == job then
            for k, v in pairs(Config.Vault) do
                if k == job then
                    local Checkgrade = false
                    if v.CheckGrade and xPlayer.job.grade >= v.JobGrade then
                        Checkgrade = true
                    else
                        if not v.CheckGrade then
                            Checkgrade = true
                        end 
                    end
                    if Checkgrade then
                        TriggerEvent('FewZ_vault:getSharedInventory', 'society_' .. job, function(store)
                            local coffre = (store.get("account") or {})
                            for i = 1, #coffre, 1 do
                                if coffre[i].name == item then
                                    if (coffre[i].count >= count and count > 0) then
                                        xPlayer.addAccountMoney(item, count)
                                        if (coffre[i].count - count) == 0 then
                                            table.remove(coffre, i)
                                        else
                                            coffre[i].count = coffre[i].count - count
                                        end
                                        break
                                    else
                                        TriggerClientEvent("pNotify:SendNotification", _source, {
                                            text = "จำนวนผิดพลาด",
                                            type = "error",
                                            queue = "trunk",
                                            timeout = 3000,
                                            layout = "bottomCenter"
                                        })
                                    end
                                end
                            end
                            store.set("account", coffre)
                            TriggerEvent('FewZ:Updata', job, xPlayer)
                            sendToDiscord((Config_Webhook["Job"].Take.Account.Title),
                                xPlayer.name .. "  " .. ("\nID Steam :") .. " " .. xPlayer.identifier .. "  " ..
                                    (Config_Webhook["Job"].Take.Account.t1) .. "   " .. item .. "   " ..
                                    (Config_Webhook["Job"].Take.Account.t2) .. "   " .. count .. "   " .. "บาท" .. " " ..
                                    (Config_Webhook["Job"].Take.Account.t4) .. "  " .. xPlayer.job.name .. " " ..
                                    (Config_Webhook["Job"].Take.Account.t5) .. " ", "16711680",
                                Config_Webhook["Job"].Take.Account.webhook)
                        end)
                    else
                    	TriggerClientEvent("pNotify:SendNotification", source, {type = 'error', text = 'ตำแหน่งของท่านไม่สามารถนำสิ่งของออกได้', length = 5500})
                    end
                end
            end
        elseif job == 'vault' then
            TriggerEvent('FewZ_vault:getInventory', 'vault', xPlayerOwner.identifier, function(store)
                local coffre = (store.get("account") or {})
                for i = 1, #coffre, 1 do
                    if coffre[i].name == item then
                        if (coffre[i].count >= count and count > 0) then
                            xPlayer.addAccountMoney(item, count)
                            if (coffre[i].count - count) == 0 then
                                table.remove(coffre, i)
                            else
                                coffre[i].count = coffre[i].count - count
                            end
                            break
                        else
                            TriggerClientEvent("pNotify:SendNotification", _source, {
                                text = "จำนวนผิดพลาด",
                                type = "error",
                                queue = "trunk",
                                timeout = 3000,
                                layout = "bottomCenter"
                            })
                        end
                    end
                end
                store.set("account", coffre)
                TriggerEvent('FewZ:Updata', job, xPlayer)
                sendToDiscord((Config_Webhook["Vault"].Take.item.Title),
                    xPlayer.name .. "  " .. ("\nID Steam :") .. " " .. xPlayer.identifier .. "  " ..
                        (Config_Webhook["Vault"].Take.item.t1) .. "   " .. item .. "   " ..
                        (Config_Webhook["Vault"].Take.item.t2) .. "   " .. count .. "   " .. "บาท" .. " " ..
                        (Config_Webhook["Vault"].Take.item.t4) .. "  " .. xPlayer.job.name .. " " ..
                        (Config_Webhook["Vault"].Take.item.t5) .. " ", "16711680",
                    Config_Webhook["Vault"].Take.item.webhook)
            end)
        else
            TriggerClientEvent("pNotify:SendNotification", source, {
                type = 'error',
                text = "You not have permission",
                length = 5500
            })
        end
    elseif type == 'item_weapon' then
        if xPlayer.job.name == job then
            for k, v in pairs(Config.Vault) do
                if k == job then
                    local Checkgrade = false
                    if v.CheckGrade and xPlayer.job.grade >= v.JobGrade then
                        Checkgrade = true
                    else
                        if not v.CheckGrade then
                            Checkgrade = true
                        end 
                    end
                    if Checkgrade then
                        TriggerEvent('FewZ_vault:getSharedInventory', 'society_' .. job, function(store)
                            local storeWeapons = store.get('weapondata') or {}
                            local weaponName = nil
                            local ammo = nil

                            for i = 1, #storeWeapons, 1 do
                                if storeWeapons[i].name == item then
                                    weaponName = storeWeapons[i].name
                                    ammo = storeWeapons[i].ammo
                                    table.remove(storeWeapons, i)
                                    break
                                end
                            end

                            store.set('weapondata', storeWeapons)
                            xPlayer.addWeapon(weaponName, 0)
                            xPlayer.addWeaponAmmo(weaponName,ammo)
                            TriggerEvent('FewZ:Updata', job, xPlayer)
                            sendToDiscord((Config_Webhook["Job"].Take.weapon.Title),
                                xPlayer.name .. "  " .. ("\nID Steam :") .. " " .. xPlayer.identifier .. "  " ..
                                    (Config_Webhook["Job"].Take.weapon.t1) .. "   " .. weaponName .. "   " ..
                                    (Config_Webhook["Job"].Take.weapon.t2) .. "   " .. ammo .. "   " ..
                                    (Config_Webhook["Job"].Take.weapon.t3) .. " " .. (Config_Webhook["Job"].Take.item.t4) ..
                                    "  " .. xPlayer.job.name .. " " .. (Config_Webhook["Job"].Take.item.t5) .. " ",
                                "16711680", Config_Webhook["Job"].Take.weapon.webhook)
                        end)
                    else
                        TriggerClientEvent("pNotify:SendNotification", source, {type = 'error', text = 'ตำแหน่งของท่านไม่สามารถนำสิ่งของออกได้', length = 5500})
                    end
                end
            end
        elseif job == 'vault' then
            TriggerEvent('FewZ_vault:getInventory', 'vault', xPlayerOwner.identifier, function(store)
                local storeWeapons = store.get('weapondata') or {}
                local weaponName = nil
                local ammo = nil

                for i = 1, #storeWeapons, 1 do
                    if storeWeapons[i].name == item then
                        weaponName = storeWeapons[i].name
                        ammo = storeWeapons[i].ammo

                        table.remove(storeWeapons, i)
                        break
                    end
                end

                store.set('weapondata', storeWeapons)
                xPlayer.addWeapon(weaponName, 0)
                xPlayer.addWeaponAmmo(weaponName,ammo)
                TriggerEvent('FewZ:Updata', job, xPlayer)
                sendToDiscord((Config_Webhook["Vault"].Take.weapon.Title),
                    xPlayer.name .. "  " .. ("\nID Steam :") .. " " .. xPlayer.identifier .. "  " ..
                        (Config_Webhook["Vault"].Take.weapon.t1) .. "   " .. weaponName .. "   " ..
                        (Config_Webhook["Vault"].Take.weapon.t2) .. "   " .. ammo .. "   " ..
                        (Config_Webhook["Vault"].Take.weapon.t3) .. " " .. (Config_Webhook["Vault"].Take.item.t4) ..
                        "  " .. xPlayer.job.name .. " " .. (Config_Webhook["Vault"].Take.item.t5) .. " ", "16711680",
                    Config_Webhook["Vault"].Take.weapon.webhook)
            end)
        else
            TriggerClientEvent("pNotify:SendNotification", source, {
                type = 'error',
                text = 'You not have permission',
                length = 5500
            })
        end
    end

end)

RegisterServerEvent('FewZ_vault:putItem')
AddEventHandler('FewZ_vault:putItem', function(job, type, item, count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayerOwner = ESX.GetPlayerFromIdentifier(xPlayer.identifier)
    if type == 'item_standard' then
        local xItem = xPlayer.getInventoryItem(item)
        local playerItemCount = xPlayer.getInventoryItem(item).count
        if Config.BlackListItemAll and Config.BlackListItemAll[item] then
            TriggerClientEvent("pNotify:SendNotification", source, {
                type = "error",
                text = 'BlackListITEM',
                length = 5500
            })
        else
            if playerItemCount >= count and count > 0 then
                if xPlayer.job.name == job then
                    if Config.BlackListItemSociety and Config.BlackListItemSociety[item] then
                        TriggerClientEvent("pNotify:SendNotification", source, {
                            type = "error",
                            text = 'BlackListITEM',
                            length = 5500
                        })
                    else
                        TriggerEvent('FewZ_vault:getSharedInventory', 'society_' .. job, function(store)
                            local found = false
                            local coffre = (store.get("item") or {})

                            for i = 1, #coffre, 1 do
                                if coffre[i].name == item then
                                    coffre[i].count = coffre[i].count + count
                                    found = true
                                end
                            end
                            if not found then
                                table.insert(coffre, {
                                    name = item,
                                    count = count
                                })
                            end
                            xPlayer.removeInventoryItem(item, count)
                            store.set('item', coffre)
                            TriggerEvent('FewZ:Updata', job, xPlayer)
                            sendToDiscord((Config_Webhook["Job"].Put.item.Title),
                                xPlayer.name .. "  " .. ("\nID Steam :") .. " " .. xPlayer.identifier .. "  " ..
                                    (Config_Webhook["Job"].Put.item.t1) .. "   " .. xItem.label .. "   " ..
                                    (Config_Webhook["Job"].Put.item.t2) .. "   " .. count .. "   " ..
                                    (Config_Webhook["Job"].Put.item.t3) .. " " .. (Config_Webhook["Job"].Put.item.t4) ..
                                    "  " .. xPlayer.job.name .. " " .. (Config_Webhook["Job"].Put.item.t5) .. " ",
                                "56108", Config_Webhook["Job"].Put.item.webhook)
                        end)
                    end
                elseif job == 'vault' then
                    if Config.BlackListItemVault and Config.BlackListItemVault[item] then
                        TriggerClientEvent("pNotify:SendNotification", source, {
                            type = "error",
                            text = 'BlackListITEM',
                            length = 5500
                        })
                    else
                        TriggerEvent('FewZ_vault:getInventory', 'vault', xPlayerOwner.identifier, function(store)
                            local found = false
                            local coffre = (store.get("item") or {})

                            for i = 1, #coffre, 1 do
                                if coffre[i].name == item then
                                    coffre[i].count = coffre[i].count + count
                                    found = true
                                end
                            end
                            if not found then
                                table.insert(coffre, {
                                    name = item,
                                    count = count
                                })
                            end
                            xPlayer.removeInventoryItem(item, count)
                            store.set('item', coffre)
                            TriggerEvent('FewZ:Updata', job, xPlayer)
                            sendToDiscord((Config_Webhook["Vault"].Put.item.Title),
                                xPlayer.name .. "  " .. ("\nID Steam :") .. " " .. xPlayer.identifier .. "  " ..
                                    (Config_Webhook["Vault"].Put.item.t1) .. "   " .. xItem.label .. "   " ..
                                    (Config_Webhook["Vault"].Put.item.t2) .. "   " .. count .. "   " ..
                                    (Config_Webhook["Vault"].Put.item.t3) .. " " ..
                                    (Config_Webhook["Vault"].Put.item.t4) .. "  " .. xPlayer.job.name .. " " ..
                                    (Config_Webhook["Vault"].Put.item.t5) .. " ", "56108",
                                Config_Webhook["Vault"].Put.item.webhook)
                        end)
                    end
                else
                    TriggerClientEvent("pNotify:SendNotification", source, {
                        type = "error",
                        text = 'You not have permission for this job!',
                        length = 5500
                    })
                end
            else
                TriggerClientEvent("pNotify:SendNotification", source, {
                    type = "error",
                    text = 'invalid quantity',
                    length = 5500
                })
            end
        end
    elseif type == 'item_account' then

        local playerAccountMoney = xPlayer.getAccount(item).money

        if playerAccountMoney >= count and count > 0 then
            xPlayer.removeAccountMoney(item, count)
            if xPlayer.job.name == job --[[and job == 'police']] then
            print(xPlayer.job.name,job)
                TriggerEvent('FewZ_vault:getSharedInventory', 'society_' .. job, function(store)
                    local found = false
                    local coffre = (store.get("account") or {})

                    for i = 1, #coffre, 1 do
                        if coffre[i].name == item then
                            coffre[i].count = coffre[i].count + count
                            found = true
                        end
                    end
                    if not found then
                        table.insert(coffre, {
                            name = item,
                            count = count
                        })
                    end
                    store.set('account', coffre)
                    TriggerEvent('FewZ:Updata', job, xPlayer)
                    sendToDiscord((Config_Webhook["Job"].Put.Account.Title),
                        xPlayer.name .. "  " .. ("\nID Steam :") .. " " .. xPlayer.identifier .. "  " ..
                            (Config_Webhook["Job"].Put.Account.t1) .. "   " .. item .. "   " ..
                            (Config_Webhook["Job"].Put.Account.t2) .. "   " .. count .. "   " .. "บาท" .. " " ..
                            (Config_Webhook["Job"].Put.Account.t4) .. "  " .. xPlayer.job.name .. " " ..
                            (Config_Webhook["Job"].Put.Account.t5) .. " ", "56108",
                        Config_Webhook["Job"].Put.Account.webhook)
                end)
            elseif job == 'vault' then
                TriggerEvent('FewZ_vault:getInventory', 'vault', xPlayerOwner.identifier, function(store)
                    local found = false
                    local coffre = (store.get("account") or {})

                    for i = 1, #coffre, 1 do
                        if coffre[i].name == item then
                            coffre[i].count = coffre[i].count + count
                            found = true
                        end
                    end
                    if not found then
                        table.insert(coffre, {
                            name = item,
                            count = count
                        })
                    end

                    store.set('account', coffre)
                    TriggerEvent('FewZ:Updata', job, xPlayer)
                    sendToDiscord((Config_Webhook["Vault"].Put.item.Title),
                        xPlayer.name .. "  " .. ("\nID Steam :") .. " " .. xPlayer.identifier .. "  " ..
                            (Config_Webhook["Vault"].Put.item.t1) .. "   " .. item .. "   " ..
                            (Config_Webhook["Vault"].Put.item.t2) .. "   " .. count .. "   " .. "บาท" .. " " ..
                            (Config_Webhook["Vault"].Put.item.t4) .. "  " .. xPlayer.job.name .. " " ..
                            (Config_Webhook["Vault"].Put.item.t5) .. " ", "56108",
                        Config_Webhook["Vault"].Put.item.webhook)
                end)
            else
                TriggerClientEvent("pNotify:SendNotification", source, {
                    type = 'error',
                    text = 'This job not allow for black money',
                    length = 5500
                })
            end

        else
            TriggerClientEvent("pNotify:SendNotification", source, {
                type = 'error',
                text = 'amount_invalid',
                length = 5500
            })
        end

    elseif type == 'item_weapon' then
        if xPlayer.job.name == job then
            TriggerEvent('FewZ_vault:getSharedInventory', 'society_' .. job, function(store)
                local storeWeapons = store.get('weapondata') or {}
                -- print(ESX.DumpTable(storeWeapons))
                table.insert(storeWeapons, {
                    name = item,
                    ammo = count
                })

                xPlayer.removeWeapon(item, ammo)
                store.set('weapondata', storeWeapons)
                TriggerEvent('FewZ:Updata', job, xPlayer)
                sendToDiscord((Config_Webhook["Job"].Put.weapon.Title),
                    xPlayer.name .. "  " .. ("\nID Steam :") .. " " .. xPlayer.identifier .. "  " ..
                        (Config_Webhook["Job"].Put.weapon.t1) .. "   " .. item .. "   " ..
                        (Config_Webhook["Job"].Put.weapon.t2) .. "   " .. tostring(ammo) .. "   " ..
                        (Config_Webhook["Job"].Put.weapon.t3) .. " " .. (Config_Webhook["Job"].Put.item.t4) .. "  " ..
                        xPlayer.job.name .. " " .. (Config_Webhook["Job"].Put.item.t5) .. " ", "56108",
                    Config_Webhook["Job"].Put.weapon.webhook)
            end)
        elseif job == 'vault' then
            TriggerEvent('FewZ_vault:getInventory', 'vault', xPlayerOwner.identifier, function(store)
                local storeWeapons = store.get('weapondata') or {}

                table.insert(storeWeapons, {
                    name = item,
                    ammo = count
                })

                xPlayer.removeWeapon(item, ammo)
                store.set('weapondata', storeWeapons)
                TriggerEvent('FewZ:Updata', job, xPlayer)
                sendToDiscord((Config_Webhook["Vault"].Put.weapon.Title),
                    xPlayer.name .. "  " .. ("\nID Steam :") .. " " .. xPlayer.identifier .. "  " ..
                        (Config_Webhook["Vault"].Put.weapon.t1) .. "   " .. item .. "   " ..
                        (Config_Webhook["Vault"].Put.weapon.t2) .. "   " .. tostring(ammo) .. "   " ..
                        (Config_Webhook["Vault"].Put.weapon.t3) .. " " .. (Config_Webhook["Vault"].Put.item.t4) .. "  " ..
                        xPlayer.job.name .. " " .. (Config_Webhook["Vault"].Put.item.t5) .. " ", "56108",
                    Config_Webhook["Vault"].Put.weapon.webhook)
            end)
        else
            TriggerClientEvent("pNotify:SendNotification", source, {
                type = 'error',
                text = 'You not have permission',
                length = 5500
            })
        end
    end
end)

RegisterServerEvent('FewZ:RemoveMoney')
AddEventHandler('FewZ:RemoveMoney', function(moneyplayer, data, text)
    local xPlayer = ESX.GetPlayerFromId(source)
    if Config.Server then
        if xPlayer.getMoney() >= moneyplayer then
            xPlayer.removeMoney(moneyplayer)
            TriggerEvent('FewZ:Updata', data, xPlayer)
            TriggerClientEvent(text, source, {
                text = 'หักค่าบริการจำนวน ' .. moneyplayer .. ' บาท',
                type = "error",
                timeout = 7000,
                layout = "bottomCenter",
                queue = "global"
            })
        else
            TriggerClientEvent(text, source, {
                text = 'เงินของท่านไม่เพียงพอ',
                type = "error",
                timeout = 7000,
                layout = "bottomCenter",
                queue = "global"
            })
        end
    else
        if xPlayer.getMoney() >= moneyplayer then
            xPlayer.removeMoney(moneyplayer)
            TriggerEvent('FewZ:Updata', data, xPlayer)
            TriggerClientEvent(text, source, {
                text = 'หักค่าบริการจำนวน ' .. moneyplayer .. ' บาท',
                type = "error",
                timeout = 7000,
                layout = "bottomCenter",
                queue = "global"
            })
        else
            TriggerClientEvent(text, source, {
                text = 'เงินของท่านไม่เพียงพอ',
                type = "error",
                timeout = 7000,
                layout = "bottomCenter",
                queue = "global"
            })
        end
    end
end)

RegisterServerEvent('FewZ:OpenVault')
AddEventHandler('FewZ:OpenVault', function(job)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerEvent('FewZ:Updata', job, xPlayer)
end)

RegisterServerEvent('FewZ:Updata')
AddEventHandler('FewZ:Updata', function(job, jobplayer)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local blackMoney = 0
    local items = {}
    local weapons = {}
    local typeVault = ''
    local society = false
    if string.find(job, "vault") then
        typeVault = job
    else
        typeVault = "society_" .. job
        society = true
    end

    if society then
        TriggerEvent('FewZ_vault:getSharedInventory', typeVault, function(inventory)
            items = inventory.get('item') or {}
            weapons = inventory.get('weapondata') or {}
            --if job == 'police' then
                blackMoney = inventory.get('account') or 0
            --else
               -- blackMoney = 0
            --end
        end)
        local refreshVault = {
            blackMoney = blackMoney,
            items = items,
            weapons = weapons,
            job = job
        }
        TriggerClientEvent('FewZ:UpdataVault', jobplayer.source, refreshVault)
    else
        TriggerEvent('FewZ_vault:getInventory', typeVault, jobplayer.identifier, function(inventory)
            items = inventory.get('item') or {}
            blackMoney = inventory.get('account') or 0
            weapons = inventory.get('weapondata') or {}
        end)
        local refreshVault = {
            blackMoney = blackMoney,
            items = items,
            weapons = weapons,
            job = job
        }
        TriggerClientEvent('FewZ:UpdataVault', jobplayer.source, refreshVault)
    end
end)

function sendToDiscord(name, message, color, DiscordWebHook)
    local embeds = {{
        ["title"] = message,
        ["description"] = "ลักษณะงาน: **" .. name .. "**",
        ["type"] = "rich",
        ["color"] = color,
        ["footer"] = {}
    }}
    if message == nil or message == "" then
        return FALSE
    end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers)
    end, "POST", json.encode({
        username = name,
        embeds = embeds
    }), {
        ["Content-Type"] = "application/json"
    })
end