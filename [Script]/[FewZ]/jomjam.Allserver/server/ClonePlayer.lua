ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand("copy", function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'admin' or xPlayer.getGroup() == 'superadmin' and args[1] then
        local skindata
        if string.find(args[1],"steam:") then
            skindata = GetSkin(args[1])
            if skindata then
                TriggerClientEvent('RePlayX_ClonePlayer:Clone',source,skindata)
            else
                print("Not found identifier")
            end
        else
            local target = ESX.GetPlayerFromId(args[1])
            if target then
                skindata = GetSkin(target.identifier)
                print(json.encode(skindata))
                TriggerClientEvent('RePlayX_ClonePlayer:Clone',source,skindata)
            else
                print("Target not online")
            end
        end
    end
end, true)

GetSkin = function(iden)
    local skin = MySQL.Sync.fetchAll("SELECT skin FROM `users` WHERE identifier = '"..iden.."' ")

    if skin then
        return skin[1].skin
    end
    print("?")
    return false
end