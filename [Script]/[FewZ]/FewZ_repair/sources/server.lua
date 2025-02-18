ESX = exports["es_extended"]:getSharedObject()

RegisterServerEvent('FewZ_repair:Removemoney')
AddEventHandler('FewZ_repair:Removemoney', function(money)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeMoney(money)

end)