Config = {}

Config.Money = 0 -- เงินที่ต้องการให้เสีย
Config.Position = {
    ["stone"] = {   -- เหมือง  
        Distance = 100.0, 
        SpawnPoint = {x=2955.5674,y= 2848.0281, z=47.0341, h =107.5033},  -- เรียกรถคืน
        OpenTrunk = {
            Pos = {x=2976.8433, y=2805.2300, z=43.6447 },-- NPC
            Model   =  "s_m_m_movspace_01", -- A_M_M_Hillbilly_01
            Heading = 39.5169,
            Distance = 3.0
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

   

    ["steel"] = {   -- ส้ม 337.0147, 3571.4290, 33.3405, 217.9512
        Distance = 100.0, 
        SpawnPoint = {x=2707.9636, y=1399.0786,z= 24.5812, h=84.5570 }, 
        OpenTrunk = {
            Pos = {x=2695.7915,y= 1387.6182,z= 24.5698},-- NPC 358.8699, 3540.5784, 33.9468, 269.5237
            Model   =  "s_m_m_movspace_01",
            Heading = 264.4347,
            Distance = 5.0
        },
        StoreVehicle = {
            Pos = {x=2722.7400, y=1362.1624, z=24.5210},  -- วงเก็บรถ
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
            Pos = {x=2722.7400, y=1362.1624, z=24.5210},  -- วงเก็บรถ
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
    ["wood"] = {   -- -1589.8462, 4754.2178, 51.0251, 5.7089
    Distance = 100.0, 
    SpawnPoint = {x=-1599.1952, y=4791.0195, z=53.4894, h=344.1412}, 
    OpenTrunk = {
        Pos = {x=-1607.6997, y=4749.4375, z=53.1922},-- NPC 358.8699, 3540.5784, 33.9468, 269.5237
        Model   =  "s_m_m_movspace_01",
        Heading = 125.6978,
        Distance = 5.0
    },
    StoreVehicle = {
        Pos = {x=-1633.8335, y=4737.3618, z=53.0620},  -- วงเก็บรถ
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
        Pos = {x=-1633.8335, y=4737.3618, z=53.0620},  -- วงเก็บรถ
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
["orange"] = {   -- ส้ม 337.0147, 3571.4290, 33.3405, 217.9512
Distance = 100.0, 
SpawnPoint = {x = 353.2265, y =3530.1587, z = 34.3975, h=271.8349 }, 
OpenTrunk = {
    Pos = {x = 335.0869, y = 3539.2505, z = 33.4168},-- NPC 358.8699, 3540.5784, 33.9468, 269.5237
    Model   =  "s_m_m_movspace_01",
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

["wheat"] = {   -- ส้ม 337.0147, 3571.4290, 33.3405, 217.9512
Distance = 100.0, 
SpawnPoint = {x=552.6387, y=6532.4531, z=27.7959, h=71.0771 }, 
OpenTrunk = {
    Pos = {x=-717.6934, y=6065.3247,z=2.2038},-- NPC 358.8699, 3540.5784, 33.9468, 269.5237
    Model   =  "s_m_m_movspace_01",
    Heading = 300.9846,
    Distance = 5.0
},
StoreVehicle = {
    Pos = {x=570.5230, y=6486.4790, z=30.6890},  -- วงเก็บรถ
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
    Pos = {x=570.5230, y=6486.4790, z=30.6890},  -- วงเก็บรถ
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

["rice"] = {   -- ส้ม 337.0147, 3571.4290, 33.3405, 217.9512
Distance = 100.0, 
SpawnPoint = {x=-673.3048,y= 6002.9111,z= 10.9208,h= 174.3206 }, 
OpenTrunk = {
    Pos = {x=589.7119, y=6506.5786, z=30.0086},-- NPC 358.8699, 3540.5784, 33.9468, 269.5237
    Model   =  "s_m_m_movspace_01",
    Heading = 118.4017,
    Distance = 5.0
},
StoreVehicle = {
    Pos = {x=-693.9963,y= 6076.7842, z=2.6592},  -- วงเก็บรถ
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
    Pos = {x=-693.9963,y= 6076.7842, z=2.6592},  -- วงเก็บรถ
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

["cabbage"] = {   -- ส้ม 337.0147, 3571.4290, 33.3405, 217.9512
Distance = 100.0, 
SpawnPoint = {x=-3057.1846,y= 3251.7410,z= 1.6914,h= 268.1959 }, 
OpenTrunk = {
    Pos = {x=-3108.4644, y=3267.9075, z=4.3517},-- NPC 358.8699, 3540.5784, 33.9468, 269.5237
    Model   =  "s_m_m_movspace_01",
    Heading = 200.5007,
    Distance = 5.0
},
StoreVehicle = {
    Pos = {x=-3105.2300,y= 3241.9221,z= 2.0250},  -- วงเก็บรถ
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
    Pos = {x=-3105.2300,y= 3241.9221,z= 2.0250},  -- วงเก็บรถ
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

["chemical"] = {   -- ส้ม 337.0147, 3571.4290, 33.3405, 217.9512
Distance = 100.0, 
SpawnPoint = {x=1898.6570, y=4778.0557, z=43.4810, h=119.5267}, 
OpenTrunk = {
    Pos = {x=1871.9645, y=4771.5249, z=41.5675},-- NPC 358.8699, 3540.5784, 33.9468, 269.5237
    Model   =  "s_m_m_movspace_01",
    Heading = 316.1502,
    Distance = 5.0
},
StoreVehicle = {
    Pos = {x=1873.2518, y=4798.8008, z=44.4854},  -- วงเก็บรถ
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
    Pos = {x=1873.2518, y=4798.8008, z=44.4854},  -- วงเก็บรถ
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

["herb"] = {   -- ส้ม 337.0147, 3571.4290, 33.3405, 217.9512
Distance = 100.0, 
SpawnPoint = {x=3246.1230, y=5132.9536, z=19.6862, h=94.3268}, 
OpenTrunk = {
    Pos = {x=3265.0488, y=5142.1626, z=19.5408},-- NPC 358.8699, 3540.5784, 33.9468, 269.5237
    Model   =  "s_m_m_movspace_01",
    Heading = 281.0402,
    Distance = 5.0
},
StoreVehicle = {
    Pos = {x=3288.9263, y=5152.6387, z=18.3919},  -- วงเก็บรถ
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
    Pos = {x=3288.9263, y=5152.6387, z=18.3919},  -- วงเก็บรถ
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

["Pig"] = {   -- 2376.2151, 5089.3145, 47.1947, 49.9343
Distance = 100.0, 
SpawnPoint = {x=2376.2151, y=5089.3145, z=47.1947, h=49.934}, 
OpenTrunk = {
    Pos = {x=2376.2463, y=5077.2163, z=47.0290},-- NPC 2376.2463, 5077.2163, 47.0290, 
    Model   =  "s_m_m_movspace_01",
    Heading = 188.4203,
    Distance = 5.0
},
StoreVehicle = {
    Pos = {x=2378.9563, y=5053.0083, z=46.4446},  -- วงเก็บรถ
    DrawMark = {
        Type = 28,
        Hide = true,            -- เปิด-ปิด การแสดงวง // true คือเปิดใช้งาน ** ถ้าเปิดใช้งาน Resmon จะเพิ่มขึ้นนิดหนึ่ง
        Color = 1,	            -- สีของ DrawMark
        Radius = 14.0,         -- ขนาดของวง DrawMark
        Bold = 100,	            -- ความเข้มวง DrawMark
        R = 139,                -- CODE สีของวง DrawMark
        G = 210,                 -- CODE สีของวง DrawMark
        B = 236                  -- CODE สีของวง DrawMark
    },
}, 
LeaveVehicle = {
    Pos = {x=2378.9563, y=5053.0083, z=46.4446},  -- วงเก็บรถ
    DrawMark = {
        Type = 28,
        Hide = true,            -- เปิด-ปิด การแสดงวง // true คือเปิดใช้งาน ** ถ้าเปิดใช้งาน Resmon จะเพิ่มขึ้นนิดหนึ่ง
        Color = 1,	            -- สีของ DrawMark
        Radius = 14.0,         -- ขนาดของวง DrawMark
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
