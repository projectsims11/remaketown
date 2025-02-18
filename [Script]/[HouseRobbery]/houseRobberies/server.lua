ESX = exports["es_extended"]:getSharedObject()

local robbableItems = Config.ItemDrop

ESX.RegisterUsableItem(Config.Item.Item, function(source) --Hammer high time to unlock but 100% call cops
 local source = tonumber(source)
 local xPlayer = ESX.GetPlayerFromId(source)
 TriggerClientEvent('houseRobberies:attempt', source, 
 xPlayer.getInventoryItem(Config.Item.Item).count)
end)

RegisterServerEvent('houseRobberies:removeLockpick')
AddEventHandler('houseRobberies:removeLockpick', function()
 local source = tonumber(source)
 local xPlayer = ESX.GetPlayerFromId(source)
 xPlayer.removeInventoryItem(Config.Item.Item, Config.Item.Remove)

end)

RegisterServerEvent('houseRobberies:giveMoney')
AddEventHandler('houseRobberies:giveMoney', function()
    local source = tonumber(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local cash = math.random(Config.GiveMoney.Min, Config.GiveMoney.Max)

    xPlayer.addMoney(cash)
end)


RegisterServerEvent('houseRobberies:searchItem')
AddEventHandler('houseRobberies:searchItem', function()
    local source = tonumber(source)
    local item = {}
    local xPlayer = ESX.GetPlayerFromId(source)
    local gotID = {}

    for i=1, math.random(1, 2) do
        item = robbableItems[math.random(1, #robbableItems)]
        if math.random(1, 100) <= item.Percent then
            if tonumber(item.id) == 0 and not gotID[item.id] then
             gotID[item.id] = true
             xPlayer.addMoney(item.quantity)
            elseif item.isWeapon and not gotID[item.id] then
             gotID[item.id] = true
             xPlayer.addWeapon(item.id, 50)
            elseif not gotID[item.id] then
             gotID[item.id] = true
             xPlayer.addInventoryItem(item.id, item.quantity)
            end
        end
    end
end)
