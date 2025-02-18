ESX = exports["es_extended"]:getSharedObject()

local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,["~"] = 243, 
    ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, 
    ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,["HOME"] = 213, 
    ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, 
    ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

isInInventory       = false



RegisterCommand('openIn', function()
    if not IsPlayerDead(PlayerId()) then
        if isInInventory  then
            isInInventory = false
            closeInventory()
            print('Close')
        else
            isInInventory = true
            openInventory()
            print('Open')
        end
    end
end, false)

RegisterKeyMapping('openIn', 'Open Inventory', 'keyboard', Config.Keys)



function closeInventory()
    isInInventory = false
    SendNUIMessage({
        action = 'hide'
    })
    SetNuiFocus(false, false)
    TriggerEvent('meeta_carinventory:setOpenMenu', false)

    if Config.BlurBackdrop then
        TriggerScreenblurFadeOut(1200)
    end

    if Config.Delay.Enable then
        InDelay = true

        SetTimeout(Config.Delay.Length, function()
            InDelay = false
        end)
    end
end

RegisterCommand(Config.CloseCommand, function()
    closeInventory()
    exports['mythic_notify']:SendAlert('success', 'ปิดกระเป๋าเรียบร้อยเเล้ว ')
end)

Citizen.CreateThread(function()
    while not NetworkIsPlayerActive(PlayerId()) do
        Citizen.Wait(10)
    end

    Citizen.Wait(1000)
    if Config.CacheFastSlot then
        SendNUIMessage({
            action = 'request-browser-cache'
        })

        print('action : request-browser-cache')
    end

    TriggerServerEvent('yield_addon:inventory:setPlayer', true)
end)

RegisterNUICallback("NUIFocusOff",function()
    closeInventory()
end)





RegisterNUICallback("GetNearPlayers",function(data, cb)
    SendNUIMessage({
        action = "nearPlayers",
        player = data.player,
        item = data.item,
        id = data.id,
        count = data.count
    })
end)

