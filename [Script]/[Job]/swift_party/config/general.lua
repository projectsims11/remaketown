config = config or {}
config.framework = "esx"

config.network = {
    softLoad = true -- เมื่อโหลดข้อมูลปาร์ตี้เมื่อเข้าเซิฟเวอร์ครั้งแรกจะค่อยๆโหลดข้อมูล (false = โหลดข้อมูลทันที กินทรัพยากรสูงกว่า)
}

config.userInterface = {
    commandEnabled = true,
    command = "swift:internal:party",
    keybindEnabled = true, -- ui.commandEnabled ต้องเป็น true ถึงจะใช้ได้
    keybind = "F4"
}

config.requireItem = false -- ต้องการใช้ไอเทมเพื่อเปิด UI หรือไม่
config.item = "" -- ชื่อไอเทม

config.onChattedSound = true -- เปิดเสียงเมื่อ เรา หรือ ฝ่ายตรงข้ามพิมพ์ข้อความ
config.volume = {
    chat_self = 0.1,
    chat_opponent = 0.1,
    clickVolume = 0.15,
    typeVolume = 0.1
}

config.party = {
    timerSettings = {
        [1] = 0, -- หากจำนวนคนในปาร์ตี้เท่ากับ 1 คน จะลบเวลาฟาร์มเดิมเท่าไหร่ (ตัวอย่าง 6000 - 0 = 6000)
        [2] = 1500, -- หากจำนวนคนในปาร์ตี้เท่ากับ 2 คน จะลบเวลาฟาร์มเดิมเท่าไหร่ (ตัวอย่าง 6000 - 250 = 5750)
        [3] = 2000, -- หากจำนวนคนในปาร์ตี้เท่ากับ 3 คน จะลบเวลาฟาร์มเดิมเท่าไหร่ (ตัวอย่าง 6000 - 500 = 5500)
        [4] = 2500,
        [5] = 3000,
 
    }, -- จะเพิ่มกี่คนก็ได้ ไม่จำกัด

    minimumTimer = 1000, -- สามารถลดเวลาได้ต่ำสุดเท่าไหร่ (ตัวอย่าง 6000 - 3000 = 3000 ระบบจะเซ็ตให้เป็น 4000 แทน)
    maxPlayers = 5, -- จำกัดจำนวนคนในปาร์ตี้
    startStopCooldown = 1000, -- ดีเลย์ในการกดเริ่มปาร์ตี้ / หยุดปาร์ตี้
    chatCooldown = 1000, -- ดีเลย์การพิมพ์ข้อความ
    fullNameOnChat = false, -- โชว์ชื่อ-นามสกุลของผู้เล่นเวลาพิมพ์แชท (false = โชว์แค่ชื่อ)
    maxMessageLength = 256, -- ความยาวสูงสุดของข้อความที่สามารถพิมพ์ได้
    maxMessages = 100, -- จำนวนข้อความที่จะโชว์ได้สูงสุดในแชท (เช่นข้อความเกิน 100 ข้อความ ระบบจะลบอันที่เก่าที่สุดออก)
}

config.partyCreation = {
    maxParties = 80, -- จำกัดสร้างได้สูงสุดกี่ปาร์ตี้
    minName = 2, -- ความยาวขั้นต่ำของชื่อห้อง
    maxName = 32, -- ความยาวสูงสุดของชื่อห้อง
    minPassword = 2, -- ความยาวขั้นต่ำของรหัสห้อง
    maxPassword = 8 -- ความยาวสูงสุดของรหัสห้อง
}

config.matchMaking = {
    forceOpenWhenMatchFound = true, -- บังคับเปิดเมนู เมื่อหาห้องเจอแล้ว
    minPlayers = 3, -- ต้องการผู้เล่นกี่คนถึงจะสร้างปาร์ตี้
    matchInternal = 5000 -- ระยะเวลาที่จะ loop เช็คผู้เล่นในคิว
}