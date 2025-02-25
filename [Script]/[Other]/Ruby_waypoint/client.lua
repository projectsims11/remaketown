function GetWaypointCoords()
    local blip = GetFirstBlipInfoId(8) -- 8 is the ID for waypoints
    if DoesBlipExist(blip) then
        return GetBlipCoords(blip)
    else
        return nil
    end
end

function GetDistanceToWaypoint()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    
    local waypointCoords = GetWaypointCoords()
    if waypointCoords then
        return GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, waypointCoords.x, waypointCoords.y, waypointCoords.z, true), waypointCoords
    else
        return nil, nil
    end
end

function Draw3DText(coords, text, scale)
    local x, y, z = coords.x, coords.y, coords.z
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())

    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 215, 0, 255) -- Gold color
        SetTextOutline()
        SetTextEntry("STRING")
        AddTextComponentString(text)
        DrawText(_x, _y)

        -- Background rectangle
        local textWidth = string.len(text) * 0.0045
        -- DrawRect(_x, _y + 0.012, textWidth, 0.03, 0, 0, 0, 150)
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0) -- Run every frame
        local distance, waypointCoords = GetDistanceToWaypoint()
        if distance and waypointCoords then
            Draw3DText(vector3(waypointCoords.x, waypointCoords.y, waypointCoords.z + 1.2), "📍 " .. math.floor(distance) .. "m", 0.5)

            -- Stylish marker at waypoint
            DrawMarker(2, waypointCoords.x, waypointCoords.y, waypointCoords.z + 1.0, 0, 0, 0, 0, 0, 0, 0.4, 0.4, 0.4, 255, 215, 0, 150, false, true, 2, nil, nil, false)
        end
    end
end)
