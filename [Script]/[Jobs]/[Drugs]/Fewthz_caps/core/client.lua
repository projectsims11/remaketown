ESX = nil
local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["F"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
freeze = false
cd = false
scriptName = GetCurrentResourceName()

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent(Config["esx_routers"]['getSharedObject'], function(obj) ESX = obj end)
		Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
    Citizen.Wait(10)
    end

    checkjob(ESX.GetPlayerData().job.name)
end)

function checkjob(job)
	--print('job :',job)
	if job =='ambulance' or job =='police' or job =='mechanic' then
		jobstatus = false  
	else
		jobstatus = true
	end
end

function minigame()
    freeze = true    
    if Config["Minigame"] then        
        if exports["k5_skillcheck"]:skillCheck(Config["Dif1"]) then
            Citizen.Wait(1000)
                if exports["k5_skillcheck"]:skillCheck(Config["Dif2"])  then
                Citizen.Wait(1000)
                if exports["k5_skillcheck"]:skillCheck(Config["Dif3"]) then
                    Startsteal()                                                
                else
                    Fail()                                     
                end
            else
                Fail()  
            end
        else
            Fail()  
        end
    else
        Startsteal()   
    end
end

Citizen.CreateThread(function()   
    while true do
		Citizen.Wait(Config["Lt"])
		local playerPed = GetPlayerPed(-1)
		local coords = GetEntityCoords(playerPed)
        local canSleep  = true
		for k, v in pairs(Config["Pos"]) do
			if GetDistanceBetweenCoords(coords, v["x"], v["y"], v["z"], true) < Config["Distance"]  then	
                canSleep = false
                if jobstatus then	
                    if exports.Fewthz_Check:CheckPolice(Config["Cops"]) then
                        if not cd then	                
                            ShowToolTip(Config["Text"], v["x"], v["y"], v["z"] + 0.42)			                    
                            if IsControlJustPressed(0, Keys["E"]) and not IsPedInAnyVehicle(playerPed, true) then                                                                                                                                                                                
                                if Config["Itemreq"] then                               
                                    ESX.TriggerServerCallback(scriptName.. ':checkitem', function(status)
                                        if status then
                                            FreezeEntityPosition(PlayerPedId(), true)                                                   
                                            minigame()                                             
                                        else
                                            exports['mythic_notify']:DoHudText('error', 'คุณไม่มีไอเท็มที่กำหนดไว้')
                                        end
                                    end)
                                else
                                    FreezeEntityPosition(PlayerPedId(), true)     
                                    minigame()                                                                             
                                end	                                                                                                            
                            end
                        else
                            ShowToolTip(Config["Textcantdo2"], v["x"], v["y"], v["z"] + 0.42)	                                     
                        end
                    else
                        ShowToolTip(Config["Textnocop"], v["x"], v["y"], v["z"] + 0.42)	                                                     
                    end
                else
                    ShowToolTip(Config["Textcantdo"], v["x"], v["y"], v["z"] + 0.42)	                             
                end                     
			end                       
		end   
        if canSleep then
            Citizen.Wait(500)
        end           
	end
end)

function Startsteal()
    cd = true     
    freeze = true
    TriggerEvent(scriptName.. ':cd')
	TriggerEvent(Config["Copalert"], Config["Alertname"])
	local PedPosition = GetEntityCoords(PlayerPedId())
	local PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z }
	TriggerServerEvent('esx_addons_gcphone:startCall', 'police', ('มีคนกำลังขโมยแคปซูล'), PlayerCoords, {
		PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z },
	})
    TriggerEvent(Config["Progbar"], {
        name = "unique_action_name",
        duration = Config["Timesteal"],
        label = Config["Textsteal"],
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
            anim = "machinic_loop_mechandplayer",
            flags = 49,
        },   
    },
    function(status)
        if not status then                   
            TriggerServerEvent(scriptName.. ':getitem')
			TaskLeaveVehicle(player, GetVehiclePedIsIn(player, false), 1)
            ClearPedTasks(player)			           
			FreezeEntityPosition(PlayerPedId(), false)                                                    
            freeze = false                            
        end              
    end)    
end

function Fail() 
    if Config["Failcd"] then 
        cd = true     
        freeze = true
        fails()
    else
        cd = false
        fails()
    end
end

function fails()
    TriggerEvent(scriptName.. ':cd')
    TriggerEvent(Config["Copalert"], Config["Alertname"])
	local PedPosition = GetEntityCoords(PlayerPedId())
	local PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z }
	TriggerServerEvent('esx_addons_gcphone:startCall', 'police', ('มีคนกำลังขโมยCapsule'), PlayerCoords, {
		PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z },
	})
    TriggerEvent(Config["Progbar"], {
        name = "unique_action_name",
        duration = Config["Timefreeze"],
        label = Config["Textfreeze"],
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "random@prisoner_lift",
            anim = "loop2_idlelook2",            
        },   
    },
    function(status)
        if not status then                      
            ClearPedTasks(player)			           
		    FreezeEntityPosition(PlayerPedId(), false)      
            freeze = false      
        end       
    end)    
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(35)       
		if freeze then
			DisableControlAction(0, 24, true)    
            
            DisableControlAction(0, Keys["F"], true)    
            DisableControlAction(0, Keys["F1"], true)    
            DisableControlAction(0, Keys["F2"], true)    
            DisableControlAction(0, Keys["ENTER"], true)  
            DisableControlAction(0, Keys["T"], true)                 
		else
			Citizen.Wait(1000)
		end
	end
end)

AddEventHandler(scriptName.. ':cd', function()
    if cd then
        countDown(Config["Cooldown"])   
    end 
end)

function countDown(timeInSecond)
    Citizen.CreateThread(function()    
        local time = timeInSecond
       -- print("Countdown: "..time) 
        while(time > 0) do
            Citizen.Wait(1000)
            time = time - 1
 
            if(time <= 0)then    
                print("Capsule is now available")         
                cd = false
            else               
             --   print("Countdown: "..time)
            end
 
        end
        
    end)
end

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)	
	checkjob(job.name)
end)

function DrawText3D(x, y, z, text, scale)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
 
    SetTextScale(scale, scale)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextColour(255, 255, 255, 215)
 
    AddTextComponentString(text)
    DrawText(_x, _y)
 
    local factor = (string.len(text)) / 1200   
end

ShowToolTip = function (msg, x,y,z)
    AddTextEntry('Fewthz_caps', msg)
    SetFloatingHelpTextWorldPosition(1, x,y,z)
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
    BeginTextCommandDisplayHelp('Fewthz_caps')
    EndTextCommandDisplayHelp(2, false, false, -1)
end