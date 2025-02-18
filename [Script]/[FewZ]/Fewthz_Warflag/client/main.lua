local Keys = {
        ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
        ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
        ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
        ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
        ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
        ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
        ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
        ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
        ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX                           = nil

FewZ = GetCurrentResourceName()
Config = nil


Citizen.CreateThread(function()
        while ESX == nil do
                TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
                Citizen.Wait(0)
        end

        while ESX.GetPlayerData().job == nil do
                Citizen.Wait(100)
        end

        ESX.PlayerData = ESX.GetPlayerData()
        TriggerServerEvent(FewZ .. ':server:LoadConfig')
end)

RegisterNetEvent(FewZ .. ':client:GetConfig')
AddEventHandler(FewZ .. ':client:GetConfig', function(f)
        Config = f
        while Config == nil do
                Citizen.Wait(200)
        end
        if Config  then
                LoadEvent()
        end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
        print ('LOAD')
        ESX.TriggerServerCallback('FewZ:Gamestatus', function(status)
                if status then
                        TriggerServerEvent('FewZ:checkStart')
                end
        end)
end)


function LoadEvent()
        local FlagLocation = nil
        local EventStart = false
        local secLeft = 0
        local secWin = 0
        local secWinFlag = 20
        local LaFlag = false
        local HoldID = 0
        local ShowMenu = false
        local HoldFlagName = nil
        local ServerPlayerID = GetPlayerServerId(PlayerId())
        local OutZone = false
        local isDead = false




        function LoadAnimDict(dict)
                while (not HasAnimDictLoaded(dict)) do
                        RequestAnimDict(dict)
                        Citizen.Wait(10)
                end
        end

        AddEventHandler('esx:onPlayerDeath', function()
                isDead = true
                if ServerPlayerID == HoldID and HoldID ~= 0 then
                        HoldID = 0
                        local playerPed = PlayerPedId()
                        local playerCoords = GetEntityCoords(playerPed)
                        TriggerServerEvent('FewZ_Warflag:onPlayerDeath', ServerPlayerID, playerCoords)
                end
        end)

        AddEventHandler('esx:onPlayerSpawn', function()
                isDead = false
        end)




Citizen.CreateThread(function()

        for k, v in pairs(Config['FlagPoint']) do
                local blip = AddBlipForCoord(v.x,v.y,v.z)

                SetBlipHighDetail(blip, true)
                SetBlipSprite (blip, Config['Blip']['Sprite'])
                SetBlipScale  (blip, Config['Blip']['Scale'])
                SetBlipColour (blip, Config['Blip']['Colour'])
                SetBlipAsShortRange(blip, true)

                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(Config['Blip']['Name'])
                EndTextCommandSetBlipName(blip)

                local BlipRadius = AddBlipForRadius(v.x,v.y,v.z, Config['BlipRadius'].blip.Radius)
                SetBlipColour(BlipRadius, Config['BlipRadius'].blip.Colour)
                SetBlipAlpha(BlipRadius, 100)

        end

        while true do
                Citizen.Wait(1000)
                if EventStart then
                        if(secLeft > 0)then
                                secLeft = secLeft - 1
                                if secWin > 0 then
                                        secWin = secWin - 1
                                end
                        end
                end
        end
end)

        Citizen.CreateThread(function()
                while true do
                        Citizen.Wait(500)
                        if EventStart then
                                if(secLeft > 0)then
                                        if not ShowMenu then

                                                SendNUIMessage({ showmenu = true,text = 'ชิงธง :  '..HoldFlagName..' ['..secWin..']' , text2 = 'เหลือเวลา : '..secLeft..' วินาที' })

                                                ShowMenu = true
                                        else
                                                SendNUIMessage({ text = 'ชิงธง :  '..HoldFlagName..' ['..secWin..']' , text2 = 'เหลือเวลา : '..secLeft..' วินาที' })
                                        end
                                else
                                        if ShowMenu then
                                                SendNUIMessage({ hidemenu = true , text ='', text2 = ''})
                                                ShowMenu = false

                                        end
                                        HoldID = 0
                                        EventStart = false
                                        LaFlag = true
                                end

                        else
                                if LaFlag and (secWinFlag > 0) then

                                        secWinFlag = secWinFlag - 1
                                        SendNUIMessage({ showmenu = true, text = 'The Winner', text2 = 'Flag King :'..HoldFlagName..''})

                                else

                                        SendNUIMessage({ hidemenu = true , text ='', text2 = ''})
                                        LaFlag = false

                                end
                        end
                end
        end)

        Citizen.CreateThread(function()
                while true do
                        Citizen.Wait(0)
                        if EventStart then
                                local playerPed = PlayerPedId()
                                local coords = GetEntityCoords(PlayerPedId())

                                if secLeft > 0 then

                                        if GetDistanceBetweenCoords(coords, FlagLocation, true) < 2 and HoldID == 0 and not IsEntityDead(PlayerPedId()) then
                                                ShowToolTip(Config['Control']['Press'], FlagLocation)

                                                if IsControlJustReleased(0, Config['Control']['Capture']) then
                                                        print('^2Capture^0:flag')
                                                        captureFlag()
                                                end

                                        end
                                   for p, v in pairs(Config['FlagHealPoint']) do
                                                local DistanceCheck = GetDistanceBetweenCoords(coords, v["x"], v["y"], v["z"], true)
                                                if DistanceCheck <= Config['Markerheal']['Distance'] then
                                                        DrawMarker(Config['Markerheal']['Type'], v["x"], v["y"], v["z"], 0.0, 0.0, 0.0, Config['Markerheal']['X'], 0.0, Config['Markerheal']['Y'], Config['Markerheal']['vx'], Config['Markerheal']['vy'], Config['Markerheal']['vz'], Config['Markerheal']['R'], Config['Markerheal']['G'], Config['Markerheal']['B'], Config['Markerheal']['Thickness'], true, true, 2, false, false, false, false)
                                                end

                                                if DistanceCheck <= Config['Markerheal']['Txt'] then
                                                        DrawText3D(v, Config['Control']['Txtheal'], 1)
                                                        if DistanceCheck <= Config['DistanceCheck'] then
                                                                if IsControlJustPressed(0, Config['Control']['Heal']) then
                                                                        TriggerEvent("mythic_progbar:client:progress", {
                                                                                name = "unique_action_name",
                                                                                duration = Config['Progbar']['Time3'],
                                                                                label = Config['Progbar']['Label3'],
                                                                                useWhileDead = false,
                                                                                canCancel = true,
                                                                                controlDisables = {
                                                                                        disableMovement = true,
                                                                                        disableCarMovement = true,
                                                                                        disableMouse = false,
                                                                                        disableCombat = true,
                                                                                },
                                                                                animation = {
                                                                                        animDict = Config['Progbar']['animDict2'],
                                                                                        anim =  Config['Progbar']['anim2'],
                                                                                        },
                                                                                }, function(status)
                                                                                if not status and not IsEntityDead(PlayerPedId()) then
                                                                                        cancel = false
                                                                                        ClearPedTasks(PlayerPedId())
                                                                                        TriggerEvent('FewZ_Warflag:FlagSetHealth',_source)
                                                                                        TriggerServerEvent('FewZ_Warflag:flagheal')
                                                                                else
                                                                                        ClearPedTasks(PlayerPedId())
                                                                                        cancel = true
                                                                                end
                                                                        end)
                                                                end
                                                        end
                                                end
                                    end

                                        if HoldID ~= 0 then

                                                if GetPlayerFromServerId(HoldID) ~= -1 then
                                                        local playerflagcoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(HoldID)))
                                                        for k, v in pairs(Config['FlagPoint']) do
                                                                if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Config['Distance']   then
                                                                        local x1 ,y1, z1 = table.unpack(playerflagcoords)
                                                                        DrawMarker(0, x1, y1, z1+1.5, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, Config['DrawColerall']['King']['R'], Config['DrawColerall']['King']['G'], Config['DrawColerall']['King']['B'], 165, 1,0, 0,1)
                                                                        DrawMarker(0, x1, y1, z1+2.2, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, Config['DrawColerall']['King']['R'], Config['DrawColerall']['King']['G'], Config['DrawColerall']['King']['B'], 165, 1,0, 0,1)
                                                                        DrawMarker(0, x1, y1, z1+2.8, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, Config['DrawColerall']['King']['R'], Config['DrawColerall']['King']['G'], Config['DrawColerall']['King']['B'], 165, 1,0, 0,1)
                                                                end
                                                        end
                                                end
                                        else
                                                for k, v in pairs(Config['FlagPoint']) do
                                                        if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Config['Distance'] then
                                                                local x1 ,y1, z1 = table.unpack(FlagLocation)
                                                                DrawMarker(1, x1, y1, z1-5, 0, 0, 0, 0, 0, 0, 0.1, 0.1, 100.0, Config['DrawColerall']['Point']['R'], Config['DrawColerall']['Point']['G'], Config['DrawColerall']['Point']['B'], 100, 0, 0, 0,1)
                                                        end
                                                end
                                        end
                                end
                        else
                                Wait(1000)
                        end
                end
        end)


        function captureFlag()
                TriggerEvent("mythic_progbar:client:progress", {
                        name = "unique_action_name",
                        duration = Config['Progbar']['Time'],
                        label = Config['Progbar']['Label'],
                        useWhileDead = false,
                        canCancel = true,
                        controlDisables = {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                        },
                        animation = {
                                animDict = Config['Progbar']['animDict'],
                                anim =  Config['Progbar']['anim'],
                                flags = 1,
                        },
                }, function(status)
                        if not status and not IsEntityDead(PlayerPedId()) then
                                cancel = false
                                ClearPedTasks(PlayerPedId())
                                TriggerServerEvent('FewZ_Warflag:pickupflag')

                        else
                                ClearPedTasks(PlayerPedId())
                                cancel = true
                        end
                end)
        end

        Citizen.CreateThread(function()
                while true do
                        Citizen.Wait(5)
                        if EventStart then
                                if ServerPlayerID == HoldID and not OutZone then
                                        local pos = GetEntityCoords(GetPlayerPed(-1), true)

                                        for k, v in pairs(Config['FlagPoint']) do
                                                if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) > Config['Distance'])then
                                                        TriggerServerEvent('FewZ_Warflag:toofar')
                                                        OutZone = true
                                                end
                                        end
                                else
                                        local pos = GetEntityCoords(GetPlayerPed(-1), true)
                                        for k, v in pairs(Config['FlagPoint']) do
                                                if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < Config['Distance']) then
                                                        OutZone = false
                                                end
                                        end
                                end
                        else
                                Wait(1000)
                        end
                end
        end)

        Citizen.CreateThread(function()
                while true do
                        Citizen.Wait(5)
                        if EventStart then

                                if secLeft > 0 then
                                        local pos = GetEntityCoords(GetPlayerPed(-1), true)
                                        for k, v in pairs(Config['FlagPoint']) do
                                                if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < Config['Distance']) then

                                                        if isDead then
                                                                exports['mythic_progbar']:Progress({
                                                                        name = "unique_action_name",
                                                                        duration = Config['Progbar']['Time2'],
                                                                        label = Config['Progbar']['Label2'],
                                                                        useWhileDead = true,
                                                                        canCancel = false,
                                                                        controlDisables = {
                                                                                disableMovement = true,
                                                                                disableCarMovement = true,
                                                                                disableMouse = false,
                                                                                disableCombat = true,
                                                                        },
                                                                }, function(cancelled)
                                                                        if not cancelled then
                                                                                TriggerEvent('esx_ambulancejob:reviveflag', true, Config['SpawnPlayer'])

                                                                                isDead = false
                                                                        end
                                                                end)
                                                                Citizen.Wait(Config['Progbar']['Time2'])
                                                        end
                                                        DisableControlAction(0, 56, true)
                                                        DisableControlAction(0, 167, true)
                                                        DisableControlAction(0, 170, true)
                                                        DisableControlAction(0, 36, true)
                                                        DisableControlAction(0, 47, true)
                                                end
                                        end
                                end
                        else
                                Wait(1000)
                        end
                end
        end)

        RegisterNetEvent('esx_ambulancejob:reviveflag')
        AddEventHandler('esx_ambulancejob:reviveflag', function(notupdate)
        	local playerPed = PlayerPedId()
        	local coords = GetEntityCoords(playerPed)

        	FreezeEntityPosition(playerPed, true)
        	Wait(100)

                if notupdate then
        	        TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)
                end

        	DoScreenFadeOut(800)
        
        	while not IsScreenFadedOut() do
        	  Wait(50)
        	end
        
        	local formattedCoords = {x = ESX.Math.Round(coords.x, 1), y = ESX.Math.Round(coords.y, 1), z = ESX.Math.Round(coords.z, 1)}
        
        	RespawnPedFlag(playerPed, formattedCoords, 0.0)
        	isDead = false
        
        	StopScreenEffect('')
        	DoScreenFadeIn(800)
        	Wait(100)
        	FreezeEntityPosition(playerPed, false)
        end)

        function RespawnPedFlag(ped, coords, heading)
                SetEntityCoordsNoOffset(ped, Config['SpawnPlayer'].x, Config['SpawnPlayer'].y, Config['SpawnPlayer'].z, false, false, false, true)
                NetworkResurrectLocalPlayer(Config['SpawnPlayer'].x, Config['SpawnPlayer'].y, Config['SpawnPlayer'].z, heading, true, false)
                SetPlayerInvincible(ped, false)
                TriggerEvent('playerSpawned', Config['SpawnPlayer'].x, Config['SpawnPlayer'].y, Config['SpawnPlayer'].z)
                ClearPedBloodDamage(ped)
                SetEntityHealth(ped, 110)

                ESX.UI.Menu.CloseAll()
        end


        RegisterNetEvent('FewZ_Warflag:StartEvent')
        AddEventHandler('FewZ_Warflag:StartEvent', function(WarStartServer, TimerStart)
                print('^2Start^0:Flag')
                print('^2Start^0:SpawnFlag')
                spawnFlag(Config['FirstFlagSpawn'])
                HoldFlagName = Config['HoldFlagName']
                EventStart = WarStartServer
                secLeft = TimerStart
                HoldID = 0
        end)

        RegisterNetEvent('FewZ_Warflag:stopEvent')
        AddEventHandler('FewZ_Warflag:stopEvent', function()
                secLeft = 0
                secWin = 0
                HoldID = 0
                local pos = GetEntityCoords(GetPlayerPed(-1), true)
                for k, v in pairs(Config['FlagPoint']) do
                        local DistanceCheck = GetDistanceBetweenCoords(pos, v["x"], v["y"], v["z"], true)
                        if DistanceCheck < Config['Distance'] then
                                SetEntityHealth(PlayerPedId(), 200)
                        end
                end
        end)

        RegisterNetEvent('FewZ_Warflag:setkingname')
        AddEventHandler('FewZ_Warflag:setkingname', function(timer, name, source, TimeNow)
                secLeft = math.floor(TimeNow)
                secWin = timer
                HoldID = source
                HoldFlagName = name
                local pos = GetEntityCoords(GetPlayerPed(-1), true)
                for k, v in pairs(Config['FlagPoint']) do
                        if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < Config['Distance']) then
                        end
                end

        end)

        RegisterNetEvent('FewZ_Warflag:setkingout')
        AddEventHandler('FewZ_Warflag:setkingout', function(TimeNow, playerCoords)
                local coords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(HoldID)))
                TriggerServerEvent('FewZ_Warflag:flagdrop', playerCoords)
                print(TimeNow)
                secLeft = math.floor(TimeNow)
                secWin = 0
                HoldID = 0
                HoldFlagName = Config['HoldFlagName']
        end)

        RegisterNetEvent('FewZ_Warflag:setkingoutdrop')
        AddEventHandler('FewZ_Warflag:setkingoutdrop', function(TimeNow)
                TriggerServerEvent('FewZ_Warflag:flagdrop', Config['FirstFlagSpawn'])
                secLeft = math.floor(TimeNow)
                secWin = 0
                HoldID = 0
                HoldFlagName = Config['HoldFlagName']
        end)

        RegisterNetEvent('FewZ_Warflag:toofarC')
        AddEventHandler('FewZ_Warflag:toofarC', function(TimeNow)
                secLeft = math.floor(TimeNow)
                secWin = 0
                HoldID = 0
                HoldFlagName = Config['HoldFlagName']

                TriggerServerEvent('FewZ_Warflag:flagdrop', Config['FirstFlagSpawn'])
        end)


        RegisterNetEvent('FewZ_Warflag:SpawnFlag')
        AddEventHandler('FewZ_Warflag:SpawnFlag', function(coords)
                if EventStart then
                        if coords and Config['SpawnFlagDead'] then
                                for k, v in pairs(Config['FlagPoint']) do
                                        local DistanceCheck = GetDistanceBetweenCoords(coords, v["x"], v["y"], v["z"], true)
                                        if DistanceCheck < Config['Distance'] then
                                                spawnFlag(coords)
                                                --print(coords)
                                                print('^2Flag^0:Flag out')
                                        end
                                end
                        else
                                spawnFlag(Config['FirstFlagSpawn'])
                        end
                end
        end)

        RegisterNetEvent('FewZ_Warflag:FlagSetHealth')
        AddEventHandler('FewZ_Warflag:FlagSetHealth', function()
                SetEntityHealth(PlayerPedId(), 200)
        end)

        function spawnFlag(location)
                FlagLocation = location
        end

        ShowToolTip = function (msg, coords)
                AddTextEntry(GetCurrentResourceName(), msg)
                SetFloatingHelpTextWorldPosition(1, coords)
                SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
                BeginTextCommandDisplayHelp(GetCurrentResourceName())
                EndTextCommandDisplayHelp(2, false, false, -1)
        end
        
        function DrawText3D(coords, text, size, font)
                local vector = type(coords) == "vector3" and coords or vec(coords.x, coords.y, coords.z)
            
                local camCoords = GetFinalRenderedCamCoord()
                local distance = #(vector - camCoords)
            
                if not size then
                    size = 1
                end
                if not font then
                    font = 0
                end
            
                local scale = (size / distance) * 2
                local fov = (1 / GetGameplayCamFov()) * 100
                scale = scale * fov
            
                SetTextScale(0.0 * scale, 0.55 * scale)
                SetTextFont(font)
                SetTextProportional(1)
                SetTextColour(255, 255, 255, 215)
                BeginTextCommandDisplayText('STRING')
                SetTextCentre(true)
                AddTextComponentSubstringPlayerName(text)
                SetDrawOrigin(vector.xyz, 0)
                EndTextCommandDisplayText(0.0, 0.0)
                ClearDrawOrigin()
            end


        AddEventHandler('onResourceStop', function(resource)
                if resource == GetCurrentResourceName() then
                        FreezeEntityPosition(GetPlayerPed(-1), false)
                        ClearPedTasks(GetPlayerPed(-1))
                end
        end)

        AddEventHandler("Fewthz_core:ClientMemoryGarbage", function()
                Citizen.CreateThread(function()
                        Wait(math.random(100, 2000))
                        collectgarbage()
                end)
        end)

end