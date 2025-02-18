_G.ESX = nil
_G.script_name =  "Fewthz_basic"

TriggerEvent(Config["Fewthz-Router"]["server_shared_obj"], function(obj) ESX = obj end)

ESX.RegisterUsableItem(Config["Item"]["Nightvision"], function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent(script_name..":nightvision", source)
end)

ESX.RegisterUsableItem(Config["Item"]["Thermalvision"], function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent(script_name..":thermalvision", source)
end)

ESX.RegisterUsableItem(Config["Item"]["Ammo"], function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.triggerEvent(script_name..":addammo")
end)

RegisterServerEvent(":deleteammo")
AddEventHandler(":deleteammo", function(weapon)
    local xPlayer = ESX.GetPlayerFromId(source)
	local weaponlebal = ESX.GetWeaponFromHash(weapon)
	xPlayer.addWeaponAmmo(weaponlebal.name, Config["Ammo_Count"])
	xPlayer.removeInventoryItem(Config["Item"]["Ammo"], 1)
end)