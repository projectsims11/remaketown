Core = nil
local Ladders = {}
-- ██████╗  ██████╗ ██╗  ██╗   ██╗    ██╗     ███████╗ █████╗ ██╗  ██╗███████╗ 
-- ██╔══██╗██╔═══██╗██║  ╚██╗ ██╔╝    ██║     ██╔════╝██╔══██╗██║ ██╔╝██╔════╝ 
-- ██████╔╝██║   ██║██║   ╚████╔╝     ██║     █████╗  ███████║█████╔╝ ███████╗ 
-- ██╔═══╝ ██║   ██║██║    ╚██╔╝      ██║     ██╔══╝  ██╔══██║██╔═██╗ ╚════██║ 
-- ██║     ╚██████╔╝███████╗██║       ███████╗███████╗██║  ██║██║  ██╗███████║ 
-- ╚═╝      ╚═════╝ ╚══════╝╚═╝       ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝ 
-- [discord.gg/gaJJjnKGpg] 
Citizen.CreateThread(function()
    Core = GetCore()
end)


AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    for i = 1, 256 do
        local identifier = GetIdentifier(tonumber(i))
        if identifier then
            local lobby = coopData[identifier]
            if lobby then
                for ii = 1, #lobby.roomSetting.Vehicle do
                    local vehicle = lobby.roomSetting.Vehicle[ii]
                    if DoesEntityExist(vehicle) then
                        DeleteEntity(vehicle)
                    end
                    lobby.roomSetting.Vehicle[ii] = nil -- Clearing the vehicle reference
                end

                for ii = 1, #lobby.roomSetting.VehicleNetId do
                    local vehicle = lobby.roomSetting.VehicleNetId[ii]
                    if DoesEntityExist(vehicle) then
                        DeleteEntity(vehicle)
                    end
                    lobby.roomSetting.VehicleNetId[ii] = nil -- Clearing the vehicle reference
                end


                for _, player in ipairs(lobby.players) do
                    TriggerClientEvent('tworst-electrician:client:TakeLooby', tonumber(player["source"]))
                end
                coopData[identifier] = nil
                JoobTask[identifier] = nil
            end
        end
    end
end)


Citizen.CreateThread(function()
    local result = ExecuteSql("SELECT * FROM `tw_electrician`")
    for i = 1, #result do
        local playerData = result[i]
        local dataInfo = {
            profiledata = json.decode(playerData.profiledata),
        }
        if not playerJobData[playerData.identifier] then
            playerJobData[playerData.identifier] = dataInfo
        end
        playerJobData[playerData.identifier] = dataInfo
    end
end)

cooldowns = {}
coopData = {}
playerJobData = {}
JoobTask = {}


RegisterServerEvent('tw-electrician:loadData', function()
    local src = source
    loadElectricianData(src)
end)
function loadElectricianData(src)
    local identifier = GetIdentifier(src)
    local data = playerJobData[identifier]
    if not data then
        firsData(src, function()
            data = playerJobData[identifier]
        end)
    end
    playerJobData[identifier] = data
    playerJobData[identifier].source = src or source
    playerJobData[identifier].profiledata.avatar = GetDiscordAvatar(src) or Config.ExampleProfilePicture
    playerJobData[identifier].profiledata.name = GetName(src)
    playerJobData[identifier].profiledata.identifier = identifier
    Citizen.Wait(100)
    savePlayerData(src)
end

function firsData(src, callback)
    local identifier = GetIdentifier(src)

    if playerJobData[identifier] then
        return
    end

    local dataInfo = {
        identifier = identifier,
        profiledata = {
            ["xp"] = 0,
            ["level"] = 1,
            ['avatar'] = GetDiscordAvatar(src) or Config.ExampleProfilePicture,
            ['name'] = GetName(src),
            ['identifier'] = identifier,
        },
    }
    Citizen.Wait(100)
    playerJobData[identifier] = dataInfo
    ExecuteSql(
        'INSERT INTO tw_electrician (identifier, profiledata) VALUES (:identifier, :profiledata) ',
        {
            identifier = identifier,
            profiledata = json.encode(dataInfo.profiledata),
        }
    )
    callback()
end

function savePlayerData(src)
    local src = src
    local identifier = GetIdentifier(src)
    local data = playerJobData[identifier]
    if not data then
        return
    end
    ExecuteSql(
        'UPDATE tw_electrician SET profiledata = :profiledata WHERE identifier = :identifier',
        {
            identifier = identifier,
            profiledata = json.encode(data.profiledata)
        }
    )
end

