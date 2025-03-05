if GetResourceState("es_extended") ~= "started" then return end

local ESX = exports["es_extended"]:getSharedObject()

function SpawnVehicle(vehicle, coords, heading, props)
    ESX.Game.SpawnVehicle(vehicle, coords, heading, function(spawnedVehicle)
        SetVehicleProps(spawnedVehicle, props)

        if Config.PlaceIntoVehicle then
            TaskWarpPedIntoVehicle(PlayerPedId(), spawnedVehicle, -1)
        end
    end)
end

function SetVehicleProps(vehicle, props)
    ESX.Game.SetVehicleProperties(vehicle, props)
end

function GetVehicleProps(vehicle)
    return ESX.Game.GetVehicleProperties(vehicle)
end

function Notify(message, type)
    ESX.ShowNotification(message)
end
