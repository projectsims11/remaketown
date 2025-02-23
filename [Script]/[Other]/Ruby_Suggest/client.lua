Config = Config or {}

local uiVisible = false

function ToggleUI()
    uiVisible = not uiVisible

    SetNuiFocus(false, false)
   
    local textData = Config.Text or {}
    -- print("Sending textData:", json.encode(textData))  -- Debugging

    SendNUIMessage({
        type = uiVisible,
        textData = textData 
    })
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustReleased(0, Config.Toggle) then
            -- print("J Pressed!") -- Debugging
            ToggleUI()
        end
    end
end)

