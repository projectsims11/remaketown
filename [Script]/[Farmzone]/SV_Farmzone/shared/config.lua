Config = {}

Config.Money = 0 -- เงินที่ต้องการให้เสีย
Config.Position = {
    ["1"] = {   -- เหมือง
        Distance = 100.0,
        SpawnPoint = {x = 2978.66, y = 2809.67, z = 43.36},  -- เรียกรถคืน
        OpenTrunk = {
            Pos = {x = 2961.51, y = 2818.67, z = 43.39},-- NPC
            Model   =  "", -- A_M_M_Hillbilly_01
            Heading = 238.71,
            Distance = 5.0
        },
        StoreVehicle = {
            Pos = {x = 2954.28, y = 2791.37, z = 41.03},  -- วงเก็บรถ
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
            Pos = {x = 2954.28, y = 2791.37, z = 41.03},  -- วงเก็บรถ
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

    ["2"] = {   -- ไวรัส
        Distance = 100.0,
        SpawnPoint = {x = 40.77, y = 2866.57, z = 55.25},  -- เรียกรถคืน
        OpenTrunk = {
            Pos = {x = 58.89, y = 2873.04, z = 54.57},-- NPC
            Model   =  "",
            Heading = 28.44,
            Distance = 5.0
        },
        StoreVehicle = {
            Pos = {x = 61.33, y = 2900.8, z = 53.39},  -- วงเก็บรถ
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
            Pos = {x = 61.33, y = 2900.8, z = 53.39},  -- วงเก็บรถ
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

    ["3"] = {   -- พุดดิ้ง
        Distance = 100.0,
        SpawnPoint = {x = 1172.4, y = 3594.14, z = 32.91},  -- เรียกรถคืน
        OpenTrunk = {
            Pos = {x = 1179.88, y = 3581.43, z = 34.86},-- NPC
            Model   =  "",
            Heading = 1.37,
            Distance = 5.0
        },
        StoreVehicle = {
            Pos = {x = 1208.38, y = 3582.28, z = 34.6},  -- วงเก็บรถ
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
            Pos = {x = 1208.38, y = 3582.28, z = 34.6},  -- วงเก็บรถ
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

    ["4"] = {   -- ไข่
        Distance = 100.0,
        SpawnPoint = {x = 2341.7, y = 3874.12, z = 34.31},  -- เรียกรถคืน
        OpenTrunk = {
            Pos = {x = 2329.23, y = 3884.74, z = 35.32},-- NPC
            Model   =  "",
            Heading = 273.92,
            Distance = 5.0
        },
        StoreVehicle = {
            Pos = {x = 2312.86, y = 3907.02, z = 35.28},  -- วงเก็บรถ
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
            Pos = {x = 2312.86, y = 3907.02, z = 35.28},  -- วงเก็บรถ
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

    ["5"] = {   -- น้ำผึ้ง
        Distance = 100.0,
        SpawnPoint = {x = 2031.25, y = 4772.8, z = 40.48},  -- เรียกรถคืน
        OpenTrunk = {
            Pos = {x = 2038.28, y = 4763.82, z = 41.39},-- NPC
            Model   =  "",
            Heading = 56.98,
            Distance = 5.0
        },
        StoreVehicle = {
            Pos = {x = 2010.58, y = 4751.32, z = 41.06},  -- วงเก็บรถ
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
            Pos = {x = 2010.58, y = 4751.32, z = 41.06},  -- วงเก็บรถ
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




    ["6"] = {   -- Process cij
    Distance = 100.0,
    SpawnPoint = {x = 733.49, y = 2504.65, z = 72.15},  -- เรียกรถคืน
    OpenTrunk = {
        Pos = {x = 752.78, y = 2514.99, z = 73.47},-- NPC
        Model   =  "",
        Heading = 56.98,
        Distance = 5.0
    },
    StoreVehicle = {
        Pos = {x = 744.97, y = 2523.91, z = 72.2},  -- วงเก็บรถ
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
        Pos = {x = 744.97, y = 2523.91, z = 72.2},  -- วงเก็บรถ
        DrawMark = {
            Type = 28,
            Hide = true,            -- เปิด-ปิด การแสดงวง // true คือเปิดใช้งาน ** ถ้าเปิดใช้งาน Resmon จะเพิ่มขึ้นนิดหนึ่ง
            Color = 1,	            -- สีของ DrawMark
            Radius = 10.0,         -- ขนาดของวง DrawMark
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
