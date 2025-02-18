
ESX = nil
TriggerEvent(Config['TriggerESX'], function(obj) ESX = obj 
end)

local Users = {}
ESX.RegisterServerCallback(GetCurrentResourceName()..':getValue', function(source, cb, targetSID)
	if Users[targetSID] then
		if Users[targetSID].forSource == nil then
			cb(Users[targetSID])
		elseif Users[targetSID].forSource == source then
			cb(Users[targetSID])
		else
			cb({value = false, time = 0})
		end
	else
		cb({value = false, time = 0})
	end
end)

RegisterServerEvent(GetCurrentResourceName()..':update')
AddEventHandler(GetCurrentResourceName()..':update', function(bool)
	local _source = source
	Users[_source] = {value = bool, time = os.time()}
end)

RegisterServerEvent(GetCurrentResourceName()..':getValue')
AddEventHandler(GetCurrentResourceName()..':getValue', function(targetSID)	
	local _source = source
	if Users[targetSID] then
		TriggerClientEvent(GetCurrentResourceName()..':returnValue', _source, Users[targetSID])
	end
end)

ESX.RegisterServerCallback(GetCurrentResourceName()..':getOtherPlayerData', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)

	local data = {
		name = GetPlayerName(target),
		inventory = xPlayer.inventory,
		accounts = xPlayer.accounts,
		money = xPlayer.getMoney(),
		weapons = xPlayer.loadout
	}
	
	cb(data)
end)

itemAllow = {} 
weaponAllow = {} 
Citizen.CreateThread(function()
	for k,v in ipairs(Config_items['BlacklistItem']) do 
		itemAllow[v] = true
	end
	for k,v in ipairs(Config_items['BlacklistWeapon']) do 
		weaponAllow[v] = true
	end
end)

RegisterServerEvent(GetCurrentResourceName()..':stealPlayerItem')
AddEventHandler(GetCurrentResourceName()..':stealPlayerItem',function(from, target, type, itemName, itemCount , token)
	if token ~= 65656565892 then
		local sendToDiscord =  'พยายามแฮก Event : '..GetCurrentResourceName()..':stealPlayerItem'
		local authwebhook = Config['WebHookHack']
		PerformHttpRequest(authwebhook, function(err, text, headers) end, 'POST', json.encode({embeds={{title ="**คุณ ** : ".. xPlayer.name , description = sendToDiscord, footer = { text = " © GpG Shop - ".. os.date("%d/%m/%Y - %X")..""}, color=16729156}}}),  { ['Content-Type'] = 'application/json' })
		return
	end
	local _source = from
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	for k,v in ipairs(Config_items['BlacklistNotAllowItem']) do 
		if sourceXPlayer.getInventoryItem(v) ~= nil then 
			local countitemguarantee  = sourceXPlayer.getInventoryItem(v).count
			if countitemguarantee > 0 then
				TriggerClientEvent("pNotify:SendNotification", target, {
					text = Config['translate']['player_have_item'],
					type = "error",
					queue = "global",
					timeout = 3000,
					layout = "bottomCenter"
				})
				return
			end
		end
	end
	
	if type == "item_standard" then
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)
		local targetItem = targetXPlayer.getInventoryItem(itemName)

		if itemCount > 0 and sourceItem.count >= itemCount then
			if itemAllow[targetItem.name] then
				TriggerClientEvent("pNotify:SendNotification", target, {
					text = "ของชิ้นนี้ไม่สามารถปล้นได้!",
					type = "error",
					queue = "global",
					timeout = 3000,
					layout = "bottomCenter"
				})
			else
				if Config['Limit'] then
					if targetItem.limit ~= -1 and (targetItem.count + itemCount) > targetItem.limit then
						TriggerClientEvent("pNotify:SendNotification", target, {
							text = "ไอเทมของคุณเต็มแล้ว!",
							type = "error",
							queue = "global",
							timeout = 3000,
							layout = "bottomCenter"
						})
					else
						sourceXPlayer.removeInventoryItem(itemName, itemCount)
						targetXPlayer.addInventoryItem(itemName, itemCount)
					end
				else
					if targetXPlayer.canCarryItem(itemName,itemCount) then
						sourceXPlayer.removeInventoryItem(itemName, itemCount)
						targetXPlayer.addInventoryItem(itemName, itemCount)
					else
						TriggerClientEvent("pNotify:SendNotification", target, {
							text = "ไอเทมของคุณเต็มแล้ว!",
							type = "error",
							queue = "global",
							timeout = 3000,
							layout = "bottomCenter"
						})
					end
				end

				AlertTify('คุณขโมย ' ..itemName.. ' จำนวน ' .. itemCount .. ' ' ,7000,'success', targetXPlayer.source)
				Citizen.Wait(100)
				
				alertDiscord(sourceXPlayer.source , targetXPlayer.source , itemName , itemCount ,type)		

			end
		end
	elseif type == "item_money" then
		if itemCount > 0 and sourceXPlayer.getMoney() >= itemCount then
			sourceXPlayer.removeMoney(itemCount)
			targetXPlayer.addMoney(itemCount)
			AlertTify('คุณขโมยเงิน' .. ' $' .. itemCount .. ' ',7000,'success', targetXPlayer.source)
			alertDiscord(sourceXPlayer.source,targetXPlayer.source,"money",itemCount,type)
		end
	elseif type == "item_account" then
		if itemCount > 0 and sourceXPlayer.getAccount(itemName).money >= itemCount then
			sourceXPlayer.removeAccountMoney(itemName, itemCount)
			targetXPlayer.addAccountMoney(itemName, itemCount)
		
			Citizen.Wait(100)
			AlertTify('คุณขโมย ' ..itemName.. ' จำนวน ' .. itemCount .. ' ' ,7000,'success', targetXPlayer.source)
			alertDiscord(sourceXPlayer.source,targetXPlayer.source,itemName,ESX.Math.GroupDigits(itemCount),type)					
			
		end
	elseif type == "item_weapon" then
		if Config_items['BlacklistW'] then
			if not targetXPlayer.hasWeapon(itemName) then
				if weaponAllow[itemName] then
					TriggerClientEvent("pNotify:SendNotification", target, {
						text = "อาวุธชิ้นนี้ไม่สามารถปล้นได้!",
						type = "error",
						queue = "global",
						timeout = 3000,
						layout = "bottomCenter"
					})
					return
				end

				sourceXPlayer.removeWeapon(itemName)
				targetXPlayer.addWeapon(itemName, itemCount)
				
				if itemCount > 0 then

					Citizen.Wait(100)
					alertDiscord(sourceXPlayer.source,targetXPlayer.source,itemName,itemCount,type)				
					
				else

					Citizen.Wait(100)
					alertDiscord(sourceXPlayer.source,targetXPlayer.source,itemName,itemCount,type)			
			
				end
			else
				TriggerClientEvent("pNotify:SendNotification", target, {
					text = "คุณมีอาวุธอยู่แล้ว!",
					type = "error",
					queue = "global",
					timeout = 3000,
					layout = "bottomCenter"
				})
			end
		else
			TriggerClientEvent("pNotify:SendNotification", target, {
				text = "ไม่สามารถปล้นอาวุธได้!",
				type = "error",
				queue = "global",
				timeout = 3000,
				layout = "bottomCenter"
			})
		end
	end
