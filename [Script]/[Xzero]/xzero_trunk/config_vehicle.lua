--[[
    =========================== ตั้งค่าทั่วไป ===========================
]]
Config.Vehicle_Distance         = 3.0       -- ระยะในการค้นหารถและต้องห้ามอยู่ห่างเกินเท่าไหร่
Config.Vehicle_NPC_Disabled     = true     -- true = จะไม่สามารถเปิดหลังรถ NPC ทุกคันได้
Config.Vehicle_OwnerOnly        = true     -- true = ต้องเป็นเจ้าของรถเท่านั้นถึงจะเปิดช่องเก็บไอเทมรถได้
Config.Vehicle_IsIn             = false     -- true = อยู่บนรถสามารถเปิดช่องเก็บไอเทมรถได้ (false = จะเปิดไม่ได้ต้องลงจากรถก่อน)
Config.Vehicle_IsInOnly         = false     -- true = ต้องอยู่บนรถเท่านั้นถึงจะสามารถเปิดช่องเก็บไอเทมรถได้
Config.Vehicle_IsIn_DriverOnly  = false     -- true = ต้องเป็นคนที่ขับรถเท่านั้นถึงจะสามารถเปิดช่องเก็บไอเทมได้
Config.Vehicle_IsIn_PedAny      = false     -- true = หากมีผู้เล่นคนอื่นอยู่บนรถสามารถเปิดช่องเก็บไอเทมได้
Config.Vehicle_OpenTrunkMax     = 1         -- กำหนดสามารถเปิดหลังรถได้พร้อมกันกี่คน (-1 = ไม่จำกัด | 1 = เปิดได้คนเดีวย | กำหนดจำนวนคนได้)

--[[
    =================== Debug Vehicle Info ===================
    เอาไว้สำหรับดูข้อมูลรถ Plate/Class/DisplayName/Model
    พิมพ์คำสั่ง /vehinfo ในเกมส์เพื่อเปิดใช้งานและขึ้นไปอยู่บนรถจะแสดงข้อมูล
]]
Config.Debug_Vehicle_Info = true


--[[
    =========================== ตั้งค่า Weight, Slots เริ่มต้นพื้นฐาน ===========================
    Weight = น้ำหนักที่แบกได้ (-1 = ไม่จำกัด)
    Slots = จำนวนช่องไอเทม (-1 = ไม่จำกัด)
]]
Config.Vehicle_Weight_Default   = 5.00      -- ค่าเริ่มต้นของน้ำหนักเก็บไอเทม
Config.Vehicle_Slots_Default    = -1        -- ค่าเริ่มต้นของจำนวนช่องเก็บไอเทม


--[[
    =========================== Class คราส ===========================
    Weight = น้ำหนักที่แบกได้ (-1 = ไม่จำกัด)
    Slots = จำนวนช่องไอเทม (-1 = ไม่จำกัด)
]]
Config.Vehicle_Weight_Class = {
    ['compacts']           =   { weight    = 10.00,     slots  = -1 },
    ['sedans']             =   { weight    = 20.00,     slots  = -1 },
    ['suvs']               =   { weight    = 30.00,     slots  = -1 },
    ['coupes']             =   { weight    = 10.00,     slots  = -1 },
    ['muscle']             =   { weight    = 20.00,     slots  = -1 },
    ['sports classics']    =   { weight    = 20.00,     slots  = -1 },
    ['sports']             =   { weight    = 10.00,     slots  = -1 },
    ['super']              =   { weight    = 5.00,      slots  = -1 },
    ['motorcycles']        =   { weight    = 5.00,      slots  = -1 },
    ['off-road']           =   { weight    = 60.00,     slots  = -1 },
    ['vans']               =   { weight    = 40.00,     slots  = -1 },
    ['emergency']          =   { weight    = 5.00,      slots  = -1 },
    ['industrial']         =   { weight    = 5.00,      slots  = -1 },
    ['utility']            =   { weight    = 5.00,      slots  = -1 },
    ['cycles']             =   { weight    = 5.00,      slots  = -1 },
    ['boats']              =   { weight    = 5.00,      slots  = -1 },
    ['helicopters']        =   { weight    = 5.00,      slots  = -1 },
    ['planes']             =   { weight    = 5.00,      slots  = -1 },
    ['service']            =   { weight    = 5.00,      slots  = -1 },
    ['military']           =   { weight    = 5.00,      slots  = -1 },
    ['commercial']         =   { weight    = 5.00,      slots  = -1 },
    ['trains']             =   { weight    = 5.00,      slots  = -1 }
}


