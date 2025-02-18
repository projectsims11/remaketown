Config                       = {}
-- ██████╗  ██████╗ ██╗  ██╗   ██╗    ██╗     ███████╗ █████╗ ██╗  ██╗███████╗ 
-- ██╔══██╗██╔═══██╗██║  ╚██╗ ██╔╝    ██║     ██╔════╝██╔══██╗██║ ██╔╝██╔════╝ 
-- ██████╔╝██║   ██║██║   ╚████╔╝     ██║     █████╗  ███████║█████╔╝ ███████╗ 
-- ██╔═══╝ ██║   ██║██║    ╚██╔╝      ██║     ██╔══╝  ██╔══██║██╔═██╗ ╚════██║ 
-- ██║     ╚██████╔╝███████╗██║       ███████╗███████╗██║  ██║██║  ██╗███████║ 
-- ╚═╝      ╚═════╝ ╚══════╝╚═╝       ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝ 
-- [discord.gg/gaJJjnKGpg] 
Config.Framework             = 'esx'                  -- esx, oldesx, qb, oldqb

Config.CurrencyUnit          = '$'                   -- '€' -- '₺'  '$'
Config.SQL                   = "oxmysql"             -- oxmysql / mysql-async / ghmattimysql
Config.Inventory             = "Fewthz_inventory"        -- qb_inventory / esx_inventory / ox_inventory / qs_inventory / codem-inventory
Config.ServeName             = "TWORST"              -- Server Name MAX 10
Config.MoneyType             = "$"                   -- Money Type
Config.InteractionHandler    = 'drawtext'            --  qb-target, drawtext,ox-target
Config.ExampleProfilePicture = "https://r2.fivemanage.com/biv23I9cFWICSObhZsr4C/LogoNEW.png"
Config.JobResetCommand       = "jobresetelectrician" -- Job Reset Command

