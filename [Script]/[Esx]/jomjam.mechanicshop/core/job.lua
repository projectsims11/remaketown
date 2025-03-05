ESX = nil
PlayerData = {}

jobName = nil

CreateThread(function()
    while (ESX == nil) do
		TriggerEvent(Config['Base'][1], function(obj) ESX = obj end)
		Wait(100)
    end
    
    while (ESX.GetPlayerData() == nil or ESX.GetPlayerData().job == nil or ESX.GetPlayerData().job.name == nil) do
		Wait(100)
	end

    PlayerData = ESX.GetPlayerData()
    
    jobName = getJobName()
    updateUICurrentJob()
end)

RegisterNetEvent(Config['Base'][2])
AddEventHandler(Config['Base'][2], function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent(Config['Base'][3])
AddEventHandler(Config['Base'][3], function(job)
    PlayerData.job = job
    
    jobName = getJobName()
    updateUICurrentJob()
end)

function getJobName()
    if (PlayerData ~= nil and PlayerData.job ~= nil and PlayerData.job.name ~= nil) then
        return PlayerData.job.name
	end
	return nil
end
