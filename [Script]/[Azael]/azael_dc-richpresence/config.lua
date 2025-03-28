--===== FiveM Script =========================================
--= DC - Rich Presence
--===== Developed By: ========================================
--= Azael Dev
--===== Website: =============================================
--= https://www.azael.dev
--===== License: =============================================
--= Copyright (C) Azael Dev - All Rights Reserved
--= You are not allowed to sell this script
--============================================================ 

CONFIG = {}

CONFIG.Option = {                                           -- Option
    Update = {                                              -- Update
        Time = 15                                           -- เวลาในการอัพเดทสถานะ (ระบุเป็น “วินาที”) | Discord_UpdatePresence() มีขีดจำกัดอยู่ที่ 1 ครั้งต่อ 15 วินาที
    },

    Display = {                                             -- Display
        ID = {                                              -- ไอดี
            Enable = true                                   -- แสดง ไอดีผู้เล่น (true เท่ากับ เปิดใช้งาน | false เท่ากับ ปิดใช้งาน)
        },

        Name = {                                            -- ชื่อ
            Enable = true                                   -- แสดง ชื่อผู้เล่น (true เท่ากับ เปิดใช้งาน | false เท่ากับ ปิดใช้งาน)
        },

        Online = {                                          -- ออนไลน์
            Enable = true                                   -- แสดง จำนวนผู้เล่นออนไลน์ (true เท่ากับ เปิดใช้งาน | false เท่ากับ ปิดใช้งาน)
        },

        Activity = {                                        -- กิจกรรม
            Enable = true,                                  -- แสดง สถานะกิจกรรมผู้เล่น (true เท่ากับ เปิดใช้งาน | false เท่ากับ ปิดใช้งาน)

            Plate = {                                       -- ทะเบียน (ยานพาหนะ)
                Enable = false                               -- แสดง ทะเบียนยานพาหนะ (true เท่ากับ เปิดใช้งาน | false เท่ากับ ปิดใช้งาน)
            }
        }
    }
}

