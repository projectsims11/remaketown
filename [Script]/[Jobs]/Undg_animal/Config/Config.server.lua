GetItems = function(source, k, animalid)
    local rnd = math.random(1,100)
    local xPlayer = ESX.GetPlayerFromId(source)
    local log = {}

    for k, v in pairs(Config.Default.Animals[k].Items) do
        if rnd <= v.percent then

            if Config.Default.Extended['Base'] == '1.1' then
                local limit = xPlayer.getInventoryItem(v.name)
                if limit.limit ~= -1 and (limit.count + v.count) > limit.limit then
                    NotifyServer(source, 'ไอเทมของคุณนั้นเต็ม !')
                else
                    table.insert(log, {
                        item = v.name,
                        count = tonumber(v.count),
                    })
                    xPlayer.addInventoryItem(v.name, v.count)
                end
            elseif Config.Default.Extended['Base'] == '1.2' then
                if xPlayer.canCarryItem(v.name, v.count) then
                    table.insert(log, {
                        item = v.name,
                        count = tonumber(v.count),
                    })
                    xPlayer.addInventoryItem(v.name, v.count)
                else
                    NotifyServer(source, 'ไอเทมของคุณนั้นเต็ม !')
                end
            end

        end
    end

    local logJson = json.encode(log)
    Logs(source, 'ผู้เล่นได้รับไอเทมจาการเลี้ยงสัตว์ ['..Config.Default.Animals[k].Zone..']['..animalid..'] \n'..formatLog(logJson)..'', 'items')
end