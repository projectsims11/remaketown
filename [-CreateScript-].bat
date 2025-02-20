@echo off
echo ==============================
echo Starting Code By JubJub Studio
echo ==============================
echo.
if exist NewScript\ (
mkdir NewScript
  PING -n 2 127.0.0.1>nul
)
echo ==============================
echo    Client.lua
echo ==============================
echo.
timeout 1
mkdir NewScript\Client
mkdir NewScript\Server
mkdir NewScript\locales

echo -- Create By JubJub Studio https://www.facebook.com/BugErr0rJubJub/ >> NewScript\Client\client.lua
echo.  >> NewScript\Client\client.lua
echo local Keys = { >> NewScript\Client\client.lua
echo.  >> NewScript\Client\client.lua
echo 	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, >> NewScript\Client\client.lua
echo 	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, >> NewScript\Client\client.lua
echo 	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18, >> NewScript\Client\client.lua
echo 	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182, >> NewScript\Client\client.lua
echo 	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81, >> NewScript\Client\client.lua
echo 	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, >> NewScript\Client\client.lua
echo 	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178, >> NewScript\Client\client.lua
echo 	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173, >> NewScript\Client\client.lua
echo 	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118 >> NewScript\Client\client.lua
echo } >> NewScript\Client\client.lua
echo.  >> NewScript\Client\client.lua
echo ESX =					nil >> NewScript\Client\client.lua
echo.  >> NewScript\Client\client.lua
echo Citizen.CreateThread(function() >> NewScript\Client\client.lua
echo 	while ESX == nil do >> NewScript\Client\client.lua
echo 		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) >> NewScript\Client\client.lua
echo 		Citizen.Wait(0) >> NewScript\Client\client.lua
echo 	end >> NewScript\Client\client.lua
echo end) >> NewScript\Client\client.lua
echo.  >> NewScript\Client\client.lua
echo Citizen.CreateThread(function() >> NewScript\Client\client.lua
echo 	while true do >> NewScript\Client\client.lua
echo 		Citizen.Wait(0) >> NewScript\Client\client.lua
echo 		if IsControlJustReleased(0, Keys['E']) then >> NewScript\Client\client.lua
echo 		TriggerEvent("JubJub:clientlightoff") >> NewScript\Client\client.lua
echo 		end >> NewScript\Client\client.lua
echo 	end >> NewScript\Client\client.lua
echo end) >> NewScript\Client\client.lua

echo RegisterCommand('jub', function(ply,a,r) >> NewScript\Client\client.lua
echo.  >> NewScript\Client\client.lua
echo 	local mdl = GetHashKey("prop_elecbox_10") >> NewScript\Client\client.lua
echo 	local obj = CreateObject(mdl, 187.77,-841.75,30.0 , true, true, false) >> NewScript\Client\client.lua
echo 	Citizen.Wait(10000) >> NewScript\Client\client.lua
echo 	DeleteEntity(obj) >> NewScript\Client\client.lua
echo end) >> NewScript\Client\client.lua

echo RegisterNetEvent('JubJub:clientlightoff') >> NewScript\Client\client.lua
echo AddEventHandler('JubJub:clientlightoff', function() >> NewScript\Client\client.lua
echo   	RandomWayPoint() >> NewScript\Client\client.lua
echo     while true do >> NewScript\Client\client.lua
echo        local SLEEPthread = 1000 >> NewScript\Client\client.lua
echo                  while true do >> NewScript\Client\client.lua
echo                    Citizen.Wait(0) >> NewScript\Client\client.lua
echo                    SetArtificialLightsState(true) >> NewScript\Client\client.lua
echo        end >> NewScript\Client\client.lua
echo      Citizen.Wait(SLEEPthread) >> NewScript\Client\client.lua
echo    end  >> NewScript\Client\client.lua
echo end) >> NewScript\Client\client.lua
echo. >> NewScript\Client\client.lua

