Config = {}

Config.TRUNK_EVENT = function(plate)
    TriggerEvent("xzero_trunk:CL:On_OpenInventoryMobile",plate)
end

Config.ReduceCallback = "Fewthz_inventory:getOwnerVehicle"  --event อัพเดตกุญแจ

Config.OBJ = { 
    [1] = {
        prop = "imp_prop_tool_draw_01e", --ชื่อ OBJ
        position = {
            {
                coord = vector3(2939.969970703125, 2813.330078125, 41.70999908447265), heading = 200.87, 
                useobj = true,
                ModelName = "u_m_y_juggernaut_01";
                ModelHash = "u_m_y_juggernaut_01";
                AnimDictionary = "mini@strip_club@idles@bouncer@base";
                AnimationName = "base";
            },
        }
    },
    [2] = {
        prop = "imp_prop_tool_draw_01e", --ชื่อ OBJ
        position = {
            {
                coord = vector3(2557.469970703125, 4825.5, 34.34999847412109), heading = 150.87, 
                useobj = true,
                ModelName = "u_m_y_juggernaut_01";
                ModelHash = "u_m_y_juggernaut_01";
                AnimDictionary = "mini@strip_club@idles@bouncer@base";
                AnimationName = "base";
            },
        }
    },
    [3] = {
        prop = "imp_prop_tool_draw_01e", --ชื่อ OBJ
        position = {
            {
                coord = vector3(2059.260009765625, 4931.009765625, 39.95999908447265), heading = 220.87, 
                useobj = true,
                ModelName = "u_m_y_juggernaut_01";
                ModelHash = "u_m_y_juggernaut_01";
                AnimDictionary = "mini@strip_club@idles@bouncer@base";
                AnimationName = "base";
            },
        }
    },
    [4] = {
        prop = "imp_prop_tool_draw_01e", --ชื่อ OBJ
        position = {
            {
                coord = vector3(2117.860107421875, 5144.60986328125, 48.59000015258789), heading = 300.87, 
                useobj = true,
                ModelName = "u_m_y_juggernaut_01";
                ModelHash = "u_m_y_juggernaut_01";
                AnimDictionary = "mini@strip_club@idles@bouncer@base";
                AnimationName = "base";
            },
        }
    },
    [5] = {
        prop = "imp_prop_tool_draw_01e", --ชื่อ OBJ
        position = {
            {
                coord = vector3(460.1799926757813, 6485.39013671875, 28.3799991607666), heading = 280.87, 
                useobj = true,
                ModelName = "u_m_y_juggernaut_01";
                ModelHash = "u_m_y_juggernaut_01";
                AnimDictionary = "mini@strip_club@idles@bouncer@base";
                AnimationName = "base";
            },
        }
    },
    [6] = {
        prop = "imp_prop_tool_draw_01e", --ชื่อ OBJ
        position = {
            {
                coord = vector3(257.7000122070313, 6482.6201171875, 29.43000030517578), heading = 180.87, 
                useobj = true,
                ModelName = "u_m_y_juggernaut_01";
                ModelHash = "u_m_y_juggernaut_01";
                AnimDictionary = "mini@strip_club@idles@bouncer@base";
                AnimationName = "base";
            },
        }
    },
    [7] = {
        prop = "imp_prop_tool_draw_01e", --ชื่อ OBJ
        position = {
            {
                coord = vector3(268.6900024414063, 6629.52978515625, 28.44000053405761), heading = 180.87, 
                useobj = true,
                ModelName = "u_m_y_juggernaut_01";
                ModelHash = "u_m_y_juggernaut_01";
                AnimDictionary = "mini@strip_club@idles@bouncer@base";
                AnimationName = "base";
            },
        }
    },
    [8] = {
        prop = "imp_prop_tool_draw_01e", --ชื่อ OBJ
        position = {
            {
                coord = vector3(-734.6099853515625, 5344.68017578125, 62.18999862670898), heading = 0.87, 
                useobj = true,
                ModelName = "u_m_y_juggernaut_01";
                ModelHash = "u_m_y_juggernaut_01";
                AnimDictionary = "mini@strip_club@idles@bouncer@base";
                AnimationName = "base";
            },
        }
    },
    [9] = {
        prop = "imp_prop_tool_draw_01e", --ชื่อ OBJ
        position = {
            {
                coord = vector3(578.5499877929688, 2896.030029296875, 38.34999847412109), heading = 280.87, 
                useobj = true,
                ModelName = "u_m_y_juggernaut_01";
                ModelHash = "u_m_y_juggernaut_01";
                AnimDictionary = "mini@strip_club@idles@bouncer@base";
                AnimationName = "base";
            },
        }
    }
}

Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}