local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

ESX                           = nil
local PlayerData              = {}
local dutyjobsinfo            = {}
local offdutyjobsinfo         = {}
local OnDutyJobsList          = {}
local OffDutyJobsList         = {}
local cop,ems,mc = 0,0,0

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

ShowHelpNotification = function(msg)
    SetTextComponentFormat("DUTYSTRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
	  EndTextCommandDisplayHelp(0, 0, 1, -1)
end

ShowFloatingHelpNotification = function(msg, coords)
	AddTextEntry('DUTYSTRING', msg)
	SetFloatingHelpTextWorldPosition(1, coords)
	SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
	BeginTextCommandDisplayHelp('DUTYSTRING')
	EndTextCommandDisplayHelp(2, false, false, -1)
end

DrawText3D = function(coords, text, size, font)
	coords = vector3(coords.x, coords.y, coords.z)

	local camCoords = GetGameplayCamCoords()
	local distance = #(coords - camCoords)

	if not size then size = 1 end
	if not font then font = 0 end

	local scale = (size / distance) * 2
	local fov = (1 / GetGameplayCamFov()) * 100
	scale = scale * fov

	SetTextScale(0.0 * scale, 0.55 * scale)
	SetTextFont(font)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)

	SetDrawOrigin(coords, 0)
	BeginTextCommandDisplayText('DUTYSTRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(0.0, 0.0)
	ClearDrawOrigin()
end

Citizen.CreateThread(function()
	for k,v in pairs(Config.Zones) do
		if not dutyjobsinfo[v.job] then OnDutyJobsList[#OnDutyJobsList+1] = v.job end
		if not offdutyjobsinfo[v.offjob] then OffDutyJobsList[#OffDutyJobsList+1] = v.offjob end
		dutyjobsinfo[v.job] = v.offjob
		offdutyjobsinfo[v.offjob] = v.job
	end
    while true do
        local Sleep = 1000
        if ESX and PlayerData.job then
			local playerjob = PlayerData.job.name
			if dutyjobsinfo[playerjob] or offdutyjobsinfo[playerjob] then
				for k,v in pairs(Config.Zones) do
					if playerjob == v.job or playerjob == v.offjob then
						local coords = GetEntityCoords(GetPlayerPed(-1))
						local dist = 999.0
						if Config.DistanceMethod == 'Vdist' then
							dist = Vdist(coords, v.Pos.x, v.Pos.y, v.Pos.z)
						else
							dist = #(coords - vector3(v.Pos.x, v.Pos.y, v.Pos.z))
						end
						if(dist <= Config.DrawDistance)then
							Sleep = 5
							local r,g,b = 255,0,0
							local duty = _U('duty1')
							if playerjob == v.offjob then duty = _U('duty2') r,g,b = 0,255,0 end
							DrawMarker(6, v.Pos.x, v.Pos.y, v.Pos.z - 0.975, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, r,g,b, 100, false, true, 2, false, false, false, false)
							if(dist <= v.Size.x)then
								if Config.HelpText == '3DText' then
									DrawText3D(vector3(v.Pos.x, v.Pos.y, v.Pos.z),duty,0.75)
								elseif Config.HelpText == 'Floating' then
									ShowFloatingHelpNotification(duty,vector3(v.Pos.x, v.Pos.y, v.Pos.z))
								else
									ShowHelpNotification(duty)
								end

								if IsControlJustPressed(0, Keys['E']) then
									TriggerServerEvent('esx_duty:toggleduty')
                  Wait(2000)
								end
							end
							if Config.JustCanSeeOne then
								break
							end
						end
					end
				end
			else
				Sleep = 2000
			end
        else
            Sleep = 3000
        end
        Wait(Sleep)
    end
end)

---------------ambulance 0
RegisterNetEvent('Fewthz:ambulancecloth0')
AddEventHandler('Fewthz:ambulancecloth0', function()
  TriggerEvent('skinchanger:getSkin', function(skin)
    local playerPed = PlayerPedId()
    local lib, anim = 'mp_safehouseshower@male@', 'male_shower_towel_dry_to_get_dressed' 
    ESX.Streaming.RequestAnimDict(lib, function()
      local co = GetEntityCoords(playerPed)
      local he = GetEntityHeading(playerPed)

      TaskPlayAnimAdvanced(playerPed, lib, anim, co.x, co.y, co.z, 0, 0, he, 8.0, 1.0, -1, 0, 0.5, 0, 0)
      exports['mythic_progbar']:Progress( {
	
        name = "unique_action_name",
        duration = 2.0 * 1000,
        label = "กำลังเปลี่ยนชุด..",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        },
           
      }, function(status)
        if not status then
          -- Do Something If Event Wasn't Cancelled
        end
      end)
      Citizen.Wait(2000)
      PlaySoundFrontend(-1, "Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
      ClearPedTasks(playerPed)
      if skin.sex == 0 then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_ambulance['Grade0'].male)
      else
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_ambulance['Grade0'].female)
      end
    end)

	end)
  ems = ems + 1
end)

---------------ambulance 1
RegisterNetEvent('Fewthz:ambulancecloth1')
AddEventHandler('Fewthz:ambulancecloth1', function()
  TriggerEvent('skinchanger:getSkin', function(skin)
    local playerPed = PlayerPedId()
    local lib, anim = 'mp_safehouseshower@male@', 'male_shower_towel_dry_to_get_dressed' 
    ESX.Streaming.RequestAnimDict(lib, function()
      local co = GetEntityCoords(playerPed)
      local he = GetEntityHeading(playerPed)

      TaskPlayAnimAdvanced(playerPed, lib, anim, co.x, co.y, co.z, 0, 0, he, 8.0, 1.0, -1, 0, 0.5, 0, 0)
      exports['mythic_progbar']:Progress( {
	
        name = "unique_action_name",
        duration = 2.0 * 1000,
        label = "กำลังเปลี่ยนชุด..",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        },
           
      }, function(status)
        if not status then
          -- Do Something If Event Wasn't Cancelled
        end
      end)
      Citizen.Wait(2000)
      PlaySoundFrontend(-1, "Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
      ClearPedTasks(playerPed)
      if skin.sex == 0 then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_ambulance['Grade1'].male)
      else
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_ambulance['Grade1'].female)
      end
    end)
  end)
  ems = ems + 1
end)

