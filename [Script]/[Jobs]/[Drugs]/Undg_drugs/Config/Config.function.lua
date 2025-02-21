Progress = function(time)
    local promise = promise:new() -- สร้าง promise

    exports['mythic_progbar']:Progress({
        name = "unique_action_name",
        duration = time * 1000,
        label = 'Doing Something',
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "amb@world_human_guard_patrol@male@idle_b",
            anim = "idle_e",
            flags = 49,
        },
    }, function(cancelled)
        if not cancelled then
            promise:resolve(true) -- ถ้าการทำงานสำเร็จ ส่งค่า true กลับ
        else
            promise:resolve(false) -- ถ้ายกเลิก ส่งค่า false กลับ
        end
    end)

    return Citizen.Await(promise) -- คืนค่ารอการทำงานของ promise
end

MiniGame = function()
    -- local result = exports.nc_minigames:Minigame('bar', {
    --     text = 'ซ่อมไฟ',
    --     speed = 1.2,
    --     success = 4,
    --     failed = 2,
    --     position = 'random',
    --     sound = true
    -- })
    -- if result then
    --     return true
    -- else
    --     return false
    -- end
    return true
end

Fail = function()
   FreezeEntityPosition(PlayerPedId(), true)
   Wait(5000)
   FreezeEntityPosition(PlayerPedId(), false)
end

TextUi = function(coords) -- TEXT จะขึ้นตอนอยู่ใกล้ๆ ใช้แบบ No Loop
    exports["Fewthz_TextUI"]:ShowHelpNotification('PRESS <span>E</span> TO OPEN MENU SELL DRUGS')
    -- exports["Fewthz_TextUI"]:ShowHelpNotification(v.TextUI)
    --exports["Fewthz_TextUI"]:ShowHelpNotification(CurrentActionMsg)
end
 
HideTextUI = function()
    -- exports["Fewthz_TextUI"]:ShowHelpNotification()
end

CheckCountJob = function(count)
    police = exports["Undg_check"]:Check('police')
    if police >= count then
        return true
    end

    return false
end

BlockKeys = function()
	DisableAllControlActions(0)

	EnableControlAction(0, 1, true) -- Mouse movement (Look)
	EnableControlAction(0, 2, true) -- Mouse movement (Look)
	EnableControlAction(0, 3, true) -- Mouse scroll down
	EnableControlAction(0, 4, true) -- Mouse scroll up

    EnableControlAction(0, 73, true)
	EnableControlAction(0, 249, true)
	EnableControlAction(0, 306, true)
	EnableControlAction(0, 19, true)
end

SendMessagePolice = function() -- ส่งข้อความถึงใครบ้างตอนจกเสร็จ
    TriggerEvent("Fewthz_policealert:alertNet", "cement")
    local PedPosition = GetEntityCoords(PlayerPedId())
	local PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z }

	TriggerServerEvent('esx_addons_gcphone:startCall', 'police', ('มีคนกำลังขายยา !'), PlayerCoords, {
		PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z },
	})
end