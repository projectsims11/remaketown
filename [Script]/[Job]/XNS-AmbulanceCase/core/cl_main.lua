Keys = {
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

local CaseCache = {}

ESX = nil
script_name = GetCurrentResourceName()

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent(Config["esx_routers"]['getSharedObject'], function(obj) ESX = obj end)
        Citizen.Wait(250)
    end

    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

    ESX.PlayerData = ESX.GetPlayerData()

    TriggerServerEvent(script_name .. ":SV:GetConfig")
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterCommand('test', function(source, args, rawCommand)
    local playerPed = PlayerPedId()
	PedPosition		= GetEntityCoords(playerPed)
	local PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z }
	TriggerServerEvent("XNS-AmbulanceCase:SV:SendEmergency", PlayerCoords)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
        if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' then
			if IsControlJustReleased(0, Keys["="]) then
                TransitionToBlurred(1000)
				SetNuiFocus(true, true)
                SendNUIMessage({
                    Action = 'OpenMenu'
                })
			end
		end
	end
end)

RegisterNetEvent(script_name .. ":CL:GetConfig")
AddEventHandler(script_name .. ":CL:GetConfig", function(Cache)
    CaseCache = Cache
    Citizen.Wait(1000)
    SendNUIMessage({
        Action = 'SyncCase',
        Cache = CaseCache
    })
end)

RegisterNetEvent(script_name..":CL:SendEmergency")
AddEventHandler(script_name..":CL:SendEmergency", function(data)
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' then
        exports.pNotify:SendNotification({ text="มีคนกำลังสลบ", type="error"})
        SendNUIMessage({
            Action = 'PlaySound'
        })
    end
    table.insert(CaseCache, {
        Cache = data.Cache,
        Number = data.Number,
        Suscess = false,
        Owner = nil,
        Time = 0,
        Min = 0,
        Text = 'ไม่กี่วินาที',
        Coords = data.Coords
    })
    SendNUIMessage({
        Action = 'UpdateCase',
        Cache = data.Cache,
        Number = data.Number,
        Text = 'ไม่กี่วินาที'
    })
end)

RegisterNetEvent(script_name..":CL:UpdateOwner")
AddEventHandler(script_name..":CL:UpdateOwner", function(data)
    for k, v in pairs(CaseCache) do
        if v.Cache == data.Cache then
            v.Owner = data.Owner
            SendNUIMessage({
                Action = 'UpdateOwner',
                Cache = data.Cache,
                Owner = v.Owner,
            })
        end
    end
end)

RegisterNetEvent(script_name..":CL:UpdateSuscess")
AddEventHandler(script_name..":CL:UpdateSuscess", function(Cache)
    for k, v in pairs(CaseCache) do
        if v.Cache == Cache then
            v.Suscess = true
            SendNUIMessage({
                Action = 'UpdateSuscess',
                Cache = v.Cache
            })
        end
    end
end)

RegisterNetEvent(script_name..":CL:UpdateDelete")
AddEventHandler(script_name..":CL:UpdateDelete", function(Cache)
    for k, v in pairs(CaseCache) do
        if v.Cache == Cache then
            RemoveCase(v.Cache)
            SendNUIMessage({
                Action = 'UpdateDelete',
                Cache = v.Cache
            })
        end
    end
end)

function RemoveCase(Cache)
    local Cache = Cache
    local Notfound = false
    local Time = 15
    Citizen.CreateThread(function()
		while Time > 0 and not Notfound do
			Citizen.Wait(1000)
			if Time > 0 then
				Time = Time - 1
			end
		end
	end)
    
    while not Notfound do
        Wait(0)
        if Time == 0 then
            Notfound = true
        end
        for k,v in pairs(CaseCache) do
            if v.Cache == Cache then
                table.remove(CaseCache, k)
                Notfound = true
            end
        end
    end
end

Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(1000)
        if #CaseCache > 0 then
            for i = 1, #CaseCache, 1 do
                CaseCache[i].Time = CaseCache[i].Time + 1
                if CaseCache[i].Time == 60 then
                    CaseCache[i].Min = CaseCache[i].Min + 1
                    CaseCache[i].Text = ('%s นาที'):format(CaseCache[i].Min)
                    CaseCache[i].Time = 0
                    SendNUIMessage({
                        Action = 'UpdatePhone',
                        Cache = CaseCache[i].Cache,
                        Number = CaseCache[i].Number,
                        Text = CaseCache[i].Text,
                    })
                end
            end
        end
    end
end)

RegisterNUICallback("GetGPS", function(data, cb)
    for k, v in pairs(CaseCache) do
        if v.Cache == tonumber(data.Name) then
            exports.pNotify:SendNotification({ text="ตั้ง GPS ไปที่เกิดเหตุแล้ว", type="success"})
            SetNewWaypoint(v.Coords.x, v.Coords.y)
        end
    end
end)

RegisterNUICallback("UpdateOwner", function(data, cb)
    for k, v in pairs(CaseCache) do
        if v.Cache == tonumber(data.Name) then
            local rdm = math.random(1, 100)
            Citizen.Wait(rdm)
            if v.Owner == nil then
                TriggerServerEvent(script_name..":SV:UpdateOwner", v.Cache)
                SetNewWaypoint(v.Coords.x, v.Coords.y)
            else
                exports.pNotify:SendNotification({ text="มีผู้รับเคสนี้ไปแล้ว", type="error"})
            end
        end
    end
end)

RegisterNUICallback("UpdateSuscess", function(data, cb)
    for k, v in pairs(CaseCache) do
        if v.Cache == tonumber(data.Name) then
            if not v.Suscess then
                if v.Owner ~= nil then
                    TriggerServerEvent(script_name..":SV:UpdateSuscess", v.Cache)
                else
                    exports.pNotify:SendNotification({ text="ยังไม่มีผู้รับเคสนี้", type="error"})
                end
            else
                exports.pNotify:SendNotification({ text="ส่งเคสนี้ไปแล้ว", type="error"})
            end
        end
    end
end)

RegisterNUICallback("UpdateDelete", function(data, cb)
    for k, v in pairs(CaseCache) do
        if v.Cache == tonumber(data.Name) then
            if v.Suscess then
                TriggerServerEvent(script_name..":SV:UpdateDelete", v.Cache)
            else
                exports.pNotify:SendNotification({ text="เคสยังไม่สำเร็จ", type="error"})
            end
        end
    end
end)

RegisterNUICallback("close", function(data, cb)
    TransitionFromBlurred(1000)
    SetNuiFocus(false, false)
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        TransitionFromBlurred(1000)
    end
end)