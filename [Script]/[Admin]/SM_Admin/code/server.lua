local playerLists = {}
local JobLists = {}

ESX = nil
TriggerEvent(Config["EventRoute"]["getSharedObject"], function(obj) ESX = obj end)

AddEventHandler("onResourceStart", function(resource)
    if resource == "SM_Admin" then
        local result = MySQL.Sync.fetchAll("SELECT * FROM jobs")
        for i=1, #result, 1 do
            local result2 = MySQL.Sync.fetchAll("SELECT grade, label FROM job_grades WHERE job_name = @job", { ["@job"] = result[i].name })
            table.insert(JobLists, { name = result[i].name, label = result[i].label, ranks = result2 })
        end
    end
end)

RegisterNetEvent("SM_Admin:playerLoaded")
AddEventHandler("SM_Admin:playerLoaded", function()
    local playerId = source
	local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer and checkPermission(xPlayer) then
	    TriggerClientEvent("SM_Admin:loadData:List", xPlayer.source, JobLists)
    end
end)

RegisterNetEvent("SM_Admin:getData:Group")
AddEventHandler("SM_Admin:getData:Group", function()
	local xPlayer = ESX.GetPlayerFromId(source)
    local check = false
    if xPlayer and checkPermission(xPlayer) then check = true end
    TriggerClientEvent("SM_Admin:loadData:Group", xPlayer.source, check)
end)

RegisterNetEvent("SM_Admin:getData:Players")
AddEventHandler("SM_Admin:getData:Players", function() 
	local data = {}
	local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        data[i] = {
            playerid = xPlayers[i],
            identifier = GetPlayerIdentifier(xPlayers[i], 0),
    	    name = GetPlayerName(xPlayers[i])
        }
    end
    if not playerLists[xPlayer.getIdentifier()] then playerLists[xPlayer.getIdentifier()] = {} end
    if json.encode(playerLists[xPlayer.getIdentifier()]) ~= json.encode(data) then
        playerLists[xPlayer.getIdentifier()] = data
        TriggerClientEvent("SM_Admin:loadData:Players", xPlayer.source, playerLists[xPlayer.getIdentifier()])
    end
end)

RegisterNetEvent("SM_Admin:getData:User")
AddEventHandler("SM_Admin:getData:User", function(target) 
	local data = {}
	local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
	if xTarget then
		data = {
            playerid = xTarget.source,
			identifier = xTarget.getIdentifier(),
			rpname = xTarget.getName(),
			cash = xTarget.getMoney(),
			bank = xTarget.getAccount("bank").money,
			job = xTarget.getJob(),
			steamid = getSteam(xTarget.getIdentifier())
		}
		TriggerClientEvent("SM_Admin:loadData:User", xPlayer.source, data)
	end
end)

RegisterNetEvent("SM_Admin:setJob:User")
AddEventHandler("SM_Admin:setJob:User", function(target, job, grade) 
    local xTarget = ESX.GetPlayerFromId(target)
    xTarget.setJob(job, grade)
end)

RegisterNetEvent("SM_Admin:AddItem")
AddEventHandler("SM_Admin:AddItem", function(playerID, selectedItem, amount)
    if playerID ~= -1 then
        local xTarget = ESX.GetPlayerFromId(playerID)
        xTarget.addInventoryItem(selectedItem, amount)
    else
        local xPlayers = ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xTarget = ESX.GetPlayerFromId(xPlayers[i])
            xTarget.addInventoryItem(selectedItem, amount)
        end
    end
end)

RegisterNetEvent("SM_Admin:GiveWeapon")
AddEventHandler("SM_Admin:GiveWeapon", function(playerID, weapon)
    if playerID ~= -1 then
        local xTarget = ESX.GetPlayerFromId(playerID)
        if xTarget.hasWeapon(weapon) then
            xTarget.addWeaponAmmo(weapon, 50)
        else
            xTarget.addWeapon(weapon, 10)
        end
    else
        local xPlayers = ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xTarget = ESX.GetPlayerFromId(xPlayers[i])
            if xTarget.hasWeapon(weapon) then
                xTarget.addWeaponAmmo(weapon, 50)
            else
                xTarget.addWeapon(weapon, 10)
            end
        end
    end
end)

RegisterNetEvent("SM_Admin:AddMoney")
AddEventHandler("SM_Admin:AddMoney", function(playerID, type, amount)
    local xTarget = ESX.GetPlayerFromId(playerID)
    if xTarget then
        if type == "money" then
            xTarget.addMoney(amount)
        elseif type == "bank" then
            xTarget.addAccountMoney("bank", amount)
        elseif type == "black_money" then
            xTarget.addAccountMoney("black_money", amount)
        end
    end
end)

RegisterNetEvent("SM_Admin:Heal:ToSV")
AddEventHandler("SM_Admin:Heal:ToSV", function(type, target)
    local xTarget = ESX.GetPlayerFromId(target)
    if type == "one" then
        if xTarget then
            TriggerClientEvent("SM_Admin:Heal:ToCL", xTarget.source, type)
        end
    elseif type == "all" then
        TriggerClientEvent("SM_Admin:Heal:ToCL", -1, type)
    end
end)

