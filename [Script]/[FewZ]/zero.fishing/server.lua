

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
FzJob = GetCurrentResourceName()

ESX.RegisterUsableItem(Config['Itemuse'], function(source) --ชุป
	local xPlayer = ESX.GetPlayerFromId(source)
	local xZItem = xPlayer.getInventoryItem(Config['Removeitem'])
    TriggerClientEvent(FzJob..':Useitem',source)
	Citizen.Wait(10000)
end)


RegisterServerEvent(FzJob..':AddItem')
AddEventHandler(FzJob..':AddItem', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	 local xItem = xPlayer.getInventoryItem(Config['Additem'])
	local xZItem = xPlayer.getInventoryItem(Config['Removeitem'])
	if xItem.limit ~= -1 and xItem.count >= xItem.limit then
	 xPlayer.canCarryItem(Config['Additem'], math.random(Config['Drop'][1],Config['Drop'][2]))

		xPlayer.addInventoryItem(Config['Additem'], math.random(Config['Drop'][1],Config['Drop'][2]))
		TriggerClientEvent("UpdateQuest", source, "quest_fishing", 1)

	else
		TriggerClientEvent(FzJob..':auto', _source)
		
        TriggerEvent("mythic_notify:client:SendAlert",{
            text = 'เกินน้ำหนักที่กำหนด ! ! !',
            type = "error",
            timeout = 3000,
        })

		if Config['ต้องการให้ลบไอเท็มไหม'] then
			xPlayer.removeInventoryItem(Config['Removeitem'], 1)
		end
	end

	
	-- if xItem.limit ~= -1 and xItem.count >= xItem.limit then
		
	-- 	xPlayer.addInventoryItem(Config['Additem'], math.random(Config['Drop'][1],Config['Drop'][2]))
	-- else
	
	-- end


	
	if Config['เปอร์เซ็นที่เบ็ดจะเเตก'] ~= 0 then
		if math.random(1, 100) <= Config['เปอร์เซ็นที่เบ็ดจะเเตก'] then
			xPlayer.removeInventoryItem(Config['Itemuse'], 1)

			TriggerClientEvent("pNotify:SendNotification", source, {
				text ='เบ็ดของคุณหัก!! ' ,
				type = "error",
				timeout = 5000,
				layout = "bottomCenter" 
			})
			
		end
	end


	if Config['BonusDrop'] ~= nil then
		for k,v in pairs(Config['BonusDrop']) do
			if math.random(1, 100) <= v.Percent then
				local _source = source
				local xItemCount = math.random(v.ItemCount[1], v.ItemCount[2])
				local xPlayer = ESX.GetPlayerFromId(_source)
				local xItem = xPlayer.getInventoryItem(v.ItemName)




				--------------------   WEIGHT

				-- if xPlayer.canCarryItem(v.ItemName, xItemCount) then

				-- 	xPlayer.addInventoryItem(v.ItemName, xItemCount)
				-- else
				-- 	print('Weight Not!!')
				-- 	 TriggerClientEvent(FzJob..':Cancel', _source)
					
				-- 	xPlayer.triggerEvent("mythic_notify:client:SendAlert",{
				-- 		text = 'เกินน้ำหนักที่กำหนด ! ! !',
				-- 		type = "error",
				-- 		timeout = 3000,
				-- 	})
				-- end


				--------------------    LIMIT 

				if xItem.limit ~= -1 and (xItem.count + xItemCount) > xItem.limit then
					print('Limit Not!!')
					xPlayer.triggerEvent("mythic_notify:client:SendAlert",{
					    text = 'ไอเท็มเต็มบบางชิ้นเต็ม ! ! !',
					    type = "error",
					    timeout = 3000,
					})
				else
					xPlayer.addInventoryItem(xItem.name, xItemCount)
				end

				

			end
		end
	end


	
end)


