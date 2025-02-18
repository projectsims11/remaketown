CreateThread(function()
	while true do
		local sleep = 100
		local player = PlayerPedId()
		if not IsEntityDead(player) then
			for k,v in pairs(Config['Weapon']) do
				SetWeaponDamageModifier(k, 0.0001)
				if HasPedBeenDamagedByWeapon(player, k, 0) then
					sleep = 0

					local armour = GetPedArmour(player)
					if armour > 0 then
						if (armour - v.Damage) > 0 then
							-- เข้าเกราะ
							local health = GetEntityHealth(player)
							SetEntityHealth(player, (health + 1))
							SetPedArmour(player, (armour - v.Damage))

							-- เจาะเกราะ
							if v.Chance_Penetrate > 0 then
								if math.random(1, 100) <= v.Chance_Penetrate then

									if v.Shake_Cam then
										ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08)
									end

									-- เช็คเจาะเกราะ
									local ran_dm_p = math.random(v.Damage_Penetrate[1] , v.Damage_Penetrate[2])
									local health = GetEntityHealth(player)
									SetEntityHealth(player , health - ran_dm_p)
								end
							end
						elseif (armour > 0) then
							-- เข้าเกราะ เกราะหมดเข้าเลือด
							local dd = v.Damage - armour
							local health = GetEntityHealth(player)
							SetEntityHealth(player, (health - (dd + 1)))
							SetPedArmour(player, (armour - v.Damage))
							SetPedComponentVariation(player, 9, 0, 0, 0)
						end
					else
						-- เข้าเลือดไม่มีเกราะ
						local health = GetEntityHealth(player)
						SetEntityHealth(player, ((health + 1) - v.Damage))
					end
					
					ClearEntityLastDamageEntity(player)
					if v.Critical then
						if math.random(1, 100) <= v.Critical_Chance then
							SetPedSuffersCriticalHits(GetPlayerPed(-1), true)
						else
							SetPedSuffersCriticalHits(GetPlayerPed(-1), false)
						end
					else
					   SetPedSuffersCriticalHits(GetPlayerPed(-1), false)
					end

					break
				end
			end
		end
		Wait(sleep)
	end
end)

AddEventHandler("Fewthz_core:ClientMemoryGarbage", function()
	Citizen.CreateThread(function()
		Wait(math.random(100, 2000))
		collectgarbage()
	end)
end)