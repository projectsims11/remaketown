Config = {}

Config.esx = 'limit' -- limit, weight

Config.Img = 'nui://Fewthz_inventory/html/img/items/'

Config.Zone = {
    ['Stone'] = {
        KeyBinds = { 
            Start = 38;
            Stop = 73;
        },
        Pos = vector4(2652.530029296875, 2807.110107421875, 34.15999984741211 ,100.0);
    
        Item = {
            Request = {
                Text = 'หิน';
                Name = 'stone';
                Count = 2;
            },
            Get = {
                Text = 'หินสะอาด';
                Name = 'washed_stone';
                Count = 1;
            },
            Bonus = {
                {
			        ItemName = 'crystalgreen';
                    ItemCount = 1;
			        Percent = 15;
			    },
                {
			        ItemName = 'crystalblue';
                    ItemCount = 1;
			        Percent = 15;
			    },
                {
			        ItemName = 'crystalwhite';
                    ItemCount = 1;
			        Percent = 15;
			    },
                {
			        ItemName = 'diamondblack';
                    ItemCount = 1;
			        Percent = 15;
			    },
                {
			        ItemName = 'diamondwhite';
                    ItemCount = 1;
			        Percent = 15;
			    },
            },
        },
    
        Alert = {
            DisplayHelpText = '<font face="athiti">กด ~INPUT_CONTEXT~ ~w~เพื่อโพรเซสหิน</font>',
            Discord = 'Process Stone',
        },
    
        Blip = {
            Use = true,
            Name = '<font face="sarabun">[โพรเซส] หิน</font>',
            Sprite = 478,
            Color = 5,
            Scale = 0.8,
        },
    
        NPC = {
            Show = true,
            ModelName = "mp_m_weed_01",
            ModelHash = 0x917ED459,
        },
    
        
        Duration = 2000;
        Process = function(duration, k)
            TriggerEvent("mythic_progbar:client:progress", {
                name = "Cabbage",
                duration = duration,
                label = "กำลังโพรเซสหิน..",
                useWhileDead = false,
                canCancel = false,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
                    anim = 'machinic_loop_mechandplayer',
                },
            }, function(status)
                if not status then
                    Get(k)
                end
            end)
        end,
    },

    ['Wood'] = {
        KeyBinds = { 
            Start = 38;
            Stop = 73;
        },
        Pos = vector4(-797.8599853515625, 5395.9599609375, 34.31000137329101 ,0);
    
        Item = {
            Request = {
                Text = 'ไม้';
                Name = 'wood';
                Count = 2;
            },
            Get = {
                Text = 'ไม้อัด';
                Name = 'pro_wood';
                Count = 1;
            },
            Bonus = {
                {
			        ItemName = 'water';
                    ItemCount = 1;
			        Percent = 0;
			    },
            },
        },
    
        Alert = {
            DisplayHelpText = '<font face="athiti">กด ~INPUT_CONTEXT~ ~w~เพื่อโพรเซสไม้</font>',
            Discord = 'Process Wood',
        },
    
        Blip = {
            Use = true,
            Name = '<font face="sarabun">[โพรเซส] ไม้</font>',
            Sprite = 478,
            Color = 21,
            Scale = 0.8,
        },
    
        NPC = {
            Show = true,
            ModelName = "mp_m_weed_01",
            ModelHash = 0x917ED459,
        },
    
        
        Duration = 2000;
        Process = function(duration, k)
            TriggerEvent("mythic_progbar:client:progress", {
                name = "Cabbage",
                duration = duration,
                label = "กำลังโพรเซสไม้..",
                useWhileDead = false,
                canCancel = false,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
                    anim = 'machinic_loop_mechandplayer',
                },
            }, function(status)
                if not status then
                    Get(k)
                end
            end)
        end,
    },

    ['Rice'] = {
        KeyBinds = { 
            Start = 38;
            Stop = 73;
        },
        Pos = vector4(2070.4599609375, 4939.9599609375, 40.97000122070312 ,180.0);
    
        Item = {
            Request = {
                Text = 'ข้าวเปลือก';
                Name = 'rice';
                Count = 2;
            },
            Get = {
                Text = 'ข้าวสาร';
                Name = 'rice_pro';
                Count = 1;
            },
            Bonus = {
                {
			        ItemName = 'water';
                    ItemCount = 1;
			        Percent = 0;
			    },
            },
        },
    
        Alert = {
            DisplayHelpText = '<font face="athiti">กด ~INPUT_CONTEXT~ ~w~เพื่อโพรเซสข้าว</font>',
            Discord = 'Process Rice',
        },
    
        Blip = {
            Use = true,
            Name = '<font face="sarabun">[โพรเซส] ข้าว</font>',
            Sprite = 478,
            Color = 36,
            Scale = 0.8,
        },
    
        NPC = {
            Show = true,
            ModelName = "mp_m_weed_01",
            ModelHash = 0x917ED459,
        },
    
        
        Duration = 2000;
        Process = function(duration, k)
            TriggerEvent("mythic_progbar:client:progress", {
                name = "Cabbage",
                duration = duration,
                label = "กำลังโพรเซสข้าว..",
                useWhileDead = false,
                canCancel = false,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
                    anim = 'machinic_loop_mechandplayer',
                },
            }, function(status)
                if not status then
                    Get(k)
                end
            end)
        end,
    },

    ['Bee'] = {
        KeyBinds = { 
            Start = 38;
            Stop = 73;
        },
        Pos = vector4(289.80999755859375, 6461.85986328125, 30.68000030517578 ,100.0);
    
        Item = {
            Request = {
                Text = 'น้ำผึ้ง';
                Name = 'a_bee';
                Count = 2;
            },
            Get = {
                Text = 'น้ำผึ้งแพ็ค';
                Name = 'b_bee';
                Count = 1;
            },
            Bonus = {
                {
			        ItemName = 'water';
                    ItemCount = 1;
			        Percent = 0;
			    },
            },
        },
    
        Alert = {
            DisplayHelpText = '<font face="athiti">กด ~INPUT_CONTEXT~ ~w~เพื่อโพรเซสน้ำผึ่ง</font>',
            Discord = 'Process Bee',
        },
    
        Blip = {
            Use = true,
            Name = '<font face="sarabun">[โพรเซส] น้ำผึ่ง</font>',
            Sprite = 478,
            Color = 46,
            Scale = 0.8,
        },
    
        NPC = {
            Show = true,
            ModelName = "mp_m_weed_01",
            ModelHash = 0x917ED459,
        },
    
        
        Duration = 2000;
        Process = function(duration, k)
            TriggerEvent("mythic_progbar:client:progress", {
                name = "Cabbage",
                duration = duration,
                label = "กำลังโพรเซสน้ำผึ่ง..",
                useWhileDead = false,
                canCancel = false,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
                    anim = 'machinic_loop_mechandplayer',
                },
            }, function(status)
                if not status then
                    Get(k)
                end
            end)
        end,
    },

    ['Oil'] = {
        KeyBinds = { 
            Start = 38;
            Stop = 73;
        },
        Pos = vector4(580.8099975585938, 2924.1201171875, 40.88000106811523 ,180.0);
    
        Item = {
            Request = {
                Text = 'น้ำมัน';
                Name = 'oil_a';
                Count = 2;
            },
            Get = {
                Text = 'น้ำมันแพ็ค';
                Name = 'oil_b';
                Count = 1;
            },
            Bonus = {
                {
			        ItemName = 'water';
                    ItemCount = 1;
			        Percent = 0;
			    },
            },
        },
    
        Alert = {
            DisplayHelpText = '<font face="athiti">กด ~INPUT_CONTEXT~ ~w~เพื่อโพรเซสน้ำมัน</font>',
            Discord = 'Process Oil',
        },
    
        Blip = {
            Use = true,
            Name = '<font face="sarabun">[โพรเซส] น้ำมัน</font>',
            Sprite = 478,
            Color = 39,
            Scale = 0.8,
        },
    
        NPC = {
            Show = true,
            ModelName = "mp_m_weed_01",
            ModelHash = 0x917ED459,
        },
    
        
        Duration = 2000;
        Process = function(duration, k)
            TriggerEvent("mythic_progbar:client:progress", {
                name = "Cabbage",
                duration = duration,
                label = "กำลังโพรเซสน้ำมัน..",
                useWhileDead = false,
                canCancel = false,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
                    anim = 'machinic_loop_mechandplayer',
                },
            }, function(status)
                if not status then
                    Get(k)
                end
            end)
        end,
    },

    ['Carrot'] = {
        KeyBinds = { 
            Start = 38;
            Stop = 73;
        },
        Pos = vector4(243.55999755859375, 6597.8701171875, 29.8700008392334 ,-50.0);
    
        Item = {
            Request = {
                Text = 'แครอท';
                Name = 'carrot_a';
                Count = 2;
            },
            Get = {
                Text = 'แครอทแพ็ค';
                Name = 'carrot_b';
                Count = 1;
            },
            Bonus = {
                {
			        ItemName = 'water';
                    ItemCount = 1;
			        Percent = 0;
			    },
            },
        },
    
        Alert = {
            DisplayHelpText = '<font face="athiti">กด ~INPUT_CONTEXT~ ~w~เพื่อโพรเซสแครอท</font>',
            Discord = 'Process Carrot',
        },
    
        Blip = {
            Use = true,
            Name = '<font face="sarabun">[โพรเซส] แครอท</font>',
            Sprite = 478,
            Color = 47,
            Scale = 0.8,
        },
    
        NPC = {
            Show = true,
            ModelName = "mp_m_weed_01",
            ModelHash = 0x917ED459,
        },
    
        
        Duration = 2000;
        Process = function(duration, k)
            TriggerEvent("mythic_progbar:client:progress", {
                name = "Cabbage",
                duration = duration,
                label = "กำลังโพรเซสแครอท..",
                useWhileDead = false,
                canCancel = false,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
                    anim = 'machinic_loop_mechandplayer',
                },
            }, function(status)
                if not status then
                    Get(k)
                end
            end)
        end,
    },

    ['Pumpkin'] = {
        KeyBinds = { 
            Start = 38;
            Stop = 73;
        },
        Pos = vector4(484.7699890136719, 6459.10986328125, 30.20999908447265 ,0);
    
        Item = {
            Request = {
                Text = 'ฟักทอง';
                Name = 'pumpkin_a';
                Count = 2;
            },
            Get = {
                Text = 'ฟักทองแพ็ค';
                Name = 'pumpkin_b';
                Count = 1;
            },
            Bonus = {
                {
			        ItemName = 'water';
                    ItemCount = 1;
			        Percent = 0;
			    },
            },
        },
    
        Alert = {
            DisplayHelpText = '<font face="athiti">กด ~INPUT_CONTEXT~ ~w~เพื่อโพรเซสฟักทอง</font>',
            Discord = 'Process Pumpkin',
        },
    
        Blip = {
            Use = true,
            Name = '<font face="sarabun">[โพรเซส] ฟักทอง</font>',
            Sprite = 478,
            Color = 5,
            Scale = 0.8,
        },
    
        NPC = {
            Show = true,
            ModelName = "mp_m_weed_01",
            ModelHash = 0x917ED459,
        },
    
        
        Duration = 2000;
        Process = function(duration, k)
            TriggerEvent("mythic_progbar:client:progress", {
                name = "Cabbage",
                duration = duration,
                label = "กำลังโพรเซสฟักทอง..",
                useWhileDead = false,
                canCancel = false,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
                    anim = 'machinic_loop_mechandplayer',
                },
            }, function(status)
                if not status then
                    Get(k)
                end
            end)
        end,
    },

    ['Bamboo'] = {
        KeyBinds = { 
            Start = 38;
            Stop = 73;
        },
        Pos = vector4(2153.030029296875, 5120.64990234375, 47.33000183105469 ,0);
    
        Item = {
            Request = {
                Text = 'ไม้ไผ่';
                Name = 'bamboo';
                Count = 2;
            },
            Get = {
                Text = 'หน่อไม้';
                Name = 'bamboo_pro';
                Count = 1;
            },
            Bonus = {
                {
			        ItemName = 'water';
                    ItemCount = 1;
			        Percent = 0;
			    },
            },
        },
    
        Alert = {
            DisplayHelpText = '<font face="athiti">กด ~INPUT_CONTEXT~ ~w~เพื่อโพรเซสไผ่</font>',
            Discord = 'Process Bamboo',
        },
    
        Blip = {
            Use = true,
            Name = '<font face="sarabun">[โพรเซส] ไผ่</font>',
            Sprite = 478,
            Color = 43,
            Scale = 0.8,
        },
    
        NPC = {
            Show = true,
            ModelName = "mp_m_weed_01",
            ModelHash = 0x917ED459,
        },
    
        
        Duration = 2000;
        Process = function(duration, k)
            TriggerEvent("mythic_progbar:client:progress", {
                name = "Cabbage",
                duration = duration,
                label = "กำลังโพรเซสไผ่..",
                useWhileDead = false,
                canCancel = false,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
                    anim = 'machinic_loop_mechandplayer',
                },
            }, function(status)
                if not status then
                    Get(k)
                end
            end)
        end,
    },

    ['Mushroom'] = {
        KeyBinds = { 
            Start = 38;
            Stop = 73;
        },
        Pos = vector4(2591.27001953125, 4804.669921875, 34.2400016784668 ,100.0);
    
        Item = {
            Request = {
                Text = 'เห็ดสกปรก';
                Name = 'mushroom_a';
                Count = 2;
            },
            Get = {
                Text = 'เห็ดแพ็ค';
                Name = 'mushroom_b';
                Count = 1;
            },
            Bonus = {
                {
			        ItemName = 'water';
                    ItemCount = 1;
			        Percent = 0;
			    },
            },
        },
    
        Alert = {
            DisplayHelpText = '<font face="athiti">กด ~INPUT_CONTEXT~ ~w~เพื่อโพรเซสเห็ด</font>',
            Discord = 'Process Mushroom',
        },
    
        Blip = {
            Use = true,
            Name = '<font face="sarabun">[โพรเซส] เห็ด</font>',
            Sprite = 478,
            Color = 51,
            Scale = 0.8,
        },
    
        NPC = {
            Show = true,
            ModelName = "mp_m_weed_01",
            ModelHash = 0x917ED459,
        },
    
        
        Duration = 2000;
        Process = function(duration, k)
            TriggerEvent("mythic_progbar:client:progress", {
                name = "Cabbage",
                duration = duration,
                label = "กำลังโพรเซสเห็ด..",
                useWhileDead = false,
                canCancel = false,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
                    anim = 'machinic_loop_mechandplayer',
                },
            }, function(status)
                if not status then
                    Get(k)
                end
            end)
        end,
    },

}