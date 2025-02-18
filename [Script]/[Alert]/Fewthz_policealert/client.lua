Fewthz = GetCurrentResourceName()
local a = nil
local b = "male"
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
    for e, f in ipairs({"police"}) do
        if f == a.PlayerData.job.name then
            return true
        end
    end
    return false
end
RegisterNetEvent(Fewthz .. ":Notify")
AddEventHandler(
    Fewthz .. ":Notify",
    function(g, b, h, i, j)
        local k =
            "" ..
            Config["translate"]["title"] ..
                "" ..
                    string.format(Config["translate"]["text"], g, Config["translate"][b], h) ..
                        '<br><b style="color:black; font-size:12px;background:white; border-radius:3px; padding:1% 4% 1% 4%;">' ..
                            Config["base_key_text"] ..
                                '</b><b> + <b style="color:black; font-size:12px;background:white; border-radius:3px; padding:1% 4% 1% 4%;"> ' ..
                                    i .. "</b>" .. Config["translate"]["tip"] .. "<br>"
        if isPlayerWhitelisted then
            alertNotification(k)
            TriggerEvent(Fewthz .. ":alertArea", j)
        end
    end
)
RegisterNetEvent(Fewthz .. ":Notifyaccept")
AddEventHandler(
    Fewthz .. ":Notifyaccept",
    function(l)
        local m =
            '<span style="font-size:18px;color:white;">ตำรวจ </span><span style="font-size:18px;color:orange;">' ..
            l .. ' </span><span style="font-size:18px;color:white;">รับเคสแล้ว</span>'
        if isPlayerWhitelisted then
            worker_nameNotification(m)
        end
    end
)
RegisterNetEvent(Fewthz .. ":sendLocation")
AddEventHandler(
    Fewthz .. ":sendLocation",
    function(j)
        SetNewWaypoint(j.x, j.y)
        SendGps()
        if Config["worker_name"] then
            TriggerServerEvent(Fewthz .. ":accept", name)
        end
    end
)
local n = function(o, p)
    return IsControlPressed(o, p) or IsDisabledControlPressed(o, p)
end
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(10)
            local i
            if n(1, 157) then
                i = 1
            elseif n(1, 158) then
                i = 2
            elseif n(1, 160) then
                i = 3
            elseif n(1, 164) then
                i = 4
            elseif n(1, 165) then
                i = 5
            elseif n(1, 159) then
                i = 6
            elseif n(1, 161) then
                i = 7
            elseif n(1, 162) then
                i = 8
            elseif n(1, 163) then
                i = 9
            end
            if n(1, Config["base_key"]) and i and a.PlayerData.job and a.PlayerData.job.name == "police" then
                TriggerServerEvent(Fewthz .. ":getLocation", i)
                Citizen.Wait(1000)
            end
        end
    end
)
getStreetName = function()
    local j = GetEntityCoords(PlayerPedId())
    local q, r = GetStreetNameAtCoord(j.x, j.y, j.z)
    q = GetStreetNameFromHashKey(q)
    return q
end
AddEventHandler(
    "skinchanger:loadSkin",
    function(s)
        b = s.sex == 0 and "male" or "female"
    end
)
RegisterNetEvent(Fewthz .. ":alertArea")
AddEventHandler(
    Fewthz .. ":alertArea",
    function(j)
        Citizen.CreateThread(
            function()
                SendNUIMessage({type = "playsound"})
                local f = AddBlipForRadius(j.x, j.y, j.z, Config["red_radius"])
                SetBlipHighDetail(f, true)
                SetBlipColour(f, 1)
                SetBlipAlpha(f, 200)
                SetBlipAsShortRange(f, true)
                local t = 200
                local u = t / Config["duration"] * 100
                local v = t / Config["duration"]
                while t > 0 do
                    t = t - v
                    if t <= 0 then
                        RemoveBlip(f)
                    else
                        SetBlipAlpha(f, math.floor(t))
                    end
                    Citizen.Wait(u)
                end
            end
        )
    end
)
AddEventHandler(
    Fewthz .. ":alertNet",
    function(w)
        local x = PlayerPedId()
        local j = GetEntityCoords(x)
        TriggerServerEvent(Fewthz .. ":defaultAlert2", w, b, getStreetName(), j)
    end
)
RegisterNetEvent(Fewthz .. ":getalertNet")
AddEventHandler(
    Fewthz .. ":getalertNet",
    function(w)
        local x = PlayerPedId()
        local j = GetEntityCoords(x)
        TriggerServerEvent(Fewthz .. ":defaultAlert2", w, b, getStreetName(), j)
    end
)
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(7)
            local x = PlayerPedId()
            if Config["alert_section"]["carjacking"] and IsPedJacking(x) then
                Citizen.Wait(7)
                local y = GetVehiclePedIsIn(x)
                local z = GetPedInVehicleSeat(y, -1)
                if z == x then
                    local j = GetEntityCoords(x)
                    TriggerServerEvent(Fewthz .. ":defaultAlert", "carjacking", b, getStreetName(), j)
                end
                Citizen.Wait(Config["duration"] * 1000)
            elseif Config["alert_section"]["melee"] and IsPedInMeleeCombat(x) then
                Citizen.Wait(7)
                local j = GetEntityCoords(x)
                TriggerServerEvent(Fewthz .. ":defaultAlert", "melee", b, getStreetName(), j)
                Citizen.Wait(Config["duration"] * 1000)
            elseif Config["alert_section"]["gunshot"] and IsPedShooting(x) and not IsPedCurrentWeaponSilenced(x) then
                Citizen.Wait(7)
                local j = GetEntityCoords(x)
                TriggerServerEvent(Fewthz .. ":defaultAlert", "gunshot", b, getStreetName(), j)
                Citizen.Wait(Config["duration"] * 1000)
            end
        end
    end
)

AddEventHandler("Fewthz_core:ClientMemoryGarbage", function()
	Citizen.CreateThread(function()
		Wait(math.random(100, 2000))
		collectgarbage()
	end)
end)