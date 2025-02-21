-- Haru Discord : https://discord.gg/Md2gCmpP8X
-- Configuration for minimap positioning and size
local posX = -0.005
local posY = -0.003
local width = 0.183
local height = 0.24

-- Variable to ensure minimap customization happens only once
local loaded = false

-- Event handler for player spawn
AddEventHandler("playerSpawned", function()
    if not loaded then
        loaded = true
        
        -- Load and apply custom minimap texture
        RequestStreamedTextureDict("circlemap", false)
        while not HasStreamedTextureDictLoaded("circlemap") do
            Wait(100)
        end
        AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "circlemap", "radarmasksm")

        -- Set minimap component positions
        SetMinimapClipType(1)
        SetMinimapComponentPosition('minimap', 'L', 'B', posX, posY - 0.05, width, height)
        SetMinimapComponentPosition('minimap_mask', 'L', 'B', posX, posY, width, height)
        SetMinimapComponentPosition('minimap_blur', 'L', 'B', -0.012, -0.038, 0.28, 0.337)

        -- Configure and handle minimap setup
        local minimap = RequestScaleformMovie("minimap")
        SetRadarBigmapEnabled(true, false)
        Wait(0)
        SetRadarBigmapEnabled(false, false)

        -- Set up health and armor on the minimap
        Citizen.CreateThread(function()
            while true do
                Wait(500) -- Reduced wait time to every 500 ms
                BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
                ScaleformMovieMethodAddParamInt(3)
                EndScaleformMovieMethod()
            end
        end)
    end
end)

-- Event handler for entering a vehicle
AddEventHandler("svrp-gameplay:enteredVehicle", function()
    SendNUIMessage({ action = "displayUI" })
end)

-- Event handler for exiting a vehicle
AddEventHandler("svrp-gameplay:exitVehicle", function()
    SendNUIMessage({ action = "hideUI" })
end)

-- Handling pause menu status
local pauseMenu = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500) -- Check every 500 ms

        local inVehicle = IsPedInAnyVehicle(PlayerPedId())
        local pauseActive = IsPauseMenuActive()

        if pauseActive and not pauseMenu then
            pauseMenu = true
            SendNUIMessage({ open = 30 })
            if inVehicle then
                SendNUIMessage({ action = "hideUI" })
            end
        elseif not pauseActive and pauseMenu then
            pauseMenu = false
            if inVehicle then
                SendNUIMessage({ action = "displayUI" })
            end
        end
    end
end)
