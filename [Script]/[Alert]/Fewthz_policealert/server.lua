Fewthz = GetCurrentResourceName()
original_scriptname = "Fewthz_policealert"
ESX = nil

TriggerEvent(
    "esx:getSharedObject",
    function(a)
        ESX = a
    end
)

local b = {}

local function c(d, e, f, g, h)
    TriggerClientEvent(Fewthz .. ":Notify", -1, d, e, f, g, h)
end

RegisterServerEvent(Fewthz .. ":accept")
AddEventHandler(
    Fewthz .. ":accept",
    function(i)
        local j = ESX.GetPlayers()
        local k = GetPlayerName(source)
        TriggerClientEvent(Fewthz .. ":Notifyaccept", -1, k)
    end
)

local function l(h)
    local g
    for m = 1, 9 do
        local n = b[m]
        if n == nil then
            g = m
            b[m] = {time = GetGameTimer() + Config["duration"] * 800, pos = h}
            break
        end
    end
    return g
end

RegisterServerEvent(Fewthz .. ":getLocation")
AddEventHandler(
    Fewthz .. ":getLocation",
    function(g)
        local o = b[g]
        if o then
            TriggerClientEvent(Fewthz .. ":sendLocation", source, o.pos)
        end
    end
)

local p = {}
RegisterServerEvent(Fewthz .. ":defaultAlert")
AddEventHandler(
    Fewthz .. ":defaultAlert",
    function(q, e, f, h)
        if p[source] and p[source] > GetGameTimer() then
            return
        end
        local g = l(h)
        if not g then
            return
        end
        local d
        if q == "carjacking" then
            d = Config["translate"]["action_carjacking"]
        elseif q == "melee" then
            d = Config["translate"]["action_melee"]
        elseif q == "gunshot" then
            return
        end
        p[source] = GetGameTimer() + Config["duration"] * 800
        c(d, e, f, g, h)
    end
)

local p = {}

RegisterServerEvent(Fewthz .. ":defaultAlert2")
AddEventHandler(
    Fewthz .. ":defaultAlert2",
    function(q, e, f, h)
        if p[source] and p[source] > GetGameTimer() then
            return
        end
        local g = l(h)
        if not g then
            return
        end
        local d
        for r, n in pairs(Config["alert"]) do
            if q == n.type then
                d = n.action
                p[source] = GetGameTimer() + Config["duration"] * 800
                c(d, e, f, g, h)
                return
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            for m = 1, 9 do
                local n = b[m]
                if n and n.time < GetGameTimer() then
                    b[m] = nil
                end
            end
            Citizen.Wait(500)
        end
    end
)

