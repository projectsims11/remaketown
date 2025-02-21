Config = {}

Config.Default = {

    Extended = {
        ['Verion'] = true,	-- สูงกว่า 1.6.0 + = true | ต่ำกว่า 1.6.0 = false
        ['Base'] = '1.2', -- 1.1 จะใช้เช็คไอเทมแบบ item.limit | 1.2 จะใช้เช็คไอเทมแบบ canCarryItem
        ['UserLicense'] = 'Undg_ky2wdgyofk3xnuipjyg7', -- KEY USER https://discord.gg/k2DVyt5a
        ['onPlayerSpawn'] = 'playerSpawned',
        ['onPlayerDeath'] = 'esx:onPlayerDeath',
        ['onPlayerLoaded'] = 'esx:playerLoaded',
        ['Img-Inventory'] = 'nui://Fewthz_inventory/html/img/items/',
    },
    
    Animation = {
        anim = "cut_cough_coccutter",
        dict = "anim@amb@business@coc@coc_unpack_cut_left@",
    },

    Sound = {
        Failed = {
            name = 'sound/fail.mp3', 
            volume = 0.5,
            maxDistance = 5.0,
        },
        Success = {
            name = 'sound/success.mp3', 
            volume = 0.5,
            maxDistance = 5.0,
        },
    },

    Zone = {
        [1] = {
            Coords = vector3(1728.0931, 3321.7292, 42.0225),
            Distance = 2.0,
            Object = {
                Enable = true,
                Name = 'gr_prop_gr_bench_01b',
                Heading = 15.00,
            },
            Blips = {
                Enable = false,			
                Text = '[Craft] - General',  
                Sprite = 682,			
                Color = 45,			
                Scale = 1.2,	
            },           
            Text = '~y~โต๊ะคราฟไอเทมทั่วไป',
            Desc = 'สำหรับไอเทม ~b~ทั่วไป',
            AllowJob = {
                ['unemployed'],
            },
            Category = {1,2},
        },

        [2] = {
            Coords = vector3(1723.1901, 3306.3252, 41.2235),
            Distance = 2.0,
            Object = {
                Enable = true,
                Name = 'bkr_prop_meth_chiller_01a',
                Heading = 15.00,
            }, 
            Blips = {
                Enable = false,			
                Text = '[Craft] - General',  
                Sprite = 682,			
                Color = 14,			
                Scale = 1.2,	
            }, 
            Text = '~y~โต๊ะคราฟยา',
            Desc = 'สำหรับไอเทม ~b~ทั่วไป',
            AllowJob = {
                ['unemployed'],
            },
            Category = {2}
        },

        [3] = {
            Coords = vector3(-253.6068, -915.9514, 20.5805),
            Distance = 2.0,
            Object = {
                Enable = false,
                Name = 'bkr_prop_meth_chiller_01a',
                Heading = 15.00,
            }, 
            Blips = {
                Enable = false,			
                Text = '[Craft] - Fishing',  
                Sprite = 682,			
                Color = 14,			
                Scale = 1.2,	
            }, 
            Text = '~y~โต๊ะคราฟ แฟชั่น',
            Desc = 'สำหรับคราฟแฟชั่น',
            AllowJob = {
                ['unemployed'],
            },
            Category = {2}
        },

        [3] = {
            Coords = vector3(925.0306, -102.5391, 82.4413),
            Distance = 2.0,
            Object = {
                Enable = true,
                Name = 'prop_cooker_03',
                Heading = 149.2054,
            }, 
            Blips = {
                Enable = false,			
                Text = '<font face="sarabun">เตาทำอาหาร</font>',  
                Sprite = 266,			
                Color = 47,			
                Scale = 0.8,	
            }, 
            Text = '~y~เตาทำอาหาร',
            Desc = 'ปรุงอาหารสดใหม่ที่นี่',
            AllowJob = {
                ['unemployed'],
            },
            Category = {2}
        },
    },

}