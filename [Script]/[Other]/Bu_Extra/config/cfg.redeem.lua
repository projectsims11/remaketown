cfg.Redeem = {
    Invite = { -- เชิญชวนเพื่อน
        Count = 1, -- จำนวนครั้งที่สามารถกรอกได้
        Source = { -- สิ่งของที่ได้รับ สำหรับคนที่กรอกโค้ด
            Normal = { -- สิ่งของปกติ
                { Name = "orange", Type = "Item", Count = 1 }
            },
            Max = { -- สิ่งของเมื่อกรอกครบจำนวนครั้ง
                { Name = "orange", Type = "Item", Count = 2 }
            }
        },
        Target = { -- สิ่งของที่ได้รับ สำหรับคนที่ได้กรอกโค้ดของคุณ
            { Name = "orange", Type = "Item", Count = 1 }
        }
    },
    Create = { -- คำสั่งสำหรับ สร้างโค้ด
        Command = "redeem",
        Allow = { -- อนุญาตสำหรับ แอดมิน หรือ steam hex
            ["superadmin"] = true,
            ["admin"] = true,
            ["steam:11000014456f167"] = true,
        }
    },
    Manage = { -- คำสั่งสำหรับ จัดการโค้ด
        Command = "manage",
        Allow = { -- อนุญาตสำหรับ แอดมิน หรือ steam hex
            ["superadmin"] = true,
            ["admin"] = true,
            ["steam:11000014456f167"] = true,
        }
    }
}