--[[
    =========================== DisplayName/Model ชื่อ/โมเดล ===========================
    ** การกำหนดชื่อตัวอักษรจะต้องเป็นตัวพิมพ์เล็กทั้งหมด **
    Weight = น้ำหนักที่แบกได้ (-1 = ไม่จำกัด)
    Slots = จำนวนช่องไอเทม (-1 = ไม่จำกัด)
]]
Config.Vehicle_Weight_NameAndModel = {
    --['test00'] = { -- ชื่อ DisplayName หรือ Model
    --    weight    = 10.00, -- น้ำหนัก (-1 = จะไม่จำกัดน้ำหนัก)
    --    slots     = 60, -- จำนวนช่องไอเทม (-1 = ไม่จำกัดจำนวนช่องไอเทม)
    --    item_blacklist = {
    --        -- กำหนดชื่อไอเทมที่จะไม่ให้เก็บ (กำหนดได้หลายไอเทม)
    --        "fixkit",
    --        "water"
    --    },
    --    item_limit = {
    --        -- กำหนดชื่อไอเทมที่จะจำกัดจำนวนไม่ให้เก็บได้เกินที่กำหนด (กำหนดได้หลายไอเทม)
    --        -- การตั้ง -1 = ไม่จำกัดจำนวน
    --        ['bread'] = 2,
    --        ['water'] = 2
    --    },
    --    job = {
    --        -- กำหนด Job(อาชีพ) ที่จะสามารถเปิดหลังรถได้เท่านั้น
    --        --"police",
    --        --"ambulance"
    --    }
    --},

    ['sandking2'] = {   weight = 150.00,    slots = -1 },
    ['sandking'] = {   weight = 80.00,    slots = -1 },
    ['riata'] = {   weight = 50.00,    slots = -1 },
    ['guardian'] = {   weight = 100.00,    slots = -1 },
}


--[[
    =========================== Plate ป้ายทะเบียน ===========================
    Weight = น้ำหนักที่แบกได้ (-1 = ไม่จำกัด)
    Slots = จำนวนช่องไอเทม (-1 = ไม่จำกัด)
]]
Config.Vehicle_Weight_Plate = {
    ['AAA 01'] = {   weight = 100.00,    slots = -1 },
    ['AAA 02'] = {   weight = 100.00,    slots = -1 },
    ['AAA 03'] = {   weight = 100.00,    slots = -1 },
    --['AAA 03'] = {   weight = 100.00,    slots = -1 },
    --['AAA 03'] = {   weight = 100.00,    slots = -1 },
}

--[[
    =========================== ตั้งค่า Job อาชีพ/หน่วยงาน ===========================
]]
Config.Vehicle_Job = {
    ['police'] = {
        OwnerOnly_Allow = true, -- true = สามารถเปิดหลังรถได้ในกรณีที่ตั้งค่า Vehicle_OwnerOnly = true
        --Locked_Allow = true -- true = สามารถเปิดหลังรถที่ล็อคอยู่ได้
    },
    -- ['ambulance'] = {
    --     OwnerOnly_Allow = true, -- true
    --     Locked_Allow = false
    -- }
}

--[[
    ============================ BlackList รถที่จะไม่ให้เปิดหลังรถได้ ============================
    ** Class กำหนดด้วยคราสรถ (รายชื่อ Class ทั้งหมดดูได้จาก https://pastebin.com/raw/8CudCtme) **
]]
Config.Vehicle_BlackList_Class = {
    "cycles",
    "boats",
    "helicopters",
    "planes"
}


--[[
    ============================ BlackList รถที่จะไม่ให้เปิดหลังรถได้ ============================
    ** DisplayName, Model กำหนดจาก ชื่อรถ หรือ โมเดล **
    ** การกำหนดชื่อตัวอักษรจะต้องเป็นตัวพิมพ์เล็กทั้งหมด **
]]
Config.Vehicle_BlackList_NameAndModel = {
    --"xa21",
    --"adder"
}


--[[
    ============================ BlackList รถที่จะไม่ให้เปิดหลังรถได้ ============================
    ** Plate กำหนดจากป้ายทะเบียน **
]]
Config.Vehicle_BlackList_Plate = {
    --"AAA 001",
    --"AAA 002"
}


--[[
    =================== Vehicle NPC Database Control ===================
    ระบบจัดการข้อมูลไอเทมหลังรถของ NPC
    ** ตัวอย่างนี้จะเป็นการลบข้อมูล หลังรถNPC ที่ไม่มีการใช้งานเป็นเวลา 24ชม. **
]]
Config.Vehicle_NPC = {
    DB_Save         = true, -- false = จะไม่บันทึกข้อมูลไอเทมหลังรถNPC ลง Databadse (เมื่อรันสคิปใหม่ข้อมูลไอเทมหลังรถจะหาย)
    DB_Clear_Hour   = 24    -- จำนวนกี่ ชม. หากไม่มีการใช้งานหลังรถจะทำการลบข้อมูล (0 = ไม่ลบข้อมูล)
}