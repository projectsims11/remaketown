ESX = exports["es_extended"]:getSharedObject()

script_name = GetCurrentResourceName()
local reset_duration = Config.Duration
local cachedPlant = {}

ServerEvent = {
	":getItem"
}

RegisterNetEvent(script_name .. ':server:LoadConfig')
AddEventHandler(script_name .. ':server:LoadConfig',  function()
	TriggerClientEvent(script_name .. ':client:GetConfig', source, {
		se = ServerEvent;
		cp = cachedPlant
	})
end)

RegisterServerEvent(script_name .. ServerEvent[1])
AddEventHandler(script_name .. ServerEvent[1], function(netid)	
	local item = Config.Item
	local countitem = Config.ItemCount
	local xPlayer = ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem(item)
	if not xItem then
		return
	end
	if Config.esx == 'limit' then
		local xItem = xPlayer.getInventoryItem(item)
		if xItem.limit ~= -1 and xItem.count >= xItem.limit then
			xPlayer.triggerEvent('pNotify:SendNotification', {
				text = "กระเป๋าเต็ม",
				type = "error",
				queue = "center",
				timeout = 5000,
				layout = "bottomCenter"
			})
		else
			if xItem.limit ~= -1 and (xItem.count + countitem) >= xItem.limit then
				xPlayer.setInventoryItem(item, xItem.limit)
			else
				cachedPlant[netid] = GetGameTimer() + (reset_duration * 1000)

				exports.swift_quest:AddPoint(source, 3, 1) -- QUEST

				xPlayer.addInventoryItem(item, countitem)
				TriggerClientEvent(script_name .. "fetchCooldown", -1, netid, reset_duration)
			end
		end
	elseif	Config.esx == 'weight' then
		if xPlayer.canCarryItem(item, countitem) then
			cachedPlant[netid] = GetGameTimer() + (reset_duration * 1000)
			xPlayer.addInventoryItem(item, countitem)
			TriggerClientEvent(script_name .. "fetchCooldown", -1, netid, reset_duration)
		else
			-- @ น้ำหนักของคุณเต็มแล้ว
			xPlayer.triggerEvent('pNotify:SendNotification', {
				text = "น้ำหนักของคุณเต็มแล้ว",
				type = "error",
				queue = "center",
				timeout = 5000,
				layout = "bottomCenter"
			})
		end
	end
end)

RegisterServerEvent(script_name .. ":fetchCement")
AddEventHandler(script_name .. ":fetchCement", function(netid)
	if cachedPlant[netid] then return end
	cachedPlant[netid] = GetGameTimer() + (reset_duration * 1000)
	local src = source
	TriggerClientEvent(script_name .. ":fetchCement", -1, netid, src)
end)

CreateThread(function()
	while true do
		for k,v in pairs(cachedPlant) do
			if v < GetGameTimer() then
				cachedPlant[k] = nil
			end
		end
		Wait(30000)
	end
end)

print("^6FEWZ CABLE ^2DEBUG => ^2ON :D^0")