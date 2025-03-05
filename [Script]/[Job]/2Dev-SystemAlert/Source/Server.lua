
ESX = nil

Citizen.CreateThread(function()
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)
end)

local CaseTable = {}
local CaseStatus = {
    waiting = 0,
    accept = 0,
    success = 0,
    all = 0
}

RegisterServerEvent("2Dev-SystemAlert:Add")
AddEventHandler("2Dev-SystemAlert:Add",function(alertname , coords)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local newFeedback = {
		caseid = #CaseTable + 1,
        patientid = src,
		coords = coords,
        alert = alertname,
        name = xPlayer.getName(),
        phone = getPhoneNumber(xPlayer.getIdentifier()),
        time = os.date("%X"),
        casestatus = false,
        acceptcase = 'ไม่มี',
        casesuccess = false
	}
	CaseTable[#CaseTable + 1] = newFeedback
    CaseStatus["waiting"] =  CaseStatus["waiting"] + 1
    CaseStatus["all"] =  CaseStatus["all"] + 1
	TriggerClientEvent("2Dev-SystemAlert:CASE", -1, CaseTable)
    TriggerClientEvent("2Dev-SystemAlert:CASESTATUS", -1, CaseStatus)
end)

RegisterServerEvent("2Dev-SystemAlert:UpdataStatus")
AddEventHandler("2Dev-SystemAlert:UpdataStatus",function(caesid)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if CaseTable[caesid]["casestatus"] == false then
        CaseTable[caesid]["casestatus"] = true
        CaseTable[caesid]["acceptcase"] = xPlayer.getName()
        CaseStatus["waiting"] =  CaseStatus["waiting"] - 1
        CaseStatus["accept"] =  CaseStatus["accept"] + 1
        TriggerClientEvent("2Dev-SystemAlert:CASEUPDATEBYID", -1, caesid, CaseTable[caesid], 'accept')
        TriggerClientEvent("2Dev-SystemAlert:CASESTATUS", -1, CaseStatus)
        TriggerClientEvent("2Dev-SystemAlert:ALERTTOPATIENT", CaseTable[caesid]["patientid"], 'หมอ '..CaseTable[caesid]["acceptcase"]..' รับเคสคุณแล้ว และกำลังเดินทางมารักษา..')  
    else
        print("Me kon rub case nee leaw")
    end
end)

RegisterServerEvent("2Dev-SystemAlert:CaseSuccess")
AddEventHandler("2Dev-SystemAlert:CaseSuccess",function(caesid)
    if CaseTable[caesid]["casestatus"] == true then
        CaseTable[caesid]["casestatus"] = "none"
        CaseStatus["accept"] =  CaseStatus["accept"] - 1
        CaseStatus["success"] =  CaseStatus["success"] + 1
        TriggerClientEvent("2Dev-SystemAlert:CASEUPDATEBYID", -1, caesid, CaseTable[caesid], 'success')
        TriggerClientEvent("2Dev-SystemAlert:CASESTATUS", -1, CaseStatus)   
    else
        print("Tong rub case gon na")
    end
end)

RegisterServerEvent("2Dev-SystemAlert:CaseDelete")
AddEventHandler("2Dev-SystemAlert:CaseDelete",function(caesid)
    CaseTable[caesid] = nil
    -- if CaseStatus["all"] > 0 then CaseStatus["all"] =  CaseStatus["all"] - 1 end
    if CaseStatus["waiting"] > 0 then CaseStatus["waiting"] =  CaseStatus["waiting"] - 1 end
    if CaseStatus["accept"] > 0 then CaseStatus["accept"] =  CaseStatus["accept"] - 1 end
    if CaseStatus["success"] > 0 then CaseStatus["success"] =  CaseStatus["success"] - 1 end
    TriggerClientEvent("2Dev-SystemAlert:CASEUPDATEBYID", -1, caesid, CaseTable[caesid], 'delete')
    TriggerClientEvent("2Dev-SystemAlert:CASESTATUS", -1, CaseStatus)   
    print("Delete case nee leaw")
end)

RegisterServerEvent("2Dev-SystemAlert:DelAllCase")
AddEventHandler("2Dev-SystemAlert:DelAllCase",function()
    CaseTable = {}
    -- CaseStatus["all"] =  0
    CaseStatus["waiting"] =  0
    CaseStatus["accept"] =  0
    CaseStatus["success"] =  0
    TriggerClientEvent("2Dev-SystemAlert:CASEUPDATEBYID", -1, caesid, CaseTable, 'deleteall')
    TriggerClientEvent("2Dev-SystemAlert:CASESTATUS", -1, CaseStatus)   
    print("Delete case tung mod leaw")
end)

RegisterNetEvent("2Dev-SystemAlert:FetchFeedData")
AddEventHandler("2Dev-SystemAlert:FetchFeedData", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer and xPlayer.job.name == 'ambulance' then
        ambulance = true
		TriggerClientEvent("2Dev-SystemAlert:FetchFeedData", source, CaseTable, ambulance)
    else
        ambulance = false
		TriggerClientEvent("2Dev-SystemAlert:FetchFeedData", source, CaseTable, ambulance)
	end
end)


function getPhoneNumber(identifier)
    local result = exports.oxmysql:single_async('SELECT phone_number FROM users WHERE identifier = ?', {identifier})
    if result then
        return result.phone_number
    end
    -- local result = MySQL.single.await('SELECT phone_number FROM users WHERE identifier = ?', {identifier})
    -- if result then
    --     return result.phone_number
    -- end
end
