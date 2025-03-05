ESX = exports['es_extended']:getSharedObject()
FewZ = GetCurrentResourceName()

RegisterNetEvent(FewZ..':Get')
AddEventHandler(FewZ..':Get', function(item_name, count, job, k)
	local xPlayer = ESX.GetPlayerFromId(source)

	if Config.esx == 'limit' then
		local xItem = xPlayer.getInventoryItem(item_name)
		if xItem.limit ~= -1 and xItem.count >= xItem.limit then
			TriggerClientEvent(FewZ..':Stop', source)
			xPlayer.triggerEvent('pNotify:SendNotification', {
				text = "กระเป๋าเต็ม",
				type = "error",
				queue = "center",
				timeout = 5000,
				layout = "bottomCenter"
			})
		else
			if xItem.limit ~= -1 and (xItem.count + count) >= xItem.limit then
				xPlayer.setInventoryItem(item_name, xItem.limit)
			else
				xPlayer.addInventoryItem(item_name, count)
				webhook(source, 'Additem', 'item : ' .. item_name .. '\ncount : ' .. tostring(count))
			end
		end
	elseif	Config.esx == 'weight' then
		if xPlayer.canCarryItem(item_name, count) then
			xPlayer.addInventoryItem(item_name, count)
			webhook(source, 'Additem', 'item : ' .. item_name .. '\ncount : ' .. tostring(count))
		else
			TriggerClientEvent(FewZ..':Stop', source)
			xPlayer.triggerEvent('pNotify:SendNotification', {
				text = "นี่มันหนักเกินไปแล้วฉันแบกไม่ไหว🥺",
				type = "error",
				queue = "center",
				timeout = 5000,
				layout = "bottomCenter"
			})
		end
	else
		TriggerClientEvent(FewZ..':Stop', source)
		xPlayer.triggerEvent('pNotify:SendNotification', {
			text = "กระเป๋าเต็ม",
			type = "error",
			queue = "center",
			timeout = 5000,
			layout = "bottomCenter"
		})
	end

	if Config.Zone[k].Item.Bonus ~= nil then
		for k,v in pairs(Config.Zone[k].Item.Bonus) do
			if math.random(1, 100) <= v.Percent then
				if Config.esx == 'limit' then

					local xItem = xPlayer.getInventoryItem(v.ItemName)
					if xItem.limit ~= -1 and xItem.count >= xItem.limit then
						xPlayer.triggerEvent('pNotify:SendNotification', {
							text = "กระเป๋าเต็ม",
							type = "error",
							queue = "center",
							timeout = 5000,
							layout = "bottomCenter"
						})
					else
						if xItem.limit ~= -1 and (xItem.count + count) >= xItem.limit then
							xPlayer.setInventoryItem(v.ItemName, xItem.limit)
						else
							xPlayer.addInventoryItem(v.ItemName, v.ItemCount)
							webhook(source, 'AddBonus', 'item : ' .. v.ItemName .. '\ncount : ' .. tostring(v.ItemCount))
						end
					end

				elseif	Config.esx == 'weight' then

					if xPlayer.canCarryItem(v.ItemName, v.ItemCount) then
						xPlayer.addInventoryItem(v.ItemName, v.ItemCount)
						webhook(source, 'AddBonus', 'item : ' .. v.ItemName .. '\ncount : ' .. tostring(v.ItemCount))
					else
						xPlayer.triggerEvent('pNotify:SendNotification', {
							text = "นี่มันหนักเกินไปแล้วฉันแบกไม่ไหว🥺",
							type = "error",
							queue = "center",
							timeout = 5000,
							layout = "bottomCenter"
						})
					end
					
				end
			end
		end
	end
end)

RegisterNetEvent(FewZ..':Remove')
AddEventHandler(FewZ..':Remove', function(item_name, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem(item_name, count)
end)

function webhook(source, msg, footer)
	local xPlayer = ESX.GetPlayerFromId(source)
	sendToDiscord(16753920, "Fewthz_Process", 'identifier : ' .. xPlayer.identifier ..'\n\n' .. msg, footer)
end

function sendToDiscord(color, name, message, footer)
	local embed = {
		  {
			  ["color"] = color,
			  ["title"] = "**".. name .."**",
			  ["description"] = message or '',
			  ["footer"] = {
				  ["text"] = footer or '',
			  },
		  }
	  }
  
	PerformHttpRequest(Config.DISCORD_URL, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
  end
  