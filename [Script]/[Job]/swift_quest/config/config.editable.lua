config = config or {}

config.textuiStyle = 1 -- 1 = loop, 2 = show/hide
config.textui = function(state)
    if state then
        -- Show
        if GetResourceState("Fewthz_TextUI") == "started" then
            exports.Fewthz_TextUI:ShowHelpNotification('~INPUT_CONTEXT~ เพื่อเปิดเมนูเควส')
        else
            ESX.ShowHelpNotification('~INPUT_CONTEXT~ to open Quest Board', true)
        end
    else
        -- Hide
        print("Hide")
    end
end

if IsDuplicityVersion() then
    config.notification = function(playerId, message, type)
        TriggerClientEvent("pNotify:SendNotification", playerId, {
            text = message,
            layout = "bottomCenter",
            timeout = 3000,
            type = type,
        })
    end
else
    local keymappings = {
        [170] = "F1", [171] = "F2", [172] = "F3", [173] = "F4", [174] = "F5", [175] = "F6", [176] = "F7", [177] = "F8", [178] = "F9", [179] = "F10", [180] = "F11", [181] = "F12"
    }

    config.FormatControlInstructional = function(key)
        return keymappings[tonumber(key)] or key
    end    

    config.notification = function(message, type)
        TriggerEvent("pNotify:SendNotification", {
            text = message,
            layout = "bottomCenter",
            timeout = 3000,
            type = type,
        })
    end
end