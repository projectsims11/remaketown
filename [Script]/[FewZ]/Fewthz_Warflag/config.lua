
Config = {}

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}





--[[
-- คำสั่ง

เปิด /flag
ปิด /stopflag

]]

Config['SpawnFlagDead']          = true                                   -- ตายแล้วธงดรอปที่ตาย
Config['EnableStartFlagAuto']    = true                                   -- เปิดออโต้
Config['StartTime']              = {"09:30","12:30","15:30","19:30","02:45"}      -- ตั้งเวลาอย่าให้คาบเกี่ยว


Config['Priceheal'] = 10

-- พิกัดธง
Config['FirstFlagSpawn'] = vector3(-1599.8699951171875, -1542.489990234375, 8.93000030517578)
Config['FlagPoint'] = {
    {
        x= -1599.8699951171875, y= -1542.489990234375, z= 8.93000030517578
    }
}

-- จุดฮิล
Config['FlagHealPoint'] = {
    {
        x= -1637.69995117187, y= -1565.0400390625, z= 11.89000034332275
    }
}
Config['SpawnPlayer'] = vector3(-1639.5699462890625, -1566.18994140625, 11.89000034332275)  -- SpawnPlayer ตอนเกิด 


Config['EventDuration'] = 20 -- นาที เวลาทั้งเกม
Config['HoldFlag']      = 4  --นาที เวลาที่คนถือธงจนชนะ


Config['RandomWinnerReward'] = 0 -- สุ่มจำนวนรางวัล -- 0 ได้ทั้งหมด
Config['WinnerRewards'] = { -- ของรางวัลสำหรับคนชนะ type = black_money/ money/ weapon/ item
{ type = "money" , amount = 5000},
{ type = "black_money" , amount = 1000},
{ type = "item" , id = "Box_1", amount = 1},
{ type = "item" , id = "Box_2", amount = 1}
--{ type = "item" , id = "fashion_coin", amount = 20},
--{ type = "item" , id = "steelbar", amount = 1},n
--{ type = "item" , id = "Blueprint", amount = 1}
}


Config['HoldFlagName']  = "ไม่มีผู้ถือธง"   -- ข้อความบนสกอร์หากไม่มีคนถือธง
Config['Distance']      = 60                     -- ขอบเขต    
Config['DistanceCheck'] = 3.0                    -- ระยะการกดฮิล


Config['Control'] = {
    
    ['Capture']   = 38,  -- ปุ่มเก็บธง
    ['Press']     = "Press ~g~[E]~w~ To Capture ~r~The Flag",

    ['Heal']      = 38,   -- ปุ่มฮิล
    ['Txtheal']   = "[~g~E~w~] ~g~Heal"

}



Config['Progbar'] ={
    --- เก็บธง
    ['Time']      = 5000,
    ['Label']     = "กำลังยึดธง",
    ['animDict']  = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
    ['anim']      = "machinic_loop_mechandplayer",

    -- เกิด
    ['Time2']     = 7000,
    ['Label2']     = "ผีมือยังไม่ถึงขั้นเอาไหม่",

    -- รักษา
    ['Time3']      = 5000,
    ['Label3']     = "ชาจพลัง",
    ['animDict2']  = "ac_ig_3_p3_b-4",
    ['anim2']      = "w_ar_assaultrifle^1-4",
}


------- Blip --------
Config['Blip']={

    ['Sprite']     = 419,            -- Type Blip
    ['Colour']     = 24,             -- สีBlip
    ['Scale']      = 1.0,            -- ขนาดBlip
    ['Name']      = "WAR FLAG",  -- ชื่อBlip
    

}


------- วงในแมพ --------
Config['BlipRadius'] = {     
		['blip'] = {
            ['Radius'] = 60.0,
            ['Colour'] = 5
        },
}

------- Marker --------
Config['Markerheal'] = {
  
    ['Type']      = 28,

    -- การหันทิศทาง
    ['X']         = -90, 
    ['Y']         = -90,

    -- ขนาด
    ['vx']        = 2.0, 
    ['vy']        = 2.0, 
    ['vz']        = 2.5, 

    --- สี
    ['R']         = 103,
    ['G']         = 240,
    ['B']         = 76,

    -- ความหนาวง
    ['Thickness'] = 100,
    
    -- ระยะการมองเห็น
    ['Distance'] = 10.0,  -- Marker
    ['Txt']      = 10.0,  -- ข้อความ 


}


Config['DrawColerall'] = {
    --- สี Marker ธงบนหัว RGB
    ['King'] = {
        
        ['R'] = 255,
        ['G'] = 0,
        ['B'] = 0,

    },
    --- สี Marker จุดธง RGB
    ['Point'] = {

        ['R'] = 255,
        ['G'] = 0,
        ['B'] = 0,

    }      

}

