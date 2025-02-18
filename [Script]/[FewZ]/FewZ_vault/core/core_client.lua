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

ESX = nil
local vaultType = {}

local ObjectVault = {}
local ObjectFewZ = {}
local isOpen = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

checkHasItem = function(item_name, count)
    local inventory = ESX.GetPlayerData().inventory
    for i=1, #inventory do
      local item = inventory[i]
      if item_name == item.name and item.count >= count then
        return true
      end
    end
    return false
end

function OpenVaultInventoryMenu(data)
	if data.job == ESX.PlayerData.job.name or data.job == 'vault' then
		vaultType = data
		if data.job == ESX.PlayerData.job.name and data.job ~= 'vault' then
			TriggerServerEvent('FewZ:OpenVault',data.job)
		else
			if data.needItem then
				if checkHasItem(data.needItemLicense,1) then
					TriggerServerEvent('FewZ:OpenVault',data.job)
				else
					exports.pNotify:SendNotification({text=(Config.Text.NoItem),type="error"})
				end
			else
				if data.removeMoney then
					TriggerServerEvent('FewZ:RemoveMoney',data.money,data.job, data.pNotifyPed)
				else
					TriggerServerEvent('FewZ:OpenVault',data.job)	
				end
			end	
		end
	else
		exports.pNotify:SendNotification({text=(Config.Text.Nojobs),type="error"})
		Citizen.Wait(8000)
	end
end

Citizen.CreateThread(function()
    while ESX == nil or ESX.PlayerData == nil or ESX.PlayerData.job == nil do
        Citizen.Wait(1000)
    end

    for k,v in pairs(Config.Vault) do
		ESX.Game.SpawnLocalObject(v.VaultBox, vector3(v.coords.x, v.coords.y, v.coords.z), function(obj)
			SetEntityHeading(obj, v.heading)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)
			table.insert(ObjectVault, obj)
		end)
	end
    
end)

Citizen.CreateThread(function()
    while ESX == nil or ESX.PlayerData == nil or ESX.PlayerData.job == nil do
        Citizen.Wait(1000)
    end
    for k,v in pairs(Config.FewZ) do
		ESX.Game.SpawnLocalObject(v.VaultBox, vector3(v.Coords.x, v.Coords.y, v.Coords.z), function(obj)
			SetEntityHeading(obj, v.heading)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)
			table.insert(ObjectFewZ, obj)
		end)
	end
    
end)

GetClosestCrate = function()
    local closest,closestDist
    local plyPos = GetEntityCoords(PlayerPedId())
    for k,v in pairs(Config.Vault) do
		local dist = Vdist(plyPos,v.coords.x,v.coords.y, v.coords.z)
		if not closestDist or dist < closestDist then
			closest = k
			closestDist = dist
		end
    end
    return (closest or false),(closestDist or 9999)
end

GetClosestCrate2 = function()
    local closest,closestDist
    local plyPos = GetEntityCoords(PlayerPedId())
    for k,v in pairs(Config.FewZ) do
		local dist = Vdist(plyPos,v.Coords.x,v.Coords.y, v.Coords.z)
		if not closestDist or dist < closestDist then
			closest = k
			closestDist = dist
		end
    end
    return (closest or false),(closestDist or 9999)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local closest,dist = GetClosestCrate()
		if closest then
            if dist < 3 then
				if not IsEntityDead(PlayerPedId()) then 
					exports['Fewthz_TextUI']:ShowHelpNotification(Config.Vault[closest].TEXT..closest)
					if IsControlJustReleased(0, Keys['E']) then
						--CheckVaultClosed(closest)
						if ESX.PlayerData.job.name == closest then
							OpenVaultInventoryMenu({job = closest, needItemLicense = Config.Vault[closest].needItemLicense})
						else
							exports.pNotify:SendNotification({text=(Config.Vault[closest].NotJob),type="error"})
						end
					end
				end
			else
				if isOpen ~= nil and isOpen == closest then
					isOpen = nil
					TriggerEvent(Config.Setiing.CloseInventory)
				end
				Citizen.Wait(500)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local closest,dist = GetClosestCrate2()
		if closest then
            if dist < 3 then
				if not IsEntityDead(PlayerPedId()) then 
					exports['Fewthz_TextUI']:ShowHelpNotification(Config.FewZ[closest].TEXT..Config.FewZ[closest].P)
					if IsControlJustReleased(0, Keys['E']) then
						--CheckVaultClosed(closest)
						OpenVaultInventoryMenu({job = Config.FewZ[closest].P, needItem = Config.FewZ[closest].needItem, needItemLicense = Config.FewZ[closest].needItemLicense, removeMoney = Config.FewZ[closest].removeMoney, money = Config.FewZ[closest].money, pNotifyPed = Config.FewZ[closest].pNotify})
					end
				end
			else
				if isOpen ~= nil and isOpen == closest then
					isOpen = nil
					TriggerEvent(Config.Setiing.CloseInventory)
				end
				Citizen.Wait(500)
			end
		end
	end
end)

function CheckVaultClosed(closest)
	isOpen = closest
	TriggerEvent(Config.Setiing.Progressbar, {
		name = "unique_action_name",
		duration = 60*1000,
		label = "ตู้จะปิดอัตโนมัติกันเหลี่ยม...",
		useWhileDead = false,
		canCancel = false,
		controlDisables = {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = false,
		},
	}, function(status)
		if not status then
			isOpen = nil
			TriggerEvent(Config.Setiing.CloseInventory)
		end
	end)
end

function getVaultLicense()
	return vaultType
end

AddEventHandler('onResourceStop', function(resource)

	if resource == GetCurrentResourceName() then

		for k, v in pairs(ObjectVault) do

			ESX.Game.DeleteObject(v)

		end

		for k, v in pairs(ObjectFewZ) do

			ESX.Game.DeleteObject(v)

		end

	end

end)
