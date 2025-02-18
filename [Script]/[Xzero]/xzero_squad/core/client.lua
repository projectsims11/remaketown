local a = nil
RegisEvent(
    true,
    events.cl["OnVerifyReceive"],
    function(b)
        a = b
    end
)
Citizen.CreateThread(
    function()
        local c = GetGameTimer()
        while a == nil and GetGameTimer() - c <= 30 * 1000 do
            TriggerServerEvent(events.sv["OnVerifyRequest"])
            Wait(300)
        end
        __Init()
    end
)
ESX = nil
xzero = {}
xzero.C = {}
isEnabled = true
configMyTeam = nil
myPlayerJob = nil
myPlayerCoordsLasted = nil
myPlayerSirenStatusLasted = nil
myPlayerClearMemoryDelay = 10 * 1000
myPlayerClearMemoryTime = nil
playerListStatus = {}
_cachcePlayerListStatus = {}
__Init = function()
    if not a then
        print("^1Verify:ERROR^7")
        return
    end
    Wait(500)
    ESXGetDataInit()
    print(("Inited - version_current:^3%s^7"):format(version_current))
    EventsInit()
end
EventsInit = function()
    RegisEvent(
        true,
        "esx:setJob",
        function(d)
            myPlayerJob = d
            configMyTeam = myPlayerJob and myPlayerJob.name and Config.teamList[myPlayerJob.name] or nil
            BlipClearAll()
            Wait(100)
            myPlayerStatusUpdate(getSirenStatus())
        end
    )
    RegisEvent(
        true,
        events.cl["OnPlayerStatusUpdateReceive"],
        function(e, f)
            myPlayerStatusClearMemory()
            if not isEnabled or not configMyTeam or not myPlayerJob or myPlayerJob.name ~= e then
                BlipClearAll()
                return
            end
            BlipClearOutList(f)
            local g = #playerListStatus
            for h, i in pairs(f) do
                local j = _cachcePlayerListStatus[h] or nil
                if j then
                    j.blipSetup(i.coords, i.sirenStatus)
                else
                    local k = xzero.C.PlayerStatus(e, h, i.playerName, configMyTeam)
                    k.blipSetup(i.coords, i.sirenStatus)
                    g = g + 1
                    playerListStatus[g] = k
                end
            end
        end
    )
    Citizen.CreateThread(
        function()
            while true do
                Wait(50)
                if isEnabled and configMyTeam and configMyTeam.enabled then
                    local l = PlayerPedId()
                    local m = GetEntityCoords(l)
                    local n = myPlayerCoordsLasted and #(m - myPlayerCoordsLasted) or 0
                    local o = getSirenStatus()
                    local p = (myPlayerSirenStatusLasted == nil or myPlayerSirenStatusLasted ~= o) and true or false
                    if p then
                        myPlayerSirenStatusLasted = o
                    end
                    if myPlayerCoordsLasted == nil or n >= Config.clientDistance or p then
                        myPlayerStatusUpdate(o)
                        Wait(configMyTeam.clientDelay or Config.clientDelay)
                    end
                else
                    Wait(500)
                end
            end
        end
    )
    RegisEvent(
        true,
        events.cl["OnSquadSetEnabled"],
        function(i)
            isEnabled = i or false
            if isEnabled then
                myPlayerStatusUpdate(getSirenStatus())
            else
                Wait(300)
                BlipClearAll()
                TriggerServerEvent(events.sv["OnPlayerTeamLeave"])
            end
        end
    )
    RegisEvent(
        false,
        "esx:onPlayerDeath",
        function()
            if not configMyTeam or configMyTeam.playerDeathShow then
                return
            end
            TriggerEvent(events.cl["OnSquadSetEnabled"], false)
        end
    )
    RegisEvent(
        false,
        "playerSpawned",
        function()
            if isEnabled or not configMyTeam then
                return
            end
            TriggerEvent(events.cl["OnSquadSetEnabled"], true)
        end
    )
end
myPlayerStatusUpdate = function(o)
    if isEnabled and configMyTeam and configMyTeam.enabled then
        myPlayerCoordsLasted = GetEntityCoords(PlayerPedId())
        TriggerServerEvent(
            events.sv["OnPlayerStatusUpdateReceive"],
            myPlayerJob.name,
            {coords = myPlayerCoordsLasted, sirenStatus = o}
        )
        return true
    end
    return false