RegisterNUICallback(
    "UseItem",
    function(data, cb)
        if data.item.type == "item_key" then
            TriggerServerEvent("meeta_remote:useKey", data.item.label)
            closeInventory()				
        elseif data.item.name == 'id_card' then
            local closestPlayer, dist = ESX.Game.GetClosestPlayer(GetEntityCoords(PlayerPedId()))
            if closestPlayer == -1 or dist > 3.0 then

            else
                TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer))

            end

            TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
            closeInventory()	
        elseif data.item.name == 'driver_license' then
            TriggerEvent('teamDvm_idcard:dv_license', source)
            closeInventory()	
        elseif data.item.type == "item_accessories" then
            local player = GetPlayerPed(-1)
            closeInventory()
            --หมวก
            if data.item.name == "helmet" then
                TriggerEvent('skinchanger:getSkin', function(skin)
                    if skin["helmet_1"] == -1 then
                        local dict = "veh@bicycle@roadfront@base"
                        local anim = "put_on_helmet"
            
                        RequestAnimDict(dict)
                        while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
                        
                        TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
            
                        Wait(1000)
    
                        local accessorySkin = {}
                        accessorySkin['helmet_1'] = data.item.itemnum
                        accessorySkin['helmet_2'] = data.item.itemskin
    
                        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
                        ClearPedTasks(player)
                    else
                        if IsPedInAnyVehicle(PlayerPedId(), true) == false then
                            local dict = "veh@bike@common@front@base"
                            local anim = "take_off_helmet_walk"
    
                            RequestAnimDict(dict)
                            while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
                            
                            TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
                
                            Wait(800)
                        end
    
                        local accessorySkin = {}
                        accessorySkin['helmet_1'] = -1
                        accessorySkin['helmet_2'] = 0
                        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
                        ClearPedTasks(player)
                    end
                    
                end)
            --หน้ากาก
            elseif data.item.name == "mask" then
                TriggerEvent('skinchanger:getSkin', function(skin)
                    if skin["mask_1"] == -1 then
    
                        local dict = "veh@bicycle@roadfront@base"
                        local anim = "put_on_helmet"
            
                        RequestAnimDict(dict)
                        while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
                        
                        TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
            
                        Wait(1000)
    
                        local accessorySkin = {}
                        accessorySkin['mask_1'] = data.item.itemnum
                        accessorySkin['mask_2'] = data.item.itemskin
                        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
                        ClearPedTasks(player)
                    else
    
                        if IsPedInAnyVehicle(PlayerPedId(), true) == false then
                            local dict = "veh@bike@common@front@base"
                            local anim = "take_off_helmet_walk"
    
                            RequestAnimDict(dict)
                            while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
                            
                            TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
                
                            Wait(800)
                        end
    
                        local accessorySkin = {}
                        accessorySkin['mask_1'] = -1
                        accessorySkin['mask_2'] = 0
                        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
                        ClearPedTasks(player)
                    end
                    
                end)
            --แวนตา
            elseif data.item.name == "glasses" then
                TriggerEvent('skinchanger:getSkin', function(skin)
                    if skin["glasses_1"] == -1 then
    
                        if IsPedInAnyVehicle(PlayerPedId(), true) == false then
                            local dict = "clothingspecs"
                            local anim = "try_glasses_positive_a"
                
                            RequestAnimDict(dict)
                            while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
                            
                            TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
                
                            Wait(800)
                        end
    
                        local accessorySkin = {}
                        accessorySkin['glasses_1'] = data.item.itemnum
                        accessorySkin['glasses_2'] = data.item.itemskin
                        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
                        ClearPedTasks(player)
    
                    else
    
                        if IsPedInAnyVehicle(PlayerPedId(), true) == false then
                            local dict = "clothingspecs"
                            local anim = "take_off"
                
                            RequestAnimDict(dict)
                            while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
                            
                            TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
                
                            Wait(1000)
                        end
    
                        local accessorySkin = {}
                        accessorySkin['glasses_1'] = -1
                        accessorySkin['glasses_2'] = 0
                        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
                        ClearPedTasks(player)
                    end
                    
                end)
            -- เสื้อยึด
            -- elseif data.item.name == "tshirt" then
            --     TriggerEvent('skinchanger:getSkin', function(skin)
            --         if skin["torso_1"] == 15 then
            --             if Config.Options.enabled and IsPedInAnyVehicle(PlayerPedId(), true) == false then
            --                 RequestAnimDict(Config.Options.dicton)
            --                 while (not HasAnimDictLoaded(Config.Options.dicton)) do Citizen.Wait(0) end
            --                 TaskPlayAnim(player, Config.Options.dicton, Config.Options.animon, 8.0, 1.0, -1, 0, 0.5, 0, 0)
            --                 Wait(2000)
            --             end
    
            --             local accessorySkin = {}
            --             accessorySkin['tshirt_1']   = data.item.itemnum
            --             accessorySkin['tshirt_2']   = data.item.itemskin
            --             accessorySkin['arms']       = data.item.itemnum2
            --             accessorySkin['arms_2']     = data.item.itemskin2
            --             accessorySkin['torso_1']    = data.item.itemnum3
            --             accessorySkin['torso_2']    = data.item.itemskin3
            --             accessorySkin['decals_1']   = data.item.itemnum4
            --             accessorySkin['decals_2']   = data.item.itemskin4
            --             skin['tshirt_1']            = data.item.itemnum
            --             skin['tshirt_2']            = data.item.itemskin
            --             skin['arms']                = data.item.itemnum2
            --             skin['arms_2']              = data.item.itemskin2
            --             skin['torso_1']             = data.item.itemnum3
            --             skin['torso_2']             = data.item.itemskin3
            --             skin['decals_1']            = data.item.itemnum4
            --             skin['decals_2']            = data.item.itemskin4
    
            --             TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
            --             TriggerServerEvent('esx_skin:save', skin)              
            --             TriggerEvent("pNotify:SendNotification", {
            --                 text = Config.Text.torsoon,
            --                 type = "success",
            --                 timeout = 2000,
            --                 layout = "bottomCenter",
            --                 queue = "global"
            --             })
    
            --             ClearPedTasks(player)
            --         elseif skin["torso_1"] ~= 15 then
            --             if Config.Options.enabledoff and IsPedInAnyVehicle(PlayerPedId(), true) == false then
            --                 RequestAnimDict(Config.Options.dictoff)
            --                 while (not HasAnimDictLoaded(Config.Options.dictoff)) do Citizen.Wait(0) end
            --                 TaskPlayAnim(player, Config.Options.dictoff, Config.Options.animoff, 8.0, 1.0, -1, 0, 0.3, 0, 0)
            --                 Wait(2000)
            --             end
    
            --             local accessorySkin = {}
            --             accessorySkin['tshirt_1'] = 15
            --             accessorySkin['tshirt_2'] = 0
            --             accessorySkin['torso_1'] = 15
            --             accessorySkin['torso_2'] = 0
            --             accessorySkin['arms'] = 15
            --             accessorySkin['arms_2'] = 0
            --             accessorySkin['decals_1'] = -1
            --             accessorySkin['decals_2'] = 0
    
            --             TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
            --             TriggerServerEvent('esx_skin:save', skin)
            --             TriggerEvent("pNotify:SendNotification", {
            --                 text = Config.Text.torsooff,
            --                 type = "error",
            --                 timeout = 2000,
            --                 layout = "bottomCenter",
            --                 queue = "global"
            --             })
            --             ClearPedTasks(player)
            --         end
            --     end)
            -- --กางเกง
            -- elseif data.item.name == "pants" then
            --     TriggerEvent('skinchanger:getSkin', function(skin)
            --         if skin["pants_1"] == 21 then
    
            --             if Config.Options.enabled and IsPedInAnyVehicle(PlayerPedId(), true) == false then
            --                 RequestAnimDict(Config.Options.dicton)
            --                 while (not HasAnimDictLoaded(Config.Options.dicton)) do Citizen.Wait(0) end
            --                 TaskPlayAnim(player, Config.Options.dicton, Config.Options.animon, 8.0, 1.0, -1, 0, 0.5, 0, 0)
            --                 Wait(2000)
            --             end
    
            --             local accessorySkin = {}
            --             accessorySkin['pants_1'] = data.item.itemnum
            --             accessorySkin['pants_2'] = data.item.itemskin
            --             skin['pants_1'] = data.item.itemnum
            --             skin['pants_2'] = data.item.itemskin
            --             TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
            --             TriggerServerEvent('esx_skin:save', skin)
            --             ClearPedTasks(player)
            --             TriggerEvent("pNotify:SendNotification", {
            --                 text = Config.Text.pantson,
            --                 type = "success",
            --                 timeout = 2000,
            --                 layout = "bottomCenter",
            --                 queue = "global"
            --             })
    
            --         else
    
            --             if Config.Options.enabledoff and IsPedInAnyVehicle(PlayerPedId(), true) == false then
            --                 RequestAnimDict(Config.Options.dictoff)
            --                 while (not HasAnimDictLoaded(Config.Options.dictoff)) do Citizen.Wait(0) end
            --                 TaskPlayAnim(player, Config.Options.dictoff, Config.Options.animoff, 8.0, 1.0, -1, 0, 0.3, 0, 0)
            --                 Wait(2000)
            --             end
    
            --             local accessorySkin = {}
            --             accessorySkin['pants_1'] = 21
            --             accessorySkin['pants_2'] = 0
            --             TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
            --             TriggerServerEvent('esx_skin:save', skin)
            --             ClearPedTasks(player)
            --             TriggerEvent("pNotify:SendNotification", {
            --                 text = Config.Text.pantsoff,
            --                 type = "error",
            --                 timeout = 2000,
            --                 layout = "bottomCenter",
            --                 queue = "global"
            --             })
            --         end
                    
            --     end)
            -- --รองเท้า
            -- elseif data.item.name == "shoes" then
            --     TriggerEvent('skinchanger:getSkin', function(skin)
            --         if skin["shoes_1"] == 34 then
    
            --             if Config.Options.enabled and IsPedInAnyVehicle(PlayerPedId(), true) == false then
            --                 RequestAnimDict(Config.Options.dicton)
            --                 while (not HasAnimDictLoaded(Config.Options.dicton)) do Citizen.Wait(0) end
            --                 TaskPlayAnim(player, Config.Options.dicton, Config.Options.animon, 8.0, 1.0, -1, 0, 0.5, 0, 0)
            --                 Wait(2000)
            --             end
    
            --             local accessorySkin = {}
            --             accessorySkin['shoes_1'] = data.item.itemnum
            --             accessorySkin['shoes_2'] = data.item.itemskin
            --             skin['shoes_1'] = data.item.itemnum
            --             skin['shoes_2'] = data.item.itemskin
            --             TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
            --             TriggerServerEvent('esx_skin:save', skin)
            --             ClearPedTasks(player)
            --             TriggerEvent("pNotify:SendNotification", {
            --                 text = Config.Text.shoeson,
            --                 type = "success",
            --                 timeout = 2000,
            --                 layout = "bottomCenter",
            --                 queue = "global"
            --             })
    
            --             ClearPedTasks(player)
            --         else
    
            --             if Config.Options.enabledoff and IsPedInAnyVehicle(PlayerPedId(), true) == false then
            --                 RequestAnimDict(Config.Options.dictoff)
            --                 while (not HasAnimDictLoaded(Config.Options.dictoff)) do Citizen.Wait(0) end
            --                 TaskPlayAnim(player, Config.Options.dictoff, Config.Options.animoff, 8.0, 1.0, -1, 0, 0.3, 0, 0)
            --                 Wait(2000)
            --             end
    
            --             local accessorySkin = {}
            --             accessorySkin['shoes_1'] = 34
            --             accessorySkin['shoes_2'] = 0
            --             TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
            --             TriggerServerEvent('esx_skin:save', skin)
            --             ClearPedTasks(player)
            --             TriggerEvent("pNotify:SendNotification", {
            --                 text = Config.Text.shoesoff,
            --                 type = "error",
            --                 timeout = 2000,
            --                 layout = "bottomCenter",
            --                 queue = "global"
            --             })
            --         end
            --     end)
            -- --กระเป๋า
            -- elseif data.item.name == "bags" then
            --     TriggerEvent('skinchanger:getSkin', function(skin)
            --         if skin["bags_1"] == -1 then
    
            --             if IsPedInAnyVehicle(PlayerPedId(), true) == false then
            --                 local dict = "mp_safehouseshower@male@"
            --                 local anim = "male_shower_undress_&_turn_on_water"
                
            --                 RequestAnimDict(dict)
            --                 while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
                            
            --                 TaskPlayAnim(player, dict, anim, 8.0, 1.0, -1, 0, 0.3, 0, 0 )
                
            --                 Wait(800)
            --             end
    
            --             local accessorySkin = {}
            --             accessorySkin['bags_1'] = data.item.itemnum
            --             accessorySkin['bags_2'] = data.item.itemskin
            --             TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
            --             ClearPedTasks(player)
            --         else
    
            --             if IsPedInAnyVehicle(PlayerPedId(), true) == false then
            --                 local dict = "mp_safehouseshower@male@"
            --                 local anim = "male_shower_undress_&_turn_on_water"
                
            --                 RequestAnimDict(dict)
            --                 while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
                            
            --                 TaskPlayAnim(player, dict, anim, 8.0, 1.0, -1, 0, 0.3, 0, 0 )
                
            --                 Wait(800)
            --             end
    
            --             local accessorySkin = {}
            --             accessorySkin['bags_1'] = -1
            --             accessorySkin['bags_2'] = 0
            --             TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
            --             ClearPedTasks(player)
            --         end
            --   end)	
            --ตางหู		  
            elseif data.item.name == "earring" then
                TriggerEvent('skinchanger:getSkin', function(skin)
                    if skin["ears_1"] == -1 then
                        if IsPedInAnyVehicle(PlayerPedId(), true) == false then
                            local dict = "mini@ears_defenders"
                            local anim = "takeoff_earsdefenders_idle"
                            RequestAnimDict(dict)
                            while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
                            TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
                            Wait(800)
                        end
                        local accessorySkin = {}
                        accessorySkin['ears_1'] = data.item.itemnum
                        accessorySkin['ears_2'] = data.item.itemskin
                        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
                        ClearPedTasks(player)
                    else
                        if IsPedInAnyVehicle(PlayerPedId(), true) == false then
                            local dict = "mini@ears_defenders"
                            local anim = "takeoff_earsdefenders_idle"
                            RequestAnimDict(dict)
                            while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
                            TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
                            Wait(800)
                        end
                        local accessorySkin = {}
                        accessorySkin['ears_1'] = -1
                        accessorySkin['ears_2'] = 0
                        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
                        ClearPedTasks(player)
                    end
                end)
            -- เสื้อเกราะ
            elseif data.item.name == "bproof" then
                TriggerEvent('skinchanger:getSkin', function(skin)
                    if skin["bproof_1"] == -1 then
                        if Config.Options.enabled and IsPedInAnyVehicle(PlayerPedId(), true) == false then
                            RequestAnimDict(Config.Options.dicton)
                            while (not HasAnimDictLoaded(Config.Options.dicton)) do Citizen.Wait(0) end
                            TaskPlayAnim(player, Config.Options.dicton, Config.Options.animon, 8.0, 1.0, -1, 0, 0.5, 0, 0)
                            Wait(2000)
                        end
    
                        local accessorySkin = {}
                        accessorySkin['bproof_1']   = data.item.itemnum
                        accessorySkin['bproof_2']   = data.item.itemskin
                        skin['bproof_1']            = data.item.itemnum
                        skin['bproof_2']            = data.item.itemskin
    
                        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
                        TriggerServerEvent('esx_skin:save', skin)              
                        TriggerEvent("pNotify:SendNotification", {
                            text = Config.Text.torsoon,
                            type = "success",
                            timeout = 2000,
                            layout = "bottomCenter",
                            queue = "global"
                        })
    
                        ClearPedTasks(player)
                    else
    
                        if Config.Options.enabledoff and IsPedInAnyVehicle(PlayerPedId(), true) == false then
                            RequestAnimDict(Config.Options.dictoff)
                            while (not HasAnimDictLoaded(Config.Options.dictoff)) do Citizen.Wait(0) end
                            TaskPlayAnim(player, Config.Options.dictoff, Config.Options.animoff, 8.0, 1.0, -1, 0, 0.3, 0, 0)
                            Wait(2000)
                        end
    
                        local accessorySkin = {}
                        accessorySkin['bproof_1'] = -1
                        accessorySkin['bproof_2'] = 0
    
                        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
                        TriggerServerEvent('esx_skin:save', skin)
                        TriggerEvent("pNotify:SendNotification", {
                            text = Config.Text.torsooff,
                            type = "error",
                            timeout = 2000,
                            layout = "bottomCenter",
                            queue = "global"
                        })
                        ClearPedTasks(player)
                    end
                end)
            -- สร้อยคอ
            elseif data.item.name == "chain" then
                TriggerEvent('skinchanger:getSkin', function(skin)
                    if skin["chain_1"] == -1 then
                        if Config.Options.enabled and IsPedInAnyVehicle(PlayerPedId(), true) == false then
                            RequestAnimDict(Config.Options.dicton)
                            while (not HasAnimDictLoaded(Config.Options.dicton)) do Citizen.Wait(0) end
                            TaskPlayAnim(player, Config.Options.dicton, Config.Options.animon, 8.0, 1.0, -1, 0, 0.5, 0, 0)
                            Wait(2000)
                        end
    
                        local accessorySkin = {}
                        accessorySkin['chain_1']   = data.item.itemnum
                        accessorySkin['chain_2']   = data.item.itemskin
                        skin['chain_1']            = data.item.itemnum
                        skin['chain_2']            = data.item.itemskin
    
                        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
                        TriggerServerEvent('esx_skin:save', skin)              
                        TriggerEvent("pNotify:SendNotification", {
                            text = Config.Text.torsoon,
                            type = "success",
                            timeout = 2000,
                            layout = "bottomCenter",
                            queue = "global"
                        })
    
                        ClearPedTasks(player)
                    else
                        if Config.Options.enabledoff and IsPedInAnyVehicle(PlayerPedId(), true) == false then
                            RequestAnimDict(Config.Options.dictoff)
                            while (not HasAnimDictLoaded(Config.Options.dictoff)) do Citizen.Wait(0) end
                            TaskPlayAnim(player, Config.Options.dictoff, Config.Options.animoff, 8.0, 1.0, -1, 0, 0.3, 0, 0)
                            Wait(2000)
                        end
    
                        local accessorySkin = {}
                        accessorySkin['chain_1'] = -1
                        accessorySkin['chain_2'] = 0
    
                        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
                        TriggerServerEvent('esx_skin:save', skin)
                        TriggerEvent("pNotify:SendNotification", {
                            text = Config.Text.torsooff,
                            type = "error",
                            timeout = 2000,
                            layout = "bottomCenter",
                            queue = "global"
                        })
                        ClearPedTasks(player)
                    end
                end)
            -- นาฬิกาข้อมือ
            elseif data.item.name == "watches" then
                TriggerEvent('skinchanger:getSkin', function(skin)
                    if skin["watches_1"] == -1 then
                        if Config.Options.enabled and IsPedInAnyVehicle(PlayerPedId(), true) == false then
                            RequestAnimDict(Config.Options.dicton)
                            while (not HasAnimDictLoaded(Config.Options.dicton)) do Citizen.Wait(0) end
                            TaskPlayAnim(player, Config.Options.dicton, Config.Options.animon, 8.0, 1.0, -1, 0, 0.5, 0, 0)
                            Wait(2000)
                        end
    
                        local accessorySkin = {}
                        accessorySkin['watches_1']   = data.item.itemnum
                        accessorySkin['watches_2']   = data.item.itemskin
                        skin['watches_1']            = data.item.itemnum
                        skin['watches_2']            = data.item.itemskin
    
                        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
                        TriggerServerEvent('esx_skin:save', skin)              
                        TriggerEvent("pNotify:SendNotification", {
                            text = Config.Text.torsoon,
                            type = "success",
                            timeout = 2000,
                            layout = "bottomCenter",
                            queue = "global"
                        })
    
                        ClearPedTasks(player)
                    else
    
                        if Config.Options.enabledoff and IsPedInAnyVehicle(PlayerPedId(), true) == false then
                            RequestAnimDict(Config.Options.dictoff)
                            while (not HasAnimDictLoaded(Config.Options.dictoff)) do Citizen.Wait(0) end
                            TaskPlayAnim(player, Config.Options.dictoff, Config.Options.animoff, 8.0, 1.0, -1, 0, 0.3, 0, 0)
                            Wait(2000)
                        end
    
                        local accessorySkin = {}
                        accessorySkin['watches_1'] = -1
                        accessorySkin['watches_2'] = 0
    
                        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
                        TriggerServerEvent('esx_skin:save', skin)
                        TriggerEvent("pNotify:SendNotification", {
                            text = Config.Text.torsooff,
                            type = "error",
                            timeout = 2000,
                            layout = "bottomCenter",
                            queue = "global"
                        })
                        ClearPedTasks(player)
                    end
                end)
            -- สร้อยข้อมือ
            elseif data.item.name == "bracelets" then
                TriggerEvent('skinchanger:getSkin', function(skin)
                    if skin["bracelets_1"] == -1 then
                        if Config.Options.enabled and IsPedInAnyVehicle(PlayerPedId(), true) == false then
                            RequestAnimDict(Config.Options.dicton)
                            while (not HasAnimDictLoaded(Config.Options.dicton)) do Citizen.Wait(0) end
                            TaskPlayAnim(player, Config.Options.dicton, Config.Options.animon, 8.0, 1.0, -1, 0, 0.5, 0, 0)
                            Wait(2000)
                        end
    
                        local accessorySkin = {}
                        accessorySkin['bracelets_1']   = data.item.itemnum
                        accessorySkin['bracelets_2']   = data.item.itemskin
                        skin['bracelets_1']            = data.item.itemnum
                        skin['bracelets_2']            = data.item.itemskin
    
                        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
                        TriggerServerEvent('esx_skin:save', skin)              
                        TriggerEvent("pNotify:SendNotification", {
                            text = Config.Text.torsoon,
                            type = "success",
                            timeout = 2000,
                            layout = "bottomCenter",
                            queue = "global"
                        })
    
                        ClearPedTasks(player)
                    else
                        if Config.Options.enabledoff and IsPedInAnyVehicle(PlayerPedId(), true) == false then
                            RequestAnimDict(Config.Options.dictoff)
                            while (not HasAnimDictLoaded(Config.Options.dictoff)) do Citizen.Wait(0) end
                            TaskPlayAnim(player, Config.Options.dictoff, Config.Options.animoff, 8.0, 1.0, -1, 0, 0.3, 0, 0)
                            Wait(2000)
                        end
    
                        local accessorySkin = {}
                        accessorySkin['bracelets_1'] = -1
                        accessorySkin['bracelets_2'] = 0
    
                        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
                        TriggerServerEvent('esx_skin:save', skin)
                        TriggerEvent("mythic_notify:SendAlert", {
                            text = Config.Text.torsooff,
                            type = "error",
                            timeout = 3000,
                            layout = "bottomCenter",
                            queue = "global"
                        })
                        ClearPedTasks(player)
                    end
                end)
            end
        else
            TriggerServerEvent("esx:useItem", data.item.name)
            if ItemCloseInventory(data.item.name) then
                closeInventory()
            else	
                Citizen.Wait(500)
                loadPlayerInventory()
            end
        end
    cb("ok")
