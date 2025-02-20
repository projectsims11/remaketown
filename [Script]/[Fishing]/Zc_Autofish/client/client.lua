RegisterFontFile('font4thai')
fontId = RegisterFontId('font4thai')

ESX = nil
local startfish = false
local removeitem = 0
local getitem = 0
local getitemtime = Config.TimetoAdd
local _Death = false
local passive = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    Citizen.Wait(100)
    SendNUIMessage({type = false, id = GetPlayerServerId(PlayerId())})
end)

Citizen.CreateThread(function()
    Citizen.Wait(4000)
    _Death = false
    SendNUIMessage({type = false, time = 0})
    ui = false
    startfish = false
end)

Citizen.CreateThread(function()
    while true do
        Wait(1000)
        for k, v in pairs(Config.ZoneAfk) do
            if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),
                                        v.coords, false) < v.dis then
                inzone = true
                vcoords = v.coords
                vdis = v.dis
                break
            else
                inzone = false
                vcoords = nil
                vdis = nil
            end
        end
    end
end)

RegisterNetEvent('Autofish')
AddEventHandler('Autofish', function()
    if not using then
        if inzone then
            if checkHasItem(Config.Removeitem) then
                local dict = "anim@heists@box_carry@"
                startfish = true
                passive = true
                RequestAnimDict(dict)
                while not HasAnimDictLoaded(dict) do
                    Citizen.Wait(100)
                end
                TaskStartScenarioInPlace(GetPlayerPed(-1),
                                         "WORLD_HUMAN_STAND_FISHING", 0, true)
                oldpos = GetEntityCoords(GetPlayerPed(-1))
                if Config.HeadProps ~= nil then Attachprops() end

            else
                TriggerEvent("pNotify:SendNotification", {
                    text = '<strong class="blue-text">ไม่มีเหยื่อตกปลา</strong>',
                    type = "error",
                    timeout = 3000,
                    layout = "bottomCenter",
                    queue = "global"
                })
            end
        else
            TriggerEvent("pNotify:SendNotification", {
                text = '<strong class="blue-text">ใช้ได้เฉพาะในโซน</strong>',
                type = "error",
                timeout = 3000,
                layout = "bottomCenter",
                queue = "global"
            })
        end
    else
        TriggerEvent("pNotify:SendNotification", {
            text = '<strong class="blue-text">ไม่มีเหยื่อตกปลา</strong>',
            type = "error",
            timeout = 3000,
            layout = "bottomCenter",
            queue = "global"
        })
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(100)
        if startfish then
            if IsControlPressed(0, Config.Key) then
                while true do
                    _Death = false
                    SendNUIMessage({type = false, time = 0})
                    Citizen.Wait(0)
                    ui = false
                    startfish = false
                    CancelFishing()
                    break
                end
            end
        end
    end
end)

Citizen.CreateThread(function()  ---- update
    while true do
        Wait(2000)
        if startfish then
            currentpos = GetEntityCoords(GetPlayerPed(-1))
            if GetDistanceBetweenCoords(currentpos, oldpos, true) > 5 then
                while true do
                    _Death = false
                    SendNUIMessage({type = false, time = 0})
                    Citizen.Wait(0)
                    ui = false
                    startfish = false
                    CancelFishing()
                    break
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(1000)
        if startfish then
            _Death = true
            SendNUIMessage({type = _Death, time = getitem})
        end
    end
end)
local startcount = false
Citizen.CreateThread(function()
    while true do

        Wait(1000)
        if startfish then
            if startcount == false then
                startcount = true
                getitem = getitemtime
                removeitem = checkcount(Config.Removeitem)
            end
        end
        if startcount then
            if getitem > 0 then getitem = getitem - 1 end
            if getitem == 0 then
                TriggerServerEvent("AFKfishadd")
                getitem = getitemtime
                removeitem = removeitem - 1
                startcount = false
            elseif removeitem == 0 then
                _Death = false
                SendNUIMessage({type = false, time = 0})
                Citizen.Wait(0)
                ui = false
                startfish = false
                CancelFishing()
            end
        end
    end
end)

