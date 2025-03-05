TriggerEvent('chat:addSuggestion', '/transfer-vehicle', 'Transfers a vehicle to another person.', {
    { name="new-owner", help="New owner's ID" },
    { name="plate", help="Vehicle's license plate" },
})

RegisterCommand("transfer-vehicle", function(source, args, rawCommand) 
    local plate = ""
    for k,v in ipairs(args) do 
        if k ~= 1 then 
            plate = plate .. " " .. v
        end
    end

    TwoNa.TriggerServerCallback("2na_garage:transferVehicle", { newOwner = args[1], plate = TwoNa.Functions.Trim(plate), }, function(success) 
        if success then 
            TriggerEvent("chat:addMessage", { args = {"^2SUCCESS", ": Vehicle with plate " .. plate .. " has successfully transfered to its new owner!"}})
        else
            TriggerEvent("chat:addMessage", { args = { "^1ERROR", ": An error occured while transfering the vehicle!" }})
        end
    end)
end)