ESX = nil
BountyHunt = nil
bountytime = 0
BountyIDx = 0
watercount = 0
local bounty = false
local Draw = 0
local position = 0
local inblacklistzone = false
local ServerPlayerID = GetPlayerServerId(PlayerId())
bountytime = 0
bountyprice = 0
data = {}
local Wanted = false -- **
upprice2 = 0

local reset = function()
    bounty = false
    Wanted = false
    Draw = -1
    killer = nil
end

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent(Config.framework, function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    Citizen.Wait(5000)
    if not bounty then TriggerServerEvent("ZcplyerConnect") end
    while not ESX.IsPlayerLoaded() do Wait(0) end
    TriggerServerEvent("zcxbountysv")
end)

RegisterNetEvent("bountyfalse")
AddEventHandler("bountyfalse", function()
    bounty = false
    Wanted = false -- **
    Draw = -1
    upprice2 = 0
    SendNUIMessage({gray = true})
    Wait(5000)
    SendNUIMessage({type = false, clear = true})
    --  SendNUIMessage({sound = 'wasted.mp3', volume = 0.5})
end)

RegisterNetEvent("getPrice")
AddEventHandler("getPrice",
                function(cb) TriggerServerEvent("getPrice", upprice) end)
RegisterNetEvent("setPrice")
AddEventHandler("setPrice", function(data)
    Wait(100)
    upprice = data
end)

RegisterNetEvent("Hunterwin")
AddEventHandler("Hunterwin", function()
    SendNUIMessage({sound = '2.mp3', volume = 0.5})
    reset()
end)