end)

RegisterNUICallback(
    "DropItem",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end
		
		 if Config.disableDrop and Config.disableDrop[data.item.name] then
            exports['mythic_notify']:SendAlert('error', 'ไม่สามารถทิ้งได้')
                 closeInventory()
		 	return
	     end
		
		
		 if data.item.type == "item_weapon" then
            exports['mythic_notify']:SendAlert('error', 'ไม่สามารถทิ้งได้')
             closeInventory()
		 	return
		 end
		
		RequestAnimDict("amb@medic@standing@kneel@base")
		TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base", "base", 8.0, -8.0, -1, 1, 0, false, false, false)
		
		local lPed = GetPlayerPed(-1)

        if type(data.number) == "number" and math.floor(data.number) == data.number then
			if not IsPedInAnyVehicle(lPed, false) and not IsPedSwimming(lPed) and not IsPedShooting(lPed) and not IsPedClimbing(lPed) and not IsPedDiving(lPed) and not IsPedFalling(lPed) and not IsPedJumping(lPed) and not IsPedJumpingOutOfVehicle(lPed) and IsPedOnFoot(lPed) and not IsPedRunning(lPed) and not IsPedUsingAnyScenario(lPed) and not IsPedInParachuteFreeFall(lPed) then
				TriggerEvent("Fxw_inventory:closeInventory")
				
				ESX.UI.Menu.CloseAll()

				ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'Drop_Menu',
				{
				  title    = ' '..data.item.label..' x'..data.number..'',
				  align    = 'top-left',
				  elements = {
					{label = ('Yes'), value = 'yes', itemlabel = data.item.label, itemtype = data.item.type, itemname = data.item.name, itemnumber = data.number},
					{label = ('No'), value = 'no'}
				  }
				},
				
				function(datamenu, menu)
				  if datamenu.current.value == 'yes' then
					menu.close()
					ClearPedTasks(PlayerPedId())
					Citizen.CreateThread(function()
                        exports['mythic_notify']:SendAlert('success', 'ทำการทิ้ง '..data.item.label..' จำนวน '..data.number..' ชิ้น')
						Wait(500)
						if string.find(data.item.type, "car_key_") then
							local plate = string.gsub(data.item.type, "car_key_", "")
							-- TriggerServerEvent("scotty:dropKey", string.upper(plate))
						else
							TriggerServerEvent("esx:removeInventoryItem", datamenu.current.itemtype, datamenu.current.itemname, datamenu.current.itemnumber)
                            
						end
					end)
				  elseif datamenu.current.value == 'no' then
					menu.close()
					ClearPedTasks(PlayerPedId())
				  end

				end,
				function(data, menu)
				  menu.close()
				  ClearPedTasks(PlayerPedId())
				end)
			end
        end

        Wait(250)
        loadPlayerInventory(false)

        cb("ok")
    end
)

