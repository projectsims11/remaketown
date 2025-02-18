
ESX = nil
ESX = exports['es_extended']:getSharedObject()

local PlayerData = {}
local redzoneready = false
local zoneradis = 100.0
local zonerange = 100
local inreadzone = false
local PlayerData              = {}
local kerfil = false

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	TriggerServerEvent('redzone:firstSpawn')
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)



RegisterNetEvent('curfew_council:start1')
AddEventHandler('curfew_council:start1', function()
	if kerfil == false then
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'fewz_curfew',
		{
			title = "สถานที่"
		}, function(data, menu)
		
			local result = tostring(data.value)
		
			if result == "nil" then
				exports.pNotify:SendNotification({
					text = "ค่าไม่ถูกต้อง",
					type = "error", theme= "mint", timeout = 7000, layout = "bottomCenter",
				})
			else
				menu.close()
				TriggerServerEvent('fewz_curfew:send1',result)
			end
		
		end, function(data, menu)
			menu.close()
		end)
	else
			YesorNo()
	end
	print('curfew')
end)

function YesorNo()

    	ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'panic',
        {
          title = 'ยกเลิกเคอร์ฟิว',
          align = 'center',
          elements = {
            {label = 'ใช่', value = 'yes'},
            {label = 'ไม่',  value = 'no'},
          },
        },
        function (data, menu)
          if data.current.value == 'yes' then   
			TriggerServerEvent('fewz_curfew:send1', '')
			menu.close()			
          end
			
          if data.current.value == 'no' then			
				menu.close()			
          end

        end,
        function (data, menu)
          menu.close()
        end
      )
end

local location = {}

RegisterNetEvent('redzone:setposition1')
AddEventHandler('redzone:setposition1', function(result)
	x1,y1,z1 = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
	TriggerServerEvent('redzone:sentlocation1', x1,y1,z1,result)
end)

local results = ''

RegisterNetEvent('redzone:stopredzone1')
AddEventHandler('redzone:stopredzone1', function()
	kerfil = false
	if location[0] ~= nil then
		--exports.pNotify:SendNotification({
		--	text = "<span style='color:OrangeRed'>*โซนอันตราย*</span><br><span style='color:Red'>ประกาศเคอร์ฟิว  </span><span style='color:Gold'>"..results.."</span><br> ได้ถูกยกเลิกแล้ว",
		--	type = "alert", theme= "gta", timeout = 10000, layout = "topCenter",
		--})
		exports['okokNotify']:Alert("", "<span style='color:OrangeRed'>*โซนอันตราย*</span><br><span style='color:Red'>ประกาศเคอร์ฟิว  </span><span style='color:Gold'>"..results.."</span><br> ได้ถูกยกเลิกแล้ว", 10000, 'warning')
		TriggerEvent('chatMessage', "สภา ", {255, 0, 0}, "^8ประกาศยกเลิกเคอร์ฟิว ^3"..results)
		RemoveBlip(location[0].blip)
		location[0] = nil
	end
end)

RegisterNetEvent('redzone:createForAll1')
AddEventHandler('redzone:createForAll1', function(x2,y2,z2,result)
	results = result
	kerfil = true
	local textStreet = ""
	local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }
	local pos = GetEntityCoords(GetPlayerPed(-1))
	local var1, var2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
	local current_zone = zones[GetNameOfZone(pos.x, pos.y, pos.z)]
	if tostring(GetStreetNameFromHashKey(var2)) == "" then
		textStreet = "<span style='color:OrangeRed'>*โซนอันตราย*</span> <br><span style='color:Red'>ประกาศเคอร์ฟิว </span><span style='color:Gold'>"..result.."</span><br>โดย: <span style='color:OrangeRed'>[เจ้าหน้าที่สภา]</span><br><span style='color:White'>ผู้ไม่เกี่ยวข้องออกจากพื้นที่ใน 30 วินาที</span>"
		TriggerEvent('chatMessage', "สภา ", {255, 0, 0}, "^8ประกาศเคอร์ฟิว ^3 "..result.." ^8ขอให้ประชาชนที่ไม่เกี่ยวข้องออกจากพื้นที่ด้วยครับ!!")
		location[0] = { x=x2,y=y2,z=z2-220.0,streetname=tostring(GetStreetNameFromHashKey(var1)),zone=current_zone }
		location[0].blip = AddBlipForRadius(x2, y2, z2,zoneradis) 
		SetBlipColour(location[0].blip,1)
		SetBlipAlpha(location[0].blip,100)
	else 
		textStreet = "<span style='color:OrangeRed'>*โซนอันตราย*</span> <br><span style='color:Red'>ประกาศเคอร์ฟิว </span><span style='color:Gold'>"..result.."</span><br>โดย: <span style='color:OrangeRed'>[เจ้าหน้าที่สภา]</span><br><span style='color:White'>ผู้ไม่เกี่ยวข้องออกจากพื้นที่ใน 30 วินาที</span>"
		TriggerEvent('chatMessage', "สภา ", {255, 0, 0}, "^8ประกาศเคอร์ฟิว ^3 "..result.." ^8ขอให้ประชาชนที่ไม่เกี่ยวข้องออกจากพื้นที่ด้วยครับ!!")
		location[0] = { x=x2,y=y2,z=z2-220.0,streetname=tostring(GetStreetNameFromHashKey(var1)),zone=current_zone }
		location[0].blip = AddBlipForRadius(x2, y2, z2,zoneradis) 
		SetBlipColour(location[0].blip,1)
		SetBlipAlpha(location[0].blip,100)
	end
	exports['okokNotify']:Alert("", textStreet, 10000, 'warning')
	--exports.pNotify:SendNotification({
	--	text = textStreet,
	--	type = "alert", theme= "gta", timeout = 10000, layout = "topCenter",
	--})
	local dist= GetDistanceBetweenCoords(pos,x2, y2, z2, false)
	if dist < zoneradis then
		redzoneready = true
		inreadzone = true
	end
