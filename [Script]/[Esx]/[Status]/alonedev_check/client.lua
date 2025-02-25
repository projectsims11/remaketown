
local ESX = nil
local players_table = {}
local players = 0
local player_job = nil
local inventory = nil 
local money = nil
local ScriptLoaded = false

Citizen.CreateThread(function()
	print("Data Reloading ... ")
	while ESX == nil do
		ESX = exports["es_extended"]:getSharedObject()
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	while ESX.GetPlayerData().job.name == nil do
		Citizen.Wait(100)
	end

	while ESX.GetPlayerData().accounts == nil do 
		Wait(100)
	end

	while ESX.GetPlayerData().inventory == nil do 
		Wait(100)
	end

	ScriptLoaded = true
	ESX.PlayerData = ESX.GetPlayerData()
	player_job = ESX.PlayerData.job.name
	inventory = ESX.PlayerData.inventory 
	money = ESX.PlayerData.accounts
	print("Loading Complete.")

end)

RegisterNetEvent('alonedev_check:addplayerconnected')
AddEventHandler('alonedev_check:addplayerconnected', function(connectedPlayers)
	UpdatePlayerTable(connectedPlayers)
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	ScriptLoaded = true
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)	
	player_job = job.name
end)


function UpdatePlayerTable(connectedPlayers)
	players_table = {}
	players = 0

	print('UpdatePlayerTable')

	for k, v in pairs(connectedPlayers) do
		players = players + 1

		if v.job then 
			if players_table[v.job] then 
				players_table[v.job].count = players_table[v.job].count + 1
			else 
				players_table[v.job] = {
					count = 1
				}
			end
		end
	end

	if cfg.Debug then 
		for i , v in pairs(players_table) do 
			print('Job : ' .. i .. ' Count : ' ..  v.count)
		end
	end


end

function CheckJob()
	return player_job
end

function CheckJobOnline(JOB, amount)
	if JOB then
		if players_table[JOB] == nil or players_table[JOB].count == nil then 
			if cfg.Debug then 
				TriggerServerEvent('alonedev_check:Notify', "Error [CheckJobOnline] : Job " ..JOB .. " Not Found" , true)
			end
			return 0
			
				-- TriggerServerEvent('alonedev_check:Notify', "Error [CheckJobOnline] : Job " ..JOB .. " Not Found" , true)
		else
			return 0
		end

		if amount then 
			if players_table[JOB] and players_table[JOB].count >= amount then
				return true, players_table[JOB].count
			end
		else 
			return players_table[JOB].count
		end
	end
end

function CheckPlayer()
	return players
end

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)

	if not money and ScriptLoaded then 
		TriggerServerEvent('alonedev_check:Notify', "Error [SetAccountMoney] : ResetClient")
		ResetClient()
	end

    for k,v in ipairs(money) do
        if v.name == account.name then
            money[k] = account
            break
        end
    end
end)

function CheckMoney(mtype, amount)
	local attempt = 0
	while money == nil do 
		attempt = attempt + 1
		Wait(1000)

		if attempt > 10 then  
			TriggerServerEvent('alonedev_check:Notify', "Error [CheckMoney] : Money Table Not Found")
		end
	end

	for i=1, #money do
		local money = money[i]
		if money.name == mtype then
			if not amount then
				return money.money	
			else
				if money.money >= amount then
					return true
				end
			end
		end
	end	

	return false

end


RegisterNetEvent('esx:addInventoryItem')
AddEventHandler('esx:addInventoryItem', function(item, count)

	if cfg.Debug then 
		print('Adding item ' .. item .. ' count : ' .. count)
	end

	if not inventory and ScriptLoaded then 
		TriggerServerEvent('alonedev_check:Notify', "Error [AddInventoryItem] : ResetClient")
		ResetClient()
	else 
		Wait(5000)
	end

	for k,v in ipairs(inventory) do
        if v.name == item.name then
            inventory[k] = {
				name = item , 
				count = count
			}
			break
		end
	end

	if cfg.Debug then 
		print('Added item ' .. item .. ' count : ' .. count .. ' Successfully')
	end
end)

RegisterNetEvent('esx:removeInventoryItem')
AddEventHandler('esx:removeInventoryItem', function(item, count)

	if cfg.Debug then 
		print('Removing item ' .. item .. ' count : ' .. count)
	end

	if not inventory and ScriptLoaded then 
		TriggerServerEvent('alonedev_check:Notify', "Error [RemoveInventoryItem] : ResetClient")
		ResetClient()
	end

	for k,v in ipairs(inventory) do
		if v.name == item.name then
			inventory[k] = {
				name = item , 
				count = count
			}
			break
		end
    end

	if cfg.Debug then 
		print('Removed item ' .. item .. ' count : ' .. count .. ' Successfully')
	end
end)

function CheckItems(item_name, count)
	local attempt = 0
	while inventory == nil do 
		attempt = attempt + 1
		Wait(1000)

		if attempt > 10 then  
			TriggerServerEvent('alonedev_check:Notify', "Error [CheckItems] : Money Table Not Found")
		end
	end

	if item_name then 
		for i=1, #inventory do
			local item = inventory[i]
			if item_name == item.name and item.count > 0 then
				if count then 
					if item.count >= count then 
						return true
					end
				else 
					return true
				end
			end
		end
	else 
		return inventory
	end
	return false
end

if cfg.Debug then 
	RegisterCommand('alonedev_check' , function()
		print("Player Job : " .. CheckJob())
		print("Player Count : " .. CheckPlayer())
		print("Police Job Online : " .. CheckJobOnline("police"))
		print("Player Money : " .. CheckMoney("money"))
		print("Player Bank : " .. CheckMoney("bank"))
		print("Player Black Money : " .. CheckMoney("black_money"))
	end)	
	RegisterCommand('alonedev_itemcheck' , function()
		for i , v in pairs(CheckItems()) do 
			print("Player have Items : " .. v.name .. ' Count : ' .. v.count)
		end
	end)	
end

if cfg.ResetClient then 
	RegisterCommand('alonedev_resetvalue' , function()
		ResetClient()
	end)	

	function ResetClient()
		print("Data Reloading ... ")
		while ESX == nil do
			ESX = exports["es_extended"]:getSharedObject()
			Citizen.Wait(0)
		end
	
		while ESX.GetPlayerData().job == nil do
			Citizen.Wait(100)
		end
	
		ScriptLoaded = true
		ESX.PlayerData = ESX.GetPlayerData()
		print("Loading Complete.")
	end
end

exports("CheckJob", CheckJob)
exports("CheckJobOnline", CheckJobOnline)
exports("CheckPlayer", CheckPlayer)
exports("CheckMoney", CheckMoney)
exports("CheckItems", CheckItems)
