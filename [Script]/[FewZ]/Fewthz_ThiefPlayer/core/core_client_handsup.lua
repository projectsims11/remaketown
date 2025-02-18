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

local canHandsUp = true

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

CreateThread(function()
    local handsup = false
    local handsupforcl = false
    while true do
        local sleep = 1000
        local player = GetPlayerPed( -1 )
        
        if not IsEntityDead( player ) and handsup then
            handsup = false
            TriggerServerEvent(GetCurrentResourceName()..':update', false)
        end
        
        if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
            sleep = 7
            if IsControlJustReleased(0, Keys['Y']) then

                if IsPedInAnyVehicle(PlayerPedId(), true) == false then

                        loadAnimDict( "random@arrests" )
                        loadAnimDict( "random@arrests@busted" )

                        while not HasAnimDictLoaded('random@arrests') do
                            Citizen.Wait(100)
                        end

                        handsup = true
                        TaskPlayAnim( player, "random@arrests", "idle_2_hands_up", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
                        Wait (4000)
                        TaskPlayAnim( player, "random@arrests", "kneeling_arrest_idle", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
                        Wait (500)
                        TaskPlayAnim( player, "random@arrests@busted", "enter", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
                        Wait (1000)
                        TaskPlayAnim( player, "random@arrests@busted", "idle_a", 8.0, 1.0, -1, 9, 0, 0, 0, 0 )
                        TriggerServerEvent(GetCurrentResourceName()..':update', handsup)
                        handsupforcl = false
                    --	print('2')
                    while handsup do
                        Citizen.Wait(0)
                        DisableAllControlActions(0)
                        EnableControlAction(0, 1, true)
                        EnableControlAction(0, 2, true)
                        EnableControlAction(0, Keys['X'], true)
                        EnableControlAction(0, Keys['N'], true)
                        if IsControlJustReleased(0, Keys['X']) then
                            handsup = false
                            TaskPlayAnim( player, "random@arrests@busted", "exit", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
                            Wait (3000)
                            TaskPlayAnim( player, "random@arrests", "kneeling_arrest_get_up", 8.0, 1.0, -1, 128, 0, 0, 0, 0 )
                            ClearPedTasks(GetPlayerPed(-1))
                            ClearPedSecondaryTask(PlayerPedId())
                            TriggerServerEvent(GetCurrentResourceName()..':update', handsup)
                            handsupforcl = false
                        end
                    end
                else
                    exports['mythic_notify']:SendAlert('error', 'อยู่บนรถไม่สามารถคุกเข่าไม่ได้!')	
                end
            end
        end
        Wait(sleep)
    end
end)