Config = Config or {}

Config.Food = {
    ["bento"] = {
        eating_duration = 5000,
        item_check = {
            enable = false , 
            item = 'gangcard',
        },

        status_add = {
            {
                status = 'hunger',
                percent = 1000000,
                type = 'add'
            },
        },

        emote = {
            prop = "prop_food_cb_tray_03",
            anim_dict = "mp_player_inteat@burger",
            anim_start = "mp_player_int_eat_burger_enter",
            anim_loop = "mp_player_int_eat_burger",
            Anim_End = "mp_player_int_eat_exit_burger",

            attach = function(prop , ped )
                bone_id = GetPedBoneIndex(ped, 18905)
                AttachEntityToEntity(prop, ped, bone_id, 0.15, 0.040, 0.025, 15.0, 175.0, 0.0, true, true, false, true, 1, true)
            end,
        },

        zone = {
            enable = false ,
            coords = vector3(-3001.9470, 133.8749, 14.9291),
            radius = 50.0,
        }

    },
    ["honey_frappe"] = {
        eating_duration = 5000,
        item_check = {
            enable = false , 
            item = 'gangcard',
        },

        status_add = {
            {
                status = 'stress',
                percent = 1000000,
                type = 'remove'
            },
        },

        emote = {
            prop = "prop_amb_beer_bottle",
            anim_dict = "amb@world_human_drinking@coffee@male@idle_a",
            anim_start = "idle_c",
            anim_loop = "idle_c",
            Anim_End = "idle_c",

            attach = function(prop , ped )
                bone_id = GetPedBoneIndex(ped, 28422)
                AttachEntityToEntity(prop, ped, bone_id, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
            end,
        },

        zone = {
            enable = false ,
            coords = vector3(-3001.9470, 133.8749, 14.9291),
            radius = 50.0,
        },

        -- allowjob = {
        --     'Crimson' ,
        --     'Doomsday',
        --     'Ragnarok',
        --     'Rock',
        --     'Freedom'
        -- }
    },
}

Config.Process = function(itemname , duration)
    TriggerEvent('Heathens.ItemProgress:progress', {
        item = itemname, -- ===> ชื่อไอเทม
        text = 'กินๆๆๆ', -- ===> ข้อความ
        duration = duration, -- ===> เวลาคูลดาวน์ 
    }, function()
    end)
end


Config.Noti = function(message , noti_type)
    TriggerEvent("pNotify:SendNotification", {
        text = message,
        type = noti_type,
        timeout = 3000,
        layout = "centerRight",
        queue = "global"
    })
end