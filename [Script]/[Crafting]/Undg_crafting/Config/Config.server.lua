Config.Category = {
   
    [1] = {
        Name = 'GENARAL',
        Items = {

            {
                Name = 'phone', -- ชื่อไอเทในการคราฟ
                Rate = 1, -- % ในการคราฟ
                Time = 5, -- เวลาในการคราฟ
                Limit = 5, -- สามารถคราฟได้กี่อันต่อ 1 รอบ
                Equipment = {'phone', true}, -- อุปกรณ์ในการคราฟ phone คือชื่อไอเทม true , false ข้างหลังจะให้ลบตอนคราฟสำเร็จไหม
                Money = {
                    ["money"] = 5000, -- เงินที่ใช้ในการตีแต่ละรอบ แนะนำให้ใส่ 1 อย่าง อยู่ในช่วงทดสอบ หากอยากใส่ 2 อย่าง
                },
                Chances = { -- ไอเทมสำเร็จเพิ่ม % ในการตี 
                    ['phone'] = 5, -- phone คือไอเทมสำหรับใช้เพิ่ม % | เลข 5 คือจะให้เพิ่มกี่ % ก็คือ 5 แนะนำให้ใส่ 1 ชิ้น
                },
                Required = { -- ของที่ใช้ในการคราฟต่างๆ
                    ['phone'] = 5,
                },
                Fail = { -- หากตีแตกจะได้รับไอเทมอะไร
                    ['phone'] = 5,
                },
                -- สำหรับ + อาวุธ หาก Protectweapon = false, ให้ใส่ Weapongetback ให้ด้วยตอนคราฟแตกมันจะโดนลบ WeaponRequired หากไม่ใส่ Weapongetback
                Protectweapon = false,
                WeaponRequired = false,
                Weapongetback = false,
            },

            {
                Name = 'stone',
                Rate = 100,
                Time = 5,
                Limit = 5,
                Equipment = {'phone', true},
                Money = {
                    ["money"] = 5000, 
                },
                Chances = {
                    ['phone'] = 5,
                },
                Required = {
                    ['phone'] = 5,
                },
                Fail = {
                    ['phone'] = 5,
                },
                Protectweapon = false,
                WeaponRequired = false,
                Weapongetback = false,
            },
        },
    },

    [2] = {
        Name = 'TOOL',
        Items = {
            {
                Name = 'bread',
                Rate = 5,
                Time = 5,
                Limit = 5,
                Equipment = {'phone', true},
                Money = {
                    ["black_money"] = 5000, 
                },
                Required = {
                    ['stone'] = 5,
                },
                Chances = {
                    ['phone'] = 5,
                },
                Fail = {
                    ['phone'] = 5,
                },
                Protectweapon = false,
                WeaponRequired = false,
                Weapongetback = false,
            },

            {
                Name = 'WEAPON_BAT',
                Rate = 1,
                Time = 5,
                Limit = 5,
                Equipment = {'bread', true},
                Money = {
                    ["money"] = 5000, 
                },
                Chances = {
                    ['phone'] = 50,
                },
                Required = {
                    ['phone'] = 5,
                },
                Fail = false;
                Protectweapon = false,
                WeaponRequired = false,
                Weapongetback = false,
            },
        },
    },
}
