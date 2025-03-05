ESX = exports['es_extended']:getSharedObject()
FewZ = GetCurrentResourceName()

-- @ Work

local ShowHelp = true

checkInventory = function(itemName)
	for k,v in pairs(ESX.GetPlayerData().inventory) do
		if v.name == itemName then
			return v;
		end
	end

	return nil
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local canSleep  = true
		for k , v in pairs(Config.Zone) do
			local coords = GetEntityCoords(PlayerPedId())
			local playerPed = PlayerPedId()
			if GetDistanceBetweenCoords(coords, Config.Zone[k].Pos.x, Config.Zone[k].Pos.y, Config.Zone[k].Pos.z, true) < 2 then
				canSleep = false
				if ShowHelp then
					exports["Fewthz_TextUI"]:ShowHelpNotification('<font face="sarabun">'..Config.Zone[k].Alert.DisplayHelpText..'</font>')
				end
				if IsControlJustPressed(0, Config.Zone[k].KeyBinds.Start) and ShowHelp then
					if exports['Fewthz_Check']:CheckItem(Config.Zone[k].Item.Request.Name, Config.Zone[k].Item.Request.Count) then
						ShowHelp = false

						FreezeEntityPosition(PlayerPedId(), true)

						TriggerEvent(FewZ..':Start', k)

						itemList = {}
						local header = "PROCESS"
						local itemone = Config.Zone[k].Item.Request.Name
						local itemoneneed = Config.Zone[k].Item.Request.Count
						local itemtwo = Config.Zone[k].Item.Get.Name
						local itemtwogive = Config.Zone[k].Item.Get.Count
						local time = Config.Zone[k].Duration
						local textone = Config.Zone[k].Item.Request.Text
						local texttwo = Config.Zone[k].Item.Get.Text

						for k, v in pairs(Config.Zone[k].Item.Bonus) do
							table.insert(
								itemList,
								{
									key = k,
									itemname = v.ItemName
								}
							)
						end

						SetNuiFocus(true, true)
    					SendNUIMessage(
    					    {
    					        action = "Start_Process",
    					        name = header,
    					        duration = time,
    					        itemone = itemone,
    					        itemtwo = itemtwo,
    					        itemoneneed = itemoneneed,
    					        itemtwogive = itemtwogive,
    					        textone = textone,
    					        texttwo = texttwo,
    					        bonus = itemList,
								texturl = Config.Img,
    					    }
    					)

					else
						TriggerEvent("pNotify:SendNotification", {
							text = 'ไอเทมของคุณมีไม่เพียงพอ',
							type = "error",
							timeout = 5000,
							layout = "centerRight",
							queue = "global"
						})
					end
				elseif IsControlJustPressed(0, Config.Zone[k].KeyBinds.Stop) and not ShowHelp then
					TriggerEvent(FewZ..':Stop')
				end
			end
		end
		if canSleep then
			Citizen.Wait(500)
		end
	end
end)

-- @ Get Function

function AutoProcess(k)
	if not ShowHelp then
		repeat
			if exports['Fewthz_Check']:CheckItem(Config.Zone[k].Item.Request.Name, Config.Zone[k].Item.Request.Count) then
				Config.Zone[k].Process(Config.Zone[k].Duration, k)
			else
				TriggerEvent(FewZ..':Stop')

			end
			Citizen.Wait(Config.Zone[k].Duration + 500)
		until ShowHelp == true
	end
end

RegisterNetEvent(FewZ..':Start', AutoProcess)

function StopAutoProcess()
	if not ShowHelp then

		TriggerEvent("mythic_progbar:client:cancel")

		FreezeEntityPosition(PlayerPedId(), false)
		
		ShowHelp = true

		SetNuiFocus(false, false)
        SendNUIMessage({action = "Process_Cancel"})

		TriggerEvent("pNotify:SendNotification", {
			text = 'โพรเซส เรียบร้อยแล้ว',
			type = "success",
			timeout = 5000,
			layout = "centerRight",
			queue = "global"
		})
	end
end

RegisterNetEvent(FewZ..':Stop', StopAutoProcess)

RegisterNUICallback("Exit",function()
    SetNuiFocus(false, false)
    SendNUIMessage({action = "Process_Cancel"})
    StopAutoProcess()
end)


function Get(k)
	-- @ Remove To Player
	TriggerServerEvent(FewZ..':Remove', Config.Zone[k].Item.Request.Name, Config.Zone[k].Item.Request.Count)
	-- @ Give To Player
	TriggerServerEvent(FewZ..':Get', Config.Zone[k].Item.Get.Name, Config.Zone[k].Item.Get.Count, Config.Zone[k].Alert.Discord, k)
end


-- @ Various

Citizen.CreateThread(function()
    for k , v in pairs(Config.Zone) do
		RequestModel(GetHashKey(Config.Zone[k].NPC.ModelName))
		while not HasModelLoaded(GetHashKey(Config.Zone[k].NPC.ModelName)) do
			Wait(1)
		end
        if Config.Zone[k].NPC.Show then
			ped =  CreatePed(4, Config.Zone[k].NPC.ModelHash ,Config.Zone[k].Pos.x, Config.Zone[k].Pos.y, Config.Zone[k].Pos.z-1, 3374176, false, true)
			SetEntityHeading(ped, Config.Zone[k].Pos.w)
			FreezeEntityPosition(ped, true)
			SetEntityInvincible(ped, true)
			SetBlockingOfNonTemporaryEvents(ped, true)
			TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
        end
    end
end)


Citizen.CreateThread(function()
    for k , v in pairs(Config.Zone) do
        if Config.Zone[k].Blip.Use then
            local blip = AddBlipForCoord(Config.Zone[k].Pos.x, Config.Zone[k].Pos.y, Config.Zone[k].Pos.z)
            SetBlipSprite(blip, Config.Zone[k].Blip.Sprite)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, Config.Zone[k].Blip.Scale)
            SetBlipColour(blip, Config.Zone[k].Blip.Color)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(Config.Zone[k].Blip.Name)
            EndTextCommandSetBlipName(blip)
        end
    end
end)

AddEventHandler("Fewthz_core:ClientMemoryGarbage", function()
	Citizen.CreateThread(function()
		Wait(math.random(100, 2000))
		collectgarbage()
	end)
end)