Config = {}

Config["Version"] = false -- true = weight  false = limit
Config["esx_routers"] = {
    ['getSharedObject'] = 'esx:getSharedObject'
}

Config["Minigame"] = true -- กำหนดว่าจะให้มีมินิเกมไหม
Config["Failcd"] = false -- ถ้าเล่นมินิเกมพลาดจะให้ติดคลูดาวน์ไหม true = ติดคูลดาวน์ false = ไม่ติดคูลดาวน์
Config["Dif1"] = "normal"   -- ปรับระดับความยากของมินิเกมในแต่ละรอบ
Config["Dif2"] = "normal"   -- มี easy normal hard
Config["Dif3"] = "normal" -- มีถึง hard แต้แนะนำแค่ normal เพราะ hard ยากมาก

Config["Itemreq"] = false -- กำหนดสิ่งของที่จะต้องมี true = ต้องมี false = ไม่ต้องมี
Config["Item"] = 'c0' -- ไอเท็มที่กำหนด
Config["Itemreqdel"] = true -- กำหนดว่าจะให้ใช้แค่ครั้งเดียวแล้วลบไหม true = ลบ false = ไม่ลบ
Config["Itemam"] = 1 -- จำนวนที่จะให้ลบ



Config["Cops"] = 1 -- ต้องมีตำรวจเท่าไหร่ถึงจะทำได้
Config["Copalert"] = "Fewthz_policealert:alertNet" -- ใช้อันไหนเปลี่ยนเป็นอันนั้น
Config["Alertname"] = "capsule" -- ("maxez-police:alertNet", "capsule") ตัวอย่าง
Config["Phonecop"] = 'มีคนกำลังขโมยแคปซูล' -- ข้อความที่แจ้งเข้าไปในโทรศัพท์ของตำรวจ

Config["Timesteal"] = 30000 -- เวลาขโมยแคปซูล 1000 = 1 วิ 
Config["Textsteal"] = "กำลังขโมยแคปซูล" -- ข้อความที่ขึ้นตรงหลอดโหลด
Config["Progbar"] = "mythic_progbar:client:progress" -- หลอดโหลด
Config["Getitem"] = {
                        "capsulea",         
                        "capsuleb",         -- สุ่มไอเท็มที่จะได้รับอย่างใดอย่างนึง
                        "capsulec"
}
Config["Amount"] = 1,1  -- สุ่มว่าจะได้ของกี่ชิ้น 

Config["Timefreeze"] = 20000 -- กำหนดเวลาโดนแช่ขาตอนเล่นมินิเกมพลาด
Config["Textfreeze"] = "กำลังโดนแช่แข็ง" -- ข้อความที่ขึ้นตรงหลอดโหลด

Config["Text"] = '<font face="sarabun"> [~g~E~w~] ~w~ขโมยแคปซูล</font>' -- กำหนดข้อความ
Config["Textnocop"] = '<font face="sarabun"> ~r~ต้องการตำรวจ ' ..Config["Cops"]..' คน</font>'
Config["Textcantdo"] = '<font face="sarabun"> ~r~หน่วยงานไม่สามารถทำได้</font>'
Config["Textcantdo2"] = '<font face="sarabun"> ~r~คุณกำลังติดคูลดาวน์</font>'
Config["Distance"] = 5 -- ใกล้แค่ไหนถึงจะเห็นข้อความ
Config["Lt"] = 5 -- ถ้าตัวอักษรกระพริบหรือกดไม่ค่อยติดปรับตรงนี้ 

Config["Cooldown"] = 60 -- เวลาคูลดาวน์หน่วยเป็นวิ 1 นาที = 60 วิ,10 นาที = 600 วิ

Config["Pos"] = {   -- เพิ่มจุดได้เรื่อยๆ(บางพื้นที่อาจจะบัค)
    ["Pos1"] = { ["x"] = -894.69,  ["y"] = -196.84, ["z"] = 38.26},     
}

Config["Discordwebhook"] = "" -- Log ดิสคอร์ด