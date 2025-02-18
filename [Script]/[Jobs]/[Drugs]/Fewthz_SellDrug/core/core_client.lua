ESX = exports["es_extended"]:getSharedObject()
FewZ = GetCurrentResourceName()

local OnNPCZone     = false
local Selling       = false
local AllNPCData    = {}
local streetName

function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end    
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function LoadModel(model)
    while not HasModelLoaded(model) do
          RequestModel(model)
          Citizen.Wait(10)
    end
end

function checkHasItem(item_name, item_amount)
    local inventory = ESX.GetPlayerData().inventory
    for i=1, #inventory do
        local item = inventory[i]
        if item_name == item.name and tonumber(item.count) >= tonumber(item_amount) then
            local itemcount = item.count
            return true
        end
    end
    return false
end

DrawText3DHealth = function(coords, text)
    SetTextScale(0.60, 0.60)
    SetTextFont(1)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(coords.x, coords.y, coords.z + 1.0, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)

		local coords      = GetEntityCoords(PlayerPedId())
		local isInMarker  = false
		local currentZone = nil
        local CoordsSpawn = nil
        local CoordsHeading = nil

		for k,v in pairs(Config['SellCoords']) do
			if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Config['CreateNPCDistance']) then
				isInMarker  = true
				currentZone = k
                CoordsSpawn = vector3(v.x, v.y, v.z)
                CoordsHeading = v.h
                StatusPed   = v.Active
			end
		end

		if (isInMarker and not OnNPCZone) or (isInMarker and LastZone ~= currentZone) then
			OnNPCZone = true
			LastZone                = currentZone
            CreateForSellPed(CoordsSpawn,CoordsHeading)
		end

		if not isInMarker and OnNPCZone then
			OnNPCZone = false
            CoordsSpawn = nil
            CoordsHeading = nil
            for k, v in pairs(AllNPCData) do DeleteEntity(v.Ped) end
		end
	end
end)

function CreateForSellPed(Coords,Heading)
    local AllPEDHash = math.random(1, #Config['PedList'])
    local GetHashPed = Config['PedList'][AllPEDHash]
    local PedHashKey = GetHashKey(GetHashPed)
    LoadModel(PedHashKey)
    local NPC_PED = CreatePed(3, PedHashKey, Coords.x,Coords.y,Coords.z-1, false, false, false)
    SetEntityHeading(NPC_PED,Heading)
    SetEntityInvincible(NPC_PED, true)
    SetBlockingOfNonTemporaryEvents(NPC_PED, true)
    SetPedDiesWhenInjured(NPC_PED, false)
    SetPedCanRagdollFromPlayerImpact(NPC_PED, false)
    SetEntityInvincible(NPC_PED, true)
    TaskWanderInArea(NPC_PED, Coords.x,Coords.y,Coords.z-1, 10.0, 0.0 , 0.0) 
    table.insert(AllNPCData,{Ped = NPC_PED})
end

Citizen.CreateThread(function()
    while true do
        Wait(0)
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local PetnearbyObject, nearbyID, mrcoords
        local canSleep  = true

        for k, v in pairs(AllNPCData) do
            mrcoords = GetEntityCoords(v.Ped)
            if GetDistanceBetweenCoords(coords, mrcoords, false) < 2.0 then
                canSleep = false
                PetnearbyObject, nearbyID = v.Ped
                break
            end
        end

        if PetnearbyObject and IsPedOnFoot(playerPed) then

            if not IsPedDeadOrDying(PetnearbyObject, true) then
                if not Selling then
                    DrawText3DHealth(mrcoords, Config['DrawText3D'])
                end
            end   

            if IsDisabledControlJustReleased(0, 38) then
                ESX.UI.Menu.CloseAll()

	            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'sell_actions', {
	            	title    = 'sell',
	            	align    = 'top-left',
	            	elements = {
	            		{label = 'ขายยา', value = 'sell'},
	            		{label = 'ปล้น NPC', value = 'Thifenpc'},
	            }}, function(data, menu)
	            	if data.current.value == 'Thifenpc' then
                        menu.close()
                        if exports.Fewthz_Check:CheckPolice(Config['CopCount']) then
                            if CheckSellCoordsActive() then
                                if not Selling then
	            		            ThifeByPlayer(PetnearbyObject)
                                end
                            else
                                exports['mythic_notify']:DoHudText('error', 'คุณปล้นจุดนี้ไปแล้ว')
                                Citizen.Wait(1000)
                            end
                        else
                            exports['mythic_notify']:DoHudText('error', 'ตำรวจไม่เพียงพอ')
                            Citizen.Wait(1000)
                        end
	            	elseif data.current.value == 'sell' then
                        menu.close()
                        if not Selling then
                            if checkHasItem(Config['Item'], 1) then
                                if exports.Fewthz_Check:CheckPolice(Config['CopCount']) then
                                    if CheckSellCoordsActive() then
                                        FreezeEntityPosition(PetnearbyObject, true)
                                        for k,v in pairs(Config['SellCoords']) do
                                            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.x,v.y,v.z, false) < 20.0 then
                                                local CoordsCheck = vector3(v.x, v.y, v.z)
                                                TriggerEvent(FewZ..':SetCDActive', CoordsCheck)
                                            end
                                        end
                                        StartSellDrug()
                                    else
                                        exports['mythic_notify']:DoHudText('error', 'คุณขายจุดนี้ไปแล้ว')
                                        Citizen.Wait(1000)
                                    end
                                else
                                    ThifeByNPC(PetnearbyObject)
                                end
                            else
                                exports['mythic_notify']:DoHudText('error', 'คุณไม่มีสิ่งของผิดกฎหมายสำหรับขาย')
                                Citizen.Wait(1000)
                            end
                        end
                    end
                end, function(data, menu)
                    menu.close()
                end)
            end
            
        end
        if canSleep then
            Citizen.Wait(500)
        end
    end
