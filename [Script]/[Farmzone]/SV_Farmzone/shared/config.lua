Config = {}

Config.Money = 0 -- เงินที่ต้องการให้เสีย
Config.Position = {
    ["1"] = {   -- เหมือง  2956.4343, 2843.1965, 46.1879, 107.5033
        Distance = 100.0, 
        SpawnPoint = {x=2955.5674,y= 2848.0281, z=47.0341, h =107.5033},  -- เรียกรถคืน
        OpenTrunk = {
            Pos = {x = 2961.51, y = 2818.67, z = 43.39},-- NPC
            Model   =  "", -- A_M_M_Hillbilly_01
            Heading = 107.5033,
            Distance = 5.0
        },
        StoreVehicle = {
            Pos = {x = 2947.8, y = 2789.16, z = 40.64},  -- วงเก็บรถ
            DrawMark = {
                Type = 28,
                Hide = true,            -- เปิด-ปิด การแสดงวง // true คือเปิดใช้งาน ** ถ้าเปิดใช้งาน Resmon จะเพิ่มขึ้นนิดหนึ่ง
                Color = 1,	            -- สีของ DrawMark
                Radius = 00.0,         -- ขนาดของวง DrawMark
                Bold = 100,	            -- ความเข้มวง DrawMark
                R = 139,                -- CODE สีของวง DrawMark
                G = 210,                 -- CODE สีของวง DrawMark
                B = 236                  -- CODE สีของวง DrawMark
            },
        }, 
        LeaveVehicle = {
            Pos = {x = 2947.8, y = 2789.16, z = 40.64},  -- วงเก็บรถ
            DrawMark = {
                Type = 28,
                Hide = true,            -- เปิด-ปิด การแสดงวง // true คือเปิดใช้งาน ** ถ้าเปิดใช้งาน Resmon จะเพิ่มขึ้นนิดหนึ่ง
                Color = 1,	            -- สีของ DrawMark
                Radius = 25.0,         -- ขนาดของวง DrawMark
                Bold = 100,	            -- ความเข้มวง DrawMark
                R = 139,                -- CODE สีของวง DrawMark
                G = 210,                 -- CODE สีของวง DrawMark
                B = 236                  -- CODE สีของวง DrawMark
            },
        }
    },

    ["2"] = {   -- ส้ม 337.0147, 3571.4290, 33.3405, 217.9512
        Distance = 100.0, 
        SpawnPoint = {x = 353.2265, y =3530.1587, z = 34.3975, h=271.8349 }, 
        OpenTrunk = {
            Pos = {x = 335.0869, y = 3539.2505, z = 33.4168},-- NPC 358.8699, 3540.5784, 33.9468, 269.5237
            Model   =  "",
            Heading = 217.9512,
            Distance = 5.0
        },
        StoreVehicle = {
            Pos = {x = 337.0147, y = 3571.4290, z = 33.3405},  -- วงเก็บรถ
            DrawMark = {
                Type = 28,
                Hide = true,            -- เปิด-ปิด การแสดงวง // true คือเปิดใช้งาน ** ถ้าเปิดใช้งาน Resmon จะเพิ่มขึ้นนิดหนึ่ง
                Color = 1,	            -- สีของ DrawMark
                Radius = 00.0,         -- ขนาดของวง DrawMark
                Bold = 100,	            -- ความเข้มวง DrawMark
                R = 139,                -- CODE สีของวง DrawMark
                G = 210,                 -- CODE สีของวง DrawMark
                B = 236                  -- CODE สีของวง DrawMark
            },
        }, 
        LeaveVehicle = {
            Pos = {x = 337.0147, y = 3571.4290, z = 33.3405},  -- วงเก็บรถ
            DrawMark = {
                Type = 28,
                Hide = true,            -- เปิด-ปิด การแสดงวง // true คือเปิดใช้งาน ** ถ้าเปิดใช้งาน Resmon จะเพิ่มขึ้นนิดหนึ่ง
                Color = 1,	            -- สีของ DrawMark
                Radius = 25.0,         -- ขนาดของวง DrawMark
                Bold = 100,	            -- ความเข้มวง DrawMark
                R = 139,                -- CODE สีของวง DrawMark
                G = 210,                 -- CODE สีของวง DrawMark
                B = 236                  -- CODE สีของวง DrawMark
            },
        }
    },


}
Config.Alert = {
    ["stored_warning"] = "เกิดข้อผิดพลาด ไม่สามารถฝากรถคันนี้ได้.",
    ["vehicle_key_warning"] = "คุณมีรถที่ฝากอยู่จุดนี้อยู่แล้ว ไม่สามารถฝากเพิ่มได้อีก.",
    ["stored_success"] = "ฝากรถเรียบร้อย."
}
