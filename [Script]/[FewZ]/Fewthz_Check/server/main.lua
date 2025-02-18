ESX = exports["es_extended"]:getSharedObject()

local Total_ALL = {
    All = 0,
    ambulance = 0,
    police = 0,
    mechanic = 0,
    council = 0,
}

AddEventHandler("esx:setJob", function(id, newjob, oldjob)
    if newjob.name ~= oldjob.name then
        if Total_ALL[oldjob.name] ~= nil then
            Total_ALL[oldjob.name] = Total_ALL[oldjob.name] - 1
            TriggerClientEvent(GetCurrentResourceName() .. "UpdateData", -1, Total_ALL[oldjob.name], oldjob.name)
        end
        if Total_ALL[newjob.name] ~= nil then
            Total_ALL[newjob.name] = Total_ALL[newjob.name] + 1
            TriggerClientEvent(GetCurrentResourceName() .. "UpdateData", -1, Total_ALL[newjob.name], newjob.name)
        end
    end
end)

AddEventHandler("esx:playerLoaded",function(id, xPlayer) 
    local ID = id
    Total_ALL.All = Total_ALL.All + 1
    if Total_ALL[xPlayer.job.name] ~= nil then
        Total_ALL[xPlayer.job.name] = Total_ALL[xPlayer.job.name] + 1
        TriggerClientEvent(GetCurrentResourceName() .. "UpdateData", -1, Total_ALL[xPlayer.job.name], xPlayer.job.name)
    end
    TriggerClientEvent(GetCurrentResourceName() .. "UpdateDataAll", -1, Total_ALL.All)
    Citizen.CreateThread(function()
        Citizen.Wait(3000)
        TriggerClientEvent(GetCurrentResourceName() .. "UpdateDataWhenstart", ID, Total_ALL)
    end)
end)

AddEventHandler('playerDropped', function(reason)
    Total_ALL.All = Total_ALL.All - 1
	local playerId = source
	local xPlayer = ESX.GetPlayerFromId(playerId)
    if Total_ALL[xPlayer.job.name] ~= nil then
        Total_ALL[xPlayer.job.name] = Total_ALL[xPlayer.job.name] - 1
        TriggerClientEvent(GetCurrentResourceName() .. "UpdateData", -1, Total_ALL[xPlayer.job.name], xPlayer.job.name)
    end
    TriggerClientEvent(GetCurrentResourceName() .. "UpdateDataAll", -1, Total_ALL.All)
end)




AddEventHandler("onResourceStart", function(i)
    if i == GetCurrentResourceName() then
        Citizen.CreateThread(function()
            Citizen.Wait(1000)
            WhenRestart()
        end)
    end
end)

function WhenRestart()
    local k = ESX.GetPlayers()
    for l = 1, #k, 1 do
        local xPlayer = ESX.GetPlayerFromId(k[l])
        if xPlayer then
            Total_ALL.All = Total_ALL.All + 1
            if Total_ALL[xPlayer.job.name] ~= nil then
                Total_ALL[xPlayer.job.name] = Total_ALL[xPlayer.job.name] + 1
            end
        end
    end
    for k, v in pairs(Total_ALL) do
        TriggerClientEvent(GetCurrentResourceName() .. "UpdateData", -1, v, k)
    end
    TriggerClientEvent(GetCurrentResourceName() .. "UpdateDataAll", -1, Total_ALL.All)
end