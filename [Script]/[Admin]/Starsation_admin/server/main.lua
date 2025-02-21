
ESX = nil
local itemList, jobList = {}, {}
local temppos = nil
admin = {}
Updateblip = {}
Updateblip_count = 0
Starsation_admin = GetCurrentResourceName("Starsation_admin")
if GetCurrentResourceName() ~= "Starsation_admin" then
    os.exit(-1)
end
TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj 
    print("Starting resource "..Starsation_admin.."")
end)

local pass

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		pass = math.random(1111,9999)
		
		Citizen.Wait(1000)

    local resource = GetCurrentResourceName()
    end
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

if Config.SettingSystem.Bansystem then
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
                                --print("player unbanned")
                        end)
                		deferrals.done()
                		return
                	end

                	local time = math.floor((result[1].time - os.time()) / 60)
                    deferrals.done("[เรื้อน] คุณถูกแบนชั่วคราว "..time.." นาที เหตุผล: "..result[1].reason)
                else
                    deferrals.done("[เรื้อน] คุณถูกแบนอย่างถาวรด้วยเหตุผล: "..result[1].reason)
                end
            else
                deferrals.done()
            end
        end)
    end)
end
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
    local iden = GetPlayerIdentifiers(source)[1]
    
    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @iden LIMIT 0,1', {['@iden'] = iden}, function(result)
            if not (result[1] == nil) then
                local job_label = GetJobLabel(result[1].job, result[1].job_grade)   
                local PlayerOnline = #ESX.GetPlayers()
                
                for i=1, #xPlayers, 1 do
                    local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                    data[i] = {
                        identifier = xPlayer.getIdentifier(),
                        playerid = xPlayers[i],
                        online = PlayerOnline,
                        group = xPlayer.getGroup(),
                        rpname = xPlayer.getName(),
                        cash = xPlayer.getMoney(), 
                        bank = xPlayer.getAccount("bank").money,
                        phone = result[1].phone_number,
                        jobs = xPlayer.job.grade_label,
                        name = GetPlayerName(xPlayers[i])
                    }
                end
            cb(data)
        else
            cb(nil)
        end
    end)
end)

function GetJobLabel(job_name, job_grade)
    local result = MySQL.Sync.fetchAll('SELECT label FROM job_grades WHERE job_name = @job_name AND grade = @job_grade', {
        ['@job_name'] = job_name,
        ['@job_grade'] = job_grade
    })
    if not (result[1] == nil) then
        return result[1].label
    end
    return nil
end

ESX.RegisterServerCallback("admin:getItemList", function(source,cb)
    cb(itemList)
 end)

ESX.RegisterServerCallback("admin:getBanList", function(source,cb)
    if Config.SettingSystem.Bansystem then
        MySQL.Async.fetchAll('SELECT * FROM bans',{}, function(result)
        	for i=1, #result, 1 do
        		result[i].time = math.floor((result[i].time - os.time()) / 60)
        	end
          	cb(result)
        end)
    else
        cb({})
    end

 end)

