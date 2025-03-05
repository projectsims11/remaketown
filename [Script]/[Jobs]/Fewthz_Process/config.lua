Config = {}

Config.esx = 'limit' -- limit, weight

Config.Img = 'nui://Fewthz_inventory/html/img/items/'

Config.Zone = {
    ['Stone'] = {
        KeyBinds = { 
            Start = 38;
            Stop = 73;
        },
        Pos = vector4(1142.38, 2654.75, 38.15 ,88.96);
    
        Item = {
            Request = {
                Text = 'หิน';
                Name = 'stone_a';
                Count = 2;
            },
            Get = {
                Text = 'หินสะอาด';
                Name = 'exp';
                Count = 1;
            },
            Bonus = {
                {
			        ItemName = 'exp';
                    ItemCount = 1;
			        Percent = 15;
			    },
                {
			        ItemName = 'exp';
                    ItemCount = 1;
			        Percent = 15;
			    },
                {
			        ItemName = 'exp';
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
        Pos = vector4(1141.52, 2642.53, 38.14 , 42.19);
    
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
        Pos = vector4(1125.33, 2641.78, 38.14, 358.43);
    
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
        Pos = vector4(1107.01, 2642.82, 38.14, 314.14);
    
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
        Pos = vector4(1106.21, 2652.74, 38.14 ,269.55);
    
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
}