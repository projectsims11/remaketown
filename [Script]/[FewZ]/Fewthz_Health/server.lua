------------------------------------------
--	iEnsomatic RealisticVehicleFailure  --
------------------------------------------
--
--	Created by Jens Sandalgaard
--
--	This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
--
--	https://github.com/iEns/RealisticVehicleFailure
--



local function checkWhitelist(id)
	for key, value in pairs(RepairWhitelist) do
		if id == value then
			return true
		end
	end	
	return false
end

--AddEventHandler('chatMessage', function(source, _, message)
--	local msg = string.lower(message)
--	local identifier = GetPlayerIdentifiers(source)[1]
--	if msg == "/repair" then
--		CancelEvent()
--		if RepairEveryoneWhitelisted == true then
--			TriggerClientEvent('28258fde-e0c4-4d3a-b3b7-99c1f632e2c4', source)
--		else
--			if checkWhitelist(identifier) then
--				TriggerClientEvent('28258fde-e0c4-4d3a-b3b7-99c1f632e2c4', source)
--			else
--				TriggerClientEvent('3f8162b1-ecb8-4c16-a008-880ddcb5c01f', source)
--			end
--		end
--	end
--end)
