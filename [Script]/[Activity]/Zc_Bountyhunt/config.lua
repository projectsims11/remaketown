Config = {}
Config.framework = 'esx:getSharedObject'
------------------------------------------------------------------
--  การตั้งเวลาออโต้ ใช้สคริป Zc_AutoEventx มีแถมไป -------
--- ใช้ชื่ออีเว้น
------------------------------------------------------------------
Config['คำสั่งสุ่มล่าค่าหัว'] = 'bounty' -- สุ่มล่าค่าหัว
Config['คำสั่งระบุล่าค่าหัว'] = 'bountyx' -- ระบุค่าหัว  /bountyx ไอดี วินาที ราคาหัว
Config['คำสั่งยกเลิก'] = 'stopx'
Config['เวลาล่าค่าหัว'] = 600 ---- วินาที
Config['ค่าหัว'] = {500, 4000} ---- ค่าหัว
-------------------------------------------------------------------
-------------------------------------------------------------------
Config['แบล๊คลิสจ๊อบ'] = { --- ไม่ให้โดนล่า
--    'police', 'ambulance', 'gouvernment', 'offpolice','offambulance', 'offgouvernment'
}
-------------------------------------------------------------------
Config['ข้อหา'] = {
    [1] = {
        header = "<font face='font4thai'>คอมกากพาหน่วง</font>",
        pic = 'skull1'
    },
    [2] = {
        header = "<font face='font4thai'>ทำผิดกฎประเทศ</font>",
        pic = 'skull2'
    },
    [3] = {
        header = "<font face='font4thai'>เพ้อเจ้อ</font>",
        pic = 'skull3'
    },
    [4] = {
        header = "<font face='font4thai'>น่ารักเกินไป</font>",
        pic = 'skull4'
    },
    [5] = {
        header = "<font face='font4thai'>น่ารักเกินไป</font>",
        pic = 'skull3'
    },
    [6] = {
        header = "<font face='font4thai'>น่ารักเกินไป</font>",
        pic = 'skull2'
    }

}
-------------------------------------------------------------------
Config['แบล๊คลิสโซน'] =
    { --- โซนที่ไม่อยากให้สุ่มเช่นบ้านแก๊งค์, SafeZone , Afk
        -- [1] = {
        --     coords = vector3(1708.548828125, 6408.18359375, 33.246089935303),
        --     radius = 30.0
        -- },
        -- [2] = {
        --     coords = vector3(1940.8619384766, 6328.96875, 43.060764312744),
        --     radius = 30.0
        -- }
    }



Config['ขนาดมาร์คเกอร์'] = 1.5 ------ ขนาดมาร์คเกอร์ (เลขจำเป็นต้องมีทศนิยม)
Config['ระยะมองเห็นมาร์คเกอร์']  = 50 ---- ระยะมองเห็นมาร์คเกอร์
-------------------------------------------------------------------
Config['ห้ามขึ้นรถ'] =  false  ------------- ถ้าเปิดไว้คนติดต่าหัวจะขึ้นรถไมไ่ด้ 
Config['ชุบถ้าตายเอง'] = true  ------- ถ้าไม่ชุบแล้วคนโดนล่าตายเอง ผู้เล่นอื่นต้องชุบมาฆ่าใหม่ 
Config['เลือดที่จะให้เพิ่มถ้าตายเอง']  = 110 ----- เต็ม 200 / 100 คือตาย
Config['ห้ามลงน้ำ']  = true 
Config['บัฟพิเศษ'] = false ---- ให้บัฟพิเศษ ฮีล / สตามิน่าไม่ลด 
Config['เวลาให้บัฟ'] = 10 -- ให้ทุกๆกี่วินาที
Config['บัฟรถชนไม่ตาย'] = true ---- ให้บัฟรถชนไม่ตาย
Config['ดีบัคบัฟรถชน'] = 10 -- millisec-- Wait Debug ถ้าเซิฟไหนเปิดแล้วยังชนตาย ให้ลดเลขลง (ยิ่งเลขต่ำ rm ยิ่งเยอะ)

Config["ของรางวัล"] = {
    [1] = {ItemName = 'stone_a', Count = {1, 3}, Percent = 100},
    [2] = {ItemName = 'stone_a', Count = {1, 3}, Percent = 100}
}

function svItemlog(xPlayer, ItemName, Count) --- log ของรางวัล
    ---- ใส่โค้ดที่นี่ ------

end
function svlog(xPlayer, bountyprice) --- log เงิน
    ---- ใส่โค้ดที่นี่ ------

end

function notify(sms, time) --------แจ้งเตือน
    TriggerEvent('pNotify:SendNotification', {
        text = sms,
        type = 'error',
        timeout = time,
        layout = 'BottomCenter',
        queue = 'left'
    })
end

----------------- DEBUG MODE ---------------------------------------
--------------------------- ตัวใหม่ Config['ความไวบลิปในแมพ'] = 1 ตั้ง 1 วิได้เลย ----------
Config['ความไวบลิปในแมพ'] = 1 -------- อัพเดทบลิปทุกกี่วินาที  ยิ่งเลขน้อย บลิปยิ่งติดตัวลื่นขึ้นในแมพ แต่กิน Resmon SV
Config['มาร์คเกอร์บนหัว'] = 10 ---- ความไวของมาร์คเกอร์ ในการเกาะติดหัวผู้เล่น ยิ่้งเลขน้อยยิ่งสมูท แต่กิน Resmon
Config['มาร์คเกอร์กระพริบ'] = 4 ---- ยิ่้งเลขน้อย จะไม่กระพริบ แต่กิน Resmon

