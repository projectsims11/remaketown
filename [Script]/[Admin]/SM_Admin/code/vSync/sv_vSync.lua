if not Config["Options"]["WeatherOptions"].WeatherandBlackOut then return end

local WeatherOptions = Config["Options"]["WeatherOptions"]
local TimeOptions = Config["Options"]["TimeOptions"]
local SM = {}

CurrentWeather = WeatherOptions.StartWeather
local baseTime = TimeOptions.BaseTime
local timeOffset = 0
local freezeTime = false
local blackout = WeatherOptions.Blackout
local newWeatherTimer = WeatherOptions.NewWeatherTimer

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local newBaseTime = os.time(os.date("!*t"))/2 + 360
        if freezeTime then
            timeOffset = timeOffset + baseTime - newBaseTime            
        end
        baseTime = newBaseTime
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(TimeOptions.updateTime)
        TriggerClientEvent("SM_Admin:updateTime", -1, baseTime, timeOffset, freezeTime)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(WeatherOptions.updateWeather)
        TriggerClientEvent("SM_Admin:updateWeather", -1, CurrentWeather, blackout)
    end
end)

Citizen.CreateThread(function()
    while true do
        newWeatherTimer = newWeatherTimer - 1
        Citizen.Wait(60000)
        if newWeatherTimer == 0 then
            if WeatherOptions.DynamicWeather then
                NextWeatherStage()
            end
            newWeatherTimer = 10
        end
    end
end)

function ShiftToMinute(minute)
    timeOffset = timeOffset - ( ( (baseTime+timeOffset) % 60 ) - minute )
end

function ShiftToHour(hour)
    timeOffset = timeOffset - ( ( ((baseTime+timeOffset)/60) % 24 ) - hour ) * 60
end

function NextWeatherStage()
    if CurrentWeather == "CLEAR" or CurrentWeather == "CLOUDS" or CurrentWeather == "EXTRASUNNY"  then
        local new = math.random(1,2)
        if new == 1 then
            CurrentWeather = "CLEARING"
        else
            CurrentWeather = "OVERCAST"
        end
    elseif CurrentWeather == "CLEARING" or CurrentWeather == "OVERCAST" then
        local new = math.random(1,6)
        if new == 1 then
            if CurrentWeather == "CLEARING" then CurrentWeather = "FOGGY" else CurrentWeather = "RAIN" end
        elseif new == 2 then
            CurrentWeather = "CLOUDS"
        elseif new == 3 then
            CurrentWeather = "CLEAR"
        elseif new == 4 then
            CurrentWeather = "EXTRASUNNY"
        elseif new == 5 then
            CurrentWeather = "SMOG"
        else
            CurrentWeather = "FOGGY"
        end
    elseif CurrentWeather == "THUNDER" or CurrentWeather == "RAIN" then
        CurrentWeather = "CLEARING"
    elseif CurrentWeather == "SMOG" or CurrentWeather == "FOGGY" then
        CurrentWeather = "CLEAR"
    end
    TriggerEvent("SM_Admin:requestSync")
end

function split(s, delimiter)
    result = {}
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match)
    end
    return result
end

SM.freezeTime = function(source)
    if source ~= 0 then
        local xPlayer = ESX.GetPlayerFromId(source)
        if checkPermission(xPlayer) then
            freezeTime = not freezeTime
            if freezeTime then
                TriggerClientEvent('esx:showNotification', source, 'Time frozen') 
            else
                TriggerClientEvent('esx:showNotification', source, 'Time unfrozen') 
            end
        end
    end
end

SM.Time = function(source, args)
    print('test')
    if source == 0 then
        if tonumber(args[1]) ~= nil and tonumber(args[2]) ~= nil then
            local argh = tonumber(args[1])
            local argm = tonumber(args[2])
            if argh < 24 then
                ShiftToHour(argh)
            else
                ShiftToHour(0)
            end
            if argm < 60 then
                ShiftToMinute(argm)
            else
                ShiftToMinute(0)
            end
            print("time changed")
            TriggerEvent("SM_Admin:requestSync")
        else
            print("invalid time")
        end
    elseif source ~= 0 then
        local xPlayer = ESX.GetPlayerFromId(source)
        if checkPermission(xPlayer) then
            if tonumber(args[1]) ~= nil and tonumber(args[2]) ~= nil then
                local argh = tonumber(args[1])
                local argm = tonumber(args[2])
                if argh < 24 then
                    ShiftToHour(argh)
                else
                    ShiftToHour(0)
                end
                if argm < 60 then
                    ShiftToMinute(argm)
                else
                    ShiftToMinute(0)
                end
                local newtime = math.floor(((baseTime+timeOffset)/60)%24) .. ":"
                local minute = math.floor((baseTime+timeOffset)%60)
                if minute < 10 then
                    newtime = newtime .. "0" .. minute
                else
                    newtime = newtime .. minute
                end
                TriggerClientEvent('esx:showNotification', source, 'Time changed to '..newtime) 
                TriggerEvent("SM_Admin:requestSync")
            else
                TriggerClientEvent('chat:addMessage', source, {args = {"SM_Admin ", " Invalid time."}})
            end
        end
    end
