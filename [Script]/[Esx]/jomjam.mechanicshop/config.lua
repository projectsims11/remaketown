Config = Config or {}

Config['Base'] = { -- สำหรับ Base ที่ไม่ใช่ esx สามารถปรับได้ที่ตรงนี้เลยครับ

    [1] = 'esx:getSharedObject',
    [2] = 'esx:playerLoaded',
    [3] = 'esx:setJob'


}

local Sec = 1000
local Minute = 60 * Sec
local Hour = 60 * Minute

Config['ActionDistance'] = 3.0 -- ระยะในการกดเพื่อแต่งรถ
Config['Keys'] = {

    action = { -- การตั่งค่าต่างๆ
        key = 38, -- ปุ่มที่ใช่ในการกด (https://docs.fivem.net/docs/game-references/controls/)
        TextHelper = '<font face="font4thai">กด E ~b~เพื่อแต่งรถ</font>'
    }
    
}

Config['UseJob'] = false -- ใช้หน่วยงานในการแต่งมั้ย

Config['Positions'] = {
    {
        pos = { x = 284.760009765625, y = -337.6099853515625, z = 45.0099983215332 }, -- พิกัดที่สามารถแต่งรถได้
        NeedJobName = 'mechanic', -- ใช้อาชีพไหนแต่งรถ
        -- -- อันเดิม
        -- Blip = {

        --     Open = true,
        --     ID = 455,
        --     Color = 0,
        --     Size = 1.0,
        --     Name = '<font face="font4thai">ร้านแต่งรถ</font>',

        -- }
        Blip = {

            Open = true,
            ID = 383,
            Color = 0,
            Size = 0.8,
            Name = '<font face="font4thai">ร้านแต่งรถ</font>',

        }
    },
    {
        pos = { x = 275.8900146484375, y = -335.3500061035156, z = 45.0099983215332 }, -- พิกัดที่สามารถแต่งรถได้
        NeedJobName = 'mechanic', -- ใช้อาชีพไหนแต่งรถ
        Blip = {

            Open = false,
            ID = 72,
            Color = 0,
            Size = 1.0,
            Name = 'Customs Car',

        }
    },
    {
        pos = { x = 280.2300109863281, y = -337.04998779296875, z = 45.0099983215332 }, -- พิกัดที่สามารถแต่งรถได้
        NeedJobName = 'mechanic', -- ใช้อาชีพไหนแต่งรถ
        Blip = {

            Open = false,
            ID = 72,
            Color = 0,
            Size = 1.0,
            Name = 'Customs Car',

        }
    },
    {
        pos = { x = 284.2200012207031, y = -339.04998779296875, z = 45.0099983215332 }, -- พิกัดที่สามารถแต่งรถได้
        NeedJobName = 'mechanic', -- ใช้อาชีพไหนแต่งรถ
        Blip = {

            Open = false,
            ID = 72,
            Color = 0,
            Size = 1.0,
            Name = 'Customs Car',

        }
    },
    {
        pos = { x = 288.9100036621094, y = -340.4500122070313, z = 45.0099983215332 }, -- พิกัดที่สามารถแต่งรถได้
        NeedJobName = 'mechanic', -- ใช้อาชีพไหนแต่งรถ
        Blip = {

            Open = false,
            ID = 72,
            Color = 0,
            Size = 1.0,
            Name = 'Customs Car',

        }
    }
}


Config["Loading"] = { -- หลอดโหลดตอนซ่อมรถ
    ["Type"] = "mythic_progbar", -- ชื่อ Evant ของสคริปหลอดโหลด mythic_progbar
    ["Settings"] = { -- การตั้งค่าต่างๆ
        ["Repair"] = {
            ["Time"] = 30 * Sec, -- ระยะเวลาในการซ่อม
            ["Text"] = "กำลังซ่อมรถ" -- ข้อความระหว่างการซ่อม
        }
    }
}

Config['Repair'] = { -- ตั้งค่าการซ่อมรถ

    ['Vehiclerepair'] = true, -- ใช้เวลาซ่อมรถตามความพัง
    ['Repair'] = false, -- ถ้าเป็น false จะแค่ล้างรถ ถ้าเป็น true จะซ่อมรถด้วย
    ['Time'] = 5, -- เวลา * ['Vehiclerepair'] ถ้าไม่ต้องการให้ปรับเป็น 1
    ['Fuel'] = 100.0, -- น้ำมัน ( % ) | มี .0
    ['Cleanliness'] = 0 -- ความสะอาด ( % ) น้อย = สะอาด | ไม่ต้องมี .0

}

Config['Alert_NotJob'] = true -- เปิดการใช้งานมั้ย true = เปิด | false = ปืด
function Alert_NotJob() -- ข้อความเวลาผู้เล่น (ที่ อาชีพไม่ตรงกับ NeedJobName) มากดแต่งรถ
    TriggerEvent("pNotify:SendNotification", {
        text = 'กรุณาตามช่าง',
        type = "error",
        timeout = 5000,
        layout = "centerRight",
        queue = "global"
    })
end

Config['Finish'] = false -- เปิดการใช้งานมั้ย true = เปิด | false = ปืด
function Finish() -- ข้อความตอนแต่งรถ เสร็จ

    TriggerEvent("pNotify:SendNotification", {
        text = 'เสร็จสิ้น',
        type = "success",
        timeout = 5000,
        layout = "centerRight",
        queue = "global"
    })

end

Config['Finish_Custom'] = true-- เปิดการใช้งานมั้ย true = เปิด | false = ปืด
function Finish_Custom() -- ข้อความตอนซ่อมรถ เสร็จ

    TriggerEvent("pNotify:SendNotification", {
        text = 'ซ่อมรถเสร็จแล้วว !',
        type = "success",
        timeout = 5000,
        layout = "centerRight",
        queue = "global"
    })

end