ESX = nil
local opene = false
second = 1000
local Checkcar = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    CreateMechanicPed()
end)

function LoadModel(model)
    while not HasModelLoaded(model) do
          RequestModel(model)
          Citizen.Wait(10)
    end
end

Citizen.CreateThread(function()

    for i=1, #Config.Coords, 1 do
        local blip = AddBlipForCoord(Config.Coords[i].x, Config.Coords[i].y, Config.Coords[i].z)

        SetBlipSprite (blip, 402)
        SetBlipDisplay(blip, 4)
        SetBlipScale  (blip, 1.0)
        SetBlipColour (blip, 64)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString((Config.Blip))
        EndTextCommandSetBlipName(blip)
    end

end)

function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end
end

--==========================================================================-- Repaircar

local Mechanic_Ped          = {}
local PlayerOnMechanicZone  = false
local Repairing             = false

function CreateMechanicPed()
    for k, v in pairs(Config.Coords) do
        LoadModel(Config.Ped)
        local PedKey = GetHashKey(Config.Ped)
        local MechanicPed = CreatePed(5, PedKey, v.x,v.y,v.z-1, false, false, false)
        SetEntityHeading(MechanicPed,v.h)
        SetEntityInvincible(MechanicPed, true)
        SetBlockingOfNonTemporaryEvents(MechanicPed, true)
        SetPedDiesWhenInjured(MechanicPed, false)
        SetPedCanRagdollFromPlayerImpact(MechanicPed, false)
        FreezeEntityPosition(MechanicPed, true)
        SetEntityAsMissionEntity(MechanicPed, true, true)
        SetEntityAsMissionEntity(MechanicPed, true, true)
        table.insert(Mechanic_Ped,{Ped = MechanicPed})

    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local coords      = GetEntityCoords(PlayerPedId())
        local isInMarker  = false
        local currentZone = nil

        for k, v in pairs(Config.Coords) do
            if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 5.0) then
                isInMarker  = true
                currentZone = k
                opene       = true
            end
        end

        if (isInMarker and not PlayerOnMechanicZone) or (isInMarker and LastZone ~= currentZone) then
            PlayerOnMechanicZone = true
            LastZone             = currentZone
        end
        if not isInMarker and PlayerOnMechanicZone then
            PlayerOnMechanicZone = false
            Checkcar = false
            Washing = false
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Sleep = 1000
        if PlayerOnMechanicZone then
            local CarTarget = GetVehiclePedIsIn(PlayerPedId(),false)
            local VehicleCoords = GetEntityCoords(CarTarget)

            for k,v in pairs(Config.Type) do
                Sleep = 5
                if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
                    if IsDisabledControlJustPressed(0,38) then
                        if not Repairing then
                            if CheckBlackList() then

                                SetNuiFocus(true, true)

                                SendNUIMessage({
                                    display = true,
                                })

                                SendNUIMessage({
                                    itemLabel = v.text,
                                    price = v.price,
                                })
                            else
                                exports['mythic_notify']:DoHudText('error', 'รถคันนี้ไม่สามารถซ่อมได้')
                            end
                        end
                    end
                    if opene then
                        textui()
                    end
                end
            end
        end
        Citizen.Wait(Sleep)
    end
end)

