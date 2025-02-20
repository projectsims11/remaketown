-- Create By JubJub Studio https://www.facebook.com/BugErr0rJubJub/ 
  
local Keys = { 
  
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
  
ESX =					nil 
  
Citizen.CreateThread(function() 
	while ESX == nil do 
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
		Citizen.Wait(0) 
	end 
end) 
  
Citizen.CreateThread(function() 
	while true do 
		Citizen.Wait(0) 
		if IsControlJustReleased(0, Keys['E']) then 
		TriggerEvent("JubJub:clientlightoff") 
		end 
	end 
end) 
RegisterCommand('jub', function(ply,a,r) 
  
	local mdl = GetHashKey("prop_elecbox_10") 
	local obj = CreateObject(mdl, 187.77,-841.75,30.0 , true, true, false) 
	Citizen.Wait(10000) 
	DeleteEntity(obj) 
end) 
RegisterNetEvent('JubJub:clientlightoff') 
AddEventHandler('JubJub:clientlightoff', function() 
  	RandomWayPoint() 
    while true do 
       local SLEEPthread = 1000 
                 while true do 
                   Citizen.Wait(0) 
                   SetArtificialLightsState(true) 
       end 
     Citizen.Wait(SLEEPthread) 
   end  
end) 
 
RegisterNetEvent('JubJub:clientlighton') 
AddEventHandler('JubJub:clientlighton', function() 
    ExecuteCommand( "stop Blackout" ) 
    ExecuteCommand( "Start Blackout" ) 
end) 
-- Create By JubJub Studio https://www.facebook.com/BugErr0rJubJub/ 
  
local Keys = { 
  
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
  
ESX =					nil 
  
Citizen.CreateThread(function() 
	while ESX == nil do 
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
		Citizen.Wait(0) 
	end 
end) 
  
Citizen.CreateThread(function() 
	while true do 
		Citizen.Wait(0) 
		if IsControlJustReleased(0, Keys['E']) then 
		TriggerEvent("JubJub:clientlightoff") 
		end 
	end 
end) 
RegisterCommand('jub', function(ply,a,r) 
  
	local mdl = GetHashKey("prop_elecbox_10") 
	local obj = CreateObject(mdl, 187.77,-841.75,30.0 , true, true, false) 
	Citizen.Wait(10000) 
	DeleteEntity(obj) 
end) 
RegisterNetEvent('JubJub:clientlightoff') 
AddEventHandler('JubJub:clientlightoff', function() 
  	RandomWayPoint() 
    while true do 
       local SLEEPthread = 1000 
                 while true do 
                   Citizen.Wait(0) 
                   SetArtificialLightsState(true) 
       end 
     Citizen.Wait(SLEEPthread) 
   end  
end) 
 
RegisterNetEvent('JubJub:clientlighton') 
AddEventHandler('JubJub:clientlighton', function() 
    ExecuteCommand( "stop Blackout" ) 
    ExecuteCommand( "Start Blackout" ) 
end) 
