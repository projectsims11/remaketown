nuiLoaded                    = false
selectedtrafficLampCoords    = {}
selectedhouseBoardCoordsData = {}
missionBlips                 = {}
trafficLights                = {}
local VehBlip                = {}
local FinishBlip             = {}
local Ladders                = {}
local SpawnedLadders         = {}
local laddercraft            = false
local liftcraft              = false

local cachedZCoords          = {}
local cachedZCoordsStreet    = {}
-- ██████╗  ██████╗ ██╗  ██╗   ██╗    ██╗     ███████╗ █████╗ ██╗  ██╗███████╗ 
-- ██╔══██╗██╔═══██╗██║  ╚██╗ ██╔╝    ██║     ██╔════╝██╔══██╗██║ ██╔╝██╔════╝ 
-- ██████╔╝██║   ██║██║   ╚████╔╝     ██║     █████╗  ███████║█████╔╝ ███████╗ 
-- ██╔═══╝ ██║   ██║██║    ╚██╔╝      ██║     ██╔══╝  ██╔══██║██╔═██╗ ╚════██║ 
-- ██║     ╚██████╔╝███████╗██║       ███████╗███████╗██║  ██║██║  ██╗███████║ 
-- ╚═╝      ╚═════╝ ╚══════╝╚═╝       ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝ 
-- [discord.gg/gaJJjnKGpg] 
--Blips---
local phonePoleBlips         = {}
local streetLampBlips        = {}
local houseBoardBlips        = {}
local streetTrafoBlips       = {}
local TrafficLamp            = {}
local TrafficLamp2           = {}

-- LİFT--
local Lifts                  = {}
local LocalLifts             = {}
local ControllingLift        = false


--- SMOKE EFFECTS
local activeSmokeEffectsstreetTrafo = {}

local activeSmokeEffectsTrafo = {}

local activeSmokeEffectsHouseBoard = {}

local activeSmokeEffectsphonePole = {}

local activeSmokeEffectStreetLamp = {}
function checkNUI()
    while not nuiLoaded do
        Wait(0)
    end
end

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then

    end
end)

function NuiMessage(action, payload)
    checkNUI()
    SendNUIMessage({
        action = action,
        payload = payload
    })
end

CreateThread(function()
    while not nuiLoaded do
        if NetworkIsSessionStarted() then
            SendNUIMessage({
                action = "CHECK_NUI",
            })
        end
        Wait(2000)
    end
end)

RegisterNUICallback("checkNUI", function(data, cb)
    nuiLoaded = true
    cb("ok")
end)

function openElectricinMenu()
    if nuiLoaded and Core then
        local playerData = TriggerCallback('tworst-electrician:server:getPlayerData')
        local ServerLobby = TriggerCallback('tworst-electrician:server:CreatePlayerLobby')
        if playerData then
            SetNuiFocus(true, true)
            NuiMessage('OPEN_MENU', playerData)
            NuiMessage('LOAD_LOBBY', ServerLobby)
        end
    end
end

Citizen.CreateThread(function()
    while Core == nil and not nuiLoaded do
        Citizen.Wait(0)
    end
    Config.OpenTrigger()
    NuiMessage('SERVER_NAME', Config.ServeName)
    NuiMessage('LOCALES', Config.Locales)
    NuiMessage('SERVER_MONEY_TYPE', Config.MoneyType)
    NuiMessage('REGION_DATA', Config.Electrician['regionData'])
end)




RegisterNetEvent('tworst-electrician:client:invetePlayer', function(lobbyOwner, identifier)
    local playerData = TriggerCallback('tworst-electrician:server:getPlayerData')
    if playerData then
        SetNuiFocus(true, true)
        NuiMessage('INVITE_MENU', { lobbyOwner = lobbyOwner, identifier = identifier })
    end
end)

RegisterNetEvent('tworst-electrician:client:RefreshLobby', function(lobbyData)
    local playerData = TriggerCallback('tworst-electrician:server:getPlayerData')
    CoopDataClient = lobbyData
    if playerData then
        SetNuiFocus(true, true)
        NuiMessage('OPEN_MENU', playerData)
        NuiMessage('LOAD_LOBBY', CoopDataClient.players)
        NuiMessage('REFRESH_LOBBY', CoopDataClient.roomSetting.Mission)
    end
end)

RegisterNetEvent('tworst-electrician:client:UpdateData', function(lobbyData, missionName)
    if missionName == "fixStreetLamp" then
        CoopDataClient.roomSetting.Mission.regionstreetLampCoords = lobbyData
        for index, value in ipairs(CoopDataClient.roomSetting.Mission.regionstreetLampCoords) do
            if value.fixed then
                if activeSmokeEffectStreetLamp[index] then
                    StopParticleFxLooped(activeSmokeEffectStreetLamp[index], 0)
                    RemoveParticleFx(activeSmokeEffectStreetLamp[index], false)
                    RemoveSmokeEffect(activeSmokeEffectStreetLamp[index])
                    activeSmokeEffectStreetLamp[index] = nil
                end

                if streetLampBlips[index] then
                    RemoveBlip(streetLampBlips[index])
                    table.remove(streetLampBlips, index)
                end
            end
        end
    elseif missionName == 'fixTrafficLamp' then
        CoopDataClient.roomSetting.Mission.regiontrafficLampCoords = lobbyData
        for index, value in ipairs(CoopDataClient.roomSetting.Mission.regiontrafficLampCoords) do
            if CoopDataClient.roomSetting.Mission.regiontrafficLampCoords[index].regionFixedTrafo.fixed then
                if activeSmokeEffectsTrafo[index] then
                    StopParticleFxLooped(activeSmokeEffectsTrafo[index], 0)
                    RemoveParticleFx(activeSmokeEffectsTrafo[index], false)
                    RemoveSmokeEffect(activeSmokeEffectsTrafo[index])
                    activeSmokeEffectsTrafo[index] = nil
                end

                if TrafficLamp[index] then
                    RemoveBlip(TrafficLamp[index])
                    table.remove(TrafficLamp, index)
                end
            end
            for k, v in ipairs(value.regionTrafficCoords) do
                if v.fixed then
                    if activeSmokeEffectsTrafo[k] then
                        StopParticleFxLooped(activeSmokeEffectsTrafo[index], 0)
                        RemoveParticleFx(activeSmokeEffectsTrafo[index], false)
                        RemoveSmokeEffect(activeSmokeEffectsTrafo[index])
                        activeSmokeEffectsTrafo[index] = nil
                    end

                    if TrafficLamp2[k] then
                        RemoveBlip(TrafficLamp2[k])
                        table.remove(TrafficLamp2, k)
                    end

                    for i = #trafficLights, 1, -1 do
                        local lightCoords = trafficLights[i].coords
                        local dataCoords = vector3(v.coords.x, v.coords.y, v.coords.z)
                        local distancew = #(vector3(lightCoords.x, lightCoords.y, lightCoords.z) - dataCoords)
                        if distancew < 10 then
                            trafficLights[i].fixed = true
                        end
                    end
                end
            end
        end
    elseif missionName == 'fixHouseBoard' then
        CoopDataClient.roomSetting.Mission.regionhouseBoardCoords = lobbyData
        for index, value in ipairs(CoopDataClient.roomSetting.Mission.regionhouseBoardCoords) do
            if value.fixed then
                if activeSmokeEffectsHouseBoard[index] then
                    StopParticleFxLooped(activeSmokeEffectsHouseBoard[index], 0)
                    RemoveParticleFx(activeSmokeEffectsHouseBoard[index], false)
                    RemoveSmokeEffect(activeSmokeEffectStreetLamp[index])
                    activeSmokeEffectsHouseBoard[index] = nil
                end

                if houseBoardBlips[index] then
                    RemoveBlip(houseBoardBlips[index])
                    table.remove(houseBoardBlips, index)
                end
            end
        end
    elseif missionName == 'fixTrafo' then
        CoopDataClient.roomSetting.Mission.regionstreetTrafoCoords = lobbyData
        for index, value in ipairs(CoopDataClient.roomSetting.Mission.regionstreetTrafoCoords) do
            if value.fixed then
                if activeSmokeEffectsstreetTrafo[index] then
                    StopParticleFxLooped(activeSmokeEffectsstreetTrafo[index], 0)
                    RemoveParticleFx(activeSmokeEffectsstreetTrafo[index], false)
                    RemoveSmokeEffect(activeSmokeEffectsstreetTrafo[index])
                    activeSmokeEffectsstreetTrafo[index] = nil
                end

                if streetTrafoBlips[index] then
                    RemoveBlip(streetTrafoBlips[index])
                    table.remove(streetTrafoBlips, index)
                end
            end
        end
    elseif missionName == 'phonePole' then
        CoopDataClient.roomSetting.Mission.regionphonePoleCoords = lobbyData
        for index, value in ipairs(CoopDataClient.roomSetting.Mission.regionphonePoleCoords) do
            if value.fixed then
                if activeSmokeEffectsphonePole[index] then
                    StopParticleFxLooped(activeSmokeEffectsphonePole[index], 0)
                    RemoveParticleFx(activeSmokeEffectsphonePole[index], false)
                    RemoveSmokeEffect(activeSmokeEffectsphonePole[index])
                    activeSmokeEffectsphonePole[index] = nil
                end


                if phonePoleBlips[index] then
                    RemoveBlip(phonePoleBlips[index])
                    table.remove(phonePoleBlips, index)
                end
            end
        end
    end
end)

