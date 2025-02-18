--===== FiveM Script =========================================
--= DB - Health and Armor
--===== Developed By: ========================================
--= Azael Dev
--===== Website: =============================================
--= https://www.azael.dev
--===== License: =============================================
--= Copyright (C) Azael Dev - All Rights Reserved
--= You are not allowed to sell this script or edit
--============================================================ 

Config = {}

Config['script_token'] = 'Token Key'        				-- ระบุ Token ของ Script ดูได้ที่ https://www.azael.dev/dashboard/digishop/

Config['esx_routers'] = {									-- เส้นทางกิจกรรมของทรัพยากร ESX Framework
	['server_shared_obj'] = 'esx:getSharedObject',			-- หาก es_extended เซิร์ฟเวอร์ของคุณ มีการแก้ไขชื่อกิจกรรมของทรัพยากร เพื่อป้องกันโปรแกรมโกงต่าง ๆ
	['server_player_load'] = 'esx:playerLoaded'				-- คุณสามารถแก้ไขการตั้งค่าในส่วนนี้ให้ตรงกับชื่อกิจกรรมของทรัพยากรนั้น ๆ ได้
}															-- หมายเหตุ: ห้ามแก้ไขการตั้งค่าในส่วนนี้โดยเด็ดขาด หากคุณไม่เข้าใจว่าสิ่งนี้คืออะไร เพราะอาจจะทำให้ทรัพยากรเกิดข้อผิดพลาดได้