Config.Electrician           = {
    ['coords'] = {
        ['intreactionCoords'] = vector3(528.77, -1603.26, 29.34),
        ['ped'] = true,
        ['pedCoords'] = vector3(528.77, -1603.26, 29.34),
        ['pedHeading'] = 46.59,
        ['pedHash'] = 0x49EA5685,
    },
    ['job'] = 'all',
    ['blip'] = {
        show = true,
        blipName = 'Electrician Job',
        blipType = 643,
        blipColor = 3,
        blipScale = 0.55
    },
    ['missionBlips'] = {
        SetBlipSprite = 354,
        SetBlipColour = 5,
        SetBlipScale = 0.85,
        SetBlipDisplay = 4
    },
    ['marker'] = {
        ['type'] = 1,
        ['size'] = vector3(528.77, -1603.26, 29.34),
        ['color'] = { r = 0, g = 255, b = 0 },
    },
    ['drawtext'] = {
        ['text'] = "Press ~g~[E]~s~ to open the ~g~Electrician~s~",
        ['deliverVehile'] = "Deliver Vehicle - [E]",
        ['fixHouseBoard'] = "Press ~g~[E]~s~ to open the ~g~Panel~s~",
        ['fixTrafo'] = "Press ~g~[E]~s~ to open the ~g~Panel~s~",
        ['buildlift'] = "Press ~g~[E]~s~ to build  a  ~g~Lift~s~",
        ['phonePole'] = "Press ~g~[E]~s~ to fix the ~g~Telephone Pole~s~",
        ['buildladder'] = "Press ~g~[E]~s~ to build  a  ~g~Ladder~s~",
        ['fixStreetLamp'] = "Press ~g~[E]~s~ to fix the ~g~Street Lamp~s~",
        ['removelift'] = "Press ~g~[E]~s~ to remove a ~g~Lift~s~",
        ['removeladder'] = "Press ~g~[E]~s~ to remove a ~g~Ladder~s~",
        ['fixTrafficLamp'] = "Press ~g~[E]~s~ to fix the ~g~Traffic Light~s~",
    },
    ['jobVehicle'] = 'utillitruck2', --
    ['jobVehicle2'] = {
        vehicleName = 'utillitruck3',
        jobVehicle2 = true
    },

    ['jobDeliverTheVehicleCoords'] = vector3(-849.16, 6592.56, 0.55),
    ['regionData'] = {
        {
            regionKey = 1,
            regionRandomCount = math.random(2, 2),
            regiontrafficLampCoords = {
                {
                    regiontrafficKey = 1,
                    regionAreaCoords = vector3(190.38, -334.78, 44.07),
                    regionareaDistance = 60.0,
                    regionTrafficCoords = {
                        { coords = vector3(202.474304, -325.591614, 42.971840), fixed = false },
                        { coords = vector3(179.57, -323.06, 42.97),             fixed = false },
                        { coords = vector3(165.74, -349.88, 43.03),             fixed = false },
                        { coords = vector3(202.9, -358.29, 43.01),              fixed = false }
                    },
                    regionFixedTrafo = { coords = vector3(213.66, -336.3, 43.91), fixed = false },
                    regionFixedTrafoText = "Press ~g~[E]~s~ to fix the ~g~Electricity~s~",
                },
                {
                    regiontrafficKey = 2,
                    regionAreaCoords = vector3(281.89, -81.66, 70.15),
                    regionareaDistance = 60.0,
                    regionTrafficCoords = {
                        { coords = vector3(269.01, -69.17, 69.41),  fixed = false },
                        { coords = vector3(298.31, -61.79, 69.34),  fixed = false },
                        { coords = vector3(264.46, -98.06, 69.38),  fixed = false },
                        { coords = vector3(289.54, -101.47, 69.61), fixed = false }
                    },
                    regionFixedTrafo = { coords = vector3(255.42, -84.03, 70.28), fixed = false },
                    regionFixedTrafoText = "Press ~g~[E]~s~ to fix the ~g~Electricity~s~",
                },
                {
                    regiontrafficKey = 3,
                    regionAreaCoords = vector3(-42.61, 36.03, 72.21),
                    regionareaDistance = 60.0,
                    regionTrafficCoords = {
                        { coords = vector3(-32.58, 45.87, 71.98), fixed = false },
                        { coords = vector3(-57.32, 48.68, 71.26), fixed = false },
                        { coords = vector3(-55.91, 23.19, 71.92), fixed = false },
                        { coords = vector3(-24.38, 18.25, 71.45), fixed = false }
                    },
                    regionFixedTrafo = { coords = vector3(-28.61, 45.4, 72.3), fixed = false },
                    regionFixedTrafoText = "Press ~g~[E]~s~ to fix the ~g~Electricity~s~",
                },
            },
            regionstreetLampCoords = {
                { coords = vector3(296.49, -348.94, 49.62), fixed = false, open = false },
                { coords = vector3(300.07, -339.12, 50.92), fixed = false, open = false },

                { coords = vector3(303.89, -329.46, 51.08), fixed = false, open = false },
                { coords = vector3(268.28, -316.47, 51.2),  fixed = false, open = false },

                { coords = vector3(286.73, -323.17, 50.03), fixed = false, open = false },
                { coords = vector3(283.16, -332.94, 50.2),  fixed = false, open = false },

            },
            regionhouseBoardCoords = {
                { coords = vector3(215.55, -143.54, 58.55), fixed = false, open = false },
                { coords = vector3(229.16, -112.05, 69.73), fixed = false, open = false },
                { coords = vector3(151.14, -90.72, 64.27),  fixed = false, open = false },
                { coords = vector3(57.32, -77.21, 62.26),   fixed = false, open = false },
                { coords = vector3(49.02, -92.97, 61.28),   fixed = false, open = false },
                { coords = vector3(48.46, -94.49, 61.26),   fixed = false, open = false },
                { coords = vector3(51.46, -60.3, 67.46),    fixed = false, open = false },
            },
            regionstreetTrafoCoords = {
                { coords = vector3(-36.78, -1577.22, 29.52),  fixed = false, open = false },
                { coords = vector3(-93.2, -1530.56, 34.0),    fixed = false, open = false },
                { coords = vector3(-115.57, -1553.29, 34.33), fixed = false, open = false },
            },
            regionphonePoleCoords = {
                { coords = vector3(-40.54, -1379.22, 40.37), fixed = false, open = false },
                { coords = vector3(0.73, -1378.96, 38.61),   fixed = false, open = false },
                { coords = vector3(-5.01, -1355.6, 39.46),   fixed = false, open = false },
                { coords = vector3(-45.92, -1355.53, 38.78), fixed = false, open = false },

            },
            regionJobTask = {
                {
                    jobName = "fixTrafo",
                    jobBlipLabel = "Trafo",
                    jobCount = 1,
                    jobLabel = " Repair Transformer"
                },
                {
                    jobName = "fixHouseBoard",
                    jobBlipLabel = "House Board",
                    jobCount = 1,
                    jobLabel = " Repair the Electric Panel of Houses"
                },
                {
                    jobName = "fixStreetLamp",
                    jobBlipLabel = "Street Lamp",
                    jobCount = 1,
                    jobLabel = " Repair Number of Street Lights"
                },
                {
                    jobName = "fixTrafficLamp",
                    jobBlipLabel = "Traffic Lamp Board",
                    jobCount = 1,
                    jobLabel = " Repair a Traffic Light"
                },
                {
                    jobName = "phonePole",
                    jobBlipLabel = "Phone Pole",
                    jobCount = 2,
                    jobLabel = " Repair Telephone Poles"
                },

            },
            regionInfo = {
                regionTitle = "Los Santos",
                regionDetails = "Lorem ipsum dolor sit amet consectetur. Quis mi nec nibh leo at scelerisque sagittis.",
                regionJobTask =
                "Lorem ipsum dolor sit amet consectetur. Nec fermentum placerat iaculis lacus ac hendrerit vel. Urna vitae et amet sit amet lectus egestas turpis a.",
                regionImage = "region.png"
            },
            regionMaxPlayer = 4,
            regionMinimumLevel = 0,
            regionAwards = {
                money = 5000,
                xp = 1000,
                onlineJobExtraAwards = 2
            },

            regionItems = {
                {
                    itemCount = 1,
                    itemLabel = "Utility TruckCar",
                    itemImage = "item.png"
                },

            },
            regionSpawnCoords = {
                vector4(533.26, -1595.88, 28.52, 136.32),
                vector4(522.83, -1606.42, 28.64, 320.61),
            },
            regionDeliveryCoords = vector3(533.26, -1595.88, 28.52)
        },
        {
            regionKey = 2,
            regionRandomCount = math.random(2, 2),
            regiontrafficLampCoords = {
                {
                    regiontrafficKey = 1,
                    regionAreaCoords = vector3(826.05, -1748.74, 29.48),
                    regionareaDistance = 80.0,
                    regionTrafficCoords = {
                        { coords = vector3(850.0, -1766.74, 29.17),  fixed = false },
                        { coords = vector3(847.65, -1728.46, 30.06), fixed = false },
                        { coords = vector3(806.26, -1766.21, 29.67), fixed = false },
                        { coords = vector3(802.22, -1732.87, 29.37), fixed = false }
                    },
                    regionFixedTrafo = { coords = vector3(847.52, -1775.7, 29.03), fixed = false },
                    regionFixedTrafoText = "Press ~g~[E]~s~ to fix the ~g~Electricity~s~",
                },
                {
                    regiontrafficKey = 2,
                    regionAreaCoords = vector3(1069.35, -1749.13, 35.75),
                    regionareaDistance = 60.0,
                    regionTrafficCoords = {
                        { coords = vector3(1070.4, -1731.48, 36.09),  fixed = false },
                        { coords = vector3(1054.6, -1742.6, 36.21),   fixed = false },
                        { coords = vector3(1084.83, -1758.5, 35.85),  fixed = false },
                        { coords = vector3(1070.41, -1770.23, 36.32), fixed = false }
                    },
                    regionFixedTrafo = { coords = vector3(1084.76, -1767.04, 35.96), fixed = false },
                    regionFixedTrafoText = "Press ~g~[E]~s~ to fix the ~g~Electricity~s~",
                },
            },
            regionstreetLampCoords = {
                { coords = vector3(825.12, -2247.5, 36.11),  fixed = false, open = false },
                { coords = vector3(859.92, -2250.55, 36.17), fixed = false, open = false },

                { coords = vector3(910.08, -2236.19, 36.55), fixed = false, open = false },
                { coords = vector3(923.31, -2257.48, 36.27), fixed = false, open = false },


            },
            regionhouseBoardCoords = {
                { coords = vector3(709.88, -2139.19, 29.07), fixed = false, open = false },
                { coords = vector3(709.05, -2149.26, 28.96), fixed = false, open = false },
                { coords = vector3(708.18, -2158.47, 29.45), fixed = false, open = false },
                { coords = vector3(707.28, -2168.47, 28.75), fixed = false, open = false },
            },
            regionstreetTrafoCoords = {
                { coords = vector3(971.73, -1810.68, 31.03), fixed = false, open = false },
                { coords = vector3(963.1, -1828.73, 30.96),  fixed = false, open = false },
                { coords = vector3(961.2, -1808.28, 30.99),  fixed = false, open = false },
            },
            regionphonePoleCoords = {
                { coords = vector3(830.6, -2248.05, 40.53),  fixed = false, open = false },
                { coords = vector3(894.94, -2253.68, 40.58), fixed = false, open = false },
                { coords = vector3(776.15, -2284.71, 38.18), fixed = false, open = false },

            },
            regionJobTask = {
                {
                    jobName = "fixTrafo",
                    jobBlipLabel = "Trafo",
                    jobCount = 2,
                    jobLabel = " Repair Transformer"
                },
                {
                    jobName = "fixHouseBoard",
                    jobBlipLabel = "House Board",
                    jobCount = 2,
                    jobLabel = " Repair the Electric Panel of Houses"
                },
                {
                    jobName = "fixStreetLamp",
                    jobBlipLabel = "Street Lamp",
                    jobCount = 2,
                    jobLabel = " Repair Number of Street Lights"
                },
                {
                    jobName = "fixTrafficLamp",
                    jobBlipLabel = "Traffic Lamp Board",
                    jobCount = 2,
                    jobLabel = " Repair a Traffic Light"
                },
                {
                    jobName = "phonePole",
                    jobBlipLabel = "Phone Pole",
                    jobCount = 2,
                    jobLabel = " Repair Telephone Poles"
                },

            },
            regionInfo = {
                regionTitle = "Los Santos",
                regionDetails = "Lorem ipsum dolor sit amet consectetur. Quis mi nec nibh leo at scelerisque sagittis.",
                regionJobTask =
                "Lorem ipsum dolor sit amet consectetur. Nec fermentum placerat iaculis lacus ac hendrerit vel. Urna vitae et amet sit amet lectus egestas turpis a.",
                regionImage = "region.png"
            },
            regionMaxPlayer = 4,
            regionMinimumLevel = 0,
            regionAwards = {
                money = 7500,
                xp = 1250,
                onlineJobExtraAwards = 2
            },

            regionItems = {
                {
                    itemCount = 1,
                    itemLabel = "Utility TruckCar",
                    itemImage = "item.png"
                },

            },
            regionSpawnCoords = {
                vector4(533.26, -1595.88, 28.52, 136.32),
                vector4(522.83, -1606.42, 28.64, 320.61),
            },
            regionDeliveryCoords = vector3(533.26, -1595.88, 28.52)
        },
        {
            regionKey = 3,
            regionRandomCount = math.random(2, 2),
            regiontrafficLampCoords = {
                {
                    regiontrafficKey = 1,
                    regionAreaCoords = vector3(-1292.11, -1191.35, 4.94),
                    regionareaDistance = 60.0,
                    regionTrafficCoords = {
                        { coords = vector3(-1292.26, -1177.19, 4.65), fixed = false },
                        { coords = vector3(-1280.68, -1192.81, 4.73), fixed = false },
                        { coords = vector3(-1296.91, -1207.0, 4.68),  fixed = false },
                        { coords = vector3(-1312.14, -1192.63, 4.79), fixed = false }
                    },
                    regionFixedTrafo = { coords = vector3(-1294.27, -1168.6, 4.82), fixed = false },
                    regionFixedTrafoText = "Press ~g~[E]~s~ to fix the ~g~Electricity~s~",
                },
                {
                    regiontrafficKey = 2,
                    regionAreaCoords = vector3(-1156.02, -1342.97, 5.11),
                    regionareaDistance = 60.0,
                    regionTrafficCoords = {
                        { coords = vector3(-1142.21, -1347.99, 4.92), fixed = false },
                        { coords = vector3(-1155.17, -1321.17, 4.97), fixed = false },
                        { coords = vector3(-1174.77, -1336.53, 4.93), fixed = false },
                        { coords = vector3(-1157.31, -1360.53, 5.31), fixed = false }
                    },
                    regionFixedTrafo = { coords = vector3(-1144.98, -1355.85, 4.85), fixed = false },
                    regionFixedTrafoText = "Press ~g~[E]~s~ to fix the ~g~Electricity~s~",
                },
            },
            regionstreetLampCoords = {
                { coords = vector3(-1136.04, -1317.53, 10.8),  fixed = false, open = false },
                { coords = vector3(-1098.24, -1324.26, 11.02), fixed = false, open = false },
                { coords = vector3(-1077.21, -1333.9, 11.91),  fixed = false, open = false },
            },
            regionhouseBoardCoords = {
                { coords = vector3(-1114.89, -1218.55, 2.82), fixed = false, open = false },
                { coords = vector3(-1108.51, -1223.37, 2.73), fixed = false, open = false },
                { coords = vector3(-1114.95, -1260.07, 7.12), fixed = false, open = false },
            },
            regionstreetTrafoCoords = {
                { coords = vector3(-1266.89, -1120.51, 7.17), fixed = false, open = false },
                { coords = vector3(-1255.37, -1153.72, 7.9),  fixed = false, open = false },
                { coords = vector3(-1248.24, -1193.38, 8.43), fixed = false, open = false },
            },
            regionphonePoleCoords = {
                { coords = vector3(-1268.56, -1034.12, 19.06), fixed = false, open = false },
                { coords = vector3(-1281.57, -1070.53, 16.77), fixed = false, open = false },
                { coords = vector3(-1295.11, -1077.0, 17.07),  fixed = false, open = false },

            },
            regionJobTask = {
                {
                    jobName = "fixTrafo",
                    jobBlipLabel = "Trafo",
                    jobCount = 3,
                    jobLabel = " Repair Transformer"
                },
                {
                    jobName = "fixHouseBoard",
                    jobBlipLabel = "House Board",
                    jobCount = 3,
                    jobLabel = " Repair the Electric Panel of Houses"
                },
                {
                    jobName = "fixStreetLamp",
                    jobBlipLabel = "Street Lamp",
                    jobCount = 3,
                    jobLabel = " Repair Number of Street Lights"
                },
                {
                    jobName = "fixTrafficLamp",
                    jobBlipLabel = "Traffic Lamp Board",
                    jobCount = 2,
                    jobLabel = " Repair a Traffic Light"
                },
                {
                    jobName = "phonePole",
                    jobBlipLabel = "Phone Pole",
                    jobCount = 3,
                    jobLabel = " Repair Telephone Poles"
                },

            },
            regionInfo = {
                regionTitle = "Los Santos",
                regionDetails = "Lorem ipsum dolor sit amet consectetur. Quis mi nec nibh leo at scelerisque sagittis.",
                regionJobTask =
                "Lorem ipsum dolor sit amet consectetur. Nec fermentum placerat iaculis lacus ac hendrerit vel. Urna vitae et amet sit amet lectus egestas turpis a.",
                regionImage = "region.png"
            },
            regionMaxPlayer = 4,
            regionMinimumLevel = 0,
            regionAwards = {
                money = 10000,
                xp = 1500,
                onlineJobExtraAwards = 2
            },

            regionItems = {
                {
                    itemCount = 1,
                    itemLabel = "Utility TruckCar",
                    itemImage = "item.png"
                },

            },
            regionSpawnCoords = {
                vector4(533.26, -1595.88, 28.52, 136.32),
                vector4(522.83, -1606.42, 28.64, 320.61),
            },
            regionDeliveryCoords = vector3(533.26, -1595.88, 28.52)
        },
        {
            regionKey = 4,
            regionRandomCount = math.random(2, 2),
            regiontrafficLampCoords = {
                {
                    regiontrafficKey = 1,
                    regionAreaCoords = vector3(-699.15, -225.39, 36.99),
                    regionareaDistance = 60.0,
                    regionTrafficCoords = {
                        { coords = vector3(-679.53, -220.59, 37.06), fixed = false },
                        { coords = vector3(-695.05, -205.35, 37.41), fixed = false },
                        { coords = vector3(-723.64, -228.71, 37.38), fixed = false },
                        { coords = vector3(-704.67, -246.78, 37.21), fixed = false }
                    },
                    regionFixedTrafo = { coords = vector3(-675.08, -200.63, 37.19), fixed = false },
                    regionFixedTrafoText = "Press ~g~[E]~s~ to fix the ~g~Electricity~s~",
                },
                {
                    regiontrafficKey = 2,
                    regionAreaCoords = vector3(-635.16, -655.95, 31.73),
                    regionareaDistance = 80.0,
                    regionTrafficCoords = {
                        { coords = vector3(-618.07, -670.83, 31.55), fixed = false },
                        { coords = vector3(-620.31, -639.53, 31.97), fixed = false },
                        { coords = vector3(-656.88, -646.74, 31.57), fixed = false },
                        { coords = vector3(-649.69, -678.12, 31.57), fixed = false }
                    },
                    regionFixedTrafo = { coords = vector3(-619.96, -637.91, 31.51), fixed = false },
                    regionFixedTrafoText = "Press ~g~[E]~s~ to fix the ~g~Electricity~s~",
                },
            },
            regionstreetLampCoords = {
                { coords = vector3(-288.16, -340.08, 35.44), fixed = false, open = false },
                { coords = vector3(-307.27, -320.6, 36.54),  fixed = false, open = false },
                { coords = vector3(-326.56, -292.77, 37.17), fixed = false, open = false },
            },
            regionhouseBoardCoords = {
                { coords = vector3(-1160.88, -214.45, 37.63), fixed = false, open = false },
                { coords = vector3(-1146.97, -361.66, 38.08), fixed = false, open = false },
                { coords = vector3(-678.76, -176.53, 37.67),  fixed = false, open = false },
            },
            regionstreetTrafoCoords = {
                { coords = vector3(-1311.33, -162.08, 45.38), fixed = false, open = false },
                { coords = vector3(-1310.36, -177.1, 43.78),  fixed = false, open = false },
                { coords = vector3(-1350.07, -207.32, 43.82), fixed = false, open = false },
            },
            regionphonePoleCoords = {
                { coords = vector3(-1650.41, -354.58, 60.19), fixed = false, open = false },
                { coords = vector3(-1669.68, -368.92, 60.02), fixed = false, open = false },
                { coords = vector3(-1702.68, -406.54, 57.31), fixed = false, open = false },

            },
            regionJobTask = {
                {
                    jobName = "fixTrafo",
                    jobBlipLabel = "Trafo",
                    jobCount = 3,
                    jobLabel = " Repair Transformer"
                },
                {
                    jobName = "fixHouseBoard",
                    jobBlipLabel = "House Board",
                    jobCount = 3,
                    jobLabel = " Repair the Electric Panel of Houses"
                },
                {
                    jobName = "fixStreetLamp",
                    jobBlipLabel = "Street Lamp",
                    jobCount = 3,
                    jobLabel = " Repair Number of Street Lights"
                },
                {
                    jobName = "fixTrafficLamp",
                    jobBlipLabel = "Traffic Lamp Board",
                    jobCount = 2,
                    jobLabel = " Repair a Traffic Light"
                },
                {
                    jobName = "phonePole",
                    jobBlipLabel = "Phone Pole",
                    jobCount = 3,
                    jobLabel = " Repair Telephone Poles"
                },
            },
            regionInfo = {
                regionTitle = "Los Santos",
                regionDetails = "Lorem ipsum dolor sit amet consectetur. Quis mi nec nibh leo at scelerisque sagittis.",
                regionJobTask =
                "Lorem ipsum dolor sit amet consectetur. Nec fermentum placerat iaculis lacus ac hendrerit vel. Urna vitae et amet sit amet lectus egestas turpis a.",
                regionImage = "region.png"
            },
            regionMaxPlayer = 4,
            regionMinimumLevel = 0,
            regionAwards = {
                money = 15000,
                xp = 2000,
                onlineJobExtraAwards = 2
            },

            regionItems = {
                {
                    itemCount = 1,
                    itemLabel = "Utility TruckCar",
                    itemImage = "item.png"
                },

            },
            regionSpawnCoords = {
                vector4(533.26, -1595.88, 28.52, 136.32),
                vector4(522.83, -1606.42, 28.64, 320.61),
            },
            regionDeliveryCoords = vector3(533.26, -1595.88, 28.52)
        },
    },

}

