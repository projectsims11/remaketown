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
            Coords = vector3(218.44, -729.48, 47.08),
            Distance = 2.0,
            Object = {
                Enable = true,
                Name = 'gr_prop_gr_bench_01b',
                Heading = 249.60,
            },
            Blips = {
                Enable = true,			
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
            Coords = vector3(216.54, -734.54, 47.08),
            Distance = 2.0,
            Object = {
                Enable = true,
                Name = 'gr_prop_gr_bench_01b',
                Heading = 250.30,
            }, 
            Blips = {
                Enable = true,			
                Text = '[Craft] - General',  
                Sprite = 682,			
                Color = 14,			
                Scale = 1.2,	
            }, 
            Text = '~y~โต๊ะคราฟไอเทมทั่วไป',
            Desc = 'สำหรับไอเทม ~b~ทั่วไป',
            AllowJob = {
                ['unemployed'],
            },
            Category = {2}
        },

    },

}
