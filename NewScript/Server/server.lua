-- Create By JubJub Studio https://www.facebook.com/BugErr0rJubJub/ 
  
ESX                = nil 
  
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
  
ESX.RegisterServerCallback('Check_Name:haveItem', function(source, cb, item) 
local xPlayer = ESX.GetPlayerFromId(source) 
local xItem = xPlayer.getInventoryItem(item) 
 
	if xItem.count  then 
		cb(true) 
	else 
		cb(false) 
	end 
end) 
 
function ON() 
    TriggerClientEvent('Blackout:clientlighton', -1) 	
end 
 
SetTimeout(Config.ON, ON) 
-- Create By JubJub Studio https://www.facebook.com/BugErr0rJubJub/ 
  
ESX                = nil 
  
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
  
ESX.RegisterServerCallback('Check_Name:haveItem', function(source, cb, item) 
local xPlayer = ESX.GetPlayerFromId(source) 
local xItem = xPlayer.getInventoryItem(item) 
 
	if xItem.count  then 
		cb(true) 
	else 
		cb(false) 
	end 
end) 
 
function ON() 
    TriggerClientEvent('Blackout:clientlighton', -1) 	
end 
 
SetTimeout(Config.ON, ON) 
