function ShowMarker(x,y,z) --* Marker ของคนที่มีค่าหัว
    if Config.Systems.CustomMarker ~= nil then
        if not HasStreamedTextureDictLoaded(Config.Systems.CustomMarker) then
            RequestStreamedTextureDict(Config.Systems.CustomMarker, true)
            while not HasStreamedTextureDictLoaded(Config.Systems.CustomMarker) do
                Wait(1)
            end
        else
            
            DrawMarker(9, x, y, z + 2, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 255,true, false, 2, true, Config.Systems.CustomMarker, Config.Systems.CustomMarker, false)
        end
    else
        DrawMarker(9, x, y, z + 2, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 255,true, false, 2, true, Config.Systems.CustomMarker, Config.Systems.CustomMarker, false)
    end
end

function SeeMarkerBox(x,y,z)
    local dict = CreateRuntimeTxd('marker')
    DrawMarker(29, x, y, z + 2, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.7, 1.7, 1.7, 255,215,0, 100, true, false, 2, dict, nil, false)
end

function ShowTextOnBox(x,y,z)
    ShowText("<font face='font4thai'> ~h~[กด E ~g~เก็บ ~s~]</font>", vector3(x,y,z))
end

function Loading()
    local Time = Config.Systems.TimeLoot*1000
    TriggerEvent("mythic_progbar:client:progress", {
        name = "unique_action_name",
        duration =Time,
        label = "Load",
        useWhileDead = false,
        canCancel = true,
    
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true
        },
        animation = {
            animDict = "missheistdockssetup1clipboard@idle_a",
            anim = "idle_a",
        }
    }, function(status)
        if not status then
        end
    end)
    Citizen.Wait(Time)
    return
end



function ShowText(msg, coords)
    AddTextEntry('esxFloatingHelpNotification', msg)
	SetFloatingHelpTextWorldPosition(1, coords)
	SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
	BeginTextCommandDisplayHelp('esxFloatingHelpNotification')
	EndTextCommandDisplayHelp(2, false, false, -1)
end



function GenerateCrabCoords(crabCoordX,crabCoordY,crabCoordZ)

    return vector3(crabCoordX,crabCoordY,crabCoordZ+0.5)

	-- while true do
	-- 	Citizen.Wait(1)
	-- 	local coordZ = GetCoordZ(crabCoordX, crabCoordY)
	-- 	local coord = vector3(crabCoordX, crabCoordY, coordZ)
	-- 	return coord
	-- end
end

function GetCoordZ(x, y)

    -- local groundCheckHeights = {30.0, 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0, 49.0, 50.0,1000}

    ----------------------------------------

    local groundCheckHeights = {}
    for check = 0.0,1000,1 do 
        table.insert(groundCheckHeights,check)
    end
    
    --
    for i, height in ipairs(groundCheckHeights) do
        
        local foundGround, z = GetGroundZFor_3dCoord(x, y, height)
        --
        
        if foundGround then
            return z
        end
    end


	
	--
	
	return 43.0
end