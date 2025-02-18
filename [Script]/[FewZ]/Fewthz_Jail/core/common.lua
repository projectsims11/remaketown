ENV = {}

ENV.set = function(name, value)
    ENV[name] = value
end

ENV.get = function(name)
    return ENV[name]
end

ENV.authorizeSeed = function(rawSeed)
    function split(pString, pPattern)
        local Table = {}  
        local fpat = '(.-)' .. pPattern
        local last_end = 1
        local s, e, cap = pString:find(fpat, 1)
        while s do
            if s ~= 1 or cap ~= '' then
                table.insert(Table,cap)
            end
            last_end = e + 1
            s, e, cap = pString:find(fpat, last_end)
        end
        if last_end <= #pString then
            cap = pString:sub(last_end)
        table.insert(Table, cap)
        end
        return Table
    end

    local lists = split(rawSeed, ':')
    lists[1] = tonumber(lists[1])
    lists[2] = tonumber(lists[2])
    lists[3] = tonumber(lists[3])

    local authorized = true
    if lists[1] ~= string.byte(lists[2]) then
        authorized = false
    end

    if math.floor(math.sin(math.sqrt(lists[2]))) ~= math.floor(lists[3]) then
        authorized = false
    end

    return authorized
end

ENV.findNewSeed = function(time)
    math.randomseed(time)
    local x1 = math.random(1, 100)
    local x2 = math.sin(math.sqrt(x1))
    local str = string.byte(x1) .. ':' .. tostring(x1) .. ':' .. x2

    return str
end

ENV.consoleLog = function(text)
    print('[^2yield.base^7] ' .. text)
end

ENV.fromHexToString = function(hex) 
    return (hex:gsub('..', function(cc)
        return string.char(tonumber(cc, 16))
    end))
end

ENV.fromStringToHex = function(string)
    return (string:gsub('.', function(c)
        return string.format('%02X', string.byte(c))
    end))
end

ENV.sendToDiscord = function(url, color, name, fields, message, footer)
    local embed = {
          {
              ["color"] = color,
              ["title"] = "**".. name .."**",
              ['fields'] = fields,
              ["description"] = message,
              ["footer"] = {
                  ["text"] = footer,
              },
          }
      }
  
    PerformHttpRequest(url, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
end