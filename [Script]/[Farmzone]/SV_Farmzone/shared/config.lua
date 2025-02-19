Config = {}

Config.Money = 0 -- เงินที่ต้องการให้เสีย
Config.Position = {
    ["stone"] = {   -- เหมือง  
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

   

    ["steel"] = {   -- ส้ม 337.0147, 3571.4290, 33.3405, 217.9512
        Distance = 100.0, 
        SpawnPoint = {x=2707.9636, y=1399.0786,z= 24.5812, h=84.5570 }, 
        OpenTrunk = {
            Pos = {x=2706.3142, y=1395.0212, z=24.5656},-- NPC 358.8699, 3540.5784, 33.9468, 269.5237
            Model   =  "",
            Heading = 271.8349,
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
    SpawnPoint = {x=-1599.1952, y=4791.0195, z=52.4894, h=344.1412}, 
    OpenTrunk = {
        Pos = {x= -1589.8462, y=4754.2178, z=51.0251},-- NPC 358.8699, 3540.5784, 33.9468, 269.5237
        Model   =  "",
        Heading = 344.1412,
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

["wheat"] = {   -- ส้ม 337.0147, 3571.4290, 33.3405, 217.9512
Distance = 100.0, 
SpawnPoint = {x=552.6387, y=6532.4531, z=27.7959, h=71.0771 }, 
OpenTrunk = {
    Pos = {x=550.9422, y=6518.7598, z=29.8381},-- NPC 358.8699, 3540.5784, 33.9468, 269.5237
    Model   =  "",
    Heading = 71.0771,
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
    Pos = {x=-674.4368,y= 6065.0703,z= 2.6185},-- NPC 358.8699, 3540.5784, 33.9468, 269.5237
    Model   =  "",
    Heading = 71.0771,
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
    Pos = {x=-3074.7795,y= 3249.6218,z= 1.5963},-- NPC 358.8699, 3540.5784, 33.9468, 269.5237
    Model   =  "",
    Heading = 71.0771,
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
    Pos = {x=1904.0123, y=4786.8613, z=43.9954},-- NPC 358.8699, 3540.5784, 33.9468, 269.5237
    Model   =  "",
    Heading = 71.0771,
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
    Pos = {x=3263.7688, y=5157.8789, z=19.8247},-- NPC 358.8699, 3540.5784, 33.9468, 269.5237
    Model   =  "",
    Heading = 71.0771,
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




}
Config.Alert = {
    ["stored_warning"] = "เกิดข้อผิดพลาด ไม่สามารถฝากรถคันนี้ได้.",
    ["vehicle_key_warning"] = "คุณมีรถที่ฝากอยู่จุดนี้อยู่แล้ว ไม่สามารถฝากเพิ่มได้อีก.",
    ["stored_success"] = "ฝากรถเรียบร้อย."
}