end

SM.freezeWeather = function(source)
    if source ~= 0 then
        local xPlayer = ESX.GetPlayerFromId(source)
        if checkPermission(xPlayer) then
            WeatherOptions.DynamicWeather = not WeatherOptions.DynamicWeather
            if not WeatherOptions.DynamicWeather then
                TriggerClientEvent('esx:showNotification', source, 'Dynamic Weather disabled') 
            else
                TriggerClientEvent('esx:showNotification', source, 'Dynamic Weather enabled') 
            end
        end
    end
end

SM.Weather = function(source, args, invokeMethod)
    if source == 0 then
        local validWeatherType = false
        if args[1] == nil then
            print("invalid weather syntax")
            return
        else
            for i,wtype in ipairs(Config.AvailableWeatherTypes) do
                if wtype == string.upper(args[1]) then
                    validWeatherType = true
                end
            end
            if validWeatherType then
                print("weather updated")
                CurrentWeather = string.upper(args[1])
                newWeatherTimer = 10
                TriggerEvent("SM_Admin:requestSync")
            else
                print("weather invalid")
            end
        end
    else
        local xPlayer = ESX.GetPlayerFromId(source)
        if checkPermission(xPlayer) then
            local validWeatherType = false
            if invokeMethod == "command" then
                if args[1] == nil then
                    TriggerClientEvent('chat:addMessage', source, {args = {"SM_Admin ", " Invalid weather syntax"}})
                else
                    TriggerClientEvent('esx:showNotification', source, " Weather will change to "..string.lower(args[1])) 
                    CurrentWeather = string.upper(args[1])
                    newWeatherTimer = 10
                    TriggerEvent("SM_Admin:requestSync")
                end
            elseif invokeMethod == "gui" then
                TriggerClientEvent('esx:showNotification', source, " Weather will change to "..string.lower(args)) 
                CurrentWeather = args
                newWeatherTimer = 10
                TriggerEvent("SM_Admin:requestSync")
            end
        end
    end
end

SM.Blackout = function(source)
    if source == 0 then
        blackout = not blackout
        if blackout then
            print('blackout enabled')
        else
            print('blackout disabled')
        end
    else
        local xPlayer = ESX.GetPlayerFromId(source)
        if checkPermission(xPlayer) then
            blackout = not blackout
            if not serverCfg["vSyncSetting"].useReplightScript then -- zack
                if blackout then
                    TriggerClientEvent('esx:showNotification', source, 'Blackout enabled') 
                else
                    TriggerClientEvent('esx:showNotification', source, 'Blackout disabled') 
                end
            else
                blackout = false
                TriggerClientEvent('esx:showNotification', source, 'Blackout has bypassed for handle by other script')
            end
            
            TriggerEvent("SM_Admin:requestSync")
        end
    end
end

RegisterServerEvent("SM_Admin:requestSync")
AddEventHandler("SM_Admin:requestSync", function()
    TriggerClientEvent("SM_Admin:updateWeather", -1, CurrentWeather, blackout)
    TriggerClientEvent("SM_Admin:updateTime", -1, baseTime, timeOffset, freezeTime)
end)

RegisterNetEvent('SM_Admin:blackoutonline')
AddEventHandler('SM_Admin:blackoutonline', function(onoff)
    blackout = onoff
    TriggerEvent("SM_Admin:requestSync")
end)

RegisterNetEvent('SM_Admin:freezeWeather')
AddEventHandler('SM_Admin:freezeWeather', function(weather)
    SM.freezeWeather(source)
end)

RegisterNetEvent('SM_Admin:Weather')
AddEventHandler('SM_Admin:Weather', function(weather)
    SM.Weather(source, weather, "gui")
end)

RegisterNetEvent('SM_Admin:Blackout')
AddEventHandler('SM_Admin:Blackout', function()
    SM.Blackout(source)
end)

RegisterNetEvent('SM_Admin:freezeTime')
AddEventHandler('SM_Admin:freezeTime', function()
    SM.freezeTime(source)
end)

RegisterNetEvent('SM_Admin:Time')
AddEventHandler('SM_Admin:Time', function(args)
    args = split(args, ':')
    SM.Time(source, args)
end)

RegisterCommand('freezeweather', function(source, args)
    SM.freezeWeather(source)
end)

RegisterCommand('weather', function(source, args)
    SM.Weather(source, args, "command")
end)

RegisterCommand('blackout', function(source)
    SM.Blackout(source)
end)

RegisterCommand('freezetime', function(source, args)
    SM.freezeTime(source)
end)

RegisterCommand('time', function(source, args, rawCommand)
    SM.Time(source, args)
end)
