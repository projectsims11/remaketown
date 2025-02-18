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
                name = 'ทั้งหมด',
                icon = '<ion-icon name="cube-outline"></ion-icon>',
                itemList = 'all',
            },
            [2] = {
                name = 'Mining',
                icon = '<ion-icon name="key-outline"></ion-icon>',
                itemList = {
                    'stone_b',
                },
            },
            [3] = {
                name = 'Fishing',
                icon = '<ion-icon name="body-outline"></ion-icon>',
                itemList = {
                    'shrimp',
                    'dolly_fish',
                    'squid',
                },
            },
            [4] = {
                name = 'White job',
                icon = '<ion-icon name="hammer-outline"></ion-icon>',
                itemList = {
                    'carrot',
                    'rice',
                    'honey',
                    'pumpkin',
                    'strawberry',
                },
            },
            [5] = {
                name = 'Others',
                icon = '<ion-icon name="fast-food-outline"></ion-icon>',
                itemList = {
                    'chamomile',
                    'wood',

                },
            },
        },

        Listitem = {
            [1] = {
                name = 'carrot',
                randomPrice = {54,80}
            },
            [2] = {
                name = 'honey',
                randomPrice = {80,120}
            },
            [3] = {
                name = 'pumpkin',
                randomPrice = {54,80}
            },
            [4] = {
                name = 'rice',
                randomPrice = {67,100}
            },
            [5] = {
                name = 'wood',
                randomPrice = {20,30}
            },
            [6] = {
                name = 'strawberry',
                randomPrice = {80,120}
            },
            [7] = {
                name = 'stone_b',
                randomPrice = {1,3}
            },
            [8] = {
                name = 'chamomile',
                randomPrice = {20,30}
            },
            [9] = {
                name = 'shrimp',
                randomPrice = {88,117}
            },
            [10] = {
                name = 'dolly_fish',
                randomPrice = {250,334}
            },
            [11] = {
                name = 'squid',
                randomPrice = {400,534}
            },
        },
    },

    Zone = {
        [1] = {
            Coords = vector3(-427.5072, 1116.7429, 326.7816),
            Blips = {
                enable = true,			-- เปิด true / ปิด false | แสดง Blips บนแผนที่
                Text = '[ECONOMY] MAIN',   -- Text ใน Blip
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
                'rice',
                'carrot',
                'honey',
                'pumpkin',
                'wood',
                'strawberry',
                'stone_b',
                'chamomile',
                'shrimp',
                'dolly_fish',
                'squid',

            },
        },

    },

}
