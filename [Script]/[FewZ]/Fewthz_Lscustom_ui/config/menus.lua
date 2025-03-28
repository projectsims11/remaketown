Config = Config or {}

Config.Menus = {
    ['empty'] = {
        title = 'Custom',
        options = {},
    },
    ['main'] = {
        title = 'Custom',
        options = {
            -- {label = 'Repair', img = 'img/icons/repair.png', price = 1000, onSelect = function() repairtVehicle(customVehicle) end},
            {label = 'Body', img = 'img/icons/visual.png', openSubMenu = 'visual'},
            {label = 'Upgrade', img = 'img/icons/upgrade.png', openSubMenu = 'upgrade'}
        },
        onBack = function() closeUI(1) end,
        defaultOption = 1
    },
        ['upgrade'] = {
            title = 'UPGRADES',
            options = {
                {label = 'Engine', img = 'img/icons/engine.png', modType = 11, priceMult = {5.0, 5.0, 7.0, 10.0, 13.0, 15.0}},
                {label = 'Brakes', img = 'img/icons/brakes.png', modType = 12, priceMult = {5.0, 5.0, 7.0, 10.0, 12.0}},
                {label = 'Transmission', img = 'img/icons/transmission.png', modType = 13, priceMult = {5.0, 5.0, 11.0, 13.0, 15.0}},
                {label = 'Suspension', img = 'img/icons/suspension.png', modType = 15, priceMult = {5.0, 5.0, 7.0, 8.0, 9.0, 10.0, 11.0}},
                {label = 'Armor', img = 'img/icons/armor.png', modType = 16, priceMult = {1.0, 3.0, 5.0, 7.0, 19.0, 10.0, 11.0, 13.0}},
                {label = 'Turbo', img = 'img/icons/engine.png', modType = 18, priceMult = {1.0, 13.0}},
            },
            onBack = function() updateMenu('main') end
        },
        ['visual'] = {
            title = 'VISUALS',
            options = {
                {label = 'Body Part', img = 'img/icons/body.png', openSubMenu = 'body_parts'},
                {label = 'Inside Part', img = 'img/icons/body.png', openSubMenu = 'inside_parts'},
                {label = 'Respray', img = 'img/icons/respray.png', openSubMenu = 'respray'},
                {label = 'Wheel', img = 'img/icons/wheel.png', openSubMenu = 'wheels', onSelect = function()
                    moveToCameraToBoneSmoth(customCamMain, customCamSec, customVehicle, 'wheel_lf', {x = -1.8, y = 0.0, z = 0.0}, {x = 0.0, y = 0.0, z = -20.0})
                end},
                {label = 'Plate', img = 'img/icons/plate.png', openSubMenu = 'plate'},
                {label = 'Lights', img = 'img/icons/headlights.png', openSubMenu = 'lights'},
                {label = 'Sticker', img = 'img/icons/respray.png', openSubMenu = 'stickers'},
                {label = 'Extra', img = 'img/icons/plus.png', modType = 'extras', priceMult = 2.00},
                {label = 'Window Tint', img = 'img/icons/door.png', modType = 'windowTint', priceMult = 2.00, onSelect = function()
                    moveToCameraToBoneSmoth(customCamMain, customCamSec, customVehicle, 'window_lf', {x = -2.0, y = 0.0, z = 0.0}, {x = 0.0, y = 0.0, z = -10.0})
                end, onSubBack = function()
                    SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
                end},
                {label = 'Horn', img = 'img/icons/horn.png', modType = 14, priceMult = 5.00},
                {label = 'Interior', img = 'img/icons/body.png', modType = 27, priceMult = 6.00},
                {label = 'Plaques', img = '', modType = 35, priceMult = 5.00},
                {label = 'Speakers', img = 'img/icons/speaker.png', modType = 36, priceMult = 6.00},
                {label = 'Trunk', img = 'img/icons/trunk.png', modType = 37, priceMult = 7.00, onSelect = function() openDoors(customVehicle, {0,0,0,0,0,1,1}) end},
                {label = 'Hydrulics', img = 'img/icons/hydrulics.png', modType = 38, priceMult = 8.00},
                {label = 'Engine Block', img = 'img/icons/engine_block.png', modType = 39, priceMult = 10.00, onSelect = function() openDoors(customVehicle, {0,0,0,0,1,0,0}) end},
                {label = 'Air Filter', img = 'img/icons/air_filter.png', modType = 40, priceMult = 5.00},
                {label = 'Struts', img = 'img/icons/suspension.png', modType = 41, priceMult = 8.00},
                {label = 'Tank', img = 'img/icons/gas_tank.png', modType = 45, priceMult = 7.00},
            },
            onBack = function() updateMenu('main') end
        },
            ['body_parts'] = {
                title = 'BODY PARTS',
                options = {
                    {label = 'Spoilers', img = 'img/icons/spoiler.png', modType = 0, priceMult = 5.00},
                    {label = 'Front Bumper', img = 'img/icons/bumper.png', modType = 1, priceMult = 5.00},
                    {label = 'Rear Bumper', img = 'img/icons/bumper.png', modType = 2, priceMult = 5.00, onSelect = function()
                        moveToCameraToBoneSmoth(customCamMain, customCamSec, customVehicle, 'bumper_r', {x = 0.0, y = -4.0, z = 1.5}, {x = -30.0, y = 0.0, z = 0.0})
                    end, onSubBack = function()
                        SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
                    end},
                    {label = 'Side Skirts', img = 'img/icons/bumper.png', modType = 3, priceMult = 5.00, onSelect = function()
                        moveToCameraToBoneSmoth(customCamMain, customCamSec, customVehicle, 'wheel_lf', {x = -2.5, y = 0.0, z = 0.0}, {x = 0.0, y = 0.0, z = -20.0})
                    end, onSubBack = function()
                        SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
                    end},
                    {label = 'Exhaust', img = 'img/icons/exhaust.png', modType = 4, priceMult = 8.00, onSelect = function()
                        moveToCameraToBoneSmoth(customCamMain, customCamSec, customVehicle, 'bumper_r', {x = 0.0, y = -4.0, z = 1.5}, {x = -30.0, y = 0.0, z = 0.0})
                    end, onSubBack = function()
                        SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
                    end},
                    {label = 'Cage', img = 'img/icons/body.png', modType = 5, priceMult = 5.00, onSelect = function()
                        moveToCameraToBoneSmoth(customCamMain, customCamSec, customVehicle, 'interiorlight', {x = 0.0, y = 1.0, z = -0.1}, {x = 0.0, y = 0.0, z = 0.0})
                    end, onSubBack = function()
                        SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
                    end},
                    {label = 'Grille', img = 'img/icons/gill.png', modType = 6, priceMult = 5.00},
                    {label = 'Hood', img = 'img/icons/hood.png', modType = 7, priceMult = 5.00},
                    {label = 'Left Fender', img = 'img/icons/bumper.png', modType = 8, priceMult = 5.00},
                    {label = 'Right Fender', img = 'img/icons/bumper.png', modType = 9, priceMult = 5.00},
                    {label = 'Roof', img = 'img/icons/roof.png', modType = 10, priceMult = 5.00},
                    {label = 'Arch Cover', img = 'img/icons/bumper.png', modType = 42, priceMult = 5.00},
                    {label = 'Aerials', img = 'img/icons/aerials.png', modType = 43, priceMult = 5.00},
                    {label = 'Wings', img = 'img/icons/bumper.png', modType = 44, priceMult = 5.00},
                    {label = 'Windows', img = 'img/icons/door.png', modType = 46, priceMult = 5.00},
                },
                onBack = function() updateMenu('visual') end
            },
            ['inside_parts'] = {
                title = 'INSIDE PARTS',
                options = {
                    {label = 'Dashboard', img = 'img/icons/dashboard.png', modType = 29, priceMult = 5.00},
                    {label = 'Dial', img = 'img/icons/dashboard.png', modType = 30, priceMult = 5.00},
                    {label = 'Door Speaker', img = 'img/icons/speaker.png', modType = 31, priceMult = 5.00, onSelect = function() openDoors(customVehicle, {1,1,1,1,0,0,0}) end},
                    {label = 'Seat', img = 'img/icons/seat.png', modType = 32, priceMult = 10.00},
                    {label = 'Steering Wheel', img = 'img/icons/steering_wheel.png', modType = 33, priceMult = 5.00},
                    {label = 'Shifter Leaver', img = 'img/icons/shifter_leaver.png', modType = 34, priceMult = 5.00},
                    {label = 'Ornaments', img = '', modType = 28, priceMult = 5.00},
                },
                onBack = function() updateMenu('visual') end
            },
            ['respray'] = {
                title = 'RESPRAY',
                options = {
                    {label = 'Primary', img = 'img/icons/respray.png', modType = 'color1', customType = 'customColor', priceMult = 5.00, onSelect = function() openColorPicker('Primary Color', 'color1', true, 2.0) end},
                    {label = 'Secondary', img = 'img/icons/respray.png', modType = 'color2', customType = 'customColor', priceMult = 5.00, onSelect = function() openColorPicker('Secondary Color', 'color2', true, 2.0) end},
                    {label = 'Primary Paint Type', img = 'img/icons/respray.png', modType = 'paintType1', priceMult = 5.00},
                    {label = 'Secondary Paint Type', img = 'img/icons/respray.png', modType = 'paintType2', priceMult = 5.00},
                    {label = 'Pearlescent', img = 'img/icons/respray.png', modType = 'pearlescentColor', customType = 'color', priceMult = 5.00, onSelect = function() openColorPicker('Pearlescent Color', 'pearlescentColor', false, 2.0) end},
                },
                onBack = function() updateMenu('visual') end
            },
            ['wheels'] = {
                title = 'WHEELS',
                options = {
                    {label = 'Wheels Type', img = 'img/icons/wheel.png', onSelect = function() updateMenu('wheels_type') end},
                    {label = 'Wheels Color', img = 'img/icons/respray.png', modType = 'wheelColor', customType = 'color', priceMult = 5.00, onSelect = function() openColorPicker('Wheels Color', 'wheelColor', false, 0.5) end},
                    {label = 'Smoke Color', img = 'img/icons/respray.png', modType = 'tyreSmokeColor', customType = 'customColor', priceMult = 2.00, onSelect = function() openColorPicker('Tyre Smoke Color', 'tyreSmokeColor', true, 0.5) end},
                },
                onBack = function() updateMenu('visual') SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true) end
            },
                ['wheels_type'] = {
                    title = 'WHEELS TYPE',
                    options = {
                        {label = 'Sport', img = 'img/icons/wheel.png', modType = 23, priceMult = 8.00, onSelect = function() SetVehicleModData(customVehicle, 'wheels', 0) end},
                        {label = 'Muscle ', img = 'img/icons/wheel.png', modType = 23, priceMult = 8.00, onSelect = function() SetVehicleModData(customVehicle, 'wheels', 1) end},
                        {label = 'Lowrider', img = 'img/icons/wheel.png', modType = 23, priceMult = 8.00, onSelect = function() SetVehicleModData(customVehicle, 'wheels', 2) end},
                        {label = 'SUV', img = 'img/icons/wheel.png', modType = 23, priceMult = 8.00, onSelect = function() SetVehicleModData(customVehicle, 'wheels', 3) end},
                        {label = 'Offroad', img = 'img/icons/wheel.png', modType = 23, priceMult = 8.00, onSelect = function() SetVehicleModData(customVehicle, 'wheels', 4) end},
                        {label = 'Tuner', img = 'img/icons/wheel.png', modType = 23, priceMult = 8.00, onSelect = function() SetVehicleModData(customVehicle, 'wheels', 5) end},
                        {label = 'Bike Wheels', img = 'img/icons/wheel.png', modType = 23, priceMult = 8.00, onSelect = function() SetVehicleModData(customVehicle, 'wheels', 6) end},
                        {label = 'High End', img = 'img/icons/wheel.png', modType = 23, priceMult = 8.00, onSelect = function() SetVehicleModData(customVehicle, 'wheels', 7) end},
                    },
                    onBack = function() updateMenu('wheels') end
                },
            ['plate'] = {
                title = 'PLATE',
                options = {
                    {label = 'Type', img = 'img/icons/plate.png', modType = 25, priceMult = 2.00},
                    {label = 'Color', img = 'img/icons/respray.png', modType = 'plateIndex', priceMult = 2.00, onSelect = function()
                        moveToCameraToBoneSmoth(customCamMain, customCamSec, customVehicle, 'bumper_r', {x = -2.0, y = -2.0, z = 1.5}, {x = -30.0, y = 0.0, z = 0.0})
                    end, onSubBack = function()
                        SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
                    end},
                    {label = 'Holder', img = 'img/icons/bumper.png', modType = 26, priceMult = 2.00},
                },
                onBack = function() updateMenu('visual') end
            },
            ['lights'] = {
                title = 'LIGHTS',
                options = {
                    {label = 'Xenon', img = 'img/icons/headlights.png', modType = 'modXenon', priceMult = 5.00, onSelect = function() SetVehicleEngineOn(customVehicle, true, false, false) end},
                    {label = 'Neon', img = 'img/icons/headlights.png', modType = 'neonColor', customType = 'customColor', priceMult = 5.00, onSelect = function() SetVehicleEngineOn(customVehicle, true, false, false) openColorPicker('Neon Color', 'neonColor', true, 0.5) end},
                },
                onBack = function() updateMenu('visual') end
            },
            ['stickers'] = {
                title = 'STICKERS',
                options = {
                    {label = 'Stickers', img = 'img/icons/respray.png', modType = 48, priceMult = 10.00},
                    {label = 'Livery', img = 'img/icons/respray.png', modType = 'livery', priceMult = 10.00},
                },
                onBack = function() updateMenu('visual') end
            },
}