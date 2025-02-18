local compassOn = false
local lastCompassHeading = "0"
local isInVehicle = false

RegisterNUICallback("uiReady", function()
    CreateThread(function()
        while not NetworkIsSessionStarted() do
            Wait(2000)
        end
        showCompas()
    end)
end)

CreateThread(function()
    while true do
        Wait(5000)
        isInVehicle = IsPedInAnyVehicle(PlayerPedId(), false)
        
        if not isInVehicle then
            SendNUIMessage({action = "close"})
        elseif compassOn then
            SendNUIMessage({action = "open"})
        end
    end
end)

function showCompas()
    if compassOn then return end
    compassOn = true
    
    CreateThread(function()
        while compassOn do
            if isInVehicle then
                local camRot = GetGameplayCamRot(0)
                local currentHeading = 360.0 - ((camRot.z + 360.0) % 360.0)
                local headingStr = string.format("%.0f", currentHeading)
                
                if headingStr == '360' then 
                    headingStr = '0' 
                end
                
                if lastCompassHeading ~= headingStr then
                    SendNUIMessage({
                        action = "update", 
                        heading = headingStr
                    })
                    lastCompassHeading = headingStr
                end
            end
            
            Wait(10)
        end
    end)
end

RegisterCommand("compass", function()
    compassOn = not compassOn
    if not compassOn then
        SendNUIMessage({action = "close"})
    else
        showCompas()
    end
end)