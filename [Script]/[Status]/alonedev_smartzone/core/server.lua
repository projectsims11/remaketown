local loadScript
local alonedev_smartzone = nil

loadScript = function()
    ESX = cfg.Extended.Server()
    local client = GetCurrentResourceName() .. ':client:'
    local server = GetCurrentResourceName() .. ':server:'
    alonedev_smartzone = {}

    SetupGlobalState = function()
        for i , v in pairs(SmartZone.Zone) do 
            if v.zone_time then 
                GlobalState["SmartZone_" .. i] = {
                    Isopened = false
                }
            else
                GlobalState["SmartZone_" .. i] = {
                    Isopened = true
                }
            end

        end

        if cfg.Debug then 
            for i , v in pairs(SmartZone.Zone) do 
                print("Zone" ..i .. "Status" .. GlobalState["SmartZone_" .. i].Isopened)
            end 
        end
    end

    SetupGlobalState()
    
    function  ZoneStart(index , wait_time)
        GlobalState["SmartZone_" .. index].Isopened = true
        if cfg.Debug then 
            print(GlobalState["SmartZone_" .. index].Isopened)
        end
        Citizen.CreateThread(function()
            Wait(wait_time * 60000)
            GlobalState["SmartZone_" .. index].Isopened = false
            if cfg.Debug then 
                print(GlobalState["SmartZone_" .. index].Isopened)
            end
        end)
    end

    if cfg.timeloop_function then 
        Citizen.CreateThread(function()
            while true do 
                local date_local = os.date("%H:%M", os.time())
                for i , v in pairs(SmartZone.Zone) do 
                    if v.zone_time and type(v.zone_time) == 'table' then 
                        for i2, v2 in pairs(v.zone_time) do 
                            if v2[1] == date_local then
                                ZoneStart(i , v2[2])
                            end
                        end
                    end
                end

                Wait(cfg.timeloop_delay * 1000)
            end
        end)
    else 
        exports('StartZone' , ZoneStart )
    end

end


Active = function()
    print('########################')
    print('     ^5ALONEDEVSHOP     ')
    print('      ^2SMART ^1ZONE    ')
    print('  ^5THANK FOR SUPPORTING ')
    print('########################')
end

Citizen.CreateThread(function()
    Wait(1500)
    if GetCurrentResourceName() == 'alonedev_smartzone' then 
        Active()
        Wait(3000)
        loadScript()
    end
end)

