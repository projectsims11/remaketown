-- ระบบ Discord Log
Config = {}
Config.DC = {
    Enabled = true, -- true = เปิดใช้งาน
    URL_Webhook = 'https://ptb.discord.com/api/webhooks/1032353007016366180/YiZpHvKWiOS-K5S0VJioq-yoYEx_lXnp6r645F3eERRPQzcl9F9UesiAXiDF5UzC4Hi9',
    -- รูปแบบการแสดงข้อมูลในดิสคอส
    Template = {
        color_money = 0x08F896,
        color_black_money = 0xFF0000,
        description = 'Identifier: **%s** | **%s** \n Item: **%s** | **%s** \n Count: **%s** \n Price: **%s** | **%s**'
    }
}