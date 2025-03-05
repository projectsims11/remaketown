TwoNa = exports["2na_core"]:getSharedObject()

TwoNa.RegisterServerCallback("2na_garage:getOwnedVehicles", function(source, data, cb) 
    local vehicles = TwoNa.GetPlayerVehicles(source)

    cb(vehicles)
end)

TwoNa.RegisterServerCallback("2na_garage:getAvailableGarages", function(source, data, cb) 
    local identifier = TwoNa.GetPlayerIdentifier(source)
    local garages = TwoNa.MySQL.Sync.Fetch("SELECT * from 2na_garages", {})
    local availableGarages = {}

    for _,v in ipairs(Config.Garages) do 
        local targetGarage = nil

        for _,g in ipairs(garages) do 
            if g.garage == v.id then 
                targetGarage = g
                break
            end
        end

        if targetGarage and targetGarage.owner == identifier then
            v.owned = true
            v.safe = targetGarage.safe
            table.insert(availableGarages, v)
        else
            v.owned = false
            v.purchaseable = true
            table.insert(availableGarages, v)
        end
    end

    cb(availableGarages)
end)

TwoNa.RegisterServerCallback("2na_garage:getImpoundedVehicles", function(source, data, cb) 
    local vehicles = TwoNa.GetPlayerVehicles(source)
    local impoundedVehicles = {}

    for k,v in ipairs(vehicles) do 
        if not v.stored then
            table.insert(impoundedVehicles, v) 
        end
    end

    cb(impoundedVehicles)
end)

TwoNa.RegisterServerCallback("2na_garage:updateVehicle", function(source, data, cb) 
    local vehicles = TwoNa.GetPlayerVehicles(source)
    local targetVehicle = nil

    for k,v in ipairs(vehicles) do 
        if v.plate == data.plate then 
            targetVehicle = v
        end
    end

    if targetVehicle then 
        if data.properties then 
            for k,v in pairs(data.properties) do 
                targetVehicle.properties[k] = v
            end
        end

        local success = TwoNa.UpdatePlayerVehicle(source, data.plate, {
            properties = targetVehicle.properties,
            garage = data.garage or nil,
            stored = data.stored or nil
        })

        cb(success)
    else
        cb(false)
    end
end)

TwoNa.RegisterServerCallback("2na_garage:payBill", function(source, data, cb) 
    local player = TwoNa.GetPlayer(source)
    local cost = 0

    if data.billType == 'impoundRelease' then 
        cost = Config.SpawnVehicleCost
    elseif data.billType == 'engineRepair' then
        cost = Config.VehiceEngineRepairCost
    elseif data.billType == 'garagePurchase' then
        for k,v in ipairs(Config.Garages) do 
            if v.id == data.garage then 
                cost = v.cost
            end
        end
    end

    if player.getMoney() >= cost then 
        player.removeMoney(cost)

        if data.billType == 'engineRepair' then
            if Config.GarageCenter.Enabled then 
                TwoNa.MySQL.Async.Execute("UPDATE 2na_garages SET safe = safe + @cost WHERE garage = @garage", { ["@cost"] = cost, ["@garage"] = data.garage.id }, function() 
                    cb(true)
                end)
            else
                cb(true)
            end
        end

        cb(true)
    else
        cb(false)
    end
end)

TwoNa.RegisterServerCallback("2na_garage:purchaseGarage", function(source, data, cb) 
    if Config.GarageCenter.Enabled then 
        TwoNa.TriggerCallback("2na_garage:payBill", source, { billType = "garagePurchase", garage = data.garage }, function(success) 
            if success then
                local identifier = TwoNa.GetPlayerIdentifier(source)

                TwoNa.MySQL.Async.Execute("INSERT INTO 2na_garages (garage, owner) VALUES (@garage, @owner)", { ["@garage"] = data.garage, ["@owner"] = identifier }, function() 
                    cb(true)
                end)
            else
                cb(false)
            end
        end)
    else
        cb(false)
    end
end)

TwoNa.RegisterServerCallback("2na_garage:withdrawGarageMoney", function(source, data, cb) 
    if Config.GarageCenter.Enabled then 
        local garage = TwoNa.MySQL.Sync.Fetch("SELECT * FROM 2na_garages WHERE garage = @garage", { ["@garage"] = data.garage })[1]

        if garage then 
            local player = TwoNa.GetPlayer(source)

            TwoNa.MySQL.Async.Execute("UPDATE 2na_garages SET safe = 0 WHERE garage = @garage", { ["@garage"] = data.garage }, function() 
                player.addMoney(garage.safe)

                cb(true)
            end)
        else
            cb(false)
        end
    else
        cb(false)
    end
end)

TwoNa.RegisterServerCallback("2na_garage:sellGarage", function(source, data, cb) 
    if Config.GarageCenter.Enabled then 
            local targetGarage = nil

        for k,v in ipairs(Config.Garages) do 
            if v.id == data.garage then 
                targetGarage = v
            end
        end

        if targetGarage then
            TwoNa.MySQL.Async.Execute("DELETE FROM 2na_garages WHERE garage = @garage", { ["@garage"] = data.garage, ["@owner"] = identifier }, function() 
                local player = TwoNa.GetPlayer(source)
                player.addMoney(targetGarage.cost)
                cb(true)
            end)
        else
            cb(false)
        end
    else
        cb(false)
    end
end)

TwoNa.RegisterServerCallback("2na_garage:repairVehicleEngine", function(source, data, cb) 
    local playerVehicles = TwoNa.GetPlayerVehicles(source)
    local targetVehicle = nil

    for k,v in ipairs(playerVehicles) do
        if v.plate == data.plate then 
            targetVehicle = v
        end
    end

    if not targetVehicle then
        return cb(false)
    end

    targetVehicle.properties.engineHealth = 1000.0

    local success = TwoNa.UpdatePlayerVehicle(source, data.plate, targetVehicle)

    cb(success)
end)

TwoNa.RegisterServerCallback("2na_garage:transferVehicle", function(source, data, cb) 
    local playerVehicles = TwoNa.GetPlayerVehicles(source)
    local isVehicleOwned = false

    for k,v in ipairs(playerVehicles) do
        if v.plate == data.plate then 
            isVehicleOwned = true
        end
    end

    if not isVehicleOwned then 
        return cb(false)
    end

    local success = TwoNa.UpdateVehicleOwner(data.plate, data.newOwner)

    cb(success)
end)

TwoNa.RegisterServerCallback("2na_garage:getVehicleByName", function(source, data, cb) 
    local vehicle = TwoNa.GetVehicleByName(data.name)

    cb(vehicle)
end)