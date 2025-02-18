Config = {}

-- Events Router
Config.EventsRouter = {
    getSharedObject = "esx:getSharedObject"
}

Config.clientDistance = 5.0
Config.clientDelay = 10000
Config.serverDelay = 60000

Config.teamList = {
    ["police"] = {
        enabled = true,
        label = "[POLICE]",
        BlipSprite = 1,
        BlipScale = 1.0,
        BlipColour = 18,
        clientDelay = 500,
        serverDelay = 500,
        playerDeathShow = false
    },
    ["ambulance"] = {
        enabled = true,
        label = "[EMS]",
        BlipSprite = 1,
        BlipScale = 1.0,
        BlipColour = 34,
        clientDelay = 500,
        serverDelay = 500,
        playerDeathShow = false
    },
    ["mechanic"] = {
        enabled = true,
        label = "[Mechanic]",
        BlipSprite = 1,
        BlipScale = 1.0,
        BlipColour = 44,
        clientDelay = 500,
        serverDelay = 500,
        playerDeathShow = false
    }
}