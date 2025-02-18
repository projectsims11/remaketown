local key = nil
local resourceName = GetCurrentResourceName()

Citizen.CreateThread(function()
    _run()
end)

_run = function()

ESX = nil
FewZ = GetCurrentResourceName()
local isEventStart = false
local EventDuration = 0
local PlayerGotFlag = nil
local CurrentEventTime = 0
local GotFlagTime = 0
local isRegisterTime = false
local firstTime = true

local spawnYet = false

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


local World_Config = nil

RegisterServerEvent(FewZ..':server:LoadConfig')
AddEventHandler(FewZ..':server:LoadConfig', function()
    local _source = source
    World_Config = Config
    if World_Config ~= nil then
        TriggerClientEvent(FewZ..':client:GetConfig',_source, World_Config)
    end

end)

--------------Dropped Player-------------
AddEventHandler('esx:playerDropped', function(playerID, reason)

    local xPlayer = ESX.GetPlayerFromId(playerID)
    local TimeNow = EventDuration/1000 - CurrentEventTime
    if PlayerGotFlag == xPlayer.source then
        TriggerClientEvent('FewZ_Warflag:setkingout',-1,TimeNow)
    end

end)



RegisterNetEvent('FewZ_Warflag:onPlayerDeath')
AddEventHandler('FewZ_Warflag:onPlayerDeath', function(ID, playerCoords)
    local xPlayer = ESX.GetPlayerFromId(source)
    local TimeNow = EventDuration/1000 - CurrentEventTime
    TriggerClientEvent('FewZ_Warflag:setkingout',-1,TimeNow, playerCoords)
end)


 ------ 1.2

    -- ESX.RegisterCommand('flag','admin',function(xPlayer, args, showError)
    --     if not isEventStart and not isRegisterTime then
    --             EventDuration = Config['EventDuration']
    --             TriggerClientEvent(FewZ..'StartGame',-1)
    --             end
    --             Start()

    -- end, false,{help = "Start flag"})

    -- ESX.RegisterCommand('stopflag','admin',function(xPlayer, args, showError)
    --         if not isEventStart and not isRegisterTime then
    --              EventDuration = Config['EventDuration']
    --              TriggerClientEvent('FewZ_Warflag:stopEvent', -1)
    --         end
    --          End(isCancel)

    -- end, false,{help = "Stop flag"})


    RegisterCommand('flag', function(source, args, rawCommand)
        if not isEventStart and not isRegisterTime then
            EventDuration = Config['EventDuration']
        end
        Start()

    end, true)

    RegisterCommand('stopflag', function(source, args, rawCommand)
        if not isEventStart and not isRegisterTime then
            EventDuration = Config['EventDuration']
            TriggerClientEvent('FewZ_Warflag:stopEvent', -1)
        end
        End(isCancel)

    end, false)

RegisterServerEvent('FewZ_Warflag:loadingGame')
AddEventHandler('FewZ_Warflag:loadingGame',function()
    local _source = source
    local kingName = ''
    if isEventStart then
        if PlayerGotFlag ~= nil then
            local kingName = GetPlayerName(PlayerGotFlag)
        end
        local Flaghold = (Config['HoldFlag'] * 60) - GotFlagTime
        TriggerClientEvent('FewZ_Warflag:StartEvent', _source, isEventStart, ((EventDuration/1000) - CurrentEventTime))
        TriggerClientEvent('FewZ_Warflag:setkingname',_source, Flaghold, kingName, PlayerGotFlag, TimeNow)
    end

end)


---------------Auto Start----------------

function startTheFlag()
    SetTimeout(1000, function()
                TriggerEvent('FewZ_Warflag:checkStart')
                startTheFlag()
        end)
end

if Config['EnableStartFlagAuto'] then
    startTheFlag()
end

RegisterServerEvent('FewZ_Warflag:checkStart')
AddEventHandler('FewZ_Warflag:checkStart',function()
    if not isEventStart and not isRegisterTime then
        local date_local = os.date('%H:%M:%S', os.time())
        for i=1, #Config['StartTime'], 1 do
            local start_time = Config['StartTime'][i]..':00'
            if date_local == start_time then
                EventDuration = Config['EventDuration']
                isRegisterTime = true
                Start()
            end
        end
    end
end)

ESX.RegisterServerCallback('FewZ:Gamestatus', function(source, cb)
    if isEventStart then
        print ('status')
                cb(true)
    end
end)

RegisterServerEvent('FewZ:checkStart')
AddEventHandler('FewZ:checkStart',function()
    local _source = source
    local timer = Config['HoldFlag'] * 1000 * 60 / 1000

    TriggerClientEvent('FewZ_Warflag:StartEvent', _source, isEventStart, EventDuration/1000 - CurrentEventTime)
    if PlayerGotFlag ~= nil then
    TriggerClientEvent('FewZ_Warflag:setkingname',_source, timer-GotFlagTime, GetPlayerName(PlayerGotFlag), PlayerGotFlag, EventDuration/1000 - CurrentEventTime)
    end

end)


function Start()
    EventDuration = EventDuration * 60 * 1000
    isEventStart = true

    TriggerClientEvent('FewZ_Warflag:StartEvent', -1, isEventStart, EventDuration/1000)

    -- α╣Çα╕úα╕┤α╣êα╕íα╕Öα╕▒α╕Üα╕ûα╕¡α╕óα╕½α╕Ñα╕▒α╕ç
    CurrentEventTime = 1
    CountdownEnd()
