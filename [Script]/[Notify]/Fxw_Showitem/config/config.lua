Config = {}

Config.URL_NUI_Images = "nui://Fewthz_inventory/html/img/items" -- ที่อยู่ของรูปภาพไอเทม (กำหนดตามสคิปกระเป๋าที่ใช้อยู่)
Config.TimeOut = 5000 * 1000 -- กำหนดเวลาให้แจ้งเตือนหาย (ตัวอย่างนี้ตั้งไว้ 2วินาที)

-- ตำแหน่งการแสดงแจ้งเตือน (มีให้เลือก 2 รูปแบบ)
-- layout-uptodown = บนลงล่าง | -- layout-downtoup = ล่างขึ้นบน
Config.Layout = 'layout-downtoup'

Config.WeaponUse_Notify = true -- true = แจ้งเตือนเมื่อใช้อาวุธ

-- Prefix
Config.Prefix = {
    added = 'Added',
    remove = 'Removed',
    use_weapon = 'Use'
}

-- สำหรับคนที่ใช้ es_extended ตัวใหม่ตั้งค่า Config.es_extended_old = false เพื่อปิดใช้งานในส่วนที่ไม่จำเป็น
Config.es_extended_old = true