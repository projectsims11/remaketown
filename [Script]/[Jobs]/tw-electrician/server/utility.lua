-- ██████╗  ██████╗ ██╗  ██╗   ██╗    ██╗     ███████╗ █████╗ ██╗  ██╗███████╗ 
-- ██╔══██╗██╔═══██╗██║  ╚██╗ ██╔╝    ██║     ██╔════╝██╔══██╗██║ ██╔╝██╔════╝ 
-- ██████╔╝██║   ██║██║   ╚████╔╝     ██║     █████╗  ███████║█████╔╝ ███████╗ 
-- ██╔═══╝ ██║   ██║██║    ╚██╔╝      ██║     ██╔══╝  ██╔══██║██╔═██╗ ╚════██║ 
-- ██║     ╚██████╔╝███████╗██║       ███████╗███████╗██║  ██║██║  ██╗███████║ 
-- ╚═╝      ╚═════╝ ╚══════╝╚═╝       ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝ 
-- [discord.gg/gaJJjnKGpg] 
function ExecuteSql(query, parameters)
    local IsBusy = true
    local result = nil
    if Config.SQL == "oxmysql" then
        if parameters then
            exports.oxmysql:execute(query, parameters, function(data)
                result = data
                IsBusy = false
            end)
        else
            exports.oxmysql:execute(query, function(data)
                result = data
                IsBusy = false
            end)
        end
    elseif Config.SQL == "ghmattimysql" then
        if parameters then
            exports.ghmattimysql:execute(query, parameters, function(data)
                result = data
                IsBusy = false
            end)
        else
            exports.ghmattimysql:execute(query, {}, function(data)
                result = data
                IsBusy = false
            end)
        end
    elseif Config.SQL == "mysql-async" then
        if parameters then
            MySQL.Async.fetchAll(query, parameters, function(data)
                result = data
                IsBusy = false
            end)
        else
            MySQL.Async.fetchAll(query, {}, function(data)
                result = data
                IsBusy = false
            end)
        end
    end
    while IsBusy do
        Citizen.Wait(0)
    end
    return result
end

function RegisterCallback(name, cbFunc)
    while not Core do
        Wait(0)
    end
    if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
        Core.RegisterServerCallback(name, function(source, cb, data)
            cbFunc(source, cb, data)
        end)
    else
        Core.Functions.CreateCallback(name, function(source, cb, data)
            cbFunc(source, cb, data)
        end)
    end
end

function WaitCore()
    while Core == nil do
        Wait(0)
    end
end

function GetPlayer(source)
    local Player = false
    while Core == nil do
        Citizen.Wait(0)
    end
    if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
        Player = Core.GetPlayerFromId(source)
    else
        Player = Core.Functions.GetPlayer(source)
    end
    return Player
end

function GetIdentifier(source)
    local Player = GetPlayer(source)
    if Player then
        if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
            return Player.getIdentifier()
        else
            return Player.PlayerData.citizenid
        end
    end
end

function GetPlayerInventory(source)
    local data = {}
    local Player = GetPlayer(source)
    if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
        for _, v in pairs(Player.getInventory()) do
            v.count = v.count or v.amount
            if v and tonumber(v.count) > 0 then
                local formattedData = v
                formattedData.name = string.lower(v.name)
                formattedData.label = v.label
                formattedData.amount = v.count
                formattedData.image = v.image or (string.lower(v.name) .. '.png')
                table.insert(data, formattedData)
            end
        end
    else
        for _, v in pairs(Player.PlayerData.items) do
            if v then
                local amount = v.count or v.amount
                if tonumber(amount) > 0 then
                    local formattedData = v
                    formattedData.name = string.lower(v.name)
                    formattedData.label = v.label
                    formattedData.amount = amount
                    formattedData.image = v.image or (string.lower(v.name) .. '.png')
                    table.insert(data, formattedData)
                end
            end
        end
    end
    return data
end

function GetName(source)
    if Config.Framework == "oldesx" or Config.Framework == "esx" then
        local xPlayer = Core.GetPlayerFromId(tonumber(source))
        if xPlayer then
            return xPlayer.getName()
        else
            return "0"
        end
    elseif Config.Framework == 'qb' or Config.Framework == 'oldqb' then
        local Player = Core.Functions.GetPlayer(tonumber(source))
        if Player then
            return Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
        else
            return "0"
        end
    end
end

function AddMoney(source, type, value)
    local Player = GetPlayer(source)
    if Player then
        if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
            if type == 'bank' then
                Player.addAccountMoney('bank', tonumber(value))
            end
            if type == 'cash' then
                Player.addMoney(value)
            end
        elseif Config.Framework == 'qb' or Config.Framework == 'oldqb' then
            if type == 'bank' then
                Player.Functions.AddMoney('bank', value)
            end
            if type == 'cash' then
                Player.Functions.AddMoney('cash', value)
            end
        end
    end