end

function CountDownWinner()
    local _WinByTime = Config['HoldFlag'] * 60
    SetTimeout(1000, function()
        if GotFlagTime >= _WinByTime then

            End()
        elseif GotFlagTime <= 0 then

        else

            GotFlagTime = GotFlagTime + 1

            CountDownWinner()
        end
    end)
end

function CountdownEnd()
    local _EventDuration = EventDuration / 1000

    SetTimeout(1000, function()
        if CurrentEventTime >= _EventDuration then
            End()
        elseif CurrentEventTime <= 0 then
            -- Flag Cancel by Time
        else
            CurrentEventTime = CurrentEventTime + 1
            --print(CurrentEventTime)
            CountdownEnd()
        end

    end)

end

function End(isCancel)
    isEventStart = false
    TriggerClientEvent('FewZ_Warflag:stopEvent', -1)
    GiveReward()
end

function GiveReward()
    if not PlayerGotFlag or PlayerGotFlag == nil then
        -- NO WINNER
        print('^2Flag^0:no winner')
    else

        ---print('the Winner is '..PlayerGotFlag.name) -- Just check
        if Config['RandomWinnerReward'] == 0 then
            for i=1, #Config['WinnerRewards'], 1 do
                setReward(PlayerGotFlag, Config['WinnerRewards'][i])
            end
        else
            for i=1, #Config['RandomWinnerReward'], 1 do
                local index = math.random(1, #Config['WinnerRewards'])
                setReward(PlayerGotFlag, Config['WinnerRewards'][index])
            end
        end


        -- Hold Flag Winner
    end
    Reset()

end

function Reset()
        EventDuration = 0
        PlayerGotFlag = nil
        GotFlagTime = 0
        CurrentEventTime = 0
end

function setReward(PlayerId, Reward)
    local xPlayer = ESX.GetPlayerFromId(PlayerId)

    if Reward.type == 'money' then
        xPlayer.addMoney(Reward.amount)

        local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. Reward.type .. ' จำนวน $' .. ESX.Math.GroupDigits(Reward.amount) .. ''
        TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'WarGlagReward', sendToDiscord, xPlayer.source, '^5')
    elseif Reward.type == 'item' then
        xPlayer.addInventoryItem(Reward.id, Reward.amount)

        local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. ESX.GetItemLabel(Reward.id) .. ' จำนวน ' .. Reward.amount .. ''
        TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'WarGlagReward', sendToDiscord, xPlayer.source, '^2')
    elseif Reward.type == "black_money" then
                xPlayer.addAccountMoney('black_money', Reward.amount)

                local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. Reward.type .. ' จำนวน $' .. ESX.Math.GroupDigits(Reward.amount) .. ''
                TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'WarGlagReward', sendToDiscord, xPlayer.source, '^3')
        elseif Reward.type == "weapon" then
                xPlayer.addWeapon(Reward.id, Reward.ammo)

                local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. ESX.GetWeaponLabel(Reward.id) .. ' และ กระสุน จำนวน ' .. Reward.ammo .. ''
                TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'WarGlagReward', sendToDiscord, xPlayer.source, '^1')
        end

end

-----------------------------------------
-----------------------------------------

-- PickUp Flag --
nameoftheflag = ''
timeremain = 0
timeofwin = 0
RegisterServerEvent('FewZ_Warflag:pickupflag')
AddEventHandler('FewZ_Warflag:pickupflag',function()
    local _source = source
    local gotName = GetPlayerName(_source)
    local timer = Config['HoldFlag'] * 1000 * 60
    local TimeNow = EventDuration/1000 - CurrentEventTime
    nameoftheflag = gotName
    spawnYet = false

    if PlayerGotFlag == nil then

        PlayerGotFlag = _source
        TriggerClientEvent('FewZ_Warflag:setkingname',-1, timer/1000, gotName, _source, TimeNow)


        GotFlagTime = 1

        CountDownWinner()

    end
    --end

end)

Citizen.CreateThread(function()
    while true do
        Wait(1000)
        if isEventStart then
           if timeremain ~= 0 then
            timeremain = timeremain -1
            print (timeremain)
            print(nameoftheflag)
           end

           if timeofwin ~= 0 then
            timeofwin = timeofwin -1
            print ('time of win '..timeofwin)
           end
        end
    end
end)

-- Drop Flag --
RegisterServerEvent('FewZ_Warflag:flagdrop')
AddEventHandler('FewZ_Warflag:flagdrop',function(coord)

    if not spawnYet then
        spawnYet = true
        PlayerGotFlag = nil
        GotFlagTime = 0
        print('Drop the Flag')

        TriggerClientEvent('FewZ_Warflag:SpawnFlag', -1, coord)
    end
end)


RegisterServerEvent('FewZ_Warflag:flagheal')
AddEventHandler('FewZ_Warflag:flagheal',function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local price = Config['Priceheal']

    if xPlayer.getMoney() >= price then
        xPlayer.removeMoney(price)
        TriggerClientEvent('FewZ_Warflag:FlagSetHealth',_source)
    else

        TriggerClientEvent('esx:showNotification', _source, ('~r~remove~s~ money '..price))
    end

end)


RegisterServerEvent('FewZ_Warflag:toofar')
AddEventHandler('FewZ_Warflag:toofar',function()
    local TimeNow = EventDuration/1000 - CurrentEventTime
    TriggerClientEvent('FewZ_Warflag:toofarC', -1, TimeNow)
end)
end