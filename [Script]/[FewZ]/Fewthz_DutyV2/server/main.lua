ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local dutyjobsinfo = {}
local offdutyjobsinfo = {}
local OnDutyJobsList = {}
local OffDutyJobsList = {}

Citizen.CreateThread(function()
	for k,v in pairs(Config.Zones) do
		if not dutyjobsinfo[v.job] then OnDutyJobsList[#OnDutyJobsList+1] = v.job end
		if not offdutyjobsinfo[v.offjob] then OffDutyJobsList[#OffDutyJobsList+1] = v.offjob end
		dutyjobsinfo[v.job] = v.offjob
		offdutyjobsinfo[v.offjob] = v.job
	end
end)

RegisterServerEvent('esx_duty:toggleduty')
AddEventHandler('esx_duty:toggleduty', function(job)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.name
    local grade = xPlayer.job.grade
    
    if dutyjobsinfo[job] then
        xPlayer.setJob(dutyjobsinfo[job], grade)
		TriggerClientEvent('codem-notification', source, _U('offduty'), 3000, 'error', options)
		JobOFF()
		TriggerClientEvent('Fewthz:loaddefult', _source)
    elseif offdutyjobsinfo[job] then
        xPlayer.setJob(offdutyjobsinfo[job], grade)
		TriggerClientEvent('codem-notification', source, _U('offduty'), 3000, 'check', options)
		JobON()
    end
end)
local Duty = false

function JobON()
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local name = GetPlayerName(_source)
    local job = xPlayer.job.name
    local grade = xPlayer.job.grade
	local sendToDiscord = 'Stream: ' .. name .. ' ชื่อ : ' ..xPlayer.name.. ' หน่วยงาน: ' .. job .. ' ระดับ: ' .. grade .. ' เข้าเวรแล้ว'

	if job == 'police' then
        TriggerEvent('azael_discordlogs:sendToDiscord', 'JobDutyPolice', sendToDiscord, _source, '^3')
		if grade == 0 then
			TriggerClientEvent('Fewthz:policecloth0', _source)
		elseif grade == 1 then
			TriggerClientEvent('Fewthz:policecloth1', _source)
		elseif grade == 2 then
			TriggerClientEvent('Fewthz:policecloth2', _source)
		elseif grade == 3 then
			TriggerClientEvent('Fewthz:policecloth3', _source)
		elseif grade == 4 then
			TriggerClientEvent('Fewthz:policecloth4', _source)
		elseif grade == 5 then
			TriggerClientEvent('Fewthz:policecloth5', _source)
		elseif grade == 6 then
			TriggerClientEvent('Fewthz:policecloth6', _source)
		elseif grade == 7 then
			TriggerClientEvent('Fewthz:policecloth7', _source)
		elseif grade == 8 then
			TriggerClientEvent('Fewthz:policecloth8', _source)
		elseif grade == 9 then
			TriggerClientEvent('Fewthz:policecloth9', _source)
		elseif grade == 10 then
			TriggerClientEvent('Fewthz:policecloth10', _source)
		elseif grade == 11 then
			TriggerClientEvent('Fewthz:policecloth11', _source)
		elseif grade == 12 then
			TriggerClientEvent('Fewthz:policecloth12', _source)
		elseif grade == 13 then
			TriggerClientEvent('Fewthz:policecloth13', _source)
		elseif grade == 14 then
			TriggerClientEvent('Fewthz:policecloth14', _source)
		elseif grade == 15 then
			TriggerClientEvent('Fewthz:policecloth15', _source)
		elseif grade == 16 then
			TriggerClientEvent('Fewthz:policecloth16', _source)
		elseif grade == 17 then
			TriggerClientEvent('Fewthz:policecloth17', _source)
		elseif grade == 18 then
			TriggerClientEvent('Fewthz:policecloth18', _source)
			
		end

	elseif job == 'ambulance' then
        TriggerEvent('azael_discordlogs:sendToDiscord', 'JobDutyAmbulance', sendToDiscord, _source, '^3')
		if grade == 0 then
			TriggerClientEvent('Fewthz:ambulancecloth0', _source)
		elseif grade == 1 then
			TriggerClientEvent('Fewthz:ambulancecloth1', _source)
		elseif grade == 2 then
			TriggerClientEvent('Fewthz:ambulancecloth2', _source)
		elseif grade == 3 then
			TriggerClientEvent('Fewthz:ambulancecloth3', _source)
		elseif grade == 4 then
			TriggerClientEvent('Fewthz:ambulancecloth4', _source)
		elseif grade == 5 then
			TriggerClientEvent('Fewthz:ambulancecloth5', _source)
		elseif grade == 6 then
			TriggerClientEvent('Fewthz:ambulancecloth6', _source)
		elseif grade == 7 then
			TriggerClientEvent('Fewthz:ambulancecloth7', _source)
		end
	elseif job == 'mechanic' then
        TriggerEvent('azael_discordlogs:sendToDiscord', 'JobDutyMechanic', sendToDiscord, _source, '^3')
		if grade == 0 then
			TriggerClientEvent('Fewthz:mechaniccloth0', _source)
		elseif grade == 1 then
			TriggerClientEvent('Fewthz:mechaniccloth1', _source)
		elseif grade == 2 then
			TriggerClientEvent('Fewthz:mechaniccloth2', _source)
		elseif grade == 3 then
			TriggerClientEvent('Fewthz:mechaniccloth3', _source)
		elseif grade == 4 then
			TriggerClientEvent('Fewthz:mechaniccloth4', _source)
		elseif grade == 5 then
			TriggerClientEvent('Fewthz:mechaniccloth5', _source)
		end
    end
	TriggerEvent('Timeing')
end

function JobOFF()
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local name = GetPlayerName(_source)
    local job = xPlayer.job.name
    local grade = xPlayer.job.grade
	local sendToDiscord = 'Stream: ' .. name .. ' ชื่อ : ' ..xPlayer.name.. ' หน่วยงาน: ' .. job .. ' ระดับ: ' .. grade .. ' ออกเวรแล้ว'
	
	if job == 'offpolice' then
        TriggerEvent('azael_discordlogs:sendToDiscord', 'JobDutyPolice', sendToDiscord, _source, '^2')
		-- if xPlayer.getWeapon('WEAPON_STUNGUN') then
			-- xPlayer.removeWeapon('WEAPON_STUNGUN')
		-- end
		-- if xPlayer.getWeapon('WEAPON_COMBATPISTOL') then
			-- xPlayer.removeWeapon('WEAPON_COMBATPISTOL')
		-- end
		-- if xPlayer.getWeapon('WEAPON_NIGHTSTICK') then
			-- xPlayer.removeWeapon('WEAPON_NIGHTSTICK')
		-- end
		-- if xPlayer.getWeapon('WEAPON_PUMPSHOTGUN') then
			-- xPlayer.removeWeapon('WEAPON_PUMPSHOTGUN')
		-- end

	elseif job == 'offambulance' then
        TriggerEvent('azael_discordlogs:sendToDiscord', 'JobDutyAmbulance', sendToDiscord, _source, '^2')
	elseif job == 'offmechanic' then
        TriggerEvent('azael_discordlogs:sendToDiscord', 'JobDutyMechanic', sendToDiscord, _source, '^2')
	end
	Duty = false
end

--Exports

function CheckDuty(source)
	if not source then return nil end
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local playerjob = xPlayer.job.name
	
	if dutyjobsinfo[playerjob] then
		return true
	elseif offdutyjobsinfo[playerjob] then
		return false
	else
		return nil
	end
end

exports("CheckDuty", CheckDuty)

function GetOffDutyJobs()
    return OffDutyJobsList
end

exports("GetOffDutyJobs", GetOffDutyJobs)

function GetOnDutyJobs()
    return OnDutyJobsList
end

exports("GetOnDutyJobs", GetOnDutyJobs)

function IsJobOnDuty(JobName)
	if dutyjobsinfo[JobName] then
		return true
	else
		return nil
	end
end

exports("IsJobOnDuty", IsJobOnDuty)

function IsJobOffDuty(JobName)
	if offdutyjobsinfo[JobName] then
		return true
	else
		return nil
	end
end

exports("IsJobOffDuty", IsJobOffDuty)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(source)
	if Config.PlayerJoinOffDuty then
		local xPlayer = ESX.GetPlayerFromId(source)
		local g = xPlayer.getJob().grade

		if xPlayer.getJob().name == 'police' then
			xPlayer.setJob('offpolice', g)
		elseif xPlayer.getJob().name == 'ambulance' then
			xPlayer.setJob('offambulance', g)
		elseif xPlayer.getJob().name == 'mechanic' then
			xPlayer.setJob('offmechanic', g)
		end
	end
end)

ESX.RegisterCommand('getpolice', 'admin', function(xPlayer, args, showError)
    local count = 0
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        local job = xPlayer.getJob()
        if job.name == 'police' then
            print(xPlayer.name)
            count = count + 1
            
        end
    end

    if count == 0 then
        xPlayer.triggerEvent('pNotify:SendNotification', {
            text = "ไม่มีตำรวจ",
            type = "error",
            queue = "center",
            timeout = 5000,
            layout = "bottomCenter"
        })
    elseif count > 0 then
        xPlayer.triggerEvent('pNotify:SendNotification', {
            text = "มีตำรวจทั้งหมด "..count.." คน",
            type = "error",
            queue = "center",
            timeout = 5000,
            layout = "bottomCenter"
        })
    end

    
end, false, {help = ''})

ESX.RegisterCommand('getambulance', 'admin', function(xPlayer, args, showError)
    local count = 0
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        local job = xPlayer.getJob()
        if job.name == 'ambulance' then
            print(xPlayer.name)
            count = count + 1
            
        end
    end

    if count == 0 then
        xPlayer.triggerEvent('pNotify:SendNotification', {
            text = "ไม่มีหมอ",
            type = "error",
            queue = "center",
            timeout = 5000,
            layout = "bottomCenter"
        })
    elseif count > 0 then
        xPlayer.triggerEvent('pNotify:SendNotification', {
            text = "มีหมอทั้งหมด "..count.." คน",
            type = "error",
            queue = "center",
            timeout = 5000,
            layout = "bottomCenter"
        })
    end
end, false, {help = ''})

ESX.RegisterCommand('getmechanic', 'admin', function(xPlayer, args, showError)
    local count = 0
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        local job = xPlayer.getJob()
        if job.name == 'mechanic' then
            print(xPlayer.name)
            count = count + 1
            
        end
    end

    if count == 0 then
        xPlayer.triggerEvent('pNotify:SendNotification', {
            text = "ไม่มีช่าง",
            type = "error",
            queue = "center",
            timeout = 5000,
            layout = "bottomCenter"
        })
    elseif count > 0 then
        xPlayer.triggerEvent('pNotify:SendNotification', {
            text = "มีช่างทั้งหมด "..count.." คน",
            type = "error",
            queue = "center",
            timeout = 5000,
            layout = "bottomCenter"
        })
    end
end, false, {help = ''})

ESX.RegisterCommand('getmod', 'admin', function(xPlayer, args, showError)
    local count = 0
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        local job = xPlayer.getJob()
        if job.name == 'mod' then
            print(xPlayer.name)
            count = count + 1
            
        end
    end

    if count == 0 then
        xPlayer.triggerEvent('pNotify:SendNotification', {
            text = "ไม่มีสภา",
            type = "error",
            queue = "center",
            timeout = 5000,
            layout = "bottomCenter"
        })
    elseif count > 0 then
        xPlayer.triggerEvent('pNotify:SendNotification', {
            text = "มีสภาทั้งหมด "..count.." คน",
            type = "error",
            queue = "center",
            timeout = 5000,
            layout = "bottomCenter"
        })
    end
end, false, {help = ''})

