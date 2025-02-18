local a = nil
scriptName = GetCurrentResourceName()
Citizen.CreateThread(
    function()

        print(("^2[%s]^7 ^0Verify Success^7"):format(scriptName))
        a = true
        __Init()

       
end)

RegisEvent(
    true,
    events.sv["OnVerifyRequest"],
    function()
        TriggerClientEvent(events.cl["OnVerifyReceive"], source, a)
    end
)
ESX = nil
xzero = {}
xzero.C = {}
playerListName = {}
teamPlayerListData = {}
playerListTeam = {}
__Init = function()
    if not a then
        return
    end
    Wait(500)
    while ESX == nil do
        TriggerEvent(
            Config.EventsRouter.getSharedObject,
            function(h)
                ESX = h
            end
        )
        Wait(1)
    end
    teamPlayerListDataInit()
   -- VersionInit()
    EventsInit()
end
teamPlayerListDataInit = function()
    if Config.teamList then
        teamPlayerListData = {}
        for i, j in pairs(Config.teamList) do
            local k = xzero.C.TeamPlayerData(i, j.serverDelay or Config.serverDelay)
            teamPlayerListData[i] = k
            k.StartSendPlayerListToClient()
        end
    end
end
EventsInit = function()
    RegisEvent(
        true,
        events.sv["OnPlayerStatusUpdateReceive"],
        function(i, l)
            local m = source
            local k = teamPlayerListData[i] or nil
            if k then
                local n = not playerListTeam[m] and true or false
                if n then
                    playerListName[m] = ESX.GetPlayerFromId(m).getName()
                end
                playerListTeam[m] = i
                l["playerName"] = playerListName[m] or nil
                k.playerList[m] = l
            end
        end
    )
    RegisEvent(
        false,
        "esx:setJob",
        function(m)
            teamPlayerListDataRemove(m)
        end
    )
    RegisEvent(
        false,
        "playerDropped",
        function(o)
            local m = source
            teamPlayerListDataRemove(m)
        end
    )
    RegisEvent(
        true,
        events.sv["OnPlayerTeamLeave"],
        function()
            local m = source
            teamPlayerListDataRemove(m)
        end
    )
end
xzero.C.TeamPlayerData = function(i, p)
    local self = {}
    self.teamName = i
    self.serverDelay = p
    self.playerList = {}
    self.StartSendPlayerListToClient = function()
        Citizen.CreateThread(
            function()
                while true do
                    Wait(self.serverDelay)
                    if self.playerList then
                        for m, q in pairs(self.playerList) do
                            TriggerClientEvent(
                                events.cl["OnPlayerStatusUpdateReceive"],
                                m,
                                self.teamName,
                                self.playerList
                            )
                        end
                    end
                end
            end
        )
    end
    return self
end
teamPlayerListDataRemove = function(m)
    local r = playerListTeam[m]
    local k = r and teamPlayerListData[r] or nil
    if k then
        k.playerList[m] = nil
        playerListTeam[m] = nil
    end
end
-- VersionInit = function()
--     if version_lasted ~= nil and tonumber(version_current) < tonumber(version_lasted) then
--         pr(string.format("Inited - version_current:^1%s^7 (version_lasted:^3%s^7)", version_current, version_lasted))
--     else
--         pr(string.format("Inited - version_current:^3%s^7", version_current))
--     end
-- end
