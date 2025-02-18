ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
end)

---------------------------------------------------------------------------------
--Citizen.CreateThread(function()
--    while true do
--        Wait(0)
--        local ped = PlayerPedId()
--        if DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId(ped))) then
--            local veh = GetVehiclePedIsTryingToEnter(PlayerPedId(ped))
--            local lock = GetVehicleDoorLockStatus(veh)
--            if lock == 7 then
--                SetVehicleDoorsLocked(veh, 2)
--            end
--            local pedd = GetPedInVehicleSeat(veh, -1)
--            if pedd then
--                SetPedCanBeDraggedOut(pedd, false)
--            end
--        end
--    end
-- end)
-----------------------------------------------------------------------------------

local locked = false
RegisterNetEvent(GetCurrentResourceName() ..':start')
AddEventHandler(GetCurrentResourceName() ..':start', function()
    local ped = PlayerPedId()
    local pedc = GetEntityCoords(ped)
    local closeveh = GetClosestVehicle(pedc.x, pedc.y, pedc.z, 5.0, 0 ,71)
    local lockstatus = GetVehicleDoorLockStatus(closeveh)
    local distance = #(GetEntityCoords(closeveh) - pedc)
    if distance < 3 then
        if lockstatus == 2 then
            local result = exports['lockpick']:startLockpick()
            ped = PlayerPedId()
            pedc = GetEntityCoords(ped)
            local veh = GetClosestVehicle(pedc.x, pedc.y, pedc.z, 3.0, 0, 71)
            TriggerServerEvent(GetCurrentResourceName() ..':remove')
            if result then
                Citizen.Wait(1000)
                ExecuteCommand("e uncuff")
                Citizen.Wait(500)
                ClearPedTasks(PlayerPedId())
                FreezeEntityPosition(PlayerPedId(), false)
                SetVehicleDoorsLocked(veh, 0)
                SetVehicleDoorsLockedForAllPlayers(veh, false)
                exports["pNotify"]:SendNotification({
                    text = 'ปลดล็อครถเรียบร้อย',
                    type = "success",
                    timeout = 3000,
                    layout = "centerRight",
                    queue = "global"
                })
            else
                ClearPedTasks(PlayerPedId())
                FreezeEntityPosition(PlayerPedId(), false)
                SetVehicleAlarm(veh, true)
                SetVehicleAlarmTimeLeft(veh, 10000)
                SetVehicleDoorsLocked(veh, 2)
                exports["pNotify"]:SendNotification({
                    text = 'ปลดล็อครถไม่สำเร็จ',
                    type = "error",
                    timeout = 3000,
                    layout = "centerRight",
                    queue = "global"
                })
            end
        else
            exports["pNotify"]:SendNotification({
                text = 'รถไม่ได้ล็อค',
                type = "error",
                timeout = 3000,
                layout = "centerRight",
                queue = "global"
            })
        end
    else
        exports["pNotify"]:SendNotification({
            text = 'ไม่เจอรถ',
            type = "error",
            timeout = 3000,
            layout = "centerRight",
            queue = "global"
        })
    end
end)