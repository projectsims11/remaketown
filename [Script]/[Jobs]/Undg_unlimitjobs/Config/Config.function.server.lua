DiscordLogs = function(data) 
    local link = ''
    PerformHttpRequest(link, function(err, text, headers) 
    end, 'POST', json.encode({username = "UNDERGROUND LOG", embeds = data, avatar_url = 'https://cdn.discordapp.com/attachments/1250733331763695626/1253301979611009034/Untitled-1.png?ex=66828aed&is=6681396d&hm=0b57b5a4d3a667d8995929302b3be690c2415948784910cf14798694d6d5d886&'}), { ['Content-Type'] = 'application/json' })
end

function ExtractIdentifiers(source)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    for i = 0, GetNumPlayerIdentifiers(source) - 1 do
        local id = GetPlayerIdentifier(source, i)
        
        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end

    return identifiers
end

function removeUnwantedChars(inputString)
    local cleanedString = string.gsub(inputString, "vec3", "") 
    cleanedString = string.gsub(cleanedString, "%(", "") 
    cleanedString = string.gsub(cleanedString, "%)", "") 
    cleanedString = string.gsub(cleanedString, ",", "") 
    return cleanedString
end
