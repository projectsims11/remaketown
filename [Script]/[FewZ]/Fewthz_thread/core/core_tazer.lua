local tiempo = 4000
local isTaz = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(7)
		ped = PlayerPedId()
		local sleep = true
		if IsPedBeingStunned(ped) then
			sleep = false
			SetPedToRagdoll(ped, 5000, 5000, 0, 0, 0, 0)
		end
		if IsPedBeingStunned(ped) and not isTaz then
			sleep = false
			isTaz = true
			SetTimecycleModifier("REDMIST_blend")
			ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", 1.0)
		elseif not IsPedBeingStunned(ped) and isTaz then
			sleep = false
			isTaz = false
			Wait(5000)
			SetTimecycleModifier("hud_def_desat_Trevor")
			Wait(10000)
      		SetTimecycleModifier("")
			SetTransitionTimecycleModifier("")
			StopGameplayCamShaking()
		end
		if sleep then
			Citizen.Wait(500)
		end
	end
end)