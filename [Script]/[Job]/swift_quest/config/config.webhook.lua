webhook = {}
webhook.logs = ""

webhook.onClaim = function(playerId, taskId, taskData, rewardLabel)
    local playerName = "Unknown"
    if config.framework == "esx" then
        local xPlayer = ESX.GetPlayerFromId(playerId)
        playerName = (xPlayer and xPlayer.getName()) or GetPlayerName(playerId) or playerId
    else
        playerName = GetPlayerName(playerId) or playerId
    end

    local payload = {{
        title = "ผู้เล่นทำเควสสำเร็จ",
        color = 5814783,
        fields = {{
            name = "ชื่อ",
            value = playerName,
            inline = true
        },{
            name = "Identifier",
            value = GetPlayerIdentifierByType(playerId, "steam") or "ไม่พบ Identifier",
            inline = true
        }, {
            name = "TaskID",
            value = tostring(taskId),
            inline = true
        }, {
            name = "รับของรางวัล",
            value = string.format("```\n%s\n```", rewardLabel or "ไม่ได้รับของรางวัล")
        }}
    }}

    PerformHttpRequest(webhook.logs, nil, 'POST', json.encode({
        embeds = payload
    }), {
        ['Content-Type'] = 'application/json'
    })
end