RegisterNetEvent("SM_Admin:Revive:ToSV")
AddEventHandler("SM_Admin:Revive:ToSV", function(type, target)
    local xTarget = ESX.GetPlayerFromId(target)
    if type == "one" then
        if xTarget then
            TriggerClientEvent("SM_Admin:Revive:ToCL", xTarget.source, type)
        end
    elseif type == "all" then
        TriggerClientEvent("SM_Admin:Revive:ToCL", -1, type)
    end
end)

RegisterNetEvent("SM_Admin:Teleport:ToSV")
AddEventHandler("SM_Admin:Teleport:ToSV", function(targetId, action)
    local xPlayer = ESX.GetPlayerFromId(source)
    Teleport(source, targetId, action)
end)

RegisterNetEvent("SM_Admin:Freeze:ToSV")
AddEventHandler("SM_Admin:Freeze:ToSV", function(target)
    local xTarget = ESX.GetPlayerFromId(target)
    if xTarget then
        TriggerClientEvent("SM_Admin:Freeze:ToCL", xTarget.source)
    end
end)

RegisterNetEvent("SM_Admin:Slay:ToSV")
AddEventHandler("SM_Admin:Slay:ToSV", function(target)
    local xTarget = ESX.GetPlayerFromId(target)
    if xTarget then
	    TriggerClientEvent("SM_Admin:Slay:ToCL", xTarget.source)
    end
end)

RegisterNetEvent("SM_Admin:God:ToSV")
AddEventHandler("SM_Admin:God:ToSV", function(target)
    local xTarget = ESX.GetPlayerFromId(target)
    if xTarget then
        TriggerClientEvent("SM_Admin:God:ToCL", xTarget.source)
    end
end)

RegisterNetEvent("SM_Admin:sendData:Announce")
AddEventHandler("SM_Admin:sendData:Announce", function(text)
    Config["Announce"](text)
end)

