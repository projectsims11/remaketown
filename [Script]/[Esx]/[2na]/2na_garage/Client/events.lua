RegisterNetEvent("2na_garage:showMenu")
AddEventHandler("2na_garage:showMenu", function(data) 
    if data.type == 'garage' then 
        TwoNa.TriggerServerCallback("2na_garage:getOwnedVehicles", {}, function(vehicles) 
            local filteredVehicles = {}
            SetNuiFocus(true, true)

            for k, v in ipairs(vehicles) do 
                vehicles[k].id = generateVehicleId(GetHashKey(v.model), v.plate)
                vehicles[k].properties.max_speed = GetVehicleModelEstimatedMaxSpeed(v.model) * 1.609344
                vehicles[k].displayName = GetDisplayNameFromVehicleModel(v.model)

                if vehicles[k].name == nil then 
                    TwoNa.TriggerServerCallback("2na_garage:getVehicleByName", { name = vehicles[k].displayName }, function(data) 
                        if data then 
                            vehicles[k].name = data.name
                            vehicles[k].model = data.model
                            vehicles[k].category = data.category
                            vehicles[k].price = data.price
                        end
                    end)
                end

                if type(vehicles[k].model) == 'string' then 
                    table.insert(filteredVehicles, vehicles[k])
                end
            end

            SendNUIMessage({
                type = "garage",
                action = "show",
                vehicles = filteredVehicles,
                garage = data.garage,
                garageList = Config.Garages,
                engineRepairCost = Config.VehiceEngineRepairCost
            })
        end)
    else 
        TwoNa.TriggerServerCallback("2na_garage:getImpoundedVehicles", {}, function(vehicles)
            local filteredVehicles = {}
            SetNuiFocus(true, true)

            for k, v in ipairs(vehicles) do 
                vehicles[k].id = generateVehicleId(GetHashKey(v.model), v.plate)
                vehicles[k].properties.max_speed = GetVehicleModelEstimatedMaxSpeed(v.model) * 1.609344
                vehicles[k].displayName = GetDisplayNameFromVehicleModel(v.model)

                if vehicles[k].name == nil then 
                    TwoNa.TriggerServerCallback("2na_garage:getVehicleByName", { name = vehicles[k].displayName }, function(data) 
                        if data then 
                            vehicles[k].name = data.name
                            vehicles[k].model = data.model
                            vehicles[k].category = data.category
                            vehicles[k].price = data.price
                        end
                    end)
                end

                if type(vehicles[k].model) == 'string' then
                    table.insert(filteredVehicles, vehicles[k])
                end
            end

            SendNUIMessage({
                type = "impound",
                action = "show",
                vehicles = filteredVehicles,
                garage = data.garage,
                garageList = Config.Garages,
                engineRepairCost = Config.VehiceEngineRepairCost,
                spawnVehicleCost = Config.SpawnVehicleCost
            })
        end)
    end
end)

RegisterNetEvent("2na_garage:hideMenu")
AddEventHandler("2na_garage:hideMenu", function() 

    SetNuiFocus(false, false)

    SendNUIMessage({
        action = "hide"
    })
end)

RegisterNetEvent("2na_garage:spawnVehicle")
AddEventHandler("2na_garage:spawnVehicle", function(data) 
    TwoNa.TriggerServerCallback("2na_garage:getOwnedVehicles", {}, function(vehicles) 
        local targetVehicle = nil

        for k,v in ipairs(vehicles) do
            if generateVehicleId(GetHashKey(v.model), v.plate) == data.vehicle.id then
                targetVehicle = v
                break 
            end
        end

        if targetVehicle ~= nil then
            if targetVehicle.stored then
                if targetVehicle.garage == nil then
                    targetVehicle.garage = data.garage.id  
                end

                if not Config.TakeCarFromParkedGarage or Config.TakeCarFromParkedGarage and targetVehicle.garage == data.garage.id then 
                    TwoNa.TriggerServerCallback("2na_garage:updateVehicle", { plate = targetVehicle.plate, stored = 0, garage = nil },  function(success) 
                        if success then
                            if not IsModelInCdimage(targetVehicle.model) then 
                                print("Cannot spawn vehicle because of an error")
                                return 
                            end

                            RequestModel(targetVehicle.model)

                            while not HasModelLoaded(targetVehicle.model) do 
                              Citizen.Wait(10)
                            end

                            local vehicle = CreateVehicle(targetVehicle.model, data.garage.vehicleCoords.spawn.coord.x, data.garage.vehicleCoords.spawn.coord.y, data.garage.vehicleCoords.spawn.coord.z, data.garage.vehicleCoords.spawn.heading + 0.01, true, false) 

                            SetModelAsNoLongerNeeded(targetVehicle.model)

                            data.vehicle.properties.plate = targetVehicle.plate

                            TwoNa.Game.SetVehicleProperties(vehicle, data.vehicle.properties)
                            
                            SetVehicleEngineHealth(vehicle, (data.vehicle.properties.engineHealth or 1000) - 0.1)

                            SetPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
                            
                            TriggerEvent("2na_garage:hideMenu")
                        else
                            print("An error occured while spawning the vehicle!") 
                        end
                    end)
                end
            end
        end
    end)
end)

