local checkState = false

AddEventHandler("playerSpawned", function ()
    if not checkState then
        ShutdownLoadingScreen()
        ShutdownLoadingScreenNui()
        checkState = true
    end
end)


-- Function to simulate loading progress
function sendLoadProgress(loadFraction, taskName)
    -- Send the load progress message to the NUI (HTML/JS UI)
    SendNUIMessage({
        type = "loadProgress",   -- Event type to identify the message
        loadFraction = loadFraction,  -- A value between 0 and 1 representing progress (e.g., 0.5 for 50%)
        eventName = "loadProgress",  -- Name of the event (you can customize this)
        name = taskName   -- Name of the task being loaded (e.g., "Loading assets")
    })
end

-- Example usage: Sending 50% progress for a task named "Loading assets"
sendLoadProgress(0.5, "Loading assets")

-- You can call the function periodically to simulate progress updates:
Citizen.CreateThread(function()
    local progress = 0
    local taskName = "Loading assets"

    while progress < 1 do
        Citizen.Wait(1000)  -- Wait for 1 second before updating progress
        progress = progress + 0.1  -- Increase progress by 10% every second

        -- Send the updated progress to the NUI
        sendLoadProgress(progress, taskName)
    end

    -- Once loading is complete, you could send a final message or trigger another event
    sendLoadProgress(1, taskName)
end)