Config.trafficLightModels    = {
    "prop_traffic_03a",
    "prop_traffic_02a",
    "prop_traffic_01a",
    "prop_traffic_01d",
    "prop_traffic_lightset_01",
    "prop_traffic_01b",
    "prop_traffic_03b",
}

Config.Vehiclekey            = true
Config.VehicleSystem         = "qb-vehiclekeys" -- cd_garage / qs-vehiclekeys / wasabi-carlock / qb-vehiclekeys
Config.Removekeys            = true
Config.RemoveVehicleSystem   =
"qb-vehiclekeys"                                               -- cd_garage / qs-vehiclekeys / wasabi-carlock / qb-vehiclekeys

Config.GiveVehicleKey        = function(plate, model, vehicle) -- you can change vehiclekeys export if you use another vehicle key system
    if Config.Vehiclekey then
        if Config.VehicleSystem == 'cd_garage' then
            TriggerEvent('cd_garage:AddKeys', exports['cd_garage']:GetPlate(vehicle))
        elseif Config.VehicleSystem == 'qs-vehiclekeys' then
            model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
            exports['qs-vehiclekeys']:GiveKeys(plate, model, true)
        elseif Config.VehicleSystem == 'wasabi-carlock' then
            exports.wasabi_carlock:GiveKey(plate)
        elseif Config.VehicleSystem == 'qb-vehiclekeys' then
            TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', plate)
        end
    end
