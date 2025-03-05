positions = {
    {{299.45, -595.21, 43.2, 340.06}, {300.12, -594.6, 38.15, 330.37}, "Press ~INPUT_CONTEXT~ to enter to the basement ", false, false},
    { {300.12, -594.6, 38.15, 330.37}, {299.45, -595.21, 43.2, 340.06}, "Press ~INPUT_CONTEXT~ to go up ", false, false},
}

vehicle_message = "~r~You can't do it with the vehicle!"
novehcile_message = "~r~You are entering/leaving without a vehicle"

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(5)
        local player = GetPlayerPed(-1)
        local playerLoc = GetEntityCoords(player)

        for _,location in ipairs(positions) do
            teleport_text = location[4]
            pos1 = {
                x=location[1][1],
                y=location[1][2],
                z=location[1][3],
                heading=location[1][4]
            }
            pos2 = {
                x=location[2][1],
                y=location[2][2],
                z=location[2][3],
                heading=location[2][4]
            }

            vechicle = location[5]

            DrawMarker(31, pos1.x, pos1.y, pos1.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 204, 255, 255, false, true, 2, true, false, false, false)
            DrawMarker(20, pos1.x, pos1.y, pos1.z - 0.3, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 204, 255, 255, false, true, 2, true, false, false, false)
            DrawMarker(27, pos1.x, pos1.y, pos1.z - 0.9, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 204, 255, 255, false, true, 2, true, false, false, false)

            if position_verf(playerLoc.x, playerLoc.y, playerLoc.z, pos1.x, pos1.y, pos1.z, 2) then 
                help_message(teleport_text)
                if IsControlJustReleased(1, 38) then
                    if vechicle == true then
                        if IsPedInAnyVehicle(player, true) then
                            FreezeEntityPosition(player, true)
                            DoScreenFadeOut(500)
                            Citizen.Wait(500)
                            DoScreenFadeIn(500)
                            FreezeEntityPosition(player, false)
                            SetEntityCoords(GetVehiclePedIsUsing(player), pos2.x, pos2.y, pos2.z)
                            SetEntityHeading(GetVehiclePedIsUsing(player), pos2.heading)
                        else
                            FreezeEntityPosition(player, true)
                            DoScreenFadeOut(500)
                            Citizen.Wait(500)
                            DoScreenFadeIn(500)
                            FreezeEntityPosition(player, false)
                            SetEntityCoords(player, pos2.x, pos2.y, pos2.z)
                            SetEntityHeading(player, pos2.heading)
                            notify_message(novehcile_message)
                        end
                    elseif vechicle == false then
                        if IsPedInAnyVehicle(player, true) then
                            notify_message(vehicle_message)
                        else
                            FreezeEntityPosition(player, true)
                            DoScreenFadeOut(500)
                            Citizen.Wait(500)
                            DoScreenFadeIn(500)
                            FreezeEntityPosition(player, false)
                            SetEntityCoords(player, pos2.x, pos2.y, pos2.z)
                            SetEntityHeading(player, pos2.heading)
                        end
                    end
                end
            end          
        end
    end
end)

function position_verf(x, y, z, cx, cy, cz, radius)
    local t1 = x - cx
    local t12 = t1^2

    local t2 = y-cy
    local t21 = t2^2

    local t3 = z - cz
    local t31 = t3^2

    return (t12 + t21 + t31) <= radius^2
end

function help_message(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end

function notify_message(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end