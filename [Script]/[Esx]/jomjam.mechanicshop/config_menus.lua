Config = Config or {}

-- ==================================================================================== --
-- =============================== ตั้งค่าราคาของการแต่งรถ ================================= --
-- ==================================================================================== --

-- ==================================================================================== --
-- ==================================== คำอธิบาย ======================================= --
-- คำแนะนำ ควรแก้ไขแค่ ราคา หรือ แค่ ชื่อตรง Title เท่านั้น
-- ตั้งค่าราคาของการแต่งรถได้ที่ priceMult ราคาจะเป็น % ของราคาที่ตั้ง ใน config_vehicles.lua
-- ==================================================================================== --


Config['Menus'] = {
    ["empty"] = {
        title = "",
        options = {}
    },
    ["main"] = {
        title = "หน้าหลัก",
        options = {
            {label = "ล้างรถ", img = "img/icons/repair.png", price = 1000, onSelect = function()
                    repairtVehicle(customVehicle)
                end},
            {label = "แต่งภายนอก", img = "img/icons/visual.png", openSubMenu = "visual"},
            {label = "อัพเกรด", img = "img/icons/upgrade.png", openSubMenu = "upgrade"}
        },
        onBack = function()
            closeUI(1)
        end,
        defaultOption = 1
    },
    ["upgrade"] = {
        title = "อัพเกรด",
        options = {
            {label = "เครื่องยนต์", img = "img/icons/engine.png", modType = 11, priceMult = {10.0, 20.0, 30.0, 40.0, 50.0, 60.0}},
            {label = "เบรค", img = "img/icons/brakes.png", modType = 12, priceMult = {10.0, 20.0, 30.0, 40.0, 50.0}},
            {
                label = "เกียร์",
                img = "img/icons/transmission.png",
                modType = 13,
                priceMult = {10.0, 20.0, 30.0, 40.0, 50.0}
            },
            {
                label = "โช๊ค",
                img = "img/icons/suspension.png",
                modType = 15,
                priceMult = {10.0, 20.0, 30.0, 40.0, 50.0, 60.0, 70.0}
            },
            {
                label = "เกราะ",
                img = "img/icons/armor.png",
                modType = 16,
                priceMult = {10.0, 20.0, 30.0, 40.0, 50.0, 60.0, 70.0, 80.0}
            },
            {label = "เทอร์โบ", img = "img/icons/engine.png", modType = 18, priceMult = {25.0, 50.0}}
        },
        onBack = function()
            updateMenu("main")
        end
    },
    ["visual"] = {
        title = "ภายนอก",
        options = {
            {label = "อุปกรณ์เสริม", img = "img/icons/body.png", openSubMenu = "body_parts"},
            {label = "ส่วนภายใน", img = "img/icons/body.png", openSubMenu = "inside_parts"},
            {label = "สี", img = "img/icons/respray.png", openSubMenu = "respray"},
            {
                label = "ล้อ",
                img = "img/icons/wheel.png",
                openSubMenu = "wheels",
                onSelect = function()
                    moveToCameraToBoneSmoth(
                        customCamMain,
                        customCamSec,
                        customVehicle,
                        "wheel_lf",
                        {x = -1.8, y = 0.0, z = 0.0},
                        {x = 0.0, y = 0.0, z = -20.0}
                    )
                end
            },
            {label = "ป้ายทะเบียน", img = "img/icons/plate.png", openSubMenu = "plate"},
            {label = "ไฟรถ", img = "img/icons/headlights.png", openSubMenu = "lights"},
            {label = "สติ๊กเกอร์", img = "img/icons/respray.png", openSubMenu = "stickers"},
            {label = "พิเศษ", img = "img/icons/plus.png", modType = "extras", priceMult = 2.0},
            {
                label = "กระจก",
                img = "img/icons/door.png",
                modType = "windowTint",
                priceMult = 1.12,
                onSelect = function()
                    moveToCameraToBoneSmoth(
                        customCamMain,
                        customCamSec,
                        customVehicle,
                        "window_lf",
                        {x = -2.0, y = 0.0, z = 0.0},
                        {x = 0.0, y = 0.0, z = -10.0}
                    )
                end,
                onSubBack = function()
                    SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
                end
            },
            {label = "แตร", img = "img/icons/horn.png", modType = 14, priceMult = 1.12},
            {label = "การตกแต่งภายใน", img = "img/icons/body.png", modType = 27, priceMult = 6.98},
            {label = "โล่", img = "img/icons/armor.png", modType = 35, priceMult = 4.19},
            {label = "ลำโพง", img = "img/icons/speaker.png", modType = 36, priceMult = 6.98},
            {label = "กระโปรงหลังรถ", img = "img/icons/trunk.png", modType = 37, priceMult = 5.58, onSelect = function()
                    openDoors(customVehicle, {0, 0, 0, 0, 0, 1, 1})
                end},
            {label = "ระบบไฮดรอลิกส์", img = "img/icons/hydrulics.png", modType = 38, priceMult = 5.12},
            {
                label = "บล็อกเครื่องยนต์",
                img = "img/icons/engine_block.png",
                modType = 39,
                priceMult = 5.12,
                onSelect = function()
                    openDoors(customVehicle, {0, 0, 0, 0, 1, 0, 0})
                end
            },
            {label = "กรองอากาศ", img = "img/icons/air_filter.png", modType = 40, priceMult = 3.72},
            {label = "เสา", img = "img/icons/suspension.png", modType = 41, priceMult = 6.51},
            {label = "ถัง", img = "img/icons/gas_tank.png", modType = 45, priceMult = 4.19}
        },
        onBack = function()
            updateMenu("main")
        end
    },
    ["body_parts"] = {
        title = "แต่งชิ้นส่วน",
        options = {
            {label = "สปอยเลอร์", img = "img/icons/spoiler.png", modType = 0, priceMult = 2.65},
            {label = "กันชนหน้า", img = "img/icons/bumper.png", modType = 1, priceMult = 2.12},
            {
                label = "กันชนหลัง",
                img = "img/icons/bumper.png",
                modType = 2,
                priceMult = 2.12,
                onSelect = function()
                    moveToCameraToBoneSmoth(
                        customCamMain,
                        customCamSec,
                        customVehicle,
                        "bumper_r",
                        {x = 0.0, y = -4.0, z = 1.5},
                        {x = -30.0, y = 0.0, z = 0.0}
                    )
                end,
                onSubBack = function()
                    SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
                end
            },
            {
                label = "สเกิร์ตข้าง",
                img = "img/icons/bumper.png",
                modType = 3,
                priceMult = 2.65,
                onSelect = function()
                    moveToCameraToBoneSmoth(
                        customCamMain,
                        customCamSec,
                        customVehicle,
                        "wheel_lf",
                        {x = -2.5, y = 0.0, z = 0.0},
                        {x = 0.0, y = 0.0, z = -20.0}
                    )
                end,
                onSubBack = function()
                    SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
                end
            },
            {
                label = "ท่อ",
                img = "img/icons/exhaust.png",
                modType = 4,
                priceMult = 2.12,
                onSelect = function()
                    moveToCameraToBoneSmoth(
                        customCamMain,
                        customCamSec,
                        customVehicle,
                        "bumper_r",
                        {x = 0.0, y = -4.0, z = 1.5},
                        {x = -30.0, y = 0.0, z = 0.0}
                    )
                end,
                onSubBack = function()
                    SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
                end
            },
            {
                label = "กรง",
                img = "img/icons/body.png",
                modType = 5,
                priceMult = 2.12,
                onSelect = function()
                    moveToCameraToBoneSmoth(
                        customCamMain,
                        customCamSec,
                        customVehicle,
                        "interiorlight",
                        {x = 0.0, y = 1.0, z = -0.1},
                        {x = 0.0, y = 0.0, z = 0.0}
                    )
                end,
                onSubBack = function()
                    SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
                end
            },
            {label = "ตะแกรง", img = "img/icons/bumper.png", modType = 6, priceMult = 2.72},
            {label = "เครื่องดูดควัน", img = "img/icons/hood.png", modType = 7, priceMult = 2.88},
            {label = "บังโคลนซ้าย", img = "img/icons/bumper.png", modType = 8, priceMult = 2.12},
            {label = "บังโคลนขวา", img = "img/icons/bumper.png", modType = 9, priceMult = 2.12},
            {label = "หลังคา", img = "img/icons/roof.png", modType = 10, priceMult = 2.58},
            {label = "ฝาครอบโค้ง", img = "img/icons/bumper.png", modType = 42, priceMult = 4.19},
            {label = "เสาอากาศ", img = "img/icons/shifter_leaver.png", modType = 43, priceMult = 1.12},
            {label = "ปีก", img = "img/icons/bumper.png", modType = 44, priceMult = 6.05},
            {label = "หน้าต่าง", img = "img/icons/door.png", modType = 46, priceMult = 1.0}
        },
        onBack = function()
            updateMenu("visual")
        end
    },
    ["inside_parts"] = {
        title = "ชิ้นส่วนภายใน",
        options = {
            {label = "แผงควบคุม", img = "img/icons/dashboard.png", modType = 29, priceMult = 4.65},
            {label = "วิทยุ", img = "img/icons/dashboard.png", modType = 30, priceMult = 4.19},
            {
                label = "ลำโพงข้างประตู",
                img = "img/icons/speaker.png",
                modType = 31,
                priceMult = 5.58,
                onSelect = function()
                    openDoors(customVehicle, {1, 1, 1, 1, 0, 0, 0})
                end
            },
            {label = "ที่นั่ง", img = "img/icons/seat.png", modType = 32, priceMult = 4.65},
            {label = "พวงมาลัย", img = "img/icons/steering_wheel.png", modType = 33, priceMult = 4.19},
            {label = "คันเกียร์", img = "img/icons/shifter_leaver.png", modType = 34, priceMult = 3.26},
            {label = "เครื่องประดับ", img = "img/icons/accessories.png", modType = 28, priceMult = 0.9}
        },
        onBack = function()
            updateMenu("visual")
        end
    },
    ["respray"] = {
        title = "สี",
        options = {
            {
                label = "สีหลัก",
                img = "img/icons/respray.png",
                modType = "color1",
                customType = "customColor",
                priceMult = 1.12,
                onSelect = function()
                    openColorPicker("Primary Color", "color1", true, 0.5)
                end
            },
            {
                label = "สีรอง",
                img = "img/icons/respray.png",
                modType = "color2",
                customType = "customColor",
                priceMult = 0.66,
                onSelect = function()
                    openColorPicker("Secondary Color", "color2", true, 0.5)
                end
            },
            {label = "ประเภทสีหลัก", img = "img/icons/respray.png", modType = "paintType1", priceMult = 0.5},
            {label = "ประเภทสีรอง", img = "img/icons/respray.png", modType = "paintType2", priceMult = 0.5},
            {
                label = "เงา",
                img = "img/icons/respray.png",
                modType = "pearlescentColor",
                customType = "color",
                priceMult = 0.88,
                onSelect = function()
                    openColorPicker("Pearlescent Color", "pearlescentColor", false, 0.5)
                end
            }
        },
        onBack = function()
            updateMenu("visual")
        end
    },
    ["wheels"] = {
        title = "ล้อ",
        options = {
            {label = "ประเภทล้อ", img = "img/icons/wheel.png", onSelect = function()
                    updateMenu("wheels_type")
                end},
            {
                label = "สีล้อ",
                img = "img/icons/respray.png",
                modType = "wheelColor",
                customType = "color",
                priceMult = 0.66,
                onSelect = function()
                    openColorPicker("Wheels Color", "wheelColor", false, 0.5)
                end
            },
            {
                label = "สีควัน",
                img = "img/icons/respray.png",
                modType = "tyreSmokeColor",
                customType = "customColor",
                priceMult = 1.12,
                onSelect = function()
                    openColorPicker("Tyre Smoke Color", "tyreSmokeColor", true, 0.5)
                end
            }
        },
        onBack = function()
            updateMenu("visual")
            SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
        end
    },
    ["wheels_type"] = {
        title = "ประเภทล้อ",
        options = {
            {label = "Sport", img = "img/icons/wheel.png", modType = 23, priceMult = 1.65, onSelect = function()
                    SetVehicleModData(customVehicle, "wheels", 0)
                end},
            {label = "Muscle ", img = "img/icons/wheel.png", modType = 23, priceMult = 1.65, onSelect = function()
                    SetVehicleModData(customVehicle, "wheels", 1)
                end},
            {label = "Lowrider", img = "img/icons/wheel.png", modType = 23, priceMult = 1.65, onSelect = function()
                    SetVehicleModData(customVehicle, "wheels", 2)
                end},
            {label = "SUV", img = "img/icons/wheel.png", modType = 23, priceMult = 1.65, onSelect = function()
                    SetVehicleModData(customVehicle, "wheels", 3)
                end},
            {label = "Offroad", img = "img/icons/wheel.png", modType = 23, priceMult = 1.65, onSelect = function()
                    SetVehicleModData(customVehicle, "wheels", 4)
                end},
            {label = "Tuner", img = "img/icons/wheel.png", modType = 23, priceMult = 1.65, onSelect = function()
                    SetVehicleModData(customVehicle, "wheels", 5)
                end},
            {label = "Bike Wheels", img = "img/icons/wheel.png", modType = 23, priceMult = 1.65, onSelect = function()
                    SetVehicleModData(customVehicle, "wheels", 6)
                end},
            {label = "High End", img = "img/icons/wheel.png", modType = 23, priceMult = 1.65, onSelect = function()
                    SetVehicleModData(customVehicle, "wheels", 7)
                end}
        },
        onBack = function()
            updateMenu("wheels")
        end
    },
    ["plate"] = {
        title = "ป้ายทะเบียน",
        options = {
            {label = "Type", img = "img/icons/plate.png", modType = 25, priceMult = 1.1},
            {
                label = "สี",
                img = "img/icons/respray.png",
                modType = "plateIndex",
                priceMult = 1.1,
                onSelect = function()
                    moveToCameraToBoneSmoth(
                        customCamMain,
                        customCamSec,
                        customVehicle,
                        "bumper_r",
                        {x = -2.0, y = -2.0, z = 1.5},
                        {x = -30.0, y = 0.0, z = 0.0}
                    )
                end,
                onSubBack = function()
                    SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
                end
            },
            {label = "Holder", img = "img/icons/bumper.png", modType = 26, priceMult = 3.49}
        },
        onBack = function()
            updateMenu("visual")
        end
    },
    ["lights"] = {
        title = "ไฟรถ",
        options = {
            {
                label = "ไฟหน้ารถ",
                img = "img/icons/headlights.png",
                modType = "modXenon",
                priceMult = 0.1,
                onSelect = function()
                    SetVehicleEngineOn(customVehicle, true, false, false)
                end
            },
            {
                label = "ไฟใต้ท้องรถ",
                img = "img/icons/headlights.png",
                modType = "neonColor",
                customType = "customColor",
                priceMult = 1.12,
                onSelect = function()
                    SetVehicleEngineOn(customVehicle, true, false, false)
                    openColorPicker("Neon Color", "neonColor", true, 0.5)
                end
            }
        },
        onBack = function()
            updateMenu("visual")
        end
    },
    ["stickers"] = {
        title = "สติกเกอร์",
        options = {
            {label = "สติกเกอร์", img = "img/icons/respray.png", modType = 48, priceMult = 6.0},
            {label = "เครื่องแบบ", img = "img/icons/respray.png", modType = "livery", priceMult = 6.0}
        },
        onBack = function()
            updateMenu("visual")
        end
    }
}

