webhook = {}
webhook.jailLogs = ""

---@param xPlayer table ของคนทำคดี (หาก system = true จะเข้าถึงได้แค่ xPlayer.name, xPlayer.identifier เท่านั้น)
---@param targetXPlayer table ของผู้ถูกทำคดี
---@param time number ระยะเวลาเป็นหน่วยนาที
---@param fine number บิล
---@param summary string คดี
---@param system boolean ถูกเจลโดยระบบหรือไม่
webhook.onJailed = function(xPlayer, targetXPlayer, time, fine, summary, system)
    if #webhook.jailLogs <= 0 then return end

    local embedData = {{
        ['color'] = 14423100,
        ['footer'] = {
            ['text'] = "nnaridz_discordlogs | " .. os.date()
        },
        ['description'] = ("```\n%s ถูกจำคุก เป็นเวลา %s นาที และถูกปรับเป็นจำนวน %s$\n```\n```\n%s\n```\n**ข้อมูลคนทำคดี**\nชื่อ: %s\nIdentifier: %s"):format(targetXPlayer.name, time, fine, summary, xPlayer.name, xPlayer.identifier)
    }}

    PerformHttpRequest(webhook.jailLogs, nil, 'POST', json.encode({
        embeds = embedData
    }), {
        ['Content-Type'] = 'application/json'
    })
end