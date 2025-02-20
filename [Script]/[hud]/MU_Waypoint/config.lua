--[[
==================================================================================														  
	Admin Support : MU Developer
	DISCORD : https://discord.gg/9EEHzq5CrU
==================================================================================		
]]	

Config = {}

mu = {
    id = 1,  -- https://docs.fivem.net/docs/game-references/markers/ รูปแบบmarkersที่ใช้งาน
    scale = 5.0, -- การมองเห็น
    rgb = {r = 0, g = 143, b = 255, a = 200},  --สีmarkersที่ใช้งาน
    height = 130.0 --ความสูง ค่าเดิมดีอยู่แล้ว
}

Config.MU_Enabled_Disabled = {
    MU_TextureEnabled = false, -- true เปิดใช้ markers แบบlogo กำหนดเอง /-- false ปิดใช้ markers แบบlogo กำหนดเอง 
    textureDict = 'mu', --ชื่อ markers ต้องตรงกัน
    textureName = 'mu', --ชื่อ markers ต้องตรงกัน
    textureMarkerScale = 15.0, -- ระยะ markers
    textureHeight = 34.0 -- -- ความสูง markers
}