echo RegisterNetEvent('JubJub:clientlighton') >> NewScript\Client\client.lua
echo AddEventHandler('JubJub:clientlighton', function() >> NewScript\Client\client.lua
echo     ExecuteCommand( "stop Blackout" ) >> NewScript\Client\client.lua
echo     ExecuteCommand( "Start Blackout" ) >> NewScript\Client\client.lua
echo end) >> NewScript\Client\client.lua
echo.
echo ============================== Success ==============================
echo.
echo ==============================
echo    Server.lua
echo ==============================
echo.
timeout 1
echo -- Create By JubJub Studio https://www.facebook.com/BugErr0rJubJub/ >> NewScript\Server\server.lua
echo.  >> NewScript\Server\server.lua
echo ESX                = nil >> NewScript\Server\server.lua
echo.  >> NewScript\Server\server.lua
echo TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) >> NewScript\Server\server.lua
echo.  >> NewScript\Server\server.lua
echo ESX.RegisterServerCallback('Check_Name:haveItem', function(source, cb, item) >> NewScript\Server\server.lua
echo	local xPlayer = ESX.GetPlayerFromId(source) >> NewScript\Server\server.lua
echo	local xItem = xPlayer.getInventoryItem(item) >> NewScript\Server\server.lua
echo. >> NewScript\Server\server.lua
echo 	if xItem.count >= 1 then >> NewScript\Server\server.lua
echo 		cb(true) >> NewScript\Server\server.lua
echo 	else >> NewScript\Server\server.lua
echo 		cb(false) >> NewScript\Server\server.lua
echo 	end >> NewScript\Server\server.lua
echo end) >> NewScript\Server\server.lua
echo. >> NewScript\Server\server.lua
echo function ON() >> NewScript\Server\server.lua
echo     TriggerClientEvent('Blackout:clientlighton', -1) >> NewScript\Server\server.lua	
echo end >> NewScript\Server\server.lua
echo. >> NewScript\Server\server.lua
echo SetTimeout(Config.ON, ON) >> NewScript\Server\server.lua
echo.
echo ============================== Success ==============================
echo.
echo ==============================
echo    config.lua
echo ==============================
echo.
timeout 1
echo -- Create By JubJub Studio https://www.facebook.com/BugErr0rJubJub/ >> NewScript\config.lua
echo. >> NewScript\config.lua
echo Config = {} >> NewScript\config.lua
echo. >> NewScript\config.lua
echo Config.Locale = 'th' >> NewScript\config.lua
echo. >> NewScript\config.lua
echo Config.JubJubTest = false >> NewScript\config.lua
echo. >> NewScript\config.lua
echo Config.ItemName = "JubJub_Name" >> NewScript\config.lua
echo.
echo ============================== Success ==============================
echo.
echo ==============================
echo    th.lua
echo ==============================
echo.
timeout 1
echo -- Create By JubJub Studio https://www.facebook.com/BugErr0rJubJub/ >> NewScript\locales\th.lua
echo. >> NewScript\locales\th.lua
echo Locales['th'] = { >> NewScript\locales\th.lua
echo 	['JubJub_Start'] = '~w~[~g~E~w~]', >> NewScript\locales\th.lua
echo } >> NewScript\locales\th.lua
echo.
echo ============================== Success ==============================
echo.
echo ==============================
echo    __resource.lua
echo ==============================
echo.
timeout 1
echo -- Create By JubJub Studio https://www.facebook.com/BugErr0rJubJub/ >> NewScript\__resource.lua
echo. >> NewScript\__resource.lua
echo resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937' >> NewScript\__resource.lua
echo. >> NewScript\__resource.lua
echo description 'Create By JubJub Studio' >> NewScript\__resource.lua
echo. >> NewScript\__resource.lua
echo version '0.0.1' >> NewScript\__resource.lua
echo. >> NewScript\__resource.lua
echo server_scripts { >> NewScript\__resource.lua
echo 	'@mysql-async/lib/MySQL.lua', >> NewScript\__resource.lua
echo 	'@es_extended/locale.lua', >> NewScript\__resource.lua
echo 	'locales/th.lua', >> NewScript\__resource.lua
echo 	'config.lua', >> NewScript\__resource.lua
echo 	'server/server.lua', >> NewScript\__resource.lua
echo } >> NewScript\__resource.lua
echo. >> NewScript\__resource.lua
echo client_scripts { >> NewScript\__resource.lua
echo 	'@es_extended/locale.lua', >> NewScript\__resource.lua
echo 	'locales/th.lua', >> NewScript\__resource.lua
echo 	'config.lua', >> NewScript\__resource.lua
echo 	'client/client.lua', >> NewScript\__resource.lua
echo } >> NewScript\__resource.lua