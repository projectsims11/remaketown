ESX = nil
local itemList, jobList = {}, {}
local temppos = nil
admin = {}
Updateblip = {}
Updateblip_count = 0

TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj 
end)

AddEventHandler('onResourceStart', function()
    MySQL.ready(function ()
        MySQL.Async.fetchAll('SELECT name, label FROM items',{}, function(result)
            itemList = result
        end)

        MySQL.Async.fetchAll('SELECT * FROM jobs ORDER BY name <>  "unemployed", name',{}, function(result)
            for i=1, #result, 1 do
                MySQL.Async.fetchAll('SELECT grade, label FROM job_grades WHERE job_name = @job',{["@job"] = result[i].name}, function(result2)
                    table.insert(jobList, {name = result[i].name, label = result[i].label, ranks = result2})
                end)
            end
        end)
    end)
end)

AddEventHandler("playerConnecting", function(name, setReason, deferrals)
    local player = source
    local identifier
    for k,v in ipairs(GetPlayerIdentifiers(player)) do
        if string.match(v, 'steam:') then
            identifier = v
            break
        end
    end

    deferrals.defer()
    deferrals.update("Checking Ban Status.")
    
    MySQL.Async.fetchAll('SELECT * FROM bans WHERE license = @license', {
        ['@license'] = identifier
    }, function(result)
        if result[1] then
            if result[1].time ~= 0 then
            	if result[1].time < os.time() then
                    MySQL.Async.execute('DELETE FROM bans WHERE license = @license',
                        {   
                            ['license'] = result[1].license, 
                        },
                        function(insertId)
                            print("player unbanned")
                    end)
            		deferrals.done()
            		return
            	end

            	local time = math.floor((result[1].time - os.time()) / 60)
                deferrals.done("[admin] คุณถูกแบนชั่วคราวสำหรับ "..time.." นาที เหตุผล: "..result[1].reason)
            else
                deferrals.done("[admin] คุณถูกแบนอย่างถาวรด้วยเหตุผล: "..result[1].reason)
            end
        else
            deferrals.done()
        end
    end)
end)


--[Fetch User Rank CallBack]
ESX.RegisterServerCallback("esx_marker:fetchUserRank", function(source, cb)
    local player = ESX.GetPlayerFromId(source)

    if player then
        local playerGroup = player.getGroup()

        if playerGroup then 
            cb(playerGroup)
        else
            cb("user")
        end
    else
        cb("user")
    end
end)


ESX.RegisterServerCallback("admin:TeleportSpectate", function(source, cb, targetId)
    local player = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(targetId)
    local playerCoords = xTarget.getCoords()
    player.setCoords(playerCoords)
    cb(true)
end)

ESX.RegisterServerCallback("admin:getPlayers", function(source,cb)
    local data = {}
    local xPlayers = ESX.GetPlayers()

    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        data[i] = {
            identifier = xPlayer.getIdentifier(),
            playerid = xPlayers[i],
            group = xPlayer.getGroup(),
    	    rpname = xPlayer.getName(),
    	    cash = xPlayer.getMoney(), 
            bank = xPlayer.getAccount("bank").money,
    	    name = GetPlayerName(xPlayers[i])
        }
    end

    cb(data)
end)

ESX.RegisterServerCallback("admin:getItemList", function(source,cb)
    cb(itemList)
 end)

ESX.RegisterServerCallback("admin:getBanList", function(source,cb)
    MySQL.Async.fetchAll('SELECT * FROM bans',{}, function(result)
    	for i=1, #result, 1 do
    		result[i].time = math.floor((result[i].time - os.time()) / 60)
    	end
        	cb(result)
      end)
 end)

ESX.RegisterServerCallback("admin:getJobs", function(source,cb)
    cb(jobList)
 end)

