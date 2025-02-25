ESX = exports['es_extended']:getSharedObject()

ESX.RegisterCommand(Config.Commandtxt, Config.Permission, function(xPlayer, args, showError)
    local source = xPlayer.source
    TriggerClientEvent('Ruby_UpgradeCar:upgradeVehicle', source)
end, true, {help = "Upgrade your vehicle to max."})
