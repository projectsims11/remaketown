ESX = exports["es_extended"]:getSharedObject()
FewZ = GetCurrentResourceName()

RegisterServerEvent(FewZ..':andmoney')
AddEventHandler(FewZ..':andmoney', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem = xPlayer.getInventoryItem(Config['Item'])
    local xItemCount = math.random(Config['Count'][1], Config['Count'][2])
    local Money = math.random(Config['MoneyCount'][1], Config['MoneyCount'][2])

    if Config['BlackMoney']then
        xPlayer.removeInventoryItem(Config['Item'], xItemCount)
    
        xPlayer.addAccountMoney('black_money', xItemCount * Money)
    else
        xPlayer.removeInventoryItem(Config['Item'], xItemCount)
    
        xPlayer.addMoney(xItemCount * Money)
    end

    if Config['ItemBonus'][1] ~= nil then
        for k,v in pairs(Config['ItemBonus']) do
            if math.random(1, 100) <= v.Percent then
				local xPlayer = ESX.GetPlayerFromId(_source)
				local A = xPlayer.getInventoryItem(v.ItemName)
                local B = v.ItemCount

                if Config['Extended'] then
                    if xPlayer.canCarryItem(A.name, B) then
                        xPlayer.addInventoryItem(A.name, B)
                    else
                        TriggerClientEvent(FewZ..':notify', _source, "error", "น้ำหนักในตัวของคุณเต็ม")
                    end
                else
				    if A.limit ~= -1 and A.count >= A.limit then
                        TriggerClientEvent(FewZ..':notify', _source, "error", "ไอเท็มโบนัสคุณเต็ม")
				    else
				    	if A.limit ~= -1 and (A.count + B) > A.limit then
				    		xPlayer.setInventoryItem(A.name, A.limit)
				    	else
				    		xPlayer.addInventoryItem(A.name, B)						
				    	end
				    end
                end
            end
        end
    end
end)

RegisterServerEvent(FewZ..':Removethief')
AddEventHandler(FewZ..':Removethief', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xItemCount = math.random(Config['Itemthief'][1], Config['Itemthief'][2])
    xPlayer.removeInventoryItem(Config['Item'], xItemCount)
end)

RegisterServerEvent(FewZ..':Addthief')
AddEventHandler(FewZ..':Addthief', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xItemCount = math.random(Config['Itemthief'][1], Config['Itemthief'][2])
    xPlayer.addInventoryItem(Config['Item'], xItemCount)
end)