ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('Ruby_UpgradeCar:upgradeVehicle')
AddEventHandler('Ruby_UpgradeCar:upgradeVehicle', function()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)

    if vehicle == 0 then
        print("You are not in a vehicle!")
        return
    end

    local modTypes = {11, 12, 13, 15, 16}

    SetVehicleModKit(vehicle, 0) -- Must call to apply mods

    for _, modType in ipairs(modTypes) do
        local maxMod = GetNumVehicleMods(vehicle, modType) - 1
        if maxMod >= 0 then
            SetVehicleMod(vehicle, modType, maxMod, false)
        end
    end

    ToggleVehicleMod(vehicle, 18, true) -- Turbo
    print("UPGRADE!")
end)