RegisterNUICallback('Yes', function(data, cb)

    SendNUIMessage({
        clear = true,
    })

    for k,v in pairs(Config.Type) do
        if data.item == v.text then
            if k == 'Check' then
                local checkmoneyCheck = exports["Fewthz_Check"]:Money()
                if checkmoneyCheck > v.price then
                    opene = false
                    Checkcar = true
                    TriggerServerEvent('FewZ_repair:Removemoney',v.price)
                    exports['mythic_notify']:DoHudText('success', 'คุณใช้บริการเปิดดูค่ารถ ราคา '..v.price..' บาท')
                else
                    exports['mythic_notify']:DoHudText('error', 'คุณมีเงินไม่เพียงพอ')
                    FreezeEntityPosition(VehicleSit, false)
                end
            elseif k == 'Repairall' then
                local checkmoneyCheck = exports["Fewthz_Check"]:Money()
                if checkmoneyCheck > v.price then
                    TriggerServerEvent('FewZ_repair:Removemoney',v.price)
                    StartingRepairCar('all')
                    exports['mythic_notify']:DoHudText('success', 'คุณใช้บริการซ่อมทั้งหมด ราคา '..v.price..' บาท')
                else
                    exports['mythic_notify']:DoHudText('error', 'คุณมีเงินไม่เพียงพอ')
                    FreezeEntityPosition(VehicleSit, false)
                end
            elseif k == 'Repairout' then
                local checkmoneyCheck = exports["Fewthz_Check"]:Money()
                if checkmoneyCheck > v.price then
                    TriggerServerEvent('FewZ_repair:Removemoney',v.price)
                    StartingRepairCar('body')
                    exports['mythic_notify']:DoHudText('success', 'คุณใช้บริการซ่อมภายนอก ราคา '..v.price..' บาท')
                else
                    exports['mythic_notify']:DoHudText('error', 'คุณมีเงินไม่เพียงพอ')
                    FreezeEntityPosition(VehicleSit, false)
                end
            elseif k == 'Repair' then
                local checkmoneyCheck = exports["Fewthz_Check"]:Money()
                if checkmoneyCheck > v.price then
                    TriggerServerEvent('FewZ_repair:Removemoney',v.price)
                    StartingRepairCar('engine')
                    exports['mythic_notify']:DoHudText('success', 'คุณใช้บริการซ่อมเครื่องยนต์ ราคา '..v.price..' บาท')
                else
                    exports['mythic_notify']:DoHudText('error', 'คุณมีเงินไม่เพียงพอ')
                    FreezeEntityPosition(VehicleSit, false)
                end
            elseif k == 'Wash' then
                local checkmoneyCheck = exports["Fewthz_Check"]:Money()
                if checkmoneyCheck > v.price then
                    TriggerServerEvent('FewZ_repair:Removemoney',v.price)
                    StartingWashCar('Wash')
                    exports['mythic_notify']:DoHudText('success', 'คุณใช้บริการล้างรถ ราคา '..v.price..' บาท')
                else
                    exports['mythic_notify']:DoHudText('error', 'คุณมีเงินไม่เพียงพอ')
                    FreezeEntityPosition(VehicleSit, false)
                end
            end
        end
    end

end)

RegisterNUICallback('focusOff', function(data, cb)
    SetNuiFocus(false, false)
end)

function CheckBlackList()
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsIn(ped, false)
    local model = GetEntityModel(veh)
    local vehiclename = GetDisplayNameFromVehicleModel(model)
    local IsBlacklist = false
    for k,v in pairs(Config['Blacklist']) do
        if vehiclename == v then
            IsBlacklist = true
        end
    end
    if IsBlacklist then
        return false
    else
        return true
    end
end

Citizen.CreateThread(function()
    while true do
        Sleep = 1000
        if Checkcar then
            opene = false
            if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then

                for k, v in pairs(Config.Coords) do
                    Sleep = 5
                    local CarTarget = GetVehiclePedIsIn(PlayerPedId(),false)
                    local CarBodyHealth = GetVehicleBodyHealth(CarTarget)
                    local CarEngineHealth = GetVehicleEngineHealth(CarTarget)
                    local VehicleCoords = GetEntityCoords(CarTarget)
                    Drawtext(VehicleCoords.x,VehicleCoords.y,VehicleCoords.z + 1, '<font face="font4thai">~b~ BODY ~s~'..math.modf(CarBodyHealth / 10).. 
                    ' %  / ~r~ ENGINE ~s~'..math.modf(CarEngineHealth / 10)..' %</font>')
                end
            end
        end
        Citizen.Wait(Sleep)
    end
end)