end

Config.RemoveVehiclekey      = function(plate, model, vehicle)
    if Config.Removekeys then
        if Config.RemoveVehicleSystem == 'cd_garage' then
            TriggerServerEvent('cd_garage:RemovePersistentVehicles', exports['cd_garage']:GetPlate(vehicle))
        elseif Config.RemoveVehicleSystem == 'qs-vehiclekeys' then
            model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
            exports['qs-vehiclekeys']:RemoveKeys(plate, model)
        elseif Config.RemoveVehicleSystem == 'wasabi-carlock' then
            exports.wasabi_carlock:RemoveKey(plate)
        elseif Config.RemoveVehicleSystem == 'qb-vehiclekeys' then
            TriggerServerEvent('qb-vehiclekeys:client:RemoveKeys', plate)
        end
    end
end

Config.FuelSystem            = "LegacyFuel"                  -- LegacyFuel / x-fuel

Config.SetVehicleFuel        = function(vehicle, fuel_level) -- you can change LegacyFuel export if you use another fuel system
    if Config.FuelSystem == 'LegacyFuel' then
        return exports["LegacyFuel"]:SetFuel(vehicle, fuel_level)
    elseif Config.FuelSystem == 'x-fuel' then
        return exports["x-fuel"]:SetFuel(vehicle, fuel_level)
    else
        return SetVehicleFuelLevel(vehicle, fuel_level + 0.0)
    end
