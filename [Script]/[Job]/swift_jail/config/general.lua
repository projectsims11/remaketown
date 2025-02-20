config = {}
config.framework = "esx" --? esx, custom สามาระแก้ได้ฟังชั่นต่างๆได้ใน framework.lua

config.minimumTime = 1 -- เวลาจำคุกขั้นต่ำ
config.maximumTime = 500 -- เวลาจำคุกสูงสุดคือ: 9999999
config.minimumFine = 0 -- ค่าปรับต่ำสุด
config.maximumFine = 500000 -- ค่าปรับสูงสุดคือ: 99999999999
config.allowSelfJail = true -- เปิด/ปิด อนุญาติให้เจลตัวเอง
config.maxLabelLength = 255 -- จำนวนตัวอักษรสูงสุดเวลาใส่บิล (สูงสุด 255)
config.announce = true -- ประกาศบนแชทซ้ายบนหรือไม่

-- Database Configuration
config.loadDelay = 3 -- เมื่อผู้เล่นเข้าเซิฟเวอร์ให้รอกี่วินาทีถึงจะเช็คข้อมูล
config.skipCutscene = true -- ข้าม Cutscene เมื่อผู้เล่นเข้าเซิฟเวอร์ (ในกรณี config.cutscenes.enabled = true)
config.doNotSave = {
    enabled = true, -- เปิด/ปิด ระบบหากเวลาเหลือน้อย เช่น 5 วินาที (ค่าเริ่มต้น) จะไม่บันทึกข้อมูล และ จะลบข้อมูลออกแทน
    seconds = 5 -- หากเวลาที่เหลือต่ำกว่า 5 วินาที (ค่าเริ่มต้น) แล้วผู้เล่นออกจากเซิฟเวอร์ ให้ระบบลบข้อมูลแทนที่จะบันทึกข้อมูล
}

config.keyMapping = {
    enabled = true,
    defaultKey = "/"
}

config.commands = {
    jailMenu = {
        enabled = true, -- เปิด/ปิด คำสั่งเปิดเมนู
        command = "jail"
    },

    unjail = {
        enabled = true, -- เปิด/ปิด คำสั่งปล่อยตัว
        command = "unjail"
    }
}

config.permissions = {
    group = { -- สำหรับแอดมิน (ถ้ายังใช้เบสเก่าอยู่สามารถเพิ่ม superadmin ได้)
        "admin"
    },

    job = { -- อาชีพที่อนุญาติให้เปิดเมนู
        "police"
    }
}

config.waitForCollisionLoaded = true -- รอจนกว่าพื้นรอบๆผู้เล่นจะโหลดเสร็จถึงจะปล่อยล็อคขา, false = รอ 5 วินาทีแล้วปล่อยล็อคขาทันที (แนะนำให้ใช้เพราะมีความสเถียรกว่า และลดโอกาสการตกแมพ)
config.waitForCollisionTimeout = 5000 -- ถ้าพื้นรอบๆผู้เล่นไม่โหลดภายในเวลาที่ตั้งค่าไว้จะปล่อยล็อคขาทันที
config.jails = {
    ["small"] = {
        label = "ตู้ปลา", -- ข้อความที่จะแสดงในตัวเลือก
        ShowInMenu = true, -- แสดงในเมนูหรือไม่?
        jail_position = { -- ตำแหน่งที่จะจำคุก | สามารถใส่หลายจุดได้
            vector3(459.1574, -1001.3145, 24.9149),
            vector3(459.1427, -997.7450, 24.9149),
            vector3(460.2232, -994.2856, 24.9149)
        },
        unjail_position = { -- ตำแหน่งที่จะปล่อยตัว | สามารถใส่หลายจุดได้
            vector3(433.4303, -975.3193, 30.7100)
        }
    },
    ["main"] = {
        label = "คุกใหญ่",
        ShowInMenu = true,
        jail_position = {
            vector3(1681.0636, 2512.7705, 45.5648)
        },
        unjail_position = {
            vector3(433.4303, -975.3193, 30.7100)
        }
    }
}


config.unjail = {
    enabled = true,
    key = "K",
    imagePath = "nui://Fewthz_inventory/html/img/items/",
    minimumTime = 5, -- หากเวลาต่ำกว่านี้จะใช้บัตรไม่ได้
    items = { --- {item = "ชื่อไอเทม", time = เวลาที่จะลด (หน่วยเป็นนาทีเท่านั้น)}
        {name = "Unjail_5m", time = 5},
        {name = "Unjail_10m", time = 10}
    }
}

config.setClothes = {
    enabled = true, -- เปิด/ปิด ระบบเปลี่ยนชุดนักโทษ
    male = { -- ผู้ชาย
        ['tshirt_1'] = 15,
        ['tshirt_2'] = 0,
        ['torso_1'] = 834,
        ['torso_2'] = 2,
        ['arms'] = 2,
        ['pants_1'] = 49,
        ['pants_2'] = 0,
        ['shoes_1'] = 53,
        ['shoes_2'] = 0
    },

    female = { -- ผู้หญิง
        ['tshirt_1'] = 13,
        ['tshirt_2'] = 0,
        ['torso_1'] = 986,
        ['torso_2'] = 2,
        ['arms'] = 4,
        ['pants_1'] = 195,
        ['pants_2'] = 0,
        ['shoes_1'] = 47,
        ['shoes_2'] = 0
    }
}

