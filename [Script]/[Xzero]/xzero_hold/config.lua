--[[
    Script for FiveM (GTAV)
    Created: xZero
]]
Config = {}

-- Base Extended
Config.Base = {
    getSharedObject = 'esx:getSharedObject',
    onPlayerSpawn = 'esx:onPlayerSpawn',
    onPlayerDeath = 'esx:onPlayerDeath'
}

Config.Key_OpenMenu = Keys['F10'] -- ปุ่มสำหรับเปิดเมนูอุ้ม
Config.MenuAlign    = 'top-left' -- ตำแหน่งของเมนู

-- รายการที่จะแสดงในเมนูอุ้ม (สามารถปิดใช้งานแต่ละเมนูได้)
Config.Hold_Type_List = {
    { name = 'carry1',  label = 'อุ้ม' },
    { name = 'carry2',  label = 'ขี่หลัง' },
    { name = 'carry3',  label = 'แบก' },
    { name = 'carry4',  label = 'อุ้มแบบคิมิโน้โตะ' },
    { name = 'carry5',  label = '[ถ่ายรูป] อุ้มเจ้าสาว (เดินไม่ได้)' },
    --{ name = 'hostage', label = 'จับเป็นตัวประกัน' },
}

Config.Hold_Request_Distance    = 3.0  -- ระยะในการค้นหาผู้เล่น (ค้นหาผู้เล่นเพื่อที่จะทำการอุ้ม)
Config.Hold_Target_IsCancel     = true -- true = คนที่ถูกอุ้มสามารถยกเลิกอุ้มได้เอง (false = คนที่ถูกอุ้มจะยกเลิกอุ้มเองไม่ได้ ต้องให้คนอุ้มปล่อยเท่านั้น)
Config.Hold_Target_IsDead       = true -- true = สามารถอุ้มผู้เล่นที่ตายอยู่ได้ (false = จะอุ้มผู้เล่นที่ตายอยู่ไม่ได้)

--[[
    ========== ตั้งค่าการยอมรับอุ้ม ==========
    ** คนที่ตายอยู่จะสามารถอุ้มได้ทันทีโดยไม่ต้องรอยอมรับ **
]]
Config.NeedInvate           = true     -- true = เปิดใช้งานต้องกดยอมรับอุ้ม (คนที่ถูกอุ้มจะต้องกดยอมรับคำขอก่อน)
Config.NeedInvate_Timeout   = 10 * 1000 -- คำขอยอมรับอุ้มจะมีเวลาจำกัดเท่าไหร่ (หากเกินเวลาจะต้องขออุ้มใหม่)
Config.NeedInvate_MenuAlign = 'center' -- ตำแหน่งเมนูยอมรับ


--[[
    ========== ตั้งค่าดีเลย์ ==========
    1000 = 1วินาที | 500 = 0.5วินาที
]]
Config.Delay_After_Action = { 100, 500 } -- รอดีเลก่อนจะทำการอุ้มผู้เล่น (ในตัวอย่างนี้ตั้งไว้แบบสุ่มตั้งแต่ 100 ถึง 500)


--[[
    ========== คั้งค่าการปิดปุ่มกดตอนถูก อุ้ม หรือ จับเป็นประกัน ==========
    หาดูข้อมูลปุ่มกดได้จาก https://docs.fivem.net/docs/game-references/controls/
]]
Config.Hold_DisabledControl = {
    -- คนที่อุ้มหรือเป็นคนจับ
    ['source'] = {
        Enabled = false, -- true = เปิดใช้งานไม่ให้กดปุ้ม (ตั้งปุ่มที่จะไม่ให้กดใน Keys)
        Keys = {
        }
    },
    -- คนที่ถูกอุ้มหรือถูกจับ
    ['target'] = {
        Enabled = true, -- true = เปิดใช้งานไม่ให้กดปุ้ม (ตั้งปุ่มที่จะไม่ให้กดใน Keys)
        Keys = {
            24,   -- INPUT_ATTACK
            25,   -- INPUT_AIM
            140,  -- ATTACK (R)
            21,   -- INPUT_SPRINT
            22,   -- INPUT_JUMP
            38    -- INPUT_PICKUP (E)
        }
    }
}


Config.Hold_Option = {
    -- ตั่งค่าจับเป็นตัวประกัน
    ['hostage'] = {
        Bypass_NeedInvate = true, -- true = สามารถจับเป็นตัวกระกันได้ทันที (โดยไม่จำเป็นต้องรอยอมรับ ถ้าตั้งค่ายอมรับด้านบนไว้)
        UseWeapon         = true, -- true = ต้องถืออาวุธก่อนถึงจะสามารถจับเป็นตัวประกันได้
        UseWeaponList = {
            -- กำหนดชื่ออาวุธที่ต้องถือแล้วจะสามารถจับเป็นตัวประกันได้
            -- หาข้อมูลได้จาก https://wiki.rage.mp/index.php?title=Weapons
            "weapon_dagger", 
            "weapon_bottle", 
            "weapon_knife", 
            "weapon_machete", 
            "weapon_switchblade"
        },
        Kill        = true,    -- true = สามารถกดปุ่มเพื่อฆ่าตัวประกันได้
        Kill_Key    = 38,      -- ปุ่มที่จะทำการกดเพื่อฆ่า (ตัวอย่างนี้ตั้งไว้ปุ่ม E)
        Kill_Alert  = 'กด ~r~[E]~s~ ฆ่าตัวประกัน', -- ข้อความแจ้งบอกปุ่มกดฆ่า

        -- ไม่จำเป็นต้องปรับตรงนี้
        Target_IsCancel       = false,
        Request_Target_IsDead = false
    }
}


