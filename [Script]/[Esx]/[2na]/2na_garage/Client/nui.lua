RegisterNUICallback("hideMenu", function(data,cb) 
    TriggerEvent("2na_garage:hideMenu")
    cb(true)
end)

RegisterNUICallback("spawnVehicle", function(data, cb) 
    if data.payBill then 
        TwoNa.TriggerServerCallback("2na_garage:payBill", { billType = "impoundRelease" }, function(paid) 
            if paid then
                TwoNa.TriggerServerCallback("2na_garage:updateVehicle", { plate = data.vehicle.plate, stored = 1, garage = nil }, function(sucess) 
                    if sucess then
                        TriggerEvent("2na_garage:spawnVehicle", data)
                    else
                        cb(false) 
                    end
                end)          
            else
                cb(false)
            end
        end)
    else
        TriggerEvent("2na_garage:spawnVehicle", data)
        cb(true)
    end
end)

RegisterNUICallback("repairVehicleEngine", function(data, cb) 
    TwoNa.TriggerServerCallback("2na_garage:payBill", { billType = "engineRepair", garage = data.garage }, function(paid) 
        if paid then
            TwoNa.TriggerServerCallback("2na_garage:repairVehicleEngine", { plate = data.plate }, function(sucess) 
                if sucess then
                    cb(true)
                else
                    cb(false) 
                end
            end)          
        else
            cb(false)
        end
    end)
end)