Config = {}

Config.AutoEven = {

    ["ice"] = {
        day = 'Everyday',
        time = "09:00:00", 
        event = function()
            TriggerEvent('zcSword_Auto', 'Random', 2 , 10)
        end
    },
    ["ice1"] = {
        day = 'Everyday',
        time = "15:00:00", 
        event = function()
            TriggerEvent('zcSword_Auto', 'Random', 2 , 10)
        end
    },
    ["ice2"] = {
        day = 'Everyday',
        time = "21:00:00", 
        event = function()
            TriggerEvent('zcSword_Auto', 'Random', 2 , 10)
        end
    },
    ["ice3"] = {
        day = 'Everyday',
        time = "03:00:00", 
        event = function()
            TriggerEvent('zcSword_Auto', 'Random', 2 , 10)
        end
    },

    ["car"] = {
        day = 'Saturday',
        time = "23:00:00", 
        event = function()
            TriggerClientEvent('Dm_Triathlon:StartGamePhaseone', -1, 'car')
            TriggerEvent('resetscore')

        end
    },
    ["car1"] = {
        day = 'Sunday',
        time = "23:00:00", 
        event = function()
            TriggerClientEvent('Dm_Triathlon:StartGamePhaseone', -1, 'car')
            TriggerEvent('resetscore')

        end
    },

    ["train"] = {
        day = 'Wednesday',
        time = "23:00:00", 
        event = function()
            -- TriggerClientEvent('Dm_Triathlon:StartGamePhaseone', -1, 'car')
            -- TriggerEvent('resetscore')
            TriggerEvent('RobTrain')

        end
    },

    ["Red1"] = {
        day = 'Everyday',
        time = "01:30:00", 
        event = function()
            TriggerEvent('zcblackout_autoeventx',5,600)
        end
    },
    ["Red2"] = {
        day = 'Everyday',
        time = "03:30:00", 
        event = function()
            TriggerEvent('zcblackout_autoeventx',5,600)
        end
    },
    ["Red3"] = {
        day = 'Everyday',
        time = "05:30:00", 
        event = function()
            TriggerEvent('zcblackout_autoeventx',5,600)
        end
    },
    ["Red4"] = {
        day = 'Everyday',
        time = "07:30:00", 
        event = function()
            TriggerEvent('zcblackout_autoeventx',5,600)
        end
    },
    ["Red5"] = {
        day = 'Everyday',
        time = "09:30:00", 
        event = function()
            TriggerEvent('zcblackout_autoeventx',5,600)
        end
    },
    ["Red6"] = {
        day = 'Everyday',
        time = "11:30:00", 
        event = function()
            TriggerEvent('zcblackout_autoeventx',5,600)
        end
    },
    ["Red7"] = {
        day = 'Everyday',
        time = "13:30:00", 
        event = function()
            TriggerEvent('zcblackout_autoeventx',5,600)
        end
    },
    ["Red8"] = {
        day = 'Everyday',
        time = "15:30:00", 
        event = function()
            TriggerEvent('zcblackout_autoeventx',5,600)
        end
    },
    ["Red9"] = {
        day = 'Everyday',
        time = "17:30:00", 
        event = function()
            TriggerEvent('zcblackout_autoeventx',5,600)
        end
    },
    ["Red10"] = {
        day = 'Everyday',
        time = "19:30:00", 
        event = function()
            TriggerEvent('zcblackout_autoeventx',5,600)
        end
    },
    ["Red11"] = {
        day = 'Everyday',
        time = "21:30:00", 
        event = function()
            TriggerEvent('zcblackout_autoeventx',5,600)
        end
    },
    ["Red12"] = {
        day = 'Everyday',
        time = "23:30:00", 
        event = function()
            TriggerEvent('zcblackout_autoeventx',5,600)
        end
    },

    -- ["car"] = {
    --     day = 'Tuesday',
    --     time = "07:59:45", 
    --     event = function()
    --         TriggerClientEvent('Dm_Triathlon:StartGamePhaseone', -1, 'car')
    --         TriggerEvent('resetscore')

    --     end
    -- },
  

}


