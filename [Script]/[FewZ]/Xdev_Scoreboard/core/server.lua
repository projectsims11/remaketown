ESX = nil

PlayerOnline = 0
MedicConnected = 0
PoliceConnected = 0
MechanicConnected = 0
CouncilConnected = 0

local botToken = 'MTE5MjQ0NzcxMTEzMjI1NDIyOA.GyvqMq.XkxNIoDzS-3NbvTc9VY1sdz7ANsdiIRbBqPMNk'
local TOKEN = 'Bot '  .. botToken
local DEFAULT_ID = '731765107788349520'

TriggerEvent('esx:getSharedObject', function(obj)ESX = obj end)

ESX.RegisterServerCallback('scoreboard:server:getdata', function(source, cb)
    local iden = GetPlayerIdentifiers(source)[1]
    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @iden LIMIT 0,1', {
        ['@iden'] = iden
    }, function(result)
        if not (result[1] == nil) then
            local data = {}
            local xPlayer = ESX.GetPlayerFromId(source)

            data = {
                my_phone = result[1].phone_number,
                my_name = result[1].firstname .. ' ' .. result[1].lastname,
                my_job = xPlayer.job.label,
                my_ping = GetPlayerPing(source),
                my_job_label = xPlayer.job.grade_label,
                players = PlayerOnline,
                MedicConnected = MedicConnected,
                PoliceConnected = PoliceConnected,
                CouncilConnected = CouncilConnected,
                MechanicConnected = MechanicConnected,
                PlayerOnline = PlayerOnline
            }
            cb(data)
        else
            cb(nil)
        end
    end)
    ESX.RegisterServerCallback('scoreboard:avatars',function(source, cb)
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        local identifier = GetPlayerIdentifiers(source)[1]
        
        MySQL.Async.fetchAll(
            'SELECT * FROM users WHERE identifier = @identifier ',
            {['identifier'] = xPlayer.identifier}, function(result)
                local avatar = {}
                if (result[1] ~= nil) then
                    for i = 1, #result, 1 do
                        table.insert(avatar, {
                        steamid = tonumber(
                        identifier:gsub('steam:', ''), 16)
                    })
                end
                cb(avatar)
            end
        end)
    end)
end)

local function getDiscordId(playerId)
    local identifiers = GetPlayerIdentifiers(playerId)
    for i=1, #identifiers do
        if identifiers[i]:match('discord:') then
            return identifiers[i]:gsub('discord:', '')
        end
    end
    return DEFAULT_ID
end

local function getPlayerFromDiscord(discordId)
    if not discordId then
        return false
    end
    local p = promise.new()
    PerformHttpRequest(('https://discordapp.com/api/users/%s'):format(discordId), function(err, result, headers)
        p:resolve({data=result, code=err, headers = headers})
    end, 'GET', '', {['Content-Type'] = 'application/json', ['Authorization'] = TOKEN})

    local result = Citizen.Await(p)
    if result then
        -- if result.code ~= 200 then
        --     return print('Error: Something went wrong with error code - ' .. result.code)
        -- end
        local data = json.decode(result.data)
        if data and data.avatar then
            return ('https://cdn.discordapp.com/avatars/%s/%s'):format(discordId, data.avatar)
        end
    end
end

RegisterNetEvent('scoreboard:setavadiscord', function()
    local playerIds = source
    local discordId = getDiscordId(playerIds)
    local avatar = getPlayerFromDiscord(discordId)
    TriggerClientEvent('scoreboard:avadiscord', playerIds, avatar)
end)

function GetJobLabel(job_name, job_grade)
    local result = MySQL.Sync.fetchAll('SELECT label FROM job_grades WHERE job_name = @job_name AND grade = @job_grade', {
        ['@job_name'] = job_name,
        ['@job_grade'] = job_grade
    })
    if not (result[1] == nil) then
        return result[1].label
    end
    return nil
end

AddEventHandler('esx:playerLoaded', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.job.name == Config.JobName['2'] then
        MedicConnected = MedicConnected + 1
        PlayerOnline = PlayerOnline + 1
        TriggerClientEvent('update', -1, MedicConnected, PoliceConnected, CouncilConnected, MechanicConnected)
        Wait(1000)
        TriggerClientEvent('playeronline', -1, PlayerOnline)
    elseif xPlayer.job.name == Config.JobName['1'] then
        PoliceConnected = PoliceConnected + 1
        PlayerOnline = PlayerOnline + 1
        TriggerClientEvent('update', -1, MedicConnected, PoliceConnected, CouncilConnected, MechanicConnected)
        Wait(1000)
        TriggerClientEvent('playeronline', -1, PlayerOnline) 
    elseif xPlayer.job.name == Config.JobName['3'] then
        MechanicConnected = MechanicConnected + 1
        PlayerOnline = PlayerOnline + 1
        TriggerClientEvent('update', -1, MedicConnected, PoliceConnected, CouncilConnected, MechanicConnected)
        Wait(1000)
        Wait(1000)
        TriggerClientEvent('playeronline', -1, PlayerOnline) 
    elseif xPlayer.job.name == Config.JobName['4'] then
        CouncilConnected = CouncilConnected + 1
        PlayerOnline = PlayerOnline + 1
        TriggerClientEvent('update', -1, MedicConnected, PoliceConnected, CouncilConnected, MechanicConnected)
        Wait(1000)
        Wait(1000)
        TriggerClientEvent('playeronline', -1, PlayerOnline) 
    else
        PlayerOnline = PlayerOnline + 1
        Wait(1000)
        TriggerClientEvent('playeronline', -1, PlayerOnline)
    end
end)