RegisterNetEvent("2na_garage:parkVehicle")
AddEventHandler("2na_garage:parkVehicle", function(garage) 
    local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)

    if vehicle then 
        local vehicleProps = TwoNa.Game.GetVehicleProperties(vehicle)
        vehicleProps["id"] = generateVehicleId(vehicleProps.model, vehicleProps.plate)


        TwoNa.TriggerServerCallback("2na_garage:getOwnedVehicles", {}, function(vehicles) 
            local isVehicleOwned = false

            for k, v in ipairs(vehicles) do
                if generateVehicleId(GetHashKey(v.model), v.plate) == vehicleProps.id then
                    isVehicleOwned = true
                    break 
                end
            end

            if isVehicleOwned then
                TwoNa.TriggerServerCallback("2na_garage:updateVehicle", { plate = vehicleProps.plate, properties = vehicleProps, stored = 1, garage = garage.id }, function(success) 
                    if success then
                        TaskLeaveVehicle(GetPlayerPed(-1), vehicle, 0)

                        Citizen.Wait(1700)

                        FreezeEntityPosition(vehicle, true)

                        DisableVehicleWorldCollision(vehicle)

                        for i = 255, 1, -10 do
                            SetEntityAlpha(vehicle, i, true)
                            Citizen.Wait(0.1)
                        end

                        DeleteEntity(vehicle)
                    else
                        print("An error occured while parking the vehicle!")
                    end
                end)
            else
                print("You cannot park a vehicle that is not owned by you!") 
            end
        end)
    end
end)

RegisterNetEvent("2na_garage:markGarage")
AddEventHandler("2na_garage:markGarage", function(data)
    for k,v in ipairs(Config.Garages) do 
        if v.id == data.garageId then 
            SetNewWaypoint(
                v.markerCoords.menu.x,
                v.markerCoords.menu.y
            )
            break
        end
    end

end)

RegisterNetEvent("2na_garage:purchaseGarage")
AddEventHandler("2na_garage:purchaseGarage", function(data)
    local garage = data.garage

    TwoNa.TriggerServerCallback("2na_garage:purchaseGarage", { garage = garage.id }, function()end)
end)

RegisterNetEvent("2na_garage:sellGarage")
AddEventHandler("2na_garage:sellGarage", function(data)
    local garage = data.garage
    
    TwoNa.TriggerServerCallback("2na_garage:sellGarage", { garage = garage.id }, function()end)
end)

RegisterNetEvent("2na_garage:withdrawGarageMoney")
AddEventHandler("2na_garage:withdrawGarageMoney", function(data)
    local garage = data.garage
    
    TwoNa.TriggerServerCallback("2na_garage:withdrawGarageMoney", { garage = garage.id }, function() end)
end)

RegisterNetEvent("2na_garage:showGarageCenterMenu")
AddEventHandler("2na_garage:showGarageCenterMenu", function() 
    TriggerEvent("nh-context:sendMenu", {
        { id = 1,  header = '<span style="font-weight: bold; width: 100%; text-align: center">───&nbsp;&nbsp;Garage Center&nbsp;&nbsp;───</span>', txt = ""},
        {
            id = 2,
            header = "Purchase Garages",
            txt = "Purchase available garages for a small price",
            params = {
                event = "2na_garage:Menu:PurchaseGarages"
            }
        },
        {
            id = 3,
            header = "My Garages",
            txt = "See the list of garages you own",
            params = {
                event = "2na_garage:Menu:OwnedGarages"
            }
        }
    })
end)