end)



Citizen.CreateThread(function()
	while true do
	Citizen.Wait(1)
	local canSleep  = true
		for k,pos in pairs(location) do
			canSleep = false
			rgb = RGBRainbow(1)
			DrawMarker(1, pos.x, pos.y, pos.z , 0, 0, 0, 0, 0, 0, 200.0001, 200.0001, 400.0001, 1000, 0, 0, rgb.r, rgb.g, rgb.b, 0.4,0)
		end
		if canSleep then
			Citizen.Wait(500)
		end
	end
end)

local zones = location




Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end
	
	while true do
		Citizen.Wait(100)
		local playerPed = GetPlayerPed(-1)
		local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
		local minDistance = 100000
		for i = 1, #location, 1 do
			dist = Vdist(location[i].x, location[i].y, location[i].z, x, y, z)
			if dist < minDistance then
				minDistance = dist
				closestZone = i
			end
		end
	end
end)

function RGBRainbow(frequency)
    local result = {}
    local curtime = GetGameTimer() / 1000

    result.r = math.floor(math.sin(curtime * frequency + 0) * 127 + 128)
    result.g = math.floor(math.sin(curtime * frequency + 2) * 127 + 128)
    result.b = math.floor(math.sin(curtime * frequency + 4) * 127 + 128)

    return result
end


Citizen.CreateThread(function()
	local function GetPedVehicleSeat()
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		for i=-2,GetVehicleMaxNumberOfPassengers(vehicle) do
			if(GetPedInVehicleSeat(vehicle, i) == playerPed) then return i end
		end
		return -2
	end
	while true do
		Citizen.Wait(1000)
		if next(location) == nil then
			Citizen.Wait(5000)
		end
		
		local playerCoords = GetEntityCoords(playerPed)
		for k,pos in pairs(location) do
			local dist= GetDistanceBetweenCoords(playerCoords,pos.x, pos.y, pos.z, false)
			local _, roadCoords = GetClosestRoad(PlayerPedId())
			if dist < zoneradis and not redzoneready  then -- ระยะวงแดง
				local heading, vector = GetNthClosestVehicleNodeFavourDirection(playerCoords.x, playerCoords.y, playerCoords.z, pos.x, pos.y, pos.z, math.floor((zoneradis*2)-dist), 1, 0, 1, 0x40400000, 0);
				if (IsPedInAnyVehicle(GetPlayerPed(-1), false) and GetPedVehicleSeat(GetPlayerPed(-1)) == -1) then
					if ( not DoesEntityExist( veh ) ) then 
						local ped = GetPlayerPed( -1 )
	
						if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
							local pos = GetEntityCoords( ped )
					
							if ( IsPedSittingInAnyVehicle( ped ) ) then 
								local vehicle = GetVehiclePedIsIn( ped, false )
					
								if ( GetPedInVehicleSeat( vehicle, -1 ) == ped ) then 
									DeleteGivenVehicle( vehicle, numRetries )
								end 
							end 
						end 
					end

					FreezeEntityPosition(GetPlayerPed(-1), true)
					exports.pNotify:SendNotification({
						text = "ห้ามเข้าวงแดง วิ่งออกไป",
						type = "error",
						timeout = 5000,
						layout = "bottomCenter"
					})
					Citizen.Wait(5000)
					ClearPedSecondaryTask(ped)
					FreezeEntityPosition(GetPlayerPed(-1), false)

				else
					FreezeEntityPosition(GetPlayerPed(-1), true)
					exports.pNotify:SendNotification({
						text = "ห้ามเข้าวงแดง  วิ่งออกไป",
						type = "error",
						timeout = 5000,
						layout = "bottomCenter"
					})
					Citizen.Wait(5000)
					ClearPedSecondaryTask(ped)
					FreezeEntityPosition(GetPlayerPed(-1), false)
				end
			elseif dist > zoneradis and redzoneready then
				redzoneready = nil
				inreadzone = false
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		playerPed = PlayerPedId()
		Citizen.Wait(1000)
	end
end)


function DeleteGivenVehicle( veh, timeoutMax )
    local timeout = 0 

    SetEntityAsMissionEntity( veh, true, true )
    DeleteVehicle( veh )

    if ( DoesEntityExist( veh ) ) then
        while ( DoesEntityExist( veh ) and timeout < timeoutMax ) do 
            DeleteVehicle( veh )

            timeout = timeout + 1 
            Citizen.Wait( 500 )
        end 
    end 
end 

AddEventHandler("Fewthz_core:ClientMemoryGarbage", function()
	Citizen.CreateThread(function()
		Wait(math.random(100, 2000))
		collectgarbage()
	end)
end)