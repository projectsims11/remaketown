authorized = {
    "admin", -- !!important secure
    "superadmin", -- !!important secure
    "steam:xxxxxxxxx", -- ถ้าอยากให้ใครใช้ได้อีกก็เพิ่มเข้าไป แต่ไม่ต้องแอดยศ admin superadmin
}

serverCfg = {}

serverCfg["Options"] = {
    ["banSystem"] = true,
}

serverCfg["vSyncSetting"] = {
    useReplightScript = true, -- ถ้ามีสคริปซ่อมไฟปรับ true ให้เหมือนกันทั้ง server client
}



