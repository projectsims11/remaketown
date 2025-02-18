

function alertAccessoryblank()
    pcall(function()
    exports.pNotify:SendNotification({text = "กรุณาใส่ชื่อเสื้อผ้า", timeout = 5000})
    end)
end

function alertAccessoryShort()
    pcall(function()
        exports.pNotify:SendNotification({text = "ชื่อสั้นเกินไป", timeout = 5000})
    end)
end

function alertAccessoryLong()
    pcall(function()
    exports.pNotify:SendNotification({text = "ชื่อยาวเกินไป", timeout = 5000})
    end)
end


function PaybutMoneyNotEnough(price)
    pcall(function()
       TriggerEvent("pNotify:SendNotification", {
           text = '<strong class="red-text">เงินในกระเป๋าไม่เพียงพอต้องใช้  </strong>' ..price..' บาท',
           type = "error",
           timeout = 3000,
           layout = "centerRight",
           queue = "global"
       })
    end)
end

function DoneUpdateSkin()
    pcall(function()
        exports.pNotify:SendNotification({text = "อัพเดทสกิลเรียบร้อยแล้ว", timeout = 5000})
    end)
end

function FullSlotCloth()
    pcall(function()
        TriggerEvent("pNotify:SendNotification", {
            text = '<strong class="green-text">ชุดเต็ม slot ไม่สามารถเพิ่มได้ กรุณาเพิ่ม slot </strong>',
            type = "error",
            timeout = 3000,
            layout = "centerRight",
            queue = "global"
        })
    end)

end


function NotEnoughMoneySavaCloth()
    pcall(function()
    TriggerEvent("pNotify:SendNotification", {
        text = '<strong class="red-text">เงินในกระเป๋าไม่เพียงพอต้องใช้  </strong>' ..Config.wardrobePrice..' บาท',
        type = "error",
        timeout = 3000,
        layout = "centerRight",
        queue = "global"
    })
    end)
end


function DoneLoadCloth()
    pcall(function()
        exports.pNotify:SendNotification({text = "<strong >โหลดชุดสำเร็จ </strong>", timeout = 5000})
    end)
end


function DoneSaveCloth()
    pcall(function()
        exports.pNotify:SendNotification({text = "<strong >บันทึกชุดเรียบร้อยแล้ว </strong>", timeout = 5000})
    end)
end


function NotEnoughMoneyAddSlot()
    pcall(function()
        TriggerEvent("pNotify:SendNotification", {
            text = '<strong class="red-text">เงินในกระเป๋าไม่เพียงพอต้องใช้  </strong>'..Config.wardrobeslot,
            type = "error",
            timeout = 3000,
            layout = "centerRight",
            queue = "global"
        })
    end)
end
