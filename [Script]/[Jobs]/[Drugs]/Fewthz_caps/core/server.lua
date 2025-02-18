ESX = nil
scriptName = GetCurrentResourceName()
cd = {}

TriggerEvent("esx:getSharedObject", function(obj) 
    ESX = obj 
end)

ESX.RegisterServerCallback(scriptName.. ':checkitem',function(source,cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getInventoryItem(Config["Item"]).count > 0 then
		if Config["Itemreqdel"] then
			xPlayer.removeInventoryItem(Config["Item"] , Config["Itemam"])
		else
		end
		cb(true)		
	else
		cb(false)
	end
end)

function RandomItem()
	return Config["Getitem"][math.random(#Config["Getitem"])]
end
  
function RandomNumber()
	return math.random(Config["Amount"])
end 	

RegisterServerEvent(scriptName.. ':getitem')
AddEventHandler(scriptName.. ':getitem', function()
    local xPlayer = ESX.GetPlayerFromId(source)
	math.randomseed(GetGameTimer())
	if Config["Version"] then
		if xPlayer.canCarryItem(Config["Getitem"], 1) then
			local sourceItem = xPlayer.getInventoryItem(Config["Getitem"])
			if sourceItem.limit ~= -1 and (sourceItem.count + 1) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', _source, "player cannot hold")
			else
				xPlayer.addInventoryItem(RandomItem(), RandomNumber())				  
			end
		else
			TriggerClientEvent('esx:showNotification', _source," could not hold all of that ")
		end 
	else
		xPlayer.addInventoryItem(RandomItem(), RandomNumber())		
	end
	discord_webhook(source)
end)

AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
	Citizen.Wait(20000)
	print('^6FEWZ ^2SCRIPTS => ^2ON :D^0')
end)  

function discord_webhook(source)
	local xPlayer = ESX.GetPlayerFromId(source) -- 
    local embed
	local id = source
	embed = {{
		["color"] =  25500,
		["title"] = "".. ' ขโมยแคปซูล '.."\n ",
		["description"] = "ID : "..id.."\nName : "..xPlayer.getName().."\nIdentifier : "..xPlayer.identifier
	}}
	PerformHttpRequest(Config["Discordwebhook"], function(err, text, headers) end, 'POST', json.encode({username = username, embeds = embed}), { ['Content-Type'] = 'application/json' })
end