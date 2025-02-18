CheckTime = function()
    SetTimeout(1000, function()
        local a = os.date('%H:%M:%S', os.time())   
        for i=1, #Config.TimeReset, 1 do
            local b = Config.TimeReset[i][1]..':00'
            if a == b then  
                t[1](e.cl["ClearQuestState"], source)
            end
        end 
        CheckTime()   
	end)
end

if Config.EnableReset then
    CheckTime()
end

RegisEvent(true, e.sv["QuestRewards"], function(a)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    for k, v in pairs(Config.Quest[a].Reward) do 
        if v.type == 'money' or v.type == 'black_money' then
            xPlayer.addAccountMoney(v.type, v.quantity)
        else
            xPlayer.addInventoryItem(v.name, v.quantity)
        end
    end
end)

RegisEvent(true, e.sv["ResetQuestID"], function(a)
    local src = source
    t[1](e.cl["ResetQuestID"], src, a, Config.Quest[a].Count)
end)