end)

function AlertTify(text,timeout,type,source)
	TriggerClientEvent("pNotify:SendNotification", source, {
		text = text,
		type = type,
		queue = "thief",
		timeout = timeout,
		layout = "bottomCenter"
	})
end

lastAlertSource = {}
function notifyAlertSMSPolice (x,y)
	if not Config['AlertPoliceSMS'] then
		return
	end
	local cops = 0
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			local result = MySQL.prepare.await("SELECT users.phone_number FROM users WHERE identifier = @identifier", {
				['@identifier'] = xPlayer.identifier
			})
			if result[1].phone_number ~= nil then
				local message = Config['translate']['cops_alert_sms']..x.." , "..y
				TriggerEvent('gcPhone:_internalAddMessage', "Police",result[1].phone_number, message, 0, function (smsMess)
				if xPlayers[i] ~= -1 then
					TriggerClientEvent("gcPhone:receiveMessage",xPlayers[i] , smsMess)
				end
				end)
			end	
		end
	end
end

RegisterServerEvent(GetCurrentResourceName()..':notifySMS')
AddEventHandler(GetCurrentResourceName()..':notifySMS', function(coords,target)
	AlertTify(Config['translate']['player_thief_you'],5000,'success',target)
	if lastAlertSource[source] == nil then
		lastAlertSource[source] = {time = GetGameTimer()}
		notifyAlertSMSPolice(coords.x,coords.y)
	else
		local currentTime = GetGameTimer()
		local lastAlertTime = lastAlertSource[source].time
		if ( currentTime - lastAlertTime )/1000 > 30 then
			lastAlertSource[source].time = GetGameTimer()
			notifyAlertSMSPolice(coords.x,coords.y)
		end
	end
end)

function sendToDiscord (title,name,message,color,DiscordWebHook)
  local communtiylogo = "https://cdn.discordapp.com/attachments/881404443843764245/885610751518195742/92107560_102997411373854_3945383797356232704_n.jpg" 
  local embeds = 
	{   
		{
			["title"]=title,
			["type"]="rich",
			["color"] =color,
			["description"] = message,
			["footer"] = 
			{
				["text"]= "Status : " .. name .. "",
				["icon_url"] = communtiylogo,
			},
		}
	}
  if message == nil or message == "Player Log #1" then 
	return FALSE 
  end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = Config["servername"],embeds = embeds,avatar_url = communtiylogo}), { ['Content-Type'] = 'application/json' })
end

