Config = {}
ConfigCL = {}
ConfigJs = {}
Config.Keys = {["ESC"] = 322,["F1"] = 288,["F2"] = 289,["F3"] = 170,["F5"] = 166,["F6"] = 167,["F7"] = 168,["F8"] = 169,["F9"] = 56,["F10"] = 57,["~"] = 243,["1"] = 157,["2"] = 158,["3"] = 160,["4"] = 164,["5"] = 165,["6"] = 159,["7"] = 161,["8"] = 162,["9"] = 163,["-"] = 84,["="] = 83,["BACKSPACE"] = 177,["TAB"] = 37,["Q"] = 44,["W"] = 32,["E"] = 38,["R"] = 45,["T"] = 245,["Y"] = 246,["U"] = 303,["P"] = 199,["["] = 39,["]"] = 40,["ENTER"] = 18,["CAPS"] = 137,["A"] = 34,["S"] = 8,["D"] = 9,["F"] = 23,["G"] = 47,["H"] = 74,["K"] = 311,["L"] = 182,["LEFTSHIFT"] = 21,["Z"] = 20,["X"] = 73,["C"] = 26,["V"] = 0,["B"] = 29,["N"] = 249,["M"] = 244,[","] = 82,["."] = 81,["LEFTCTRL"] = 36,["LEFTALT"] = 19,["SPACE"] = 22,["RIGHTCTRL"] = 70,["HOME"] = 213,["PAGEUP"] = 10,["PAGEDOWN"] = 11,["DELETE"] = 178,["LEFT"] = 174,["RIGHT"] = 175,["TOP"] = 27,["DOWN"] = 173,["NENTER"] = 201,["N4"] = 108,["N5"] = 60,["N6"] = 107,["N+"] = 96,["N-"] = 97,["N7"] = 117,["N8"] = 61,["N9"] = 118
}

--- การอัพเดทBlip
--- once every 5 seconds | during 256-1024 players
--- once every 4 seconds | during 128-256 players
--- once every 3 seconds | during 96-128 players
--- once every 2 seconds | during 64-96 players

---------------------- กระสุนเสกรถปรับตรงนี้ -------------------------

Config.showPlayerVehicles = true             --- true/เปิด false/ปิด แม่งใช้ไม่ได้กูจะรั่ว

Config.vehicleGunVehicle = "tankercar"       --- ชื่อรถ

-----------------------------------------------------------------

-------------------- รีเซิฟเวอร์ - ลบรถทั้งหมด -----------------------

AutoDeleteCar = function(time)
    TriggerClientEvent("Starsation_deletecar:RunNotifyDeleteVehicle", -1, time) --- นับถอยหลังลบรถ / เชื่อม Event ลบรถของสคริปนั้นๆ
end

AutoReserver = function(time)
    TriggerClientEvent("Starsation_deletecar:RunNotifyRestartServer", -1, time) --- นับถอยหลังรีเซิร์ฟ / เชื่อม Event รีเซิร์ฟของสคริปนั้นๆ
    TriggerClientEvent("Starsation_autorestart:RunNotifyRestartServer", -1, time)
end

CancelAutoDeleteCar = function()
    TriggerClientEvent("Starsation_deletecar:CancelDeleteCar", -1)              --- ยกเลิกการลบรถทั้งหมด / เชื่อม Event ลบรถของสคริปนั้นๆ
end

CancelAutoReserver = function()
    TriggerClientEvent("Starsation_deletecar:CancelNotifyRestartServer", -1)    --- ยกเลิกรีเซิร์ฟ / สำหรับคนที่ใช้ 2 สคริปเพื่อปิด Cmd - รีเซิร์ฟ ให้เชื่อม Event ทั้งคู่ / สำหรับคนใช้สคริปเดียว ให้เชื่อมอันเดียวพอ อีกอันชั่งแม่ง
    TriggerClientEvent("Starsation_autorestart:CancelNotifyRestartServer", -1)  --- ตัวอย่าง Event ของใครบ้างคนเป็นแบบนี้ RegisterNetEvent(script_name .. ':CancelNotifyRestartServer') --- / ให้นำชื่อโฟลเดอร์สคริป มาใช้แทน  - ต่อ    
