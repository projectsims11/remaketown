ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local timers = { -- if you want more job shifts add table entry here same as the examples below
    ambulance = {
        {} -- don't edit inside
    },
    police = {
        {} -- don't edit inside
    },
    mechanic = {
        {} -- don't edit inside
    },
}
local dcname = Config.botname -- bot's name
local avatar = Config.image -- bot's avatar

function DiscordLog(name, message, color, job)
    local connect = {
        {
            ["color"] = color,
            ["title"] = "**".. name .."**",
            ["description"] = message,
            ["footer"] = {
                --["text"] = "Duty Log",
            },
        }
    }
    if job == "police" then
        PerformHttpRequest(Config.webhook_police, function(err, text, headers) end, 'POST', json.encode({username = dcname, embeds = connect, avatar_url = avatar}), { ['Content-Type'] = 'application/json' })
    elseif job == "ambulance" then
        PerformHttpRequest(Config.webhook_ems, function(err, text, headers) end, 'POST', json.encode({username = dcname, embeds = connect, avatar_url = avatar}), { ['Content-Type'] = 'application/json' })
    elseif job == "mechanic" then
        PerformHttpRequest(Config.webhook_mc, function(err, text, headers) end, 'POST', json.encode({username = dcname, embeds = connect, avatar_url = avatar}), { ['Content-Type'] = 'application/json' })
    end
end

RegisterServerEvent("utk_sl:userjoined")
AddEventHandler("utk_sl:userjoined", function(job)
    local id = source
    local xPlayer = ESX.GetPlayerFromId(id)

    table.insert(timers[job], {id = id, identifier = xPlayer.identifier, name = xPlayer.name, time = os.time(), date = os.date("%d/%m/%Y %X")})
end)

RegisterServerEvent("utk_sl:jobchanged")
AddEventHandler("utk_sl:jobchanged", function(old, new, method)
    local xPlayer = ESX.GetPlayerFromId(source)
    local header = nil
    local color = nil

    if old == "police" then
        header = "Police duty" -- Header
        color = 3447003 -- Color
    elseif old == "ambulance" then
        header = "EMS duty"
        color = 15158332
    elseif old == "mechanic" then
        header = "MC duty"
        color = 15158332
    end
    if method == 1 then
        for i = 1, #timers[old], 1 do
            if timers[old][i].identifier == xPlayer.identifier then
                local duration = os.time() - timers[old][i].time
                local date = timers[old][i].date
                local timetext = nil
                -- local playerId = PlayerId()
                -- local source = GetPlayerServerId(playerId)

                -- if duration % 2 == 0 then -- quest
                    
                --     exports.swift_quest:AddPoint(source, 4, 1) 
                -- end    

                if duration > 0 and duration < 60 then
                    timetext = tostring(math.floor(duration)).." วินาที"
                elseif duration >= 60 and duration < 3600 then
                    timetext = tostring(math.floor(duration / 60)).." นาที"
                elseif duration >= 3600 then
                    timetext = tostring(math.floor(duration / 3600).." ชั่วโมง, "..tostring(math.floor(math.fmod(duration, 3600)) / 60)).." นาที"
                end
                DiscordLog(header , "ชื่อ: **"..timers[old][i].name.."**\nSteam : **"..timers[old][i].identifier.."**\n Stream Name : "..GetPlayerName(source).."**\n เวลาในการทำงาน: **__"..timetext.."__**\n เริ่มทำงานเวลา: **"..date.."**\n ออกงานเวลา: **"..os.date("%d/%m/%Y %X").."", color, old)
                table.remove(timers[old], i)
                break
            end
        end
    end
    if not (timers[new] == nil) then
        for t, l in pairs(timers[new]) do
            if l.id == xPlayer.source then
                table.remove(table[new], l)
            end
        end
    end
    if new == "police" or new == "ambulance" or new == "mechanic" then
        table.insert(timers[new], {id = xPlayer.source, identifier = xPlayer.identifier, name = xPlayer.name, time = os.time(), date = os.date("%d/%m/%Y %X")})
    end
end)

AddEventHandler("playerDropped", function(reason)
    local id = source
    local header = nil
    local color = nil

    for k, v in pairs(timers) do
        for n = 1, #timers[k], 1 do
            if timers[k][n].id == id then
                local duration = os.time() - timers[k][n].time
                local date = timers[k][n].date
                local timetext = nil

                if k == "police" then
                    header = "Police duty"
                    color = 3447003
                elseif k == "ambulance" then
                    header = "EMS duty"
                    color = 15158332
                elseif k == "mechanic" then
                    header = "MC duty"
                    color = 15158332
                end
                if duration > 0 and duration < 60 then
                    timetext = tostring(math.floor(duration)).." วินาที"
                elseif duration >= 60 and duration < 3600 then
                    timetext = tostring(math.floor(duration / 60)).." นาที"
                elseif duration >= 3600 then
                    timetext = tostring(math.floor(duration / 3600).." ชั่วโมง, "..tostring(math.floor(math.fmod(duration, 3600)) / 60)).." นาที"
                end
                DiscordLog(header, "ชื่อ: **"..timers[k][n].name.."**\nSteam : **"..timers[k][n].identifier.."**\n Stream Name : "..GetPlayerName(source).."**\n เวลาในการทำงาน: **__"..timetext.."__**\n เริ่มทำงานเวลา: **"..date.."**\n ออกงานเวลา: **"..os.date("%d/%m/%Y %X").."", color, k)
                table.remove(timers[k], n)
                return
            end
        end
    end
end)

DiscordLog("[Duty Log Police]", "Log ตรวจสอบการเข้าเวรออกเวร Police", 15958332, "police")
DiscordLog("[Duty Log ambulance]", "Log ตรวจสอบการเข้าเวรออกเวร ambulance", 15958332, "ambulance")
DiscordLog("[Duty Log mechanic]", "Log ตรวจสอบการเข้าเวรออกเวร mechanic", 15958332, "mechanic")