---------------ambulance 2
RegisterNetEvent('Fewthz:ambulancecloth2')
AddEventHandler('Fewthz:ambulancecloth2', function()
  TriggerEvent('skinchanger:getSkin', function(skin)
    local playerPed = PlayerPedId()
    local lib, anim = 'mp_safehouseshower@male@', 'male_shower_towel_dry_to_get_dressed' 
    ESX.Streaming.RequestAnimDict(lib, function()
      local co = GetEntityCoords(playerPed)
      local he = GetEntityHeading(playerPed)

      TaskPlayAnimAdvanced(playerPed, lib, anim, co.x, co.y, co.z, 0, 0, he, 8.0, 1.0, -1, 0, 0.5, 0, 0)
      exports['mythic_progbar']:Progress( {
	
        name = "unique_action_name",
        duration = 2.0 * 1000,
        label = "กำลังเปลี่ยนชุด..",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        },
           
      }, function(status)
        if not status then
          -- Do Something If Event Wasn't Cancelled
        end
      end)
      Citizen.Wait(2000)
      PlaySoundFrontend(-1, "Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
      ClearPedTasks(playerPed)
      if skin.sex == 0 then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_ambulance['Grade2'].male)
      else
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_ambulance['Grade2'].female)
      end
    end)
	end)
  ems = ems + 1
end)

---------------ambulance 3
RegisterNetEvent('Fewthz:ambulancecloth3')
AddEventHandler('Fewthz:ambulancecloth3', function()
  TriggerEvent('skinchanger:getSkin', function(skin)
    local playerPed = PlayerPedId()
    local lib, anim = 'mp_safehouseshower@male@', 'male_shower_towel_dry_to_get_dressed' 
    ESX.Streaming.RequestAnimDict(lib, function()
      local co = GetEntityCoords(playerPed)
      local he = GetEntityHeading(playerPed)

      TaskPlayAnimAdvanced(playerPed, lib, anim, co.x, co.y, co.z, 0, 0, he, 8.0, 1.0, -1, 0, 0.5, 0, 0)
      exports['mythic_progbar']:Progress( {
	
        name = "unique_action_name",
        duration = 2.0 * 1000,
        label = "กำลังเปลี่ยนชุด..",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        },
           
      }, function(status)
        if not status then
          -- Do Something If Event Wasn't Cancelled
        end
      end)
      Citizen.Wait(2000)
      PlaySoundFrontend(-1, "Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
      ClearPedTasks(playerPed)
      if skin.sex == 0 then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_ambulance['Grade3'].male)
      else
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_ambulance['Grade3'].female)
      end
    end)
	end)
  ems = ems + 1
end)
--------ambulance4
RegisterNetEvent('Fewthz:ambulancecloth4')
AddEventHandler('Fewthz:ambulancecloth4', function()
  TriggerEvent('skinchanger:getSkin', function(skin)
    local playerPed = PlayerPedId()
    local lib, anim = 'mp_safehouseshower@male@', 'male_shower_towel_dry_to_get_dressed' 
    ESX.Streaming.RequestAnimDict(lib, function()
      local co = GetEntityCoords(playerPed)
      local he = GetEntityHeading(playerPed)

      TaskPlayAnimAdvanced(playerPed, lib, anim, co.x, co.y, co.z, 0, 0, he, 8.0, 1.0, -1, 0, 0.5, 0, 0)
      exports['mythic_progbar']:Progress( {
	
        name = "unique_action_name",
        duration = 2.0 * 1000,
        label = "กำลังเปลี่ยนชุด..",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        },
           
      }, function(status)
        if not status then
          -- Do Something If Event Wasn't Cancelled
        end
      end)
      Citizen.Wait(2000)
      PlaySoundFrontend(-1, "Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
      ClearPedTasks(playerPed)
      if skin.sex == 0 then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_ambulance['Grade4'].male)
      else
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_ambulance['Grade4'].female)
      end
    end)
	end)
  ems = ems + 1
end)
--------ambulance5
RegisterNetEvent('Fewthz:ambulancecloth5')
AddEventHandler('Fewthz:ambulancecloth5', function()
  TriggerEvent('skinchanger:getSkin', function(skin)
    local playerPed = PlayerPedId()
    local lib, anim = 'mp_safehouseshower@male@', 'male_shower_towel_dry_to_get_dressed' 
    ESX.Streaming.RequestAnimDict(lib, function()
      local co = GetEntityCoords(playerPed)
      local he = GetEntityHeading(playerPed)

      TaskPlayAnimAdvanced(playerPed, lib, anim, co.x, co.y, co.z, 0, 0, he, 8.0, 1.0, -1, 0, 0.5, 0, 0)
      exports['mythic_progbar']:Progress( {
	
        name = "unique_action_name",
        duration = 2.0 * 1000,
        label = "กำลังเปลี่ยนชุด..",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        },
           
      }, function(status)
        if not status then
          -- Do Something If Event Wasn't Cancelled
        end
      end)
      Citizen.Wait(2000)
      PlaySoundFrontend(-1, "Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
      ClearPedTasks(playerPed)
      if skin.sex == 0 then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_ambulance['Grade5'].male)
      else
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_ambulance['Grade5'].female)
      end
    end)
	end)
  ems = ems + 1
end)
--------ambulance6
RegisterNetEvent('Fewthz:ambulancecloth6')
AddEventHandler('Fewthz:ambulancecloth6', function()
  TriggerEvent('skinchanger:getSkin', function(skin)
    local playerPed = PlayerPedId()
    local lib, anim = 'mp_safehouseshower@male@', 'male_shower_towel_dry_to_get_dressed' 
    ESX.Streaming.RequestAnimDict(lib, function()
      local co = GetEntityCoords(playerPed)
      local he = GetEntityHeading(playerPed)

      TaskPlayAnimAdvanced(playerPed, lib, anim, co.x, co.y, co.z, 0, 0, he, 8.0, 1.0, -1, 0, 0.5, 0, 0)
      exports['mythic_progbar']:Progress( {
	
        name = "unique_action_name",
        duration = 2.0 * 1000,
        label = "กำลังเปลี่ยนชุด..",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        },
           
      }, function(status)
        if not status then
          -- Do Something If Event Wasn't Cancelled
        end
      end)
      Citizen.Wait(2000)
      PlaySoundFrontend(-1, "Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
      ClearPedTasks(playerPed)
      if skin.sex == 0 then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_ambulance['Grade6'].male)
      else
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_ambulance['Grade6'].female)
      end
    end)
	end)
end)
--------ambulance7
RegisterNetEvent('Fewthz:ambulancecloth7')
AddEventHandler('Fewthz:ambulancecloth7', function()
  TriggerEvent('skinchanger:getSkin', function(skin)
    local playerPed = PlayerPedId()
    local lib, anim = 'mp_safehouseshower@male@', 'male_shower_towel_dry_to_get_dressed' 
    ESX.Streaming.RequestAnimDict(lib, function()
      local co = GetEntityCoords(playerPed)
      local he = GetEntityHeading(playerPed)

      TaskPlayAnimAdvanced(playerPed, lib, anim, co.x, co.y, co.z, 0, 0, he, 8.0, 1.0, -1, 0, 0.5, 0, 0)
      exports['mythic_progbar']:Progress( {
	
        name = "unique_action_name",
        duration = 2.0 * 1000,
        label = "กำลังเปลี่ยนชุด..",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        },
           
      }, function(status)
        if not status then
          -- Do Something If Event Wasn't Cancelled
        end
      end)
      Citizen.Wait(2000)
      PlaySoundFrontend(-1, "Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
      ClearPedTasks(playerPed)
      if skin.sex == 0 then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_ambulance['Grade7'].male)
      else
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_ambulance['Grade7'].female)
      end
    end)
	end)
  ems = ems + 1