RegisterNetEvent("admin:GiveWeapon")
AddEventHandler("admin:GiveWeapon", function(playerID, weapon)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanGiveWeapon then
       local target = ESX.GetPlayerFromId(playerID)
        if target.hasWeapon(weapon) then
           target.addWeaponAmmo(weapon, 12)
           ConfigSv["GiveWeaponAmmo"](source, target, xPlayer, weapon)
        else
           target.addWeapon(weapon, 0)
           ConfigSv["GiveWeapon"](source, target, xPlayer, weapon)
        end
    else
       admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:AddItem")
AddEventHandler("admin:AddItem", function(playerID, selectedItem, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanGiveItem then
        local target = ESX.GetPlayerFromId(playerID)
        target.addInventoryItem(selectedItem, amount)
        ConfigSv["GiveItem"](source, target, xPlayer, selectedItem, amount)
    else
       admin.Error(source, "noPerms")
    end
end)


RegisterNetEvent("admin:AddCash")
AddEventHandler("admin:AddCash", function (playerID, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanAddCash then
        local target = ESX.GetPlayerFromId(playerID)
        target.addMoney(amount)

        ConfigSv["GiveCash"](source, target, xPlayer, selectedItem, amount)
    else
       admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:AddBlackCash")
AddEventHandler("admin:AddBlackCash", function (playerID, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanAddBlackMoney then
        local target = ESX.GetPlayerFromId(playerID)
        target.addAccountMoney("black_money", amount)
        ConfigSv["GiveBlackCash"](source, target, xPlayer, selectedItem, amount)
    else
       admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:AddBank")
AddEventHandler("admin:AddBank", function (playerID, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanAddBank then
        local target = ESX.GetPlayerFromId(playerID)
        target.addAccountMoney("bank", amount)
        ConfigSv["GiveCashBank"](source, target, xPlayer, selectedItem, amount)
    else
       admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent('admin:Kick')
AddEventHandler('admin:Kick', function(playerID, reason)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanKick then
        local target = ESX.GetPlayerFromId(playerID)
        DropPlayer(playerID, reason)
        ConfigSv["Kick"](source, target, xPlayer, reason)
    else
       admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent('admin:Ban')
AddEventHandler('admin:Ban', function(playerId, time, reason)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and (Config.Perms[playerGroup].CanBanTemp and time ~= 0) or (Config.Perms[playerGroup].CanBanPerm and time == 0) then
        if time ~= 0 then
        	local timeToSeconds = time * 60
        	time = (os.time() + timeToSeconds)
        end

        MySQL.Async.execute('INSERT INTO bans (license, name, time, reason) VALUES (@license, @name, @time, @reason)',
            {   
                ['license'] = xPlayer.getIdentifier(), 
                ['name'] = GetPlayerName(playerId), 
                ['time'] = time, 
                ['reason'] = reason 
            },
            function(insertId)
                DropPlayer(playerId, "คุณโดนแบน")
            end)
        ConfigSv["Ban"](source, target, xPlayer, reason)
    else
       admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:Promote")
AddEventHandler("admin:Promote", function (playerID, group)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    local targetPlayer = ESX.GetPlayerFromId(playerID)
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanPromote then
        if group ~= "superadmin" or playerGroup == "superadmin" then
            targetPlayer.setGroup(group)
            TriggerClientEvent('esx:showNotification', source, "Promoted "..GetPlayerName(playerID).." to "..group)
        end
    else
       admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:Announcement")
AddEventHandler("admin:Announcement", function (message)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanAnnounce then
        TriggerClientEvent('chat:addMessage', -1, {color = { 255, 0, 0}, args = {"ประกาศ ", message}})
    else
       admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:Notification")
AddEventHandler("admin:Notification", function (playerID, message)
    local _source = playerID
    TriggerClientEvent('chat:addMessage', _source, {args = {"admin ", message}})
end)

RegisterNetEvent("admin:Teleport")
AddEventHandler("admin:Teleport", function (targetId, action)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    local temp_id = nil
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanTeleport then
        if action == "bring" then
            sourceMessage = "You brought a player"
            targetMessage = "You were summoned"
            xPlayer = ESX.GetPlayerFromId(source)
            xTarget = ESX.GetPlayerFromId(targetId)
            temp_id = source
        elseif action == "goto" then
            targetMessage = "You teleported to a player"
            xPlayer = ESX.GetPlayerFromId(targetId)
            xTarget = ESX.GetPlayerFromId(source)
            temp_id = targetId
        end
    
    
        if xTarget then
            local playerCoords = xPlayer.getCoords()
            TriggerClientEvent('admin_:teleport', xTarget.source, playerCoords)
            --xTarget.setCoords(playerCoords)
            if sourceMessage then
                TriggerClientEvent('esx:showNotification', xPlayer.source, sourceMessage)
            end
            TriggerClientEvent('esx:showNotification', xTarget.source, targetMessage)
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Player is not online.')        
        end
    else
       admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:Teleportx") -- ดึงผู้เล่นทุกคนมารวมกัน
AddEventHandler("admin:Teleportx", function (targetId, action)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    local temp_id = nil
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanTeleport then
        local playerCoords = xPlayer.getCoords()
        ConfigSv["TeleportAll"](source, target, xPlayer)
        TriggerClientEvent('admin_:teleport',-1, playerCoords)
    end
end)

RegisterNetEvent("admin:Slay")
AddEventHandler("admin:Slay", function (target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanSlay then
        TriggerClientEvent('admin:Slay', target)
        ConfigSv["Slay"](source, target, xPlayer)
    else
       admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:Slays") -- ฆ่าผู้เล่นทั้งหมด
AddEventHandler("admin:Slays", function (target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanSlay then
        TriggerClientEvent('admin:Slay', -1)
        ConfigSv["SlayAll"](source, target, xPlayer)
    else
       admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:God")
AddEventHandler("admin:God", function (target)
    local xPlayer = ESX.GetPlayerFromId(target)
    local playerGroup = xPlayer.getGroup()

    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanGodmode then
        TriggerClientEvent('admin:God', target)
        ConfigSv["God"](source, target, xPlayer)
    else
       admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:Godall")
AddEventHandler("admin:Godall", function ()
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanGodmode then
        TriggerClientEvent('admin:God',-1)
        ConfigSv["GodAll"](source, target, xPlayer)
    else
       admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:Speed") -- ฮีลทั้งเซิฟเวอร์
AddEventHandler("admin:Speed", function()
    TriggerClientEvent("admin:Speed",source)
end)

RegisterNetEvent("admin:heal") -- ฮีลทั้งเซิฟเวอร์
AddEventHandler("admin:heal", function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetPlayer = ESX.GetPlayerFromId(target)
    targetPlayer.triggerEvent('admin:heal')
    ConfigSv["Heal"](source, target, xPlayer)
end)

RegisterNetEvent("admin:healall") -- ฮีลทั้งเซิฟเวอร์
AddEventHandler("admin:healall", function()   
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent("healall", -1)
    ConfigSv["HealAll"](source, target, xPlayer)
end)

RegisterNetEvent("admin:revives") -- ชุปทั้งเซิฟเวอร์
AddEventHandler("admin:revives", function()   
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('reviveallplayer', -1)
    ConfigSv["ReviveAll"](source, target, xPlayer)
end)


RegisterNetEvent("admin:skin")
AddEventHandler("admin:skin", function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetPlayer = ESX.GetPlayerFromId(target)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanRevive then
        TriggerClientEvent('esx_skin:openSaveableMenu', target)
        ConfigSv["Skin"](source, target, xPlayer)
    else
       admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:addUpdateblip")
AddEventHandler("admin:addUpdateblip", function(state)
    Updateblip[source] = state
    if state then
        Updateblip_count  = Updateblip_count + 1
    else
        Updateblip_count = Updateblip_count - 1
    end
end)

Citizen.CreateThread(function()
    while true do
        if Updateblip_count >= 1 then
            local xPlayers = ESX.GetPlayers()
            local data = {}
            for i=1, #xPlayers, 1 do
                data[i] = {
                    playerId = xPlayers[i],
            	    rpname = GetPlayerName(xPlayers[i]),
            	    coords = GetEntityCoords(GetPlayerPed(xPlayers[i]))
                }
            end
            for key, value in pairs(Updateblip) do
                if value then
                    TriggerClientEvent('admin:showblip', key, key, data)
                end
            end
            if #xPlayers > 256 then
                Citizen.Wait(1000 * 5)
            elseif #xPlayers > 128 then
                Citizen.Wait(1000 * 4)
            elseif #xPlayers > 96 then
                Citizen.Wait(1000 * 3)
            elseif #xPlayers > 64 then
                Citizen.Wait(1000 * 2)
            else
                Citizen.Wait(1000)
            end
        end
        Citizen.Wait(0)
    end
end)


RegisterNetEvent("admin:Freeze")
AddEventHandler("admin:Freeze", function (target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanFreeze then
        TriggerClientEvent('admin:Freeze', target)
        ConfigSv["Freeze"](source, target, xPlayer)
    else
       admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:Unban")
AddEventHandler("admin:Unban", function(license)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanUnban then
        MySQL.Async.execute('DELETE FROM bans WHERE license = @license',
            {   
                ['license'] = license, 
            },
            function(insertId)
                print("player unbanned")
        end)
        TriggerClientEvent('esx:showNotification', source, "Unbanned Player. ("..license..")")
    else
       admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:setJob")
AddEventHandler("admin:setJob", function(target, job, rank)
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetPlayer = ESX.GetPlayerFromId(target)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanSetJob then
        targetPlayer.setJob(job, rank)
        ConfigSv["setJob"](source, target, xPlayer, targetPlayer, job, rank)
    else
       admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:revive")
AddEventHandler("admin:revive", function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetPlayer = ESX.GetPlayerFromId(target)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanRevive then
        targetPlayer.triggerEvent('esx_ambulancejob:revive')
        ConfigSv["Revive"](source, target, xPlayer)
    else
       admin.Error(source, "noPerms")
    end
end)

function admin.Error(source, message)
    if message == "noPerms" then
        TriggerClientEvent('chat:addMessage', source, {args = {"admin ", " You do not have permission for this."}})
    else
        TriggerClientEvent('chat:addMessage', source, {args = {"admin ", message}})
    end
end

function split(s, delimiter)
    result = {}
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match)
    end
    return result
end