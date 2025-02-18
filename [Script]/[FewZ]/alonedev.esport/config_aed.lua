
Config = Config or {}

Config['Setup_cl'] = function()
    ESX = nil
    Citizen.CreateThread(function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(0)
        end
    end)
end

Config['Setup_sv'] = function()
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

Config['Noti'] = function(text)
    TriggerEvent('pNotify:SendNotification', {
        text = '<span class="red-text">'..text..'</span> ',
        type = 'error',
        timeout = 3000,
        layout = 'centerLeft',
        queue = 'global'
    })
end

Config['AedProgbar'] = function(time)
    local status
    TriggerEvent("mythic_progbar:client:progress", {
        name = "unique_action_name",
        duration = time * 1000,
        label = "ตื่นมาก่อน พวกแม่งรออยู่..",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = false,
            },
        }, function(s)
            status = s
        end
    )

    while status == nil do 
        Wait(0)
    end

    return status
end

Config['ReviveAed'] = function()
    TriggerEvent('esx_ambulancejob:revive') -- เชื่อมหมอ
    -- local playerPed = GetPlayerPed(-1)
	-- local coords    = GetEntityCoords(playerPed)

	-- TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)

	-- Citizen.CreateThread(function()

	-- 	DoScreenFadeOut(1500)

	-- 	while not IsScreenFadedOut() do
	-- 		Citizen.Wait(1000)
	-- 	end

	-- 	ESX.SetPlayerData('lastPosition', {
	-- 		x = coords.x,
	-- 		y = coords.y,
	-- 		z = coords.z
	-- 	})

	-- 	TriggerServerEvent('esx:updateLastPosition', {
	-- 		x = coords.x,
	-- 		y = coords.y,
	-- 		z = coords.z
	-- 	})

	-- 	RespawnPed(playerPed, {
	-- 		x = coords.x,
	-- 		y = coords.y,
	-- 		z = coords.z
	-- 	})
	-- 	StopScreenEffect('')
	-- 	DoScreenFadeIn(1500)
	-- 	SetEntityHealth(playerPed, 120)
	-- 	FreezeEntityPosition(PlayerPedId(), false)
	-- end)
end


-- function RespawnPed(ped, coords, heading)
--     SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
--     NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
--     SetPlayerInvincible(ped, false)
--     TriggerEvent('playerSpawned', coords.x, coords.y, coords.z)
--     TriggerEvent('esx:onPlayerSpawn', coords.x, coords.y, coords.z)
--     ClearPedBloodDamage(ped)

--     ESX.UI.Menu.CloseAll()
-- end


Config['Aed'] = {
    {
        ['item_name'] = 'aed',
        ['CheckCount'] = true ,
        ['Job'] = nil ,
        ['Zone'] = nil ,
        --[[
        ['Zone'] = {
            coords = vector3(3873.3567, -1656.4917, 627.7646),
            rad = 50.0
        } ,
        ]]
        ['Time'] = 5,
        ['Remove'] = true,
    },
    {
        ['item_name'] = 'aed_agency',
        ['CheckCount'] = true ,
        ['Job'] = {'police' , 'ambulance' , 'council'} ,
        ['Zone'] = nil ,
        --[[
        ['Zone'] = {
            coords = vector3(3873.3567, -1656.4917, 627.7646),
            rad = 50.0
        } ,
        ]]
        ['Time'] = 5,
        ['Remove'] = false,
    },
}