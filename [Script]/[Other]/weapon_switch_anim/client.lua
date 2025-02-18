
local Dis = false
Config = {}

-- Lägg till alla vapen det ska fungera på
Config.WeaponList = {
	2035676849,1223103956,1512192074,-1401070337,2139292427,296771568,449180187,383969873,-374534170,-210820246,-1072209735,-1237496571,-1697180103,-1995410772,157741911,1308421029,1678514099,1888432313,-2033623763,
	-1794901598,-232539764,949110380,1186783937,488083319,726215642,-1786099057,1141786504,-102323637,-1834847097,-656458692,-581044007,-538741184,487013001,-1716189206,1737195953,1317494643,-2067956739,-102973651,
	-1951375401,-1810795771,419712736,-853065399
}

Config.PedAbleToWalkWhileSwapping = true
Config.UnarmedHash = -1569615261

Citizen.CreateThread(function()
	local animDict = 'reaction@intimidation@1h'

	local animIntroName = 'intro'
	local animOutroName = 'outro'

	local animFlag = 0

	RequestAnimDict(animDict)
	  
	while not HasAnimDictLoaded(animDict) do
		Citizen.Wait(100)
	end

	local lastWeapon = nil

	while true do
		Citizen.Wait(100)

		if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then
			if Config.PedAbleToWalkWhileSwapping then
				animFlag = 48
			else
				animFlag = 0
			end

			for i=1, #Config.WeaponList do
				if lastWeapon ~= nil and lastWeapon ~= Config.WeaponList[i] and GetSelectedPedWeapon(GetPlayerPed(-1)) == Config.WeaponList[i] then
					Dis = true
					SetCurrentPedWeapon(GetPlayerPed(-1), Config.UnarmedHash, true)
					TaskPlayAnim(GetPlayerPed(-1), animDict, animIntroName, 8.0, -8.0, 2700, animFlag, 0.0, false, false, false)

					Citizen.Wait(1000)
					SetCurrentPedWeapon(GetPlayerPed(-1), Config.WeaponList[i], true)
					Dis = false
				end

				if lastWeapon ~= nil and lastWeapon == Config.WeaponList[i] and GetSelectedPedWeapon(GetPlayerPed(-1)) == Config.UnarmedHash then
					Dis = true
					TaskPlayAnim(GetPlayerPed(-1), animDict, animOutroName, 8.0, -8.0, 2100, animFlag, 0.0, false, false, false)

					Citizen.Wait(1000)
					SetCurrentPedWeapon(GetPlayerPed(-1), Config.UnarmedHash, true)
					Dis = false
				end
			end
		end

		lastWeapon = GetSelectedPedWeapon(GetPlayerPed(-1))
	end
end)

Citizen.CreateThread(function() 
    while true do
        Wait(0)
        if Dis then
            DisablePlayerFiring(PlayerPedId(), true)
            DisableControlAction(1, 25, true)
            DisableControlAction(1, 250, true)
            DisableControlAction(1, 45, true)
            DisableControlAction(1, 263, true)
            DisableControlAction(1, 80, true)
            DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
            DisableControlAction(1, 23, true)
            DisableControlAction(1, 37, true)
        else
            Citizen.Wait(1000)
        end
    end
end)

print(GetHashKey('WEAPON_KNUCKLE+5'))