function UpdateBlipForVehicle(vehicle, blip)
    Citizen.CreateThread(function()
        while DoesEntityExist(vehicle) do
            local vehiclecoords = GetEntityCoords(vehicle)
            SetBlipCoords(blip, vehiclecoords.x, vehiclecoords.y, vehiclecoords.z)
            Wait(1000)   -- Update every second
        end
        RemoveBlip(blip) -- Remove blip if vehicle no longer exists
    end)
end

RegisterNetEvent("tworst-electrician:client:StartJobOwner", function(data, data2) -- Start Job Owner
    if data and data2 then
        CoopDataClient = data
        joobTaskClient = data2
        if CoopDataClient then
            for index, value in ipairs(CoopDataClient.roomSetting.VehicleNetId) do
                local clientvehInfo = NetToVeh(value)
                if DoesEntityExist(clientvehInfo) then
                    local model = GetDisplayNameFromVehicleModel(GetEntityModel(clientvehInfo))
                    SetVehicleExtra(clientvehInfo, 1, 1)
                    SetVehicleExtra(clientvehInfo, 2, 1)
                    SetVehicleExtra(clientvehInfo, 3, 0)
                    SetVehicleExtra(clientvehInfo, 4, 1)
                    SetVehicleExtra(clientvehInfo, 5, 1)
                    SetVehicleExtra(clientvehInfo, 6, 0)
                    Config.SetVehicleFuel(clientvehInfo, 100.0)
                    Config.GiveVehicleKey(GetVehicleNumberPlateText(clientvehInfo), model, clientvehInfo)

                    local vehBlip = AddBlipForCoord(GetEntityCoords(clientvehInfo))
                    SetBlipSprite(vehBlip, 85)
                    SetBlipColour(vehBlip, 0)
                    SetBlipScale(vehBlip, 0.8)
                    SetBlipAsShortRange(vehBlip, true)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString("Electrician Car")
                    EndTextCommandSetBlipName(vehBlip)
                    table.insert(VehBlip, vehBlip)
                    UpdateBlipForVehicle(clientvehInfo, vehBlip)
                end
            end
            NuiMessage('START_JOB', joobTaskClient)
            SetNuiFocus(false, false)
            Wait(500)
            Citizen.CreateThread(function()
                spawnMission1()
            end)
            Citizen.CreateThread(function()
                spawnMission2()
            end)
            Citizen.CreateThread(function()
                spawnMission3()
            end)
            Citizen.CreateThread(function()
                spawnMission4()
            end)
            Citizen.CreateThread(function()
                spawnMission5()
            end)
        end
    end
end)


RegisterNetEvent('tworst-electrician:client:StartJob', function(jobData, jobTask)
    if jobData.roomSetting.startJob then
        joobTaskClient = jobTask
        CoopDataClient = jobData
        NuiMessage('CLOSENUI')
        NuiMessage('START_JOB', joobTaskClient)
        SetNuiFocus(false, false)
        TriggerEvent('tworst-electrician:server:FinishJob', CoopDataClient.roomSetting.owneridentifier)
    end
end)

RegisterNetEvent('tworst-electrician:client:RefreshJob', function(jobTask)
    joobTaskClient = jobTask
    NuiMessage('REFRESH_JOBTASK', joobTaskClient)
end)

RegisterNetEvent('tworst-electrician:client:UpdateLobby', function(lobbyData, ladderorlift)
    CoopDataClient = lobbyData
    if ladderorlift == 'lift' then
        liftcraft = false
    elseif ladderorlift == 'ladder' then
        laddercraft = false
    end
end)

RegisterNetEvent('tworst-electrician:client:TakeLooby', function()
    NuiMessage('CLOSENUI')
    SetNuiFocus(false, false)
    CoopDataClient = {}
end)

