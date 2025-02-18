loadingbar = function() -- ใส่หลอดโหลด
    TriggerEvent("mythic_progbar:client:progress", {
        duration = Config.Time * second,
        label = "กำลังล้างรถ",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }
    },
        function(status)
            if not status then
                -- Do Something If Event Wasn't Cancelled
            end
        end)
end

fixevent = function () -- สำหรับใส่พวกเควส ไม่ใส่ก็ปล่อยว่าง
    -- print('Fix')
end

washevent = function () -- สำหรับใส่พวกเควส ไม่ใส่ก็ปล่อยว่าง
    -- print('wash')
end

textui = function () -- ใส่ Textui
    local CarTarget = GetVehiclePedIsIn(PlayerPedId(),false)
    local VehicleCoords = GetEntityCoords(CarTarget)
    Drawtext(VehicleCoords.x,VehicleCoords.y,VehicleCoords.z + 1, '<font face="font4thai">~w~กด [~r~E~w~]~w~ เพื่อเปิดเมนู</font>')
    -- exports["Blitz_textui"]:ShowHelpNotification("กด ~INPUT_CONTEXT~ เพื่อเปิดเมนู")
end