end

Config.NotificationText      = {
    ['vehicleexist'] = {
        text = "You cannot start a mission because the vehicle is a vehicle in the Spawn Zone",
        type = "errorNotify"
    },

    ['playerfaraway'] = {
        text = "The person you invited is far away",
        type = "infoNotify"
    },

    ['lobbyfull'] = {
        text = "The lobby is full.",
        type = "succesNotify"
    },
    ['jobnotstarted'] = {
        text = "You have not started the job yet.",
        type = "errorNotify"
    },
    ['jobalreadystarted'] = {
        text = "You have already started the job.",
        type = "errorNotify"
    },
    ['maxlevel'] = {
        text = "You have reached the maximum level.",
        type = "errorNotify"
    },
    ['playeralreadyinlobby'] = {
        text = "You are already in the lobby.",
        type = "errorNotify"
    },
    ['missionnotselected'] = {
        text = "You have not selected a mission.",
        type = "errorNotify"
    },
    ['playerleftlobby'] = {
        text = "The mission is terminated because the lobbyist is out of the game.",
        type = "errorNotify"
    },
    ['deliverVehile'] = {
        text = "Deliver the vehicle",
        type = "infoNotify"
    },
    ['missionnotpermit'] = {
        text = "The task you want to access is currently being done by someone else.",
        type = "errorNotify"
    },
    ['resetJob'] = {
        text = "You have reset the job.",
        type = "errorNotify"
    },
    ['notowner'] = {
        text = "You are not the owner of the vehicle.",
        type = "errorNotify"
    },

}

