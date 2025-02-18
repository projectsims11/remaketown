ESX = exports['es_extended']:getSharedObject()

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

Fewthz                   = GetCurrentResourceName()
local InAction = false
local isInShopMenu = false
local Test = false

AddEventHandler("Fewthz_core:ClientMemoryGarbage", function()
	Citizen.CreateThread(function()
		Wait(math.random(100, 2000))
		collectgarbage()
	end)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local coord = GetEntityCoords(PlayerPedId())
		local health = GetEntityHealth(PlayerPedId())
		local main = Config.Main.Maincoords
		local sleep = true
		for k ,v in ipairs(Config.Main) do

            if GetDistanceBetweenCoords(coord,v.x,v.y,v.z,true) < 30 then
                sleep = false
				DrawMarker(Config.Marker.Marker.Id, v.x,v.y,v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Marker.Marker.Size.x, Config.Marker.Marker.Size.y, Config.Marker.Marker.Size.z, Config.Marker.Marker.Color.r, Config.Marker.Marker.Color.g, Config.Marker.Marker.Color.b, Config.Marker.Marker.Color.a, false, true, 2, false, false, false, false)
			end

			if GetDistanceBetweenCoords(coord,v.x,v.y,v.z,true) < 2 then
				sleep = false
                    if Config.Text3D then
				        DrawText3Ds(v.x,v.y,v.z + 0.5, v.Text)
                    else
                        exports["Fewthz_TextUI"]:ShowHelpNotification(v.TextUI)
                    end
				if IsControlJustPressed(0, 38) then
                    OpenCloakroomMenu()
				end
			end
		end
		if sleep then
			Citizen.Wait(500)
		end
	end
end)

function OpenCloakroomMenu()
	local playerPed = PlayerPedId()
    local player = GetPlayerServerId(PlayerId())
    local grade = Config.Uniforms.Player
    local health = GetEntityHealth(PlayerPedId())
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
		title    = ('เช็คอินนอนเตียง'),
		align    = 'top-left',
		elements = {
            {label = ("ยืนยันชำระค่านอนเตียง <strong class='blue-text'>"..Config.Money.."</strong> บาท"), uniform = grade},
			{label = ('ยกเลิก'), value = 'No'},
		}
	}, function(data, menu)
        if data.current.value == 'No' then
            exports['okokNotify']:Alert("แจ้งเตือน", "ยกเลิกเรียบร้อยแล้ว", 3000, 'error')
            menu.close()
		end
        if data.current.uniform then
            if exports.Fewthz_Check:CheckAmbulance(Config.Ambulance) then
                exports['okokNotify']:Alert("แจ้งเตือน", Config.Text, 3000, 'error')
            else
                if (health == 200) then
                    exports['okokNotify']:Alert("แจ้งเตือน", "คุณไม่ได้มีอาการบาดเจ็บ", 3000, 'warning')
                else
                    local bought = exports["Fewthz_Check"]:Money()
                    if bought > Config.Money then
                        if NoallowJob(Config.NoallowJob) then
                            exports['okokNotify']:Alert("แจ้งเตือน", "สามารถนอนรักษาตัวได้", 3000, 'success')
                            bedActive()
                            if Config.SocietyAmbulance then
                                if Config.SocietyAccount then
                                    TriggerServerEvent(Fewthz..'buyAccount')
                                else
                                    exports['okokNotify']:Alert("แจ้งเตือน", "ได้รับบิลเรียบร้อย", 3000, 'success')
                                    TriggerServerEvent('esx_billing:sendBill', player, 'society_ambulance', Config.Billname, Config.Money)
                                end
                            else
                                TriggerServerEvent(Fewthz..'buy')
                            end
                            test = false
                            Bed = true
                        else
                            exports['okokNotify']:Alert("แจ้งเตือน", "สามารถนอนรักษาตัวได้", 3000, 'success')
                            setUniform(data.current.uniform, playerPed)
                            bedActive()
                            if Config.SocietyAmbulance then
                                if Config.SocietyAccount then
                                    TriggerServerEvent(Fewthz..'buyAccount')
                                else
                                    exports['okokNotify']:Alert("แจ้งเตือน", "ได้รับบิลเรียบร้อย", 3000, 'success')
                                    TriggerServerEvent('esx_billing:sendBill', player, 'society_ambulance', Config.Billname, Config.Money)
                                end
                            else
                                TriggerServerEvent(Fewthz..'buy')
                            end
                            test = false
                            Bed = true
                        end
                    else
                        exports['okokNotify']:Alert("แจ้งเตือน", '<span style="color:red">ล้มเหลว</span> คุณไม่มีเงิน <span style="color:red">' .. Config.Money ..'</span> บาท', 3000, 'error')
                    end
                end
            end
        end
        menu.close()
    end, function(data, menu)
        menu.close()
    end)
end

function setUniform(uniform, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		local uniformObject
		if skin.sex == 0 then
			uniformObject = Config.Uniforms.Player.male
		else
			uniformObject = Config.Uniforms.Player.female
		end
		if uniformObject then
			TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
		else
			ESX.ShowNotification(('no_outfit'))
		end
	end)
end