end                                                                             --- ตัวอย่างการเชื่อมที่ถูกต้อง TriggerClientEvent("ชื่อโฟลเดอร์สคริป:CancelNotifyRestartServer", -1) บลาๆๆๆๆ ตามที่เชื่อมไว เชื่อมไม่ได้อันนั้นก็เรื่องของมึงแล้ว 

-----------------------------------------------------------------

------------------------ ตั้งค่า โชว์ชื่อบนหัว -------------------------

Config.SettingSystem = {
    KeyOpen = 'HOME',                   --- เมนู HOME
    KeyNoclip = 'CAPITAL', 
    KeyNoclipSpeed = 'LSHIFT', 
    WeatherandBlackOut = true,          --- ระบบอากาศและปิดไฟของเมือง
    Bansystem = true                    --- ระบบแบน
}

-----------------------------------------------------------------

------------------------ ตั้งค่า Noclip ----------------------------

Config.Noclip = {
    { text = 'ช้า' , speed = 0.1},
    { text = 'ปกติ' , speed = 0.5},
    { text = 'เร็ว' , speed = 2},
    { text = 'เร็วมาก' , speed = 4},
}

-----------------------------------------------------------------

----------------------- ตั้งค่า โชว์ชื่อบนหัว --------------------------

Config.SettingDisplayOnlyAdmin = {  --- กำหนดชื่อบนหัว
    Distance = 1000.0,              --- ระยะห่าง
    DrawText = true,                --- ข้อความบนหัว
    Scale = 1.0,                    --- ขนาดข้อความ
    Health = true                   --- โชว์เลือด
}

------------------------------------------------------------------

----------- ต้องเปิด WeatherandBlackOut หากจะใช้งาน -----------------

Config.DynamicWeather = true        --- เปลี่ยนสภาพอากาศอัตโนมัติ
Config.NewWeatherTimer = 60         --- ระยะเวลาในการเปลี่ยนสภาพอากาศ
Config.Blackout = false             ---  ตั้งค่าเริ่มต้น เปิด/ปิด ไฟในเมือง
Config.StartWeather = 'EXTRASUNNY'  --- สภาพเริ่มต้นเมื่อเปิดเซิฟ
Config.BaseTime = 2000              --- เวลาเริ่มต้นเมื่อเปิดเซิฟ

------------------------------------------------------------------

--------------------------- เชื่อมกระเป๋า ----------------------------

ConfigCL["Inventory"] = function(data)                 --- เปิดกระเป๋า
    TriggerEvent("esx_inventoryhud:openPlayerInventory", data.playerid, '') 
    --exports.nc_inventory:SearchInventory(data.playerid, 'admin') --- ตัวอย่างการเชื่อมกระเป๋า NC Inventory
    SetDisplay(false)
end


------------------------------------------------------------------

---------------------------- เชื่อมสกิน -----------------------------

ConfigCL["SetSkin"] = function(data)
    TriggerEvent('esx_skin:openSaveableMenu', source)   --- ตัวอย่าง / รีสกินผู้เล่น ไม่ใช่ รีสกินตัวผู้ใช้คำสั่ง
end

------------------------------------------------------------------

---------------------------- ลบ Prop -----------------------------

ConfigCL["DeleteProp"] = {
    "prop_boxpile_07d",
}

------------------------------------------------------------------

--------------------- Effect เปลี่ยนอวาต้าสกิน -----------------------

Config.dict2 = "proj_indep_firework"                    --- หมวดหมู่
Config.particleName2 = "scr_indep_firework_grd_burst"   --- Effect

