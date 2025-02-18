local open = false

Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('jsfour-idcard:dv_license')
AddEventHandler('jsfour-idcard:dv_license', function()
	local player, distance = ESX.Game.GetClosestPlayer()

	TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
	
	if distance ~= -1 and distance <= 3.0 then
		TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'driver')
	end
end)

RegisterNetEvent('jsfour-idcard:id_card')
AddEventHandler('jsfour-idcard:id_card', function()
	local player, distance = ESX.Game.GetClosestPlayer()

	TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
	
	if distance ~= -1 and distance <= 3.0 then
		TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
	end
end)

-- Open ID card
RegisterNetEvent('jsfour-idcard:open')
AddEventHandler('jsfour-idcard:open', function( data, type )
	open = true
	SendNUIMessage({
		action = "open",
		array  = data,
		type   = type
	})
end)

-- Key events
Citizen.CreateThread(function()
	while true do
		Wait(0)
		if IsControlJustReleased(0, 322) and open or IsControlJustReleased(0, 177) and open then
			SendNUIMessage({
				action = "close"
			})
			open = false
		end
	end
end)

RegisterNetEvent('jsfour-idcard:shot')
AddEventHandler('jsfour-idcard:shot', function(playerID)

	local posx, posy = 0.777, 0.26
	local width, height = 0.05, 0.10
	local x, y = GetActiveScreenResolution()
		if x == 1920 and y == 1080 then
			posx, posy = 0.777, 0.26
	 		width, height = 0.07, 0.14
		elseif x == 1366 and y == 768 then
			posx, posy = 0.686, 0.366
			width, height = 0.086, 0.196
		elseif x == 1360 and y == 768 then
			posx, posy = 0.685, 0.366
			width, height = 0.087, 0.196
		elseif x == 1600 and y == 900 then
			posx, posy = 0.732, 0.3122
			width, height = 0.073, 0.168
		elseif x == 1400 and y == 1050 then
			posx, posy = 0.694, 0.267
			width, height = 0.083, 0.145
		elseif x == 1440 and y == 900 then
			posx, posy = 0.702, 0.312
			width, height = 0.082, 0.169
		elseif x == 1680 and y == 1050 then
			posx, posy = 0.745, 0.268
			width, height = 0.068, 0.1435
		elseif x == 1280 and y == 720 then
			posx, posy = 0.665, 0.3905
			width, height = 0.09, 0.2105
		elseif x == 1280 and y == 768 then
			posx, posy = 0.665, 0.366
			width, height = 0.091, 0.196
		elseif x == 1280 and y == 800 then
			posx, posy = 0.665, 0.3515
			width, height = 0.091, 0.1895
		elseif x == 1280 and y == 960 then
			posx, posy = 0.665, 0.2925
			width, height = 0.091, 0.1585
		elseif x == 1280 and y == 1024 then
			posx, posy = 0.665, 0.2745
			width, height = 0.091, 0.1475
		elseif x == 1024 and y == 768 then
			posx, posy = 0.5810, 0.366
			width, height = 0.115, 0.1965
		elseif x == 800 and y == 600 then
			posx, posy = 0.4635, 0.4685
			width, height = 0.1455, 0.251
		elseif x == 1152 and y == 864 then
			posx, posy = 0.6275, 0.325
			width, height = 0.1005, 0.175
		elseif x == 1280 and y == 600 then
			posx, posy = 0.665, 0.468
			width, height = 0.0905, 0.251
		end

	local handle = ESX.Game.GetPedMugshot(GetPlayerPed(GetPlayerFromServerId(playerID)))
	if not IsPedheadshotValid(handle) then
		print('hay un error aqui')
		print(handle)
	end

	while not IsPedheadshotReady (handle) do
		Wait (0)
	end
	local headshot = GetPedheadshotTxdString (handle)
	while open do
		Wait (0)
		DrawSprite (headshot, headshot, posx, posy, width, height, 0.0, 255, 255, 255, 1000)
	end
	if not open then
		UnregisterPedheadshot(handle)
	end
end)
