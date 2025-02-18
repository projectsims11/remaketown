ESX = nil
local FewZ_ooc_playerlist = {}

TriggerEvent(
  "esx:getSharedObject",
  function(obj)
    ESX = obj
  end
)

function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height']
			
		}
	else
		return nil
	end
end
  

TriggerEvent('es:addCommand', 'me', function(source, args, user)
    local name = getIdentity(source)
    table.remove(args, 2)
    TriggerClientEvent('esx-qalle-chat:me', -1, source, name.firstname, table.concat(args, " "))
end)

RegisterCommand('ad', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
	local group = xPlayer.getGroup()
	if group == 'admin' or group == 'superadmin' or group == 'mod' then
	
	local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(4)
    local name = getIdentity(source)
    fal = ''
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 0, 0, 0.7); border-radius: 3px;"><i class="fas fa-ad"></i>{0} 📢 ประกาศจาก นายก <br> {1}<br></div>',
        args = { fal, msg }
    })
	end
end, false)

RegisterCommand("tc", function(source, args, rawCommand)
	local Player = ESX.GetPlayerFromId(source)
	local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(4)
    local name = getIdentity(source)
	if Player["job"]["name"] == "council" then
		fal = "ประกาศจากสภา"
		TriggerClientEvent("chat:addMessage", -1, {
			template = "<div style='padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.6); border-radius: 3px;'><i class='fas fa-balance-scale'></i> {0} <br> {1}<br></div>",
			args = { fal, msg }
		})
	end
end, false)

RegisterCommand('pd', function(source, args, rawCommand)
    
	local Player = ESX.GetPlayerFromId(source)

	if Player["job"]["name"] == "police" then
	
	local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(4)
    local name = getIdentity(source)
    fal = '🚔 ประกาศ จากกรมตำรวจ '
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 80, 245, 0.7); border-radius: 3px;"><i class="fas fa-gavel"></i>{0} <br> {1}<br></div>',
        args = { fal, msg }
    })

	local sendToDiscord = '' .. Player.name .. ' หน่วยงาน: ' .. Player.job.name .. ' ประกาศ: ' .. msg .. ''
	TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'AnnounceAgency', sendToDiscord, Player.source, '^5')
	end
end, false)
RegisterCommand('md', function(source, args, rawCommand)
    
	local Player = ESX.GetPlayerFromId(source)

	if Player["job"]["name"] == "ambulance" then
	
	local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(4)
    local name = getIdentity(source)
    fal = '🚑️ ประกาศจาก โรงพยาบาล '
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 100, 155, 0.7); border-radius: 3px;"><i class="fas fa-ambulance"></i>{0} <br> {1}<br></div>',
        args = { fal, msg }
    })

	local sendToDiscord = '' .. Player.name .. ' หน่วยงาน: ' .. Player.job.name .. ' ประกาศ: ' .. msg .. ''
	TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'AnnounceAgency', sendToDiscord, Player.source, '^9')
	end
end, false)

RegisterCommand('mc', function(source, args, rawCommand)
    
	local Player = ESX.GetPlayerFromId(source)

	if Player["job"]["name"] == "mechanic" then
	
	local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(4)
    local name = getIdentity(source)
    fal = '⚒ ประกาศจาก อู่ช่าง '
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 150, 50, 0.7); border-radius: 3px;"><i class="fas fa-wrench"></i>{0} <br> {1}<br></div>',
        args = { fal, msg }
    })

	local sendToDiscord = '' .. Player.name .. ' หน่วยงาน: ' .. Player.job.name .. ' ประกาศ: ' .. msg .. ''
	TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'AnnounceAgency', sendToDiscord, Player.source, '^3')
	end
end, false)

AddEventHandler('chatMessage', function(source, playername, message)
	local isFound = false
	local _source = source
	local name = getIdentity(source)
	
	if name["identifier"] ~= " " or name["identifier"] ~= nil or name["identifier"] ~= "" then
		for _,v in pairs(FewZ_ooc_playerlist) do
			if(name["identifier"] == v.steam) then
				isFound = true
				break
			end
		end
	else
		isFound = true
	end
	
	if(isFound == true) then
		if(string.sub(message, 1, 1) ~= "/") then
			local fal = name.firstname .. " " .. name.lastname
			for _,v in pairs(FewZ_ooc_playerlist) do
				TriggerClientEvent('chat:addMessage', v.id, {
					template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 3px;"><i class="fas fa-globe"></i> {0}:<br> {1}</div>',
					args = { fal, message }
				})
			end
		end
	end
end)

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end
