local zones = {
	{
		vector3(1728.6199951171875, 3313.43994140625, 41.52999877929687),
	}
	
}

local range 		= 100.0
local closestZone 	= 1
local closestZonej 	= 1

Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end
	for i = 1, #zones, 1 do
		for j = 1, #zones[i], 1 do
			local blip = AddBlipForRadius(zones[i][j].x, zones[i][j].y, zones[i][j].z, zones[i].size or range)
		
			SetBlipColour(blip,59)
			SetBlipAlpha(blip,180)
		end
	end
end)

Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end
	while true do
		Citizen.Wait(100)
		local playerPed = GetPlayerPed(-1)
		local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
		local minDistance = 100000
		for i = 1, #zones, 1 do
			for j = 1, #zones[i], 1 do
				dist = Vdist(zones[i][j].x, zones[i][j].y, zones[i][j].z, x, y, z)
				if dist < minDistance then
					minDistance = dist
					closestZone = i
					closestZonej = j
				end
			end
		end
	end
end)