end)
---------------police 0
RegisterNetEvent('Fewthz:policecloth0')
AddEventHandler('Fewthz:policecloth0', function()
  TriggerEvent('skinchanger:getSkin', function(skin)
    local playerPed = PlayerPedId()
    local lib, anim = 'mp_safehouseshower@male@', 'male_shower_towel_dry_to_get_dressed' 
    ESX.Streaming.RequestAnimDict(lib, function()
      local co = GetEntityCoords(playerPed)
      local he = GetEntityHeading(playerPed)

      TaskPlayAnimAdvanced(playerPed, lib, anim, co.x, co.y, co.z, 0, 0, he, 8.0, 1.0, -1, 0, 0.5, 0, 0)
      exports['mythic_progbar']:Progress( {
	
        name = "unique_action_name",
        duration = 2.0 * 1000,
        label = "กำลังเปลี่ยนชุด..",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        },
           
      }, function(status)
        if not status then
          -- Do Something If Event Wasn't Cancelled
        end
      end)
      Citizen.Wait(2000)
      PlaySoundFrontend(-1, "Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
      ClearPedTasks(playerPed)
      if skin.sex == 0 then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_police['Grade0'].male)
      else
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_police['Grade0'].female)
      end
    end)
	end)
  cop = cop + 1
end)

---------------police 1
RegisterNetEvent('Fewthz:policecloth1')
AddEventHandler('Fewthz:policecloth1', function()
  TriggerEvent('skinchanger:getSkin', function(skin)
    local playerPed = PlayerPedId()
    local lib, anim = 'mp_safehouseshower@male@', 'male_shower_towel_dry_to_get_dressed' 
    ESX.Streaming.RequestAnimDict(lib, function()
      local co = GetEntityCoords(playerPed)
      local he = GetEntityHeading(playerPed)

      TaskPlayAnimAdvanced(playerPed, lib, anim, co.x, co.y, co.z, 0, 0, he, 8.0, 1.0, -1, 0, 0.5, 0, 0)
      exports['mythic_progbar']:Progress( {
	
        name = "unique_action_name",
        duration = 2.0 * 1000,
        label = "กำลังเปลี่ยนชุด..",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        },
           
      }, function(status)
        if not status then
          -- Do Something If Event Wasn't Cancelled
        end
      end)
      Citizen.Wait(2000)
      PlaySoundFrontend(-1, "Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
      ClearPedTasks(playerPed)
      if skin.sex == 0 then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_police['Grade1'].male)
      else
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_police['Grade1'].female)
      end
    end)
	end)
  cop = cop + 1
end)

---------------police 2
RegisterNetEvent('Fewthz:policecloth2')
AddEventHandler('Fewthz:policecloth2', function()
  TriggerEvent('skinchanger:getSkin', function(skin)
    local playerPed = PlayerPedId()
    local lib, anim = 'mp_safehouseshower@male@', 'male_shower_towel_dry_to_get_dressed' 
    ESX.Streaming.RequestAnimDict(lib, function()
      local co = GetEntityCoords(playerPed)
      local he = GetEntityHeading(playerPed)

      TaskPlayAnimAdvanced(playerPed, lib, anim, co.x, co.y, co.z, 0, 0, he, 8.0, 1.0, -1, 0, 0.5, 0, 0)
      exports['mythic_progbar']:Progress( {
	
        name = "unique_action_name",
        duration = 2.0 * 1000,
        label = "กำลังเปลี่ยนชุด..",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        },
           
      }, function(status)
        if not status then
          -- Do Something If Event Wasn't Cancelled
        end
      end)
      Citizen.Wait(2000)
      PlaySoundFrontend(-1, "Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
      ClearPedTasks(playerPed)
      if skin.sex == 0 then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_police['Grade2'].male)
      else
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_police['Grade2'].female)
      end
    end)
	end)
  cop = cop + 1
end)

---------------police 3
RegisterNetEvent('Fewthz:policecloth3')
AddEventHandler('Fewthz:policecloth3', function()
  TriggerEvent('skinchanger:getSkin', function(skin)
    local playerPed = PlayerPedId()
    local lib, anim = 'mp_safehouseshower@male@', 'male_shower_towel_dry_to_get_dressed' 
    ESX.Streaming.RequestAnimDict(lib, function()
      local co = GetEntityCoords(playerPed)
      local he = GetEntityHeading(playerPed)

      TaskPlayAnimAdvanced(playerPed, lib, anim, co.x, co.y, co.z, 0, 0, he, 8.0, 1.0, -1, 0, 0.5, 0, 0)
      exports['mythic_progbar']:Progress( {
	
        name = "unique_action_name",
        duration = 2.0 * 1000,
        label = "กำลังเปลี่ยนชุด..",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        },
           
      }, function(status)
        if not status then
          -- Do Something If Event Wasn't Cancelled
        end
      end)
      Citizen.Wait(2000)
      PlaySoundFrontend(-1, "Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
      ClearPedTasks(playerPed)
      if skin.sex == 0 then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_police['Grade3'].male)
      else
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_police['Grade3'].female)
      end
    end)
	end)
  cop = cop + 1
end)

---------------police 4
RegisterNetEvent('Fewthz:policecloth4')
AddEventHandler('Fewthz:policecloth4', function()
  TriggerEvent('skinchanger:getSkin', function(skin)
    local playerPed = PlayerPedId()
    local lib, anim = 'mp_safehouseshower@male@', 'male_shower_towel_dry_to_get_dressed' 
    ESX.Streaming.RequestAnimDict(lib, function()
      local co = GetEntityCoords(playerPed)
      local he = GetEntityHeading(playerPed)

      TaskPlayAnimAdvanced(playerPed, lib, anim, co.x, co.y, co.z, 0, 0, he, 8.0, 1.0, -1, 0, 0.5, 0, 0)
      exports['mythic_progbar']:Progress( {
	
        name = "unique_action_name",
        duration = 2.0 * 1000,
        label = "กำลังเปลี่ยนชุด..",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        },
           
      }, function(status)
        if not status then
          -- Do Something If Event Wasn't Cancelled
        end
      end)
      Citizen.Wait(2000)
      PlaySoundFrontend(-1, "Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
      ClearPedTasks(playerPed)
      if skin.sex == 0 then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_police['Grade4'].male)
      else
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_police['Grade4'].female)
      end
    end)
	end)
  cop = cop + 1