end
myPlayerStatusClearMemory = function()
    local q = myPlayerClearMemoryTime and GetGameTimer() - myPlayerClearMemoryTime or nil
    if not q or q >= myPlayerClearMemoryDelay then
        myPlayerClearMemoryTime = GetGameTimer()
        collectgarbage()
    end
end
getSirenStatus = function()
    local l = PlayerPedId()
    local r = GetVehiclePedIsIn(l, false)
    if r and r > 0 then
        local s = GetPedInVehicleSeat(r, -1)
        local t = s == l and IsVehicleSirenOn(r) or false
        return t
    end
    return false
end
xzero.C.PlayerStatus = function(e, h, u, v)
    local self = {}
    self.teamName = e
    self.playerSvId = h
    self.playerName = u
    self.coords = nil
    self.sirenStatus = nil
    self.configTeam = v
    self.blipIsCreate = false
    self.blipNormal = nil
    self.blipSiren = nil
    self.blipSetup = function(w, x)
        self.coords = w
        self.sirenStatus = x
        if not self.coords then
            return
        end
        self.blipNormalSetup()
        self.blipSirenSetup()
    end
    self.blipNormalSetup = function()
        if self.blipNormal then
            SetBlipCoords(self.blipNormal, self.coords.x, self.coords.y, self.coords.z)
        else
            self.blipNormal =
                BlipCreate(
                self.coords,
                self.configTeam.BlipSprite,
                self.configTeam.BlipScale,
                self.configTeam.BlipColour,
                ("%s - %s [%s]"):format(self.configTeam.label, self.playerName, self.playerSvId)
            )
        end
    end
    self.blipSirenSetup = function()
        if not self.sirenStatus and self.blipSiren then
            RemoveBlip(self.blipSiren)
            self.blipSiren = nil
        elseif self.sirenStatus and self.blipSiren then
            SetBlipCoords(self.blipSiren, self.coords.x, self.coords.y, self.coords.z)
        elseif self.sirenStatus and not self.blipSiren then
            self.blipSiren =
                BlipCreate(self.coords, 161, 0.8, 1, ("%s - %s [Siren]"):format(self.configTeam.label, self.playerName))
        end
    end
    self.blipClear = function()
        for y, z in ipairs({"blipNormal", "blipSiren"}) do
            if self[z] then
                RemoveBlip(self[z])
                self[z] = nil
            end
        end
    end
    return self
end
getPlayerStatusInList = function(h)
    local A = #playerListStatus
    if A > 0 then
        for B = 1, A do
            if playerListStatus[B].playerSvId == h then
                return playerListStatus[B]
            end
        end
    end
    return nil
end
BlipCreate = function(w, C, D, E, F)
    local G = AddBlipForCoord(w.x, w.y, w.z)
    SetBlipSprite(G, C)
    SetBlipScale(G, D)
    SetBlipColour(G, E)
    if F ~= nil then
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(F)
        EndTextCommandSetBlipName(G)
    end
    return G
end
BlipClearAll = function()
    local A = #playerListStatus
    if A > 0 then
        for B = 1, A do
            playerListStatus[B].blipClear()
        end
    end
    playerListStatus = {}
    _cachcePlayerListStatus = {}
end
BlipClearOutList = function(f)
    local g = 0
    local H = {}
    local I = 0
    _cachcePlayerListStatus = {}
    if #playerListStatus > 0 then
        for B = 1, #playerListStatus do
            g = g + 1
            local j = playerListStatus[B]
            if f[j.playerSvId] then
                _cachcePlayerListStatus[j.playerSvId] = j
            else
                j.blipClear()
                I = I + 1
                H[I] = g
            end
        end
    end
    if #H > 0 then
        for y, J in ipairs(H) do
            table.remove(playerListStatus, J)
        end
    end
end
ESXGetDataInit = function()
    while ESX == nil do
        TriggerEvent(
            Config.EventsRouter.getSharedObject,
            function(K)
                ESX = K
            end
        )
        Wait(200)
    end
    while ESX.GetPlayerData() == nil and ESX.GetPlayerData().job == nil do
        Wait(200)
    end
    myPlayerJob = ESX.GetPlayerData().job
    configMyTeam = myPlayerJob.name and Config.teamList[myPlayerJob.name] or nil
end
