jobData = {
    jobname = nil,
    job_grade_name = nil,
    job_grade = nil,
    job_label = nil
}
-- ██████╗  ██████╗ ██╗  ██╗   ██╗    ██╗     ███████╗ █████╗ ██╗  ██╗███████╗ 
-- ██╔══██╗██╔═══██╗██║  ╚██╗ ██╔╝    ██║     ██╔════╝██╔══██╗██║ ██╔╝██╔════╝ 
-- ██████╔╝██║   ██║██║   ╚████╔╝     ██║     █████╗  ███████║█████╔╝ ███████╗ 
-- ██╔═══╝ ██║   ██║██║    ╚██╔╝      ██║     ██╔══╝  ██╔══██║██╔═██╗ ╚════██║ 
-- ██║     ╚██████╔╝███████╗██║       ███████╗███████╗██║  ██║██║  ██╗███████║ 
-- ╚═╝      ╚═════╝ ╚══════╝╚═╝       ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝ 
-- [discord.gg/gaJJjnKGpg] 
RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function()
    Wait(1000)
    TriggerServerEvent('tw-electrician:loadData')
end)

RegisterNetEvent("QBCore:Client:OnPlayerLoaded")
AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
    Wait(1000)
    TriggerServerEvent('tw-electrician:loadData')
end)

CreateThread(function()
    Core, Config.Framework = GetCore()
    spawnPed()
    createBlips()
    SetPlayerJob()
end)
AddEventHandler('onResourceStop', function(resource)
    if (GetCurrentServerEndpoint() == nil) then
        return
    end
    if (resource == GetCurrentResourceName()) then
        TriggerServerEvent('tw-electrician:loadData')
        ClearPedTasks(PlayerPedId())
    end
end)

function SetPlayerJob()
    while Core == nil do
        Wait(0)
    end
    Wait(500)
    while not nuiLoaded do
        Wait(50)
    end
    WaitPlayer()

    if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
        local PlayerData = Core.GetPlayerData()
        jobData.jobname = PlayerData.job.name
        jobData.job_grade_name = PlayerData.job.label
        jobData.job_grade = tonumber(PlayerData.job.grade)
    else
        local PlayerData = Core.Functions.GetPlayerData()
        jobData.jobname = PlayerData["job"].name
        jobData.job_grade_name = PlayerData["job"].label
        jobData.job_grade = PlayerData["job"].grade.level
    end
end

function WaitPlayer()
    if Config.Framework == "esx" or Config.Framework == 'oldesx' then
        while Core == nil do
            Wait(0)
        end
        while Core.GetPlayerData() == nil do
            Wait(0)
        end
        while Core.GetPlayerData().job == nil do
            Wait(0)
        end
    else
        while Core == nil do
            Wait(0)
        end
        while Core.Functions.GetPlayerData() == nil do
            Wait(0)
        end
        while Core.Functions.GetPlayerData().metadata == nil do
            Wait(0)
        end
    end
end

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
    Wait(1000)
    SetPlayerJob()
end)

RegisterNetEvent("QBCore:Client:OnJobUpdate")
AddEventHandler("QBCore:Client:OnJobUpdate", function(data)
    Wait(1000)
    SetPlayerJob()
end)


local blips = {}

function createBlips()
    if Config.Electrician['blip']['show'] then
        blips = AddBlipForCoord(tonumber(Config.Electrician['coords'].intreactionCoords.x),
            tonumber(Config.Electrician['coords'].intreactionCoords.y),
            tonumber(Config.Electrician['coords'].intreactionCoords.z))
        SetBlipSprite(blips, Config.Electrician['blip'].blipType)
        SetBlipDisplay(blips, 4)
        SetBlipScale(blips, Config.Electrician['blip'].blipScale)
        SetBlipColour(blips, Config.Electrician['blip'].blipColor)
        SetBlipAsShortRange(blips, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(tostring(Config.Electrician['blip'].blipName))
        EndTextCommandSetBlipName(blips)
    end
end

function canOpen()
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped, false) then
        return false
    end
    if Config.Electrician['job'] then
        if Config.Electrician['job'] ~= 'all' and Config.Electrician['job'] ~= jobData.jobname then
            sendNotification(Config.NotificationText['wrongjob'].text, Config.NotificationText['wrongjob'].type)
            return false
        end
    end
    return true
