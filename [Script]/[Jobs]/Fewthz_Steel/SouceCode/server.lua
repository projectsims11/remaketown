ESX = exports["es_extended"]:getSharedObject()

local FewZ = GetCurrentResourceName()

RegisterServerEvent(FewZ ..':retrieve')
AddEventHandler(FewZ ..':retrieve', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    math.randomseed(os.time())
    local luck = math.random(0, 100)
    local itemName = Config['ไอเทม']
    local randomSteelScrap = math.random((Config['จำนวน'][1] or 1), (Config['จำนวน'][2] or 6))
    local xItem = xPlayer.getInventoryItem(itemName)	

    if Config.canCarry then
        if xItem.limit ~= -1 and (xItem.count + 1) > xItem.limit then
            TriggerClientEvent("pNotify:SendNotification", source, {
                text = '<strong class="red-text">กระเป๋าของคุณเต็ม</strong>',
                type = "error",
                timeout = 3000,
                layout = "bottomCenter",
                queue = "global"
            })
        else
            xPlayer.addInventoryItem(itemName, randomSteelScrap)
            local sendToDiscord = 'ผู้เล่นชื่อ : '..xPlayer.name..' ได้รับ '..ESX.GetItemLabel(itemName)..' จำนวน '..randomSteelScrap..''
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'SteelJob', sendToDiscord, xPlayer.source, '^2')
        end	
    else
        if xPlayer.canCarryItem(itemName, randomSteelScrap) then
            xPlayer.addInventoryItem(itemName, randomSteelScrap)
        else
            TriggerClientEvent("pNotify:SendNotification", source, {
                type = "error",
                timeout = 3000,
                text = "<strong class='red-text'><center>"..Config['น้ำหนักเต็ม'].."<center></strong>",--bottomCenter <Center>
                layout = "centerRight",
                queue = "global"
            })
        end
    end
end)