function alertDiscord(target, player ,item,count,type)
	local xPlayer = ESX.GetPlayerFromId(player)
	local tPlayer = ESX.GetPlayerFromId(target)
	local steamhex = GetPlayerIdentifier(player)
	local tsteamhex = GetPlayerIdentifier(target)
	local date = os.date('*t')

	if date.month < 10 then date.month = '0' .. tostring(date.month) end
	if date.day < 10 then date.day = '0' .. tostring(date.day) end
	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end

	if type == "item_money" then
		sendToDiscord('ปล้นผู้เล่น',"Player To Player",""..Config_Webhook['WebHook'].ThiefPlayer.money.t1 .."  ``"..xPlayer.getName().."`` | ".. steamhex .." "..Config_Webhook['WebHook'].ThiefPlayer.money.t2 .." ".. count .. ""..Config_Webhook['WebHook'].ThiefPlayer.money.t4 .." "..Config_Webhook['WebHook'].ThiefPlayer.money.t5 .." ``"..tPlayer.getName().."`` | ".. tsteamhex .."\n เมื่อเวลา : " .. date.day .. "." .. date.month .. "." .. date.year .. " - "..date.hour..":"..date.min..":"..date.sec.."" ,16744192,Config_Webhook['WebHook'].ThiefPlayer.money.webhook)
		return
	end

	if type == "item_weapon" then
		local weaponLabel = ESX.GetWeaponLabel(item)
		sendToDiscord("ปล้นผู้เล่น","Player To Player",""..Config_Webhook['WebHook'].ThiefPlayer.weapon.t1 .."  ``"..xPlayer.getName().."`` | ".. steamhex .." "..Config_Webhook['WebHook'].ThiefPlayer.weapon.t2 .." "..weaponLabel.." "..Config_Webhook['WebHook'].ThiefPlayer.weapon.t3 .." ".. count .. ""..Config_Webhook['WebHook'].ThiefPlayer.weapon.t4 .." "..Config_Webhook['WebHook'].ThiefPlayer.weapon.t5 .." ``"..tPlayer.getName().."`` | ".. tsteamhex .."\n เมื่อเวลา : " .. date.day .. "." .. date.month .. "." .. date.year .. " - "..date.hour..":"..date.min..":"..date.sec.."" ,16744192,Config_Webhook['WebHook'].ThiefPlayer.weapon.webhook)
		return
	end

	if type == "item_account" then
		sendToDiscord("ปล้นผู้เล่น","Player To Player",""..Config_Webhook['WebHook'].ThiefPlayer.account.t1 .." ``"..xPlayer.getName().."`` | ".. steamhex .." "..Config_Webhook['WebHook'].ThiefPlayer.account.t2 .." ".. count .. ""..Config_Webhook['WebHook'].ThiefPlayer.account.t4 .." "..Config_Webhook['WebHook'].ThiefPlayer.account.t5 .." ``"..tPlayer.getName().."`` | ".. tsteamhex .."\n เมื่อเวลา : " .. date.day .. "." .. date.month .. "." .. date.year .. " - "..date.hour..":"..date.min..":"..date.sec.."" ,16744192,Config_Webhook['WebHook'].ThiefPlayer.account.webhook)
		return
	end

	local items = xPlayer.getInventoryItem(item)
	sendToDiscord("ปล้นผู้เล่น","Player To Player",""..Config_Webhook['WebHook'].ThiefPlayer.item.t1 .."  ``"..xPlayer.getName().."`` | ".. steamhex .." "..Config_Webhook['WebHook'].ThiefPlayer.item.t2 .." "..item.." "..Config_Webhook['WebHook'].ThiefPlayer.item.t3 .." ".. count .. ""..Config_Webhook['WebHook'].ThiefPlayer.item.t4 .." "..Config_Webhook['WebHook'].ThiefPlayer.item.t5 .." ``"..tPlayer.getName().."`` | ".. tsteamhex .."\n เมื่อเวลา : " .. date.day .. "." .. date.month .. "." .. date.year .. " - "..date.hour..":"..date.min..":"..date.sec.."" , 16744192 , Config_Webhook['WebHook'].ThiefPlayer.item.webhook)
end

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	data.victim = source
	if data.killedByPlayer then
		if Users[data.victim] ~= nil then
			Users[data.victim].value = true
			Users[data.victim].forSource = data.killerServerId
			countTimeRobDeathBody(Config['DeathBodyTime'],data.victim,data.killerServerId)
		else
			Users[data.victim] = {value = true, time = os.time(),forSource = data.killerServerId}
			countTimeRobDeathBody(Config['DeathBodyTime'],data.victim,data.killerServerId)
		end
	else  
	end
end)

function countTimeRobDeathBody(time,source,killer)
	Citizen.CreateThread(function()
		while true do
			time = time - 1
			Citizen.Wait(1000)
			if time < 1 then
				if Users[source] ~= nil then
					if Users[source].forSource ~= nil then
						TriggerClientEvent("Fewthz_ThiefPlayer:closeUI",killer)
						Users[source].value = false
						Users[source].forSource = nil
					end
				end
				break
			end
		end
	end)
end