end

function spawnPed()
    if Config.Electrician.coords.ped then
        WaitForModel(Config.Electrician.coords.pedHash)
        local createNpc = CreatePed("PED_TYPE_PROSTITUTE",
            Config.Electrician.coords.pedHash,
            Config.Electrician.coords.pedCoords.x,
            Config.Electrician.coords.pedCoords.y,
            Config.Electrician.coords.pedCoords.z - 0.98,
            Config.Electrician.coords.pedHeading, false,
            false)
        FreezeEntityPosition(createNpc, true)
        SetEntityInvincible(createNpc, true)
        SetBlockingOfNonTemporaryEvents(createNpc, true)
    end
end

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    SetTextScale(0.3, 0.3)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 370
    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 90)
end

function SetBlipAttributes(blip, id)
    SetBlipSprite(blip, 1)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.8)
    SetBlipAsShortRange(blip, true)
    SetBlipColour(blip, 26)
    ShowNumberOnBlip(blip, id)
    SetBlipShowCone(blip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Electrician : " .. id)
    EndTextCommandSetBlipName(blip)
end

RegisterNetEvent('tworst-electrician:openMenu', function()
    if canOpen() then
        openElectricinMenu()
    end
end)


function WaitForModel(model)
    if not IsModelValid(model) then
        return
    end

    if not HasModelLoaded(model) then
        RequestModel(model)
    end

    while not HasModelLoaded(model) do
        Citizen.Wait(0)
    end
end

Citizen.CreateThread(function()
    Config.OpenTrigger = function()
        if Config.InteractionHandler == "qb-target" then
            exports['qb-target']:RemoveZone('twelectirician' .. 1)
            exports['qb-target']:RemoveZone('twelectirician' .. 2)
            exports['qb-target']:AddBoxZone("twelectirician" .. 1,
                vector3(Config.Electrician.coords.intreactionCoords.x,
                    Config.Electrician.coords.intreactionCoords.y,
                    Config.Electrician.coords.intreactionCoords.z), 1.5,
                1.5,
                {
                    name = "twelectirician" .. 1,
                    debugPoly = false,
                    heading = -20,
                    minZ = Config.Electrician.coords.intreactionCoords.z - 2,
                    maxZ = Config.Electrician.coords.intreactionCoords.z + 2,
                }, {
                    options = {
                        {
                            type = "client",
                            event = "tworst-electrician:openMenu",
                            icon = 'fas fa-credit-card',
                            label = "Open Electrician Menu",

                        },
                    },
                    distance = 2
                })
        elseif Config.InteractionHandler == "ox-target" then
            exports.ox_target:removeZone('twelectirician' .. 1)
            exports.ox_target:removeZone('twelectirician' .. 2)

            exports['ox_target']:addBoxZone({
                coords = vector3(Config.Electrician.coords.intreactionCoords.x,
                    Config.Electrician.coords.intreactionCoords.y,
                    Config.Electrician.coords.intreactionCoords.z),
                minZ = Config.Electrician.coords.intreactionCoords.z - 2,
                maxZ = Config.Electrician.coords.intreactionCoords.z + 2,
                heading = -20,
                name = "twelectirician" .. 1,
                id = "twelectirician" .. 1,
                options = {
                    {
                        type = "client",
                        event = "tworst-electrician:openMenu",
                        icon = 'fas fa-credit-card',
                        label = "Open Electrician Menu",
                    },
                },
                distance = 2
            })
        elseif Config.InteractionHandler == "drawtext" then
            Citizen.CreateThread(function()
                while true do
                    local wait = 1500
                    local playerPed = PlayerPedId()
                    local coords = GetEntityCoords(playerPed)
                    local distance = #(coords - Config.Electrician.coords.intreactionCoords)
                    if distance < 1.5 then
                        wait = 0
                        DrawText3D(Config.Electrician.coords.intreactionCoords.x,
                            Config.Electrician.coords.intreactionCoords.y,
                            Config.Electrician.coords.intreactionCoords.z + 1.0,
                            Config.Electrician['drawtext']['text'])
                        if IsControlJustReleased(0, 38) then
                            if canOpen() then
                                openElectricinMenu()
                            end
                        end
                    end
                    Citizen.Wait(wait)
                end
            end)
        end
    end
end)

function TriggerCallback(name, data)
    local incomingData = false
    local status = 'UNKOWN'
    local counter = 0
    while Core == nil do
        Wait(0)
    end
    if Config.Framework == 'esx' then
        Core.TriggerServerCallback(name, function(payload)
            status = 'SUCCESS'
            incomingData = payload
        end, data)
    else
        Core.Functions.TriggerCallback(name, function(payload)
            status = 'SUCCESS'
            incomingData = payload
        end, data)
    end
    CreateThread(function()
        while incomingData == 'UNKOWN' do
            Wait(1000)
            if counter == 4 then
                status = 'FAILED'
                incomingData = false
                break
            end
            counter = counter + 1
        end
    end)

    while status == 'UNKOWN' do
        Wait(0)
    end
    return incomingData
end

function PlayAnim(dataName)
    local playerPed = PlayerPedId()

    if dataName == 'failMinigame' then
        LoadAnimation("ragdoll@human")
        TaskPlayAnim(playerPed, 'ragdoll@human', "electrocute", 8.0, 1.0, -1, 1, 0, false, false, false)
        FreezeEntityPosition(playerPed, true)
        SetTimeout(2800, function()
            ClearPedTasksImmediately(playerPed)
            FreezeEntityPosition(playerPed, false)
        end)
    elseif dataName == 'ladderUp' then
        LoadAnimation("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
        ClearPedTasksImmediately(playerPed)
        FreezeEntityPosition(playerPed, true)
        TaskPlayAnim(playerPed, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 8.0, 1.0, -1,
            1, 0, false, false, false)
        Wait(2500)

        ClearPedTasks(playerPed)
        FreezeEntityPosition(playerPed, false)
    elseif dataName == 'ladderDown' then
        ClearPedTasksImmediately(playerPed)
        FreezeEntityPosition(playerPed, true)
        TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_HAMMERING", -1, -1)

        Wait(2500)

        ClearPedTasks(playerPed)
        FreezeEntityPosition(playerPed, false)

        ClearAreaOfObjects(GetEntityCoords(PlayerPedId()), 1.0, 0)
    end
end

function LoadAnimation(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do Wait(10) end
end

function PlayEffect(dict, particleName, entity, off, rot, time, cb)
    CreateThread(function()
        RequestNamedPtfxAsset(dict)
        while not HasNamedPtfxAssetLoaded(dict) do
            Wait(0)
        end
        UseParticleFxAssetNextCall(dict)
        Wait(10)
        local particleHandle = StartParticleFxLoopedOnEntity(particleName, entity, off.x, off.y, off.z, rot.x, rot.y,
            rot.z, 1.0)
        SetParticleFxLoopedColour(particleHandle, 0, 255, 0, 0)
        Wait(time)
        StopParticleFxLooped(particleHandle, false)
        cb()
    end)
end

function selectRandomCoords(coords, num)
    local selected = {}
    math.randomseed(GetGameTimer())

    if num > #coords then
        num = #coords
    end

    while #selected < num do
        local index = math.random(1, #coords)
        if not table.contains(selected, coords[index]) then
            table.insert(selected, coords[index])
        end
    end

    return selected
end

function table.contains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

function FindZForCoords(x, y)
    local found = true
    local START_Z = 1500.0
    local z = START_Z
    while found and z > 0 do
        local _found, _z = GetGroundZAndNormalFor_3dCoord(x + 0.0, y + 0.0, z - 1.0)
        if _found then
            z = _z + 0.0
        end
        found = _found
        Wait(0)
    end
    return z + 0.0
end

function GetVehicles()
    return GetGamePool('CVehicle')
end

function GetVehiclesInArea(coords, maxDistance)
    return EnumerateEntitiesWithinDistance(GetVehicles(), false, coords, maxDistance)
end

function EnumerateEntitiesWithinDistance(entities, isPlayerEntities, coords, maxDistance)
    local nearbyEntities = {}

    if coords then
        coords = vector3(coords.x, coords.y, coords.z)
    else
        local playerPed = PlayerPedId()
        coords = GetEntityCoords(playerPed)
    end
    for k, entity in pairs(entities) do
        local distance = #(coords - GetEntityCoords(entity))

        if distance <= maxDistance then
            nearbyEntities[#nearbyEntities + 1] = isPlayerEntities and k or entity
        end
    end
    return nearbyEntities
end
