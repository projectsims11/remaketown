ESX = exports["es_extended"]:getSharedObject()

Citizen.CreateThread(function()
    while true do
        local sleep = 1000
        local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)
        for k, v in pairs(Config['Zone']) do
            if (GetDistanceBetweenCoords(coords, v.coords.x, v.coords.y, v.coords.z, true) < Config.DrawDistance) then
				sleep = 0
                DrawMarker(1, v.coords.x, v.coords.y, v.coords.z-1, 0, 0, 0, 0, 0, 0, v.size*2, v.size*2, 0.5, 0, 191, 255, 155, 0, 0, 2, 0, 0, 0, 0)
                if (GetDistanceBetweenCoords(coords, v.coords.x, v.coords.y, v.coords.z, true) < v.size ) then
                    ShowFloating('<font face="sarabun">กด [~r~ E ~w~] เพื่อเปิดเมนูผู้เล่น</font>',v.coords.x, v.coords.y, v.coords.z)
                    if IsControlJustReleased(1, 38) then
                        Start()
                    end
                end
			end
        end
		Citizen.Wait(sleep)
    end
end)

function Start()
    SetNuiFocus(true, true)
	SendNUIMessage({
		action = 'Start',
		type = true,
	})
end

function Stop()
    SetNuiFocus(false, false)
	SendNUIMessage({
		action = 'Start',
		type = false,
	})
end


RegisterNUICallback('exit', function()
    Stop()
end)

RegisterNUICallback('skin', function()
    Stop()
    TriggerEvent('esx_skin:openSaveableMenu')
end)

RegisterNUICallback('tp', function()
    Stop()
    for k, v in pairs(Config['Zone']) do
        SetEntityCoords(PlayerPedId(), v.coordtp.x, v.coordtp.y, v.coordtp.z)
    end
end)

ShowFloating = function (msg, x,y,z)
    AddTextEntry(GetCurrentResourceName(), msg)
    SetFloatingHelpTextWorldPosition(1, x,y,z)
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
    BeginTextCommandDisplayHelp(GetCurrentResourceName())
    EndTextCommandDisplayHelp(2, false, false, -1)
end