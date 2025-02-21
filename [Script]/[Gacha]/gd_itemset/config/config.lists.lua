-- Server Side
-- type = คือประเภทของกล่อง
-- all = ได้รับทั้งหมด
-- random = สุ่ม
-- select_one = เลือกเพียง 1 ชิ้น

-- ประเภทไอเทม
-- item = ไอเทมทั่วไป
-- account = เงิน
-- weapon = อาวุธ
-- vehicle = ยานพาหนะ

Config.ItemSetLists = {
     ['gacha_promote'] = {
          label = 'GACHA PROMOTE',
          type = 'random',
          lists = {
               ['common'] = {
                    rate = 50.0, -- หากปรับเป็น all หรือ select_one ไม่ต้องสนใจ rate
                    items = {
                         { type = 'item', name = 'stone_a', label = "หิน", quantity = 10 },
                         { type = 'item', name = 'wood', label = "ไม้", quantity = 10 },
                    }
               },
               ['uncommon'] = {
                    rate = 40.0,
                    items = {
                         { type = 'account', name = 'money', label = "เงิน", quantity = 100 },
                         { type = 'weapon', name = 'WEAPON_BAT', label = "ไม้เบส", quantity = 100 },
                    }
               },
               ['exotic'] = {
                    rate = 7.0,
                    items = {
                         { type = 'vehicle', name = 'sultan', label = "sultan", quantity = 1, veh_type = 'car', job = '' },
                    }
               },
               ['legendary'] = {
                    rate = 3.0,
                    items = {
                         { type = 'account', name = 'money', label = "เงิน", quantity = 10000 },
                     
                    }
               }
          }
     },
}