end)

---------------police 5
RegisterNetEvent('Fewthz:policecloth5')
AddEventHandler('Fewthz:policecloth5', function()
  TriggerEvent('skinchanger:getSkin', function(skin)
    local playerPed = PlayerPedId()
    local lib, anim = 'mp_safehouseshower@male@', 'male_shower_towel_dry_to_get_dressed' 
    ESX.Streaming.RequestAnimDict(lib, function()
      local co = GetEntityCoords(playerPed)
      local he = GetEntityHeading(playerPed)

      TaskPlayAnimAdvanced(playerPed, lib, anim, co.x, co.y, co.z, 0, 0, he, 8.0, 1.0, -1, 0, 0.5, 0, 0)
      exports['mythic_progbar']:Progress( {
	
        name = "unique_action_name",
        duration = 2.0 * 1000,
        label = "กำลังเปลี่ยนชุด..",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        },
           
      }, function(status)
        if not status then
          -- Do Something If Event Wasn't Cancelled
        end
      end)
      Citizen.Wait(2000)
      PlaySoundFrontend(-1, "Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
      ClearPedTasks(playerPed)
      if skin.sex == 0 then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_police['Grade5'].male)
      else
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_police['Grade5'].female)
      end
    end)
	end)
  cop = cop + 1
end)

---------------police 6
RegisterNetEvent('Fewthz:policecloth6')
AddEventHandler('Fewthz:policecloth6', function()
  TriggerEvent('skinchanger:getSkin', function(skin)
    local playerPed = PlayerPedId()
    local lib, anim = 'mp_safehouseshower@male@', 'male_shower_towel_dry_to_get_dressed' 
    ESX.Streaming.RequestAnimDict(lib, function()
      local co = GetEntityCoords(playerPed)
      local he = GetEntityHeading(playerPed)

      TaskPlayAnimAdvanced(playerPed, lib, anim, co.x, co.y, co.z, 0, 0, he, 8.0, 1.0, -1, 0, 0.5, 0, 0)
      exports['mythic_progbar']:Progress( {
	
        name = "unique_action_name",
        duration = 2.0 * 1000,
        label = "กำลังเปลี่ยนชุด..",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        },
           
      }, function(status)
        if not status then
          -- Do Something If Event Wasn't Cancelled
        end
      end)
      Citizen.Wait(2000)
      PlaySoundFrontend(-1, "Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
      ClearPedTasks(playerPed)
      if skin.sex == 0 then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_police['Grade6'].male)
      else
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_police['Grade6'].female)
      end
    end)
	end)
  cop = cop + 1
end)

---------------police 7
RegisterNetEvent('Fewthz:policecloth7')
AddEventHandler('Fewthz:policecloth7', function()
  TriggerEvent('skinchanger:getSkin', function(skin)
    local playerPed = PlayerPedId()
    local lib, anim = 'mp_safehouseshower@male@', 'male_shower_towel_dry_to_get_dressed' 
    ESX.Streaming.RequestAnimDict(lib, function()
      local co = GetEntityCoords(playerPed)
      local he = GetEntityHeading(playerPed)

      TaskPlayAnimAdvanced(playerPed, lib, anim, co.x, co.y, co.z, 0, 0, he, 8.0, 1.0, -1, 0, 0.5, 0, 0)
      exports['mythic_progbar']:Progress( {
	
        name = "unique_action_name",
        duration = 2.0 * 1000,
        label = "กำลังเปลี่ยนชุด..",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        },
           
      }, function(status)
        if not status then
          -- Do Something If Event Wasn't Cancelled
        end
      end)
      Citizen.Wait(2000)
      PlaySoundFrontend(-1, "Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
      ClearPedTasks(playerPed)
      if skin.sex == 0 then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_police['Grade7'].male)
      else
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_police['Grade7'].female)
      end
    end)
	end)
  cop = cop + 1
end)
---------------police 8
RegisterNetEvent('Fewthz:policecloth8')
AddEventHandler('Fewthz:policecloth8', function()
  TriggerEvent('skinchanger:getSkin', function(skin)
    local playerPed = PlayerPedId()
    local lib, anim = 'mp_safehouseshower@male@', 'male_shower_towel_dry_to_get_dressed' 
    ESX.Streaming.RequestAnimDict(lib, function()
      local co = GetEntityCoords(playerPed)
      local he = GetEntityHeading(playerPed)

      TaskPlayAnimAdvanced(playerPed, lib, anim, co.x, co.y, co.z, 0, 0, he, 8.0, 1.0, -1, 0, 0.5, 0, 0)
      exports['mythic_progbar']:Progress( {
	
        name = "unique_action_name",
        duration = 2.0 * 1000,
        label = "กำลังเปลี่ยนชุด..",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        },
           
      }, function(status)
        if not status then
          -- Do Something If Event Wasn't Cancelled
        end
      end)
      Citizen.Wait(2000)
      PlaySoundFrontend(-1, "Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
      ClearPedTasks(playerPed)
      if skin.sex == 0 then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_police['Grade8'].male)
      else
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_police['Grade8'].female)
      end
    end)
	end)
  cop = cop + 1
end)
---------------police 9
RegisterNetEvent('Fewthz:policecloth9')
AddEventHandler('Fewthz:policecloth9', function()
  TriggerEvent('skinchanger:getSkin', function(skin)
    local playerPed = PlayerPedId()
    local lib, anim = 'mp_safehouseshower@male@', 'male_shower_towel_dry_to_get_dressed' 
    ESX.Streaming.RequestAnimDict(lib, function()
      local co = GetEntityCoords(playerPed)
      local he = GetEntityHeading(playerPed)

      TaskPlayAnimAdvanced(playerPed, lib, anim, co.x, co.y, co.z, 0, 0, he, 8.0, 1.0, -1, 0, 0.5, 0, 0)
      exports['mythic_progbar']:Progress( {
	
        name = "unique_action_name",
        duration = 2.0 * 1000,
        label = "กำลังเปลี่ยนชุด..",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        },
           
      }, function(status)
        if not status then
          -- Do Something If Event Wasn't Cancelled
        end
      end)
      Citizen.Wait(2000)
      PlaySoundFrontend(-1, "Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
      ClearPedTasks(playerPed)
      if skin.sex == 0 then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_police['Grade9'].male)
      else
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_police['Grade9'].female)
      end
    end)
	end)
  cop = cop + 1
