Config = {}

Config.Default = {

    Extended = {
        ['Verion'] = true,	-- สูงกว่า 1.6.0 + = true | ต่ำกว่า 1.6.0 = false
        ['UserLicense'] = 'Undg_b6phj48duluiozccipbk', -- KEY USER https://discord.gg/k2DVyt5a
        
        ['setAccountMoney'] = 'esx:setAccountMoney',
        ['addInventoryItem'] = 'esx:addInventoryItem',
        ['removeInventoryItem'] = 'esx:removeInventoryItem',
        ['setJob'] = 'esx:setJob',
        ['onPlayerDeath'] = 'esx:onPlayerDeath',
        ['onPlayerLoaded'] = 'esx:playerLoaded',

        ['Img-Inventory'] = 'nui://Fewthz_inventory/html/img/items/',
    },

    Manage = {
        
        OpenEonomy = 'E',
        CheckEonomy = 'F10',
        ResetEconomy = 3600,

        Category = {
            [1] = {
                name = 'All',
                icon = '<ion-icon name="briefcase"></ion-icon>',
                itemList = 'all',
            },
            [2] = {
                name = 'Mining',
                icon = '<ion-icon name="hammer"></ion-icon>',
                itemList = {
                    'stone_a',
                },
            },
            [3] = {
                name = 'Fishing',
                icon = '<ion-icon name="fish"></ion-icon>',
                itemList = {
                    'shrimp',
                    'dolly_fish',
                    'squid',
                },
            },
            [4] = {
                name = 'White job',
                icon = '<ion-icon name="logo-usd"></ion-icon>',
                itemList = {
                    'orange',
                    'wheat',
                    'rice',
                    'cabbage',
                    'chemical',
                    'treasure',
                },
            },
            [5] = {
                name = 'Others',
                icon = '<ion-icon name="fast-food-outline"></ion-icon>',
                itemList = {
                    'herb',
                    'wood',

                },
            },
                [6] = {
                    name = 'Process',
                    icon = '<ion-icon name="basket"></ion-icon>',
                    itemList = {
                    'cabbage_process', 
                    'chemi_process',
                    'orange_process',
                    'rice_process',
                    'wheat_process',
    
                    },
            },
        },

        Listitem = {
            [1] = {
                name = 'wood',
                randomPrice = {1,3} -- แก้ราคาแล้ว 3/5/25
            },
            [2] = {
                name = 'orange',
                randomPrice = {15,18} -- แก้ราคาแล้ว 3/5/25
            },
            [3] = {
                name = 'wheat',
                randomPrice = {17,20} -- แก้ราคาแล้ว 3/5/25
            },
            [4] = {
                name = 'rice',
                randomPrice = {17,20} -- แก้ราคาแล้ว 3/5/25
            },
            [5] = {
                name = 'cabbage',
                randomPrice = {15,18} -- แก้ราคาแล้ว 3/5/25
            },
            [6] = {
                name = 'chemical',
                randomPrice = {12,14} -- แก้ราคาแล้ว 3/5/25
            },
            [7] = {
                name = 'herb',
                randomPrice = {5,10} -- แก้ราคาแล้ว 3/5/25
            },
            [8] = {
                name = 'treasure',
                randomPrice = {15,25}
            },
            [9] = {
                name = 'dolly_fish',
                randomPrice = {15,25}
            },
            [10] = {
                name = 'squid',
                randomPrice = {15,25}
            },
            [11] = {
                name = 'shrimp',
                randomPrice = {15,25}
            },
            [12] = {
            name = 'stone_a',
             randomPrice = {1,3} -- แก้ราคาแล้ว 3/5/25      
                
            },
            [13] = {
             name = 'cabbage_process',
            randomPrice = {30,35} -- แก้ราคาแล้ว 3/5/25             
            },
            [14] = {
             name = 'chemi_process',
             randomPrice = {24,28} -- แก้ราคาแล้ว 3/5/25        
           },
           [15] = {
            name = 'orange_process',
            randomPrice = {30,35} -- แก้ราคาแล้ว 3/5/25        
           },
           [16] = {
            name = 'rice_process',
            randomPrice = {33,39} -- แก้ราคาแล้ว 3/5/25        
          },
          [17] = {
            name = 'wheat_process',
            randomPrice = {33,39} -- แก้ราคาแล้ว 3/5/25        
         },
        },
    },

    Zone = {
        [1] = {
            Coords = vector3(288.4881, -1601.3280, 31.2658),
            Blips = {
                enable = true,			-- เปิด true / ปิด false | แสดง Blips บนแผนที่
                Text = "<font face='font4thai'>[ECO] ตลาดขายของ</font>",   -- Text ใน Blip
                Sprite = 276,			-- id | รูปลักษณ์
                Color = 73,				-- สี
                Scale = 1.2,			-- ขนาด
            },
            Objects = {
                Npc = {
                    Enable = true,
                    Model = "a_m_o_soucent_03",					
                    Heading = 346.8237,
                    Animation = {
                        PlayAnimation = true,
                        AnimationDirect = "missheistdockssetup1clipboard@idle_a",
                        AnimationScene = "idle_a",
                    },
                },

                Prop = { 
                    Enable = false, 
                    Model = '',
                    Heading = 274.96,
                },
            },
            Distance = 4.0,  -- ระยะในการเปิดเมนู
            Listitem = {
                'wood',
                'orange',
                'wheat',
                'rice',
                'cabbage',
                'chemical',
                'herb',
                'treasure',
                'dolly_fish',
                'squid',
                'shrimp',
                'stone_a',
                'cabbage_process',
                'chemi_process',       
                'orange_process',                   
                'rice_process',
                'wheat_process',
            },
        },

    },

}
