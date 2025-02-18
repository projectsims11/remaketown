ESX = Setting['Framework']

for k,v in pairs(Setting['ItemBox']) do
	ESX.RegisterUsableItem(v.usebox, function(source)
		local xPlayer = ESX.GetPlayerFromId(source)

		local GetItemData = v["GiveItem"]
		for i=1, #GetItemData do
			if math.random(1, 100) <= GetItemData[i]["percent"] then
				local GetItemDataNum  = GetItemData[i]["item"]
				local GetCountItemDataNum  = GetItemData[i]["amount"]
				local GetType  = GetItemData[i]["type"]

				if GetType == 'money' then
					xPlayer.addMoney(GetCountItemDataNum)

					local txtmoney = 'ได้รับเงินเขียว จำนวน => '..GetCountItemDataNum.."\n"
					local sendToDiscord = ''..xPlayer.name..' '..txtmoney.."\n จากกล่อง >> "..v.usebox
					if Setting["Discord"]["Enable"] then
						Setting["Discord"]["DiscordLog"](xPlayer.source,sendToDiscord)
					else
						DC_Log(xPlayer, sendToDiscord)
					end
				elseif GetType == 'black_money' then
					xPlayer.addAccountMoney('black_money', GetCountItemDataNum)

					local txtmoney = 'ได้รับเงินแดง จำนวน => '..GetCountItemDataNum.."\n"
					local sendToDiscord = ''..xPlayer.name..' '..txtmoney.."\n จากกล่อง >> "..v.usebox
					if Setting["Discord"]["Enable"] then
						Setting["Discord"]["DiscordLog"](xPlayer.source,sendToDiscord)
					else
						DC_Log(xPlayer, sendToDiscord)
					end
				elseif GetType == 'vehicle' then
					local hash = GetItemDataNum
					GiveVehicle(ESX,source, hash)

					local txtveh = 'ได้รับรถ : '..GetItemDataNum..' จำนวน => '..GetCountItemDataNum.."\n"
					local sendToDiscord = ''..xPlayer.name..' '..txtveh.."\n จากกล่อง >> "..v.usebox
					if Setting["Discord"]["Enable"] then
						Setting["Discord"]["DiscordLog"](xPlayer.source,sendToDiscord)
					else
						DC_Log(xPlayer, sendToDiscord)
					end
				elseif GetType == 'weapon' then
					if string.find(string.upper(GetItemDataNum), "WEAPON_", 1) ~= nil then
						xPlayer.addWeapon(string.upper(GetItemDataNum), GetCountItemDataNum)

						local txtweapon = 'ได้รับอาวุธ : '..ESX.GetWeaponLabel(GetItemDataNum)..' จำนวน => '..GetCountItemDataNum.."\n"
						local sendToDiscord = ''..xPlayer.name..' '..txtweapon.."\n จากกล่อง >> "..v.usebox
						if Setting["Discord"]["Enable"] then
							Setting["Discord"]["DiscordLog"](xPlayer.source,sendToDiscord)
						else
							DC_Log(xPlayer, sendToDiscord)
						end
					end
				elseif GetType == 'item' then
					xPlayer.addInventoryItem(GetItemDataNum, GetCountItemDataNum)

					local txtitem = 'ได้รับ : '..ESX.GetItemLabel(GetItemDataNum)..' จำนวน => '..GetCountItemDataNum.."\n"
					local sendToDiscord = ''..xPlayer.name..' '..txtitem.."\n จากกล่อง >> "..v.usebox
					if Setting["Discord"]["Enable"] then
						Setting["Discord"]["DiscordLog"](xPlayer.source,sendToDiscord)
					else
						DC_Log(xPlayer, sendToDiscord)
					end
				end
			end
		end
		xPlayer.removeInventoryItem(v.usebox, v.remove)
	end)
end

function DC_Log(xPlayer, textlog)
    local R = Setting["Discord"];
    Citizen.CreateThread(function()
        local S = {
			username = ''..GetCurrentResourceName()..'',
			avatar_url = Setting["Discord"]['BotLogo'],
            embeds = {
                {
                    color = 0x08F896,
                    title = "Fewthz_GIFTBOX",
                    description = '`'..textlog..'`',
                    footer = {
                        text = ('เวลา: %s'):format(os.date('%d/%m/%Y | %H:%M:%S',os.time()))
                    }
                }
            }
        }
        PerformHttpRequest(R.Webhook, function(g, h, i) end, 'POST', json.encode(S), {['Content-Type'] = 'application/json'})
    end)
end

local NumberCharset = {}
local Charset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GetRandomNumber(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end