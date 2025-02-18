ESX = nil

PlayerOnline = 0
EMS = 0
POLICE = 0
MECHANIC = 0
COUNCIL = 0

FirstName = {}
PhoneNumber = {}
JOB = {}
JOB_LABEL = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)ESX = obj end)
        Citizen.Wait(0)
    end
    Wait(7)
end)

RegisterNetEvent('scoreboard:avadiscord', function(avatar)
    SendNUIMessage({
        type = 'SetDiscordImg',
        avatar = avatar
    })
end)

RegisterKeyMapping('Scoreboard:openNui', 'Scoreboard', 'keyboard', 'DELETE')

RegisterCommand('Scoreboard:openNui', function()
    ESX.TriggerServerCallback('scoreboard:server:getdata', function(data)
        display = not display
        TriggerEvent("scoreboard:display", display)
        Wait(1000)
        UserProfile(data)
        updatedata(data)
        SendNUIMessage({
            type = 'update',
            my_id = GetPlayerServerId(PlayerId()),
            my_phone = PhoneNumber,
            my_name = FirstName,
            my_job = JOB,
            my_job_label = JOB_LABEL,
            my_ping = Ping,
            players = PlayerOnline,
            ems = EMS,
            police = POLICE,
            mechanic = MECHANIC,
            council = COUNCIL,
        })
    end)
    if not display then
        if Config.Profile == 'Steam' then
            ESX.TriggerServerCallback('scoreboard:avatars', function(avatar)
                local SteamAPI = '67543604E451EF1EC2EDD1CB1BBB1737'
                if avatar[1].steamid then
                    steamid = 'http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=' .. SteamAPI .. '&steamids=' .. avatar[1].steamid
                else
                    steamid = 'null'
                end
                SendNUIMessage({
                    steamid = steamid,
                    display = true
                })
            end)
        elseif Config.Profile == 'Discord' then
            TriggerServerEvent('scoreboard:setavadiscord', function()
            end)
        end
    end
end, false)

RegisterNetEvent('update')
AddEventHandler('update', function(e, p, m, c)
    EMS = e
    POLICE = p
    MECHANIC = m
    COUNCIL = c
    Wait(1000)
    updatedata(e, p, m, c)
end)

RegisterNetEvent('playeronline')
AddEventHandler('playeronline', function(allplayer)
    PlayerOnline = allplayer
    SendNUIMessage({
        type = 'update',
        players = PlayerOnline,
    
    })
end)

AddEventHandler('scoreboard:display', function(value)
    SendNUIMessage({
        type = 'ui',
        display = value
    })
end)

function updatedata(e, p, m, c)
    SendNUIMessage({
        type = 'update',
        my_id = GetPlayerServerId(PlayerId()),
        my_phone = PhoneNumber,
        my_name = FirstName,
        my_job = JOB,
        my_job_label = JOB_LABEL,
        my_ping = Ping,
        players = PlayerOnline,
        ems = e,
        police = p,
        mechanic = m,
        council = c,
    })
end

function UserProfile(data)
    PhoneNumber = data.my_phone
    FirstName = data.my_name
    JOB = data.my_job
    JOB_LABEL = data.my_job_label
    Ping = data.my_ping
end