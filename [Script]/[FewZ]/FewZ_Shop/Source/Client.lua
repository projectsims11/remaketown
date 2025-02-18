ESX = SERVER.Framework

local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local PlayerData              = {}

function OpenShopMenu(zone)

	TriggerServerEvent('FewZ_Shop:balance')
	ESX.TriggerServerCallback('FewZ_Shop:canOpen', function( useAble, text )
		if not useAble then
			-- ไม่สามารถใช้ร้านค้านี่ได้
			TriggerEvent("pNotify:SendNotification", {
				text = text,
			   type = 'warning',
			   timeout = PNOTIFY_SETTING.TIME * 1000,
			   layout = PNOTIFY_SETTING.LAYOUT
		   })
			return 
		end		

		TriggerScreenblurFadeIn()
		PlayerData = ESX.GetPlayerData()
		SendNUIMessage({
			message		= "show",
			clear = true
		})
	

		
		local elements = {}

		local Zone = GlobaConfig["Zones"][zone]

		if Zone == nil then
			return print('Zone is nil')
		end



		local Items = Zone.Items

		if Items == nil then
			return print('Items is nil')
		end

		for k , item in pairs(Items) do

			if item.limit == -1 or not item.limit then
				item.limit = 100
			end

			SendNUIMessage({
				message		= "add",
				item		= item.item,
				label      	= item.label,
				price      	= item.price,
				max        	= item.limit,
				loc			= zone,
				img 		= MARKET_SETTING.PATH_IMG
			})

			if  Secure.Debug_mode then
				print("\n^1[ ^7- ^1] ^7DEBUG IN GAME ^7( ^5OPEN SHOP ^1& ^5AND LOAD DATA ^7 )")
				print("^1[ ^7"..GetCurrentResourceName().." ^1] CHECK SHOP ^7( ^5"..zone.."^7 )")
				print("^1[ ^7"..GetCurrentResourceName().." ^1] CHECK ITEM ^7( ^5"..item.item.."^7 )")
				print("^1[ ^7"..GetCurrentResourceName().." ^1] CHECK LABEL ^7( ^5"..item.label.."^7 )")
				print("^1[ ^7"..GetCurrentResourceName().." ^1] CHECK PRICE ^7( ^5"..item.price.."^7 )\n")
			end

		end
		
		ESX.SetTimeout(200, function()
			SetNuiFocus(true, true)
		end)

	end, zone)

end

AddEventHandler('FewZ_Shop:hasEnteredMarker', function(zone)
	CurrentAction     = 'shop_menu'
	
	CurrentActionData = {zone = zone}
end)

AddEventHandler('FewZ_Shop:hasExitedMarker', function(zone)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

Citizen.CreateThread(function()
	for k,v in pairs(GlobaConfig["Zones"]) do
		for i = 1, #v.Pos, 1 do
			if v.CustomBlip then
				local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)
				SetBlipSprite (blip, v.CustomBlip.Blip)
				SetBlipDisplay(blip, 4)
				SetBlipScale  (blip, v.CustomBlip.Scale)
				SetBlipColour (blip, v.CustomBlip.Color)
				SetBlipAsShortRange(blip, true)
				AddTextComponentString(v.CustomBlip.Text)
				AddTextEntry('BLIP_SHOP_1', v.CustomBlip.Text)
				BeginTextCommandSetBlipName("BLIP_SHOP_1")
				EndTextCommandSetBlipName(blip)
			else
				if v.ShowBlip == true then
					local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)
					SetBlipSprite (blip, 52)
					SetBlipDisplay(blip, 4)
					SetBlipScale  (blip, 0.7)
					SetBlipColour (blip, 42)
					SetBlipAsShortRange(blip, true)
					AddTextEntry('BLIP_SHOP', '<font face="sarabun">ร้านค้าทั่วไป</font>')
					BeginTextCommandSetBlipName("BLIP_SHOP")
					EndTextCommandSetBlipName(blip)
				end
			end	
		end
	end
