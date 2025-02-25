if not Config["Options"]["WeatherOptions"].WeatherandBlackOut then return end

local WeatherOptions = Config["Options"]["WeatherOptions"]
local TimeOptions = Config["Options"]["TimeOptions"]

CurrentWeather = WeatherOptions.StartWeather
local lastWeather = CurrentWeather
local baseTime = TimeOptions.BaseTime
local timeOffset = 0
local timer = 0
local freezeTime = false
local blackout = false

Citizen.CreateThread(function()
    while true do
        if lastWeather ~= CurrentWeather then
            lastWeather = CurrentWeather
            SetWeatherTypeTransition(GetPrevWeatherTypeHashName(), GetHashKey(CurrentWeather), 0.5)
            Citizen.Wait(15000)
        end
        Citizen.Wait(3000)
        if not Config["Options"]["WeatherOptions"].useReplightScript then
            SetBlackout(blackout) 
        end
        ClearOverrideWeather()
        ClearWeatherTypePersist()
        SetWeatherTypeNowPersist(lastWeather)
        SetWindSpeed(0.2)
        SetWindDirection(180.0)
        
        if lastWeather == 'XMAS' then
            SetForceVehicleTrails(true)
            SetForcePedFootstepsTracks(true)
        else
            SetForceVehicleTrails(false)
            SetForcePedFootstepsTracks(false)
        end
    end
end)

Citizen.CreateThread(function()
    local hour = 0
    local minute = 0
    while true do
        Citizen.Wait(50)
        local newBaseTime = baseTime
        if GetGameTimer() - 500  > timer then
            newBaseTime = newBaseTime + 0.25
            timer = GetGameTimer()
        end
        if freezeTime then
            timeOffset = timeOffset + baseTime - newBaseTime			
        end
        baseTime = newBaseTime
        hour = math.floor(((baseTime+timeOffset)/60)%24)
        minute = math.floor((baseTime+timeOffset)%60)
        NetworkOverrideClockTime(hour, minute, 0)
    end
end)

RegisterNetEvent("SM_Admin:updateWeather")
AddEventHandler("SM_Admin:updateWeather", function(NewWeather, newblackout)
    CurrentWeather = NewWeather
    blackout = newblackout
end)

RegisterNetEvent("SM_Admin:updateTime")
AddEventHandler("SM_Admin:updateTime", function(base, offset, freeze)
    freezeTime = freeze
    timeOffset = offset
    baseTime = base
end)

AddEventHandler("playerSpawned", function()
    TriggerServerEvent("SM_Admin:requestSync")
end)