RegisterNUICallback('closeNUI', function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback('invitePlayer', function(data)
    TriggerServerEvent('tworst-electrician:server:invetePlayer', data)
end)

RegisterNUICallback('firePlayer', function(data)
    TriggerServerEvent('tworst-electrician:server:firePlayer', data)
end)

RegisterNUICallback('acceptInvite', function(data)
    SetNuiFocus(false, false)
    TriggerServerEvent('tworst-electrician:server:acceptInvite', data)
end)

RegisterNUICallback('selectMission', function(data)
    TriggerServerEvent('tworst-electrician:server:selectMission', data)
end)

RegisterNUICallback('startJob', function(data)
    local vehcoords1 = data.regionSpawnCoords[1]
    local vehcoords2 = data.regionSpawnCoords[2]
    local distanceCheck = GetVehiclesInArea(vehcoords1, 6.0)
    local distanceCheck2 = GetVehiclesInArea(vehcoords2, 6.0)

    if #distanceCheck == 0 and #distanceCheck2 == 0 then
        TriggerServerEvent('tworst-electrician:server:startJob', data)
    else
        sendNotification(Config.NotificationText['vehicleexist'].text, Config.NotificationText['vehicleexist'].type)
    end
end)

RegisterNUICallback('resetJob', function()
    TriggerServerEvent('tworst-electrician:server:resetJobButton', CoopDataClient.roomSetting.owneridentifier)
end)

RegisterNUICallback('switchFixed', function(data)
    if not data.missionName then
        local missionPermit = TriggerCallback('tworst-electrician:server:getMissionsDetails',
            { owneridentifier = CoopDataClient.roomSetting.owneridentifier, missionControl = 'trafoclose' })
        if missionPermit then
            SetNuiFocus(false, false)
            NuiMessage('CLOSE_TRAFO_MISSION')
            TriggerServerEvent('tworst-electrician:server:switchFixed', CoopDataClient.roomSetting.owneridentifier,
                data.regiontrafficKey.coords)
        else
            sendNotification(Config.NotificationText['missionnotpermit'].text,
                Config.NotificationText['missionnotpermit'].type)
        end
    end
end)

RegisterNUICallback('switchFixedHouse', function(data)
    local coords = data.regiontrafficKey.coords
    SetNuiFocus(false, false)
    NuiMessage('CLOSE_TRAFO_MISSION')
    TriggerServerEvent('tworst-electrician:server:UpdateJobTask', data.regiontrafficKey.missionName,
        CoopDataClient.roomSetting.owneridentifier)
    if data.regiontrafficKey.missionName == "fixHouseBoard" then
        TriggerServerEvent('tworst-electrician:server:switchFixedHouse',
            CoopDataClient.roomSetting.owneridentifier,
            coords)
    elseif data.regiontrafficKey.missionName == "fixTrafo" then
        TriggerServerEvent('tworst-electrician:server:switchFixedTrafo',
            CoopDataClient.roomSetting.owneridentifier,
            coords)
    elseif data.regiontrafficKey.missionName == "phonePole" then
        TriggerServerEvent('tworst-electrician:server:switchFixedPhonePole',
            CoopDataClient.roomSetting.owneridentifier,
            coords)
    end
end)

RegisterNUICallback('closeNUIHouse', function(data)
    local coords = data.regiontrafficKey.coords
    SetNuiFocus(false, false)
    TriggerServerEvent('tworst-electrician:server:changeTrafoModal',
        CoopDataClient.roomSetting.owneridentifier, 0, coords,
        data.regiontrafficKey.missionName,
        false)
    if data.regiontrafficKey.error then
        if (not IsPedClimbing(PlayerPedId())) then -- Only do animations when not climbing, as this will not work while on a ladder.
            PlayAnim('failMinigame')
            Wait(2000)
        end
        local health = GetEntityHealth(PlayerPedId())
        SetEntityHealth(PlayerPedId(), health - math.random(10, 25))
    end
end)

RegisterNUICallback('closeNUIFixed', function(data)
    if not data.missionName then
        local missionPermit = TriggerCallback('tworst-electrician:server:getMissionsDetails',
            { owneridentifier = CoopDataClient.roomSetting.owneridentifier, missionControl = 'trafoclose' })
        if missionPermit then
            if data.error then
                if (not IsPedClimbing(PlayerPedId())) then -- Only do animations when not climbing, as this will not work while on a ladder.
                    PlayAnim('failMinigame')
                    Wait(2000)
                end
                local health = GetEntityHealth(PlayerPedId())
                SetEntityHealth(PlayerPedId(), health - math.random(10, 25))
            end
        end
    end
end)
RegisterNetEvent('tworst-electrician:client:sendNotification', function(message, type)
    sendNotification(message, type)
end)

function sendNotification(messages, type)
    if nuiLoaded then
        NuiMessage('NOTIFICATION', { message = messages, type = type })
    end
end

RegisterNetEvent('tworst-electrician:client:FinishJob', function(jobData)
    CoopDataClient = jobData
    if CoopDataClient.roomSetting.carDelivered then
        sendNotification(Config.NotificationText['deliverVehile'].text, Config.NotificationText['deliverVehile'].type)
        clearBlip()
        local blip = AddBlipForCoord(CoopDataClient.roomSetting.Mission.regionDeliveryCoords.x,
            CoopDataClient.roomSetting.Mission.regionDeliveryCoords.y)
        SetBlipSprite(blip, 1)
        SetBlipColour(blip, 29)
        SetBlipScale(blip, 0.8)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("DELIVER VEHICLE")
        EndTextCommandSetBlipName(blip)
        table.insert(FinishBlip, blip)
        SetNewWaypoint(CoopDataClient.roomSetting.Mission.regionDeliveryCoords.x,
            CoopDataClient.roomSetting.Mission.regionDeliveryCoords.y)
        TriggerServerEvent('tworst-electrician:server:syncSettings', "waypoint",
            CoopDataClient.roomSetting.Mission.regionDeliveryCoords.x,
            CoopDataClient.roomSetting.Mission.regionDeliveryCoords.y, CoopDataClient.roomSetting.owneridentifier)
    end
end)

Citizen.CreateThread(function()
    while true do
        local waitTime = 1000
        if CoopDataClient and CoopDataClient.roomSetting and CoopDataClient.roomSetting.finishJob then
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            local allVehiclesInRange = true

            for index, value in ipairs(CoopDataClient.roomSetting.VehicleNetId) do
                local clientvehInfo = NetToVeh(value)
                if DoesEntityExist(clientvehInfo) then
                    local vehicleCoords = GetEntityCoords(clientvehInfo)

                    if CoopDataClient.roomSetting.carDelivered and CoopDataClient.roomSetting.finishJob then
                        local jobDeliverCoords = CoopDataClient.roomSetting.Mission.regionDeliveryCoords
                        local jobDeliverCoords = vector3(jobDeliverCoords.x, jobDeliverCoords.y, jobDeliverCoords.z)
                        local distance = #(vehicleCoords - jobDeliverCoords)

                        if distance >= 10 then
                            allVehiclesInRange = false
                            break
                        end
                    end
                end
            end

            if allVehiclesInRange then
                local playerInVehicle = IsPedInAnyVehicle(playerPed, false)
                if playerInVehicle then
                    local jobDeliverCoords = CoopDataClient.roomSetting.Mission.regionDeliveryCoords

                    DrawMarker(2, jobDeliverCoords.x, jobDeliverCoords.y, jobDeliverCoords.z + 1.0, 0, 0.75, 0.75, 0, 0,
                        0,
                        0.5,
                        0.5, 0.5, 255, 255, 255, 210, 0, 0.10, 0, 0, 0, 0.0, 0)
                    DrawText3D(jobDeliverCoords.x, jobDeliverCoords.y, jobDeliverCoords.z + 1.0,
                        Config.Electrician['drawtext']['deliverVehile'])
                    if IsControlJustPressed(0, 38) then
                        TriggerServerEvent('tworst-electrician:server:LeaveVehicle',
                            CoopDataClient.roomSetting.owneridentifier)
                        clearBlip()
                        Citizen.Wait(10000) -- 10 saniye bekle
                    end
                    waitTime = 0
                end
            end
        end
        Citizen.Wait(waitTime)
    end
end)


RegisterNetEvent('tworst-electrician:client:LeaveVehicle', function(scoreAmount, awards)
    local playerData = TriggerCallback('tworst-electrician:server:getPlayerData')
    local finishjobData = {
        playerName = playerData.playerName,
        scoreAmount = scoreAmount,
        money = awards.money,
        xp = awards.xp,
    }
    NuiMessage('FINISH_JOB', finishjobData)
    for index, value in ipairs(CoopDataClient.roomSetting.VehicleNetId) do
        local clientvehInfo = NetToVeh(value)
        if DoesEntityExist(clientvehInfo) then
            DeleteEntity(clientvehInfo)
        end
    end
    CoopDataClient = {}
    joobTaskClient = {}
    VehBlip = {}
    FinishBlip = {}
    missionBlips = {}

    for i = 1, #VehBlip do
        RemoveBlip(VehBlip[i])
    end
    clearBlip()
end)

clearBlip = function()
    for i = 1, #missionBlips do
        RemoveBlip(missionBlips[i])
    end
    missionBlips = {}
    for i = 1, #VehBlip do
        RemoveBlip(VehBlip[i])
    end
    VehBlip = {}
    for i = 1, #FinishBlip do
        RemoveBlip(FinishBlip[i])
    end
    FinishBlip = {}

    for i = 1, #phonePoleBlips do
        RemoveBlip(phonePoleBlips[i])
    end
    phonePoleBlips = {}

    for i = 1, #streetLampBlips do
        RemoveBlip(streetLampBlips[i])
    end
    streetLampBlips = {}

    for i = 1, #houseBoardBlips do
        RemoveBlip(houseBoardBlips[i])
    end
    houseBoardBlips = {}

    for i = 1, #streetTrafoBlips do
        RemoveBlip(streetTrafoBlips[i])
    end
    streetTrafoBlips = {}

    for i = 1, #TrafficLamp do
        RemoveBlip(TrafficLamp[i])
    end
    TrafficLamp = {}

    for i = 1, #TrafficLamp2 do
        RemoveBlip(TrafficLamp2[i])
    end
    TrafficLamp2 = {}

    for i = 1, #Lifts do
        RemoveBlip(Lifts[i])
    end
    Lifts = {}

    for i = 1, #LocalLifts do
        RemoveBlip(LocalLifts[i])
    end

    LocalLifts = {}
    cachedZCoords = {}
    cachedZCoordsStreet = {}
end


RegisterNetEvent('tworst-electrician:client:resetjob', function()
    for i = 1, #VehBlip do
        RemoveBlip(VehBlip[i])
    end
    VehBlip = {}

    for i = 1, #FinishBlip do
        RemoveBlip(FinishBlip[i])
    end


    for index, value in ipairs(CoopDataClient.roomSetting.VehicleNetId) do
        local clientvehInfo = NetToVeh(value)
        if DoesEntityExist(clientvehInfo) then
            DeleteEntity(clientvehInfo)
        end
    end

    CoopDataClient = {}
    joobTaskClient = {}
    VehBlip = {}
    FinishBlip = {}
    missionBlips = {}

    for i = 1, #VehBlip do
        RemoveBlip(VehBlip[i])
    end
    clearBlip()

    FinishBlip = {}
    NuiMessage('RESET_JOB')
end)

RegisterCommand(Config.JobResetCommand, function()
    if CoopDataClient and CoopDataClient.roomSetting then
        TriggerServerEvent('tworst-electrician:server:resetJobButton', CoopDataClient.roomSetting.owneridentifier)
    end
end)

function drawTextForTrafo()
    Citizen.CreateThread(function()
        local wait = 1000
        while true do
            if CoopDataClient and CoopDataClient.roomSetting and CoopDataClient.roomSetting.startJob then
                for index, value in ipairs(CoopDataClient.roomSetting.Mission.regiontrafficLampCoords) do
                    local playerCoords = GetEntityCoords(PlayerPedId())
                    local trafodistance = #(playerCoords - vector3(value.regionFixedTrafo.coords.x, value.regionFixedTrafo.coords.y, value.regionFixedTrafo.coords.z))
                    if trafodistance < 25 and not value.regionFixedTrafo.fixed then
                        wait = 0
                        DrawMarker(2, value.regionFixedTrafo.coords.x, value.regionFixedTrafo.coords.y,
                            value.regionFixedTrafo.coords.z + 1.0, 0, 0.75, 0.75, 0,
                            0,
                            0,
                            0.5,
                            0.5, 0.5, 255, 255, 255, 210, 0, 0.10, 0, 0, 0, 0.0, 0)
                        if trafodistance < 4 and not value.regionFixedTrafo.fixed then
                            DrawText3D(value.regionFixedTrafo.coords.x, value.regionFixedTrafo.coords.y,
                                value.regionFixedTrafo.coords.z, value.regionFixedTrafoText)

                            if not activeSmokeEffectsTrafo[index] then
                                activeSmokeEffectsTrafo[index] = CreateSmokeEffect(value.regionFixedTrafo.coords)
                            end

                            if IsControlJustPressed(0, 38) and trafodistance < 2 then
                                local missionPermit = TriggerCallback('tworst-electrician:server:getMissionsDetails', {
                                    owneridentifier = CoopDataClient.roomSetting.owneridentifier,
                                    missionControl = 'trafoopen'
                                })
                                if missionPermit then
                                    SetNuiFocus(true, true)
                                    NuiMessage('SWITCH_MINIGAME', {
                                        key = value.regiontrafficKey,
                                        missionName = false,
                                        coords = value.regionFixedTrafo.coords
                                    })
                                else
                                    sendNotification(Config.NotificationText['missionnotpermit'].text,
                                        Config.NotificationText['missionnotpermit'].type)
                                end
                            end
                        end
                    else
                        if activeSmokeEffectsTrafo[index] then
                            RemoveSmokeEffect(activeSmokeEffectsTrafo[index])
                            activeSmokeEffectsTrafo[index] = nil
                        end
                    end
                end
            end
            Citizen.Wait(wait)
        end
    end)
end

function drawTextForHouseBoard()
    Citizen.CreateThread(function()
        local sleep = 1000
        while true do
            if CoopDataClient and CoopDataClient.roomSetting and CoopDataClient.roomSetting.startJob then
                for index, value in ipairs(CoopDataClient.roomSetting.Mission.regionhouseBoardCoords) do
                    local playerCoords = GetEntityCoords(PlayerPedId())
                    local trafodistance = #(playerCoords - vector3(value.coords.x, value.coords.y, value.coords.z))

                    if trafodistance < 10 and not value.fixed then
                        sleep = 0
                        DrawMarker(2, value.coords.x, value.coords.y,
                            value.coords.z + 0.5, 0, 0.75, 0.75, 0,
                            0,
                            0,
                            0.5,
                            0.5, 0.5, 255, 255, 255, 210, 0, 0.10, 0, 0, 0, 0.0, 0)
                        if trafodistance < 5 and not value.fixed then
                            DrawText3D(value.coords.x, value.coords.y, value.coords.z,
                                Config.Electrician['drawtext']['fixHouseBoard'])
                            if not activeSmokeEffectsHouseBoard[index] and not value.fixed and not value.open then
                                activeSmokeEffectsHouseBoard[index] = CreateSmokeEffect(value.coords)
                            end

                            if IsControlJustPressed(0, 38) then
                                local missionPermit = TriggerCallback('tworst-electrician:server:getTrafoModal', {
                                    owneridentifier = CoopDataClient.roomSetting.owneridentifier,
                                    missionName = 'fixHouseBoard',
                                    coords = value.coords,
                                    index = index
                                })
                                if missionPermit then
                                    SetNuiFocus(true, true)
                                    NuiMessage('SWITCH_MINIGAME_HOUSE',
                                        { coords = value.coords, missionName = 'fixHouseBoard', fixed = value.fixed })
                                    TriggerServerEvent('tworst-electrician:server:changeTrafoModal',
                                        CoopDataClient.roomSetting.owneridentifier, index, value.coords, 'fixHouseBoard',
                                        true)
                                else
                                    sendNotification(Config.NotificationText['missionnotpermit'].text,
                                        Config.NotificationText['missionnotpermit'].type)
                                end
                            end
                        end
                    else
                        if activeSmokeEffectsHouseBoard[index] then
                            RemoveSmokeEffect(activeSmokeEffectsHouseBoard[index])
                            activeSmokeEffectsHouseBoard[index] = nil
                        end
                    end
                end
            end
            Citizen.Wait(sleep)
        end
    end)
end

function drwTextForstreetTrafo()
    Citizen.CreateThread(function()
        local smokeEffect = nil
        local sleep = 1000
        while true do
            if CoopDataClient and CoopDataClient.roomSetting and CoopDataClient.roomSetting.startJob then
                for index, value in ipairs(CoopDataClient.roomSetting.Mission.regionstreetTrafoCoords) do
                    local playerCoords = GetEntityCoords(PlayerPedId())
                    local trafodistance = #(playerCoords - vector3(value.coords.x, value.coords.y, value.coords.z))

                    if trafodistance < 10 and not value.fixed then
                        sleep = 0
                        DrawMarker(2, value.coords.x, value.coords.y,
                            value.coords.z + 2, 0, 0.75, 0.75, 0,
                            0,
                            0,
                            0.5,
                            0.5, 0.5, 255, 255, 255, 210, 0, 0.10, 0, 0, 0, 0.0, 0)
                        if trafodistance < 10 and not value.fixed then
                            DrawText3D(value.coords.x, value.coords.y,
                                value.coords.z + 0.2, Config.Electrician['drawtext']['fixTrafo'])
                            if not activeSmokeEffectsstreetTrafo[index] then
                                activeSmokeEffectsstreetTrafo[index] = CreateSmokeEffect(value.coords)
                            end

                            if IsControlJustPressed(0, 38) then
                                local missionPermit = TriggerCallback('tworst-electrician:server:getTrafoModal',
                                    {
                                        owneridentifier = CoopDataClient.roomSetting.owneridentifier,
                                        missionName = 'fixTrafo',
                                        coords = value.coords,
                                        index = index
                                    })
                                if missionPermit then
                                    SetNuiFocus(true, true)
                                    NuiMessage('SWITCH_MINIGAME_HOUSE',
                                        { coords = value.coords, missionName = 'fixTrafo', fixed = value.fixed })
                                    TriggerServerEvent('tworst-electrician:server:changeTrafoModal',
                                        CoopDataClient.roomSetting.owneridentifier, index, value.coords, 'fixTrafo', true)
                                else
                                    sendNotification(Config.NotificationText['missionnotpermit'].text,
                                        Config.NotificationText['missionnotpermit'].type)
                                end
                            end
                        end
                    else
                        if activeSmokeEffectsstreetTrafo[index] then
                            RemoveSmokeEffect(activeSmokeEffectsstreetTrafo[index])
                            activeSmokeEffectsstreetTrafo[index] = nil
                        end
                    end
                end
            end
            Wait(sleep)
        end
    end)
end

function liftdrawtextphonePole()
    Citizen.CreateThread(function()
        while true do
            local sleep = 1000

            if CoopDataClient and CoopDataClient.roomSetting and CoopDataClient.roomSetting.startJob then
                for key, value in ipairs(CoopDataClient.roomSetting.Mission.regionphonePoleCoords) do
                    for index, carvalue in ipairs(CoopDataClient.roomSetting.VehicleNetId) do
                        local vehicle = NetToVeh(carvalue)
                        if DoesEntityExist(vehicle) then
                            local plate = GetVehicleNumberPlateText(vehicle)
                            if CoopDataClient.roomSetting.Mission.regionJobVehiclePlate == plate and not CoopDataClient.roomSetting.liftCraft then
                                local vehicle = NetToVeh(carvalue)
                                local vehicleCoords = GetEntityCoords(vehicle)
                                local trafodistance = #(vector2(vehicleCoords.x, vehicleCoords.y) - vector2(value.coords.x, value.coords.y))
                                local playerInVehicle = IsPedInAnyVehicle(PlayerPedId(), false)
                                if trafodistance < 8 and not value.fixed then
                                    sleep = 0
                                    local playerCoords = GetEntityCoords(PlayerPedId())
                                    local distanceToTrunk = #(vector2(playerCoords.x, playerCoords.y) - vector2(value.coords.x, value.coords.y))

                                    if distanceToTrunk < 8 then
                                        if not liftcraft then
                                            DrawText3D(playerCoords.x, playerCoords.y, playerCoords.z,
                                                Config.Electrician['drawtext']['buildlift'])
                                        end

                                        if IsControlJustReleased(0, 38) and not liftcraft and not playerInVehicle then -- 38 is the control ID for the "E" key
                                            TriggerServerEvent('tworst-electrician-server:build', 'lift', value.coords,
                                                CoopDataClient.roomSetting.owneridentifier)
                                            liftcraft = true
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
            Wait(sleep)
        end
    end)
end

function drwTextForphonePole()
    Citizen.CreateThread(function()
        local sleep = 1000
        while true do
            if CoopDataClient and CoopDataClient.roomSetting and CoopDataClient.roomSetting.startJob then
                for index, value in ipairs(CoopDataClient.roomSetting.Mission.regionphonePoleCoords) do
                    local playerCoords = GetEntityCoords(PlayerPedId())
                    local trafodistance = #(playerCoords - vector3(value.coords.x, value.coords.y, value.coords.z))
                    local onlyZdistance = math.abs(playerCoords.z - value.coords.z)

                    local drawMarkerZ = cachedZCoords[index]
                    if not drawMarkerZ then
                        drawMarkerZ = FindZForCoords(value.coords.x, value.coords.y)
                        cachedZCoords[index] = drawMarkerZ + 0.1
                    end

                    if trafodistance < 20.0 and not value.fixed then
                        sleep = 0
                        DrawMarker(25, value.coords.x, value.coords.y, drawMarkerZ, 0.0, 0.0, 0.0, 0.0, 0.0,
                            0.0, 4.0, 4.0, 4.0, 255, 255, 255, 80, false, false, 2, nil, nil, false)
                    end

                    if trafodistance < 5.0 and not value.fixed and onlyZdistance < 1.0 then
                        sleep = 0
                        DrawText3D(value.coords.x, value.coords.y,
                            value.coords.z + 1.0, Config.Electrician['drawtext']['phonePole'])

                        if not activeSmokeEffectsphonePole[index] then
                            activeSmokeEffectsphonePole[index] = CreateSmokeEffect(value.coords)
                        end

                        if IsControlJustPressed(0, 38) then
                            local missionPermit = TriggerCallback('tworst-electrician:server:getTrafoModal',
                                {
                                    owneridentifier = CoopDataClient.roomSetting.owneridentifier,
                                    missionName = 'phonePole',
                                    coords = value.coords,
                                    index = index
                                })
                            if missionPermit then
                                TriggerServerEvent('tworst-electrician:server:changeTrafoModal',
                                    CoopDataClient.roomSetting.owneridentifier, index, value.coords, 'phonePole',
                                    true)
                                local settings = {
                                    wireCount = 4,
                                    wireWidth = 0.74,
                                    maxWeldFails = 3,
                                    time = 64,
                                    missionName =
                                    'phonePole',
                                    coords = value.coords
                                }
                                StartGame(settings, function(success)
                                    if success then
                                        TriggerServerEvent('tworst-electrician:server:switchFixedPhonePole',
                                            CoopDataClient.roomSetting.owneridentifier, value.coords)

                                        TriggerServerEvent('tworst-electrician:server:UpdateJobTask', 'phonePole',
                                            CoopDataClient.roomSetting.owneridentifier)
                                    else
                                        if (not IsPedClimbing(PlayerPedId())) then -- Only do animations when not climbing, as this will not work while on a ladder.
                                            PlayAnim('failMinigame')
                                            Wait(2000)
                                        end
                                        local health = GetEntityHealth(PlayerPedId())
                                        SetEntityHealth(PlayerPedId(), health - math.random(10, 25))
                                        TriggerServerEvent('tworst-electrician:server:changeTrafoModal',
                                            CoopDataClient.roomSetting.owneridentifier, index, value.coords,
                                            'phonePole',
                                            false)
                                    end
                                end)
                            else
                                sendNotification(Config.NotificationText['missionnotpermit'].text,
                                    Config.NotificationText['missionnotpermit'].type)
                            end
                        end
                    else
                        if activeSmokeEffectsphonePole[index] then
                            RemoveSmokeEffect(activeSmokeEffectsphonePole[index])
                            activeSmokeEffectsphonePole[index] = nil
                        end
                    end
                end
            end
            Wait(sleep)
        end
    end)
end

RegisterNUICallback('closeForingShow', function(data)
    if data.foringGameData.missionName == 'phonePole' then
        TriggerServerEvent('tworst-electrician:server:changeTrafoModal',
            CoopDataClient.roomSetting.owneridentifier, 0, data.foringGameData.coords,
            'phonePole',
            false)
    elseif data.foringGameData.missionName == 'fixStreetLamp' then
        TriggerServerEvent('tworst-electrician:server:changeTrafoModal',
            CoopDataClient.roomSetting.owneridentifier, 0, data.foringGameData.coords,
            'fixStreetLamp',
            false)
    end
    EndGame()
end)

function liftdrawtextStreetLamp()
    Citizen.CreateThread(function()
        while true do
            local sleep = 1000

            if CoopDataClient and CoopDataClient.roomSetting and CoopDataClient.roomSetting.startJob then
                for key, value in ipairs(CoopDataClient.roomSetting.Mission.regionstreetLampCoords) do
                    for index, carvalue in ipairs(CoopDataClient.roomSetting.VehicleNetId) do
                        local vehicle = NetToVeh(carvalue)
                        if DoesEntityExist(vehicle) then
                            local plate = GetVehicleNumberPlateText(vehicle)
                            if CoopDataClient.roomSetting.Mission.regionJobVehiclePlate == plate and not CoopDataClient.roomSetting.ladderCraft then
                                local vehicleCoords = GetEntityCoords(vehicle)
                                local trafodistance = #(vector2(vehicleCoords.x, vehicleCoords.y) - vector2(value.coords.x, value.coords.y))
                                local playerInVehicle = IsPedInAnyVehicle(PlayerPedId(), false)

                                if trafodistance < 8 and not value.fixed then
                                    sleep = 0
                                    local playerCoords = GetEntityCoords(PlayerPedId())
                                    local distanceToTrunk = #(vector2(playerCoords.x, playerCoords.y) - vector2(value.coords.x, value.coords.y))

                                    if distanceToTrunk < 8 then
                                        if not laddercraft then
                                            DrawText3D(playerCoords.x, playerCoords.y, playerCoords.z,
                                                Config.Electrician['drawtext']['buildladder'])
                                        end

                                        if IsControlJustReleased(0, 38) and not laddercraft and not playerInVehicle then -- 38 is the control ID for the "E" key
                                            TriggerServerEvent('tworst-electrician-server:build', 'ladder', value.coords,
                                                CoopDataClient.roomSetting.owneridentifier)
                                            laddercraft = true
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
            Wait(sleep)
        end
    end)
end

function drwTextForStreetLamp()
    Citizen.CreateThread(function()
        local sleep = 1000
        while true do
            if CoopDataClient and CoopDataClient.roomSetting and CoopDataClient.roomSetting.startJob then
                for index, value in ipairs(CoopDataClient.roomSetting.Mission.regionstreetLampCoords) do
                    local playerCoords = GetEntityCoords(PlayerPedId())
                    local trafodistance = #(playerCoords - vector3(value.coords.x, value.coords.y, value.coords.z))
                    local onlyZdistance = math.abs(playerCoords.z - value.coords.z)
                    local drawMarkerZ = cachedZCoordsStreet[index]

                    if not drawMarkerZ then
                        drawMarkerZ = FindZForCoords(value.coords.x, value.coords.y)
                        cachedZCoordsStreet[index] = drawMarkerZ + 0.1
                    end
                    if trafodistance < 15 and not value.fixed then
                        sleep = 0
                        DrawMarker(25, value.coords.x, value.coords.y, drawMarkerZ, 0.0, 0.0, 0.0, 0.0, 0.0,
                            0.0, 4.0, 4.0, 4.0, 255, 255, 255, 80, false, false, 2, nil, nil, false)
                    end
                    if trafodistance < 5.0 and not value.fixed and onlyZdistance < 2.0 then
                        sleep = 0
                        DrawText3D(value.coords.x, value.coords.y,
                            value.coords.z + 1.0, Config.Electrician['drawtext'].fixStreetLamp)
                        if not activeSmokeEffectStreetLamp[index] then
                            activeSmokeEffectStreetLamp[index] = CreateSmokeEffect(value.coords)
                        end

                        if IsControlJustPressed(0, 38) then
                            local missionPermit = TriggerCallback('tworst-electrician:server:getTrafoModal',
                                {
                                    owneridentifier = CoopDataClient.roomSetting.owneridentifier,
                                    missionName = 'fixStreetLamp',
                                    coords = value.coords,
                                    index = index
                                })
                            if missionPermit then
                                TriggerServerEvent('tworst-electrician:server:changeTrafoModal',
                                    CoopDataClient.roomSetting.owneridentifier, index, value.coords, 'fixStreetLamp',
                                    true)
                                local settings = {
                                    wireCount = 4,
                                    wireWidth = 0.74,
                                    maxWeldFails = 3,
                                    time = 64,
                                    missionName =
                                    'fixStreetLamp',
                                    coords = value.coords
                                }
                                StartGame(settings, function(success)
                                    if success then
                                        TriggerServerEvent('tworst-electrician:server:switchFixedstreetLamp',
                                            CoopDataClient.roomSetting.owneridentifier, value.coords)

                                        TriggerServerEvent('tworst-electrician:server:UpdateJobTask', 'fixStreetLamp',
                                            CoopDataClient.roomSetting.owneridentifier)
                                    else
                                        if (not IsPedClimbing(PlayerPedId())) then -- Only do animations when not climbing, as this will not work while on a ladder.
                                            PlayAnim('failMinigame')
                                            Wait(2000)
                                        end
                                        local health = GetEntityHealth(PlayerPedId())
                                        SetEntityHealth(PlayerPedId(), health - math.random(10, 25))
                                        TriggerServerEvent('tworst-electrician:server:changeTrafoModal',
                                            CoopDataClient.roomSetting.owneridentifier, index, value.coords,
                                            'fixStreetLamp',
                                            false)
                                    end
                                end)
                            else
                                sendNotification(Config.NotificationText['missionnotpermit'].text,
                                    Config.NotificationText['missionnotpermit'].type)
                            end
                        end
                    else
                        if activeSmokeEffectStreetLamp[index] then
                            RemoveSmokeEffect(activeSmokeEffectStreetLamp[index])
                            activeSmokeEffectStreetLamp[index] = nil
                        end
                    end
                end
            end


            Wait(sleep)
        end
    end)
end

local effect = false
local effectId = false
function CreateSmokeEffect(coords)
    RequestNamedPtfxAsset("core")
    while not HasNamedPtfxAssetLoaded("core") do
        Citizen.Wait(1)
    end
    UseParticleFxAssetNextCall("core")
    effect = StartParticleFxLoopedAtCoord("ent_dst_elec_fire_sp", coords.x, coords.y, coords.z, 0.0, 0.0, 0.0,
        1.0, false, false, false, false)
    effectId = true

    Citizen.CreateThread(function()
        while effectId do
            Citizen.Wait(3000)

            StopParticleFxLooped(effect, 0)
            UseParticleFxAssetNextCall("core")
            effect = StartParticleFxLoopedAtCoord("ent_dst_elec_fire_sp", coords.x, coords.y, coords.z, 0.0, 0.0,
                0.0, 1.0, false, false, false, false)
        end
    end)

    return effect
end

function RemoveSmokeEffect(effect)
    if effect then
        StopParticleFxLooped(effect, false)
        RemoveParticleFx(effect, false)
        effect = nil
        effectId = false
    else
        StopParticleFxLooped(effect, false)
        RemoveParticleFx(effect, false)
        effect = nil
        effectId = false
    end
end

local createdBlips = {}

function drawTextForTrafic()
    Citizen.CreateThread(function()
        local sleep = 1000
        while true do
            if CoopDataClient and CoopDataClient.roomSetting and CoopDataClient.roomSetting.startJob then
                for index, vv in ipairs(CoopDataClient.roomSetting.Mission.regiontrafficLampCoords) do
                    if vv.regionFixedTrafo.fixed then
                        sleep = 0
                        for _, selectedCoords in ipairs(vv.regionTrafficCoords) do
                            local coordsKey = string.format("%f,%f,%f", selectedCoords.coords.x, selectedCoords.coords.y,
                                selectedCoords.coords.z)
                            if not createdBlips[coordsKey] then
                                addBlipsFunctions(selectedCoords.coords, 'Traffic Light', 'fixTrafficLamp2')
                                createdBlips[coordsKey] = true
                            end

                            local playerCoords = GetEntityCoords(PlayerPedId())
                            local trafodistance = #(playerCoords - vector3(selectedCoords.coords.x, selectedCoords.coords.y, selectedCoords.coords.z))
                            if trafodistance < 10 and not selectedCoords.fixed then
                                DrawText3D(selectedCoords.coords.x, selectedCoords.coords.y,
                                    selectedCoords.coords.z + 1.0, Config.Electrician['drawtext'].fixTrafficLamp)
                                if trafodistance < 4 then
                                    if IsControlJustPressed(0, 38) then
                                        SetNuiFocus(true, true)
                                        NuiMessage('WIRING_MINIGAME',
                                            { coords = selectedCoords.coords, missionName = 'fixTrafficLamp' })
                                    end
                                end
                            end
                        end
                    end
                end
            end
            Citizen.Wait(sleep)
        end
    end)
end

function addBlipsFunctions(coords, label, jobName)
    local label = label or "Mission"
    local blip = AddBlipForCoord(coords.x, coords.y)
    SetBlipSprite(blip, Config.Electrician['missionBlips'].SetBlipSprite)
    SetBlipColour(blip, Config.Electrician['missionBlips'].SetBlipColour)
    SetBlipScale(blip, Config.Electrician['missionBlips'].SetBlipScale)
    SetBlipDisplay(blip, Config.Electrician['missionBlips'].SetBlipDisplay)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(label)
    EndTextCommandSetBlipName(blip)
    if jobName == 'phonePole' then
        table.insert(phonePoleBlips, blip)
    elseif jobName == 'fixStreetLamp' then
        table.insert(streetLampBlips, blip)
    elseif jobName == 'fixHouseBoard' then
        table.insert(houseBoardBlips, blip)
    elseif jobName == 'fixTrafo' then
        table.insert(streetTrafoBlips, blip)
    elseif jobName == 'fixTrafficLamp' then
        table.insert(TrafficLamp, blip)
    elseif jobName == 'fixTrafficLamp2' then
        table.insert(TrafficLamp2, blip)
    end
end

function spawnMission3()
    if CoopDataClient and CoopDataClient.roomSetting and CoopDataClient.roomSetting.startJob then
        for index, value in ipairs(CoopDataClient.roomSetting.Mission.regionhouseBoardCoords) do
            drawTextForHouseBoard()
            for indexx, valuee in ipairs(CoopDataClient.roomSetting.Mission.regionJobTask) do
                if valuee.jobName == 'fixHouseBoard' then
                    addBlipsFunctions(value.coords, valuee.jobBlipLabel, 'fixHouseBoard')
                end
            end
        end
    end
end

function spawnMission4()
    if CoopDataClient and CoopDataClient.roomSetting and CoopDataClient.roomSetting.startJob then
        for index, value in ipairs(CoopDataClient.roomSetting.Mission.regionstreetTrafoCoords) do
            drwTextForstreetTrafo()
            for indexx, valuee in ipairs(CoopDataClient.roomSetting.Mission.regionJobTask) do
                if valuee.jobName == 'fixTrafo' then
                    addBlipsFunctions(value.coords, valuee.jobBlipLabel, 'fixTrafo')
                end
            end
        end
    end
end

function changeTrafficLightColor(trafficLight)
    if CoopDataClient and CoopDataClient.roomSetting and CoopDataClient.roomSetting.startJob then
        local colors = { 0, 1, 2 } -- 0 = green, 1 = yellow, 2 = red
        local color = colors[math.random(#colors)]
        SetEntityTrafficlightOverride(trafficLight, color)
    end
end

function spawnMission1()
    if CoopDataClient and CoopDataClient.roomSetting and CoopDataClient.roomSetting.startJob then
        -- Helper function to check if coords exist in trafficLights
        local function coordsExist(coords, trafficLights)
            for _, lightData in ipairs(trafficLights) do
                if #(lightData.coords - coords) < 1.0 then -- Check within 1.0 unit distance
                    return true, lightData.fixed
                end
            end
            return false, nil
        end

        -- Add blips for the region areas
        for index, v in ipairs(CoopDataClient.roomSetting.Mission.regiontrafficLampCoords) do
            for indexx, valuee in ipairs(CoopDataClient.roomSetting.Mission.regionJobTask) do
                if valuee.jobName == 'fixTrafficLamp' then
                    addBlipsFunctions(v.regionFixedTrafo.coords, valuee.jobBlipLabel, 'fixTrafficLamp')
                end
            end
        end

        drawTextForTrafo()
        drawTextForTrafic()

        while true do
            Citizen.Wait(250)
            if not CoopDataClient or not CoopDataClient.players or not CoopDataClient.roomSetting.Mission.regiontrafficLampCoords then
                break
            end

            for index, v in ipairs(CoopDataClient.roomSetting.Mission.regiontrafficLampCoords) do
                local playerCoords = GetEntityCoords(PlayerPedId())
                local distance = #(playerCoords - vector3(v.regionAreaCoords.x, v.regionAreaCoords.y, v.regionAreaCoords.z))

                if distance > 150 then
                    Citizen.Wait(5000)
                else
                    while true do
                        local playerCoords = GetEntityCoords(PlayerPedId())

                        for _, model in ipairs(Config.trafficLightModels) do
                            local light = GetClosestObjectOfType(playerCoords,
                                tonumber(v.regionareaDistance) + 0.0,
                                GetHashKey(model), false, false, false)

                            if light ~= 0 then
                                local lightcoords = GetEntityCoords(light)
                                if lightcoords and #(vector3(v.regionAreaCoords.x, v.regionAreaCoords.y, v.regionAreaCoords.z) - lightcoords) <= tonumber(v.regionareaDistance) then
                                    local exists, fixed = coordsExist(lightcoords, trafficLights)
                                    if not exists then
                                        local lightData = {
                                            coords = lightcoords,
                                            light = light,
                                            fixed = false
                                        }
                                        table.insert(trafficLights, lightData)
                                    end
                                end
                            end
                        end

                        -- Update traffic lights
                        for _, trafficLight in ipairs(trafficLights) do
                            if not trafficLight.fixed then
                                changeTrafficLightColor(trafficLight.light)
                            end
                        end

                        Citizen.Wait(250) -- Sleep for traffic light changes
                    end
                    break
                end
            end
        end
    else
        sendNotification(Config.NotificationText['jobnotstart'].text, Config.NotificationText['jobnotstart'].type)
    end
end

RegisterNUICallback('fixWirings', function(data)
    SetNuiFocus(false, false)
    NuiMessage('CLOSE_WIRING')
    TriggerServerEvent('tworst-electrician:server:UpdateJobTask', data.missionName,
        CoopDataClient.roomSetting.owneridentifier)
    TriggerServerEvent('tworst-electrician:server:trafficLightsFixed', CoopDataClient.roomSetting.owneridentifier,
        data.coords)
end)


function spawnMission2()
    if CoopDataClient and CoopDataClient.roomSetting and CoopDataClient.roomSetting.startJob then
        for index, value in ipairs(CoopDataClient.roomSetting.Mission.regionstreetLampCoords) do
            drwTextForStreetLamp()
            liftdrawtextStreetLamp()
            for indexx, valuee in ipairs(CoopDataClient.roomSetting.Mission.regionJobTask) do
                if valuee.jobName == 'fixStreetLamp' then
                    addBlipsFunctions(value.coords, valuee.jobBlipLabel, 'fixStreetLamp')
                end
            end
        end
    end
end

function spawnMission5()
    if CoopDataClient and CoopDataClient.roomSetting and CoopDataClient.roomSetting.startJob then
        for index, value in ipairs(CoopDataClient.roomSetting.Mission.regionphonePoleCoords) do
            drwTextForphonePole()
            liftdrawtextphonePole()
            for indexx, valuee in ipairs(CoopDataClient.roomSetting.Mission.regionJobTask) do
                if valuee.jobName == 'phonePole' then
                    addBlipsFunctions(value.coords, valuee.jobBlipLabel, 'phonePole')
                end
            end
        end
    end
end

local currentGame

function StartGame(settings, cb)
    if currentGame then return end

    currentGame = settings
    if (IsPedClimbing(PlayerPedId())) then
        currentGame.climbing = true
    else
        ClearPedTasksImmediately(PlayerPedId())
        FreezeEntityPosition(PlayerPedId(), true)
    end
    SetNuiFocus(true, true)

    NuiMessage('START_MINIGAME_CABLETWO', currentGame)
    currentGame.cb = cb
end

function EndGame()
    local climbing = currentGame.climbing
    currentGame = nil
    if not climbing then
        FreezeEntityPosition(PlayerPedId(), false)
    end
    SetNuiFocus(false, false)
end

RegisterNUICallback("gameCompleted", function(data, cb2)
    local cb = currentGame.cb
    local climbing = currentGame.climbing
    currentGame = nil
    SetNuiFocus(false, false)
    if not climbing then
        FreezeEntityPosition(PlayerPedId(), false)
    end
    if cb then cb(data.success) end
    if cb2 then cb2() end
end)

RegisterNUICallback("welding", function(data, cb)
    if currentGame.climbing then return end
    if data.toggle and not isWelding then
        local ped = PlayerPedId()
        ClearPedTasksImmediately(ped)
        TaskStartScenarioInPlace(ped, "WORLD_HUMAN_WELDING", -1, -1)
    else
        isWelding = false
        local ped = PlayerPedId()
        ClearPedTasksImmediately(ped)
        ClearAreaOfObjects(GetEntityCoords(ped), 1.0, 0)
    end
    if cb then cb() end
end)



-- LİFT--
RegisterNetEvent("tworst-electrician:createLift", function(data)
    local input = 4.0
    if not input or not tonumber(input) then return end
    local success = liftSpawn()
    if not success then return end
    local ped        = PlayerPedId()
    local pedcoordsZ = GetEntityCoords(ped).z - 1.2

    local coords     = data
    coords.z         = pedcoordsZ
    coords.x         = coords.x + 1.9
    coords.y         = coords.y + 0.0
    TriggerServerEvent("tworst-electrician:spawnLift", coords, GetEntityHeading(ped) - 180.0, tonumber(input))
end)


function liftSpawn()
    PlayAnim('ladderUp')
    return true
end

RegisterNetEvent("tworst-electrician:updateLift", function(id, data)
    if type(id) == "table" then
        Lifts = id
    else
        Lifts[id] = data
    end
end)

function GetLift(index)
    if LocalLifts[index] and DoesEntityExist(LocalLifts[index].lift) then
        return LocalLifts[index]
    elseif LocalLifts[index] then
        return DeleteLift(index)
    end
end

function DeleteLift(index)
    if not LocalLifts[index] then return end
    local lift = LocalLifts[index]

    if DoesEntityExist(lift.lift) then
        DeleteEntity(lift.lift)
    end

    for i = 1, #lift.rails do
        if DoesEntityExist(lift.rails[i]) then
            DeleteEntity(lift.rails[i])
        end
    end
end

function EnsureLift(index)
    local lift = GetLift(index)
    if lift then return lift end

    local lift = {}

    local data = Lifts[index]
    local coords = data.coords
    local heading = data.heading
    local railHeight = data.railHeight

    local prop = CreateProp(`prop_dock_crane_lift`, coords.x, coords.y, data.currentHeight, false, true)
    SetEntityHeading(prop, heading)
    FreezeEntityPosition(prop, true)
    lift.lift = prop
    local coords = GetOffsetFromEntityInWorldCoords(prop, -0.7, 0.0, -1.5)
    lift.rails = {}
    for i = 1, railHeight do
        local prop = CreateProp(`prop_conslift_rail`, coords.x, coords.y, coords.z + (5.0 * (i - 1)), false, true)
        SetEntityHeading(prop, heading)
        FreezeEntityPosition(prop, true)
        table.insert(lift.rails, prop)
    end
    LocalLifts[index] = lift
    return lift
end

function ControlLift(index)
    if ControllingLift then return end
    ControllingLift = true
    CreateThread(function()
        local offset = 1.0
        local controls = { up = 172, down = 173 }
        while ControllingLift do
            local lift = GetLift(index)
            if not lift or #(GetOffsetFromEntityInWorldCoords(lift.lift, 0.0, 0.0, 0.0) - GetEntityCoords(PlayerPedId())) > 1.3 then break end
            if IsControlJustPressed(1, controls.up) then
                TriggerServerEvent("tworst-electrician:moveLift", index, "up", true, GetEntityCoords(lift.lift).z)
            elseif IsControlJustReleased(1, controls.up) then
                TriggerServerEvent("tworst-electrician:moveLift", index, "up", false, GetEntityCoords(lift.lift).z)
            end
            if IsControlJustPressed(1, controls.down) then
                TriggerServerEvent("tworst-electrician:moveLift", index, "down", true, GetEntityCoords(lift.lift).z)
            elseif IsControlJustReleased(1, controls.down) then
                TriggerServerEvent("tworst-electrician:moveLift", index, "down", false, GetEntityCoords(lift.lift).z)
            end
            Wait(0)
        end
        ControllingLift = false
        local lift = GetLift(index)
        if not lift then return end
        TriggerServerEvent("tworst-electrician:moveLift", index, "down", false, GetEntityCoords(lift.lift).z)
    end)
end

function RemoveLift(index)
    local success = TriggerCallback('tworst-electrician:canRemoveLift', index)
    if not success then return end
    local success = deleteLift()
    if not success then return end
    ladder = false
    liftcraft = false
    TriggerServerEvent("tworst-electrician:removeLift", index, CoopDataClient.roomSetting.owneridentifier)
end

function deleteLift()
    NuiMessage('showProgressBar', { label = Config.Locales['liftremove'], time = 2.5 })
    PlayAnim('ladderDown')

    return true -- Success
end

RegisterNetEvent("tworst-electrician:moveLift", function(id, direction, toggle, height)
    local lift = GetLift(id)
    local data = Lifts[id]
    if not lift or not data then return end

    local coords = data.coords
    local minHeight = (coords.z + 1.5)
    local maxHeight = minHeight + (5.0 * #lift.rails - 2) - 1.0
    local speed = 0.015
    local prop = lift.lift

    SetEntityCoords(prop, coords.x, coords.y, height)

    if not toggle then return end
    CreateThread(function()
        while true do
            local data = Lifts[id]
            if data.direction == direction or data.moving == toggle then break end
            Wait(0)
        end
        while true do
            local lift = GetLift(id)
            local data = Lifts[id]
            if not lift or not data then break end
            if data.direction ~= direction or data.moving ~= toggle then break end
            if direction == "up" then
                SlideObject(prop, coords.x, coords.y, maxHeight, speed, speed, speed, true)
            elseif direction == "down" then
                SlideObject(prop, coords.x, coords.y, minHeight, speed, speed, speed, true)
            end
            Wait(0)
        end
    end)
end)

RegisterNetEvent("tworst-electrician:removeLift", function(id)
    DeleteLift(id)
end)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    for k, v in pairs(LocalLifts) do
        DeleteLift(k)
    end
end)

local liftInfo = false
CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local wait = 1500
        local isInRange = false -- Yeni değişken
        for k, v in pairs(Lifts) do
            local dist = #(v2(v.coords) - v2(coords))
            if (dist < 20.0) then
                wait = 0
                local lift = EnsureLift(k)
                local location = GetOffsetFromEntityInWorldCoords(lift.lift, 0.0, 0.0, 0.0)
                local dist = #(location - coords)
                if dist < 1.3 then
                    ControlLift(k)
                    isInRange = true -- Oyuncu mesafede
                end
                local location = GetOffsetFromEntityInWorldCoords(lift.rails[1], -1.0, 0.0, -1.0)
                local dist = #(location - coords)
                if dist < 1.3 then
                    DrawText3D(coords.x, coords.y, coords.z, Config.Electrician['drawtext'].removelift)
                end
                if dist < 1.3 and IsControlJustPressed(1, 51) then
                    RemoveLift(k)
                end
            elseif (GetLift(k)) then
                DeleteLift(k)
            end
        end
        -- Mesafeye göre liftInfo değişkenini güncelle
        if isInRange then
            liftInfo = true
        else
            liftInfo = false
        end
        Wait(wait)
    end
end)

function LiftInfo()
    while true do
        Wait(0)
        if liftInfo then
            NuiMessage('LIFT_INFO', true)
        else
            NuiMessage('LIFT_INFO', false)
        end
    end
end

-- LiftInfo fonksiyonunu bir thread olarak çalıştırın
CreateThread(LiftInfo)


function v2(coords) return vec3(coords.x, coords.y, 0.0) end

function CreateProp(modelHash, ...)
    if not IsModelInCdimage(modelHash) then
        return
    end
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do Wait(0) end
    local obj = CreateObject(modelHash, ...)
    SetModelAsNoLongerNeeded(modelHash)
    return obj
end

--LADDER--



function DeleteLadder(key)
    local spawned = SpawnedLadders[key]
    if not spawned then return end
    if DoesEntityExist(spawned.ladder) then
        DeleteEntity(spawned.ladder)
    end
    if DoesEntityExist(spawned.limit) then
        DeleteEntity(spawned.limit)
    end
    SpawnedLadders[key] = nil
end

function IsLadderMissing(key)
    if not Ladders[key] then
        if SpawnedLadders[key] then
            DeleteLadder(key)
        end
        return false
    end
    if SpawnedLadders[key] then
        if not DoesEntityExist(SpawnedLadders[key].ladder) or not DoesEntityExist(SpawnedLadders[key].limit) then
            DeleteLadder(key)
            return true
        end
        return false
    else
        return true
    end
end

function EnsureLadder(key)
    if not IsLadderMissing(key) then return end
    local ladder = Ladders[key]
    local model = "hw1_06_ldr_02"
    local prop = CreateProp(model, ladder.props.ladder.x, ladder.props.ladder.y, ladder.props.ladder.z, false, true,
        false)
    local prop2 = CreateProp(`prop_wallbrick_01`, ladder.props.limit.x, ladder.props.limit.y, ladder.props.limit.z, false,
        true, false) -- This prevents the player from climbing over.
    SetEntityHeading(prop, ladder.rotation.ladder)
    SetEntityHeading(prop2, ladder.rotation.limit)
    FreezeEntityPosition(prop, true)
    FreezeEntityPosition(prop2, true)
    SetEntityAlpha(prop2, 0)
    SpawnedLadders[key] = {
        ladder = prop,
        limit = prop2
    }
end

function RemoveLadder(key)
    local data = { key = key, owneridentifier = CoopDataClient.roomSetting.owneridentifier }
    local removesucces = TriggerCallback('tworst-electrician:removeLadder', data)
    if not removesucces then return end
    NuiMessage('showProgressBar', { label = Config.Locales['ladderremove'], time = 2.5 })
    PlayAnim('ladderDown')
end

function CreateLadder(coords)
    local spawn = {
        offset = vector3(0.0, 0.0, -6.0),     -- Where the ladder will spawn.
        rotOffset = 90.0,
        limitOffset = vector3(0.0, 0.5, 4.0), -- Where the limit will spawn.
        rotLimit = 0.0,
    }


    -- Add the offset to the specified coords
    local ladderCoords = vector3(coords.x + spawn.offset.x, coords.y + spawn.offset.y, coords.z + spawn.offset.z)
    local limitCoords = vector3(coords.x + spawn.limitOffset.x, coords.y + spawn.limitOffset.y,
        coords.z + spawn.limitOffset.z)

    local ped = PlayerPedId()
    local data = {
        index = 1,
        props = {
            ladder = ladderCoords,
            limit = limitCoords,
        },
        rotation = {
            ladder = (GetEntityHeading(ped) + spawn.rotOffset),
            limit = (GetEntityHeading(ped) + spawn.rotLimit),
        },
    }

    local placeLadder = TriggerCallback('tworst-electrician:placeLadder', data)
    if not placeLadder then return end
    PlayAnim('ladderUp')
end

CreateThread(function()
    while true do
        local wait = 1000
        local ped = PlayerPedId()
        local pcoords = GetEntityCoords(ped)
        for k, v in pairs(Ladders) do
            local coords = v.props.ladder
            local dist = #(pcoords - coords)
            if dist < 20.0 then
                wait = 0
                EnsureLadder(k)
                if dist < 2.25 then
                    DrawText3D(coords.x, coords.y, coords.z, Config.Electrician['drawtext'].removeladder)
                end
                if dist < 2.25 and IsControlJustPressed(1, 51) then
                    RemoveLadder(k)
                end
            else
                DeleteLadder(k)
            end
        end
        Wait(wait)
    end
end)

RegisterNetEvent("tworst-electrician:createLadder", function(coords)
    CreateLadder(coords)
end)

RegisterNetEvent("tworst-electrician:removeLadder", function(key)
    DeleteLadder(key)
end)

RegisterNetEvent("tworst-electrician:updateLadders", function(index, data)
    if index then
        Ladders[index] = data
    else
        Ladders = data
    end
end)

AddEventHandler("onResourceStop", function(name)
    if (GetCurrentResourceName() ~= name) then return end
    for k, v in pairs(SpawnedLadders) do
        DeleteLadder(k)
    end
end)
