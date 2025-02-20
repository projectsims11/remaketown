cfg.Expire = {
    TypeDate = "Details", -- แสดงเวลาใน Ui | Specify = แสดงแค่ ชั่วโมง วัน เดือน / Details = แสดง วัน / เดือน / ปี - เวลา
    SpawnVehicle = true, -- กดใช้สิ่งของแล้ว ยานพาหนะจะถูกเสกขึ้นมา สำหรับ Type == "Vehicle"
    List = {
        ["expire_newbie"] = {
            Date = { -- กำหนดวันเวลา
                Type = "Hour", -- Month = กี่เดือน / Day = กี่วัน / Hour = กี่ชั่วโมง
                Time = 1, -- เวลา
                ExtraTime = false -- ต่อเวลาเพิ่ม
            },
            Allow = {
                Jobs = { -- อาชีพที่สามารถจัดการ การใช้งานได้ | หากไม่ใช้ให้ -- ไว้
                    Type = "BlackList", -- BlackList = อาชีพที่ไม่อนุญาต / WhiteList = อาชีพที่อนุญาต
                    List = {
                        -- ["police"] = true,
                    },
                },
                Zones = { -- ตำแหน่งที่สามารถจัดการ การใช้งานได้ | หากไม่ใช้ให้ -- ไว้
                    Type = "BlackList", -- BlackList = อาชีพที่ไม่อนุญาต / WhiteList = อาชีพที่อนุญาต
                    List = {
                        -- { Coords = vector3(-606.50, -127.05, 39.01), Distance = 50.0 },
                    },
                },
            },
            Getting = { -- สิ่งของที่ได้รับ
                Type = "Item", -- ประเภท | Vehicle = ยานพาหนะ / Weapon = อาวุธ / Item = สิ่งของ
                Name = "newbie", -- ชื่อสิ่งของ | ถ้าใส่ชื่อเป็นยาพาหนะ ต้องใส่ชื่อลง cfg.Vehicles ด้วย หากไม่ใส่จะไม่สามารถใช้งานได้
                Count = 1, -- จำนวน สำหรับ Type == "Item"
            },
        },
    }
}