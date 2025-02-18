ESX = exports["es_extended"]:getSharedObject()

local cachedBins = {}
local FewZ = GetCurrentResourceName()
local ShowHelp = true

AddEventHandler("Fewthz_core:ClientMemoryGarbage", function()
	Citizen.CreateThread(function()
		Wait(math.random(100, 2000))
		collectgarbage()
	end)
end)

Citizen.CreateThread(function()

    while true do
        Wait(3)
        local FewLoop = true
        local entity, entityDst = GetNearChair()

        if DoesEntityExist(entity) and entityDst <= 3.0 then
            FewLoop = false

            local binCoords = GetEntityCoords(entity)

            if not cachedBins[entity] then
                if ShowHelp then
					ShowToolTip('<font face="sarabun">กด ~b~[E] ~w~จี่ ~b~เหล็ก</font>', binCoords + vector3(0,0,1.2))
				end
                if IsControlJustReleased(0, 38) and ShowHelp then

                    ShowHelp = false

			    	checkHasItem(Config['ไอเท็มที่ใช้ทำงาน'])
			    	if canuse == Config['ใช้ไอเท็มเก็บ'] then
                    local binCoords = GetEntityCoords(entity)
                    if not cachedBins[entity] then
                        cachedBins[entity] = true
                        OpenTrashCan()
                    end
			    	canuse = false					
                end
            end
        else
            ShowToolTip('<font face="sarabun">~r~ไม่สามารถจี่ซ้ำได้</font>', binCoords + vector3(0,0,1.2))
        end

        end

        if FewLoop then
            Wait(2000)
        end
    end
end)

function GetNearChair()
	local entity, entityDst
	local coords = GetEntityCoords(PlayerPedId())
	for i=1, #Config['พร็อบ'] do
		entity = GetClosestObjectOfType(coords, 3.0, GetHashKey(Config['พร็อบ'][i]), false, false, false)
		entityDst = #(coords - GetEntityCoords(entity))
		if entityDst < 3.0 then
			return entity, entityDst
		end
	end
	return nil, nil
end

function checkHasItem (item_name)

	local inventory = ESX.GetPlayerData().inventory
	for i=1, #inventory do
	  local item = inventory[i]
	  if item_name == item.name and item.count > 0 then

			canuse = true
		return true
	  end
	end
	if Config['ใช้ไอเท็มเก็บ'] then 
	TriggerEvent("pNotify:SendNotification",{
			text = " <center><b style='color:white'> คุณไม่มี บัตรทำงาน</b><br /></center>",
			type = "error",
			timeout = (3000),
			layout = "bottomCenter",
			queue = "global"
		})
	end
	canuse = false

	return false
end
                
function OpenTrashCan()
    TaskStartScenarioInPlace(PlayerPedId(), "world_human_welding", 0, true)
	TriggerEvent("mythic_progbar:client:progress", {
        name = "unique_action_name",
        duration = Config['เวลาจี่'],
        label = "กำลังตัดเหล็ก...",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        prop = {
        }
    }, function(status)
        if not status then
            TriggerServerEvent(FewZ ..':retrieve')
            ClearPedTasksImmediately(PlayerPedId())
            ShowHelp = true
        end
    end)
end

Citizen.CreateThread(function()
    if Config.Zone.Blips.Open then
	    local Config1 = Config.Zone
	    local blip1 = AddBlipForCoord(Config1.Pos.x, Config1.Pos.y, Config1.Pos.z)

	    SetBlipSprite (blip1, Config1.Blips.Id)
	    SetBlipDisplay(blip1, 4)
	    SetBlipScale  (blip1, Config1.Blips.Size)
	    SetBlipColour (blip1, Config1.Blips.Color)
	    SetBlipAsShortRange(blip1, true)

	    BeginTextCommandSetBlipName("STRING")
	    AddTextComponentString(Config1.Blips.Text)
	    EndTextCommandSetBlipName(blip1)
    end
end)

ShowToolTip = function (msg, x,y,z)
    AddTextEntry('Steel', msg)
    SetFloatingHelpTextWorldPosition(1, x,y,z)
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
    BeginTextCommandDisplayHelp('Steel')
    EndTextCommandDisplayHelp(2, false, false, -1)
end