ESX.RegisterServerCallback("admin:getJobs", function(source,cb)
    cb(jobList)
 end)

 RegisterNetEvent("admin:saveplayerall")
 AddEventHandler("admin:saveplayerall", function()
     local xPlayer = ESX.GetPlayerFromId(source)
     local target = ESX.GetPlayerFromId(playerID)
     local playerGroup = xPlayer.getGroup()
     if Config.Perms[playerGroup] and Config.Perms[playerGroup].SavePlayerAll then
        ESX.SavePlayers()
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'บันทึกผู้เล่นทั้งหมด')
     else
        admin.Error(source, "noPerms")
     end
 end)

 RegisterNetEvent("admin:saveplayer")
 AddEventHandler("admin:saveplayer", function(playerID)
     local xPlayer = ESX.GetPlayerFromId(source)
     local target = ESX.GetPlayerFromId(playerID)
     local playerGroup = xPlayer.getGroup()
     if Config.Perms[playerGroup] and Config.Perms[playerGroup].SavePlayer then
        ESX.SavePlayer(xPlayer)
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'บันทึกผู้เล่น')

     else
        admin.Error(source, "noPerms")
     end
 end)

 RegisterNetEvent("admin:clearinventory")
 AddEventHandler("admin:clearinventory", function(playerID)
     local xPlayer = ESX.GetPlayerFromId(source)
     local target = ESX.GetPlayerFromId(playerID)
     local playerGroup = xPlayer.getGroup()
     if Config.Perms[playerGroup] and Config.Perms[playerGroup].ClearInventory then
        for k,v in ipairs(target.inventory) do
            if v.count > 0 then
                target.setInventoryItem(v.name, 0)
            end
        end
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'ถูกลบไอเทมทั้งหมดเรียบร้อย')
        TriggerClientEvent('esx:showNotification', target.source, 'คุณถูกลบไอเทมทั้งหมด')

     else
        admin.Error(source, "noPerms")
     end
 end)

 RegisterNetEvent("admin:clearweawpon")
 AddEventHandler("admin:clearweawpon", function(playerID)
     local xPlayer = ESX.GetPlayerFromId(source)
     local target = ESX.GetPlayerFromId(playerID)
     local playerGroup = xPlayer.getGroup()
     if Config.Perms[playerGroup] and Config.Perms[playerGroup].ClearWeawpon then
        for k,v in ipairs(target.loadout) do
            target.removeWeapon(v.name)
        end
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'ถูกลบอาวุธทั้งหมดเรียบร้อย')
        TriggerClientEvent('esx:showNotification', target.source, 'คุณถูกลบอาวุธทั้งหมด')

     else
        admin.Error(source, "noPerms")
     end
 end)

 RegisterNetEvent("admin:GiveWeapon")
 AddEventHandler("admin:GiveWeapon", function(playerID, weapon)
     local xPlayer = ESX.GetPlayerFromId(source)
     local target = ESX.GetPlayerFromId(playerID)
     local playerGroup = xPlayer.getGroup()
     if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanGiveWeapon then
        if target.hasWeapon(weapon) then
            target.addWeaponAmmo(weapon, 50)
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'เพิ่มกระสุนให้กับอาวุธของคุณ')

            local sendToDiscord = '' .. GetPlayerName(source) .. ' เพิ่มกระสุนให้กับ ' .. GetPlayerName(playerID) .. ' อาวุธ '..ESX.GetWeaponLabel(weapon)
            TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
        else
            target.addWeapon(weapon, 10)
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'You have been given a '..ESX.GetWeaponLabel(weapon)) 
            local sendToDiscord = '' .. GetPlayerName(source) .. ' เพิ่มปืนให้ตัวเอง ' .. GetPlayerName(playerID) .. ' อาวุธ '..ESX.GetWeaponLabel(weapon)
            TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
            
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
        TriggerClientEvent('esx:showNotification', source, "ให้ "..selectedItem.." ถึง "..GetPlayerName(playerID))
        local sendToDiscord = '' .. GetPlayerName(source) .. ' ให้ของกับ '..GetPlayerName(playerID).. ' ไอเทม '..ESX.GetItemLabel(selectedItem).. ' จำนวน '..amount
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
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
        TriggerClientEvent('esx:showNotification', source, "ให้ $"..amount.." เงินสด "..GetPlayerName(playerID))
        local sendToDiscord = '' .. GetPlayerName(source) .. ' เพิ่มเงิน '..GetPlayerName(playerID).. ' จำนวน '..amount
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    else
       admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:addBlack")
