local CaseCache = {}

ESX = nil
script_name = GetCurrentResourceName()
TriggerEvent(Config["esx_routers"]['getSharedObject'], function(obj) ESX = obj end)

RegisterServerEvent(script_name .. ":SV:GetConfig")
AddEventHandler(script_name .. ":SV:GetConfig", function()
    TriggerClientEvent(script_name .. ":CL:GetConfig", source, CaseCache)
end)

RegisterServerEvent(script_name..":SV:SendEmergency")
AddEventHandler(script_name..":SV:SendEmergency", function(coords)
    local _source = source
    getPhoneNumber(_source, function (phone) 
        local Phone = phone
        local RDM = math.random(1, 999999)
        table.insert(CaseCache, {
            Cache = RDM,
            Number = Phone,
            Suscess = false,
            Owner = nil,
            Time = 0,
            Min = 0,
            Text = 'ไม่กี่วินาที',
            Coords = coords
        })
        TriggerClientEvent(script_name..":CL:SendEmergency", -1, {
            Cache = RDM,
            Number = Phone,
            Coords = coords
        })
    end)
end)

RegisterServerEvent(script_name..":SV:UpdateOwner")
AddEventHandler(script_name..":SV:UpdateOwner", function(Cache)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    for k, v in pairs(CaseCache) do
        if v.Cache == Cache then
            v.Owner = xPlayer.name
            TriggerClientEvent(script_name..":CL:UpdateOwner", -1, {
                Cache = v.Cache,
                Owner = xPlayer.name
            })
        end
    end
end)

RegisterServerEvent(script_name..":SV:UpdateSuscess")
AddEventHandler(script_name..":SV:UpdateSuscess", function(Cache)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    for k, v in pairs(CaseCache) do
        if v.Cache == Cache then
            v.Suscess = true
            TriggerClientEvent(script_name..":CL:UpdateSuscess", -1, v.Cache)
        end
    end
end)

RegisterServerEvent(script_name..":SV:UpdateDelete")
AddEventHandler(script_name..":SV:UpdateDelete", function(Cache)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    for k, v in pairs(CaseCache) do
        if v.Cache == Cache then
            RemoveCase(v.Cache)
            TriggerClientEvent(script_name..":CL:UpdateDelete", -1, v.Cache)
        end
    end
end)

function RemoveCase(Cache)
    local Cache = Cache
    local Notfound = false
    local Time = 15
    Citizen.CreateThread(function()
		while Time > 0 and not Notfound do
			Citizen.Wait(1000)
			if Time > 0 then
				Time = Time - 1
			end
		end
	end)
    
    while not Notfound do
        Wait(0)
        if Time == 0 then
            Notfound = true
        end
        for k,v in pairs(CaseCache) do
            if v.Cache == Cache then
                table.remove(CaseCache, k)
                Notfound = true
            end
        end
    end
end

function getPhoneNumber(source, callback) 
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer == nil then
        callback(nil)
    end
    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier',{
      ['@identifier'] = xPlayer.identifier
    }, function(result)
        callback(result[1].phone_number)
    end)
end

-- function getPhoneNumber (source, callback) 
--     local xPlayer = ESX.GetPlayerFromId(source)
--     if xPlayer == nil then
--         callback(nil)
--     end
--     exports.mongodb:findOne({
--         collection = 'es_extended', 
--         query = {
--             identifier = xPlayer.identifier
--         }, 
--     }, function(success, result)
--         if not success then
--             return
--         end
--         callback(result[1].phone_number)
--     end)
-- end

Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(1000)
        if #CaseCache > 0 then
            for i = 1, #CaseCache, 1 do
                CaseCache[i].Time = CaseCache[i].Time + 1
                if CaseCache[i].Time == 60 then
                    CaseCache[i].Min = CaseCache[i].Min + 1
                    CaseCache[i].Text = ('%s นาที'):format(CaseCache[i].Min)
                    CaseCache[i].Time = 0
                end
            end
        end
    end
end)