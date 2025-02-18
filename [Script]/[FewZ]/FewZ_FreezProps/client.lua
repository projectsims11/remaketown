ESX	= nil 

Citizen.CreateThread(function() 
	while ESX == nil do 
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
		Citizen.Wait(0) 
	end 
	PlayerData = ESX.GetPlayerData() 
end) 

RegisterNetEvent('esx:playerLoaded') 
AddEventHandler('esx:playerLoaded', function(xPlayer) 
	PlayerData = xPlayer 
end) 

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(2500)
		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)

		for i=1, #Config.PropsAvailable do
			local entityfreez = GetClosestObjectOfType(playerCoords, 500.0, GetHashKey(Config.PropsAvailable[i]), false, false, false)
			FreezeEntityPosition(entityfreez,true)
			SetEntityCanBeDamaged(entityfreez,false)
			SetEntityInvincible(entityfreez,true)
		end
	end
end)