Citizen.CreateThread(function()
    while Core == nil do
        Citizen.Wait(0)
    end
    RegisterCallback('tworst-electrician:server:getPlayerData', function(source, cb)
        local src = source
        local identifier = GetIdentifier(src)
        local data = playerJobData[identifier]
        local dataInfo = {
            playerMoney = GetPlayerMoney(src, 'bank'),
            playerName = data.profiledata.name,
            playerIdentifier = data.profiledata.identifier,
            playerImage = data.profiledata.avatar or Config.ExampleProfilePicture,
            playerLevel = data.profiledata.level,
            playerXp = data.profiledata.xp,
            playerNextXp = Config.RequiredXP[data.profiledata.level + 1] or 0,
            source = src
        }
        cb(dataInfo)
    end)

    RegisterCallback('tworst-electrician:server:getMissionsDetails', function(source, cb, data)
        if not data then return end
        local src = source
        local owneridentifier = data.owneridentifier
        local missionControl = data.missionControl
        local lobby = coopData[owneridentifier]
        if not lobby then return end
        if not lobby.roomSetting.startJob then return end
        if not JoobTask[owneridentifier] then return end
        if missionControl == 'trafoopen' then
            if lobby.roomSetting.openTrafo then
                cb(false)
            else
                lobby.roomSetting.openTrafo = true
                cb(true)
            end
        elseif missionControl == 'trafoclose' then
            if lobby.roomSetting.openTrafo then
                lobby.roomSetting.openTrafo = false
                cb(true)
            else
                cb(false)
            end
        elseif missionControl == 'housepanelopen' then
            if lobby.roomSetting.housePanel then
                cb(false)
            else
                lobby.roomSetting.housePanel = true
                cb(true)
            end
        elseif missionControl == 'housepanelclose' then
            if lobby.roomSetting.housePanel then
                lobby.roomSetting.housePanel = false
                cb(true)
            else
                cb(false)
            end
        end
    end)

    RegisterCallback('tworst-electrician:server:getVehicleData', function(source, cb, data)
        local src = source
        local hostidentifier = data
        local lobby = coopData[hostidentifier]
        if not lobby then return end
        local dataInfo = {
            Vehicle = lobby.roomSetting.Vehicle or {}
        }
        callbackNETID = NetworkGetNetworkIdFromEntity(dataInfo.Vehicle[1])
        cb(callbackNETID)
    end)



    RegisterCallback("tworst-electrician:server:HasItem", function(source, cb, item)
        cb(HasItem(source, item))
    end)

    RegisterCallback('tworst-electrician:server:CreatePlayerLobby', function(source, cb)
        local src = source
        local identifier = GetIdentifier(src)
        local data = playerJobData[identifier]
        if not data then
            return
        end
        if not coopData[identifier] then
            coopData[identifier] = {
                roomSetting = {
                    name            = "Electrician",
                    owneridentifier = identifier,
                    ownersrc        = src,
                    startJob        = false,
                    finishJob       = false,
                    carDelivered    = false,
                    liftCraft       = false,
                    ladderCraft     = false,
                    Area            = false,
                    Mission         = false,
                    openTrafo       = false,
                    housePanel      = false,
                    fixedTrafo      = {
                        [1] = false,
                        [2] = false,
                        [3] = false,
                        [4] = false
                    },
                    awards          = {
                        money = 0,
                        xp = 0
                    },
                    Vehicle         = {},
                    VehicleNetId    = {},
                },
                players = {
                    {
                        playerName = GetName(src),
                        playerIdentifier = identifier,
                        playerImage = GetDiscordAvatar(src) or Config.ExampleProfilePicture,
                        playerLevel = data.profiledata.level,
                        playerOwner = true,
                        source = src
                    }
                }
            }
        end
        cb(coopData[identifier].players)
    end)
    RegisterCallback('tworst-electrician:server:getSellMarketData', function(source, cb)
        local src = source
        local sellMarketData = Config.Electrician['Market']["SellItems"]
        local PlayerInventory = GetPlayerInventory(src)

        local data = {}

        local inventoryItems = {}
        for _, item in ipairs(PlayerInventory) do
            inventoryItems[item.name] = item.amount
        end

        for _, marketItem in ipairs(sellMarketData) do
            local itemName = marketItem.itemName
            if inventoryItems[itemName] then
                marketItem.itemCount = inventoryItems[itemName]
                marketItem.itemMaxValue = inventoryItems[itemName] or 0
            else
                marketItem.itemCount = 0
                marketItem.itemMaxValue = 0
            end
            table.insert(data, marketItem)
        end
        cb(data)
    end)
    RegisterCallback("tworst-electrician:canRemoveLift", function(source, cb, id)
        cb(CanPlayerLift(source, id))
    end)

    RegisterCallback("tworst-electrician:placeLadder", function(source, cb, data)
        cb(true)
        SetTimeout(3000, function()
            local index = nil
            repeat
                index = os.time() .. "_" .. math.random(1000, 9999)
            until not Ladders[index]
            Ladders[index] = data
            UpdateLadders(index)
        end)
    end)

    RegisterCallback("tworst-electrician:removeLadder", function(source, cb, data)
        local key = data.key
        local owneridentifier = data.owneridentifier
        local lobby = coopData[owneridentifier]
        if not lobby then return end
        if not Ladders[key] then return end
        Ladders[key] = nil
        cb(true)
        SetTimeout(2000, function()
            UpdateLadders(key)
            lobby.roomSetting.ladderCraft = false
            TriggerClientEvent("tworst-electrician:removeLadder", -1, key)
            for _, player in ipairs(lobby.players) do
                TriggerClientEvent('tworst-electrician:client:UpdateLobby', player.source, lobby, 'ladder')
            end
        end)
    end)
    RegisterCallback('tworst-electrician:server:getTrafoModal', function(source, cb, data)
        if not data then return end
        local src = source
        local owneridentifier = data.owneridentifier
        local missionName = data.missionName
        local lobby = coopData[owneridentifier]
        if not lobby then return end
        if not lobby.roomSetting.startJob then return end
        if not JoobTask[owneridentifier] then return end
        if missionName == 'fixHouseBoard' then
            for index, value in ipairs(lobby.roomSetting.Mission.regionhouseBoardCoords) do
                if value.coords.x == data.coords.x and value.coords.y == data.coords.y and value.coords.z == data.coords.z then
                    if value.open then
                        cb(false)
                    else
                        cb(true)
                    end
                end
            end
        elseif missionName == 'fixTrafo' then
            for index, value in ipairs(lobby.roomSetting.Mission.regionstreetTrafoCoords) do
                if value.coords.x == data.coords.x and value.coords.y == data.coords.y and value.coords.z == data.coords.z then
                    if value.open then
                        cb(false)
                    else
                        cb(true)
                    end
                end
            end
        elseif missionName == 'phonePole' then
            for index, value in ipairs(lobby.roomSetting.Mission.regionphonePoleCoords) do
                if value.coords.x == data.coords.x and value.coords.y == data.coords.y and value.coords.z == data.coords.z then
                    if value.open then
                        cb(false)
                    else
                        cb(true)
                    end
                end
            end
        elseif missionName == 'fixStreetLamp' then
            for index, value in ipairs(lobby.roomSetting.Mission.regionstreetLampCoords) do
                if value.coords.x == data.coords.x and value.coords.y == data.coords.y and value.coords.z == data.coords.z then
                    if value.open then
                        cb(false)
                    else
                        cb(true)
                    end
                end
            end
        end
    end)
end)