end)

function CheckSellCoordsActive()
    for k,v in pairs(Config['SellCoords']) do
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        if GetDistanceBetweenCoords(coords, v.x,v.y,v.z, false) < 20.0 then
            if v.Active then
                v.Active = false
                return true
            else
                return false
            end
        end
    end
end

RegisterNetEvent(FewZ..':SetCDActive')
AddEventHandler(FewZ..':SetCDActive', function(Coords)
    Citizen.Wait(Config['CoordsCoolDownTime']*1000)
    for k,v in pairs(Config['SellCoords']) do
        local CoordsCheck = vector3(v.x, v.y, v.z)
        if CoordsCheck == Coords then
            v.Active = true
        end
    end
end)

function ThifeByPlayer(NPCPED)
    Selling = true
    exports['mythic_notify']:DoHudText('error', 'NPC ได้แจ้งตำรวจ')
    AlertCop()
    startCallpolice()
    FreezeEntityPosition(PetnearbyObject, true)
    FreezeEntityPosition(PlayerPedId(), true)
    LoadAnimDict('random@mugging3')
    TaskPlayAnim(NPCPED, "random@mugging3" ,"handsup_standing_base" ,6.0, -6.0, -1, 49, 0, 0, 0, 0)
    local PedHeading    = GetEntityHeading(PlayerPedId())
    local PlayerX,PlayerY,PlayerZ 	= table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.5, 0.0))
    local NPCCoords     = GetEntityCoords(PlayerPedId())
    local PropGunkey 	= GetHashKey("w_pi_sns_pistolmk2")
    local ThiefGunprop = CreateObject(PropGunkey, NPCCoords.x, NPCCoords.y, NPCCoords.z, true, false, false)
    AttachEntityToEntity(ThiefGunprop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.17, 0.02, 0.0, 280.0, 0.0, 0.0, true, false, false, true, 1, true)
    table.insert(AllNPCData,{Prop = ThiefGunprop})
    LoadAnimDict('random@countryside_gang_fight')
    TaskPlayAnim(PlayerPedId(), "random@countryside_gang_fight" ,"biker_02_stickup_loop" ,8.0, -8.0, -1, 1, 0, false, false, false )
    TaskPlayAnim(NPCPED, "random@countryside_gang_fight" ,"biker_02_stickup_loop" ,8.0, -8.0, -1, 1, 0, false, false, false )
    SetEntityCoords(NPCPED,PlayerX,PlayerY,PlayerZ-1)
    SetEntityHeading(NPCPED,PedHeading-180)
    TriggerServerEvent(FewZ..':Addthief')
    Citizen.Wait(5000)
    for k, v in pairs(AllNPCData) do DeleteEntity(v.Ped) end
    for k, v in pairs(AllNPCData) do DeleteEntity(v.Prop) end
    ClearPedTasksImmediately(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), false)
    exports['mythic_notify']:DoHudText('error', 'คุณได้ปล้น NPC')
    Selling = false
end

