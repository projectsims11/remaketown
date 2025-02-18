ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback("Fewthz_remote:isVehicleOwner",function(source, cb, plate)
        local identifier = GetPlayerIdentifier(source, 0)

        MySQL.Async.fetchAll(
            "SELECT owner FROM owned_vehicles WHERE owner = @owner AND plate = @plate",
            {
                ["@owner"] = identifier,
                ["@plate"] = plate
            },
            function(result)
                if result[1] then
                    cb(result[1].owner == identifier)
                else
                    cb(false)
                end
            end
        )
    end
)

ESX.RegisterServerCallback("Fewthz_remote:getVehicleKeys",function(source, cb)
        local _source = source

        local xPlayer = ESX.GetPlayerFromId(_source)

        local KeyInventory = {}

        local Vehicle_Key =
            MySQL.Sync.fetchAll(
            "SELECT * FROM owned_vehicles WHERE owner = @identifier",
            {
                ["@identifier"] = xPlayer.identifier
            }
        )

        for i = 1, #Vehicle_Key, 1 do
            table.insert(
                KeyInventory,
                {
                    label = Vehicle_Key[i].plate,
                    count = 1,
                    limit = -1,
                    type = "item_key",
                    name = "key",
                    usable = true,
                    rare = false,
                    canRemove = true
                }
            )
        end

        cb(KeyInventory)
    end
)
