--------------------------------------------
--------------------------------------------
--  Script    : UI - Item Notifications   --
--  Developer : Azael Dev 	              --
--  Website   : www.azael.dev             --
--  Facebook  : www.fb.com/AzaelDev.78    --
--------------------------------------------
--------------------------------------------

Config = {}

Config['script_token'] = 'k7K6hyJ8AL'         -- ระบุ Token ของ Script ดูได้ที่ https://www.azael.dev/dashboard/digishop/

Config['esx_routers'] = {								-- เส้นทางกิจกรรมของทรัพยากร ESX Framework
	['server_shared_obj'] = 'esx:getSharedObject',		-- หาก es_extended เซิร์ฟเวอร์ของคุณ มีการแก้ไขชื่อกิจกรรมของทรัพยากร เพื่อป้องกันโปรแกรมโกงต่าง ๆ
	['client_shared_obj'] = 'esx:getSharedObject'		-- คุณสามารถแก้ไขการตั้งค่าในส่วนนี้ให้ตรงกับชื่อกิจกรรมของทรัพยากรนั้น ๆ ได้
}                                                       -- หมายเหตุ: ห้ามแก้ไขการตั้งค่าในส่วนนี้โดยเด็ดขาด หากคุณไม่เข้าใจว่าสิ่งนี้คืออะไร เพราะอาจจะทำให้ทรัพยากรเกิดข้อผิดพลาดได้

Config['timeout'] = 5                        -- เวลาในการแสดง UI เป็นวินาที
Config['maximum'] = 5                        -- จำนวนการแสดง UI สูงสุด
Config['position'] = 'bottomRight'           -- ตำแหน่งในการแสดง UI (bottomCenter = กลางล่าง | bottomRight = ขวาล่าง)

Config['ammo'] = 'Ammo'                      -- ชื่อที่ใช้ในการแสดงแทน ลูกกระสุน
Config['money'] = 'Cash'                     -- ชื่อที่ใช้ในการแสดงแทน เงินสด
Config['bank'] = 'Bank Money'                -- ชื่อที่ใช้ในการแสดงแทน เงินในธนาคาร
Config['black_money'] = 'Dirty Money'        -- ชื่อที่ใช้ในการแสดงแทน เงินผิดกฏหมาย

Config['inventory_image'] = true           -- เปิดใช้งาน รูปภาพจากกระเป๋า หรือไม่? (true = ใช้งานรูปภาพจากกระเป๋า | false = ใช้งานรูปภาพของทรัพยากร)
Config['inventory_link'] = 'Fewthz_inventory/html/img/items'                -- ระบุ ลิงก์ที่อยู่รูปภาพของกระเป๋าที่ต้องการใช้งาน
