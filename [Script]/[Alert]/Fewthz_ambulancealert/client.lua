Fewthz = GetCurrentResourceName()
local a = nil
local b = "male"
isPlayerWhitelisted = false
Citizen.CreateThread(
    function()
        while a == nil do
            Citizen.Wait(0)
            TriggerEvent(
                "esx:getSharedObject",
                function(c)
                    a = c
                end
            )
        end
        while a.GetPlayerData().job == nil do
            Citizen.Wait(100)
        end
        a.PlayerData = a.GetPlayerData()
        isPlayerWhitelisted = refreshPlayerWhitelisted()
    end
)
RegisterNetEvent("esx:setJob")
AddEventHandler(
    "esx:setJob",
    function(d)
        a.PlayerData.job = d
        isPlayerWhitelisted = refreshPlayerWhitelisted()
    end
)
function refreshPlayerWhitelisted()
    if not a.PlayerData then
        return false
    end
    if not a.PlayerData.job then
        return false
    end
    for e, f in ipairs({"ambulance"}) do
        if f == a.PlayerData.job.name then
            return true
        end
    end
    return false
end
RegisterNetEvent(Fewthz .. "Notify")
AddEventHandler(
    Fewthz .. "Notify",
    function(g, b, h, i, j)
        local k =
            "" ..
            Config["translate"]["title"] ..
                "" ..
                    string.format(Config["translate"]["text"], g, Config["translate"][b], h) ..
                        "<br><b>" ..
                            Config["base_key_text"] ..
                                "</b><b> + " .. i .. "</b>" .. Config["translate"]["tip"] .. "<br>"
        if isPlayerWhitelisted then
            alertNotification(k)
            TriggerEvent(Fewthz .. "alertArea", j)
        end
    end
)
RegisterNetEvent(Fewthz .. ":Notifyaccept")
AddEventHandler(
    Fewthz .. ":Notifyaccept",
    function(l)
        local m =
            '<span style="font-size:18px;color:white;">หมอ </span><span style="font-size:18px;color:orange;">' ..
            l .. ' </span><span style="font-size:18px;color:white;">รับเคสแล้ว</span>'
        if isPlayerWhitelisted then
            worker_nameNotification(m)
        end
    end
)
RegisterNetEvent(Fewthz .. "sendLocation")
AddEventHandler(
    Fewthz .. "sendLocation",
    function(j)
        local n = GetEntityCoords(playerPed)
        SetNewWaypoint(j.x, j.y)
        SendGps()
        if Config["worker_name"] then
            TriggerServerEvent(Fewthz .. ":accept", name)
        end
    end
)
local o = function(p, q)
    return IsControlPressed(p, q) or IsDisabledControlPressed(p, q)
end
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(10)
            local i
            if o(1, 157) then
                i = 1
            elseif o(1, 158) then
                i = 2
            elseif o(1, 160) then
                i = 3
            elseif o(1, 164) then
                i = 4
            elseif o(1, 165) then
                i = 5
            elseif o(1, 159) then
                i = 6
            elseif o(1, 161) then
                i = 7
            elseif o(1, 162) then
                i = 8
            elseif o(1, 163) then
                i = 9
            end
            if o(1, Config["base_key"]) and i and a.PlayerData.job and a.PlayerData.job.name == "ambulance" then
                TriggerServerEvent(Fewthz .. "getLocation", i)
                Citizen.Wait(1000)
            end
        end
    end
)
local r = function()
    local j = GetEntityCoords(PlayerPedId())
    local s, t = GetStreetNameAtCoord(j.x, j.y, j.z)
    s = GetStreetNameFromHashKey(s)
    return s
end
AddEventHandler(
    "skinchanger:loadSkin",
    function(u)
        b = u.sex == 0 and "male" or "female"
    end
)
RegisterNetEvent(Fewthz .. "alertArea")
AddEventHandler(
    Fewthz .. "alertArea",
    function(j)
        Citizen.CreateThread(
            function()
                SendNUIMessage({type = "playsound"})
                local f = AddBlipForRadius(j.x, j.y, j.z, Config["red_radius"])
                SetBlipHighDetail(f, true)
                SetBlipColour(f, 1)
                SetBlipAlpha(f, 200)
                SetBlipAsShortRange(f, true)
                local v = 200
                local w = v / Config["duration"] * 100
                local x = v / Config["duration"]
                while v > 0 do
                    v = v - x
                    if v <= 0 then
                        RemoveBlip(f)
                    else
                        SetBlipAlpha(f, math.floor(v))
                    end
                    Citizen.Wait(w)
                end
            end
        )
    end
)
AddEventHandler(
    Fewthz .. ":alertNet",
    function(y)
        local z = PlayerPedId()
        local j = GetEntityCoords(z)
        TriggerServerEvent(Fewthz .. "defaultAlert", y, b, r(), j)
    end
)
RegisterNetEvent(Fewthz .. ":getalertNet")
AddEventHandler(
    Fewthz .. ":getalertNet",
    function(y)
        local z = PlayerPedId()
        local j = GetEntityCoords(z)
        TriggerServerEvent(Fewthz .. "defaultAlert", y, b, r(), j)
    end
)

AddEventHandler("Fewthz_core:ClientMemoryGarbage", function()
	Citizen.CreateThread(function()
		Wait(math.random(100, 2000))
		collectgarbage()
	end)
end)