function ThifeByNPC(NPCPED)
    Selling = true
    exports['mythic_notify']:DoHudText('error', 'ผู้ปราบปรามยาเสพติดในเมืองมีไม่เพียงพอ')
    FreezeEntityPosition(PetnearbyObject, true)
    FreezeEntityPosition(PlayerPedId(), true)
    LoadAnimDict('random@mugging3')
    TaskPlayAnim(PlayerPedId(), "random@mugging3" ,"handsup_standing_base" ,6.0, -6.0, -1, 49, 0, 0, 0, 0)
    local PedHeading    = GetEntityHeading(PlayerPedId())
    local PlayerX,PlayerY,PlayerZ 	= table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.5, 0.0))
    local NPCCoords     = GetEntityCoords(NPCPED)
    local PropGunkey 	= GetHashKey("w_pi_sns_pistolmk2")
    local ThiefGunprop = CreateObject(PropGunkey, NPCCoords.x, NPCCoords.y, NPCCoords.z, true, false, false)
    AttachEntityToEntity(ThiefGunprop, NPCPED, GetPedBoneIndex(NPCPED, 57005), 0.17, 0.02, 0.0, 280.0, 0.0, 0.0, true, false, false, true, 1, true)
    table.insert(AllNPCData,{Prop = ThiefGunprop})
    LoadAnimDict('random@countryside_gang_fight')
    TaskPlayAnim(NPCPED, "random@countryside_gang_fight" ,"biker_02_stickup_loop" ,8.0, -8.0, -1, 1, 0, false, false, false )
    SetEntityCoords(NPCPED,PlayerX,PlayerY,PlayerZ-1)
    SetEntityHeading(NPCPED,PedHeading-180)
    TriggerServerEvent(FewZ..':Removethief')
    Citizen.Wait(5000)
    for k, v in pairs(AllNPCData) do DeleteEntity(v.Ped) end
    for k, v in pairs(AllNPCData) do DeleteEntity(v.Prop) end
    ClearPedTasksImmediately(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), false)
    exports['mythic_notify']:DoHudText('error', 'คุณโดนปล้น')
    Selling = false
end

function StartSellDrug()
    Selling = true
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local PropBagkey 		= GetHashKey("prop_security_case_01")
    local PropSellBag = CreateObject(PropBagkey, playerCoords.x, playerCoords.y, playerCoords.z, true, false, false)
    AttachEntityToEntity(PropSellBag, playerPed, GetPedBoneIndex(playerPed, 57005), 0.10, 0.0, 0.0, 0.0, 280.0, 53.0, true, false, false, true, 1, true)
    table.insert(AllNPCData,{Prop = PropSellBag})
    FreezeEntityPosition(PlayerPedId(), true)
    LoadAnimDict('anim@amb@nightclub@mini@dance@dance_solo@male@var_a@')
    TaskPlayAnim(PlayerPedId(), "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@" ,"low_center" ,8.0, -8.0, -1, 1, 0, false, false, false )
    Citizen.Wait(Config['SellTime']*1000)
    ClearPedTasksImmediately(PlayerPedId())
    Config['ExecuteClient']()
    if math.random(1,100) <= Config['Rate'] then
        TriggerServerEvent(FewZ..':andmoney')
        FreezeEntityPosition(PlayerPedId(), false)
        for k, v in pairs(AllNPCData) do DeleteEntity(v.Ped) end
        for k, v in pairs(AllNPCData) do DeleteEntity(v.Prop) end
        Selling = false
    else 
        AlertCop()
        startCallpolice()  
        exports['mythic_notify']:DoHudText('error', 'เป้าหมายไม่รับซื้อของของคุณ')
        LoadAnimDict('stungun@standing')
        TaskPlayAnim(PlayerPedId(), "stungun@standing" ,"damage" ,8.0, -8.0, -1, 1, 0, false, false, false )
        Citizen.Wait(Config['FreezeTime']*1000)
        FreezeEntityPosition(PlayerPedId(), false)
        ClearPedTasksImmediately(PlayerPedId())
        for k, v in pairs(AllNPCData) do DeleteEntity(v.Ped) end
        Citizen.Wait(Config['เวลากระเป๋าที่อยู่ในมือ'])
        for k, v in pairs(AllNPCData) do DeleteEntity(v.Prop) end
        Selling = false
    end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3000)
		local playerCoords = GetEntityCoords(PlayerPedId())
		streetName,_ = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
		streetName = GetStreetNameFromHashKey(streetName)
	end
end)


AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(AllNPCData) do DeleteEntity(v.Ped) end
        for k, v in pairs(AllNPCData) do DeleteEntity(v.Prop) end
	end
end)

if Config['UseDebug'] then
    for k, v in pairs(Config['SellCoords']) do
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(5)
                DrawMarker(1, v.x,v.y,v.z-1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config['CreateNPCDistance']+30, Config['CreateNPCDistance']+30, 0.8, 255, 0, 0, 100, false, false, 2, false, false, false, false)
            end
        end)
        DebugBlip = AddBlipForCoord(v.x,v.y,v.z)
        SetBlipSprite(DebugBlip, 51)
        SetBlipColour(DebugBlip, 1)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('DebugBlip SellDrug')
        EndTextCommandSetBlipName(DebugBlip)
    end
end

function AlertCop()
    TriggerEvent(Config['แจ้งตำรวจ'], Config['อีเว้นท์ที่แจ้ง'])
end

function startCallpolice()
	local playerPed = PlayerPedId()
	PedPosition		= GetEntityCoords(playerPed)
	local PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z }
    TriggerServerEvent('esx_addons_gcphone:startCall', 'police', 'มีคนขายยา อยู่ที่', PlayerCoords, {
		PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z },
	})
end

RegisterNetEvent(FewZ..':notify')
AddEventHandler(FewZ..':notify', function(type, message)
    exports['mythic_notify']:DoHudText(type, message)
end)