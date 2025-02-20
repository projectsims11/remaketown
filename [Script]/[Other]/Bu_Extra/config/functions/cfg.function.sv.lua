GetMyPlate = function( Plate ) -- เช็คป้ายทะเบียน
    local Result = MySQL.Async.fetchAll("SELECT 1 FROM owned_vehicles WHERE plate = @Plate", { ["@Plate"] = Plate })
    return Result
end

SetVehicle = function( Id , xPlayer , Type , Plate , VehicleName , VehicleProperty , Stored ) -- ได้รับกุญแจและลบกุญแจ
    if Type == "Create" then
        local VehicleType = GetVehicleType( VehicleName )
        MySQL.Async.execute("INSERT INTO owned_vehicles (owner, plate, vehicle, type) VALUES (@Owner, @Plate, @Property, @Type)", {
            ["@Owner"] = xPlayer.identifier,
            ["@Plate"] = Plate,
            ["@Property"] = json.encode( VehicleProperty ),
            ["@Type"] = VehicleType
        },function()
            exports['Bu_Garage']:ADDPLATE(xPlayer.source, VehicleProperty, { STORE = Stored, TYPE = VehicleType })
        end)
    elseif Type == "Delete" then
        MySQL.Async.execute("DELETE FROM owned_vehicles WHERE plate = @Plate", { ["@Plate"] = Plate },function()
            exports['Bu_Garage']:REMOVEPLATE(xPlayer.source, Plate)
        end)
    end
end

ValidateItem = function( Id , xPlayer , ItemName , ItemCount ) -- ตรวจสอบสิ่งของก่อนได้รับ
    -- if not xPlayer.canCarryItem( ItemName , ItemCount ) then
    --     return 0
    -- end

    local xItem = xPlayer.getInventoryItem( ItemName )
    if xItem.limit ~= -1 then 
        if xItem.count >= xItem.limit then
            return 0
        end
        
        if ( xItem.count + ItemCount ) > xItem.limit then
            ItemCount = xItem.limit - xItem.count
        end
    end

    return ItemCount
end