RegisterNUICallback(
    "GiveItem",
    function(data, cb)
        local playerTemp
        local playerPed = PlayerPedId()
		local DataPlayer = tonumber(data.player)
        local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 3.0)
        local foundPlayer = false
        for i = 1, #players, 1 do
            if players[i] ~= PlayerId() then
                if GetPlayerServerId(players[i]) == DataPlayer then
                    foundPlayer = true
                    playerTemp = GetPlayerServerId(players[i])
                end
            end
        end

		if Config.disableGive and Config.disableGive[data.item.name] then
			exports['mythic_notify']:SendAlert('error', 'ของชิ้นนี้ไม่สามารถให้กันได้')
			return
		end
		
		if data.item.type == "item_weapon" then
			exports['mythic_notify']:SendAlert('success', 'ไม่สามารถให้อาวุธกันได้')
			return
		end

        if foundPlayer then
            local count = tonumber(data.number)
			
			if data.item.type == "item_weapon" then
                count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
            end
        
        if string.find(data.item.type, "house_keys_") then
            local house_ident = string.gsub(data.item.type, "house_keys_", "")
            TriggerServerEvent("scotty-housekeys:giveHouseKey", data.player, house_ident)
            Wait(500)
            loadPlayerInventory()
            return
        end
			
        local lPed = GetPlayerPed(-1)
        if not IsPedInAnyVehicle(lPed, false) and IsPedOnFoot(lPed) and not IsPedUsingAnyScenario(lPed) and string.find(data.item.type, "car_key_") then
               local plate = string.gsub(data.item.type, "car_key_", "")
               TriggerServerEvent("scotty:giveCarKey", data.player, plate)
            elseif data.item.type == "item_key" then
                TriggerServerEvent("caruby_invenkeys:giveKey", data.player, data.item.type, data.item.label)
                TriggerServerEvent("Fxw_inventory:updateKey", data.player, data.item.type, data.item.label)
		    elseif data.item.type == "item_keyhouse" then
                TriggerServerEvent("Fxw_inventory:updateKey", data.player, data.item.type, data.item.house_id)
            else
                --TriggerServerEvent('Fxw_inventory:server:RequestFeedback', playerTemp, data)	
                TriggerEvent('xzero_giveui:client:On_GiveItem', data)
                TriggerEvent('monster_giveui:client:On_GiveItem', data)
                TriggerServerEvent("esx:giveInventoryItem", DataPlayer, data.item.type, data.item.name, count)
            end
			
            ESX.Streaming.RequestAnimDict("gestures@m@car@low@casual@ps", function()
				TaskPlayAnim(PlayerPedId(), "gestures@m@car@low@casual@ps", "gesture_you_soft", 8.0, -8.0, -1, 48, 0, false, false, false)
			end)



            
			closeInventory()
			Wait(1500)
            loadPlayerInventory()			
        else
            exports['mythic_notify']:SendAlert('error', 'ไม่พบเจอผู้เล่นที่อยู่ใกล้ๆ')
        end
		-- closeInventory()
        Citizen.Wait(1500)
        loadPlayerInventory()
    cb("ok")
