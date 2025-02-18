
ESX = nil 

Config['Setup_sv']()

for i ,v in pairs(Config['Armor']) do 
	ESX.RegisterUsableItem(v['item_name'], function(source)
		local _source = source
		local xPlayer  = ESX.GetPlayerFromId(source)
		local xItem = xPlayer.getInventoryItem(v['item_name'])
		if v['CheckCount'] then 
			if xItem.limit ~= -1 and  xItem.count > xItem.limit then 
				TriggerClientEvent('alonedev.esport:notify', _source , 'จำนวนเกิน')
				return
			end
		end

		if v['Job'] then 
			local check = false
			for _ ,jobname in pairs(v['Job']) do 
				if xPlayer.job.name == jobname then 
					check = true
				end
			end

			if not check then 
				TriggerClientEvent('alonedev.esport:notify', _source , 'อาชีพไม่ได้รับอนุญาต')
				return
			end
		end
	
		TriggerClientEvent('alonedev.esport:onArmor', _source , v )
	end)
end

