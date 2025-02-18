ESX = nil
local OBJ = {}
local cacheobj = nil
local vehiclecache = nil
local openedvehicle = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
    for k,v in pairs(Config.OBJ) do
        for k2,v2 in pairs(v.position) do
            if v2.useobj then
                RequestModel(GetHashKey(v2.ModelName))
		        while not HasModelLoaded(GetHashKey(v2.ModelName)) do
		        	Wait(1)
		        end
		        ped =  CreatePed(4, GetHashKey(v2.ModelHash) ,v2.coord, false, false, true)
		        SetEntityHeading(ped, v2.heading)
		        FreezeEntityPosition(ped, true)
		        SetEntityInvincible(ped, true)
		        SetBlockingOfNonTemporaryEvents(ped, true)
		        TaskPlayAnim(ped, v2.AnimDictionary, v2.AnimationName, 8.0, 0.0, -1, 1, 0, 0, 0, 0)
            end
            table.insert(OBJ,{
                obj = v2.useobj and object or -1,
                coord = v2.coord,
            })
        end
    end
    while true do
        local playerped = PlayerPedId()
        local playercoord = GetEntityCoords(playerped)
        for _,v in pairs(OBJ) do
            if GetDistanceBetweenCoords(playercoord,v.coord,true) < 2.0 then
                cacheobj = v
            end
        end
        Citizen.Wait(1000)
    end
end)

Citizen.CreateThread(function()
    while true do
        if cacheobj then
            ShowFloatingHelpNotification("Press [~r~E~w~] to access trunk",cacheobj.coord+vector3(0,0,1.0))
            if IsControlJustReleased(0, Keys['E']) then
                if not vehiclecache then
                    CallVehicle(false)
                else
                    CallVehicle(true)
                end
            end
            local playerped = PlayerPedId()
            local playercoord = GetEntityCoords(playerped)
            if GetDistanceBetweenCoords(playercoord,cacheobj.coord,true) > 5.0 then
                cacheobj = nil
            end
        else
            Citizen.Wait(1000)
        end
        Citizen.Wait(0)
    end
end)

ShowFloatingHelpNotification = function(msg, coords)
	SetTextFont(fontId)
	AddTextEntry(GetCurrentResourceName(), msg)
	SetFloatingHelpTextWorldPosition(1, coords)
	SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
	BeginTextCommandDisplayHelp(GetCurrentResourceName())
	EndTextCommandDisplayHelp(2, false, false, -1)
end

CallVehicle = function(bool)
    if not bool then
        ESX.TriggerServerCallback(GetCurrentResourceName() .. ':getOwnedCars', function(ownedCars)
            if #ownedCars == 0 then
                TriggerEvent("pNotify:SendNotification", {
                    text = "คุณไม่มีรถที่เป็นเจ้าของ",
                    type = "error",
                    queue = "right",
                    timeout = 5000,
                    layout = "centerRight"
                })
            else
                local elements = {}
                for _,v in pairs(ownedCars) do
                    table.insert(elements, {label = '' .. v.plate .. ' - '..GetLabelText(GetDisplayNameFromVehicleModel(json.decode(v.vehicle).model))..'', plate = v.plate, vehicle = json.decode(v.vehicle)})
                end
                vehiclecache = elements
                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine_category',
                {
                    title    = "เปิดท้ายรถ",
                    align    = 'top-left',
                    elements = elements,
                }, function(data, menu)

                    if data.current.vehicle then
                        openedvehicle = CreateInvisible(data.current.vehicle)
                        Config["TRUNK_EVENT"](openedvehicle)
                        menu.close()
                    end

                end, function(data, menu)
                    menu.close()
                end)
            end
        end)
    else
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine_category',
        {
            title    = "เปิดท้ายรถ",
            align    = 'top-left',
            elements = vehiclecache,
        }, function(data, menu)

            if data.current.vehicle then
                openedvehicle = CreateInvisible(data.current.vehicle)
                Config["TRUNK_EVENT"](openedvehicle)
                menu.close()
            end

        end, function(data, menu)
            menu.close()
        end)
    end
end

function CreateInvisible(data)
    RequestModel(data.model)
    repeat Wait(0) until HasModelLoaded(data.model)
	local vehicle = CreateVehicle(data.model, GetEntityCoords(PlayerPedId()), 0.0, false, false)
    ESX.Game.SetVehicleProperties(vehicle, data)
    SetEntityVisible(vehicle, false, 0)
	SetVehicleIsConsideredByPlayer(vehicle, false)
	SetEntityCollision(vehicle, false, false)
	return vehicle
end

AddEventHandler(Config.ReduceCallback,function()
    vehiclecache = nil
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(OBJ) do
			DeleteObject(v.prop)
		end
	end
end)