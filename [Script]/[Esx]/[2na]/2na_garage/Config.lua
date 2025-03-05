Config = {}

Config.TakeCarFromParkedGarage = true

Config.SpawnVehicleCost = 1500

Config.VehiceEngineRepairCost = 500

Config.Blips = {
    Garages = {
        Type = 357,
        Color = 26,
        Name = "Garage",
        DisplayWhenNear = true 
    },
    Impounds = {
        Type = 357,
        Color = 17,
        Name = "Impound",
        DisplayWhenNear = true  
    },
    GarageCenter = {
        Type = 374,
        Color = 2,
        Name = "Garage Center",
        DisplayWhenNear = true
    }
}

Config.GarageCenter = {
    Enabled = true,
    markerCoord = vector3(6.875, -710.879, 44.2)
}

Config.Garages = {
    { 
        id="pillboxgarage", 
        name = "Pillbox Garage", 
        cost = 150000,
        markerCoords = {
            menu = vector3(213.597, -809.033, 29.0),
        },
        vehicleCoords = {
            spawn = {
                coord = vector3(230.758, -797.621, 30.574), heading = 160
            },
            park = {
                coord = vector3(220.842, -773.369, 30.794), heading = nil
            }
        }
    },
    { 
        id="garage_2", 
        name = "24 Hour Garage", 
        cost = 150000,
        markerCoords = {
            menu = vector3(100.287, -1073.403, 27.6),
        },
        vehicleCoords = {
            spawn = {
                coord = vector3(124.953, -1081.847, 29.193), heading = 3.55
            },
            park = {
                coord = vector3(120.459, -1060.021, 29.192), heading = nil
            }
        }
    }
}

Config.Impounds = {
    {
        markerCoords = {
            menu = vector3(410.137, -1623.674, 27.5),
        },
        vehicleCoords = {
            spawn = {
                coord = vector3(403.267, -1636.009, 29.291), heading = 215
            },
        }
    }
}