end)
---------------police 10
RegisterNetEvent('Fewthz:policecloth10')
AddEventHandler('Fewthz:policecloth10', function()
  TriggerEvent('skinchanger:getSkin', function(skin)
    local playerPed = PlayerPedId()
    local lib, anim = 'mp_safehouseshower@male@', 'male_shower_towel_dry_to_get_dressed' 
    ESX.Streaming.RequestAnimDict(lib, function()
      local co = GetEntityCoords(playerPed)
      local he = GetEntityHeading(playerPed)

      TaskPlayAnimAdvanced(playerPed, lib, anim, co.x, co.y, co.z, 0, 0, he, 8.0, 1.0, -1, 0, 0.5, 0, 0)
      exports['mythic_progbar']:Progress( {
	
        name = "unique_action_name",
        duration = 2.0 * 1000,
        label = "กำลังเปลี่ยนชุด..",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        },
           
      }, function(status)
        if not status then
          -- Do Something If Event Wasn't Cancelled
        end
      end)
      Citizen.Wait(2000)
      PlaySoundFrontend(-1, "Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
      ClearPedTasks(playerPed)
      if skin.sex == 0 then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_police['Grade10'].male)
      else
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_police['Grade10'].female)
      end
    end)
	end)
  cop = cop + 1
end)
---------------police 11
RegisterNetEvent('Fewthz:policecloth11')
AddEventHandler('Fewthz:policecloth11', function()
  TriggerEvent('skinchanger:getSkin', function(skin)
    local playerPed = PlayerPedId()
    local lib, anim = 'mp_safehouseshower@male@', 'male_shower_towel_dry_to_get_dressed' 
    ESX.Streaming.RequestAnimDict(lib, function()
      local co = GetEntityCoords(playerPed)
      local he = GetEntityHeading(playerPed)

      TaskPlayAnimAdvanced(playerPed, lib, anim, co.x, co.y, co.z, 0, 0, he, 8.0, 1.0, -1, 0, 0.5, 0, 0)
      exports['mythic_progbar']:Progress( {
	
        name = "unique_action_name",
        duration = 2.0 * 1000,
        label = "กำลังเปลี่ยนชุด..",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        },
           
      }, function(status)
        if not status then
          -- Do Something If Event Wasn't Cancelled
        end
      end)
      Citizen.Wait(2000)
      PlaySoundFrontend(-1, "Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
      ClearPedTasks(playerPed)
      if skin.sex == 0 then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_police['Grade11'].male)
      else
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_police['Grade11'].female)
      end
    end)
	end)
  cop = cop + 1
end)
---------------police 12
RegisterNetEvent('Fewthz:policecloth12')
AddEventHandler('Fewthz:policecloth12', function()
  TriggerEvent('skinchanger:getSkin', function(skin)
    local playerPed = PlayerPedId()
    local lib, anim = 'mp_safehouseshower@male@', 'male_shower_towel_dry_to_get_dressed' 
    ESX.Streaming.RequestAnimDict(lib, function()
      local co = GetEntityCoords(playerPed)
      local he = GetEntityHeading(playerPed)

      TaskPlayAnimAdvanced(playerPed, lib, anim, co.x, co.y, co.z, 0, 0, he, 8.0, 1.0, -1, 0, 0.5, 0, 0)
      exports['mythic_progbar']:Progress( {
	
        name = "unique_action_name",
        duration = 2.0 * 1000,
        label = "กำลังเปลี่ยนชุด..",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        },
           
      }, function(status)
        if not status then
          -- Do Something If Event Wasn't Cancelled
        end
      end)
      Citizen.Wait(2000)
      PlaySoundFrontend(-1, "Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
      ClearPedTasks(playerPed)
      if skin.sex == 0 then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_police['Grade12'].male)
      else
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_police['Grade12'].female)
      end
    end)
	end)
  cop = cop + 1
end)
---------------police 13
RegisterNetEvent('Fewthz:policecloth13')
AddEventHandler('Fewthz:policecloth13', function()
  TriggerEvent('skinchanger:getSkin', function(skin)
    local playerPed = PlayerPedId()
    local lib, anim = 'mp_safehouseshower@male@', 'male_shower_towel_dry_to_get_dressed' 
    ESX.Streaming.RequestAnimDict(lib, function()
      local co = GetEntityCoords(playerPed)
      local he = GetEntityHeading(playerPed)

      TaskPlayAnimAdvanced(playerPed, lib, anim, co.x, co.y, co.z, 0, 0, he, 8.0, 1.0, -1, 0, 0.5, 0, 0)
      exports['mythic_progbar']:Progress( {
	
        name = "unique_action_name",
        duration = 2.0 * 1000,
        label = "กำลังเปลี่ยนชุด..",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        },
           
      }, function(status)
        if not status then
          -- Do Something If Event Wasn't Cancelled
        end
      end)
      Citizen.Wait(2000)
      PlaySoundFrontend(-1, "Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
      ClearPedTasks(playerPed)
      if skin.sex == 0 then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_police['Grade13'].male)
      else
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_police['Grade13'].female)
      end
    end)
	end)
  cop = cop + 1
end)
---------------police 14
RegisterNetEvent('Fewthz:policecloth14')
AddEventHandler('Fewthz:policecloth14', function()
  TriggerEvent('skinchanger:getSkin', function(skin)
    local playerPed = PlayerPedId()
    local lib, anim = 'mp_safehouseshower@male@', 'male_shower_towel_dry_to_get_dressed' 
    ESX.Streaming.RequestAnimDict(lib, function()
      local co = GetEntityCoords(playerPed)
      local he = GetEntityHeading(playerPed)

      TaskPlayAnimAdvanced(playerPed, lib, anim, co.x, co.y, co.z, 0, 0, he, 8.0, 1.0, -1, 0, 0.5, 0, 0)
      exports['mythic_progbar']:Progress( {
	
        name = "unique_action_name",
        duration = 2.0 * 1000,
        label = "กำลังเปลี่ยนชุด..",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        },
           
      }, function(status)
        if not status then
          -- Do Something If Event Wasn't Cancelled
        end
      end)
      Citizen.Wait(2000)
      PlaySoundFrontend(-1, "Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
      ClearPedTasks(playerPed)
      if skin.sex == 0 then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_police['Grade14'].male)
      else
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_police['Grade14'].female)
      end
    end)
	end)
  cop = cop + 1