--[[
    ========== ตั้งค่าอาชีพ/หน่วยงาน ==========
]]
Config.Hold_Job = {
    -- ตัวอย่างการตั้งให้หน่วยงานตำรวจสามารถอุ้มได้โดยไม่ต้องยอมรับ และ คนถูกอุ้มยกเลิกเองไม่ได้
    ['police'] = {
        Bypass_NeedInvate       = true,  -- true = สามารถอุ้มได้ทันทีโดยไม่จำเป็นต้องรอยอมรับ
        Target_IsCancel         = false,  -- false = คนที่ถูกอุ้มจะไม่สามารถยกเลิกเองได้
		Request_Target_IsDead   = true   -- true = สามารถอุ้มคนที่ตายอยู่ได้ (สำหรับคนที่ตั้งค่า Config.Hold_Target_IsDead ไม่ให้อุ้มคนตาย)
    },
    -- ['ambulance'] = {
    --     Bypass_NeedInvate = true, -- true = สามารถอุ้มได้ทันทีโดยไม่จำเป็นต้องรอยอมรับ
    --     Target_IsCancel = true -- false = คนที่ถูกอุ้มจะไม่สามารถยกเลิกเองได้
    -- }
}


--[[
    ========== ตั้งค่า BlackList Zone ไม่ให้อุ้ม,จับตัวประกัน ในโซนที่กำหนด ==========
]]
Config.Zone_BlackList = {
    {
        enabled   = true,                  -- true = เปิดใช้งาน
        x = -335.7099914550781, y = -136.9900054931641, z = 38.59000015258789,  -- กำหนดพิกัด X Y Z
        distance  = 20.00,                  -- ความกว้างจากพิกัดที่กำหนด
        job_allow = {
            -- กำหนดอาชีพ/หน่วยงานที่จะให้สามารถอุ้มได้
            --"police",
            --"ambulance"
        }
    },
    {
        enabled   = true,                  -- true = เปิดใช้งาน
        x = -749.46, y = -1473.25, z = 4.69,  -- กำหนดพิกัด X Y Z
        distance  = 10.00,                  -- ความกว้างจากพิกัดที่กำหนด
        job_allow = {
        }
    },
    {
        enabled   = true,                  -- true = เปิดใช้งาน
        x = -737.5, y = -1483.31, z = 4.69,  -- กำหนดพิกัด X Y Z
        distance  = 10.00,                  -- ความกว้างจากพิกัดที่กำหนด
        job_allow = {
            -- กำหนดอาชีพ/หน่วยงานที่จะให้สามารถอุ้มได้
            --"police",
            --"ambulance"
        }
    },
    {
            enabled   = true,                  -- true = เปิดใช้งาน
            x = 245.38, y = -813.11, z = 30.97,  -- กำหนดพิกัด X Y Z
            distance  = 10.00,                  -- ความกว้างจากพิกัดที่กำหนด
            job_allow = {
                -- กำหนดอาชีพ/หน่วยงานที่จะให้สามารถอุ้มได้
                --"police",
                --"ambulance"
        }
    }
}


-- DrawText
Config.Text_Font = 'sarabun' -- ฟอนน์
Config.Text_Size = 0.75      -- ขนาดข้อความ

-- คำแปล
Config.T = {
    -- Hold Request
    ['hold_menu_title'] = 'Hold Menu',
    ['player_isin_vehicle'] = 'ผู้เล่นอยู่บนรถ ต้องลงจากรถก่อน',
    ['hold_target_notfound'] = 'ไม่พบผู้เล่น',
    ['hold_target_invaild'] = 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง',
    ['hold_target_isdead'] = 'ไม่สามารถ %s ผู้เล่นที่ตายได้',
    ['hold_target_request'] = 'ส่งคำขอไปยังผู้เล่น [ID:%s]',

    -- Hold Request Cancel
    ['hold_source_cancel'] = 'ยกเลิก [ID:%s]',
    ['hold_target_cancel'] = 'ยกเลิก [ID:%s]',

    -- Hold Invate Menu
    ['hold_invate_title'] = 'ยืนยันการขอจากผู้เล่น',
    ['hold_invate_accept'] = 'ยอมรับ [ID:%s]',
    ['hold_invate_reject'] = 'ยกเลิก',

    -- Hold Invate Receive
    ['hold_invate_receive_reject_source'] = 'ผู้เล่นยกเลิกคำขอ [ID:%s]',
    -- Hold Invate TimeOut
    ['hold_invate_timeout_source'] = 'หมดเวลาคำขอ [ID:%s]',
    ['hold_invate_timeout_target'] = 'หมดเวลาคำขอ [ID:%s]',

    -- Hold Action
    ['hold_action_delay_source'] = 'กรุณารอสักครู่...',
    ['hold_action_delay_target'] = 'กรุณารอสักครู่...',

    ['hold_action_success_source'] = '%s [ID:%s]',
    ['hold_action_success_target'] = '%s [ID:%s]',

    -- Hold Option
    ['hold_option_useweapon'] = 'ต้องถืออาวุธก่อน'
}