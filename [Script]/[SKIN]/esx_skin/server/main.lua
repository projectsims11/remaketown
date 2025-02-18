ESX = exports["es_extended"]:getSharedObject()

RegisterServerEvent("esx_skin:save")
AddEventHandler("esx_skin:save",function(skin)
    local xPlayer = ESX.GetPlayerFromId(source)

        MySQL.Async.execute(
            "UPDATE users SET skin = @skin WHERE identifier = @identifier",
            {
                ["@skin"] = json.encode(skin),
                ["@identifier"] = xPlayer.identifier
            }
        )
end)

RegisterServerEvent("esx_skin:responseSaveSkin")
AddEventHandler("esx_skin:responseSaveSkin",function(skin)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" then
        local file = io.open("skins.txt", "a")

        file:write(json.encode(skin))
        file:flush()
        file:close()
    else
        print(("esx_skin: %s attempted saving skin to file"):format(xPlayer.getIdentifier()))
    end
end)

    ESX.RegisterServerCallback(
        "esx_skin:getPlayerSkin",
        function(source, cb)
            local xPlayer = ESX.GetPlayerFromId(source)

                MySQL.Async.fetchAll(
                    "SELECT skin FROM users WHERE identifier = @identifier",
                    {
                        ["@identifier"] = xPlayer.identifier
                    },
                    function(users)
                        local user, skin = users[1]

                        local jobSkin = {
                            skin_male = xPlayer.job.skin_male,
                            skin_female = xPlayer.job.skin_female
                        }

                        if user.skin then
                            skin = json.decode(user.skin)
                        end

                        cb(skin, jobSkin)
                    end
                )
        end
    )

ESX.RegisterCommand("skin" , "admin", function(xPlayer, args, showError)
    xPlayer.triggerEvent("esx_skin:openSaveableMenu")
end,false,{help = _U("skin")})

ESX.RegisterCommand("skinid" , "admin", function(xPlayer, args, showError)
    args.playerId.triggerEvent("esx_skin:openSaveableMenu")
end, true,
    {
        help = _U("revive_help"),
        validate = true,
        arguments = {
            {name = "playerId", help = _U("skin"), type = "player"}
        }
    }
)

ESX.RegisterCommand("skinsave", "admin", function(xPlayer, args, showError)
    xPlayer.triggerEvent("esx_skin:requestSaveSkin")
end,false,
{help = _U("saveskin")})

-- ESX.RegisterUsableItem("RESKIN", function(source)
--     local xPlayer = ESX.GetPlayerFromId(source)
--         xPlayer.addInventoryItem("RESKIN", 1)
--         xPlayer.triggerEvent("esx_skin:openSaveableMenu")
-- end)
