local ESX                 = nil;

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)
local targetPlayer
local targetPlayerName

Citizen.CreateThread(function()
    TriggerEvent(
        "chat:addSuggestion",
        "/openinventory",
        _U("openinv_help"),
        {
            {name = _U("openinv_id"), help = _U("openinv_help")}
        }
    )
end)

RegisterNetEvent("Fewthz_inventory:openPlayerInventory")
AddEventHandler("Fewthz_inventory:openPlayerInventory",function(target, playerName)
    targetPlayer = target
	targetPlayerName = playerName
	setPlayerInventoryData()
	openPlayerInventory()
end)

function refreshPlayerInventory()
    setPlayerInventoryData()
    Wait(150)
    loadPlayerInventoryFix()
end

function setPlayerInventoryData()
    ESX.TriggerServerCallback("Fewthz_inventory:getPlayerInventory",function(data)
    SendNUIMessage({
        action = "setInfoText",
        text = "<strong>" .. "กระเป๋า" .. "</strong>> ID (" .. tostring(targetPlayer) ..")"
    })
    items = {}
	inventory = data.inventory
	accounts = data.accounts
	money = data.money
	weapons = data.weapons
	if Config["IncludeAccounts"] and accounts ~= nil then
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
	if Config["IncludeWeapons"] and weapons ~= nil then
		for key, value in pairs(weapons) do
			local weaponHash = GetHashKey(weapons[key].name)
			local playerPed = PlayerPedId()
			if weapons[key].name ~= "WEAPON_UNARMED" then
				local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
				table.insert(items,{
					label = weapons[key].label,
					count = ammo,
					limit = -1,
					type = "item_weapon",
					name = weapons[key].name,
					usable = false,
					rare = false,
					canRemove = true
				})
			end
		end
	end
	SendNUIMessage({
		action = "setSecondInventoryItems",
		itemList = items
	})
	end,targetPlayer)
end

function openPlayerInventory()
    loadPlayerInventoryFix()
    isInInventory = true
    SendNUIMessage(
        {
            action = "display",
            type = "player"
        }
    )

    SetNuiFocus(true, true)
end


RegisterNUICallback("TakeFromPlayer",function(data, cb)
    if IsPedSittingInAnyVehicle(playerPed) then
        return
    end
    if type(data.number) == "number" and math.floor(data.number) == data.number then
        local count = tonumber(data.number)
        if data.item.type == "item_weapon" then
            count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
        end
        TriggerServerEvent("Fewthz_inventory:tradePlayerItem", targetPlayer, GetPlayerServerId(PlayerId()), data.item.type, data.item.name, count)
    end
    Wait(250)
    refreshPlayerInventory()
	Wait(250)
    loadPlayerInventoryFix()
    cb("ok")
end)

RegisterNUICallback("PutIntoPlayer",function(data, cb)
    if IsPedSittingInAnyVehicle(playerPed) then
        return
    end
    if type(data.number) == "number" and math.floor(data.number) == data.number then
        local count = tonumber(data.number)
        if data.item.type == "item_weapon" then
            count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
        end
        TriggerServerEvent("Fewthz_inventory:tradePlayerItem", GetPlayerServerId(PlayerId()), targetPlayer, data.item.type, data.item.name, count)
    end
    Wait(250)
    refreshPlayerInventory()
	Wait(250)
    loadPlayerInventoryFix()
    cb("ok")
end)