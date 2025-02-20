Config = {};

Config.OnlineTime = 60 * 60;

Config.Points = {

    [10] = {
        name = 'box_skill',
        type= 'item',
        amount = {1,1},
    },
    [20] = {
        name = 'box_skin_1',
        type= 'item',
        amount = {1,1},
    },
    [30] = {
        name = 'box_skin_2',
        type= 'item',
        amount = {1,1},
    },

}

Config.ReceiveBack = {

    [1] = {name = 'money',amount = 5000},
    [2] = {name = 'money',amount = 10000},
    [3] = {name = 'money',amount = 15000},
    [4] = {name = 'money',amount = 20000},
    [5] = {name = 'money',amount = 25000},

    [6] = {name = 'money',amount = 30000},
    [7] = {name = 'money',amount = 35000},
    [8] = {name = 'money',amount = 40000},
    [9] = {name = 'money',amount = 45000},
    [10] = {name = 'money',amount = 50000},

    [11] = {name = 'money',amount = 55000},
    [12] = {name = 'money',amount = 60000},
    [13] = {name = 'money',amount = 65000},
    [14] = {name = 'money',amount = 70000},
    [15] = {name = 'money',amount = 75000},

    [16] = {name = 'money',amount = 80000},
    [17] = {name = 'money',amount = 85000},
    [18] = {name = 'money',amount = 90000},
    [19] = {name = 'money',amount = 95000},
    [20] = {name = 'money',amount = 100000},

    [21] = {name = 'money',amount = 110000},
    [22] = {name = 'money',amount = 120000},
    [23] = {name = 'money',amount = 130000},
    [24] = {name = 'money',amount = 140000},
    [25] = {name = 'money',amount = 150000},

    [26] = {name = 'money',amount = 160000},
    [27] = {name = 'money',amount = 170000},
    [28] = {name = 'money',amount = 180000},
    [29] = {name = 'money',amount = 190000},
    [30] = {name = 'money',amount = 200000},

}

Config.DailyLogin = {

    -- [0] = {
    --     name = 'phone',
    --     type= 'item',
    --     amount = {100,100}, -- true เปิดเมื่อต้องการให้ SHOW รูปภาพเมื่อยังไม่ถึงวัน / false ปิดเมื่อการให้ SHOW (?) แทนรูปภาพเมื่อยังไม่ถึงวัน
    --     -- receive_item = { -- ต้องการกำหนดวิธีการรับของ แต่ถ้าไม่ต้องการให้ **Comments
    --     --     type = 'item', -- TYPE : money, item
    --     --     name = 'stone', -- NAME : [money] - money, bank, black_money / [item] - water, bread
    --     --     amount = 1, -- AMOUNT : 0 - 1,000 / 0 - 10
    --     --     remove = false -- true หากต้องการให้ลบไอเทม ที่ใช้สำหรับการรับไอเทม / false หากไม่ต้องการให้ลบ
    --     -- },
    --     -- receive_back = { -- สามารถกดรับย้อนหลังได้ไหมหากได้ให้เปิดเอาไว้ แต่ถ้าไม่ต้องการให้ **Comments
    --     --     type = '', -- TYPE : money, item
    --     --     name = '', -- NAME : [money] - money, bank, black_money / [item] - water, bread
    --     --     amount = 0, -- AMOUNT : 0 - 1,000 / 0 - 10
    --     --     remove = true -- true หากต้องการให้ลบไอเทม ที่ใช้สำหรับการรับไอเทมย้อนหลัง / false หากไม่ต้องการให้ลบ
    --     -- },
    -- },
    
    [1] = {name = 'gacha_resource',type= 'item',amount = {30,30},},
    [2] = {name = 'gacha_resource2',type= 'item',amount = {20,20},},
    [3] = {name = 'gacha_resource',type= 'item',amount = {30,30},},
    [4] = {name = 'gacha_resource2',type= 'item',amount = {20,20},},

    [5] = {name = 'cement',type= 'item',amount = {5,5},},

    [6] = {name = 'gacha_resource',type= 'item',amount = {30,30},},
    [7] = {name = 'gacha_resource2',type= 'item',amount = {20,20},},
    [8] = {name = 'gacha_resource',type= 'item',amount = {30,30},},
    [9] = {name = 'gacha_resource2',type= 'item',amount = {20,20},},

    [10] = {name = 'cement',type= 'item',amount = {5,5},},

    [11] = {name = 'gacha_resource',type= 'item',amount = {30,30},},
    [12] = {name = 'gacha_resource2',type= 'item',amount = {20,20},},
    [13] = {name = 'gacha_resource',type= 'item',amount = {30,30},},
    [14] = {name = 'gacha_resource2',type= 'item',amount = {20,20},},

    [15] = {name = 'shoe_runner_R',type= 'item',amount = {1,1},},

    [16] = {name = 'gacha_resource',type= 'item',amount = {30,30},},
    [17] = {name = 'gacha_resource2',type= 'item',amount = {20,20},},
    [18] = {name = 'gacha_resource',type= 'item',amount = {30,30},},
    [19] = {name = 'gacha_resource2',type= 'item',amount = {20,20},},

    [20] = {name = 'cement',type= 'item',amount = {5,5},},

    [21] = {name = 'gacha_resource',type= 'item',amount = {30,30},},
    [22] = {name = 'gacha_resource2',type= 'item',amount = {20,20},},
    [23] = {name = 'gacha_resource',type= 'item',amount = {30,30},},
    [24] = {name = 'gacha_resource2',type= 'item',amount = {20,20},},

    [25] = {name = 'cement',type= 'item',amount = {5,5},},
    
    [26] = {name = 'gacha_resource',type= 'item',amount = {30,30},},
    [27] = {name = 'gacha_resource2',type= 'item',amount = {20,20},},
    [28] = {name = 'gacha_resource',type= 'item',amount = {30,30},},
    [29] = {name = 'gacha_resource2',type= 'item',amount = {20,20},},

    [30] = {name = 'shoe_runner_L',type= 'item',amount = {1,1},}

}