AddEventHandler("admin:addBlack", function (playerID, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanAddBlack then
        local target = ESX.GetPlayerFromId(playerID)
        target.addAccountMoney("black_money", amount)
        TriggerClientEvent('esx:showNotification', source, "ให้ $"..amount.." เงินสด "..GetPlayerName(playerID))
        local sendToDiscord = '' .. GetPlayerName(source) .. ' เพิ่มเงิน '..GetPlayerName(playerID).. ' จำนวน '..amount
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
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
        TriggerClientEvent('esx:showNotification', source, "ให้ $"..amount.." เงิน "..GetPlayerName(playerID).."'s บัญชีธนาคาร")
        local sendToDiscord = '' .. GetPlayerName(source) .. ' เพิ่มเงินธนาคาร '..GetPlayerName(playerID).. ' จำนวน '..amount
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    else
       admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent('admin:Kick')
AddEventHandler('admin:Kick', function(playerId, reason)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanKick then
        DropPlayer(playerId, reason)
        
        local sendToDiscord = '' .. GetPlayerName(source) .. ' เตะผู้เล่น '..GetPlayerName(playerId)
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    else
       admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent('admin:kickall')
AddEventHandler('admin:kickall', function(playerId, reason)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanKick then
		TriggerClientEvent('esx:kickall', -1)
        TriggerClientEvent('esx:showNotification', -1, "Kicked")
    else
       admin.Error(source, "noPerms")
    end
end)

if Config.SettingSystem.Bansystem then
    RegisterNetEvent('admin:Ban')
    AddEventHandler('admin:Ban', function(playerId, time, reason)
        local xPlayer = ESX.GetPlayerFromId(source)
        local xTarget = ESX.GetPlayerFromId(playerId)
        local playerGroup = xPlayer.getGroup()
        if Config.Perms[playerGroup] and (Config.Perms[playerGroup].CanBanTemp and time ~= 0) or (Config.Perms[playerGroup].CanBanPerm and time == 0) then
            if time ~= 0 then
            	local timeToSeconds = time * 60
            	time = (os.time() + timeToSeconds)
            end

            MySQL.Async.execute('INSERT INTO bans (license, name, time, reason) VALUES (@license, @name, @time, @reason)',
                {   
                    ['license'] = xTarget.getIdentifier(), 
                    ['name'] = xTarget.getName(), 
                    ['time'] = time, 
                    ['reason'] = reason 
                },
                function(insertId)
                    DropPlayer(playerId, "คุณถูกแบน")
            end)
            TriggerClientEvent('esx:showNotification', source, "แบน "..GetPlayerName(playerId))
            local sendToDiscord = '' .. GetPlayerName(source) .. ' แบนผู้เล่น '..GetPlayerName(playerId)
            TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
        else
           admin.Error(source, "noPerms")
        end
    end)
end

RegisterNetEvent("admin:Promote")
AddEventHandler("admin:Promote", function (playerID, group)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    local targetPlayer = ESX.GetPlayerFromId(playerID)
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanPromote then
        if group ~= "superadmin" or playerGroup == "superadmin" then
            targetPlayer.setGroup(group)
            TriggerClientEvent('esx:showNotification', source, "ได้รับการเลื่อนตำแหน่ง "..GetPlayerName(playerID).." แก่ "..group)
            local sendToDiscord = '' .. GetPlayerName(source) .. ' ตั้งยศแอดมินกับ '..GetPlayerName(playerID)
            TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
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
            TriggerClientEvent('chat:addMessage', -1,{
                template = '<div style="width: auto; display: flex; flex-direction: row; padding: 0.6vw; margin: 0.6vw; background-color: rgb(27, 27, 27); border-radius: 12px;"> <div style="padding-top: 10px;"><i style="color: #d03f44" class="fas fa-chess-queen"></i></div>&nbsp;&nbsp; <div \
                    style="\
                    box-shadow: 5px 5px 3px 0 #d03f44;\
                    display: inline-block;\
                    width: 40px;\
                    height: 40px;\
                    overflow: hidden;\
                    border-radius: 20%;\
                    background-position: 70% 25%;\
                    background-size: 130%;\
                    image-rendering: pixelated;\
                    background-repeat: no-repeat;\
                    background-image: url(https://cdn.discordapp.com/attachments/940648541364305931/1139223096327417976/IMG_9183.png);\
                    "\
                >\
                </div>   <div \
                style="display: flex; \
                flex-direction: column; \
                padding-left: 15px;">\
                <div \
                style="display: flex; flex-direction: row;"><span style="color: #d03f44;">{0}</span>&nbsp;<span style="font-size: 10px; padding-top: 8px;">['..os.date('%H:%M')..']</span></div><span>{1}</span></div></div>',
            args = { 'ประกาศจากแอดมิน' , message }
            })
        local sendToDiscord = '' .. GetPlayerName(source) .. ' ประกาศ '..message
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    else
       admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:Notification")
AddEventHandler("admin:Notification", function (playerID, message)
    local _source = playerID
    TriggerClientEvent('chat:addMessage', _source, {args = {"admin ", message}})
end)

RegisterCommand('hijack', function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'admin' then
		TriggerClientEvent("admin:hijak", source )
        local sendToDiscord = '' .. GetPlayerName(source) .. ' ใช้ hijack'
        TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    end
end)

RegisterNetEvent("admin:clearcarkey")
AddEventHandler("admin:clearcarkey", function(playerID)
     local xPlayer = ESX.GetPlayerFromId(source)
     local src = source
     local target = ESX.GetPlayerFromId(playerID)
     
    --  print(GetPlayerIdentifiers(playerID)[1])
     local playerGroup = xPlayer.getGroup()
     if Config.Perms[playerGroup] and Config.Perms[playerGroup].clearcarkey then
        -- local result = MySQL.Sync.execute('DELETE FROM owned_vehicles WHERE plate = @plate', {
        --  ['@plate'] = plate
        -- })
            
        local result = MySQL.Sync.execute('DELETE FROM owned_vehicles WHERE owner = @owner', {
            ['@owner'] = GetPlayerIdentifiers(playerID)[1]
        })
        Citizen.Wait(1000)
        TriggerClientEvent("Fewthz_inventory:getOwnerVehicle", src)
        --TriggerClientEvent('esx:showNotification', target.source, 'คุณถูกลบกุญแจรถ')
     else
        admin.Error(source, "noPerms")
     end
 end)

RegisterNetEvent("admin:Teleport")
AddEventHandler("admin:Teleport", function (targetId, action)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    local temp_id = nil
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanTeleport then
        if action == "bring" then
            sourceMessage = "คุณนำผู้เล่น"
            targetMessage = "คุณถูกเรียกตัว"
            xPlayer = ESX.GetPlayerFromId(source)
            xTarget = ESX.GetPlayerFromId(targetId)
            temp_id = source
        elseif action == "goto" then
            targetMessage = "คุณเคลื่อนย้ายไปยังผู้เล่น"
            xPlayer = ESX.GetPlayerFromId(targetId)
            xTarget = ESX.GetPlayerFromId(source)
            temp_id = targetId
        end
    
    
        if xTarget then
            local playerCoords = xPlayer.getCoords()
            -- TriggerClientEvent('admin_:teleport', xTarget.source, playerCoords)
            xTarget.setCoords(playerCoords)
            -- ESX.SavePlayers()
            if sourceMessage then
                TriggerClientEvent('esx:showNotification', xPlayer.source, sourceMessage)
            end
            TriggerClientEvent('esx:showNotification', xTarget.source, targetMessage)
            local sendToDiscord = '' .. GetPlayerName(source) .. ' ใช้ วาปกับ '..GetPlayerName(targetId)
            TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'ผู้เล่นไม่ได้ออนไลน์')        
        end
    else
       admin.Error(source, "noPerms")
    end
end)

RegisterCommand('healall', function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'admin' then
        TriggerClientEvent("admin.request", -1, "heal")
        local sendToDiscord = '' .. GetPlayerName(source) .. ' ใช้ healall '..GetPlayerName(target)
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    end
end)

RegisterCommand('heal', function(source, args, user)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getGroup() == 'admin' then
		-- heal another player - don't heal source
		if args[1] then
			local target = tonumber(args[1])
			
			-- is the argument a number?
			if target ~= nil then
				if GetPlayerName(target) then
					--print('esx_basicneeds: ' .. GetPlayerName(source) .. ' is healing a player!')
                    
					TriggerClientEvent('admin:healPlayer', target)
					--TriggerClientEvent('chatMessage', target, "HEAL", {223, 66, 244}, "คุณได้รับการรักษาแล้ว!")
				--else
					--TriggerClientEvent('chatMessage', source, "HEAL", {255, 0, 0}, "ไม่พบผู้เล่น!")
				end
			--else
				--TriggerClientEvent('chatMessage', source, "HEAL", {255, 0, 0}, "Incorrect syntax! You must provide a valid player ID")
			end
		else
            TriggerClientEvent('admin:healPlayer', source)
		end
	end
end)

RegisterCommand('kickall', function(source, args, user)
		local xPlayer = ESX.GetPlayerFromId(source)
		if xPlayer.getGroup() == 'superadmin' then
		TriggerClientEvent('esx:kickall', -1)

    local sendToDiscord = '' .. GetPlayerName(source) .. ' ใช้ kickall'
    TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
	end
end)

RegisterServerEvent('esx:kickall')
AddEventHandler('esx:kickall', function (security_code, message)
    DropPlayer(source,'ระบบ : คุณถูกเตะออกจาก เซิฟเวอร์')
end)

RegisterCommand('reviveall', function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'superadmin' then
		TriggerClientEvent("admin.request", -1, "revive")
    end
    local sendToDiscord = '' .. GetPlayerName(source) .. ' ใช้ reviveall'
    TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
end)

RegisterNetEvent("admin:revivedist")
AddEventHandler("admin:revivedist", function() 
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].revivedist then 
        TriggerClientEvent("admin.request", -1, "revive")

    Config['ServerLogs'].LogsReviveDist(source, GetPlayerName(source))
    else
        admin.Error(source, "noPerms")
    end
end)

RegisterCommand('fix', function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'superadmin' then
		TriggerClientEvent( 'wk:fixVehicle', source )
        local sendToDiscord = '' .. GetPlayerName(source) .. ' ใช้ fix'
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    end
end)

RegisterCommand('hij', function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'superadmin' then
		TriggerClientEvent( 'wk:hijack', source )
        local sendToDiscord = '' .. GetPlayerName(source) .. ' ใช้ hij'
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    end
end)

local frozen = {}

RegisterCommand('goto', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'superadmin' then
        targetMessage = "คุณเคลื่อนย้ายไปยังผู้เล่น"
        xPlayer = ESX.GetPlayerFromId(args[1])
        xTarget = ESX.GetPlayerFromId(source)
        temp_id = args[1]
        if xTarget then
            local playerCoords = xPlayer.getCoords()
            -- TriggerClientEvent('admin_:teleport', xTarget.source, playerCoords)
            xTarget.setCoords(playerCoords)
            if sourceMessage then
                TriggerClientEvent('esx:showNotification', xPlayer.source, sourceMessage)
            end
            TriggerClientEvent('esx:showNotification', xTarget.source, targetMessage)
            local sendToDiscord = '' .. GetPlayerName(source) .. ' วาปไปยัง ' ..GetPlayerName(args[1])
            TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'ผู้เล่นไม่ได้ออนไลน์')        
        end
    end
end)

local frozen = {}

RegisterCommand('bring', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'superadmin' then
        sourceMessage = "คุณดึงผู้เล่น"
            targetMessage = "You were summoned"
            xPlayer = ESX.GetPlayerFromId(source)
            xTarget = ESX.GetPlayerFromId(args[1])
            temp_id = source
        if xTarget then
            local playerCoords = xPlayer.getCoords()
            -- TriggerClientEvent('admin_:teleport', xTarget.source, playerCoords)
            xTarget.setCoords(playerCoords)
            if sourceMessage then
                TriggerClientEvent('esx:showNotification', xPlayer.source, sourceMessage)
            end
            TriggerClientEvent('esx:showNotification', xTarget.source, targetMessage)
            local sendToDiscord = '' .. GetPlayerName(source) .. ' ได้ดึงผู้เล่นเข้าหาตัว ' ..GetPlayerName(args[1])
            TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'ผู้เล่นไม่ได้ออนไลน์')        
        end
    end
end)

