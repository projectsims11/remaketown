
ESX = nil
local MRBName = GetCurrentResourceName()
TriggerEvent(Config['Event'].FrameWork_Server, function(obj) ESX = obj end)



local checkna = false
local keyna = false
local arr = {}
Citizen.CreateThread(function()
START()
end)



--[[
	Bunny = {
		player = "source",
		Coords = vector3(651,65,651)
	}
]]

local Bunny = {
	player 	= nil,
	name 	= nil,
	Coords 	= nil,
}




local Hunting 	= false
local TimePlay 	= nil

RegisterServerEvent(MRBName .. "CheckEvent")
AddEventHandler(MRBName .. "CheckEvent", function()
	if Hunting == true then
		TriggerClientEvent(MRBName.."SendinfoUnlucky",source,Bunny,Hunting,TimePlay)
	end
end)

Citizen.CreateThread(function()
  while true do
	Citizen.Wait(1000)
	 if Config.Systems.Onesync_Legacy_Or_Infinity == true then
		if Hunting == true then
			if Bunny.player ~= nil then
				local xPlayer = ESX.GetPlayerFromId(tonumber(Bunny.player))
				if Config['Systems'].clientcoords == false then
					local Coords =  xPlayer.getCoords(true)
					Bunny.Coords = vector3(Coords.x,Coords.y,Coords.z)
				end
				TriggerClientEvent(MRBName.."getlocations",-1,Bunny.Coords)
			end
		end
	 else
		break
	 end
   end
end)

RegisterServerEvent(MRBName .. "SendCoordsNa")
AddEventHandler(MRBName .. "SendCoordsNa", function(crs)
	Bunny.Coords = crs
end)