RegisterNetEvent("zack:announceHandler")
AddEventHandler("zack:announceHandler", function(msg, target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    print(checkPermission(xPlayer))
    print(target)
    if checkPermission(xPlayer) then
        if target == "all" then
            TriggerClientEvent("zack:ShowAnnouncement", -1, msg)
        elseif target and target ~= "self" then
            TriggerClientEvent("zack:ShowAnnouncement", target, msg)
        else
            TriggerClientEvent("zack:ShowAnnouncement", source, msg)
        end
    else
        TriggerClientEvent('chat:addMessage', source, {args = {"admin", "คุณไม่มีสิทธิ์ใช้คำสั่งนี้"}})
    end
end)


RegisterNetEvent("SM_Admin:Kick")
AddEventHandler("SM_Admin:Kick", function(target, reason)
    local xTarget = ESX.GetPlayerFromId(target)
    print("kicked player id: "..target.." name: "..GetPlayerName(xTarget.source).." reason: "..reason)
    Wait(1000)
    DropPlayer(xTarget.source, reason)
end)

if serverCfg["Options"]["banSystem"] then
    AddEventHandler("playerConnecting", function(name, setReason, deferrals)
        local identifier
        for k,v in ipairs(GetPlayerIdentifiers(source)) do
            if string.match(v, 'steam:') then
                identifier = v
                break
            end
        end
        deferrals.defer()
        deferrals.update("Checking Ban Status.")
        local data = LoadResourceFile("SM_Admin", "banlists.json")
        local result = json.decode(data or "{}")
        if result[identifier] ~= nil then
            deferrals.done("[SM_Admin] You have been permanently banned from this server. \n \n <b> Name: </b>"..result[identifier].name.." \n <b> Identifier: </b>"..identifier.." \n <b> Ban Reason: </b>"..result[identifier].reason.." \n <b> Ban Date: </b>"..result[identifier].date.."\n")
        else
            deferrals.done()
        end
    end)

    RegisterNetEvent("SM_Admin:getData:BanLists")
    AddEventHandler("SM_Admin:getData:BanLists", function()
        local xPlayer = ESX.GetPlayerFromId(source)
        local data = LoadResourceFile("SM_Admin", "banlists.json")
        local result = json.decode(data or "{}")
        if json.encode(result) ~= "{}" then
            local data = {}
            for k,v in pairs(result) do
                table.insert(data, { identifier = k, name = v.name, reason = v.reason })
            end
            TriggerClientEvent("SM_Admin:loadData:BanLists", xPlayer.source, data)
        end
    end)

    RegisterNetEvent("SM_Admin:Ban")
    AddEventHandler("SM_Admin:Ban", function(target, reason)
        local xTarget = ESX.GetPlayerFromId(target)
        local data = LoadResourceFile("SM_Admin", "banlists.json")
        local result = json.decode(data or "{}")
        if result[xTarget.getIdentifier()] == nil then
            result[xTarget.getIdentifier()] = { name = GetPlayerName(xTarget.source), reason = reason, date = os.date("%Y/%m/%d %X") }
            print("banned player id: "..target.." name: "..GetPlayerName(xTarget.source).." reason: "..reason)
            Wait(1000)
            DropPlayer(xTarget.source, reason)
            SaveResourceFile("SM_Admin", "banlists.json", json.encode(result), -1)
        end
    end)

    RegisterNetEvent("SM_Admin:Unban")
    AddEventHandler("SM_Admin:Unban", function(identifier)
        local data = LoadResourceFile("SM_Admin", "banlists.json")
        local result = json.decode(data or "{}")
        if result[identifier] ~= nil then
            print("unbanned player: "..result[identifier].name)
            result[identifier] = nil
            SaveResourceFile("SM_Admin", "banlists.json", json.encode(result), -1)
        else
            print("player not found!")
        end
    end)

    RegisterCommand("+unban", function(source, args, rawCommand)
        TriggerEvent("SM_Admin:Unban", args[1])
    end)
end

---

RegisterCommand("healall", function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    if checkPermission(xPlayer) then
        TriggerClientEvent("SM_Admin:Heal:ToCL", -1, "all")
    end
end)

RegisterCommand("heal", function(source, args, user)
	local xPlayer = ESX.GetPlayerFromId(source)
    if checkPermission(xPlayer) then
        if args[1] then
            local xTarget = ESX.GetPlayerFromId(tonumber(args[1]))
            if xTarget.source ~= nil then
                TriggerClientEvent("SM_Admin:Heal:ToCL", xTarget.source, "one")
            end
        else
            TriggerClientEvent("SM_Admin:Heal:ToCL", xPlayer.source, "one")
        end
    end
end)

RegisterCommand("reviveall", function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    if checkPermission(xPlayer) then
        TriggerClientEvent("SM_Admin:Revive:ToCL", -1, "all")
    end
end)

RegisterCommand("revive", function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    if checkPermission(xPlayer) then
        if args[1] then
            local xTarget = ESX.GetPlayerFromId(tonumber(args[1]))
            if xTarget.source ~= nil then
                TriggerClientEvent("SM_Admin:Revive:ToCL", xTarget.source, "one")
            end
        else
            TriggerClientEvent("SM_Admin:Revive:ToCL", xPlayer.source, "one")
        end
    end
end)

RegisterCommand("goto", function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    if checkPermission(xPlayer) then
        if args[1] then
            local xTarget = ESX.GetPlayerFromId(tonumber(args[1]))
            if xTarget then
                Teleport(source, xTarget.source, "goto")
            end
        end
    end
end)

RegisterCommand("bring", function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    if checkPermission(xPlayer) then
        if args[1] then
            local xTarget = ESX.GetPlayerFromId(tonumber(args[1]))
            if xTarget then
                Teleport(source, xTarget.source, "bring")
            end
        end
    end
end)

RegisterCommand("tpm", function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    if checkPermission(xPlayer) then
        TriggerClientEvent("SM_Admin:tpwp:ToCL", xPlayer.source)
    end
end)

---

checkPermission = function(xPlayer)
    --for k,v in pairs(Config["Admin"]) do
    for k,v in pairs(authorized) do

        if xPlayer.getGroup() == v or xPlayer.getIdentifier() == v then
            return true
        end
    end
    TriggerClientEvent("chat:addMessage", xPlayer.source, { args = { "SM_Admin ", "You do not have permission for this." }})
end

Teleport = function(source, targetId, type)
    local xPlayer
    local xTarget
    if type == "bring" then
        xPlayer = ESX.GetPlayerFromId(source)
        xTarget = ESX.GetPlayerFromId(targetId)
    elseif type == "goto" then
        xPlayer = ESX.GetPlayerFromId(targetId)
        xTarget = ESX.GetPlayerFromId(source)
    end
    
    if xTarget then
        local playerCoords = GetEntityCoords(GetPlayerPed(xPlayer.source))
        TriggerClientEvent("SM_Admin:Teleport:ToCL", xTarget.source, playerCoords) 
    end
end

---

getSteam = function(identifier)
    if identifier:match("steam") then
        local cb = promise:new()
        PerformHttpRequest('http://steamcommunity.com/profiles/' .. tonumber(getid('steam', identifier), 16) .. '/?xml=1', function(a, b, c)
            local s = stringsplit(b, '\n')
            if s ~= nil and next(s) ~= nil then
                for i, Line in ipairs(s) do
                    if Line:find('<avatarFull>') then
                        cb:resolve(Line:gsub('	<avatarFull><!%[CDATA%[', ''):gsub(']]></avatarFull>', ''))
                        break
                    end
                end
            end
        end)
        return Citizen.Await(cb)
    else
        return ""
    end
end

getid = function(Type, CurrentID)
	local ID = stringsplit(CurrentID, ':')
	if (ID[1]:lower() == string.lower(Type)) then
		return ID[2]:lower()
	end
	return nil
end

stringsplit = function(input, seperator)
	if seperator == nil then
		seperator = '%s'
	end
	local t={} ; i=1
    if input ~= nil then
        for str in string.gmatch(input, '([^'..seperator..']+)') do
            t[i] = str
            i = i + 1
        end
        return t
    end
end