AddEventHandler('esx:setJob', function(playerId, job, lastJob)
    Wait(1000)
    -- OnlinePlayer(playerId)
    if lastJob.name == Config.JobName['1'] then
        PoliceConnected = PoliceConnected - 1
        TriggerClientEvent('update', -1, MedicConnected, PoliceConnected, CouncilConnected, MechanicConnected)
        Wait(1000)
    elseif lastJob.name == Config.JobName['2'] then
        MedicConnected = MedicConnected - 1
        TriggerClientEvent('update', -1, MedicConnected, PoliceConnected, CouncilConnected, MechanicConnected)
        Wait(1000)
    elseif lastJob.name == Config.JobName['3'] then
        MechanicConnected = MechanicConnected - 1
        TriggerClientEvent('update', -1, MedicConnected, PoliceConnected, CouncilConnected, MechanicConnected)
        Wait(1000)
    elseif lastJob.name == Config.JobName['4'] then
        CouncilConnected = CouncilConnected - 1
        TriggerClientEvent('update', -1, MedicConnected, PoliceConnected, CouncilConnected, MechanicConnected)
        Wait(1000)
    else
        Wait(1000)
        TriggerClientEvent('update', -1, MedicConnected, PoliceConnected, CouncilConnected, MechanicConnected)
        Wait(1000)
    end
    if ESX.GetPlayerFromId(playerId).job.name == Config.JobName['2'] then
        MedicConnected = MedicConnected + 1
        Wait(1000)
        TriggerClientEvent('update', -1, MedicConnected, PoliceConnected, CouncilConnected, MechanicConnected)
        Wait(1000)
    elseif ESX.GetPlayerFromId(playerId).job.name == Config.JobName['1'] then
        PoliceConnected = PoliceConnected + 1
        Wait(1000)
        TriggerClientEvent('update', -1, MedicConnected, PoliceConnected, CouncilConnected, MechanicConnected)
        Wait(1000)
    elseif ESX.GetPlayerFromId(playerId).job.name == Config.JobName['3'] then
        MechanicConnected = MechanicConnected + 1
        Wait(1000)
        TriggerClientEvent('update', -1, MedicConnected, PoliceConnected, CouncilConnected, MechanicConnected)
        Wait(1000)
    elseif ESX.GetPlayerFromId(playerId).job.name == Config.JobName['4'] then
        CouncilConnected = CouncilConnected + 1
        Wait(1000)
        TriggerClientEvent('update', -1, MedicConnected, PoliceConnected, CouncilConnected, MechanicConnected)
        Wait(1000)
    end
end)

AddEventHandler('esx:playerDropped', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    if xPlayer.job.name == Config.JobName['2'] then
        PlayerOnline = PlayerOnline - 1
        MedicConnected = MedicConnected - 1
        TriggerClientEvent('update', -1, MedicConnected, PoliceConnected, CouncilConnected, MechanicConnected)
        Wait(1000)
        Wait(1000)
        TriggerClientEvent('playeronline', -1, PlayerOnline)
    elseif xPlayer.job.name == Config.JobName['1'] then
        PlayerOnline = PlayerOnline - 1
        PoliceConnected = PoliceConnected - 1
        TriggerClientEvent('update', -1, MedicConnected, PoliceConnected, CouncilConnected, MechanicConnected)
        Wait(1000)
        Wait(1000)
        TriggerClientEvent('playeronline', -1, PlayerOnline)
    elseif xPlayer.job.name == Config.JobName['3'] then
        PlayerOnline = PlayerOnline - 1
        MechanicConnected = MechanicConnected - 1
        TriggerClientEvent('update', -1, MedicConnected, PoliceConnected, CouncilConnected, MechanicConnected)
        Wait(1000)
        Wait(1000)
        TriggerClientEvent('playeronline', -1, PlayerOnline)
    elseif xPlayer.job.name == Config.JobName['4'] then
        PlayerOnline = PlayerOnline - 1
        CouncilConnected = CouncilConnected - 1
        TriggerClientEvent('update', -1, MedicConnected, PoliceConnected, CouncilConnected, MechanicConnected)
        Wait(1000)
        Wait(1000)
        TriggerClientEvent('playeronline', -1, PlayerOnline)
    else    
        PlayerOnline = PlayerOnline - 1
        TriggerClientEvent('playeronline', -1, PlayerOnline)
    end
end)

function CheckPlayer()
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == Config.JobName['2'] then
            MedicConnected = MedicConnected + 1
        elseif xPlayer.job.name == Config.JobName['1'] then
            PoliceConnected = PoliceConnected + 1
        elseif xPlayer.job.name == Config.JobName['3'] then
            MechanicConnected = MechanicConnected + 1
        elseif xPlayer.job.name == Config.JobName['4'] then
            CouncilConnected = CouncilConnected + 1
        end
    end
end

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        Citizen.CreateThread(function()
            Citizen.Wait(1000)
            CheckPlayer()
            TriggerClientEvent('update', -1, MedicConnected, PoliceConnected, CouncilConnected, MechanicConnected)
        Wait(1000)
            local xPlayers = ESX.GetPlayers()
            for i = 1, #xPlayers, 1 do
                PlayerOnline = (PlayerOnline + 1)
            end
            Wait(1000)
            TriggerClientEvent('playeronline', -1, PlayerOnline)
        end)
    end
end)