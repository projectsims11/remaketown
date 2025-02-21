ESX                           = nil
local PlayerData              = {}
local location                = {}
local results                 = ''

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	TriggerServerEvent('curfew_Police:firstSpawn')
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

RegisterKeyMapping('openPanic', 'Menu Curfew', 'keyboard', 'F11')

RegisterCommand('openPanic', function()
    if not IsPlayerDead(PlayerId()) then
        if PlayerData.job and PlayerData.job.name == 'police' then
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'panic', 
                {
                    title = 'เคอร์ฟิว',
                    align = 'right',
                    elements = {
                        {label = 'เริ่มเคอร์ฟิว', value = 'curfew'},
                        {label = 'ยกเลิกเคอร์ฟิว',  value = 'cancle'},
                    }, 
                },
                function (data, menu)
                    if data.current.value == 'curfew' then
                        OpenCurfew()
                        menu.close()
                    elseif data.current.value == 'cancle' then
                        OpenCancleCurfew()
                        menu.close()
                    end
                end,
            function (data, menu)
                menu.close()
            end)
        end
    end
end)

function OpenCurfew()
    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'curfew', { title = ('สถานที่')}, function(data, menu)
    local result = data.value
        if result == nil then
            exports['Notify']:Notification({
                position = 'middleRight', --------- ซ้ายกลาง
                title ='ผิดพลาด',
                description = "กรุณาใส่ลายละเอียด",
                type ='alert',
                time = 5000,
            })
            -- exports['Arthur_notify']:MsgNotification({ msg = 'กรุณาใส่ลายละเอียด', type = 1, wait = 3, })
        else
            TriggerEvent('curfew_Police:setposition', result)
            TriggerEvent('curfew_Police:SendPlayers', 3, result)
            menu.close()
        end
    end, function(data, menu)
        menu.close()
    end)
end

function OpenCancleCurfew()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'panic_cancle',
    {
      title = 'ยกเลิกเคอร์ฟิว',
      align = 'right',
      elements = {
        {label = 'ตกลง', value = 'yes'},
        {label = 'ไม่',  value = 'no'},
      },
    },
    function (data, menu)
        if data.current.value == 'yes' then
            TriggerEvent('curfew_Police:stopredzone')
            menu.close()			
        elseif data.current.value == 'no' then			
            menu.close()			
        end
    end, function (data, menu)
        menu.close()
    end)
end

RegisterNetEvent('curfew_Police:setposition')
AddEventHandler('curfew_Police:setposition', function(result)
	x1,y1,z1 = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
	TriggerServerEvent('curfew_Police:sentlocation', x1,y1,z1,result)
end)

RegisterNetEvent('curfew_Police:stopredzone')
AddEventHandler('curfew_Police:stopredzone', function()
	if location[0] ~= nil then
		TriggerEvent('curfew_Police:SendPlayers', 4)
		RemoveBlip(location[0].blip)
		location[0] = nil
	end
end)

RegisterNetEvent('curfew_Police:createForAll')
AddEventHandler('curfew_Police:createForAll', function(x2,y2,z2,result)
	local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }
	local pos = GetEntityCoords(GetPlayerPed(-1))
	local var1, var2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
	local current_zone = zones[GetNameOfZone(pos.x, pos.y, pos.z)]
	if tostring(GetStreetNameFromHashKey(var2)) == "" then
        TriggerEvent('chatMessage', "ประกาศเคอร์ฟิว ", {255, 0, 0}, "^7ประกาศเคอร์ฟิว ^3"..result.." ^7ขอให้ประชาชนที่ไม่เกี่ยวข้องออกจากพื้นที่!!")
        location[0] = { x=x2,y=y2,z=z2-220.0,streetname=tostring(GetStreetNameFromHashKey(var1)),zone=current_zone }
		location[0].blip = AddBlipForRadius(x1, y1, z1,100.0) 
		SetBlipColour(location[0].blip,1)
		SetBlipAlpha(location[0].blip,100)
	else
        TriggerEvent('chatMessage', "ประกาศเคอร์ฟิว ", {255, 0, 0}, "^7ประกาศเคอร์ฟิว ^3"..result.." ^7ขอให้ประชาชนที่ไม่เกี่ยวข้องออกจากพื้นที่!!")
        location[0] = { x=x2,y=y2,z=z2-220.0,streetname=tostring(GetStreetNameFromHashKey(var1)),zone=current_zone }
		location[0].blip = AddBlipForRadius(x1, y1, z1,100.0) 
		SetBlipColour(location[0].blip,1)
		SetBlipAlpha(location[0].blip,100)
	end
end)

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(1)
		for k,pos in pairs(location) do
			rgb = RGBRainbow(1)
			DrawMarker(1, pos.x, pos.y, pos.z , 0, 0, 0, 0, 0, 0, 400.0001, 400.0001, 400.0001, 1000, 0, 0, rgb.r, rgb.g, rgb.b, 0.4,0)
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

RegisterCommand('pd_blackout', function()
	if not IsPlayerDead(PlayerId()) then
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
			TriggerEvent('curfew_Police:SendPlayers', 5)
		end
	end
end, false)

RegisterNetEvent('curfew_Police:SendPlayers', function(type, result)
    if (type == 1) then
        SendNUIMessage(
            {
                type = "POLICE_ANM",
                typeanm = "curfew",
                cerfew = "เรเบลท่าเรือล่าง",
            }
        )
    elseif (type == 2) then
        SendNUIMessage(
            {
                type = "POLICE_ANM",
                typeanm = "curfew",
                cerfew = "เรเบลทะเลทราย",
            }
        )
    elseif (type == 3) then
        SendNUIMessage(
            {
                type = "POLICE_ANM",
                typeanm = "curfew",
                cerfew = result,
            }
        )
	elseif (type == 4) then
        SendNUIMessage(
            {
                type = "POLICE_ANM",
                typeanm = "uncerfew",
                cerfew = "All",
            }
        )
    elseif (type == 5) then
        SendNUIMessage(
            {
                type = "POLICE_ANM",
                typeanm = "blackout",
            }
        )
    end
end)