RegisterNetEvent("Bountywin")
AddEventHandler("Bountywin", function()
    SendNUIMessage({sound = '3.mp3', volume = 0.5})
    reset()
end)
local lastAG = 0
local sco = 0
local lopst = true
AddEventHandler('gameEventTriggered', function(name, args)
    if Wanted then

        if name == 'CEventNetworkEntityDamage' and args[1] == GetPlayerPed(-1) then

            if args[2] ~= -1 then lastAG = args[2] end
            if args[6] == 1 then
                local KillerNetwork = nil
                if args[2] == -1 then
                    KillerNetwork = NetworkGetPlayerIndexFromPed(lastAG)
                else
                    KillerNetwork = NetworkGetPlayerIndexFromPed(args[2])
                end
                bountyidx = GetPlayerServerId(KillerNetwork)
                TriggerServerEvent("bountyend", bountyidx, upprice, true, zcx)
                lastAG = -1
                Wait(100)
            end
            if lastAG ~= 0 then
                sco = 30
                if lopst then
                    lopst = false
                    Citizen.CreateThread(function()
                        while sco > 0 do
                            Wait(100)
                            sco = sco - 1
                        end
                        lopst = true
                        lastAG = 0
                    end)
                end
            end
        end
    end
end)
RegisterNetEvent("bountystart")
AddEventHandler("bountystart", function(id, time, timeOr, price, name, Textx)
    SendNUIMessage({sound = '1.mp3', volume = 0.5})
    local sw = false
    local bountyPed = GetPlayerPed(GetPlayerFromServerId(id))

    rnd = (tonumber(id) % #Config['ข้อหา']) + 1
    if Textx == nil then
        header = Config['ข้อหา'][rnd].header
    else
        header = Textx
    end
    pic = Config['ข้อหา'][rnd].pic
    bounty = true
    bountyid = id
    Price = price
    Time = time
    bountytime = time
    bountyprice = price
    upprice = bountyprice / timeOr
    SendNUIMessage({gray = 'false'})
    SendNUIMessage({
        type = not sw,
        name = name,
        time = time,
        pricexx = true,
        header = header
    })

    BountyIDx = GetPlayerFromServerId(id)
    CPlayer = GetPlayerPed(BountyIDx)

    sw = not sw

    if ServerPlayerID == bountyid then Wanted = true end
    Citizen.CreateThread(function()
        while bounty do
            Wait(100)
            if IsControlPressed(0, 47) then
                SendNUIMessage({type = not sw})
                sw = not sw
                Wait(1000)
            end
        end
    end)
    Citizen.CreateThread(function()
        upprice2 = bountyprice / timeOr
        while bounty do
            Wait(1000)
            bountytime = bountytime - 1
            upprice = upprice2 + upprice
            if bountytime <= 0 then
                bountytime = 0
                upprice = bountyprice
                bounty = false
                Wanted = false -- **
                if ServerPlayerID == bountyid then
                    TriggerServerEvent("bountyend", bountyid, bountyprice,
                                       false, zcx)
                end
            end
            SendNUIMessage({price = upprice})
        end
    end)
    Citizen.CreateThread(function()
        while bounty do
            if BountyIDx > 0 then
                local drawmakerped = GetPlayerPed(BountyIDx)
                local drawmakercoords = GetEntityCoords(drawmakerped)
                local distance = GetDistanceBetweenCoords(drawmakercoords,
                                                          GetEntityCoords(
                                                              PlayerPedId()),
                                                          true)
                if distance <
                    Config['ระยะมองเห็นมาร์คเกอร์'] then

                    ZcDrawMarker(drawmakercoords)
                end
            end
            Wait(Config['มาร์คเกอร์บนหัว'])
        end
    end)

    Citizen.CreateThread(function()
        while bounty do
            Wait(1000)
            TriggerServerEvent('callforId')
        end
    end)
    Citizen.CreateThread(function()
        while bounty do
            if GlobalState.BountyCoord then
                if bounty then
                    -- RemoveBlip(huntblip)
                    huntblip = AddBlipForCoord(GlobalState.BountyCoord)
                    SetBlipSprite(huntblip, 303)
                    SetBlipScale(huntblip, 2.0)
                    SetBlipColour(huntblip, 1)
                    PulseBlip(huntblip)
                else

                    RemoveBlip(huntblip)
                end
            else
                if DoesBlipExist(huntblip) then
                    RemoveBlip(huntblip)
                end
            end

            Wait(1000)
        end
        if DoesBlipExist(huntblip) then RemoveBlip(huntblip) end
    end)

    Citizen.CreateThread(function()
        while bounty do
            killer = 0
            if Wanted then
                local killed = PlayerPedId()
                if IsPedDeadOrDying(killed, true) then
                    local killer = GetPedKiller(killed)

                    if Wanted then
                        Wait(3000)
                        TriggerEvent('esx_ambulancejob:revive', false)
                        Wait(2000)
                        SetEntityHealth(killed,
                                        Config['เลือดที่จะให้เพิ่มถ้าตายเอง'])
                    end

                end
            end
            Citizen.Wait(300)
        end
    end)

    Citizen.CreateThread(function() -- **
        while bounty do
            Wait(1000)
            inblacklistzone = false
            if Wanted then
                wantedcoord = GetEntityCoords(PlayerPedId())
                for k, v in pairs(Config['แบล๊คลิสโซน']) do
                    if GetDistanceBetweenCoords(wantedcoord, v.coords, true) <
                        v.radius then inblacklistzone = true end
                    if GetDistanceBetweenCoords(wantedcoord, v.coords, true) >
                        v.radius + 10 and
                        GetDistanceBetweenCoords(wantedcoord, v.coords, true) <
                        v.radius + 50 then
                        returncoords = GetEntityCoords(PlayerPedId())

                    end
                end

            end
        end
    end)

    if Config['บัฟพิเศษ'] then
        Citizen.CreateThread(function()
            while bounty do
                Wait(Config['เวลาให้บัฟ'] * 1000)
                if Wanted then
                    SetEntityHealth(PlayerPedId(), 200)
                    ResetPlayerStamina(PlayerPedId())
                end
            end
        end)
    end

    if Config['ห้ามขึ้นรถ'] then
        Citizen.CreateThread(function()
            while bounty do
                Wait(1000)
                if Wanted then
                    if IsPedInAnyVehicle(PlayerPedId(), true) then
                        TaskLeaveAnyVehicle(PlayerPedId(), 0, 0)
                    end
                end
            end
        end)
    end

    if Config['บัฟรถชนไม่ตาย'] then
        Citizen.CreateThread(function()
            while bounty do
                Wait(Config['ดีบัคบัฟรถชน'])
                if Wanted then
                    SetRagdollBlockingFlags(PlayerPedId(), 2)
                end
            end
        end)
    end

    Citizen.CreateThread(function()
        while bounty do
            Wait(1000)
            if Wanted then
                local water, high = GetWaterHeight(wantedcoord.x, wantedcoord.y,
                                                   wantedcoord.z)
                if inblacklistzone then

                    if returncoords ~= nil then
                        if IsPedInAnyVehicle(PlayerPedId(), true) then
                            vehx = GetVehiclePedIsIn(PlayerPedId(), false)
                            SetEntityCoords(vehx, returncoords)
                            notify(
                                'ห้ามเข้าโซนแบล๊คลิส',
                                1000)
                        else
                            SetEntityCoords(PlayerPedId(), returncoords)
                            notify(
                                'ห้ามเข้าโซนแบล๊คลิส',
                                1000)
                        end
                    end
                end
                if Config['ห้ามลงน้ำ'] then
                    if water then
                        forward = GetEntityForwardVector(PlayerPedId()) * 10
                        backwardplayer = wantedcoord - forward
                        watercount = watercount + 1
                        if not Freeze then
                            SetEntityCoords(PlayerPedId(), backwardplayer)
                            notify('ห้ามลงน้ำ', 1000)
                        end
                        if watercount > 10 then
                            closestPlayer, distance = ESX.Game
                                                          .GetClosestPlayer()
                            local closePed = GetPlayerPed(closestPlayer)
                            local closecoords = GetEntityCoords(closePed)
                            if closePed == PlayerPedId() then
                                Freeze = true
                                FreezeEntityPosition(PlayerPedId(), true)
                                notify(
                                    'โดนพระเจ้าลงโทษรอคนมาช่วย',
                                    1000)
                            end
                            if closePed ~= PlayerPedId() then
                                watercount = 0
                                Freeze = false
                                FreezeEntityPosition(PlayerPedId(), false)
                                SetEntityCoords(PlayerPedId(), closecoords)
                                notify(
                                    'โดนพระเจ้าลงโทษดึงไปหาตีน',
                                    1000)
                            end
                        end
                    else
                        if watercount > 0 then
                            watercount = 0
                        end
                        if Freeze then
                            Freeze = false
                            FreezeEntityPosition(PlayerPedId(), false)
                        end
                    end
                end
            end
        end
    end)

end)

RegisterNetEvent("playerOutServer")
AddEventHandler("playerOutServer", function(id, name)
    TriggerEvent('pNotify:SendNotification', {
        text = 'ผู้ถูกล่า ' .. name ..
            ' หลบหนีออกจากเซิฟเวอร์ ถูกหักเงิน x2',
        type = 'error',
        timeout = 10000,
        layout = 'centerLeft',
        queue = 'left'
    })
end)

-- RegisterNetEvent("blipTarget")
-- AddEventHandler("blipTarget", function(coords)
--     Wait(100)
--     if bounty then
--         RemoveBlip(huntblip)
--         huntblip = AddBlipForCoord(coords)
--         SetBlipSprite(huntblip, 303)
--         SetBlipScale(huntblip, 1.5)
--         SetBlipColour(huntblip, 1)
--         PulseBlip(huntblip)
--     else
--         RemoveBlip(huntblip)
--     end
-- end)

function ZcDrawMarker(drawmakercoords)
    position = drawmakercoords
    if Draw <= 0 then
        Draw = Draw + 20
        Citizen.CreateThread(function()
            while Draw > 0 do
                if not HasStreamedTextureDictLoaded("marker") then
                    RequestStreamedTextureDict("marker", true)
                    while not HasStreamedTextureDictLoaded("marker") do
                        Wait(1)
                    end
                else
                    DrawMarker(9, position.x, position.y, position.z + 1.1,
                               -110.0, -300.0, 0.0, 90.0, 180.0, 0.0,
                               Config['ขนาดมาร์คเกอร์'],
                               Config['ขนาดมาร์คเกอร์'],
                               Config['ขนาดมาร์คเกอร์'],
                               255, 255, 255, 200, true, true, 2, false,
                               "marker", pic, false)
                end
                Wait(
                    Config['มาร์คเกอร์กระพริบ'])
                Draw = Draw - 4
            end
        end)
    end
    Draw = Draw + 100
    if Draw > 100 then Draw = 100 end
end

RegisterNetEvent("CheckZone")
AddEventHandler("CheckZone", function(Headhunt)

    if checkzone(Headhunt) and not IsPedDeadOrDying(PlayerPedId(), true) then
        TriggerServerEvent("CheckZoneReturn")
    end

end)

function checkzone(Headhunt)

    local getplayer = GetPlayerPed(GetPlayerFromServerId(Headhunt))

    local getzone = GetEntityCoords(getplayer)

    for k, v in pairs(Config['แบล๊คลิสโซน']) do
        if GetDistanceBetweenCoords(getzone, v.coords.x, v.coords.y, v.coords.z,
                                    true) < v.radius then return false end
    end

    return true
end

local id = 0
local MugshotsCache = {}
local Answers = {}

function GetMugShot(Ped, Tasparent)
    if not Ped then return "" end
    id = id + 1

    local Handle = RegisterPedheadshot(Ped)

    local timer = 2000
    while ((not Handle or not IsPedheadshotReady(Handle) or
        not IsPedheadshotValid(Handle)) and timer > 0) do
        Citizen.Wait(10)
        timer = timer - 10
    end

    local MugShotTxd = 'none'
    if (IsPedheadshotReady(Handle) and IsPedheadshotValid(Handle)) then
        MugshotsCache[id] = Handle
        MugShotTxd = GetPedheadshotTxdString(Handle)
    end

    SendNUIMessage({
        type = 'convert',
        pMugShotTxd = MugShotTxd,
        removeImageBackGround = Tasparent or false,
        id = id
    })

    local p = promise.new()
    Answers[id] = p

    return Citizen.Await(p)
end
exports("GetMugShot", GetMugShot)

RegisterNUICallback('Answer', function(data)
    if MugshotsCache[data.Id] then
        UnregisterPedheadshot(MugshotsCache[data.Id])
        MugshotsCache[data.Id] = nil
    end
    Answers[data.Id]:resolve(data.Answer)
    Answers[data.Id] = nil
end)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then return end
    for k, v in pairs(MugshotsCache) do UnregisterPedheadshot(v) end
    MugshotsCache = {}
    id = 0
end)

RegisterNetEvent("GetMugShot")
AddEventHandler("GetMugShot", function(Headhunt)
    TriggerServerEvent("GetMugShot", GetMugShot(GetPlayerPed(-1), false))

end)
RegisterNetEvent("sendMugshot")
AddEventHandler("sendMugshot",
                function(data) SendNUIMessage({convert = data}) end)

RegisterNetEvent("sendbackid")
AddEventHandler("sendbackid",
                function(idx) BountyIDx = GetPlayerFromServerId(idx) end)
