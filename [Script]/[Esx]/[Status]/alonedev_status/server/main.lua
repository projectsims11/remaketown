ESX = exports["es_extended"]:getSharedObject()

RegisterServerEvent('alonedev_status:removeItem')
AddEventHandler('alonedev_status:removeItem', function(item)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeInventoryItem(item, 1)

end)

local CheckJob = function(job , job_table)
	if job_table then 
		for i , v in pairs(job_table) do 
			if v == job then 
				return true
			end	
		end
	else 
		return true
	end

	return false
end

for k , v in pairs(Config.Food) do
    ESX.RegisterUsableItem(k, function(source)
        local xPlayer = ESX.GetPlayerFromId(source)
		local checkitem_pass = false
		if v.item_check.enable then 
			local check_item = xPlayer.getInventoryItem(v.item_check.item)
			if check_item and check_item.count > 0 then 
				checkitem_pass = true
			end
		else 
			checkitem_pass = true
		end


		if checkitem_pass then 
			if CheckJob(xPlayer.job.name , v.allowjob) then 
				TriggerClientEvent('alonedev_status:EatAll', source, k)
			else 
				TriggerClientEvent('alonedev_status:CL:notifromserver' , source , 'อาชีพคุณไม่ได้ถูกอนุญาติ')
			end
		end
    end)
end

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
    MySQL.Async.fetchAll('SELECT status FROM users WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.getIdentifier()
    }, function(result)
        local data = {}

        if result and result[1] and result[1].status then
            data = json.decode(result[1].status) or {}
        else
            data = {
                { percent = 100.00, val = 1000000, name = "stress" },
                { percent = 100.00, val = 1000000, name = "hunger" }
            }
        end

        xPlayer.set('status', data)
        TriggerClientEvent('alonedev_status:load', playerId, data)
    end)
end)


-- Citizen.CreateThread(function()
-- 	Wait(5000)
-- 	local xPlayers = ESX.GetPlayers()
-- 	for i = 1 , #xPlayers do 
-- 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
-- 		MySQL.Async.fetchAll('SELECT status FROM users WHERE identifier = @identifier', {
-- 			['@identifier'] = GetPlayerIdentifier(xPlayers[i])[1]
-- 		}, function(result)
-- 					local data = {}
		-- local pass = false

		-- if type(result) == 'table' and result ~= 'nil' then
		-- 	data = result
		-- 	pass = true
		-- end

		-- if pass then 
		-- 	xPlayer.set('status', data)
		-- else 
		-- 	xPlayer.set('status', {
		-- 		{
		-- 			percent= 100.00,
		-- 			val=1000000,
		-- 			name="stress"
		-- 		},
		-- 		{
		-- 			percent= 100.00,
		-- 			val=1000000,
		-- 			name="hunger"
		-- 		}
		-- 	})
		-- end

		-- print(result , data)
-- 			TriggerClientEvent('alonedev_status:load', xPlayers[i], data)
-- 		end)
-- 	end	
-- end)

AddEventHandler('esx:playerDropped', function(playerId, reason)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer then
        local status = xPlayer.get('status')
        if status then
            MySQL.Async.execute('UPDATE users SET status = @status WHERE identifier = @identifier', {
                ['@status'] = json.encode(status), -- Convert Lua table to JSON
                ['@identifier'] = xPlayer.identifier
            })
        end
    end
end)

AddEventHandler('alonedev_status:getStatus', function(playerId, statusName, cb)
	local xPlayer = ESX.GetPlayerFromId(playerId)
	local status  = xPlayer.get('status')

	for i=1, #status, 1 do
		if status[i].name == statusName then
			cb(status[i])
			break
		end
	end
end)

RegisterServerEvent('alonedev_status:update')
AddEventHandler('alonedev_status:update', function(status)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        xPlayer.set('status', status)
    end
end)

function SaveData()
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer then
            local status = xPlayer.get('status')
            if status then
                MySQL.Async.execute('UPDATE users SET status = @status WHERE identifier = @identifier', {
                    ['@status'] = json.encode(status), 
                    ['@identifier'] = xPlayer.identifier
                })
            end
        end
    end
    SetTimeout(10 * 60 * 1000, SaveData) -- Save every 10 minutes
end

SaveData()