end)
---------------police 15
RegisterNetEvent('Fewthz:policecloth15')
AddEventHandler('Fewthz:policecloth15', function()
  TriggerEvent('skinchanger:getSkin', function(skin)
    local playerPed = PlayerPedId()
    local lib, anim = 'mp_safehouseshower@male@', 'male_shower_towel_dry_to_get_dressed' 
    ESX.Streaming.RequestAnimDict(lib, function()
      local co = GetEntityCoords(playerPed)
      local he = GetEntityHeading(playerPed)

      TaskPlayAnimAdvanced(playerPed, lib, anim, co.x, co.y, co.z, 0, 0, he, 8.0, 1.0, -1, 0, 0.5, 0, 0)
      exports['mythic_progbar']:Progress( {
	
        name = "unique_action_name",
        duration = 2.0 * 1000,
        label = "กำลังเปลี่ยนชุด..",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        },
           
      }, function(status)
        if not status then
          -- Do Something If Event Wasn't Cancelled
        end
      end)
      Citizen.Wait(2000)
      PlaySoundFrontend(-1, "Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
      ClearPedTasks(playerPed)
      if skin.sex == 0 then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_police['Grade15'].male)
      else
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_police['Grade15'].female)
      end
    end)
	end)
  cop = cop + 1
end)
---------------police 16
RegisterNetEvent('Fewthz:policecloth16')
AddEventHandler('Fewthz:policecloth16', function()
  TriggerEvent('skinchanger:getSkin', function(skin)
    local playerPed = PlayerPedId()
    local lib, anim = 'mp_safehouseshower@male@', 'male_shower_towel_dry_to_get_dressed' 
    ESX.Streaming.RequestAnimDict(lib, function()
      local co = GetEntityCoords(playerPed)
      local he = GetEntityHeading(playerPed)

      TaskPlayAnimAdvanced(playerPed, lib, anim, co.x, co.y, co.z, 0, 0, he, 8.0, 1.0, -1, 0, 0.5, 0, 0)
      exports['mythic_progbar']:Progress( {
	
        name = "unique_action_name",
        duration = 2.0 * 1000,
        label = "กำลังเปลี่ยนชุด..",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        },
           
      }, function(status)
        if not status then
          -- Do Something If Event Wasn't Cancelled
        end
      end)
      Citizen.Wait(2000)
      PlaySoundFrontend(-1, "Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
      ClearPedTasks(playerPed)
      if skin.sex == 0 then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_police['Grade16'].male)
      else
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_police['Grade16'].female)
      end
    end)
	end)
  cop = cop + 1
end)
---------------police 17
RegisterNetEvent('Fewthz:policecloth17')
AddEventHandler('Fewthz:policecloth17', function()
  TriggerEvent('skinchanger:getSkin', function(skin)
    local playerPed = PlayerPedId()
    local lib, anim = 'mp_safehouseshower@male@', 'male_shower_towel_dry_to_get_dressed' 
    ESX.Streaming.RequestAnimDict(lib, function()
      local co = GetEntityCoords(playerPed)
      local he = GetEntityHeading(playerPed)

      TaskPlayAnimAdvanced(playerPed, lib, anim, co.x, co.y, co.z, 0, 0, he, 8.0, 1.0, -1, 0, 0.5, 0, 0)
      exports['mythic_progbar']:Progress( {
	
        name = "unique_action_name",
        duration = 2.0 * 1000,
        label = "กำลังเปลี่ยนชุด..",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        },
           
      }, function(status)
        if not status then
          -- Do Something If Event Wasn't Cancelled
        end
      end)
      Citizen.Wait(2000)
      PlaySoundFrontend(-1, "Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
      ClearPedTasks(playerPed)
      if skin.sex == 0 then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_police['Grade17'].male)
      else
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_police['Grade17'].female)
      end
    end)
	end)
  cop = cop + 1
end)
---------------police 18
RegisterNetEvent('Fewthz:policecloth18')
AddEventHandler('Fewthz:policecloth18', function()
  TriggerEvent('skinchanger:getSkin', function(skin)
    local playerPed = PlayerPedId()
    local lib, anim = 'mp_safehouseshower@male@', 'male_shower_towel_dry_to_get_dressed' 
    ESX.Streaming.RequestAnimDict(lib, function()
      local co = GetEntityCoords(playerPed)
      local he = GetEntityHeading(playerPed)

      TaskPlayAnimAdvanced(playerPed, lib, anim, co.x, co.y, co.z, 0, 0, he, 8.0, 1.0, -1, 0, 0.5, 0, 0)
      exports['mythic_progbar']:Progress( {
	
        name = "unique_action_name",
        duration = 2.0 * 1000,
        label = "กำลังเปลี่ยนชุด..",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        },
           
      }, function(status)
        if not status then
          -- Do Something If Event Wasn't Cancelled
        end
      end)
      Citizen.Wait(2000)
      PlaySoundFrontend(-1, "Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
      ClearPedTasks(playerPed)
      if skin.sex == 0 then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_police['Grade18'].male)
      else
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_police['Grade18'].female)
      end
    end)
	end)
  cop = cop + 1
end)
---------------mechanic 0
RegisterNetEvent('Fewthz:mechaniccloth0')
AddEventHandler('Fewthz:mechaniccloth0', function()
  TriggerEvent('skinchanger:getSkin', function(skin)
    local playerPed = PlayerPedId()
    local lib, anim = 'mp_safehouseshower@male@', 'male_shower_towel_dry_to_get_dressed' 
    ESX.Streaming.RequestAnimDict(lib, function()
      local co = GetEntityCoords(playerPed)
      local he = GetEntityHeading(playerPed)

      TaskPlayAnimAdvanced(playerPed, lib, anim, co.x, co.y, co.z, 0, 0, he, 8.0, 1.0, -1, 0, 0.5, 0, 0)
      exports['mythic_progbar']:Progress( {
	
        name = "unique_action_name",
        duration = 2.0 * 1000,
        label = "กำลังเปลี่ยนชุด..",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        },
           
      }, function(status)
        if not status then
          -- Do Something If Event Wasn't Cancelled
        end
      end)
      Citizen.Wait(2000)
      PlaySoundFrontend(-1, "Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
      ClearPedTasks(playerPed)
      if skin.sex == 0 then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_mechanic['Grade0'].male)
      else
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_mechanic['Grade0'].female)
      end
    end)
	end)
  mc = mc + 1
end)

---------------mechanic 1
RegisterNetEvent('Fewthz:mechaniccloth1')
AddEventHandler('Fewthz:mechaniccloth1', function()
  TriggerEvent('skinchanger:getSkin', function(skin)
    local playerPed = PlayerPedId()
    local lib, anim = 'mp_safehouseshower@male@', 'male_shower_towel_dry_to_get_dressed' 
    ESX.Streaming.RequestAnimDict(lib, function()
      local co = GetEntityCoords(playerPed)
      local he = GetEntityHeading(playerPed)

      TaskPlayAnimAdvanced(playerPed, lib, anim, co.x, co.y, co.z, 0, 0, he, 8.0, 1.0, -1, 0, 0.5, 0, 0)
      exports['mythic_progbar']:Progress( {
	
        name = "unique_action_name",
        duration = 2.0 * 1000,
        label = "กำลังเปลี่ยนชุด..",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        },
           
      }, function(status)
        if not status then
          -- Do Something If Event Wasn't Cancelled
        end
      end)
      Citizen.Wait(2000)
      PlaySoundFrontend(-1, "Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
      ClearPedTasks(playerPed)
      if skin.sex == 0 then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_mechanic['Grade0'].male)
      else
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_mechanic['Grade0'].female)
      end
    end)
	end)
  mc = mc + 1
