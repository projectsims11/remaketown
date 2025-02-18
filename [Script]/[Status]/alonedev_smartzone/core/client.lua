local loadScript
local alonedev_smartzone = nil

loadScript = function()
    ESX = cfg.Extended.Client()
    local client = GetCurrentResourceName() .. ':client:'
    local server = GetCurrentResourceName() .. ':server:'
    local CurrentZone = nil
    local SavedZone = nil
    local LoopingZone = nil
    alonedev_smartzone = {}
    local IsLooping = false

    alonedev_smartzone.SetupPlayer = function(Zone)
        local p = PlayerPedId()
        local player =  SmartZone.Zone[Zone].player

        if player.invincible then 
            SetEntityInvincible(p , true)
        end

        if player.collide then 
            SetEntityCollision(p , true , true)
        end

        if player.regenhealth then 
            SetPlayerHealthRechargeMultiplier(p, player.regenhealth)
        end
    end

    alonedev_smartzone.SetupPlayer2 = function(Zone)
        local p = PlayerPedId()
        local player =  SmartZone.Zone[Zone].player

        if player.invincible then 
            SetEntityInvincible(p , false)
        end

        if player.fade then 
            SetEntityAlpha(p , 255)
        end

        if player.collide then 
            SetEntityCollision(p , false , true)
        end

        if player.regenhealth then 
            SetPlayerHealthRechargeMultiplier(p, 0.0)
        end
    end

    alonedev_smartzone.GetZoneAnti = function(CheckStatus)
        if CurrentZone then 
            return  SmartZone.Zone[CurrentZone].anti[CheckStatus]
        end

        return false
    end

    ZoneLoops = function(ZoneNow)
        if not IsLooping then 
            if SmartZone.Zone[ZoneNow].Zone_Loop then 
                LoopingZone = ZoneNow
                local player =  SmartZone.Zone[ZoneNow].player
                Citizen.CreateThread(function()
                    while true do 
    
                        SmartZone.Zone[ZoneNow].Zone_Loop()

                        if CurrentZone ~= ZoneNow or not CurrentZone then 
                            LoopingZone = nil
                            break
                        end
        
                        Citizen.Wait(0)
                    end
        
                    return
                end)
            end
            if SmartZone.Zone[ZoneNow].block_keys then 
                LoopingZone = ZoneNow
                Citizen.CreateThread(function()
                    while true do 
        
                        for i , v in pairs(SmartZone.Zone[ZoneNow].block_keys) do 
                            DisableControlAction(0, v , true)
                        end

                        if CurrentZone ~= ZoneNow or not CurrentZone then 
                            LoopingZone = nil
                            break
                        end
        
                        Citizen.Wait(0)
                    end
    
                    return
                end)
            end
            if SmartZone.Zone[ZoneNow].player.fade then 
                LoopingZone = ZoneNow
                local player =  SmartZone.Zone[ZoneNow].player
                Citizen.CreateThread(function()
                    while true do 

                        if player.fade then 
                            SetEntityAlpha(PlayerPedId() , player.fade)
                        end

                        if CurrentZone ~= ZoneNow or not CurrentZone then 
                            LoopingZone = nil
                            break
                        end
        
                        Citizen.Wait(0)
                    end
    
                    return
                end)
            end
        else 
            if LoopingZone ~= ZoneNow or not LoopingZone then 
                Wait(1500)
                ZoneLoops(ZoneNow)
            end
        end
    end

    Citizen.CreateThread(function()

        while true do

            local p_coords = GetEntityCoords(PlayerPedId())
            local found_zone = false

            for i , v in pairs(SmartZone.Zone) do 
                if cfg.Debug then 
                    print(GlobalState["SmartZone_" .. i].Isopened)
                    Wait(500)
                end
                if GlobalState["SmartZone_" .. i].Isopened then 
                    if type(v.area.coords) ~= 'table' then 
                        if #(v.area.coords - p_coords) <= v.area.radius then 
                            CurrentZone = i
                            found_zone = true
                        end
                    else 
                        for i2 , v2 in pairs(v.area.coords) do 
                            if #(v2 - p_coords) <= v.area.radius then 
                                CurrentZone = i
                                found_zone = true
                            end
                        end
                    end
                end
            end

            if cfg.Debug then 
                print(CurrentZone , found_zone , SavedZone , LoopingZone )
            end

            if CurrentZone then 

                if found_zone then 
                    if CurrentZone ~= SavedZone or not SavedZone then 
                        SavedZone = CurrentZone
                        alonedev_smartzone.SetupPlayer(CurrentZone)
                        SmartZone.Zone[CurrentZone].SendNuiMessage()
                        SmartZone.Zone[CurrentZone].GetInZone()  
                        ZoneLoops(CurrentZone)
                    end
                end

                if not found_zone then 
                    alonedev_smartzone.SetupPlayer2(CurrentZone)
                    SmartZone.Zone[CurrentZone].GetOutZone()
                    CurrentZone = nil
                    SavedZone = nil
                end

            end
             
            Wait(500)
        end
    end)


    exports('GetZoneAnti' , alonedev_smartzone.GetZoneAnti(CheckStatus))
    exports('GetCurrentZone' , function()
        return CurrentZone
    end)
end

Citizen.CreateThread(function()
    print('[^5alonedev_smartzone] ^2Loading Script....')
    Wait(10000)
    if GetCurrentResourceName() == 'alonedev_smartzone' then 
        loadScript()
        print('[^5alonedev_smartzone] ^2Loading Success')
    end
end)




