ESX = nil
local doorState = {}
local boom = {}
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_doorlock:updateState')
AddEventHandler('esx_doorlock:updateState', function(doorIndex, state)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer and type(doorIndex) == 'number' and type(state) == 'boolean' and Config.DoorList[doorIndex] and isAuthorized(xPlayer.job.name, Config.DoorList[doorIndex]) then
		doorState[doorIndex] = state
		TriggerClientEvent('esx_doorlock:setDoorState', -1, doorIndex, state)
	else
		doorState[doorIndex] = state
		TriggerClientEvent('esx_doorlock:setDoorState', -1, doorIndex, state)
	end
end)

RegisterServerEvent('esx_doorlock:boomd')
AddEventHandler('esx_doorlock:boomd', function(doorIndex, state)
	boom[doorIndex] = state
	TriggerClientEvent('esx_doorlock:boomd', -1, doorIndex, state)
	doorState[doorIndex] = not state
	TriggerClientEvent('esx_doorlock:setDoorState', -1, doorIndex,not state)
end)

ESX.RegisterServerCallback('esx_doorlock:getDoorState', function(source, cb)
	cb(doorState, boom)
end)

function isAuthorized(jobName, doorObject)
	for k,job in pairs(doorObject.authorizedJobs) do
		if job == jobName then
			return true
		end
	end
	return false
end

RegisterNetEvent('FewZ:Remove')
AddEventHandler('FewZ:Remove', function(item_name, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem(item_name, count)
end)

RegisterNetEvent("myevent:soundStatus")
AddEventHandler("myevent:soundStatus", function(type, musicId, data)
    TriggerClientEvent("myevent:soundStatus", -1, type, musicId, data)
end)
