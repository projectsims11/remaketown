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

ESX = nil
WeaponAllowUseRrob = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent(Config['TriggerESX'], function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    for k,v in ipairs(Config['WeaponToAllowThief']) do
        WeaponAllowUseRrob[GetHashKey(v)] = true
    end
end)

function GetPlayers()
    local players = {}

    for _, i in ipairs(GetActivePlayers()) do
        table.insert(players, i)
    end

    return players
end

function GetClosestPlayer(radius)
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)

    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = GetDistanceBetweenCoords(targetCoords['x'], targetCoords['y'], targetCoords['z'], plyCoords['x'], plyCoords['y'], plyCoords['z'], true)
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end

    if closestDistance <= radius then
        return closestPlayer
    else
        return nil
    end
end

local invenother = false
function IsAbleToSteal(targetSID, err)
    ESX.TriggerServerCallback(GetCurrentResourceName()..':getValue', function(result)
        local closestPlayer = GetClosestPlayer(2)
        otherped = GetPlayerPed(closestPlayer)
        local result = result
        if result.value then
            err(false)
        elseif IsEntityDead(otherped) then	
            err(false)
        else
            err(Config['translate']['not_hand_up'])
        end
    end, targetSID)
end

local checkclose = false
function checkdeath()
    Citizen.CreateThread(function()
        while invenother do
            Citizen.Wait(1300)
            local playerPed =  PlayerPedId()
            local coords =  GetEntityCoords(playerPed)

            local closestPlayer, closestDistance = GetClosestPlayer(2)
            otherped = GetPlayerPed(closestPlayer)

            local coords2 =  GetEntityCoords(otherped)

            if GetDistanceBetweenCoords(coords,coords2, true) > 1.5 then			
                TriggerEvent(Config['InventoryCloseUi'])   
                invenother = false	
                checkclose = true
            end 

            if not checkclose and not IsPedDeadOrDying(otherped, 1) then
                invenother = false	
                checkclose = true
                TriggerEvent(Config['InventoryCloseUi'])		 
            end
        end
    end) 
end

function OpenStealMenuThief(target_id)
    local coordsPlayer = GetEntityCoords(GetPlayerPed(-1))
    local player = GetPlayerPed( -1 )
    local closestPlayer = GetClosestPlayer(2)
    otherped = GetPlayerPed(closestPlayer)
    ESX.UI.Menu.CloseAll()
    if Config['AlertPolice'] then
        TriggerEvent(Config['PoliceAlert'], Config['PoliceType'])
    end
    TriggerServerEvent(GetCurrentResourceName()..':notifySMS', coordsPlayer , target_id)
    TriggerEvent(Config['TriggerInventory'], GetPlayerServerId(closestPlayer))
    if not IsPedDeadOrDying(otherped, 1) then
        Citizen.CreateThread(function()	
            while true do
                Wait(3000)
                if IsPedDeadOrDying(otherped, 1) then
                    TriggerEvent(Config['InventoryCloseUi'])
                    invenother = false	
                end
            
                if checkclose then
                    TriggerEvent(Config['InventoryCloseUi'])
                    checkclose = false
                    break
                end		
            end
        end)
    else
        checkdeath()
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(7)
        local ped = PlayerPedId()
        if IsControlJustPressed(0, 47) and IsPedArmed(ped, 7) and not IsEntityDead(ped) and IsPedOnFoot(ped) then
            local target, distance = GetClosestPlayer(1.5)
            local currentWeapon = GetSelectedPedWeapon(PlayerPedId())
            if not WeaponAllowUseRrob[currentWeapon] then
                AlertTify(Config['translate']['weapon_use'],5000,'error')
            else
                Citizen.Wait(200)
                if exports.Fewthz_Check:CheckPolice(Config['Cops']) then
                    if target ~= nil then
                        local target_id = GetPlayerServerId(target)
                        IsAbleToSteal(target_id, function(err)
                            if(not err)then
                                local playerPed = GetPlayerPed(-1)
                                local coords = GetEntityCoords(playerPed)
                                --TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
                                TriggerEvent(Config['EventProgbar'], {
                                    name = "unique_action_name",
                                    duration = Config['TimeProgbar'],
                                    label = Config['TextProgbar'],
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                            animDict = 'amb@prop_human_bum_bin@enter',
                                            anim = 'enter',
                                    },
                                }, function(status)
                                    if not status then
                                        ClearPedSecondaryTask(PlayerPedId())	
                                        invenother = true	
                                    
                                        ClearPedTasks(GetPlayerPed(-1))

                                        OpenStealMenuThief(target_id)
                                    end
                                end)						
                            else
                                AlertTify(err,5000,'error')
                            end
                        end)
                    elseif distance then
                        AlertTify(Config['translate']['weapon_use'],3000,'error')
                        exports['mythic_notify']:SendAlert('error', 'ไม่มีเป้าหมายอยู่ใกล้ตัวคุณ!')
                    else
                        AlertTify(Config['translate']['not_distance'] ,3000,'error')
                        exports['mythic_notify']:SendAlert('error', 'ไม่มีผู้เล่นอยู่ใกล้ๆ!')
                    end
                else
                    exports.pNotify:SendNotification({
                        text = '<center><strong class="red-text">'..Config['translate']['cops']..'</strong><center>',
                        type = "error",
                        timeout = 3000, 
                        layout = "bottomCenter",
                    })
                end
            end
        end
    end
end)

local checkdead = false
isDead = false
Citizen.CreateThread(function()
    while true do
        local wait = 1000
        if IsEntityDead(PlayerPedId()) then
            isDead = true
            if not checkdead then
                checkdead = true
                TriggerServerEvent(GetCurrentResourceName()..':update', true )
            end
        else
            if checkdead then
                checkdead = false
                TriggerServerEvent(GetCurrentResourceName()..':update', false )
            end
            isDead = false
        end
        Citizen.Wait(wait)
    end
end)

Citizen.CreateThread(function()
    while true do
        local wait = 1000
        if isDead then
            wait = 5
            EnableControlAction(0, Keys['Y'], false)
        end
        Citizen.Wait(wait)
    end
end)

RegisterNetEvent(GetCurrentResourceName()..':closeUI')
AddEventHandler(GetCurrentResourceName()..':closeUI',function()
    TriggerEvent(Config['InventoryCloseUi'])
end)

function AlertTify(text,timeout,type)
    exports.pNotify:SendNotification({
        text = text,
        type = type,
        timeout = timeout,
        layout = "bottomCenter",
        queue = "thief"
    })
end

AddEventHandler("Fewthz_core:ClientMemoryGarbage", function()
	Citizen.CreateThread(function()
		Wait(math.random(100, 2000))
		collectgarbage()
	end)
end)