function StartingRepairCar(type)
    for k, v in pairs(Mechanic_Ped) do
        local MechanicCoords = GetEntityCoords(v.Ped)
        for p, i in pairs(Config.Coords) do
            local coords = GetEntityCoords(PlayerPedId())
            if GetDistanceBetweenCoords(coords, i.x, i.y, i.z, true) < 5.0 then
                if GetDistanceBetweenCoords(MechanicCoords, i.x, i.y, i.z, true) < 2.0 then
                    local CarTarget = GetVehiclePedIsIn(PlayerPedId(), false)
                    local PlayerHeading = GetEntityHeading(PlayerPedId())
                    local NPCHeading = GetEntityHeading(v.Ped)
                    local CarTargetX, CarTargetY, CarTargetZ = table.unpack(GetOffsetFromEntityInWorldCoords(CarTarget, 0.0, 3.0, 0.0))

                    Repairing = true
                    FreezeEntityPosition(CarTarget, true)


                    FreezeEntityPosition(v.Ped, false)
                    TaskGoStraightToCoord(v.Ped, CarTargetX, CarTargetY, CarTargetZ, 1.0, -1, PlayerHeading - 180, 1.0)
                    LoadAnimDict('anim@amb@clubhouse@tutorial@bkr_tut_ig3@')
                    TaskPlayAnim(v.Ped, 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', "machinic_loop_mechandplayer", 8.0, -8.0, -1, 49, -1, false, false, false)
                    loadingbar()
                    Citizen.Wait(Config.Time * second)
                    if type == 'all' then
                        SetVehicleEngineHealth(CarTarget, 1000.0)
                        SetVehicleBodyHealth(CarTarget, 1000.0)
                        SetVehicleFixed(CarTarget)
                    end
                    if type == 'body' then
                        local SaveLastEngine = GetVehicleEngineHealth(CarTarget)
                        SetVehicleBodyHealth(CarTarget, 1000.0)
                        SetVehicleFixed(CarTarget)
                        SetVehicleEngineHealth(CarTarget, SaveLastEngine)
                    end
                    if type == 'engine' then
                        SetVehicleEngineHealth(CarTarget, 1000.0)
                    end
                    ClearPedTasksImmediately(v.Ped)
                    TaskGoStraightToCoord(v.Ped, i.x, i.y, i.z, 1.0, -1, NPCHeading, 1.0)
                    FreezeEntityPosition(CarTarget, false)
                    FreezeEntityPosition(v.Ped, true)
                    Repairing = false
                    TriggerEvent('FewZ_repair:LoadingNPC')
                    fixevent()
                end

            end
        end
    end
end

function StartingWashCar(type)
    for k, v in pairs(Mechanic_Ped) do
        local MechanicCoords = GetEntityCoords(v.Ped)
        for p, i in pairs(Config.Coords) do
            local coords = GetEntityCoords(PlayerPedId())
            if GetDistanceBetweenCoords(coords, i.x, i.y, i.z, true) < 5.0 then
                if GetDistanceBetweenCoords(MechanicCoords, i.x, i.y, i.z, true) < 2.0 then
                    local CarTarget = GetVehiclePedIsIn(PlayerPedId(), false)
                    local PlayerHeading = GetEntityHeading(PlayerPedId())
                    local NPCHeading = GetEntityHeading(v.Ped)
                    local CarTargetX, CarTargetY, CarTargetZ = table.unpack(GetOffsetFromEntityInWorldCoords(CarTarget, 0.0, 3.0, 0.0))

                    Repairing = true
                    FreezeEntityPosition(CarTarget, true)

                    FreezeEntityPosition(v.Ped, false)
                    TaskGoStraightToCoord(v.Ped, CarTargetX, CarTargetY, CarTargetZ, 1.0, -1, PlayerHeading - 180, 1.0)
                    LoadAnimDict('amb@world_human_maid_clean@idle_a')
                    TaskPlayAnim(v.Ped, 'amb@world_human_maid_clean@idle_a', "idle_a", 8.0, -8.0, -1, 49, -1, false, false, false)
                    loadingbar()
                    Citizen.Wait(Config.Time * second)
                    if type == 'Wash' then
                        SetVehicleDirtLevel(CarTarget, 0.0)
                        WashDecalsFromVehicle(CarTarget, 100.0)
                        RemoveDecalsFromVehicle(CarTarget)
                    end
                    ClearPedTasksImmediately(v.Ped)
                    TaskGoStraightToCoord(v.Ped, i.x, i.y, i.z, 1.0, -1, NPCHeading, 1.0)
                    FreezeEntityPosition(CarTarget, false)
                    FreezeEntityPosition(v.Ped, true)
                    Repairing = false
                    TriggerEvent('FewZ_repair:LoadingNPC')
                    washevent()
                end
            end
        end
    end
end


RegisterNetEvent('FewZ_repair:LoadingNPC')
AddEventHandler('FewZ_repair:LoadingNPC', function()
    Citizen.Wait(1500)
    for k, v in pairs(Mechanic_Ped) do DeleteEntity(v.Ped) end
    CreateMechanicPed()
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        for k, v in pairs(Mechanic_Ped) do DeleteEntity(v.Ped) end
    end
end)

Citizen.CreateThread(function()
    while true do
        Sleep = 1000
        if Repairing then
            DisableControlAction(0, 75, true)
            Sleep = 0
        end
        Citizen.Wait(Sleep)
    end
end)

Drawtext = function(x,y,z, text)
    AddTextEntry('FewZ_repair'..GetCurrentResourceName(), text)
    SetFloatingHelpTextWorldPosition(1, x,y,z)
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
    BeginTextCommandDisplayHelp('FewZ_repair'..GetCurrentResourceName())
    EndTextCommandDisplayHelp(2, false, false, -1)
end