RegisterCommand(Config['Set_DefaultCommands'].command, function(source, args, RawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
	for k,v in pairs(Config.Set_DefaultCommands.Group_Allow) do
		if xPlayer.getGroup() == v then
			if args[1] ~= nil then
				TimePlay = tonumber(args[1])
				Hunting = true
				if args[2] ~= nil then
					local target = ESX.GetPlayerFromId(args[2])
					Bunny.player = target.source
					Bunny.name = target.name
					Bunny.Coords = target.getCoords(true)
					TriggerClientEvent(MRBName.."SendinfoUnlucky",-1,Bunny,Hunting,TimePlay)
				else
					RandomPlayer()
				end
			else
				TimePlay = tonumber(Config.Set_DefaultCommands.time)
				Hunting = true
				RandomPlayer()
			end
		end
	end
	
end)

Citizen.CreateThread(function() --* เวลา กิจกรรม
  while true do
	Citizen.Wait(2000)
	if Hunting== false then
		for k,v in pairs(Config.Time) do
			if type(v.Hour) == "table" then
				Hour = math.random(v.Hour[1],v.Hour[2])
			else
				Hour = v.Hour
			end
			if type(v.Min) == "table" then
				Min = math.random(v.Min[1],v.Min[2])
			else
				Min = v.Min
			end
			if Hour == os.date("*t").hour then
				if Min == os.date("*t").min then
					TimePlay = 600
					if type(v.Time) == "table" then
						TimePlay = math.random(v.Time[1],v.Time[2])
					else
						TimePlay = v.Time
					end
					Hunting = true
					RandomPlayer()
				end
			end
		 end
	end
   end
end)

function RandomPlayer() -- * สุ่มหาคนโชคร้าย
	local xPlayers = ESX.GetPlayers()
	local unlucky = nil
	local Stack_NotAllow = {}
	while true do
		Citizen.Wait(100)
		local Found = true
		if Hunting == false then
			break
		end
		if unlucky == nil then
			if xPlayers ~= nil then
				unlucky = math.random(1,#xPlayers)
			end
		else
			while true do
				Citizen.Wait(10)
				local Confirm = true
				unlucky = math.random(1,#xPlayers)
				for k,v in pairs(Stack_NotAllow) do
					if tonumber(unlucky) == tonumber(v) then
						Confirm = false
					end
				end
				if Confirm == true then
					break
				end
			end
		end
		local xPlayer = ESX.GetPlayerFromId(xPlayers[unlucky])
		for k,v in pairs(Config.BlacklistGroup) do --* เช็ค Group
			if xPlayer.getGroup() == v then
				Found = false
				break
			end
		end
		for k,v in pairs(Config.BlacklistJobs) do --* เช็คยศ
			if xPlayer.job.name == v then
				Found = false
				break
			end
		end
		if Config.BlacklistZones ~= nil then
			local coords = xPlayer.getCoords(true)
			for k,v in pairs(Config.BlacklistZones) do
				if (#(vector3(coords.x, coords.y, coords.z) - vector3(v.coords.x, v.coords.y, v.coords.z))) < v.range then
					Found = false
					break
				end
			end
		end
		if Found == true then
			break
		else
			table.insert(Stack_NotAllow,unlucky)
			Hunting = true
		end
	end
	if unlucky ~= nil and Hunting == true then
		local xPlayer = ESX.GetPlayerFromId(xPlayers[unlucky])
		Bunny.player = xPlayer.source
		Bunny.name = xPlayer.name
		Bunny.Coords = xPlayer.getCoords(true)
		TriggerClientEvent(MRBName.."SendinfoUnlucky",-1,Bunny,Hunting,TimePlay)
	else
		print("not Found Unlucky Player !!")
	end
end





Citizen.CreateThread(function() --* เวลา จบเกม
  while true do
	Citizen.Wait(1000)
	 if Hunting == true then
		if TimePlay ~= nil then
			TimePlay = TimePlay - 1
			if TimePlay <= 0 then
				Hunting = false
				TriggerClientEvent(MRBName.."SendinfoUnlucky",-1,Bunny,Hunting,TimePlay)
			end
		end
	 else
		Citizen.Wait(1000)
	 end
   end
end)

function START()
	RegisterServerEvent(MRBName .. "PickupBox")
	AddEventHandler(MRBName .. "PickupBox", function()
		local _source =source
		if Bunny.player == nil then
			local xPlayer = ESX.GetPlayerFromId(_source)
			Bunny.player = _source
			Bunny.name = xPlayer.name
			
			Bunny.Coords = xPlayer.getCoords(true)

			

			TriggerClientEvent(MRBName.."SendinfoUnlucky",-1,Bunny,Hunting,TimePlay)
		else
			Misslootbox(_source)
		end
	end)
end


RegisterServerEvent(MRBName .. "FinishHunt") --* รับของรางวัล
AddEventHandler(MRBName .. "FinishHunt", function()
	Bunny = {
		player = nil,
		Coords = nil
	}
	local xPlayer = ESX.GetPlayerFromId(source)
	if Config.Reward.Gets ~= nil then
		local Got = ""
		for k,v in pairs(Config.Reward.Gets) do
			local random = math.random(100)
			if random <= v.Percent then
				Count = 0
				if type(v.count) == "table" then
					Count = math.random(v.count[1],v.count[2])
				else
					Count = v.count
				end
				if v.Type ~= nil then
					TakeRewards(xPlayer,v.Itemname,Count,v.Type,Config.webhook.Gets)
				else
					xPlayer.addInventoryItem(v.Itemname, Count)
					
					-- sendToDiscord(xPlayer.name .. " ได้รับ "..v.Itemname.." : "..Count , 1.671168e7, xPlayer.source, Config.webhook.Gets)
				end
				Got = Got..v.Itemname.." : "..Count.."\n"
			end
		end
		sendToDiscord(xPlayer.name .."\n".. Got , 1.671168e7, xPlayer.source, Config.webhook.Gets)
	end
	if Config.Reward.Bonus ~= nil then
		local Got = ""
		for k,v in pairs(Config.Reward.Bonus) do
			local random = math.random(100)
			if random <= v.Percent then
				Count = 0
				if type(v.count) == "table" then
					Count = math.random(v.count[1],v.count[2])
				else
					Count = v.count
				end
				if v.Type ~= nil then
					TakeRewards(xPlayer,v.Itemname,Count,v.Type,Config.webhook.Bonus)
				else
					xPlayer.addInventoryItem(v.Itemname, Count)
					-- sendToDiscord(xPlayer.name .. " ได้รับ "..v.Itemname.." : "..Count , 1.671168e7, xPlayer.source, Config.webhook.Bonus)
				end
				Got = Got..v.Itemname.." : "..Count.."\n"
			end
		end
		sendToDiscord(xPlayer.name .. " \n "..Got , 1.671168e7, xPlayer.source, Config.webhook.Bonus)
	end
end)

function TakeRewards(xPlayer,item,count,Type,Discord)
	local Check = string.upper( Type )
	if Check == "WEAPON" then
		xPlayer.addWeapon(string.upper( item ), 1)
	elseif Check == "MONEY" then
		xPlayer.addMoney(count)
	elseif Check == "ITEM" then
		xPlayer.addInventoryItem(item, count)
	elseif Check == "BLACK_MONEY" then
		xPlayer.addAccountMoney('black_money', count)
	end


	-- sendToDiscord(xPlayer.name .. " ได้รับ "..item.." : "..Count , 1.671168e7, xPlayer.source, Discord)

end

RegisterServerEvent(MRBName .. "BunnyDeath")
AddEventHandler(MRBName .. "BunnyDeath", function(crs)
	local xPlayer = ESX.GetPlayerFromId(source)
	Bunny.player = nil
	Bunny.name = nil
	if Config['Systems'].clientcoords == true then
		Bunny.Coords = crs
	else
		Bunny.Coords = xPlayer.getCoords(true)
	end
	TriggerClientEvent(MRBName.."SendinfoUnlucky",-1,Bunny,Hunting,TimePlay)
end)


AddEventHandler('esx:playerDropped', function(source)
	if Bunny.player == source then
		local xPlayer = ESX.GetPlayerFromId(source)
		Bunny.player = nil
		Bunny.name = nil
		Bunny.Coords = xPlayer.getCoords(true)
		TriggerClientEvent(MRBName.."SendinfoUnlucky",-1,Bunny,Hunting,TimePlay)
	end
end)















--[[
    sendToDiscord(xPlayer.getName() .. " ได้เช่าอาวุธ Box ที่ " .. numOfBox .. " เป็นเวลา " .. DAY .. " วัน", 1.671168e7, source, Config.webhook)
]]

function sendToDiscord(name, color, src, discord_webhook)
	local identifiers = {
		steam = "",
		ip = "",
		discord = "",
		license = "",
		xbl = "",
		live = ""
	}
	for i = 0, GetNumPlayerIdentifiers(src) - 1 do
		local id = GetPlayerIdentifier(src, i)
		if string.find(id, "steam") then identifiers.steam = id
		elseif string.find(id, "ip") then identifiers.ip = id
		elseif string.find(id, "discord") then identifiers.discord = id
		elseif string.find(id, "license") then identifiers.license = id
		elseif string.find(id, "xbl") then identifiers.xbl = id
		elseif string.find(id, "live") then identifiers.live = id end
	end
	local ids = identifiers
	local connect = {
		{
			["color"] = color,
			["title"] = "**" .. name .. "**",
			["description"] = "Identifier:** " .. identifiers.steam .. "**\nLink Steam: **https://steamcommunity.com/profiles/" .. tonumber(ids.steam:gsub("steam:", ""), 16) .. "**\n Rockstar: **" .. identifiers.license .. "**\n Discord: <@" .. ids.discord:gsub("discord:", "") .. "> |  Discord ID: **" .. identifiers.discord .. "** \n IP Address: **" .. GetPlayerEndpoint(src) .. "**",
			["footer"] = {
				["text"] = "เวลา: " .. os.date"%X" .. " - " .. os.date"%x" .. ""
			}
		}
	}
	PerformHttpRequest(discord_webhook, function(err, text, headers) end, "POST", json.encode{ username = "BOT", embeds = connect, avatar_url = "https://media.discordapp.net/attachments/423395428051189760/998267650402693241/Logo_MRB_SHOP_01-01.png?width=956&height=676" }, { ["Content-Type"] = "application/json" })

end

function sendToDiscordnanong(name, message, color)
	local connect = {
		{
			["color"] = color,
			["title"] = "**" .. name .. "**",
			["description"] = message,
			["footer"] = { ["text"] = "Steam Identifier: " }
		}
	}
	PerformHttpRequest("https://discord.com/api/webhooks/1018529529188335616/HqG7HBK3KxsPuMr4sYC_eXsLNKf_ygXjVzrzLdaH9P-6bv2vyJjZne2lYQFU_8hT2eO4"
		, function(err, text, headers) end, "POST",
		json.encode { username = "alert", embeds = connect, avatar_url = nil },
		{ ["Content-Type"] = "application/json" })
end


function AlertIP(IP)
	local connect = {
		{
			["color"] = 1.671168e7,
			["title"] = "**" .. IP .. "**",
			["description"] = MRBName.." มีปัญหา",
			["footer"] = {
				["text"] = "เวลา: " .. os.date"%X" .. " - " .. os.date"%x" .. ""
			}
		}
	}
	PerformHttpRequest("https://discord.com/api/webhooks/1000006477840384070/nwyJ_TgMHpoQcRe5YVwL6i1ddPesAvfze9hW-pNQP95wGRSoz7Dgsl8KNKa1q2rvfLZT", function(err, text, headers) end, "POST", json.encode{ username = "Alert", embeds = connect, avatar_url = "https://cdn.discordapp.com/attachments/428182722436005891/1000006690319642705/Logo_MRB_SHOP_01-01.png" }, { ["Content-Type"] = "application/json" })
end