-----------------------------------------------------------------

---------------------- เปลี่ยนอวาต้าสกิน ----------------------------

Config.PedModel = {
    {model = 'a_c_westy',label = "westy"},
}

-----------------------------------------------------------------

------------------ ตั้งค่าความสามารถของแต่ละยศ ----------------------

Config.Perms = {
    ["admin"] = {
        CanPed = true,
        CopySkin = true,
        CanKick = true,
        CanBanTemp = true,
        CanBanPerm = true,
        CanUnban = true,
        CanAddCash = true,
        CanAddBlack = true,
        CanAddBank = true,
        CanGodmode = true,
        CanOpenPlayerInventory = true,
        CanGiveItem = true,
        CanTpWp = true,
        CanTeleport = true,
        CanSpectate = true,
        CanFreeze = true,
        CanSlay = true,
        CanPromote = true,
        CanGiveWeapon = true,
        CanNoClip = true,
        CanSpawnVehicle = true,
        CanAnnounce = true,
        CanSetJob = true,
        CanSetTime = true,
        CanRevive = true,
        CanChangeTime = true,
        CanFreezeTime = true,
        CanChangeWeather = true,
        CanBlackout = true,
        CanFreezeWeather = true,
        SavePlayerAll = true,
        SavePlayer = true,
        healspecific = true,
        reviveall = true,
        killall = true,
        freezeall = true,
        bringall = true,
        godall = true,
        speedrunall = true,
        jumeperall = true,
        staminagodall = true,
        speedrun = true,
        jumeper = true,
        staminagod = true,
        delcarall = true,
        restartserver = true,
        healall = true,
        addhunger = true,
        removestress = true,
        ClearInventory = true,
        revivedist = true,
        canceldelcarall = true,
        cancelrestartserver = true,
        ClearWeawpon = true,
        arall = true,
        Propall = true,
        clearcarkey = true
    },
    ["mod"] = {
        CanPed = true,
        CopySkin = true,
        CanKick = true,
        CanBanTemp = true,
        CanBanPerm = true,
        CanUnban = true,
        CanAddCash = true,
        CanAddBlack = true,
        CanAddBank = true,
        CanGodmode = true,
        CanOpenPlayerInventory = true,
        CanGiveItem = true,
        CanTpWp = true,
        CanTeleport = true,
        CanSpectate = true,
        CanFreeze = true,
        CanSlay = true,
        CanPromote = true,
        CanGiveWeapon = true,
        CanNoClip = true,
        CanSpawnVehicle = true,
        CanAnnounce = true,
        CanSetJob = true,
        CanSetTime = true,
        CanRevive = true,
        CanChangeTime = true,
        CanFreezeTime = true,
        CanChangeWeather = true,
        CanBlackout = true,
        CanFreezeWeather = true,
        SavePlayerAll = true,
        SavePlayer = true,
        healspecific = true,
        reviveall = true,
        killall = true,
        freezeall = true,
        bringall = true,
        godall = true,
        speedrunall = true,
        jumeperall = true,
        staminagodall = true,
        speedrun = true,
        jumeper = true,
        staminagod = true,
        delcarall = true,
        restartserver = true,
        healall = true,
        addhunger = true,
        removestress = true,
        ClearInventory = true,
        revivedist = true,
        canceldelcarall = true,
        cancelrestartserver = true,
        ClearWeawpon = true,
        arall = true,
        Propall = true,
        clearcarkey = true
    }
}

-----------------------------------------------------------------

-------------------- รถที่เสกได้โดยแอดมิน ---------------------------

