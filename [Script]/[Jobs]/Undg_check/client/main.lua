ESX = nil
Xenon = GetCurrentResourceName()

Ambulance = 0
Police = 0
Council = 0
Taxi = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	Citizen.Wait(2000)
	ESX.TriggerServerCallback(Xenon..'getConnectedPlayers', function(connectedPlayers)
		UpdatePlayerTable(connectedPlayers)
	end)
end)

RegisterNetEvent(Xenon..'updateConnectedPlayers')
AddEventHandler(Xenon..'updateConnectedPlayers', function(connectedPlayers)
	UpdatePlayerTable(connectedPlayers)
end)

RegisterNetEvent(Xenon..'UpdateXenon')
AddEventHandler(Xenon..'UpdateXenon', function(EMS,Police1,council,taxi)
	Ambulance = EMS
	Police = Police1
	Council = council
	taxi = taxi
end)

function UpdatePlayerTable(connectedPlayers)
	local formattedPlayerList, num = {}, 1
	local ems, police, taxi, council, cardealer, estate, players = 0, 0, 0, 0, 0, 0, 0
	for k,v in pairs(connectedPlayers) do
		if num == 1 then
			table.insert(formattedPlayerList, ('<tr><td>%s</td><td>%s</td><td>%s</td>'):format(v.name, v.id, v.ping))
			num = 2
		elseif num == 2 then
			table.insert(formattedPlayerList, ('<td>%s</td><td>%s</td><td>%s</td></tr>'):format(v.name, v.id, v.ping))
			num = 1
		end
		players = players + 1
		if v.job == 'ambulance' then
			ems = ems + 1
		elseif v.job == 'police' then
			police = police + 1
		elseif v.job == 'taxi' then
			taxi = taxi + 1
		elseif v.job == 'council' then
			council = council + 1
		elseif v.job == 'cardealer' then
			cardealer = cardealer + 1
		elseif v.job == 'realestateagent' then
			estate = estate + 1
		end
	end
	TriggerEvent(Xenon..'UpdateXenon',ems,police,council,taxi)
end

function CheckAmbulance(Amount)
	if Ambulance >= Amount then
		return true
	end
	return false
end

function CheckPolice(Amount)
	if Police >= Amount then
		return true
	end
	return false
end

function Check(job)
	if job == 'police' then
		return Police
	elseif job == 'ambulance' then
		return Ambulance
	elseif job == 'council' then
		return Council
	end
end

function CheckTaxi(Amount)
	if Taxi >= Amount then
		return true
	end
	return false
end