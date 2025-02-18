Config = {}

Config.Default = {

    Extended = {
        ['Verion'] = true,	-- สูงกว่า 1.6.0 + = true | ต่ำกว่า 1.6.0 = false
        ['UserLicense'] = 'Undg_19gm3ya7jnc3qrx14wu3', -- KEY USER https://discord.gg/k2DVyt5a
        
        ['onPlayerDeath'] = 'esx:onPlayerDeath',
        ['onPlayerLoaded'] = 'esx:playerLoaded',
        ['ApiKey'] = '', -- API KEY YOUTUBE how to get key => https://www.youtube.com/watch?v=44OBOSBd73M
    },

    Manage = {

        Distancespawnprop = 30.0, -- ห้าม spaw ลำโพงถ้าหากพี่ลำโพงอยู่ในระยะ  

        Animation = {
            dict = "anim@heists@money_grab@briefcase",
            anim = "put_down_case",
        },

        Ui = {
            Main = {
                Logo = 'logo.png',
                TextTime = '',
                TextTitle = 'UNDERGROUND',
                TextAuthor = 'THE UNDG+',
            },

            Info = {
                Distance = 10.0, -- ระยะที่จะโชว์ Ui แนะนำให้ตั้งน้อยกว่า Distance ของลำโพง
                Screen3D = {
                    Enable = true, -- ใช้ Ui 3D ไหม 
                    Loop = 10, -- ถ้าใส่น้อย Ui จะยิ่งสมูท แนะนำ 10
                    GrandZ = 1.8 -- ปรับให้ Ui info ขึ้นหรือลง 
                }, 
            },
        },

        Items = {
            [1] = {
                Itemuse = 'speaker', -- ไอเทมที่กดใช้ [ ** ไอเทมจะไม่ลบ แค่มีไอเทมก็สามารถ spawn ลำโพงได้ ** ]
                Distance = 15.0, -- ระยะเสียงของลำโพง หากเจ้าของออกเกินระยะนี้จะุถูกลบลำโพง
                Object = 'prop_amp_01', 
                Outzone = false, -- ถ้าออกจกาโซนจะให้ลบไหม true ลบ | false ไม่ลบ
            },
        }
    },

}
