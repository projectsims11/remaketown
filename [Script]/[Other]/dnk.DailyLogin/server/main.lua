ESX = exports.es_extended:getSharedObject();
dnk = exports['dnk.DailyLogin']:getCoreObject();
playersData = {};

CreateData = function(player)
    local rowInserted = MySQL.insert.await('INSERT INTO dnk_login (`identifier`) VALUES (?)', { player.getIdentifier() });
    if rowInserted then GetData(player.source) end;
end;

GetData = function(source)
    local player = ESX.GetPlayerFromId(source);
    if not player then return end;
    local data = MySQL.single.await('SELECT * FROM dnk_login WHERE identifier = ?', { player.getIdentifier() });
    if not data then CreateData(player) return end;
    if not playersData[player.source] then playersData[player.source] = {} end;
    playersData[player.source] = data;
    playersData[player.source].login = playersData[player.source] and json.decode(playersData[player.source].login)
    local myData = playersData[player.source];
    local myLogin = myData.login;
    local currentDate = os.date('%d/%m');
    local currentProgress = tonumber(os.date('%d'))
    myData.current = currentProgress - 1;
    if next(myLogin) then
        if myData.current < currentProgress then
            for i = 1, myData.current do
                if not myLogin.received[i] then
                    myLogin.received[i] = false;
                    myLogin.missed[i] = true;
                end;
            end;
        end;
    else
        myLogin.received = {};
        myLogin.missed = {};
        if myData.current > 0 then
            for i = 1, myData.current do
                if not myLogin.received[i] then
                    myLogin.received[i] = false;
                    myLogin.missed[i] = true;
                end;
            end;
        end
    end;

    if myData.current >= 30 or string.match(currentDate, '/(%d%d)$') ~= string.match(myData.date, '/(%d%d)$') then
        MySQL.update.await('UPDATE dnk_login SET login = ? WHERE identifier = ?', {'{}', player.getIdentifier()});
    end;

    TriggerClientEvent(dnk.gname('setData'), player.source, myLogin.received, myLogin.missed, myData.current, currentDate == myData.date, playersData[player.source].point, playersData[player.source].back)
end;

RegisterNetEvent(dnk.rname('getData'), function()
    GetData(source)
end);

RegisterNetEvent(dnk.rname('recevieItem'), function(target)
    local player = ESX.GetPlayerFromId(source)
    local item = Config.DailyLogin[target]
    if not item then return end
    if type(item.amount) == 'table' then item.amount = math.random(item.amount[1], item.amount[2]) end

    if item.type == 'item' then
        player.addInventoryItem(item.name, item.amount)
    elseif item.type == 'money' then
        player.addAccountMoney(item.name, item.amount)
    elseif item.type == 'weapon' then
        player.addWeapon(item.name, item.amount)
    elseif item.type == 'vehicle' then
        -- Config.Funcs.server.give_vehicle(player, item.name)
    end
    
    local sendToDiscord = '' .. player.name .. ' ได้รับเดรี่เควสแล้วได้ไอเทม ' .. item.name .. ' จำนวณ ' .. item.amount .. ''
    TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'dailyquest', sendToDiscord, player.source, '^2')

    if playersData[player.source].login.missed[target] then
        playersData[player.source].back = playersData[player.source].back + 1
        if Config.ReceiveBack[playersData[player.source].back] then
            if Config.ReceiveBack[playersData[player.source].back].name == 'money' then
                player.removeAccountMoney('money', Config.ReceiveBack[playersData[player.source].back].amount)
            end
        end
    else
        if target > playersData[player.source].current then
            playersData[player.source].current = target
            playersData[player.source].date = os.date('%d/%m')
        end
    end
    
    playersData[player.source].login.received[target] = true
    playersData[player.source].login.missed[target] = false

    MySQL.update('UPDATE dnk_login SET current = ?, date = ?, login = ?, back = ? WHERE identifier = ?', {
        playersData[player.source].current, playersData[player.source].date, json.encode(playersData[player.source].login), playersData[player.source].back, player.getIdentifier()
    }, function(result)
        if result then
            Wait(1000)
            GetData(player.source)
        end
    end);
end)

RegisterNetEvent(dnk.rname('receviePoint'), function(target)
    local player = ESX.GetPlayerFromId(source)
    local item = Config.Points[target]
    if not item then return end
    if type(item.amount) == 'table' then item.amount = math.random(item.amount[1], item.amount[2]) end

    if item.type == 'item' then
        player.addInventoryItem(item.name, item.amount)
    elseif item.type == 'money' then
        player.addAccountMoney(item.name, item.amount)
    elseif item.type == 'weapon' then
        player.addWeapon(item.name, item.amount)
    elseif item.type == 'vehicle' then
        -- Config.Funcs.server.give_vehicle(player, item.name)
    end
    
    -- local sendToDiscord = '' .. player.name .. ' ได้รับเดรี่เควสแล้วได้ไอเทม ' .. item.name .. ' จำนวณ ' .. item.amount .. ''
    -- TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'dailyquest', sendToDiscord, player.source, '^2')

    playersData[player.source].point = target

    MySQL.update('UPDATE dnk_login SET point = ? WHERE identifier = ?', {
        playersData[player.source].point, player.getIdentifier()
    }, function(result)
        if result then
            Wait(1000)
            GetData(player.source)
        end
    end);
end)