checkHasItem = function(item_name)
    local inventory = ESX.GetPlayerData().inventory
    for i = 1, #inventory do
        local item = inventory[i]
        if item_name == item.name and item.count > 0 then return true end
    end
    return false
end

checkcount = function(item_name)
    local inventory = ESX.GetPlayerData().inventory
    for i = 1, #inventory do
        local item = inventory[i]
        if item_name == item.name then return item.count end
    end
end

CancelFishing = function()
    using = false
    startfish = false
    startcount = false
    removeitem = 0
    getitem = 0
    ClearPedTasksImmediately(GetPlayerPed(-1))
    Delprops()
    passive = false
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local ped = PlayerPedId()
        local playerped = GetPlayerPed(-1)
        if passive then
            NetworkSetPlayerIsPassive(true)
            NetworkSetFriendlyFireOption(false)
            SetPedCanRagdoll(ped, false)
            SetEntityInvincible(playerped, true)
            SetEntityAlpha(playerped, 200, false)
        else
            NetworkSetFriendlyFireOption(true)
            SetPedCanRagdoll(ped, true)
            SetEntityInvincible(playerped, false)
            NetworkSetPlayerIsPassive(false)
            ResetEntityAlpha(playerped)
        end
    end
end)

DrawTextF = function(x, y, scale, width, height, text, r, g, b, a, outline)
    SetTextFont(fontId)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(0, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(1)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width / 2.3, y - height / 2 + 0.005)
end

function Attachprops()
    local playerped = GetPlayerPed(-1)
    local x, y, z = table.unpack(GetEntityCoords(playerped))
    local prop = CreateObject(GetHashKey(Config.HeadProps), x, y, z + 0.2, true,
                              true, true)
    local boneIndex = GetPedBoneIndex(playerped, 0x322c)
    AttachEntityToEntity(prop, playerped, boneIndex, 0.25, 0.00, 0.00, 0.0,
                         90.00, 198.0, true, true, false, true, 1, true)
end

function Delprops()
    local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
    local object2 = GetClosestObjectOfType(position.x, position.y, position.z,
                                           15.0, GetHashKey(Config.HeadProps),
                                           false, false, false)
    DeleteObject(object2)
    if object ~= 0 then DeleteObject(object2) end

end

if Config.OpenBlips then
    Citizen.CreateThread(function()
        for k, v in pairs(Config.ZoneAfk) do
            local blip1 = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)
            SetBlipSprite(blip1, Config.Blips)
            SetBlipScale(blip1, Config.BlipsSize)
            SetBlipColour(blip1, Config.BlipsColor)
            SetBlipAsShortRange(blip1, true)

            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(
                '<font face="font4thai"> ตกปลา AFK </font>')
            EndTextCommandSetBlipName(blip1)
        end
    end)
end

if Config.AFK then
    if Config.Food then
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(Config.Foodtime * 1000)
                if startfish then
                    TriggerEvent('esx_status:set', 'hunger',
                                 Config.foodadd * 1000)
                    TriggerEvent('esx_status:set', 'thirst',
                                 Config.foodadd * 1000)
                end
            end
        end)
    end

    if Config.Stress then
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(Config.Foodtime * 1000)
                if startfish then
                    TriggerEvent('esx_status:add', 'stress',
                                 Config.stressremove * 1000)
                end
            end
        end)
    end

    if Config.DirtyandSleep then
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(Config.Foodtime * 1000)
                if startfish then
                    TriggerEvent('esx_status:add', Config.dirt,
                                 Config.DirtyandSleepRemove * 1000)
                    TriggerEvent('esx_status:add', Config.sleep,
                                 Config.DirtyandSleepRemove * 1000)
                end
            end
        end)
    end
end