Config.Vehicles = {
    {model = "thrax", label = "Thrax"},

    -- ไปหาลงมอดถ้าจะใช้
    -- {model = "eg6", label = "3 ควย"},
    -- {model = "rmodrs6", label = "Audi Rs6"},
    -- {model = "babycar", label = "รถเด็กน้อย"},
    -- {model = "babywalker", label = "รถเข็นเด็กเอ๋อ"},
    -- {model = "thruster4", label = "ปีก"},
    -- {model = "cat_car", label = "รถโลแมว กาชา"},
    -- {model = "c8rb", label = "Chevrolet C8"},
    -- {model = "fk8", label = "Civic Type R"},
    -- {model = "f8t", label = "Ferrari488"},
    -- {model = "huracantecnica", label = "Lamborghini Huracán"},  
    -- {model = "jeepscc", label = "รถกบ"},
    -- {model = "rmodlego3", label = "เล่นเลโก้แล้วหลอน"},
    -- {model = "bnr34", label = "Nissanr34"},
    -- {model = "r35", label = "Nissanr35"},
    -- {model = "rmodz350pandem", label = "Nissanr Z350"},
    -- {model = "RufusVanquish", label = "RGB หลอนๆ"},
    -- {model = "cartoydv", label = "รถการ์ตูน"},
    -- {model = "tug", label = "เรือซิ่ง"},
    -- {model = "rmodsianr1", label = "ห้ามใช้"},
    -- {model = "karby", label = "ตัวอะไรก็ไม่รู้"},
    -- {model = "jcm4", label = "3000 HP BMW M3 ADMIN CAR"},
    -- {model = "CHRISTMASMOBILE", label = "เรนเดียร์"},
    -- {model = "urus", label = "LamborghiniUrus"},
    -- {model = "17xmax", label = "รถเด็กแว้น"},
    -- {model = "125itxps", label = "เวฟ ตรอ. ทรงแว้น"},
    -- {model = "rmodm4", label = "BMW M4 4500 HP"},
    -- {model = "faggio", label = "เด็กแว้นยุค 90 s"},
    -- {model = "speeder2", label = "วิ่งเฉพาะในคลอง"},
}