Config.RequiredXP            = {
    [1] = 1000,
    [2] = 1500,
    [3] = 2000,
    [4] = 2500,
    [5] = 3000,
    [6] = 3500,
    [7] = 4000,
    [8] = 4500,
    [9] = 5000,
    [10] = 5500,
    [11] = 6000,
    [12] = 6500,
    [13] = 7000,
    [14] = 7500,
    [15] = 8000,
    [16] = 8500,
    [17] = 9000,
    [18] = 9500,
    [19] = 10000,
    [20] = 10500,
    [21] = 11000,
    [22] = 11500,
    [23] = 12000,
    [24] = 12500,
    [25] = 13000,
    [26] = 13500,
    [27] = 14000,
    [28] = 14500,
    [29] = 15000,
    [30] = 15500,
    [31] = 16000,
    [32] = 16500,
    [33] = 17000,
    [34] = 17500,
    [35] = 18000,
    [36] = 18500,
    [37] = 19000,
    [38] = 19500,
    [39] = 20000,
    [40] = 20500,
    [41] = 21000,
    [42] = 21500,
    [43] = 22000,
    [44] = 22500,
    [45] = 23000,
    [46] = 23500,
    [47] = 24000,
    [48] = 24500,
    [49] = 25000,
    [50] = 25500,
    [51] = 26500,
    [52] = 27500,
    [53] = 28500,
    [54] = 29500,
    [55] = 30500,
    [56] = 31500,
    [57] = 32500,
    [58] = 33500,
    [59] = 34500,
    [60] = 35500,
    [61] = 36500,
    [62] = 37500,
    [63] = 38500,
    [64] = 39500,
    [65] = 40500,
    [66] = 41500,
    [67] = 42500,
    [68] = 43500,
    [69] = 44500,
    [70] = 45500,

}