local frozen = {}
RegisterCommand('tpm', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'superadmin' then
        TriggerClientEvent('admin.tpm', source)
    end
end)

RegisterNetEvent("admin:wartime")
AddEventHandler("admin:wartime", function(time)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].wartime then
        TriggerClientEvent('General:WarTime', -1, time)
    else
       admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:giveitemall")
AddEventHandler("admin:giveitemall", function(item,count)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getGroup() == 'admin' then
		local xPlayers = ESX.GetPlayers()
		
		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

			if ESX.GetItemLabel(item) ~= nil then
				xPlayer.addInventoryItem(item, count)
                TriggerClientEvent('esx:showNotification', -1, "แจกไอเทม " .. ESX.GetItemLabel(item) .." จาก " .. GetPlayerName(source))
				local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. ESX.GetItemLabel(item) .. ' จำนวน ' .. count .. ' (แอดมินใช้คำสั่งผ่าน MenuAdmin)'
				TriggerEvent('Starsation_logdiscord:sendToDiscord', 'GiveAllItem', sendToDiscord, xPlayer.source, '^2')
			else
                TriggerClientEvent('esx:showNotification', source, "ไม่พบไอเทม")
			end	
		end		
	end
end)

RegisterNetEvent("admin:Slay")
AddEventHandler("admin:Slay", function (target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanSlay then
        TriggerClientEvent('admin:Slay', target)
        TriggerClientEvent('esx:showNotification', source, "คุณถูกฆ่า "..GetPlayerName(target))
        TriggerClientEvent('esx:showNotification', target, "คุณถูกแอดมินฆ่า")
        --local sendToDiscord = '' .. GetPlayerName(source) .. ' ได้ฆ่าผู้เล่น ' ..GetPlayerName(args[1])
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    else
       admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:God")
AddEventHandler("admin:God", function (target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanGodmode then
        TriggerClientEvent('admin:God', target)
        TriggerClientEvent('esx:showNotification', source, "คุณเปิด/ปิดการใช้งาน Godmode"..GetPlayerName(target))
        Config['ServerLogs'].LogsGodMode(source, GetPlayerName(source))
    else
       admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:Freeze")
AddEventHandler("admin:Freeze", function (target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanFreeze then
        TriggerClientEvent('admin:Freeze', target)
        TriggerClientEvent('esx:showNotification', source, "คุณแช่แข็ง / ยกเลิกแช่แข็ง "..GetPlayerName(target))
        --local sendToDiscord = '' .. GetPlayerName(source) .. ' ได้แช่แข็ง ' ..GetPlayerName(args[1])
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    else
       admin.Error(source, "noPerms")
    end
end)

if Config.SettingSystem.Bansystem then
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
            end)
            TriggerClientEvent('esx:showNotification', source, "คุณได้ปลดแบน ("..license..")")
            local sendToDiscord = '' .. GetPlayerName(source) .. ' ได้ปลดแบน ' ..license
            TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
        else
           admin.Error(source, "noPerms")
        end
    end)
end

RegisterNetEvent("admin:setJob")
AddEventHandler("admin:setJob", function(target, job, rank)
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetPlayer = ESX.GetPlayerFromId(target)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanSetJob then
        targetPlayer.setJob(job, rank)
        TriggerClientEvent('esx:showNotification', source, "เปลี่ยน "..GetPlayerName(target).." อาชีพ "..job)
        TriggerClientEvent('esx:showNotification', target, "อาชีพคุณเปลี่ยนไปเป็น "..job)
        local sendToDiscord = '' .. GetPlayerName(source) .. ' ตั้งหน่วยงานให้กับ '..GetPlayerName(target)..' เป็น ' ..job.. ' '
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    else
       admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:copyskin")
AddEventHandler("admin:copyskin", function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetPlayer = ESX.GetPlayerFromId(target)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CopySkin then
        TriggerClientEvent('Starsation_ClonePlayer:Clone',source,GetSkin(targetPlayer.identifier))
    else
       admin.Error(source, "noPerms")
    end
end)

GetSkin = function(iden)
    local skin = MySQL.Sync.fetchAll("SELECT skin FROM `users` WHERE identifier = '"..iden.."' ")

    if skin then
        return skin[1].skin
    end
    return false
end

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

Citizen.CreateThread(function()
	PerformHttpRequest("https://ipinfo.io/json", function(err, text, headers)
	local Original = "Starsation_admin"   
	local Script = ''..GetCurrentResourceName()..''
	local UserName = "Admin Menu"
	local Version  = "1.0"
	local webhooks = "https://discord.com/api/webhooks/1166339620661907506/stcuANvupHqRWkRsbX4V_IiiIWAYGuHRvB7PcRSOOZST9yky76uGUjI4zKxqroyQRBRF"
	local image = "https://cdn.discordapp.com/attachments/1120720635140776017/1190889023804289064/admin-panel.png?ex=65a370d4&is=6590fbd4&hm=1bd1a9e27c05a5faf873c05ec7309a99d3d273c4c3fe95456ee2f817eb9a50b1&"
	local connect = {
		{
			["color"] = "3669760",
			["description"] = ' ** Countries that use scripts :** '..GetConvar("sv_hostname","Unknown")..' \n ** Original script name :** '..Original..' \n ** Current script name :** '..Script..' \n ** Type of script :** '..UserName..' \n ** Version :** '..Version..'',   
			["image"] = {
				["url"] = ''..image..'',
			},
			['footer'] = { 
				['text'] = '🕚เวลา : '..os.date('%X')..' Current script name : '..Script..'',
			},
		}
	}

		PerformHttpRequest(webhooks, function(err, text, headers) end, 'POST', json.encode({username = " Starsation log "..Original.."" , embeds = connect}), { ['Content-Type'] = 'application/json' })
	end)
end)

RegisterNetEvent("admin:revive")
AddEventHandler("admin:revive", function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].CanRevive then
        TriggerClientEvent("admin.request", target, "revive")
        TriggerClientEvent('esx:showNotification', source, "คุณถูกชุบ "..GetPlayerName(target))
        TriggerClientEvent('esx:showNotification', target, "คุณถูกชุบโดยแอดมิน")
        local sendToDiscord = '' .. GetPlayerName(source) .. ' ใช้ revive '..GetPlayerName(target)
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    else
       admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:healspecific")
AddEventHandler("admin:healspecific", function(target) 
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].healspecific then 
        TriggerClientEvent("admin.request", target, "heal")
        local sendToDiscord = '' .. GetPlayerName(source) .. ' ใช้ heal '..GetPlayerName(target)
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    else
        admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:reviveall")
AddEventHandler("admin:reviveall", function() 
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].reviveall then 
        TriggerClientEvent("admin.request", -1, "revive")
        local sendToDiscord = '' .. GetPlayerName(source) .. ' ใช้ reviveall '
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
    else
        admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:godall")
AddEventHandler("admin:godall", function() 
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].godall then 
        TriggerClientEvent("admin:godall", -1)
    else
        admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:killall")
AddEventHandler("admin:killall", function() 
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].killall then 
        TriggerClientEvent("admin:killall", -1)
    else
        admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:freezeall")
AddEventHandler("admin:freezeall", function() 
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].freezeall then 
        TriggerClientEvent("admin:freezeall", -1)
    else
        admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:bringall")
AddEventHandler("admin:bringall", function() 
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].bringall then 
        TriggerClientEvent("admin:bringall", -1 , xPlayer.getCoords())
    else
        admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:speedrunall")
AddEventHandler("admin:speedrunall", function() 
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].speedrunall then 
        TriggerClientEvent("admin:speedrunall", -1)
    else
        admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:jumeperall")
AddEventHandler("admin:jumeperall", function() 
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].jumeperall then 
        TriggerClientEvent("admin:jumeperall", -1)
    else
        admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:staminagodall")
AddEventHandler("admin:staminagodall", function() 
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].staminagodall then 
        TriggerClientEvent("admin:staminagodall", -1)
    else
        admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:speedrun")
AddEventHandler("admin:speedrun", function(target) 
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].speedrun then 
        TriggerClientEvent("admin:speedrunall", target)
    else
        admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:jumeper")
AddEventHandler("admin:jumeper", function(target) 
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].jumeper then 
        TriggerClientEvent("admin:jumeperall", target)
    else
        admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:staminagod")
AddEventHandler("admin:staminagod", function(target) 
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].staminagod then 
        TriggerClientEvent("admin:staminagodall", target)
    else
        admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:healall")
AddEventHandler("admin:healall", function() 
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].healall then 
        TriggerClientEvent("admin.request", -1, "heal")
        local sendToDiscord = '' .. GetPlayerName(source) .. ' ใช้ healall '
        TriggerEvent('Starsation_logdiscord:sendToDiscord', 'admin', sendToDiscord, source, '^3')
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

RegisterNetEvent("admin:addUpdateblip")
AddEventHandler("admin:addUpdateblip", function(state)
    Updateblip[source] = state
    if state then
        Updateblip_count  = Updateblip_count + 1
    else
        Updateblip_count = Updateblip_count - 1
    end
end)

AddEventHandler('playerDropped', function(reason)
    if Updateblip[source] ~= nil then
        Updateblip[source] = nil
    end
    for key, value in pairs(Updateblip) do
        if value then
            TriggerClientEvent('admin:removeUser', key, source)
        end
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
--[[
RegisterNetEvent("admin:delcarall")
AddEventHandler("admin:delcarall", function(time)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].delcarall then
        TriggerClientEvent("Starsation_deletecar:RunNotifyDeleteVehicle", -1, time)
    else
       admin.Error(source, "noPerms")
    end
end)]]

RegisterNetEvent('Starsation_jail:openMenu')
AddEventHandler('Starsation_jail:openMenu', function()
end)

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

function split(s, delimiter)
    result = {}
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match)
    end
    return result
end

SHOW_TOADMIN = function(type,playername,reason)
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.getGroup() == 'admin' then

            if type == 'login' then
                TriggerClientEvent('esx:showNotification', xPlayer.source, '~y~'..playername..' ~g~ Connect')
            else
                TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~'..playername..' ~r~'..reason..'')
            end
        end
    end
end

TriggerEvent('crash', function(source, args, user) --ทำให้ค้าง
	if args[1] then
		if(GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			TriggerEvent("es:getPlayerFromId", player, function(target)

				TriggerClientEvent('crash', player)

				TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Player ^2" .. GetPlayerName(player) .. "^0 has been crashed.")
			end)
		else
			TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Incorrect player ID!")
		end
	else
		TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Incorrect player ID!")
	end
end) --ทำให้ค้าง

RegisterNetEvent("admin:addhunger")
AddEventHandler("admin:addhunger", function(target , percent) 
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].addhunger then 
        TriggerClientEvent("admin:addhunger", target, percent)

        Config['ServerLogs'].LogsAddHunger(source, GetPlayerName(source) , GetPlayerName(target) , percent)
    else
        admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:removestress")
AddEventHandler("admin:removestress", function(target,percent) 
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].removestress then 
        TriggerClientEvent("admin:removestress", target, percent)

        Config['ServerLogs'].LogsRemoveStress(source, GetPlayerName(source) , GetPlayerName(target) , percent)
    else
        admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:arall")
AddEventHandler("admin:arall", function(target) 
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].arall then 
        TriggerClientEvent("admin:arall", target)
        Config['ServerLogs'].LogsAddHungerRemoveStress(source, GetPlayerName(source) , GetPlayerName(target))
    else
        admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:Propall")
AddEventHandler("admin:Propall", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].Propall then
        TriggerClientEvent('admin:DelProp', xPlayer , true)
    else
       admin.Error(source, "noPerms")
    end
end)



RegisterNetEvent("getcar")
AddEventHandler("getcar", function(source, args, showError)
    local source = source
    MySQL.Async.execute('UPDATE owned_vehicles SET stored = @stored ',
    { 
        ['@stored'] = 1 
    }, function(result)
    end)
end, true, {help = "Getcar To Garage", validate = false, arguments = {}})


RegisterNetEvent("admin:delcarall")
AddEventHandler("admin:delcarall", function(time)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].delcarall then
        AutoDeleteCar(time)
        Config['ServerLogs'].LogsDeleteCarAll(source, GetPlayerName(source))
    else
       admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:canceldelcarall")
AddEventHandler("admin:canceldelcarall", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].canceldelcarall then
        CancelAutoDeleteCar()
        Config['ServerLogs'].LogsCancelDeleteCarAll(source, GetPlayerName(source))
    else
       admin.Error(source, "noPerms")
    end
end)

RegisterNetEvent("admin:restartserver")
AddEventHandler("admin:restartserver", function(time)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].restartserver then
        AutoReserver(time)
        Config['ServerLogs'].LogsRestart(source, GetPlayerName(source))
    else
       admin.Error(source, "noPerms")
    end
end)


RegisterNetEvent("admin:cancelrestartserver")
AddEventHandler("admin:cancelrestartserver", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    if Config.Perms[playerGroup] and Config.Perms[playerGroup].cancelrestartserver then
        CancelAutoReserver()
        Config['ServerLogs'].LogsCancelRestart(source, GetPlayerName(source))
    else
       admin.Error(source, "noPerms")
    end
end)