end)

---------------mechanic 2
RegisterNetEvent('Fewthz:mechaniccloth2')
AddEventHandler('Fewthz:mechaniccloth2', function()
  TriggerEvent('skinchanger:getSkin', function(skin)
    local playerPed = PlayerPedId()
    local lib, anim = 'mp_safehouseshower@male@', 'male_shower_towel_dry_to_get_dressed' 
    ESX.Streaming.RequestAnimDict(lib, function()
      local co = GetEntityCoords(playerPed)
      local he = GetEntityHeading(playerPed)

      TaskPlayAnimAdvanced(playerPed, lib, anim, co.x, co.y, co.z, 0, 0, he, 8.0, 1.0, -1, 0, 0.5, 0, 0)
      exports['mythic_progbar']:Progress( {
	
        name = "unique_action_name",
        duration = 2.0 * 1000,
        label = "กำลังเปลี่ยนชุด..",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        },
           
      }, function(status)
        if not status then
          -- Do Something If Event Wasn't Cancelled
        end
      end)
      Citizen.Wait(2000)
      PlaySoundFrontend(-1, "Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
      ClearPedTasks(playerPed)
      if skin.sex == 0 then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_mechanic['Grade2'].male)
      else
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_mechanic['Grade2'].female)
      end
    end)
	end)
  mc = mc + 1
end)

---------------mechanic 3
RegisterNetEvent('Fewthz:mechaniccloth3')
AddEventHandler('Fewthz:mechaniccloth3', function()
  TriggerEvent('skinchanger:getSkin', function(skin)
    local playerPed = PlayerPedId()
    local lib, anim = 'mp_safehouseshower@male@', 'male_shower_towel_dry_to_get_dressed' 
    ESX.Streaming.RequestAnimDict(lib, function()
      local co = GetEntityCoords(playerPed)
      local he = GetEntityHeading(playerPed)

      TaskPlayAnimAdvanced(playerPed, lib, anim, co.x, co.y, co.z, 0, 0, he, 8.0, 1.0, -1, 0, 0.5, 0, 0)
      exports['mythic_progbar']:Progress( {
	
        name = "unique_action_name",
        duration = 2.0 * 1000,
        label = "กำลังเปลี่ยนชุด..",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        },
           
      }, function(status)
        if not status then
          -- Do Something If Event Wasn't Cancelled
        end
      end)
      Citizen.Wait(2000)
      PlaySoundFrontend(-1, "Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
      ClearPedTasks(playerPed)
      if skin.sex == 0 then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_mechanic['Grade3'].male)
      else
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_mechanic['Grade3'].female)
      end
    end)
	end)
  mc = mc + 1
end)

---------------mechanic 4
RegisterNetEvent('Fewthz:mechaniccloth4')
AddEventHandler('Fewthz:mechaniccloth4', function()
  TriggerEvent('skinchanger:getSkin', function(skin)
    local playerPed = PlayerPedId()
    local lib, anim = 'mp_safehouseshower@male@', 'male_shower_towel_dry_to_get_dressed' 
    ESX.Streaming.RequestAnimDict(lib, function()
      local co = GetEntityCoords(playerPed)
      local he = GetEntityHeading(playerPed)

      TaskPlayAnimAdvanced(playerPed, lib, anim, co.x, co.y, co.z, 0, 0, he, 8.0, 1.0, -1, 0, 0.5, 0, 0)
      exports['mythic_progbar']:Progress( {
	
        name = "unique_action_name",
        duration = 2.0 * 1000,
        label = "กำลังเปลี่ยนชุด..",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        },
           
      }, function(status)
        if not status then
          -- Do Something If Event Wasn't Cancelled
        end
      end)
      Citizen.Wait(2000)
      PlaySoundFrontend(-1, "Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
        ClearPedTasks(playerPed)
      if skin.sex == 0 then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_mechanic['Grade4'].male)
      else
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_mechanic['Grade4'].female)
      end
    end)
	end)
  mc = mc + 1
end)

---------------mechanic 5
RegisterNetEvent('Fewthz:mechaniccloth5')
AddEventHandler('Fewthz:mechaniccloth5', function()
  TriggerEvent('skinchanger:getSkin', function(skin)
    local playerPed = PlayerPedId()
    local lib, anim = 'mp_safehouseshower@male@', 'male_shower_towel_dry_to_get_dressed' 
    ESX.Streaming.RequestAnimDict(lib, function()
      local co = GetEntityCoords(playerPed)
      local he = GetEntityHeading(playerPed)

      TaskPlayAnimAdvanced(playerPed, lib, anim, co.x, co.y, co.z, 0, 0, he, 8.0, 1.0, -1, 0, 0.5, 0, 0)
      exports['mythic_progbar']:Progress( {
	
        name = "unique_action_name",
        duration = 2.0 * 1000,
        label = "กำลังเปลี่ยนชุด..",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        },
           
      }, function(status)
        if not status then
          -- Do Something If Event Wasn't Cancelled
        end
      end)
      Citizen.Wait(2000)
      PlaySoundFrontend(-1, "Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
        ClearPedTasks(playerPed)
      if skin.sex == 0 then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_mechanic['Grade5'].male)
      else
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_mechanic['Grade5'].female)
      end
    end)
	end)
  mc = mc + 1
end)

---------------taxi 0
RegisterNetEvent('Fewthz:taxicloth0')
AddEventHandler('Fewthz:taxicloth0', function()
  TriggerEvent('skinchanger:getSkin', function(skin)
    local playerPed = PlayerPedId()
    local lib, anim = 'mp_safehouseshower@male@', 'male_shower_towel_dry_to_get_dressed' 
    ESX.Streaming.RequestAnimDict(lib, function()
      local co = GetEntityCoords(playerPed)
      local he = GetEntityHeading(playerPed)

      TaskPlayAnimAdvanced(playerPed, lib, anim, co.x, co.y, co.z, 0, 0, he, 8.0, 1.0, -1, 0, 0.5, 0, 0)
      exports['mythic_progbar']:Progress( {
	
        name = "unique_action_name",
        duration = 2.0 * 1000,
        label = "กำลังเปลี่ยนชุด..",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        },
           
      }, function(status)
        if not status then
          -- Do Something If Event Wasn't Cancelled
        end
      end)
      Citizen.Wait(2000)
      PlaySoundFrontend(-1, "Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
      ClearPedTasks(playerPed)
      if skin.sex == 0 then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_taxi['Grade0'].male)
      else
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_taxi['Grade0'].female)
      end
    end)
	end)
