ESX = exports['es_extended']:getSharedObject()
local Freeze, FreezeState = true, false

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
    FreezeState = true
    SetPedCanLosePropsOnDamage(PlayerPedId(), false, 0) -- @ not drop fast
    OpenNui()
end)

OpenNui = function()
	SetNuiFocus(true, true)
	SendNUIMessage({ status = true })
    FreezeEntityPosition(PlayerPedId(), true)
end

exports('OpenNuiFreeze', OpenNui)

RegisterNUICallback("Check", function()
	SetNuiFocus(false, false)
	FreezeState = false
	Wait(2000)
	FreezeEntityPosition(PlayerPedId(), false)
end)