end

function RemoveMoney(source, type, value)
    local Player = GetPlayer(source)
    if Player then
        if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
            if type == 'bank' then
                Player.removeAccountMoney('bank', value)
            end
            if type == 'cash' then
                Player.removeMoney(value)
            end
        elseif Config.Framework == 'qb' or Config.Framework == 'oldqb' then
            if type == 'bank' then
                Player.Functions.RemoveMoney('bank', value)
            end
            if type == 'cash' then
                Player.Functions.RemoveMoney('cash', value)
            end
        end
    end
end

function addItem(src, item, amount, slot, info)
    local Player = GetPlayer(src)
    if Player then
        if Config.Inventory == "qb_inventory" then
            Player.Functions.AddItem(item, amount, slot, info)
        elseif Config.Inventory == "esx_inventory" then
            Player.addInventoryItem(item, amount)
        elseif Config.Inventory == "ox_inventory" then
            exports.ox_inventory:AddItem(src, item, amount)
        elseif Config.Inventory == "codem-inventory" then
            exports["codem-inventory"]:AddItem(src, item, amount, slot, info)
        elseif Config.Inventory == "qs_inventory" then
            exports['qs-inventory']:AddItem(src, item, count)
        end
    end
end

function removeItem(src, item, amount)
    local Player = GetPlayer(src)
    amount = tonumber(amount) or 1
    if Player then
        if Config.Inventory == "qb_inventory" then
            exports['qb-inventory']:RemoveItem(src, item, amount, false, 'electrician:server:removeItem')
            -- Player.Functions.RemoveItem(item, amount)
        elseif Config.Inventory == "esx_inventory" then
            Player.removeInventoryItem(item, amount)
        elseif Config.Inventory == "ox_inventory" then
            exports.ox_inventory:RemoveItem(src, item, amount)
        elseif Config.Inventory == "codem-inventory" then
            exports["codem-inventory"]:RemoveItem(src, item, amount)
        elseif Config.Inventory == "qs_inventory" then
            exports['qs-inventory']:RemoveItem(src, item, amount)
        end
    end
end

function GetPlayerMoney(source, value)
    local Player = GetPlayer(source)
    if Player then
        if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
            if value == 'bank' then
                return Player.getAccount('bank').money
            end
            if value == 'cash' then
                return Player.getMoney()
            end
        elseif Config.Framework == 'qb' or Config.Framework == 'oldqb' then
            if value == 'bank' then
                return Player.PlayerData.money['bank']
            end
            if value == 'cash' then
                return Player.PlayerData.money['cash']
            end
        end
    end
end

function HasItem(source, item)
    local Player = GetPlayer(source)
    if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
        if Config.Inventory == 'codem-inventory' then
            local item = exports["codem-inventory"]:CheckItemValid(source, item.name, tonumber(item.amount))
            return item
        elseif Config.Inventory == 'qs_inventory' then
            local itemCount = exports['qs-inventory']:GetItemTotalAmount(source, item.name)
            if itemCount == 0 or itemCount == nil then
                return false
            end
            return true
        elseif Config.Inventory == 'ox_inventory' then
            if GetResourceState('ox-inventory') == 'missing' then return end
            local item = exports['ox-inventory']:HasItem(source, item.name, tonumber(item.amount))
            if item then
                return true
            else
                return false
            end
        else
            local playerItem = Player.getInventoryItem(item.name)
            if not playerItem then
                return false
            end
            local amount = playerItem.count or playerItem.amount
            if tonumber(amount) >= tonumber(item.amount) then
                return true
            end
        end
    else
        if Config.Inventory == 'codem-inventory' then
            local item = exports["codem-inventory"]:CheckItemValid(source, item.name, tonumber(item.amount))
            return item
        elseif Config.Inventory == 'qs_inventory' then
            local itemCount = exports['qs-inventory']:GetItemTotalAmount(source, item.name)
            if itemCount == 0 or itemCount == nil then
                return false
            end
            return true
        elseif Config.Inventory == 'ox_inventory' then
            local item = exports['ox-inventory']:HasItem(source, item.name, tonumber(item.amount))
            if item then
                return true
            else
                return false
            end
        else
            return Core.Functions.HasItem(source, item.name, tonumber(item.amount))
        end
    end
    return false
end

function selectRandomCoords(coordsList, count)
    local selected = {}
    math.randomseed(os.time())

    for i = 1, count do
        local index = math.random(1, #coordsList)
        table.insert(selected, table.remove(coordsList, index))
    end

    return selected
end
