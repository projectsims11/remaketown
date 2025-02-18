ESX = {}
ESX.Players = {}
ESX.Jobs = {}
ESX.JobsPlayerCount = {}
ESX.Items = {}
Core = {}
Core.UsableItemsCallbacks = {}
Core.RegisteredCommands = {}
Core.Pickups = {}
Core.PickupId = 0
Core.PlayerFunctionOverrides = {}
Core.DatabaseConnected = false
Core.playersByIdentifier = {}
Core.OutdatedResources = {}
Core.vehicleTypesByModel = {}

AddEventHandler('esx:getSharedObject', function(cb)
	cb(ESX)
end)

exports('getSharedObject', function()
	return ESX
end)

local function file_exists(name)
    local f = io.open(name, "r")
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end

local function WriteOutdatedResources()
    CreateThread(function()
        while not ESX.AllResourceStarted() do
            Wait(10000)
        end

        if #Core.OutdatedResources > 0 then
            if file_exists("esx_outdatedresources.txt") then
                os.remove("esx_outdatedresources.txt")
            end

            Wait(500)
            local file = io.open("esx_outdatedresources.txt", "w")
            if file then
                file:write("Outdated Warning By XzisZ | " .. os.date("%d %B %Y %A %X") .. "\n\n")
                for _, resource in ipairs(Core.OutdatedResources) do
                    file:write(resource .. "\n")
                end
                file:close()
                
                print(("^1[CRITICAL WARNING]^7 Outdated Resource(s) Warning\n^1[!]^7 You have ^5%s Resources^7 that used the ^5getSharedObject^7 event, this event is outdated!\n^1[!]^7Please take a look at ^5esx_outdatedresources.txt^7 to see which resource(s) is outdated"):format(#Core.OutdatedResources))
            else
                print("Failed to open esx_outdatedresources.txt for writing")
            end
        end
    end)
end

local function StartDBSync()
	CreateThread(function()
		local interval <const> = 10 * 60 * 1000
		while true do
			Wait(interval)
			Core.SavePlayers()
		end
	end)
end

MySQL.ready(function()
    Core.DatabaseConnected = true
    local items = MySQL.query.await('SELECT * FROM items')
    for _, v in ipairs(items) do
        ESX.Items[v.name] = {
            label = v.label,
            limit = v.limit,
            rare = v.rare,
            canRemove = v.can_remove
        }
    end

    ESX.RefreshJobs()

    print(('\n^4ES^5X NI^4GHT^5LY HA^4S BE^5EN IN^4ITIA^5LIZ^4ED!^7\nVersion: %s\nAuthor: %s\n'):format(GetResourceMetadata(GetCurrentResourceName(), "version", 0), "XzisZ"))

    WriteOutdatedResources()
    StartDBSync()
    if Config.EnablePaycheck then
        StartPayCheck()
    end
end)


RegisterServerEvent('esx:clientLog')
AddEventHandler('esx:clientLog', function(msg)
	if Config.EnableDebug then
		print(('[^2TRACE^7] %s^7'):format(msg))
	end
end)

RegisterNetEvent("esx:ReturnVehicleType", function(Type, Request)
	if Core.ClientCallbacks[Request] then
		Core.ClientCallbacks[Request](Type)
		Core.ClientCallbacks[Request] = nil
	end
end)
