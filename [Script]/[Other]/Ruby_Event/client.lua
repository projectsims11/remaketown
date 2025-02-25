local Eventlist = {}
local TimeNow = ""

print("Ruby_Event start")



function OpenUI(event,timeui)
    SetNuiFocus(false, false)
    SendNUIMessage({
        Open = true,
        eventdata = event,
        TimeTrig = timeui,

    })
end


RegisterNetEvent("Ruby_Event:updateTime")
AddEventHandler("Ruby_Event:updateTime", function(serverTime)
    TimeNow = serverTime
    -- print("Updated Real-World Time:", TimeNow) 
end)
TriggerServerEvent("Ruby_Event:getTime")

for k,v in pairs(Config.Event) do
    table.insert(Eventlist,k);
end


Citizen.CreateThread(function()
    Timecheck = 1000 * 1 * 1 -- 60000 ms = 60 s = 1 min
    while true do

        TriggerServerEvent("Ruby_Event:getTime")
        Citizen.Wait(500)
        -- print("TimeNow in loop : "..TimeNow)
        for k,v in pairs(Config.Event) do
            for i,j in pairs(v)do
                -- print(k..": "..j)
                -- print("----------------------------------------")
                for a,b in pairs(Eventlist) do
                    -- print("check k: "..k.." and b: "..b)
                    -- print("check j: "..j.." and TimeNow: "..TimeNow)
                    -- print("k==b: ".. tostring(k == b))
                    -- print("j == TimeNow: ".. tostring(j == TimeNow))
                    if k == b and j == TimeNow then
                        -- print("k==b: ".. tostring(k == b))
                        -- print("j == TimeNow: ".. tostring(j == TimeNow))
                        -- print(k.."  Start At"..j)
                        OpenUI(k,TimeNow)
                    end
                    -- print("----------------------------------------")
                end
            end
        end
        Citizen.Wait(Timecheck)
    end
end)