Config['ServerLogs'] = {
    LogsAddWeaponToOther = function(source , name , Nametarget , weapon)
        local sendToDiscord = '' .. name .. ' เพิ่มปืนให้ตัวเอง ' .. Nametarget .. ' อาวุธ '..weapon
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    end,
    LogsAddWeaponToMe = function(source , name , Nametarget , weapon)
        local sendToDiscord = '' .. name .. ' เพิ่มปืนให้ตัวเอง ' .. Nametarget .. ' อาวุธ '..weapon
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    end,
    LogsAddItem = function(source , name , Nametarget , item , amount)
        local sendToDiscord = '' .. name .. ' ให้ของกับ '..Nametarget.. ' ไอเทม '..item.. ' จำนวน '..amount
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    end,
    LogsAddCash = function(source , name , Nametarget , amount)
        local sendToDiscord = '' .. name .. ' เพิ่มเงิน '..Nametarget.. ' จำนวน '..amount
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    end,
    LogsAddBlackmoney = function(source , name , Nametarget , amount)
        local sendToDiscord = '' .. name .. ' เพิ่มเงิน '..Nametarget.. ' จำนวน '..amount
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    end,
    LogsAddBank = function(source , name , Nametarget , amount)
        local sendToDiscord = '' .. name .. ' เพิ่มเงินธนาคาร '..Nametarget.. ' จำนวน '..amount
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    end,
    LogsKickPlayer = function(source , name , Nametarget )
        local sendToDiscord = '' .. name .. ' เตะผู้เล่น '..Nametarget
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    end,
    LogsKickAllPlayer = function(source , name)
        local sendToDiscord = '' .. name .. ' เตะผู้เล่นทั้งหมด '
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    end,
    LogsBanPlayer = function(source , name , Nametarget)
        local sendToDiscord = '' .. name .. ' แบนผู้เล่น '..Nametarget
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    end,
    LogsAddgroup = function(source , name , Nametarget)
        local sendToDiscord = '' .. name .. ' ตั้งยศแอดมินกับ '..Nametarget
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    end,
    LogsAnnouncement = function(source , name , message)
        local sendToDiscord = '' .. name .. ' ประกาศ '..message
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    end,
    LogsTeleport = function(source , name , Nametarget)
        local sendToDiscord = '' .. name .. ' ใช้ วาปกับ '..Nametarget
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    end,
    LogsHealAll = function(source , name)
        local sendToDiscord = '' .. name .. ' ใช้ healall '
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    end,
    LogsHealPlayer = function(source , name , Nametarget)
        local sendToDiscord = '' .. name .. ' ใช้ heal ให้กับ '..Nametarget
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    end,
    LogsReviveAll = function(source , name)
        local sendToDiscord = '' .. name .. ' ใช้ reviveall'
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    end,
    LogsFixcar = function(source , name)
        local sendToDiscord = '' .. name .. ' ใช้ fix'
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    end,
    LogsHijeck = function(source , name)
        local sendToDiscord = '' .. name .. ' ใช้ hij'
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    end,
    LogsBring = function(source , name , Nametarget)
        local sendToDiscord = '' .. name .. ' ได้ดึงผู้เล่นเข้าหาตัว ' ..Nametarget
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    end,
    LogsDeleteCarAll = function(source , name)
        local sendToDiscord = '' .. name .. ' ลบรถทั้งหมด'
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    end,
    LogsCancelDeleteCarAll = function(source , name)
        local sendToDiscord = '' .. name .. ' ยกเลิกการลบรถทั้งหมด'
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    end,
    LogsRestart = function(source , name , Nametarget)
        local sendToDiscord = '' .. name .. ' รีเซิฟเวอร์'
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    end,
    LogsCancelRestart = function(source , name , Nametarget)
        local sendToDiscord = '' .. name .. ' ยกเลิกการรีเซิฟเวอร์'
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    end,
    LogsGiveAllItem = function(source , name , item , amount)
        local sendToDiscord = '' .. name .. ' ได้รับ ' .. item .. ' จำนวน ' .. amount .. ' (แอดมินใช้คำสั่งผ่าน MenuAdmin)'
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^2')
    end,
    LogsKillAll = function(source , name , Nametarget)
        local sendToDiscord = '' .. name .. ' ได้ฆ่าผู้เล่น ' ..Nametarget
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    end,
    LogsGodMode = function(source , name)
        local sendToDiscord = '' .. name .. ' เปิด God '
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    end,
    LogsFreeze = function(source , name , Nametarget)
        local sendToDiscord = '' .. name .. ' ได้แช่แข็ง ' ..Nametarget
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    end,
    LogsUnBan = function(source , name , license)
        local sendToDiscord = '' .. name .. ' ได้ปลดแบน ' ..license
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    end,
    LogsSetjob = function(source , name , Nametarget, job)
        local sendToDiscord = '' .. name .. ' ตั้งหน่วยงานให้กับ '..Nametarget..' เป็น ' ..job.. ' '
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    end,
    LogsRevive = function(source , name , Nametarget)
        local sendToDiscord = '' .. name .. ' ใช้ revive '..Nametarget
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    end,
    LogsAddHunger = function(source , name , Nametarget , percent)
        local sendToDiscord = '' .. name .. ' ให้หลอดอาหาร '..Nametarget .. " จำนวน " .. percent
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    end,
    LogsRemoveStress = function(source , name , Nametarget , percent)
        local sendToDiscord = '' .. name .. ' ให้หลอความเคลียด '..Nametarget .. " จำนวน " .. percent
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    end,
    LogsAddHungerRemoveStress = function(source , name , Nametarget)
        local sendToDiscord = '' .. name .. ' ปรับให้หลอด '..Nametarget .. " เต็ม "
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    end,
    LogsReviveDist = function(source , name)
        local sendToDiscord = '' .. name .. ' ใช้ revivedist '
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    end,
}