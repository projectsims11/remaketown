Setting = {} or {} or {}

Setting['Framework'] = exports["es_extended"]:getSharedObject()

Setting["vehicle_plate_length_text"] = 3 -- ความยาวป้ายทะเบียนรถที่จะได้ ตัวอักษร
Setting["vehicle_plate_length_number"] = 3 -- ความยาวป้ายทะเบียนรถที่จะได้ ตัวเลข

Setting["Discord"] = {
    BotLogo = 'LINK IMG',
    Webhook = 'LINK DISCORD',
    Enable = false,
    DiscordLog = function( sendToDiscord, source )
        TriggerEvent('azael_discordlogs:sendToDiscord', 'Fewthz_GIFTBOX', sendToDiscord, source, '^2')	
    end
}

--[[
        1. type = item = ไอเทม money = เงินเขียว black_money = เงินแดง vehicle = รถ weapon = อาวุธ
        2. item = ชื่อ ไอเทม, เงิน, รถ
        3. amount = จำนวน
        4. percent = เปอร์เซ็นต์
]]

Setting['ItemBox'] = {
    [1] = { -- BoxSet #1
        usebox = 'newplayer_box',
        remove = 1,
        GiveItem = {
            { type = 'item', item = 'gold', amount = 1, percent = 100, },
            { type = 'money', item = 'money', amount = 100, percent = 100, },
            { type = 'black_money', item = 'black_money', amount = 100, percent = 100, },
            { type = 'vehicle', item = 't20', amount = 1, percent = 100, },
            { type = 'weapon', item = 'weapon_bat', amount = 1, percent = 100, },
        }
    },
    [2] = { -- BoxSet #2
        usebox = 'boxweapon2',
        remove = 1,
        GiveItem = {
            { type = 'item', item = 'gold', amount = 1, percent = 100, },
            { type = 'money', item = 'money', amount = 100, percent = 100, },
            { type = 'black_money', item = 'black_money', amount = 100, percent = 100, },
            { type = 'vehicle', item = 't20', amount = 1, percent = 100, },
            { type = 'weapon', item = 'weapon_bat', amount = 1, percent = 100, },
        }
    },

}