---@param unique string (สำคัญ: ห้ามใช้ชือซ้ำกัน) แนะนำให้เป็นภาษาอังกฤษ และห้ามเว้นวรรค เพราะอันนี้จะใช้บันทึกข้อมูลและโหลดข้อมูลคดีที่กดบันทึกเอาไว้
---@param label string ข้อความที่จะแสดงในเมนู
---@param amount number ค่าปรับ
---@param jail_time table เวลาจำคุก minutes คือ นาที seconds คือ วินาที
config.fine_types = {
    {unique = "cement", label = "ปูน", amount = 2000, jail_time = 5},
    {unique = "escape", label = "หลบหนี", amount = 1500, jail_time = 10},
    {unique = "escape2", label = "หลบหนีทางน้ำ / ขึ้นเขา / ออกนอกเมือง", amount = 4500, jail_time = 30},
    {unique = "escape3", label = "หลบหนีหลังการจับกุม", amount = 10000, jail_time = 15},
    {unique = "conspire", label = "สมรู้ร่วมคิด (รับโทษเท่ากัน)", amount = 0, jail_time = 0},
    {unique = "capsule_a", label = "แคป A", amount = 1500, jail_time = 10},
    {unique = "capsule_b", label = "แคป B", amount = 1500, jail_time = 10},
    {unique = "capsule_c", label = "แคป C", amount = 1500, jail_time = 10},
    {unique = "capsule_p", label = "แคป P", amount = 2500, jail_time = 15},
    {unique = "cocain_a", label = "โคเคน", amount = 1500, jail_time = 10},
    {unique = "promethazine", label = "promethazine", amount = 3500, jail_time = 10},
    {unique = "heroin", label = "เฮโรอีน", amount = 15000, jail_time = 15},
    {unique = "uranium", label = "Uranium", amount = 2500, jail_time = 15},
    {unique = "riskyarea", label = "พื้นที่สุ่มเสี่ยง", amount = 1000, jail_time = 5},
    {unique = "hideface", label = "ปกปิดใบหน้า", amount = 5000, jail_time = 5},
    {unique = "weapon", label = "เจตนาควักอาวุธ / ถืออาวุธ ในพื้นที่สาธารณะและพื้นที่สุ่มเสี่ยง", amount = 5000, jail_time = 10},
    {unique = "evidence", label = "ทำลายหลักฐาน", amount = 10000, jail_time = 15},
    {unique = "argue", label = "ทะเลาะวิวาท", amount = 10000, jail_time = 20},
    {unique = "disturb", label = "ก่อกวน / สร้างความวุ่นวาย ทุกกรณี", amount = 15000, jail_time = 15},
    {unique = "carrisk", label = "ขับรถประมาท", amount = 3000, jail_time = 10},
    {unique = "carriskdead", label = "ขับรถประมาททำให้ผู้อื่นเสียชีวิต", amount = 5000, jail_time = 20},
    {unique = "help", label = "ช่วยเหลือผู้ต้องหา", amount = 5000, jail_time = 20},


    {unique = "harm", label = "เจตนาทำร้ายร่างกาย / ทำร้ายร่างกายจน [สลบ/ไม่สลบ]", amount = 20000, jail_time = 30},
    
    {unique = "intimidate", label = "กักขังหน่วงเหนี่ยว, ข่มขู่", amount = 10000, jail_time = 20},
    {unique = "fraudulent", label = "ฉ้อโกง หรือ สตอรี่บิดของ", amount = 30000, jail_time = 30},
    
    {unique = "assist", label = "ช่วยเหลือผู้กระทำผิดระหว่างการจับกุม", amount = 10000, jail_time = 15},
    {unique = "pretend", label = "แอบอ้างเป็นหน่วยงานทุกรูปแบบ", amount = 30000, jail_time = 20},
    {unique = "stealvehicles", label = "ขโมยรถ / ขโมยเรือ หรือ พาหนะทุกประเภท", amount = 10000, jail_time = 10},
    {unique = "propertydamaged", label = "ทำความเสียหายต่อทรัพย์สิน (ชนแล้วหนี)", amount = 10000, jail_time = 10},
    
    {unique = "breakcell", label = "พยายามแหกคุก / แหกคุก (คุกใหญ่) ", amount = 10000, jail_time = 20},
    {unique = "helpbreakcell", label = "ช่วยเหลือแหกคุก / แหกคุก (คุกใหญ่)", amount = 10000, jail_time = 20},
    {unique = "bug", label = "ใช้บัค", amount = 50000, jail_time = 30},

    
   
}

config.cutscenes = {
    enabled = true, -- เปิด/ปิดระบบ Cutscene
    policeModel = -1320879687, -- โมเดล NPC ตำรวจ
    photoPosition = vector4(402.92, -996.76, -99.0, 186.225), -- จุดที่ผู้เล่นจะยืน (x, y, z, heading)
    policePosition = vector4(402.917, -1000.637, -99.004, 356.880), -- ตำแหน่ง NPC ตำรวจ
    camera = {
        duration = 5000, -- ระยะเวลาที่กล้องจะย้ายตำแหน่ง
        tweenedDuration = 5000, -- ระยะเวลาก่อนที่จะลบกล้อง
        start = {position = vector3(402.91, -997.54, -98.2), rotation = vector3(-10.43, 0.0, -0.314)}, -- ตำแหน่งเริ่มต้น
        stop = {position = vector3(402.97, -1001.89, -97.7), rotation = vector3(-15.43, 0.0, -0.314)} -- ค่ำแหน่งสุดท้ายที่กล้องจะหยุด
    }
}

config.notifyCL = function(text, type)
    TriggerEvent("pNotify:SendNotification", {
        text = text,
        layout = "bottomCenter",
        timeout = 3000,
        type = type,
    })
end

config.notifySV = function(playerId, text, type)
    TriggerClientEvent("pNotify:SendNotification", playerId, {
        text = text,
        layout = "bottomCenter",
        timeout = 3000,
        type = type,
    })
end