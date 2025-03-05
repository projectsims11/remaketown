
ESX = nil

Citizen.CreateThread(function() 
    while ESX == nil do 
        TriggerEvent(SERVER.FRAMEWORK.BASE .. ':getSharedObject', function(obj) ESX = obj end) 
        Citizen.Wait(1) 
    end 
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(100)
    end
end) 


Citizen.CreateThread(function()
	Wait(1000)
	TriggerServerEvent("2Dev-SystemAlert:FetchFeedData")
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob",function()
	TriggerServerEvent("2Dev-SystemAlert:FetchFeedData")
end)

local display = false
local blur = false
local ambulance = false
local soundalert = true
local FeedbackTable = {}
local CaseStatus = {
    waiting = 0,
    accept = 0,
    success = 0,
    all = 0
}

RegisterNUICallback('CLOSE', function()
    SetDisplay(false)
end)


RegisterNUICallback('SwitchSound', function(data)
    print(data.fixsound)
    soundalert = data.fixsound
end)

RegisterNUICallback('SetMark', function(data)
    SetNewWaypoint(tonumber(data.coordsx), tonumber(data.coordsy))
    TriggerEvent("pNotify:SendNotification", {
        text = "มาร์คจุดเรียบร้อย",
        type = "success",
        timeout = 2000,
    })
    TriggerServerEvent('2Dev-SystemAlert:UpdataStatus', data.caesid)
end)
RegisterNUICallback('Success', function(data)
    TriggerEvent("pNotify:SendNotification", {
        text = "ส่งเคสเรียบร้อย",
        type = "success",
        timeout = 2000,
    })
    TriggerServerEvent('2Dev-SystemAlert:CaseSuccess', data.caesid)
end)
RegisterNUICallback('DelCase', function(data)
    TriggerEvent("pNotify:SendNotification", {
        text = "ลบเคสเรียบร้อย",
        type = "success",
        timeout = 2000,
    })
    TriggerServerEvent('2Dev-SystemAlert:CaseDelete', data.caesid)
end)
RegisterNUICallback('DelAllCase', function()
    TriggerEvent("pNotify:SendNotification", {
        text = "ลบเคสทั้งหมดเรียบร้อย",
        type = "success",
        timeout = 2000,
    })
    TriggerServerEvent('2Dev-SystemAlert:DelAllCase')
end)

RegisterNetEvent('2Dev-SystemAlert:OpenUi')
AddEventHandler('2Dev-SystemAlert:OpenUi', function()
	if ambulance then
        SetDisplay(not display)
	end
end)

-- RegisterCommand('pmatest', function(source, args, rawCommand)
--     local plyState = Player(source).state
--     local proximity = plyState.proximity
--     print(ESX.DumpTable(proximity))
-- end, false)
-- AddEventHandler('pma-voice:setTalkingMode', function(newTalkingRange) 
--     print(newTalkingRange)
-- end)
-- AddEventHandler("pma-voice:radioActive", function(radioTalking) 
--     print(radioTalking)
-- end)

RegisterNetEvent('2Dev-SystemAlert:CASEUPDATEBYID')
AddEventHandler('2Dev-SystemAlert:CASEUPDATEBYID', function(caesid, newFeedback, typ)
	if ambulance then
        if typ == "accept" then
            FeedbackTable[caesid]["casestatus"] = true
            FeedbackTable[caesid]["acceptcase"] = newFeedback.acceptcase
            SendNUIMessage({
                action = "data-update-case-id",
                caesid = caesid,
                name = newFeedback.acceptcase,
                type = typ
            })
        elseif typ == "success" then
            FeedbackTable[caesid]["casestatus"] = "none"
            SendNUIMessage({
                action = "data-update-case-id",
                name = newFeedback.acceptcase,
                caesid = caesid,
                type = typ
            })
        elseif typ == "delete" then
            FeedbackTable[caesid] = nil
            SendNUIMessage({
                action = "data-update-case-id",
                caesid = caesid,
                type = typ
            })
        elseif typ == "deleteall" then
            FeedbackTable = {}
            SendNUIMessage({
                action = "data-update-case-id",
                type = typ
            })
        end
		
	end
end)

RegisterNetEvent('2Dev-SystemAlert:ALERTTOPATIENT')
AddEventHandler('2Dev-SystemAlert:ALERTTOPATIENT', function(txt)
    TriggerEvent("pNotify:SendNotification", {
        text = txt,
        type = "success",
        timeout = 2000,
    })
end)
RegisterNetEvent('2Dev-SystemAlert:CASE')
AddEventHandler('2Dev-SystemAlert:CASE', function(newFeedback)
	if ambulance then
        if soundalert then
            SendNUIMessage({
                action = "sound",
            })
        end
		FeedbackTable[#FeedbackTable+1] = newFeedback
		SendNUIMessage({
			action = "data",
			FeedbackTable = FeedbackTable
		})
	end
end)
RegisterNetEvent('2Dev-SystemAlert:CASESTATUS')
AddEventHandler('2Dev-SystemAlert:CASESTATUS', function(casestatus)
	if ambulance then
        CaseStatus["waiting"] = casestatus.waiting
        CaseStatus["accept"] = casestatus.accept
        CaseStatus["success"] = casestatus.success
        CaseStatus["all"] = casestatus.all
		SendNUIMessage({
			action = "data-case-status",
            waiting = CaseStatus["waiting"],
            accept = CaseStatus["accept"],
			success = CaseStatus["success"],
            all = CaseStatus["all"]
		})
	end
end)

RegisterNetEvent('2Dev-SystemAlert:FetchFeedData')
AddEventHandler('2Dev-SystemAlert:FetchFeedData', function(feedback, acces)
	FeedbackTable = feedback
	ambulance = acces
end)

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    blur = bool
    SendNUIMessage({
        action = "ui",
        status = bool,
    })
end

AddEventHandler('scotty-ambulancealert:alertNet', function(alertname)
     local player = PlayerPedId()
    local coords = GetEntityCoords(player)
    TriggerServerEvent("2Dev-SystemAlert:Add", alertname, coords)
end)