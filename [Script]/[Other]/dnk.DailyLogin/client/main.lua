ESX = exports.es_extended:getSharedObject();
dnk = exports['dnk.DailyLogin']:getCoreObject();
login = nil

local CoreScript = function()
    local self = {};

    self.GetItemLabel = function(name)
        local inventory = ESX.GetPlayerData().inventory;
        for _ , v in pairs(inventory) do
            if v.name == name then
                return v.label;
            end;
        end;
        return nil;
    end;

    self.LoadData = function(items, points, point, back)
        SendNUIMessage({ load = items, points = points, point = point, reward = Config.Points, back = Config.ReceiveBack[back + 1], inventory = 'nui://nc_inventory/html/img/items/' });
    end;

    self.ToggleMenu = function(state)
        SetNuiFocus(state, state)
        SendNUIMessage({ toggle = state });
    end;

    return self;
end;

CreateThread(function()
    login = CoreScript();
    TriggerServerEvent(dnk.gname('getData'))

    -- while true do
        
    --     if login.OnlineTime > 0 then
    --         login.OnlineTime = login.OnlineTime - 1;
    --     else
    --         login.OnlineTime = Config.OnlineTime;
    --         print('Reward Item Online !')
    --         TriggerServerEvent(dnk.gname('onlineItem'))
    --     end

    --     Wait(1000)
    -- end
end)

RegisterNetEvent('esx:playerLoaded', function()
    TriggerServerEvent(dnk.gname('getData'))
end);

RegisterNetEvent(dnk.rname('setData'), function(received, missed, current, isLogin, point, back)
    local items = ESX.Table.Clone(Config.DailyLogin)
    local points = 0

    for day , item in pairs(items) do
        if received[day] then
            item.received = true
            points = points + 1
        end

        if missed[day] then
            item.missed = true
            if Config.ReceiveBack then item.can_receiveback = true end
        end

        item.amount = math.random(item.amount[1], item.amount[2]);
        item.label = login.GetItemLabel(item.name)
        
        if not isLogin and items[current + 1] then
            items[current + 1].can_receive = true
        end
    end;
    login.LoadData(items, points, point, back);
end);

RegisterNuiCallback('recevieItem', function(index)
    index = index + 1;
    if not Config.DailyLogin[index] then return end;
    TriggerServerEvent(dnk.gname('recevieItem'), index);
end);
RegisterNuiCallback('receviePoint', function(index)
    if not Config.Points[index] then return end;
    TriggerServerEvent(dnk.gname('receviePoint'), index);
end);

RegisterNUICallback('toggleMenu', function()
    login.ToggleMenu(false);
end);

exports('OpenMenu', function()
    login.ToggleMenu(true);
end);