RegisterServerEvent('tworst-electrician:server:acceptInvite', function(data)
    local src = source
    local identifier = GetIdentifier(src)
    local playerData = playerJobData[identifier]
    local hostidentifier = data.hostIdentifier
    local lobby = coopData[hostidentifier]
    if not lobby then return end
    if lobby.roomSetting.startJob then
        TriggerClientEvent('tworst-electrician:client:sendNotification', src,
            Config.NotificationText['jobalreadystarted'].text,
            Config.NotificationText['jobalreadystarted'].type)
        return
    end
    for _, player in ipairs(lobby.players) do
        if player.identifier == identifier then
            TriggerClientEvent('tworst-electrician:client:sendNotification', src,
                Config.NotificationText['playeralreadyinlobby'].text,
                Config.NotificationText['playeralreadyinlobby'].type)
            return
        end
    end
    if #lobby.players >= 4 then
        TriggerClientEvent('tworst-electrician:client:sendNotification', src, Config.NotificationText['lobbyfull'].text,
            Config.NotificationText['lobbyfull'].type)
        return
    end
    if coopData[identifier] then
        coopData[identifier] = nil
    end
    table.insert(lobby.players, {
        playerName = playerData.profiledata.name,
        playerIdentifier = playerData.profiledata.identifier,
        playerImage = playerData.profiledata.avatar or Config.ExampleProfilePicture,
        playerLevel = playerData.profiledata.level,
        playerOwner = false,
        source = src
    })

    if tonumber(#lobby.players) ~= 1 then
        if lobby.roomSetting.Mission ~= false then
            if lobby.roomSetting.Mission.regionAwards.money then
                lobby.roomSetting.Mission.regionAwards.money = math.ceil(lobby.roomSetting.Mission.regionAwards.money *
                    lobby.roomSetting.Mission.regionAwards.onlineJobExtraAwards * #lobby.players)
            end
        end
    else
        if lobby.roomSetting.Mission ~= false then
            lobby.roomSetting.Mission.regionAwards.money = math.ceil(lobby.roomSetting.Mission.regionAwards.money)
        end
    end
    for _, player in ipairs(lobby.players) do
        TriggerClientEvent('tworst-electrician:client:RefreshLobby', player.source, coopData[hostidentifier])
    end
end)

RegisterServerEvent('tworst-electrician:server:firePlayer', function(data)
    local src = source
    local identifier = GetIdentifier(src)
    local playerData = playerJobData[identifier]
    local targetID = tonumber(data.targetID)
    local oldPlayerID
    if not targetID or not playerData then return end
    local targetIdentifier = GetIdentifier(targetID)
    if targetIdentifier ~= data.identifier then return end
    local lobby = coopData[identifier]
    if not lobby then return end
    for i, player in ipairs(lobby.players) do
        if player.playerIdentifier == targetIdentifier then
            oldPlayerID = tonumber(player.source)
            table.remove(lobby.players, i)
            break
        end
    end
    if tonumber(#lobby.players) ~= 1 then
        if lobby.roomSetting.Mission ~= false then
            lobby.roomSetting.Mission.regionAwards.money = math.ceil(lobby.roomSetting.Mission.regionAwards.money *
                lobby.roomSetting.Mission.regionAwards.onlineJobExtraAwards * #lobby.players)
        end
    else
        if lobby.roomSetting.Mission ~= false then
            lobby.roomSetting.Mission.regionAwards.money = lobby.roomSetting.Mission.regionAwards.oldmoney
        end
    end
    for _, player in ipairs(lobby.players) do
        TriggerClientEvent('tworst-electrician:client:RefreshLobby', player.source, coopData[identifier])
    end
    TriggerClientEvent('tworst-electrician:client:TakeLooby', oldPlayerID)
end)

RegisterServerEvent('tworst-electrician:server:invetePlayer', function(data)
    local src = source
    local identifier = GetIdentifier(src)
    local playerData = playerJobData[identifier]
    local targetID = tonumber(data.targetID)
    if not targetID or not playerData then return end
    local targetIdentifier = GetIdentifier(targetID)
    local targetPlayer = playerJobData[targetIdentifier]
    if not targetPlayer then return end
    local lobby = coopData[identifier]
    if not lobby then return end
    if not targetPlayer then return end
    if src == targetID then return end
    local distance = #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(targetID)))
    if math.floor(distance) > 8.0 then
        TriggerClientEvent('tworst-electrician:client:sendNotification', src,
            Config.NotificationText['playerfaraway'].text,
            Config.NotificationText['playerfaraway'].type)
        return
    end

    for _, player in ipairs(lobby.players) do
        if player.playerIdentifier == targetPlayer.profiledata.playerIdentifier then
            TriggerClientEvent('tworst-electrician:client:sendNotification', src,
                Config.NotificationText['playeralreadyinlobby'].text,
                Config.NotificationText['playeralreadyinlobby'].type)
            return
        end
    end
    if #lobby.players >= 4 then
        TriggerClientEvent('tworst-electrician:client:sendNotification', src, Config.NotificationText['lobbyfull'].text,
            Config.NotificationText['lobbyfull'].type)
        return
    end
    TriggerClientEvent('tworst-electrician:client:invetePlayer', targetID, playerData.profiledata.name, identifier,
        playerData.profiledata.source or src)
end)

RegisterServerEvent('tworst-electrician:server:selectMission', function(data)
    local src = source
    if cooldowns[src] and (os.time() - cooldowns[src] < 1) then
        print('cooldown')
        return
    end
    cooldowns[src] = os.time()
    local identifier = GetIdentifier(src)
    local playerData = playerJobData[identifier]
    local lobby = coopData[identifier]
    if not lobby then return end
    if lobby.roomSetting.startJob then
        TriggerClientEvent('tworst-electrician:client:sendNotification', src,
            Config.NotificationText['jobalreadystarted'].text,
            Config.NotificationText['jobalreadystarted'].type)
        return
    end
    if data == false then
        lobby.roomSetting.Mission = false
        for _, player in ipairs(lobby.players) do
            TriggerClientEvent('tworst-electrician:client:RefreshLobby', player.source, coopData[identifier])
        end
        return
    else
        if lobby.roomSetting.Mission ~= false then
            lobby.roomSetting.Mission = false
        end
        for k, v in pairs(Config.Electrician['regionData']) do
            if v.regionKey == data.regionKey then
                lobby.roomSetting.Mission = data
                break
            end
        end
    end

    if not lobby.roomSetting.Mission then
        lobby.roomSetting.Mission = false
        return
    end

    if tonumber(#lobby.players) ~= 1 then
        lobby.roomSetting.Mission.regionAwards.oldmoney = lobby.roomSetting.Mission.regionAwards.money
        lobby.roomSetting.Mission.regionAwards.money = math.ceil(lobby.roomSetting.Mission.regionAwards.money *
            lobby.roomSetting.Mission.regionAwards.onlineJobExtraAwards * #lobby.players)
    end
    for _, player in ipairs(lobby.players) do
        TriggerClientEvent('tworst-electrician:client:RefreshLobby', player.source, coopData[identifier])
    end
end)

RegisterServerEvent('tworst-electrician:server:startJob', function(data)
    local src = source
    local identifier = GetIdentifier(src)
    local playerData = playerJobData[identifier]
    local lobby = coopData[identifier]
    if not lobby then return end

    if lobby.roomSetting.startJob then
        TriggerClientEvent('tworst-electrician:client:sendNotification', src,
            Config.NotificationText['jobalreadystarted'].text,
            Config.NotificationText['jobalreadystarted'].type)
        return
    end

    if lobby.roomSetting.Mission == false then
        TriggerClientEvent('tworst-electrician:client:sendNotification', src,
            Config.NotificationText['missionnotselected'].text,
            Config.NotificationText['missionnotselected'].type)
        return
    end

    if #lobby.players > 4 then
        return
    end

    for _, player in ipairs(lobby.players) do
        TriggerClientEvent('tworst-electrician:client:RefreshLobby', player.source, coopData[identifier])
    end
    lobby.roomSetting.owneridentifier = identifier
    lobby.roomSetting.ownersrc = src
    lobby.roomSetting.startJob = true
    lobby.roomSetting.regionAwards = data.regionAwards
    JoobTask[identifier] = {
        Players = {},
        regionJobTask = {}
    }

    for jobdata, __ in ipairs(data.regionJobTask) do
        local jobtasktable = {
            jobName = data.regionJobTask[jobdata].jobName,
            jobCount = data.regionJobTask[jobdata].jobCount,
            jobLabel = data.regionJobTask[jobdata].jobLabel,
            madeAmount = 0,
            img = data.regionJobTask[jobdata].img or Config.ExampleProfilePicture,
            finish = false
        }
        table.insert(JoobTask[identifier].regionJobTask, jobtasktable)
    end

    for _, player in ipairs(lobby.players) do
        local playerData = playerJobData[player.playerIdentifier]
        local jobtaskPlayer = {
            playerIdentifier = playerData.profiledata.identifier,
            playerLevel = playerData.profiledata.level,
            playerName = playerData.profiledata.name,
            playerImage = playerData.profiledata.avatar or Config.ExampleProfilePicture,
            scoreAmount = 0,
            source = player.source
        }
        table.insert(JoobTask[identifier].Players, jobtaskPlayer)
    end

    local jobVehicle = CreateVehicle(GetHashKey(Config.Electrician['jobVehicle']),
        lobby.roomSetting.Mission.regionSpawnCoords[1].x,
        lobby.roomSetting.Mission.regionSpawnCoords[1].y,
        lobby.roomSetting.Mission.regionSpawnCoords[1].z,
        lobby.roomSetting.Mission.regionSpawnCoords[1].w, true, true)

    while not DoesEntityExist(jobVehicle) do
        Wait(0)
    end

    table.insert(lobby.roomSetting.Vehicle, jobVehicle)
    local netID = NetworkGetNetworkIdFromEntity(jobVehicle)
    table.insert(lobby.roomSetting.VehicleNetId, netID)
    local plate = GetVehicleNumberPlateText(jobVehicle)
    lobby.roomSetting.Mission.regionJobVehiclePlate = plate

    Wait(200)

    if #lobby.players > 2 and Config.Electrician['jobVehicle2'].jobVehicle2 then
        local jobVehicle2 = CreateVehicle(GetHashKey(Config.Electrician['jobVehicle2'].vehicleName),
            lobby.roomSetting.Mission.regionSpawnCoords[2].x,
            lobby.roomSetting.Mission.regionSpawnCoords[2].y,
            lobby.roomSetting.Mission.regionSpawnCoords[2].z,
            lobby.roomSetting.Mission.regionSpawnCoords[2].w, true, true)

        while not DoesEntityExist(jobVehicle2) do
            Wait(0)
        end

        table.insert(lobby.roomSetting.Vehicle, jobVehicle2)
        local netID = NetworkGetNetworkIdFromEntity(jobVehicle2)
        table.insert(lobby.roomSetting.VehicleNetId, netID)
    end

    for index, value in ipairs(lobby.roomSetting.Mission.regionJobTask) do
        if value.jobName == 'fixTrafo' then
            local streetTrafo = {}
            local randomCoords = lobby.roomSetting.Mission.regionstreetTrafoCoords
            local selectedCoords = selectRandomCoords(randomCoords, tonumber(value.jobCount))
            for _, coord in ipairs(selectedCoords) do
                table.insert(streetTrafo, coord)
            end
            lobby.roomSetting.Mission.regionstreetTrafoCoords = streetTrafo
        elseif value.jobName == 'fixHouseBoard' then
            local houseBoardData = {}
            local randomCoords = lobby.roomSetting.Mission.regionhouseBoardCoords
            local selectedCoords = selectRandomCoords(randomCoords, tonumber(value.jobCount))
            for _, coord in ipairs(selectedCoords) do
                table.insert(houseBoardData, coord)
            end
            lobby.roomSetting.Mission.regionhouseBoardCoords = houseBoardData
        elseif value.jobName == 'fixTrafficLamp' then
            local trafficData = {}
            local randomCoords = lobby.roomSetting.Mission.regiontrafficLampCoords
            local selectedCoords = selectRandomCoords(randomCoords, tonumber(value.jobCount))
            for _, coord in ipairs(selectedCoords) do
                table.insert(trafficData, coord)
            end
            lobby.roomSetting.Mission.regiontrafficLampCoords = trafficData
            local totaltraficprops = 0
            for index, value in ipairs(lobby.roomSetting.Mission.regiontrafficLampCoords) do
                totaltraficprops = totaltraficprops + #value.regionTrafficCoords
            end
            JoobTask[identifier].regionJobTask[index].jobCount = totaltraficprops
        elseif value.jobName == 'fixStreetLamp' then
            local streetData = {}
            local randomCoords = lobby.roomSetting.Mission.regionstreetLampCoords
            local selectedCoords = selectRandomCoords(randomCoords, tonumber(value.jobCount))
            for _, coord in ipairs(selectedCoords) do
                table.insert(streetData, coord)
            end
            lobby.roomSetting.Mission.regionstreetLampCoords = streetData
        elseif value.jobName == 'phonePole' then
            local phonePoleData = {}
            local randomCoords = lobby.roomSetting.Mission.regionphonePoleCoords
            local selectedCoords = selectRandomCoords(randomCoords, tonumber(value.jobCount))
            for _, coord in ipairs(selectedCoords) do
                table.insert(phonePoleData, coord)
            end
            lobby.roomSetting.Mission.regionphonePoleCoords = phonePoleData
        else
            print('job name not found or not exist')
        end
    end

    for _, player in ipairs(lobby.players) do
        Wait(200)
        TriggerClientEvent('tworst-electrician:client:StartJobOwner', player.source, lobby, JoobTask[identifier])
    end
end)

RegisterServerEvent('tworst-electrician:server:switchFixed', function(owneridentifier, coords)
    local src = source
    if not owneridentifier then return end
    local lobby = coopData[owneridentifier]
    if not lobby then return end
    if not lobby.roomSetting.startJob then
        TriggerClientEvent('tworst-electrician:client:sendNotification', src,
            Config.NotificationText['jobnotstarted'].text,
            Config.NotificationText['jobnotstarted'].type)
        return
    end
    for index, value in ipairs(lobby.roomSetting.Mission.regiontrafficLampCoords) do
        if value.regionFixedTrafo.coords.x == coords.x and
            value.regionFixedTrafo.coords.y == coords.y and
            value.regionFixedTrafo.coords.z == coords.z then
            lobby.roomSetting.Mission.regiontrafficLampCoords[index].regionFixedTrafo.fixed = true
            for _, player in ipairs(lobby.players) do
                TriggerClientEvent('tworst-electrician:client:UpdateData', player.source,
                    lobby.roomSetting.Mission.regiontrafficLampCoords, 'fixTrafficLamp')
            end
        end
    end
end)

RegisterServerEvent('tworst-electrician:server:trafficLightsFixed', function(owneridentifier, coords)
    local src = source
    if not owneridentifier then return end
    local lobby = coopData[owneridentifier]
    if not lobby then return end
    if not lobby.roomSetting.startJob then
        TriggerClientEvent('tworst-electrician:client:sendNotification', src,
            Config.NotificationText['jobnotstarted'].text,
            Config.NotificationText['jobnotstarted'].type)
        return
    end

    for index, value in ipairs(lobby.roomSetting.Mission.regiontrafficLampCoords) do
        for i, v in ipairs(value.regionTrafficCoords) do
            if v.coords.x == coords.x and v.coords.y == coords.y and v.coords.z == coords.z then
                lobby.roomSetting.Mission.regiontrafficLampCoords[index].regionTrafficCoords[i].fixed = true

                for _, player in ipairs(lobby.players) do
                    TriggerClientEvent('tworst-electrician:client:UpdateData', player.source,
                        lobby.roomSetting.Mission.regiontrafficLampCoords, 'fixTrafficLamp')
                end
            end
        end
    end
end)

RegisterServerEvent('tworst-electrician:server:switchFixedHouse', function(owneridentifier, coords)
    local src = source
    if not owneridentifier then return end
    local lobby = coopData[owneridentifier]
    if not lobby then return end
    if not lobby.roomSetting.startJob then
        TriggerClientEvent('tworst-electrician:client:sendNotification', src,
            Config.NotificationText['jobnotstarted'].text,
            Config.NotificationText['jobnotstarted'].type)
        return
    end
    for index, value in ipairs(lobby.roomSetting.Mission.regionhouseBoardCoords) do
        if value.coords.x == coords.x and value.coords.y == coords.y and value.coords.z == coords.z then
            lobby.roomSetting.Mission.regionhouseBoardCoords[index].fixed = true
            lobby.roomSetting.Mission.regionhouseBoardCoords[index].open = false
            for _, player in ipairs(lobby.players) do
                TriggerClientEvent('tworst-electrician:client:UpdateData', player.source,
                    lobby.roomSetting.Mission.regionhouseBoardCoords, 'fixHouseBoard')
            end
        end
    end
end)

RegisterServerEvent('tworst-electrician:server:switchFixedTrafo', function(owneridentifier, coords)
    local src = source
    if not owneridentifier then return end
    local lobby = coopData[owneridentifier]
    if not lobby then return end
    if not lobby.roomSetting.startJob then
        TriggerClientEvent('tworst-electrician:client:sendNotification', src,
            Config.NotificationText['jobnotstarted'].text,
            Config.NotificationText['jobnotstarted'].type)
        return
    end
    for index, value in ipairs(lobby.roomSetting.Mission.regionstreetTrafoCoords) do
        if value.coords.x == coords.x and value.coords.y == coords.y and value.coords.z == coords.z then
            lobby.roomSetting.Mission.regionstreetTrafoCoords[index].fixed = true
            lobby.roomSetting.Mission.regionstreetTrafoCoords[index].open = false
            for _, player in ipairs(lobby.players) do
                TriggerClientEvent('tworst-electrician:client:UpdateData', player.source,
                    lobby.roomSetting.Mission.regionstreetTrafoCoords, 'fixTrafo')
            end
        end
    end
end)

RegisterServerEvent('tworst-electrician:server:switchFixedPhonePole', function(owneridentifier, coords)
    local src = source
    if not owneridentifier then return end
    local lobby = coopData[owneridentifier]
    if not lobby then return end
    if not lobby.roomSetting.startJob then
        TriggerClientEvent('tworst-electrician:client:sendNotification', src,
            Config.NotificationText['jobnotstarted'].text,
            Config.NotificationText['jobnotstarted'].type)
        return
    end
    for index, value in ipairs(lobby.roomSetting.Mission.regionphonePoleCoords) do
        if value.coords.x == coords.x and value.coords.y == coords.y and value.coords.z == coords.z then
            lobby.roomSetting.Mission.regionphonePoleCoords[index].fixed = true
            lobby.roomSetting.Mission.regionphonePoleCoords[index].open = false
            for _, player in ipairs(lobby.players) do
                TriggerClientEvent('tworst-electrician:client:UpdateData', player.source,
                    lobby.roomSetting.Mission.regionphonePoleCoords, 'phonePole')
            end
        end
    end
end)

RegisterServerEvent('tworst-electrician:server:switchFixedstreetLamp', function(owneridentifier, coords)
    local src = source
    if not owneridentifier then return end
    local lobby = coopData[owneridentifier]
    if not lobby then return end
    if not lobby.roomSetting.startJob then
        TriggerClientEvent('tworst-electrician:client:sendNotification', src,
            Config.NotificationText['jobnotstarted'].text,
            Config.NotificationText['jobnotstarted'].type)
        return
    end
    for index, value in ipairs(lobby.roomSetting.Mission.regionstreetLampCoords) do
        if value.coords.x == coords.x and value.coords.y == coords.y and value.coords.z == coords.z then
            lobby.roomSetting.Mission.regionstreetLampCoords[index].fixed = true
            lobby.roomSetting.Mission.regionstreetLampCoords[index].open = false
            for _, player in ipairs(lobby.players) do
                TriggerClientEvent('tworst-electrician:client:UpdateData', player.source,
                    lobby.roomSetting.Mission.regionstreetLampCoords, 'fixStreetLamp')
            end
        end
    end
end)

RegisterServerEvent('tworst-electrician:server:changeTrafoModal',
    function(owneridentifier, index, coords, missionName, bool)
        local src = source
        if not owneridentifier then return end
        local lobby = coopData[owneridentifier]
        if not lobby then return end
        if not lobby.roomSetting.startJob then
            TriggerClientEvent('tworst-electrician:client:sendNotification', src,
                Config.NotificationText['jobnotstarted'].text,
                Config.NotificationText['jobnotstarted'].type)
            return
        end
        if missionName == 'fixHouseBoard' then
            for indexx, value in ipairs(lobby.roomSetting.Mission.regionhouseBoardCoords) do
                if value.coords.x == coords.x and value.coords.y == coords.y and value.coords.z == coords.z then
                    lobby.roomSetting.Mission.regionhouseBoardCoords[indexx].open = bool
                    for _, player in ipairs(lobby.players) do
                        TriggerClientEvent('tworst-electrician:client:UpdateData', player.source,
                            lobby.roomSetting.Mission.regionhouseBoardCoords, 'fixHouseBoard')
                    end
                end
            end
        elseif missionName == 'fixTrafo' then
            for indexx, value in ipairs(lobby.roomSetting.Mission.regionstreetTrafoCoords) do
                if value.coords.x == coords.x and value.coords.y == coords.y and value.coords.z == coords.z then
                    lobby.roomSetting.Mission.regionstreetTrafoCoords[indexx].open = bool
                    for _, player in ipairs(lobby.players) do
                        TriggerClientEvent('tworst-electrician:client:UpdateData', player.source,
                            lobby.roomSetting.Mission.regionstreetTrafoCoords, 'fixTrafo')
                    end
                end
            end
        elseif missionName == 'phonePole' then
            for indexx, value in ipairs(lobby.roomSetting.Mission.regionphonePoleCoords) do
                if value.coords.x == coords.x and value.coords.y == coords.y and value.coords.z == coords.z then
                    lobby.roomSetting.Mission.regionphonePoleCoords[indexx].open = bool
                    for _, player in ipairs(lobby.players) do
                        TriggerClientEvent('tworst-electrician:client:UpdateData', player.source,
                            lobby.roomSetting.Mission.regionphonePoleCoords, 'phonePole')
                    end
                end
            end
        elseif missionName == 'fixStreetLamp' then
            for indexx, value in ipairs(lobby.roomSetting.Mission.regionstreetLampCoords) do
                if value.coords.x == coords.x and value.coords.y == coords.y and value.coords.z == coords.z then
                    lobby.roomSetting.Mission.regionstreetLampCoords[indexx].open = bool
                    for _, player in ipairs(lobby.players) do
                        TriggerClientEvent('tworst-electrician:client:UpdateData', player.source,
                            lobby.roomSetting.Mission.regionstreetLampCoords, 'fixStreetLamp')
                    end
                end
            end
        end
    end)

RegisterServerEvent('tworst-electrician:server:UpdateJobTask', function(jobTaskName, owneridentifier)
    local src = source
    if not owneridentifier then return end
    local identifier = GetIdentifier(src)
    local lobby = coopData[owneridentifier]
    if not lobby then return end
    if not lobby.roomSetting.startJob then
        TriggerClientEvent('tworst-electrician:client:sendNotification', src,
            Config.NotificationText['jobnotstarted'].text,
            Config.NotificationText['jobnotstarted'].type)
        return
    end

    for _, player in ipairs(lobby.players) do
        if player.playerIdentifier == identifier then
            for k, v in pairs(JoobTask[owneridentifier].regionJobTask) do
                if v.jobName == jobTaskName then
                    v.madeAmount = v.madeAmount + 1
                    if v.madeAmount == v.jobCount then
                        v.finish = true
                        TriggerEvent('tworst-electrician:server:FinishJob', v.jobName, identifier, owneridentifier)
                    end

                    for _, player in ipairs(JoobTask[owneridentifier].Players) do
                        if player.playerIdentifier == identifier then
                            player.scoreAmount = player.scoreAmount + 1
                        end
                    end
                end
            end
        end
    end

    for _, player in ipairs(lobby.players) do
        TriggerClientEvent('tworst-electrician:client:RefreshJob', player.source, JoobTask[owneridentifier])
    end
end)


RegisterServerEvent('tworst-electrician:server:FinishJob', function(jobTaskName, identifier, owneridentifier)
    local src = source
    local lobby = coopData[owneridentifier]
    if not lobby then return end
    if not lobby.roomSetting.startJob then
        TriggerClientEvent('tworst-electrician:client:sendNotification', src,
            Config.NotificationText['jobnotstarted'].text,
            Config.NotificationText['jobnotstarted'].type)
        return
    end
    if not JoobTask[owneridentifier] then return end
    local allFinished = true

    for k, v in pairs(JoobTask[owneridentifier].regionJobTask) do
        if v.jobName == "fixTrafo" or v.jobName == "fixHouseBoard" or v.jobName == 'fixStreetLamp' or v.jobName == 'fixTrafficLamp' or v.jobName == 'phonePole' then
            if not v.finish then
                allFinished = false
                break
            end
        end
    end

    if allFinished then
        lobby.roomSetting.finishJob = true
        lobby.roomSetting.startJob = false
        lobby.roomSetting.carDelivered = true
        for _, player in ipairs(lobby.players) do
            TriggerClientEvent('tworst-electrician:client:FinishJob', player.source, coopData[owneridentifier])
        end
    end
end)

function discordloghistoryData(source, data)
    local src = source
    local identifier = GetIdentifier(src)
    local dataInfo = {
        identifier = identifier,
        avatar = GetDiscordAvatar(src) or Config.ExampleProfilePicture,
        name = GetName(src),
        id = src,
        money = data.money,
        owneridentifier = data.owneridentifier,
    }
    return dataInfo
end

RegisterServerEvent('tworst-electrician:server:LeaveVehicle', function(owneridentifier)
    local src = source
    local identifier = GetIdentifier(src)
    local lobby = coopData[owneridentifier]
    if not lobby then return end
    if not lobby.roomSetting.finishJob then
        TriggerClientEvent('tworst-electrician:client:sendNotification', src,
            Config.NotificationText['jobnotstarted'].text,
            Config.NotificationText['jobnotstarted'].type)
        return
    end
    local vehiclesToDelete = {}
    lobby.roomSetting.regionAwards.money = math.ceil(lobby.roomSetting.regionAwards.money / #lobby.players)
    for _, player in ipairs(lobby.players) do
        Wait(1000)
        for k, v in pairs(lobby.roomSetting.Vehicle) do
            table.insert(vehiclesToDelete, v)
        end

        for key, value in pairs(lobby.roomSetting.VehicleNetId) do
            table.insert(vehiclesToDelete, value)
        end

        for _, vehicle in ipairs(vehiclesToDelete) do
            if DoesEntityExist(vehicle) then
                DeleteEntity(vehicle)
            end
        end

        for _, vehicle in ipairs(vehiclesToDelete) do
            for i, v in ipairs(lobby.roomSetting.Vehicle) do
                if v == vehicle then
                    table.remove(lobby.roomSetting.Vehicle, i)
                    break
                end
            end
        end

        if #lobby.roomSetting.Vehicle == 0 then
            local historyData = {
                ['money'] = tonumber(lobby.roomSetting.regionAwards.money),
                ['owneridentifier'] = owneridentifier,
                ['time'] = os.date("%m-%d-%Y %H:%M"),
            }
            local discordlog = discordloghistoryData(tonumber(player.source), historyData)
            sendDiscordLogHistory(discordlog)
            AddMoney(tonumber(player.source), 'bank', tonumber(lobby.roomSetting.regionAwards.money))
            AddXP(tonumber(player.source), tonumber(lobby.roomSetting.regionAwards.xp))
            Wait(300)
            savePlayerData(player.source)

            for __, regionJobTask in ipairs(JoobTask[owneridentifier].Players) do
                if regionJobTask.identifier == player.identifier then
                    TriggerClientEvent('tworst-electrician:client:LeaveVehicle', player.source, regionJobTask
                        .scoreAmount, lobby.roomSetting.regionAwards)
                end
            end
        end
    end


    coopData[owneridentifier] = nil
    JoobTask[owneridentifier] = nil
end)


function AddXP(source, xp)
    if not xp and xp <= 0 then
        return
    end
    local src = source
    local identifier = GetIdentifier(src)
    local data = playerJobData[identifier]
    if not data then
        return
    end
    local profiledata = data.profiledata
    profiledata.xp = tonumber(profiledata.xp) + tonumber(xp)
    if profiledata.level > #Config.RequiredXP then
        TriggerClientEvent('tworst-electrician:client:sendNotification', src, Config.NotificationText['maxlevel'].text,
            Config.NotificationText['maxlevel'].type)
        return
    end
    if tonumber(profiledata.xp) >= tonumber(Config.RequiredXP[profiledata.level]) then
        profiledata.level = tonumber(profiledata.level) + 1
        profiledata.xp = 0
    end
end

RegisterServerEvent('tworst-electrician:server:resetJobButton', function(owneridentifier)
    local src = source
    local identifier = GetIdentifier(src)
    local owneridentifier = owneridentifier
    if not owneridentifier then return end
    if tostring(owneridentifier) ~= tostring(identifier) then
        TriggerClientEvent('tworst-electrician:client:sendNotification', src, Config.NotificationText['notowner'].text,
            Config.NotificationText['notowner'].type)
        return
    end
    local lobby = coopData[owneridentifier]
    if not lobby then return end
    if lobby.roomSetting.startJob then
        for _, player in ipairs(lobby.players) do
            if player.source == src then
                local vehiclesToDelete = {}
                for k, v in pairs(lobby.roomSetting.Vehicle) do
                    table.insert(vehiclesToDelete, v)
                end

                for key, value in pairs(lobby.roomSetting.VehicleNetId) do
                    table.insert(vehiclesToDelete, value)
                end

                for _, vehicle in ipairs(vehiclesToDelete) do
                    if DoesEntityExist(vehicle) then
                        DeleteEntity(vehicle)
                    end
                end
                for _, vehicle in ipairs(vehiclesToDelete) do
                    for i, v in ipairs(lobby.roomSetting.Vehicle) do
                        if v == vehicle then
                            table.remove(lobby.roomSetting.Vehicle, i)
                            break
                        end
                    end
                end




                coopData[owneridentifier] = nil
                JoobTask[owneridentifier] = nil

                for _, remainingPlayer in ipairs(lobby.players) do
                    SetPlayerRoutingBucket(tonumber(remainingPlayer.source), 0)
                    TriggerClientEvent('tworst-electrician:client:resetjob', remainingPlayer.source)
                    TriggerClientEvent('tworst-electrician:client:sendNotification', remainingPlayer.source,
                        Config.NotificationText['resetJob'].text, Config.NotificationText['resetJob'].type)
                end
                break
            end
        end
    end
end)

RegisterServerEvent('tworst-electrician-server:build', function(modal, coords, owneridentifier)
    local src = source
    local lobby = coopData[owneridentifier]
    if not lobby then return end

    if modal == 'lift' then
        TriggerClientEvent("tworst-electrician:createLift", src, coords)
        lobby.roomSetting.liftCraft = true
    elseif modal == 'ladder' then
        TriggerClientEvent("tworst-electrician:createLadder", src, coords)
        lobby.roomSetting.ladderCraft = true
    end
    for _, player in ipairs(lobby.players) do
        TriggerClientEvent('tworst-electrician:client:UpdateLobby', player.source, lobby)
    end
end)

---- LİFT ----
local Lifts = {}

function UpdateLift(id, target)
    TriggerClientEvent("tworst-electrician:updateLift", target or -1, id or Lifts, id and Lifts[id] or nil)
end

function CanPlayerLift(source, id, spawnData, startLift)
    if spawnData then
    else
        if not Lifts[id] then return false end
    end
    return true
end

RegisterNetEvent("tworst-electrician:moveLift", function(id, direction, toggle, height)
    Lifts[id].moving = toggle
    Lifts[id].direction = (toggle and direction or nil)
    Lifts[id].currentHeight = height - 2.75
    UpdateLift(id)

    TriggerClientEvent("tworst-electrician:moveLift", -1, id, direction, toggle, height)
end)

RegisterNetEvent("tworst-electrician:spawnLift", function(coords, heading, railHeight)
    local success = CanPlayerLift(source, nil, { railHeight = railHeight }, true)
    if not success then return end
    local lift = {
        coords = coords,
        heading = heading,
        railHeight = railHeight,
        currentHeight = coords.z + 0.5,
        moving = nil,
        direction = nil,
        controller = nil,
    }

    local id = nil

    repeat
        id = os.time() .. "_" .. math.random(1000, 9999)
    until not Lifts[id]

    Lifts[id] = lift
    UpdateLift(id)
end)


RegisterNetEvent("tworst-electrician:removeLift", function(id, owneridentifier)
    local source = source
    local success = CanPlayerLift(source, id, nil, true)
    if not success then return end
    Lifts[id] = nil
    UpdateLift(id)
    SetTimeout(1000, function()
        TriggerClientEvent("tworst-electrician:removeLift", -1, id)
    end)
    SetTimeout(3000, function()
        local lobby = coopData[owneridentifier]
        if not lobby then return end
        lobby.roomSetting.liftCraft = false
        for _, player in ipairs(lobby.players) do
            TriggerClientEvent('tworst-electrician:client:UpdateLobby', player.source, lobby, 'lift')
        end
    end)
end)


--LADDER--


function UpdateLadders(index, target)
    local data = nil
    if index then
        data = Ladders[index]
    else
        data = Ladders
    end
    TriggerClientEvent("tworst-electrician:updateLadders", target or -1, index or nil, data)
end