function bedActive(x, y, z, heading)

    Citizen.CreateThread(function()
        repeat
            Citizen.Wait(7)  
            local playerPed = PlayerPedId()
            local coords    = GetEntityCoords(playerPed)
            local closestDistance = -1 --
            local closestEntity   = nil --
            local objCoords = nil --
            local modelname = Config.BedList     
            for i=1, #modelname, 1 do
                local object = GetClosestObjectOfType(coords, 2.0, GetHashKey(modelname[i].name), false, false, false)
                if DoesEntityExist(object) then
                    objCoords = GetEntityCoords(object)
                    local distance  = GetDistanceBetweenCoords(coords, objCoords, true)
                    
                    if closestDistance == -1 or closestDistance > distance then
                        closestDistance = distance
                        closestEntity   = object
                    end
                end
            end
            if closestDistance ~= -1 and closestDistance <= 2.0 then
                if not test then
                    exports["Fewthz_TextUI"]:ShowHelpNotification('Press ~INPUT_CONTEXT~ to ~g~Beds')
                end
                if IsControlJustReleased(0, 38) then
                    test = true
                    local closestPlayer, closestDistancePlayer = ESX.Game.GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistancePlayer <= 2.0 then
                        DisplayHelpText("~r~There are patients lying")
                    else
                        local health = GetEntityHealth(playerPed)
                        if health <= 199 then
                            kj(closestEntity)
                        else
                            ESX.ShowNotification("~r~You are not sick Why do you sleep in bed?")
                        end
                    end
                end
            end      
            if Rehealth then
                local ped = PlayerPedId()
                local health = GetEntityHealth(ped)
                if health <= 199 then
                    Citizen.Wait(Config.Time_Heal)
                    SetEntityHealth(ped, health + Config.Hp_Heal)
                    Bed = true
                else
                    Rehealth = false
                    DetachEntity(playerPed, true, false)
                    ClearPedTasksImmediately(playerPed)
                    FreezeEntityPosition(playerPed, false)
                    exports['okokNotify']:Alert("แจ้งเตือน", "<center><strong class='blue-text'>ช่วยเหลือ</strong> คุณรักษาตัวเรียบร้อยแล้ว</strong><center>", 3000, 'success')
                    Citizen.Wait(1000)
                    if NoallowJob(Config.NoallowJob) then
                        Bed = false
                    else
                        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                            TriggerEvent('skinchanger:loadSkin', skin)
                        end)
                        Bed = false
                    end
                end
            end
        until Bed == false --end
    end)
end

function NoallowJob(joblist)
	if #joblist < 1 then
		return true
	end
	local playerJob = ESX.GetPlayerData().job
	for _, job in ipairs(joblist) do
		if job == playerJob.name then
			return true
		end
	end
	return false
end

function DisplayHelpText(text)
    SetTextComponentFormat('STRING')
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function kj(closestEntity)
	local playerPed = GetPlayerPed(-1)
	local dict = "amb@code_human_in_car_idles@low@ps@"
    DisableControlAction(0, 0, true) -- Changing view (V)
    DisableControlAction(0, 22, true) -- Jumping (SPACE)
    DisableControlAction(0, 23, true) -- Entering vehicle (F)
    DisableControlAction(0, 24, true) -- Punching/Attacking
    DisableControlAction(0, 29, true) -- Pointing (B)
    DisableControlAction(0, 30, true) -- Moving sideways (A/D)
    DisableControlAction(0, 31, true) -- Moving back & forth (W/S)
    DisableControlAction(0, 37, true) -- Weapon wheel
    DisableControlAction(0, 44, true) -- Taking Cover (Q)
    DisableControlAction(0, 56, true) -- F9
    DisableControlAction(0, 82, true) -- Mask menu (,)
    DisableControlAction(0, 140, true) -- Hitting your vehicle (R)
    DisableControlAction(0, 166, true) -- F5
    DisableControlAction(0, 167, true) -- F6
    DisableControlAction(0, 168, true) -- F7
    DisableControlAction(0, 170, true) -- F3
    DisableControlAction(0, 288, true) -- F1
    DisableControlAction(0, 289, true) -- F2
    DisableControlAction(1, 323, true) -- Handsup (X)
    LoadAnimationDictionary("amb@world_human_sunbathe@female@back@base")
    TaskPlayAnim(playerPed, "amb@world_human_sunbathe@female@back@base", "base", 8.0, -8, -1, 33, 0, 0, 40, 0)		
    AttachEntityToEntity(playerPed, closestEntity, 9816,0, 0.1, 1.4, 0, 0, 0, false, false, false, false, 2, false)
    FreezeEntityPosition(playerPed, true)
    Rehealth = true
    exports['okokNotify']:Alert("แจ้งเตือน", "คุณกำลังพักฟื้นตัว", 3000, 'success')
end

function LoadAnimationDictionary(animationD)
	while(not HasAnimDictLoaded(animationD)) do
		RequestAnimDict(animationD)
		Citizen.Wait(1)
	end
end

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.4, 0.4)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextDropShadow(1, 0, 0, 0, 255)
	SetTextEntry("STRING")
	SetTextCentre(true)
	AddTextComponentString(text)
	SetDrawOrigin(x,y,z, 0)
	DrawText(0.0, 0.0)
	local factor = (string.len(text)) / 370
	DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
	ClearDrawOrigin()
end