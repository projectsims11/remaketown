cfg.Rental = { -- ระบบเช่าเรือ
    {
        Coords = {
            Main = vector3( -3425.45, 964.6010, 8.3466 ), -- ตำแหน่งหลัก
            Keep = {
                Main = vector3( -3443.42, 930.2579, -0.784 ), -- ตำแหน่งเก็บเรือ
                Warp = vector4( -3426.44, 968.2975, 8.3466, 100.46 ), -- ตำแหน่งที่ผู้เล่นจะวาร์ปขึ้นไปบนฝั่ง
            },
            Spawn = vector4( -3443.42, 930.2579, -0.784, 107.17 ), -- ตำแหน่ง Spawn ของเรือ
        },
        Blips = { -- Icon บน Map
            Id = 427, -- Blip Id
            Color = 26, -- Blip Size
            Size = 0.8, -- Blip Color
            Name = "<font face='Sarabun'>ตกปลา - เช่าเรือ</font>",
            Radius = true,
        },
        -- Mark = { -- มารค์เกอร์
        --     ShowMarker = { -- โชว์มารค์เกอร์บนหัวไหม
        --         Enabled = true, -- เปิด / ปิด
        --         PosZ = 2.1, -- ความสูงของ Marker ( ถ้าไม่ใช้ "NPC" ปรับเป็น 0.0 )
        --     },
        --     NPC = { -- Prop งาน หรือจะใช้เป็น Ped ก็ได้
        --         Enabled = true, -- เปิด / ปิด
        --         Type = "NPC", ---- OBJ / NPC
        --         Model = "a_m_y_salton_01", -- ชื่อ Prop หรือ Ped
        --         Heading = 52.4, -- การหันของ Prop หรือ Ped
        --     },
        -- },
        Mark = {
			Distance = 1.0, -- ระยะในการกดปุ่ม
			ShowMarker = { -- โชว์มาร์คเกอร์อิงจาก cfg.Marker
				Enabled = true, -- เปิดใช้งาน / ปิดใช้งาน
				PosZ = 1.0, -- ความสูงของ Marker ( หากไม่ใช้ Model ปรับเป็น 0.0 )
			},
			Object = { -- แสดง Object | หากไม่ใช้ให้ -- ไว้
				Type = "NPC", -- ประเภทของ Object | NPC / OBJ
				Model = "a_m_y_salton_01", -- ชื่อ Object
				Heading = 52.24, -- การหันของ Object
			},
		},
        List = { -- ร้านเช่าเรือ
            ["tug"] = 1500,
            ["tropic2"] = 1300,
            ["speeder2"] = 800,
        }
    }
}