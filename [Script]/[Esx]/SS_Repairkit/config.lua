--[[
▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
██ ▄▄▄ ██ ▄▄▄ ████ ▄▄▄ ██ ▄▄▀██ ▄▄▀█▄ ▄██ ▄▄ █▄▄ ▄▄
██▄▄▄▀▀██▄▄▄▀▀████▄▄▄▀▀██ █████ ▀▀▄██ ███ ▀▀ ███ ██
██ ▀▀▀ ██ ▀▀▀ ████ ▀▀▀ ██ ▀▀▄██ ██ █▀ ▀██ ██████ ██
▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀
]]

Config = {}
Config['Event'] = {
    ['FrameWork_Client'] = 'esx:getSharedObject',
    ['FrameWork_Server'] = 'esx:getSharedObject',
}

Inventory_close = function() -- ใส่ฟังก์ชั่นปิดกระเป๋าของท่าน
    --[[ 
        ปิดกระเป๋า NC
        exports.esx_inventoryhud:CloseInventory(PlayerPedId())
    ]]
end

Animation_fuc = function(time, text)
    --[ ฟังก์ชั่นนี้จะเริ่มทำงานเมื่อเข้าเงื่อนไขซ่อมได้ ]
    TriggerEvent("mythic_progbar:client:progress", {
        duration = time,
        label = text,
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }
    })
    FreezeEntityPosition(PlayerPedId(), true)
end

Animation_stop = function()
    --[ ฟังก์ชั่นนี้จะทำงานเมื่อทำ Animation_fuc เสร็จ ]
    FreezeEntityPosition(PlayerPedId(), false)
end

Config['Repair'] = {
    ['fixkit'] = {              -- ชื่อไอเท็ม
        type = "REPAIR",        -- จะให้ไอเท็มนี้เป็นอะไร [ "REPAIR" = กล่องซ่อม | "RAGS" = ผ้าเช็ครถ ]
        time = 7,              -- เวลาซ่อม หน่วย วินาที
        radius = 2.0,           -- ระยะห่างจากรถเท่าไหร่
        remove_item = {
            enabel = true,      -- ลบ Item หรือไม่
            amount = 1          -- จำนวนไอเท็มที่จะลบ
        },
        remove_money = {        -- ถ้าไม่ลบ item จะให้ลบเงินแทนมั้ย
            enabel = false,     -- เปิดใช้หรือไม่
            amount = 300        -- จำนวนเงินที่จะลบ
        },
    },
    ['fixkit_job'] = {
        type = "REPAIR",
        time = 7,
        radius = 2.0,           
        remove_item = { enabel = false, amount = 1 },
        remove_money = { enabel = true, amount = 300 },
        job_list = {            -- ตัวอย่างเช็คหน่วยงาน ถ้าไม่ใช้ให้ลบออกทั้งวงเล็บ
            'police',
            'ambulance',
            'mechanic',
        },
        remove_money = {        -- ถ้าไม่ลบ item จะให้ลบเงินแทนมั้ย
            enabel = true,     -- เปิดใช้หรือไม่
            amount = 500        -- จำนวนเงินที่จะลบ
        },
    },
    ['rag'] = {
        type = "RAGS",          -- type = RAGS ตัวอย่างผ้าเช็ครถแบบลบ item 
        time = 5,
        radius = 10.0,
        remove_item = { enabel = true, amount = 1 },
        remove_money = { enabel = false, amount = 1000 },
    },
}