end)

createEvent('FewZ_Shop:info', function(balance, cash)
    local id = PlayerId()
    local playerName = GetPlayerName(id)
    
    triggerNui({
        message = "moeny",
        balance = balance,
        cash = cash,
    })
end)


Citizen.CreateThread(function()
	while true do
		local sleep = 1000

		if CurrentAction ~= nil then

			if IsControlJustReleased(0, 38) then
				sleep = 0
				if CurrentAction == 'shop_menu' then
					OpenShopMenu(CurrentActionData.zone)
				end

			elseif IsControlJustReleased (0, 44) then
				ESX.SetTimeout(200, function()
					SetNuiFocus(false, false)
				end)	
			end
		end
		local coords      = GetEntityCoords(GetPlayerPed(-1))
		local isInMarker  = false
		local currentZone = nil

		for k,v in pairs(GlobaConfig["Zones"]) do		
			for i = 1, #v.Pos, 1 do
				if(GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < v.DistanceMarker) then
					sleep = 0
					DrawMarker(MARKER_SETTING.TYPE, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, MARKER_SETTING.SIZE.x, MARKER_SETTING.SIZE.y, MARKER_SETTING.SIZE.z, MARKER_SETTING.COLOR.r, MARKER_SETTING.COLOR.g, MARKER_SETTING.COLOR.b, 100, false, true, 2, false, false, false, false)
				end
				if(GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) <v.Pos[i].Distance) then
					sleep = 0
					isInMarker  = true
					ShopItems   = v.Items
					currentZone = k
					LastZone    = k

					if MARKET_SETTING.OPENTEXTUI then
						exports["Fewthz_TextUI"]:ShowHelpNotification(MARKET_SETTING.TEXT)
					else

						SetTextComponentFormat('STRING')
						AddTextComponentString(MARKET_SETTING.TEXT)
						DisplayHelpTextFromStringLabel(0, 0, 1, -1)
					end
				end
			end
		end
		if isInMarker and not HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = true
			TriggerEvent('FewZ_Shop:hasEnteredMarker', currentZone)
		end
		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('FewZ_Shop:hasExitedMarker', LastZone)
		end
		Wait(sleep)
	end
end)

function closeGui()
	TriggerScreenblurFadeOut(10000)
  	SetNuiFocus(false, false)
  	SendNUIMessage({message = "hide"})
end

RegisterNUICallback('quit', function(data, cb)
  	closeGui()
  	cb('ok')
end)

RegisterNUICallback('purchase', function(data, cb)
	TriggerServerEvent('FewZ_Shop:buyItem', data.item, data.count, data.class, data.loc)
	TriggerServerEvent('FewZ_Shop:balance')

	if  Secure.Debug_mode then
		print("\n^1[ ^7- ^1] ^7DEBUG IN GAME ^7( ^5BUY^7 )")
		print("^1[ ^7"..GetCurrentResourceName().." ^1] CHECK COUNT ^7( ^5"..data.count.."^7 )")
		print("^1[ ^7"..GetCurrentResourceName().." ^1] CHECK ITEM ^7( ^5"..data.item.."^7 )")
		print("^1[ ^7"..GetCurrentResourceName().." ^1] CHECK LOC ^7( ^5"..data.loc.."^7 )\n")
	end
	cb('ok')
end)

if MARKET_SETTING.BOXING then
	RegisterCommand(MARKET_SETTING.COMMAND, function()
		if  Secure.Debug_mode then
			print("\n^1[ ^7- ^1] ^7DEBUG IN GAME ^7( ^5COMMAND^7 )")
			print("^1[ ^7"..GetCurrentResourceName().." ^1] STATUS ^7( ^5OPEN SHOP^7 )")
		end
		OpenShopMenu("boxing")
		currentAction = nil
	end)
end

AddEventHandler("Fewthz_core:ClientMemoryGarbage", function()
	Citizen.CreateThread(function()
		Wait(math.random(100, 2000))
		collectgarbage()
	end)
end)