CONFIG.Discord = {                                          -- Discord
    Application = {                                         -- Application (Developer Portal: https://discord.com/developers/applications)
        ID = 997230197743026258                             -- ID (รูปภาพตัวอย่าง: https://i.imgur.com/cWZjHB3.png)
    },

    Asset = {                                               -- Asset (Art Assets: https://discord.com/developers/applications/YOUR_APP_ID/rich-presence/assets)
        Logo = {                                            -- ภาพสัญลักษณ์ (ขนาดปกติ)
            Name = 'icon',                            -- ชื่อ (รูปภาพตัวอย่าง: https://imgur.com/y1Amkyu.png)
            Text = 'REMAKE TOWHN'                    -- ข้อความ
        },

        Icon = {                                            -- ภาพสัญลักษณ์ (ขนาดเล็ก)
            Name = 'icon',                            -- ชื่อ (รูปภาพตัวอย่าง: https://i.imgur.com/0STQ7rh.png)
            Text = 'REMAKE TOWHN'                    -- ข้อความ
        }
    },

    Button = {                                              -- Button (ปุ่ม)
        [1] = {                                             -- ปุ่มที่ 1
            Text = 'Join Discord',                          -- ข้อความ
            URL = 'https://discord.gg/n48uqW7YxY'           -- URL
        },

        [2] = {                                             -- ปุ่มที่ 2
            Text = 'Join Server',                           -- ข้อความ
            URL = 'fivem://connect/45.144.165.8:30120'      -- URL
        }
    }
}

CONFIG.Translate = {                                        -- Translate
    General = {                                             -- ทั่วไป
        Slot = 'Slots',                                     -- สล็อต
        Player = 'Players',                                 -- ผู้เล่น
        Loading = 'Loading...'                              -- กำลังโหลด
    },

    Unknown = {                                             -- ไม่ทราบ
        Zone = 'Unknown Zone',                              -- โซน
        Activity = 'Unknown Activity'                       -- กิจกรรม
    },

    Activity = {                                            -- กิจกรรม
        Dead = {                                            -- เสียชีวิต
            Ground = 'Dead at %s',                          -- พื้นดิน
            Water = 'Dead at %s',                           -- น้ำ
            Vehicle = 'Dead on %s in a %s %s'               -- ยานพาหนะ
        },

        Ground = {                                          -- พื้นดิน
            Sprinting = 'Sprinting on %s',                  -- วิ่ง (เร็ว)
            Running = 'Running on %s',                      -- วิ่ง (ช้า)
            Walking = 'Walking on %s',                      -- เดิน
            Standing = 'Standing at %s'                     -- ยืนนิ่ง
        },

        Water = {                                           -- น้ำ
            Swimming = 'Swimming on %s'                     -- ว่ายน้ำ
        },

        Vehicle = {                                         -- ยานพาหนะ
            Sailing = 'Sailing on %s in a %s %s',           -- ล่องเรือ
            Drowning = 'Drowning at %s in a %s %s',         -- จมน้ำ
            Flying = 'Flying over %s in a %s %s',           -- ขึ้นบิน
            Landed = 'Landed at %s in a %s %s',             -- ลงจอด
            Parked = 'Parked at %s in a %s %s',             -- จอดรถ
            Cruising = 'Cruising on %s in a %s %s',         -- ขับรถ (ช้า)
            Speeding = 'Speeding on %s in a %s %s'          -- ขับรถ (เร็ว)
        }
    }
}

CONFIG.Zone = {                                             -- Zone (List: https://docs.fivem.net/natives/?_0xCD90657D4C30E1CA)
    AIRP = 'Los Santos International Airport',
    ALAMO = 'Alamo Sea',
    ALTA = 'Alta',
    ARMYB = 'Fort Zancudo',
    BANHAMC = 'Banham Canyon Dr',
    BANNING = 'Banning',
    BEACH = 'Vespucci Beach',
    BHAMCA = 'Banham Canyon',
    BRADP = 'Braddock Pass',
    BRADT = 'Braddock Tunnel',
    BURTON = 'Burton',
    CALAFB = 'Calafia Bridge',
    CANNY = 'Raton Canyon',
    CCREAK = 'Cassidy Creek',
    CHAMH = 'Chamberlain Hills',
    CHIL = 'Vinewood Hills',
    CHU = 'Chumash',
    CMSW = 'Chiliad Mountain State Wilderness',
    CYPRE = 'Cypress Flats',
    DAVIS = 'Davis',
    DELBE = 'Del Perro Beach',
    DELPE = 'Del Perro',
    DELSOL = 'La Puerta',
    DESRT = 'Grand Senora Desert',
    DOWNT = 'Downtown',
    DTVINE = 'Downtown Vinewood',
    EAST_V = 'East Vinewood',
    EBURO = 'El Burro Heights',
    ELGORL = 'El Gordo Lighthouse',
    ELYSIAN = 'Elysian Island',
    GALFISH = 'Galilee',
    GOLF = 'GWC & Golfing Society',
    GRAPES = 'Grapeseed',
    GREATC = 'Great Chaparral',
    HARMO = 'Harmony',
    HAWICK = 'Hawick',
    HORS = 'Vinewood Racetrack',
    HUMLAB = 'Humane Labs & Research',
    JAIL = 'Bolingbroke Penitentiary',
    KOREAT = 'Little Seoul',
    LACT = 'Land Act Reservoir',
    LAGO = 'Lago Zancudo',
    LDAM = 'Land Act Dam',
    LEGSQU = 'Legion Square',
    LMESA = 'La Mesa',
    LOSPUER = 'La Puerta',
    MIRR = 'Mirror Park',
    MORN = 'Morningwood',
    MOVIE = 'Richards Majestic',
    MTCHIL = 'Mount Chiliad',
    MTGORDO = 'Mount Gordo',
    MTJOSE = 'Mount Josiah',
    MURRI = 'Murrieta Heights',
    NCHU = 'North Chumash',
    NOOSE = 'N.O.O.S.E',
    OCEANA = 'Pacific Ocean',
    PALCOV = 'Paleto Cove',
    PALETO = 'Paleto Bay',
    PALFOR = 'Paleto Forest',
    PALHIGH = 'Palomino Highlands',
    PALMPOW = 'Palmer-Taylor Power Station',
    PBLUFF = 'Pacific Bluffs',
    PBOX = 'Pillbox Hill',
    PROCOB = 'Procopio Beach',
    RANCHO = 'Rancho',
    RGLEN = 'Richman Glen',
    RICHM = 'Richman',
    ROCKF = 'Rockford Hills',
    RTRAK = 'Redwood Lights Track',
    SANAND = 'San Andreas',
    SANCHIA = 'San Chianski Mountain Range',
    SANDY = 'Sandy Shores',
    SKID = 'Mission Row',
    SLAB = 'Stab City',
    STAD = 'Maze Bank Arena',
    STRAW = 'Strawberry',
    TATAMO = 'Tataviam Mountains',
    TERMINA = 'Terminal',
    TEXTI = 'Textile City',
    TONGVAH = 'Tongva Hills',
    TONGVAV = 'Tongva Valley',
    VCANA = 'Vespucci Canals',
    VESP = 'Vespucci',
    VINE = 'Vinewood',
    WINDF = 'Ron Alternates Wind Farm',
    WVINE = 'West Vinewood',
    ZANCUDO = 'Zancudo River',
    ZP_ORT = 'Port of South Los Santos',
    ZQ_UAR = 'Davis Quartz',
    PROL = 'Prologue / North Yankton',
    ISHeist = 'Cayo Perico Island'
}