end)

RegisterNUICallback("UseMask",function(data, cb)
    if data.item.type == "item_accessories" then
        local player = GetPlayerPed(-1)

        closeInventory()
       
        -- if data.item.name == "helmet" then
        --     TriggerEvent('skinchanger:getSkin', function(skin)
        --         if skin["helmet_1"] == -1 then

        --             local dict = "veh@bicycle@roadfront@base"
        --             local anim = "put_on_helmet"
        
        --             RequestAnimDict(dict)
        --             while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
                    
        --             TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
        
        --             Wait(1000)

        --             local accessorySkin = {}
        --             accessorySkin['helmet_1'] = data.item.itemnum
        --             accessorySkin['helmet_2'] = data.item.itemskin

        --             TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
        --         else

        --              if IsPedInAnyVehicle(PlayerPedId(), true) == false then
        --                 local dict = "veh@bike@common@front@base"
        --                 local anim = "take_off_helmet_walk"

        --                 RequestAnimDict(dict)
        --                 while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
                        
        --                 TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
            
        --                 Wait(800)
        --             end

        --             local accessorySkin = {}
        --             accessorySkin['helmet_1'] = -1
        --             accessorySkin['helmet_2'] = 0
        --             TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
        --         end
                
        --     end)
        -- else
        if data.item.name == "mask" then
            TriggerEvent('skinchanger:getSkin', function(skin)
                if skin["mask_1"] == -1 then

                    local dict = "veh@bicycle@roadfront@base"
                    local anim = "put_on_helmet"
        
                    RequestAnimDict(dict)
                    while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
                    
                    TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
        
                    Wait(1000)

                    local accessorySkin = {}
                    accessorySkin['mask_1'] = data.item.itemnum
                    accessorySkin['mask_2'] = data.item.itemskin
                    TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
                else

                    if IsPedInAnyVehicle(PlayerPedId(), true) == false then
                        local dict = "veh@bike@common@front@base"
                        local anim = "take_off_helmet_walk"

                        RequestAnimDict(dict)
                        while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
                        
                        TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
            
                        Wait(800)
                    end

                    local accessorySkin = {}
                    accessorySkin['mask_1'] = -1
                    accessorySkin['mask_2'] = 0
                    TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
                end
                
            end)
        elseif data.item.name == "glasses" then
            TriggerEvent('skinchanger:getSkin', function(skin)
                if skin["glasses_1"] == -1 then

                    if IsPedInAnyVehicle(PlayerPedId(), true) == false then
                        local dict = "clothingspecs"
                        local anim = "try_glasses_positive_a"
            
                        RequestAnimDict(dict)
                        while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
                        
                        TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
            
                        Wait(800)
                    end

                    local accessorySkin = {}
                    accessorySkin['glasses_1'] = data.item.itemnum
                    accessorySkin['glasses_2'] = data.item.itemskin
                    TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)

                    ClearPedTasks(player)
                else

                    if IsPedInAnyVehicle(PlayerPedId(), true) == false then
                        local dict = "clothingspecs"
                        local anim = "take_off"
            
                        RequestAnimDict(dict)
                        while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
                        
                        TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
            
                        Wait(1000)
                    end

                    local accessorySkin = {}
                    accessorySkin['glasses_1'] = -1
                    accessorySkin['glasses_2'] = 0
                    TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
                end
                
            end)
        -- elseif data.item.name == "earring" then
        --     TriggerEvent('skinchanger:getSkin', function(skin)
        --         if skin["ears_1"] == -1 then

        --             if IsPedInAnyVehicle(PlayerPedId(), true) == false then
        --                 local dict = "mini@ears_defenders"
        --                 local anim = "takeoff_earsdefenders_idle"
            
        --                 RequestAnimDict(dict)
        --                 while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
                        
        --                 TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
            
        --                 Wait(800)
        --             end

        --             local accessorySkin = {}
        --             accessorySkin['ears_1'] = data.item.itemnum
        --             accessorySkin['ears_2'] = data.item.itemskin
        --             TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
        --         else

        --             if IsPedInAnyVehicle(PlayerPedId(), true) == false then
        --                 local dict = "mini@ears_defenders"
        --                 local anim = "takeoff_earsdefenders_idle"
            
        --                 RequestAnimDict(dict)
        --                 while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
                        
        --                 TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
            
        --                 Wait(800)
        --             end

        --             local accessorySkin = {}
        --             accessorySkin['ears_1'] = -1
        --             accessorySkin['ears_2'] = 0
        --             TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
        --         end 
        --     end)
        end
    end
end)

function shouldSkipAccount(accountName)
    for index, value in ipairs(Config.ExcludeAccountsList) do
        if value == accountName then
            return true
        end
    end
    return false
end

RegisterNetEvent("Fxw_inventory:closeHud")
AddEventHandler("Fxw_inventory:closeHud",function()
    closeInventory()
end)

AddEventHandler("Fxw_inventory:closeInventory", function()
    TriggerEvent('nc:close')
    closeInventory()
end) 

RegisterCommand('bags', function()
    TriggerEvent('Fxw_inventory:closeInventory')
    exports['mythic_notify']:SendAlert('success', 'ปิดกระเป๋าแล้ว')
end)

function ItemCloseInventory(itemName)
    for index, value in ipairs(Config.CloseUiItems) do
        if value == itemName then
            return true
        end
    end

    return false
end

RegisterNetEvent('Fxw_inventory:closeInventory2')
AddEventHandler('Fxw_inventory:closeInventory2', function()
    closeInventory()
end)

