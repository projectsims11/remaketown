script_name = GetCurrentResourceName()
GetName = function(a) return script_name .. a end;
RegisEvent = function(b, a, c)
    if b then RegisterNetEvent(a) end
    AddEventHandler(a, c)
end;
SAOWIJAOIJDOZAISJSAUZHAYUSSAZIAJISADSDS = nil;
RegisEvent(true, GetName(':client:Verify:Receive'),
           function(d) SAOWIJAOIJDOZAISJSAUZHAYUSSAZIAJISADSDS = d end)
Citizen.CreateThread(function()
    local e = GetGameTimer()
    while SAOWIJAOIJDOZAISJSAUZHAYUSSAZIAJISADSDS == nil and GetGameTimer() - e <=
        30 * 1000 do
        TriggerServerEvent(GetName(':server:Verify:Request'))
        Wait(300)
    end
    if SAOWIJAOIJDOZAISJSAUZHAYUSSAZIAJISADSDS then
        xZero.Init()
    else
        print('^1Verify:ERROR^7')
    end
end)
ESX = nil;
xZero = {}
xZero.Hooks = {}
_Inventory = {}
_Accounts = {}
_Money = nil;
_currentWeaponHash = nil;
xZero.Init = function()
    Wait(500)
    if SAOWIJAOIJDOZAISJSAUZHAYUSSAZIAJISADSDS then
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(f) ESX = f end)
            Wait(1)
        end
        while ESX.GetPlayerData() == nil do Wait(1) end
        while true do
            if ESX.GetPlayerData().inventory and #ESX.GetPlayerData().inventory >
                0 then break end
            Wait(1)
        end
        xZero.Inited()
    end
end;
xZero.Inited = function()
    print(('Inited - version_current:^3%s^7'):format(version_current))
    SendNUIMessage({
        action = "Config_Settings",
        URL_NUI_Images = Config.URL_NUI_Images,
        TimeOut = Config.TimeOut,
        Layout = Config.Layout,
        Prefix = Config.Prefix
    })
    if ESX.GetPlayerData().inventory then
        for g, h in ipairs(ESX.GetPlayerData().inventory) do
            _Inventory[h.name] = {label = h.label, count = h.count}
        end
    else
        print('^1Cahce Inventory NULL^7')
    end
    if ESX.GetPlayerData().accounts then
        for g, h in ipairs(ESX.GetPlayerData().accounts) do
            _Accounts[h.name] = h.money
        end
    else
        print('^1Cahce Accounts NULL^7')
    end
    if Config.es_extended_old then
        _Money = ESX.GetPlayerData().money;
        xZero.Hooks.Accounts_Request()
    end
    RegisEvent(true, 'esx:addWeapon', function(i, j)
        NUI_Notify(ESX.GetWeaponLabel(i), i, j, 'added')
    end)
    RegisEvent(true, 'esx:removeWeapon', function(i, j)
        local k = j and j or 0;
        NUI_Notify(ESX.GetWeaponLabel(i), i, j, 'remove')
    end)
    RegisEvent(true, 'esx:addInventoryItem', function(l, m)
        if l then
            if type(l) == 'table' then
                m = l.count;
                l = l.name or nil
            end
            if _Inventory and _Inventory[l] then
                local n = _Inventory[l] or nil;
                local o = m - n.count;
                _Inventory[l].count = m;
                NUI_Notify(n.label, l, o, 'added')
            end
        end
    end)
    RegisEvent(true, 'esx:removeInventoryItem', function(l, m)
        if l then
            if type(l) == 'table' then
                m = l.count;
                l = l.name or nil
            end
            if _Inventory and _Inventory[l] then
                local n = _Inventory[l]
                local o = n.count - m;
                _Inventory[l].count = m;
                NUI_Notify(n.label, l, o, 'remove')
            end
        end
    end)
    RegisEvent(true, 'esx:setAccountMoney', function(p)
        if _Accounts and _Accounts[p.name] then
            local _Money = _Accounts[p.name]
            local q = p.money > _Money and 'added' or 'remove'
            local o = q == 'added' and p.money - _Money or _Money - p.money;
            _Accounts[p.name] = p.money;
            if o > 0 then NUI_Notify(p.label, p.name, o, q) end
        else
            _Accounts[p.name] = p.money;
            print('^2Cache Add Account | ' .. p.name .. ' | ' .. p.money .. '^7')
        end
    end)
    if Config.es_extended_old then
        RegisEvent(true, 'es:activateMoney', function(r)
            if r and type(r) == 'number' and _Money ~= nil then
                local q = r > _Money and 'added' or 'remove'
                local o = q == 'added' and r - _Money or _Money - r;
                _Money = r;
                if o > 0 then NUI_Notify('Cash', 'cash', o, q) end
            end
        end)
    end
    if Config.WeaponUse_Notify then
        Citizen.CreateThread(function()
            while true do
                Wait(500)
                local s = PlayerPedId()
                if not IsEntityDead(s) then
                    local t = GetSelectedPedWeapon(s)
                    if not _currentWeaponHash or _currentWeaponHash ~= t then
                        _currentWeaponHash = t;
                        local u, v = GetWeapon(_currentWeaponHash)
                        if u then
                            NUI_Notify(v, u, 0, 'use_weapon')
                        end
                    end
                end
            end
        end)
    end
end;
xZero.Hooks.Accounts_Request = function()
    RegisEvent(true, GetName(':client:Accounts:Receive'), function(w)
        if w then
            for g, h in ipairs(w) do _Accounts[h.name] = h.money end
            print(('^2Cache Account Receive:%s^7'):format(#w))
        end
    end)
    Wait(500)
    TriggerServerEvent(GetName(':server:Accounts:Request'))
end;
function NUI_Notify(x, l, y, type)
    SendNUIMessage({
        action = "notify",
        item_label = x,
        item_name = l,
        item_count = y,
        type = type
    })
end
function GetWeapon(z)
    local A = ESX.GetWeaponList()
    if A then
        for g, h in ipairs(A) do
            if GetHashKey(h.name) == z then return h.name, h.label end
        end
    end
    return nil, nil
end