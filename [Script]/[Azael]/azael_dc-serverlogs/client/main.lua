ESX = nil
Citizen.CreateThread(
    function()
        while ESX == nil do
            TriggerEvent(
                Config["esx_routers"]["client_shared_obj"],
                function(obj)
                    ESX = obj
                end
            )
            Citizen.Wait(0)
        end
    end
)
local event
Citizen.CreateThread(
    function()
        local dead = false
        while true do
            Citizen.Wait(1000)
            local playerPed = GetPlayerPed(-1)
            if IsEntityDead(playerPed) and not dead then
                local playerId = GetPlayerServerId(PlayerId())
                killer = GetPedSourceOfDeath(playerPed)
                targetId = false
                for _, player in ipairs(GetActivePlayers()) do
                    local ped = GetPlayerPed(player)
                    if killer == ped then
                        targetId = GetPlayerServerId(player)
                        break
                    end
                end
                if not targetId then
                    local playerCoords = GetEntityCoords(PlayerPedId())
                    local players = ESX.Game.GetPlayersInArea(playerCoords, 15.0)
                    local vehicles = ESX.Game.GetVehiclesInArea(playerCoords, 15.0)
                    if (#vehicles > 0) and (#players > 0) then
                        for _, v in ipairs(vehicles) do
                            for _, p in ipairs(players) do
                                local targetPed = GetPlayerPed(p)
                                if IsPedInVehicle(targetPed, v) then
                                    if GetPedInVehicleSeat(GetVehiclePedIsIn(targetPed, false), -1) == targetPed then
                                        targetId = GetPlayerServerId(p)
                                        plate = ESX.Math.Trim(GetVehicleNumberPlateText(v))
                                        break
                                    end
                                end
                            end
                        end
                        if not plate then
                            plate = "Unknown"
                        end
                    end
                end
                local death = GetPedCauseOfDeath(playerPed)
                if checkArray("Melee", death) and targetId then
                    TriggerServerEvent("azael_discordlogs:sendDeathCause", "Melee", playerId, targetId, event)
                elseif checkArray("Melee", death) and not targetId then
                    TriggerServerEvent("azael_discordlogs:sendDeathCause", "Melee", playerId, false, event)
                elseif checkArray("Bullet", death) and targetId then
                    TriggerServerEvent("azael_discordlogs:sendDeathCause", "Bullet", playerId, targetId, event)
                elseif checkArray("Bullet", death) and not targetId then
                    TriggerServerEvent("azael_discordlogs:sendDeathCause", "Bullet", playerId, false, event)
                elseif checkArray("Car", death) and targetId then
                    local msg = "" .. event .. " ทะเบียน " .. plate .. ""
                    TriggerServerEvent("azael_discordlogs:sendDeathCause", "Car", playerId, targetId, msg)
                elseif checkArray("Car", death) and not targetId then
                    TriggerServerEvent("azael_discordlogs:sendDeathCause", "Car", playerId, false, event)
                elseif checkArray("Explosion", death) and targetId then
                    TriggerServerEvent("azael_discordlogs:sendDeathCause", "Explosion", playerId, targetId, event)
                elseif checkArray("Explosion", death) and not targetId then
                    TriggerServerEvent("azael_discordlogs:sendDeathCause", "Explosion", playerId, false, event)
                elseif checkArray("Gas", death) and targetId then
                    TriggerServerEvent("azael_discordlogs:sendDeathCause", "Gas", playerId, targetId, event)
                elseif checkArray("Gas", death) and not targetId then
                    TriggerServerEvent("azael_discordlogs:sendDeathCause", "Gas", playerId, false, event)
                elseif checkArray("Burn", death) and targetId then
                    TriggerServerEvent("azael_discordlogs:sendDeathCause", "Burn", playerId, targetId, event)
                elseif checkArray("Burn", death) and not targetId then
                    TriggerServerEvent("azael_discordlogs:sendDeathCause", "Burn", playerId, false, event)
                elseif checkArray("Animal", death) then
                    TriggerServerEvent("azael_discordlogs:sendDeathCause", "Animal", playerId, false, event)
                elseif checkArray("FallDamage", death) then
                    TriggerServerEvent("azael_discordlogs:sendDeathCause", "FallDamage", playerId, false, event)
                elseif checkArray("Drown", death) then
                    TriggerServerEvent("azael_discordlogs:sendDeathCause", "Drown", playerId, false, event)
                else
                    TriggerServerEvent("azael_discordlogs:sendDeathCause", "Unknown", playerId, false, false)
                end
                death = nil
                event = nil
                plate = nil
                dead = true
            end
            if not IsEntityDead(playerPed) then
                dead = false
            end
        end
    end
)
function checkArray(type, val)
    for k, v in ipairs(Config["event"]) do
        if v.type == type then
            for w, l in ipairs(v.list) do
                local hash = GetHashKey(l.name)
                local label = l.label
                if hash == val then
                    event = label
                    return event
                end
            end
        end
    end
    return false
end
