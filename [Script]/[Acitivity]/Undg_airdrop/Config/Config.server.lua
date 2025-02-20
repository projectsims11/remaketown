Server = function(source, item, count)
    local xPlayer = ESX.GetPlayerFromId(source)

    if Config.Default.Extended['Base'] == '1.1' then

        if item == 'money' then
            xPlayer.addAccountMoney('money', count)
        elseif item == 'black_money' then
            xPlayer.addAccountMoney('black_money', count)
        else
            local limit = xPlayer.getInventoryItem(item)
            if limit.limit ~= -1 and (limit.count + count) > limit.limit then
                NotifyServer('ไอเทมของคุณนั้นเต็ม !',source)
            else
                xPlayer.addInventoryItem(item, count)
            end
        end

    elseif Config.Default.Extended['Base'] == '1.2' then

        if item == 'money' then
            xPlayer.addAccountMoney('money', count)
        elseif item == 'black_money' then
            xPlayer.addAccountMoney('black_money', count)
        else
            if xPlayer.canCarryItem(item, count) then
                xPlayer.addInventoryItem(item, count)
            else
                NotifyServer('ไอเทมของคุณนั้นเต็ม !',source)
            end
        end
    end
end