TwoNa = exports["2na_core"]:getSharedObject()

Citizen.CreateThread(function()
    AddTextEntry("show_menu", "Press ~INPUT_PICKUP~ to access menu")
    AddTextEntry("show_purchase_menu", "Press ~INPUT_PICKUP~ to access purchase menu")
    AddTextEntry("park_vehicle", "Press ~INPUT_PICKUP~ to park your vehicle")

    while true do 
        local pedCoords = GetEntityCoords(GetPlayerPed(-1))

        for k, v in ipairs(Config.Garages) do 
            local menuMarkerCoord = v.markerCoords.menu

            DrawMarker(22, menuMarkerCoord.x, menuMarkerCoord.y, menuMarkerCoord.z + 2, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.8, 0.8, 0.8, 93, 56, 255, 50, false, true, 2, nil, nil, false)

            if GetDistanceBetweenCoords(pedCoords.x,pedCoords.y,pedCoords.z,menuMarkerCoord.x,menuMarkerCoord.y,menuMarkerCoord.z) < 1.2 then 
                DisplayHelpTextThisFrame("show_menu")

                if IsControlJustPressed(0, 38) then 
                    TriggerEvent("2na_garage:showMenu", { type = "garage", garage = v })
                end
            end

            local parkCoord = v.vehicleCoords.park.coord

            if IsPedInVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), false) and GetDistanceBetweenCoords(pedCoords.x,pedCoords.y,pedCoords.z,parkCoord.x,parkCoord.y,parkCoord.z) < 3 then 
                DrawMarker(27, parkCoord.x, parkCoord.y, parkCoord.z - 0.95, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 5.0, 5.0, 5.0, 93, 56, 255, 50, false, true, 2, nil, nil, false)

                DisplayHelpTextThisFrame("park_vehicle")

                if IsControlJustPressed(0, 38) then
                    TriggerEvent("2na_garage:parkVehicle", v) 
                end
            end

        end

        for k,v in ipairs(Config.Impounds) do
            local impoundMarkerCoord = v.markerCoords.menu

            DrawMarker(22, impoundMarkerCoord.x, impoundMarkerCoord.y, impoundMarkerCoord.z + 2, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.8, 0.8, 0.8, 93, 56, 255, 50, false, true, 2, nil, nil, false)

            if GetDistanceBetweenCoords(pedCoords.x,pedCoords.y,pedCoords.z,impoundMarkerCoord.x,impoundMarkerCoord.y,impoundMarkerCoord.z) < 1.2 then 
                DisplayHelpTextThisFrame("show_menu")

                if IsControlJustPressed(0, 38) then 
                    TriggerEvent("2na_garage:showMenu", { type = "impound", garage = v })
                end
            end
        end

        if Config.GarageCenter.Enabled then 
            DrawMarker(29, Config.GarageCenter.markerCoord.x, Config.GarageCenter.markerCoord.y, Config.GarageCenter.markerCoord.z + 2, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.8, 0.8, 0.8, 0, 255, 0, 50, false, true, 2, nil, nil, false)

            if GetDistanceBetweenCoords(pedCoords.x,pedCoords.y,pedCoords.z,Config.GarageCenter.markerCoord.x, Config.GarageCenter.markerCoord.y, Config.GarageCenter.markerCoord.z) < 1.2 then 
                DisplayHelpTextThisFrame("show_menu")

                if IsControlJustPressed(0, 38) then 
                    TriggerEvent("2na_garage:showGarageCenterMenu")
                end
            end
        end

        Citizen.Wait(1)
    end
end)

Citizen.CreateThread(function() 
    for k,v in ipairs(Config.Garages) do 
        local blipCoord = AddBlipForCoord(v.markerCoords.menu.x, v.markerCoords.menu.y, v.markerCoords.menu.z)

        SetBlipSprite(blipCoord, Config.Blips.Garages.Type)
        SetBlipDisplay(blipCoord, 4)
        SetBlipScale(blipCoord, 0.8)
        SetBlipColour(blipCoord, Config.Blips.Garages.Color)
        SetBlipAsShortRange(blipCoord, Config.Blips.Garages.DisplayWhenNear)
	    BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.Blips.Garages.Name)
        EndTextCommandSetBlipName(blipCoord)
    end

    for k,v in ipairs(Config.Impounds) do 
        local blipCoord = AddBlipForCoord(v.markerCoords.menu.x, v.markerCoords.menu.y, v.markerCoords.menu.z)

        SetBlipSprite(blipCoord, Config.Blips.Impounds.Type)
        SetBlipDisplay(blipCoord, 4)
        SetBlipScale(blipCoord, 0.8)
        SetBlipColour(blipCoord, Config.Blips.Impounds.Color)
        SetBlipAsShortRange(blipCoord, Config.Blips.Impounds.DisplayWhenNear)
	    BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.Blips.Impounds.Name)
        EndTextCommandSetBlipName(blipCoord)
    end

    if Config.GarageCenter.Enabled then 
        local GarageCenterBlipCoord = AddBlipForCoord(Config.GarageCenter.markerCoord.x, Config.GarageCenter.markerCoord.y, Config.GarageCenter.markerCoord.z)

        SetBlipSprite(GarageCenterBlipCoord, Config.Blips.GarageCenter.Type)
        SetBlipDisplay(GarageCenterBlipCoord, 4)
        SetBlipScale(GarageCenterBlipCoord, 0.8)
        SetBlipColour(GarageCenterBlipCoord, Config.Blips.GarageCenter.Color)
        SetBlipAsShortRange(GarageCenterBlipCoord, Config.Blips.GarageCenter.DisplayWhenNear)
	    BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.Blips.GarageCenter.Name)
        EndTextCommandSetBlipName(GarageCenterBlipCoord)
    end
end)

Citizen.CreateThread(function() 
    while true do 
        local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)

        if vehicle ~= 0 then 
            local plate = GetVehicleNumberPlateText(vehicle)
            local props = TwoNa.Game.GetVehicleProperties(vehicle)

            TwoNa.TriggerServerCallback("2na_garage:getOwnedVehicles", {}, function(vehicles) 
                for k,v in ipairs(vehicles) do 
                    if v.plate == plate and v.properties then
                        if tostring(v.properties) ~= tostring(props) then
                            TwoNa.TriggerServerCallback("2na_garage:updateVehicleProperties", { plate = plate, properties = props }, function() end)
                        end
                    end
                end
            end)
        end

        Citizen.Wait(400)
    end
end)