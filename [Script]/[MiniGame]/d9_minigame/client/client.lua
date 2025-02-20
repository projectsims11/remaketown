ESX = exports["es_extended"]:getSharedObject()
local ResourceName = GetCurrentResourceName()

GetName = function(a, b)
    return string.format("%s:%s:%s", ResourceName, a, b)
end

RegisEvent = function(n, h)
    return RegisterNetEvent(n), AddEventHandler(n, h)
end

Eventnui = function(event, data)
    SendNUIMessage({
        event = event,
        data = data
    })
end

cb = {}
cb.cl = {}
cb.id = 0

cb.Event = function(name, callback, ...)
    cb.cl[cb.id] = callback
    TriggerServerEvent(GetName('sv', 'callback'), name, cb.id, ...)
    if cb.id < 65535 then
        cb.id = cb.id + 1
    else
        cb.id = 0
    end
    collectgarbage()
end

RegisEvent(GetName('cl', 'callback'), function(id, ...)
    cb.cl[id](...)
    cb.cl[id] = nil
    collectgarbage()
end)

Citizen.CreateThread(function()
    while ESX.GetPlayerData().job == nil do Citizen.Wait(100) end
    ESX.PlayerData = ESX.GetPlayerData()
end)


RegisterCommand("tmn", function()
    local data = {
        randomkey = {'W', 'A', 'S', 'D', 'F'},
        time = 5000
    }
    local result = exports.d9_minigame:minigame(data)
    print('Minigame : ',result)
end)

Promise = nil

exports("minigame", function(data)
    local keys = data.randomkey
    
    local shuffledKeys = {}
    while #keys > 0 do
        local randomIndex = math.random(1, #keys)
        table.insert(shuffledKeys, keys[randomIndex])
        table.remove(keys, randomIndex)
    end
    
    SetNuiFocus(true, false)
    Eventnui('start', {
        key = shuffledKeys,
        time = data.time
    })
    Promise = promise.new()
    local result = Citizen.Await(Promise)
    return result
end)

RegisterNUICallback("finish", function(result, cb)
    SetNuiFocus(false, false)
    -- print(result.boo)
    Promise:resolve(result.boo)
    Eventnui('stop', {})
    cb("OK")
end)