RegisterNetEvent("2na_garage:Menu:PurchaseGarages")
AddEventHandler("2na_garage:Menu:PurchaseGarages", function() 
    TwoNa.TriggerServerCallback("2na_garage:getAvailableGarages", {}, function(garages) 
        local elements = {
            { id = 1, header = '<span style="font-weight: bold; width: 100%; text-align: center">───&nbsp;&nbsp;Purcase Garages&nbsp;&nbsp;───</span>', txt = "" }
        }

        for k,v in ipairs(garages) do 
            if not v.owned then 
                table.insert(elements, { id = k + 1, header = v.name, txt = "", params = { args = { garage = v }, event = "2na_garage:Menu:PurchaseGarage" }  })
            end 
        end

        TriggerEvent("nh-context:sendMenu", elements)
    end)
end)

RegisterNetEvent("2na_garage:Menu:PurchaseGarage")
AddEventHandler("2na_garage:Menu:PurchaseGarage", function(data)
    local garage = data.garage

    TriggerEvent("nh-context:sendMenu", {
        {id = 1, header = garage.name, txt = ""},
        {
            id = 2,
            header = "Purchase",
            txt = "Purchase this garage for " .. garage.cost .. " $",
            params = {
                event = "2na_garage:purchaseGarage",
                args = {
                    garage = garage
                }
            }
        },
        {
            id = 3,
            header = "Mark Garage",
            txt = "Mark this garage's location on map.",
            params = {
                event = "2na_garage:markGarage",
                args = { 
                    garageId = garage.id
                }
            }
        }
    })
end)

RegisterNetEvent("2na_garage:Menu:OwnedGarages")
AddEventHandler("2na_garage:Menu:OwnedGarages", function() 
    TwoNa.TriggerServerCallback("2na_garage:getAvailableGarages", {}, function(garages) 
        local elements = {
            { id = 1, header = '<span style="font-weight: bold; width: 100%; text-align: center">───&nbsp;&nbsp;Owned Garages&nbsp;&nbsp;───</span>', txt = "" }
        }

        for k,v in ipairs(garages) do 
            if v.owned then 
                table.insert(elements, { id = k + 1, header = v.name, txt = "", params = { args = { garage = v }, event = "2na_garage:Menu:ManageGarage" }  })
            end 
        end

        TriggerEvent("nh-context:sendMenu", elements)
    end)
end)

RegisterNetEvent("2na_garage:Menu:ManageGarage")
AddEventHandler("2na_garage:Menu:ManageGarage", function(data)
    local garage = data.garage

    TriggerEvent("nh-context:sendMenu", {
        {id = 1, header = garage.name, txt = ""},
        {
            id = 2,
            header = "Manage Safe",
            txt = "Manage this garagee's safe.",
            params = {
                event = "2na_garage:Menu:ManageGarageSafe",
                args = {
                    garage = garage
                }
            }
        },
        {
            id = 3,
            header = "Sell",
            txt = "Sell this garage for " .. garage.cost .. " $",
            params = {
                event = "2na_garage:sellGarage",
                args = {
                    garage = garage
                }
            }
        },
        {
            id = 4,
            header = "Mark Garage",
            txt = "Mark this garage's location on map.",
            params = {
                event = "2na_garage:markGarage",
                args = {
                    garageId = garage.id
                }
            }
        }
    })
end)

RegisterNetEvent("2na_garage:Menu:ManageGarageSafe")
AddEventHandler("2na_garage:Menu:ManageGarageSafe", function(data)
    local garage = data.garage
     
    TriggerEvent("nh-context:sendMenu", {
        {id = 1, header = garage.name, txt = ""},
        {
            id = 2,
            header = "Withdraw Cash (" .. garage.safe .. " $)",
            txt = "Withdraw the money that your garage earned.",
            params = {
                event = "2na_garage:withdrawGarageMoney",
                args = {
                    garage = garage
                }
            }
        }
    })
end)