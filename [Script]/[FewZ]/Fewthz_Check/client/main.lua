ESX = exports["es_extended"]:getSharedObject()

local Total_ALL = {
    All = 0,
    ambulance = 0,
    police = 0,
    mechanic = 0,
    council = 0,
}

AddEventHandler("Fewthz_core:ClientMemoryGarbage", function()
	Citizen.CreateThread(function()
		Wait(math.random(100, 2000))
		collectgarbage()
	end)
end)

RegisterNetEvent(GetCurrentResourceName() .. "UpdateData")
AddEventHandler(GetCurrentResourceName() .. "UpdateData",function(amount, job ) 
    Total_ALL[job] = amount
end)

RegisterNetEvent(GetCurrentResourceName() .. "UpdateDataAll")
AddEventHandler(GetCurrentResourceName() .. "UpdateDataAll",function(All) 
    Total_ALL.All = All
end)

RegisterNetEvent(GetCurrentResourceName() .. "UpdateDataWhenstart")
AddEventHandler(GetCurrentResourceName() .. "UpdateDataWhenstart",function(Total_ALL_Sv) 
    Total_ALL = Total_ALL_Sv
end)

function CheckPolice(amount)
    if Total_ALL.police >= amount then
        return true
    else
        return false
    end
end

function CheckAmbulance(amount)
    if Total_ALL.ambulance >= amount then
        return true
    else
        return false
    end
end

function CheckMechanic(amount)
    if Total_ALL.mechanic >= amount then
        return true
    else
        return false
    end
end

function CheckCouncil(amount)
    if Total_ALL.council >= amount then
        return true
    else
        return false
    end
end

function CheckPoliceonline()
    return Total_ALL.police
end

function CheckAmbulanceonline()
    return Total_ALL.ambulance
end

function CheckMechaniconline()
    return Total_ALL.mechanic
end

function CheckCouncilonline()
    return Total_ALL.council
end

function CheckPlayersonline()
    return Total_ALL.All
end

exports('Item', function(item_name)
    local inventory = ESX.GetPlayerData().inventory
    for i = 1, #inventory do
        local item = inventory[i]
        if item_name == item.name and item.count > 0 then
            return true
        end
    end
    return false
end)

exports('Money', function(type)
    local inventory = ESX.GetPlayerData().accounts
    for k,v in pairs(inventory) do
        if v.name == 'money' then
            return v.money
        end
    end
end)

exports('CheckItem', function(item_name, item_amount)
    local inventory = ESX.GetPlayerData().inventory
    for i=1, #inventory do
      local item = inventory[i]
      if item_name == item.name and tonumber(item.count) >= tonumber(item_amount) then
        return true
      end
    end
    return false
end)