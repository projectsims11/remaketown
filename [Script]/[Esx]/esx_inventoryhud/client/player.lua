ESX = exports["es_extended"]:getSharedObject()
local targetPlayer
local targetPlayerName

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)


Citizen.CreateThread(function()
	TriggerEvent("chat:addSuggestion", "/openinventory", _U"openinv_help", { { name = _U"openinv_id", help = _U"openinv_help" } })
end)

-- RegisterNetEvent("Fxw_inventory:openOtherInventory")
-- AddEventHandler("Fxw_inventory:openOtherInventory",function(other, name1, name2, weapon, data)
-- targetPlayer = other
-- targetPlayerName = name1 .. " " .. name2
-- setPlayerInventoryData()
-- Wait(150)
-- openPlayerInventory()
-- end)
RegisterNetEvent"Fxw_inventory:openPlayerInventory"
AddEventHandler("Fxw_inventory:openPlayerInventory", function(target, playerName)
	targetPlayer = target
	targetPlayerName = playerName
	setPlayerInventoryData()
	openPlayerInventory()
end)

function refreshPlayerInventory()
	setPlayerInventoryData()
	Wait(150)
	loadPlayerInventory()
end

function setPlayerInventoryData()
	ESX.TriggerServerCallback("Fxw_inventory:getPlayerInventory", function(data)
		SendNUIMessage{ action = "setInfoText", text = "Player Name : " .. targetPlayerName }
		items = {}
		inventory = data.inventory
		accounts = data.accounts
		money = data.money
		weapons = data.weapons
		if Config.IncludeAccounts and accounts ~= nil then
			for key, value in pairs(accounts) do
				if not shouldSkipAccount(accounts[key].name) then
					local canDrop = accounts[key].name ~= "bank"
					if accounts[key].money > 0 then
						accountData = {
							label = accounts[key].label,
							count = accounts[key].money,
							type = "item_account",
							name = accounts[key].name,
							usable = false,
							rare = false,
							limit = -1,
							canRemove = canDrop
						}
						table.insert(items, accountData)
					end
				end
			end
		end
		if inventory ~= nil then
			for key, value in pairs(inventory) do
				if inventory[key].count <= 0 then
					inventory[key] = nil
				else
					inventory[key].type = "item_standard"
					table.insert(items, inventory[key])
				end
			end
		end

		-- if inventory ~= nil then
		-- 	local ItemList = ESX.Table.Clone(ESX.PlayerData.inventory)
		-- 	-- print(ESX.DumpTable(ItemList))
		-- 	for z, x in pairs(ItemList) do x.count = 0 end
		-- 	for z, x in pairs(ItemList) do
		-- 		for j, k in pairs(inventory) do if x.name == j then x.count = k end end
		-- 	end
		-- 	for key, value in pairs(ItemList) do
		-- 		if value.count > 0 then
		-- 			ItemList[key].type = "item_standard"
		-- 			table.insert(items, value)
		-- 		end
		-- 	end
		-- end

		
		-- if inventory ~= nil then
		-- 	for key, value in pairs(inventory) do
		-- 		if inventory[key].count <= 0 then inventory[key] = nil
		-- 		else
		-- 			inventory[key].type = "item_standard"
		-- 			table.insert(items, inventory[key])
		-- 		end
		-- 	end
		-- end
		if Config.IncludeWeapons and weapons ~= nil then
			for key, value in pairs(weapons) do
				local weaponHash = GetHashKey(weapons[key].name)
				local playerPed = PlayerPedId()
				if weapons[key].name ~= "WEAPON_UNARMED" then
					local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
					table.insert(items, {
						label = weapons[key].label,
						count = ammo,
						weight = 0,
						type = "item_weapon",
						name = weapons[key].name,
						usable = false,
						rare = false,
						limit = -1,
						canRemove = true
					})
				end
			end
		end
		SendNUIMessage{ action = "setSecondInventoryItems", itemList = items }
	end, targetPlayer)
end

function openPlayerInventory()
	loadPlayerInventory()
	isInInventory = true
	SendNUIMessage{ action = "display", type = "player" }
	SetNuiFocus(true, true)
end

RegisterNUICallback("TakeFromPlayer", function(data, cb)
	if IsPedSittingInAnyVehicle(playerPed) then return end
	if type(data.number) == "number" and math.floor(data.number) == data.number then
		local count = tonumber(data.number)
		if data.item.type == "item_weapon" then
			count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
		end
		if Config.Crossover[data.item.name] then
			exports["mythic_notify"]:SendAlert("error", "ของชิ้นนี้ไม่สามารถดึงได้")
			return
		end
		TriggerServerEvent("Fxw_inventory:tradePlayerItem", targetPlayer, GetPlayerServerId(PlayerId()), data.item.type, data.item.name, count, "police_take")
	end
	Wait(250)
	refreshPlayerInventory()
	-- loadPlayerInventory()
	cb"ok"
end)
RegisterNUICallback("PutIntoPlayer", function(data, cb)
	if IsPedSittingInAnyVehicle(playerPed) then return end
	if type(data.number) == "number" and math.floor(data.number) == data.number then
		if Config.Crossover[data.item.name] then
			exports["mythic_notify"]:SendAlert("error", "ไม่สามารถยัดของให้ผู้เล่นได้")
			return
		end
		local count = tonumber(data.number)
		if data.item.type == "item_weapon" then
			count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
		end
		TriggerServerEvent("Fxw_inventory:tradePlayerItem", GetPlayerServerId(PlayerId()), targetPlayer, data.item.type, data.item.name, count, "police_put")
	end
	Wait(250)
	refreshPlayerInventory()
	-- loadPlayerInventory()
	cb"ok"
end)