end)

RegisterNetEvent('Fewthz:taxicloth1')
AddEventHandler('Fewthz:taxicloth1', function()
  TriggerEvent('skinchanger:getSkin', function(skin)
    local playerPed = PlayerPedId()
    local lib, anim = 'mp_safehouseshower@male@', 'male_shower_towel_dry_to_get_dressed' 
    ESX.Streaming.RequestAnimDict(lib, function()
      local co = GetEntityCoords(playerPed)
      local he = GetEntityHeading(playerPed)

      TaskPlayAnimAdvanced(playerPed, lib, anim, co.x, co.y, co.z, 0, 0, he, 8.0, 1.0, -1, 0, 0.5, 0, 0)
      exports['mythic_progbar']:Progress( {
	
        name = "unique_action_name",
        duration = 2.0 * 1000,
        label = "กำลังเปลี่ยนชุด..",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        },
           
      }, function(status)
        if not status then
          -- Do Something If Event Wasn't Cancelled
        end
      end)
      Citizen.Wait(2000)
      PlaySoundFrontend(-1, "Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
      ClearPedTasks(playerPed)
      if skin.sex == 0 then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_taxi['Grade1'].male)
      else
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_taxi['Grade1'].female)
      end
    end)
	end)
end)
RegisterNetEvent('Fewthz:taxicloth2')
AddEventHandler('Fewthz:taxicloth2', function()
  TriggerEvent('skinchanger:getSkin', function(skin)
    local playerPed = PlayerPedId()
    local lib, anim = 'mp_safehouseshower@male@', 'male_shower_towel_dry_to_get_dressed' 
    ESX.Streaming.RequestAnimDict(lib, function()
      local co = GetEntityCoords(playerPed)
      local he = GetEntityHeading(playerPed)

      TaskPlayAnimAdvanced(playerPed, lib, anim, co.x, co.y, co.z, 0, 0, he, 8.0, 1.0, -1, 0, 0.5, 0, 0)
      exports['mythic_progbar']:Progress( {
	
        name = "unique_action_name",
        duration = 2.0 * 1000,
        label = "กำลังเปลี่ยนชุด..",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        },
           
      }, function(status)
        if not status then
          -- Do Something If Event Wasn't Cancelled
        end
      end)
      Citizen.Wait(2000)
      PlaySoundFrontend(-1, "Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
      ClearPedTasks(playerPed)
      if skin.sex == 0 then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_taxi['Grade2'].male)
      else
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_taxi['Grade2'].female)
      end
    end)
	end)
end)

RegisterNetEvent('Fewthz:taxicloth3')
AddEventHandler('Fewthz:taxicloth3', function()
  TriggerEvent('skinchanger:getSkin', function(skin)
    local playerPed = PlayerPedId()
    local lib, anim = 'mp_safehouseshower@male@', 'male_shower_towel_dry_to_get_dressed' 
    ESX.Streaming.RequestAnimDict(lib, function()
      local co = GetEntityCoords(playerPed)
      local he = GetEntityHeading(playerPed)

      TaskPlayAnimAdvanced(playerPed, lib, anim, co.x, co.y, co.z, 0, 0, he, 8.0, 1.0, -1, 0, 0.5, 0, 0)
      exports['mythic_progbar']:Progress( {
	
        name = "unique_action_name",
        duration = 2.0 * 1000,
        label = "กำลังเปลี่ยนชุด..",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        },
           
      }, function(status)
        if not status then
          -- Do Something If Event Wasn't Cancelled
        end
      end)
      Citizen.Wait(2000)
      PlaySoundFrontend(-1, "Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
      ClearPedTasks(playerPed)
      if skin.sex == 0 then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_taxi['Grade3'].male)
      else
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_taxi['Grade3'].female)
      end
    end)
	end)
end)

RegisterNetEvent('Fewthz:taxicloth4')
AddEventHandler('Fewthz:taxicloth4', function()
  TriggerEvent('skinchanger:getSkin', function(skin)
    local playerPed = PlayerPedId()
    local lib, anim = 'mp_safehouseshower@male@', 'male_shower_towel_dry_to_get_dressed' 
    ESX.Streaming.RequestAnimDict(lib, function()
      local co = GetEntityCoords(playerPed)
      local he = GetEntityHeading(playerPed)

      TaskPlayAnimAdvanced(playerPed, lib, anim, co.x, co.y, co.z, 0, 0, he, 8.0, 1.0, -1, 0, 0.5, 0, 0)
      exports['mythic_progbar']:Progress( {
	
        name = "unique_action_name",
        duration = 2.0 * 1000,
        label = "กำลังเปลี่ยนชุด..",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        },
           
      }, function(status)
        if not status then
          -- Do Something If Event Wasn't Cancelled
        end
      end)
      Citizen.Wait(2000)
      PlaySoundFrontend(-1, "Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
      ClearPedTasks(playerPed)
      if skin.sex == 0 then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_taxi['Grade4'].male)
      else
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms_taxi['Grade4'].female)
      end
    end)
	end)
end)

-----กลับมาชุดเดิม
RegisterNetEvent('Fewthz:loaddefult')
AddEventHandler('Fewthz:loaddefult', function(_source)
  local playerPed = PlayerPedId()
  TriggerEvent('skinchanger:getSkin', function(skin)
    local lib_un, anim_un = 'mp_safehouseshower@male@', 'male_shower_undress_&_turn_on_water'
    ESX.Streaming.RequestAnimDict(lib_un, function()
      local co = GetEntityCoords(playerPed)
      local he = GetEntityHeading(playerPed)

      TaskPlayAnimAdvanced(playerPed, lib_un, anim_un, co.x, co.y, co.z, 0, 0, he, 8.0, 1.0, -1, 0, 0.3, 0, 0)
      exports['mythic_progbar']:Progress( {
	
        name = "unique_action_name",
        duration = 2.0 * 1000,
        label = "กำลังเปลี่ยนชุด..",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        },
           
      }, function(status)
        if not status then
          -- Do Something If Event Wasn't Cancelled
        end
      end)
      Citizen.Wait(2000)
      PlaySoundFrontend(-1, "Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
      ClearPedTasks(playerPed)

      ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, _source)
          TriggerEvent('skinchanger:loadSkin', skin)
          TriggerEvent('esx:restoreLoadout')
      end)
      ClearPedBloodDamage(playerPed)
      ResetPedVisibleDamage(playerPed)
      ClearPedLastWeaponDamage(playerPed)
      
      
    end)
  end)
end)

-- Exports

function CheckDuty()
    local playerjob = PlayerData.job.name
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
