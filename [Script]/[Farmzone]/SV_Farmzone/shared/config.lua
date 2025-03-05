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
    SpawnPoint = {x = -1793.48, y = 2676.43, z = 3.63 , h=240.56},
    OpenTrunk = {
        Pos = {x = -1846.16, y = 2670.49, z = 3.13},-- NPC 358.8699, 3540.5784, 33.9468, 269.5237 
        Model   =  "s_m_m_movspace_01",
        Heading = 213.86,
        Distance = 5.0             
    },
    StoreVehicle = {
        Pos = {x=-1820.3399658203127, y=2635.25, z=2.85999989509582},  -- วงเก็บรถ 
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
        Pos = {x=-1820.3399658203127, y=2635.25, z=2.85999989509582},  -- วงเก็บรถ 
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
SpawnPoint = {x = -720.58, y = 2554.26, z = 59.23, h=205.86 }, 
OpenTrunk = {
    Pos = {x = -670.60, y = 2623.18, z = 44.64},-- NPC 358.8699, 3540.5784, 33.9468, 269.5237
    Model   =  "s_m_m_movspace_01",
    Heading = 167.52,
    Distance = 5.0           
},
StoreVehicle = {
    Pos = {x = -678.3200073242188, y = 2592.699951171875, z = 46.20999908447265},  -- วงเก็บรถ 
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
    Pos = {x = -678.3200073242188, y = 2592.699951171875, z = 46.20999908447265},  -- วงเก็บรถ
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
SpawnPoint = {x = -396.28, y = 4304.25, z = 55.51, h=230.07 },
OpenTrunk = {
    Pos = {x = -366.50, y = 4339.40, z = 58.62},-- NPC 358.8699, 3540.5784, 33.9468, 269.5237
    Model   =  "s_m_m_movspace_01",
    Heading = 70.55,                
    Distance = 5.0
},
StoreVehicle = {
    Pos = {x=-393.8399963378906, y=4345.4599609375, z=55.7599983215332},  -- วงเก็บรถ
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
    Pos = {x=-393.8399963378906, y=4345.4599609375, z=55.7599983215332},  -- วงเก็บรถ
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
    Pos = {x=-1639.5899658203125,y= 4585.759765625, z=43.25},  -- วงเก็บรถ
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
    Pos = {x=-1639.5899658203125,y= 4585.759765625, z=43.25},  -- วงเก็บรถ
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
SpawnPoint = {x = 366.02, y = 4379.96, z = 64.16,h= 277.49 }, 
OpenTrunk = {
    Pos = {x = 285.80, y = 4338.90, z = 48.08},-- NPC 358.8699, 3540.5784, 33.9468, 269.5237
    Model   =  "s_m_m_movspace_01",
    Heading = 234.56,
    Distance = 5.0
},
StoreVehicle = {
    Pos = {x=302.2000122070313,y= 4311.9599609375,z= 46.93000030517578},  -- วงเก็บรถ
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
    Pos = {x=302.2000122070313,y= 4311.9599609375,z= 46.93000030517578},  -- วงเก็บรถ
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
SpawnPoint = {x=-96.29, y = 1861.22, z = 198.99, h= 92.93}, 
OpenTrunk = {
    Pos = {x = -48.37, y = 1877.82, z = 196.43},-- NPC 358.8699, 3540.5784, 33.9468, 269.5237
    Model   =  "s_m_m_movspace_01",
    Heading = 44.23,
    Distance = 5.0
},
StoreVehicle = {
    Pos = {x=-65.62000274658203, y=1901.3900146484375, z=196.07000732421875},  -- วงเก็บรถ
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
    Pos = {x=-65.62000274658203, y=1901.3900146484375, z=196.07000732421875},  -- วงเก็บรถ
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

["Treasure"] = {   -- 2376.2151, 5089.3145, 47.1947, 49.9343
Distance = 100.0, 
SpawnPoint = {x = 765.88, y = 4184.72, z = 40.58, h=342.52}, 
OpenTrunk = {
    Pos = {x = 715.47, y = 4153.41, z = 35.78},-- NPC 2376.2463, 5077.2163, 47.0290, 
    Model   =  "s_m_m_movspace_01",
    Heading = 155.41,
    Distance = 5.0
},
StoreVehicle = {
    Pos = {x = 722.30, y = 4175.18, z = 40.71},  -- วงเก็บรถ
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
    Pos = {x = 722.30, y = 4175.18, z = 40.71},  -- วงเก็บรถ
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

["process"] = {   -- 2376.2151, 5089.3145, 47.1947, 49.9343     coords = { x = 1098.24, y = 2663.06, z = 37.96 }, heading = 0.09
Distance = 100.0, 
SpawnPoints = {x = 1098.24, y = 2663.06, z = 37.96, h= 0.09},
OpenTrunk = {
    Pos = {x = 1123.86, y = 2657.40, z = 38.00},-- NPC 2376.2463, 5077.2163, 47.0290, 
    Model   =  "s_m_m_movspace_01",
    Heading = 358.68,
    Distance = 5.0
},
StoreVehicle = {
    Pos = {x = 1124.11, y = 2649.69, z = 38.00 },  -- วงเก็บรถ
    DrawMark = {
        Type = 28,
        Hide = true,            -- เปิด-ปิด การแสดงวง // true คือเปิดใช้งาน ** ถ้าเปิดใช้งาน Resmon จะเพิ่มขึ้นนิดหนึ่ง
        Color = 1,	            -- สีของ DrawMark
        Radius = 20.0,         -- ขนาดของวง DrawMark
        Bold = 100,	            -- ความเข้มวง DrawMark
        R = 139,                -- CODE สีของวง DrawMark
        G = 210,                 -- CODE สีของวง DrawMark
        B = 236                  -- CODE สีของวง DrawMark
    },
}, 
LeaveVehicle = {
    Pos = {x = 1124.11, y = 2649.69, z = 38.00},  -- วงเก็บรถ
    DrawMark = {
        Type = 28,
        Hide = true,            -- เปิด-ปิด การแสดงวง // true คือเปิดใช้งาน ** ถ้าเปิดใช้งาน Resmon จะเพิ่มขึ้นนิดหนึ่ง
        Color = 1,	            -- สีของ DrawMark
        Radius = 20.0,         -- ขนาดของวง DrawMark
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
