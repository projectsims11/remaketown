Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local coord = GetEntityCoords(PlayerPedId())
		local health = GetEntityHealth(PlayerPedId())
		local main = Config.ConfigSkin.Maincoords
		local sleep = true
		for k ,v in ipairs(Config.ConfigSkin) do

            if GetDistanceBetweenCoords(coord,v.x,v.y,v.z,true) < 30 then
				DrawMarker(Config.Marker.Marker.Id, v.x,v.y,v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Marker.Marker.Size.x, Config.Marker.Marker.Size.y, Config.Marker.Marker.Size.z, Config.Marker.Marker.Color.r, Config.Marker.Marker.Color.g, Config.Marker.Marker.Color.b, Config.Marker.Marker.Color.a, false, true, 2, false, false, false, false)
				sleep = false
			end

			if GetDistanceBetweenCoords(coord,v.x,v.y,v.z,true) < 5.5 then
				sleep = false
				DrawText3Ds(v.x,v.y,v.z + 0.5, v.text)
				if IsControlJustPressed(0, 38) then
                    TriggerEvent('ws_skin_ui:openSaveableMenu')
				end
			end
		end
		if sleep then
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local coord = GetEntityCoords(PlayerPedId())
		local health = GetEntityHealth(PlayerPedId())
		local main = Config.ConfigSkinMoney.Maincoords
		local sleep = true
		for k ,v in ipairs(Config.ConfigSkinMoney) do

            if GetDistanceBetweenCoords(coord,v.x,v.y,v.z,true) < 10 then
				DrawMarker(Config.Marker.Marker.Id, v.x,v.y,v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerMoney.Marker.Size.x, Config.MarkerMoney.Marker.Size.y, Config.MarkerMoney.Marker.Size.z, Config.MarkerMoney.Marker.Color.r, Config.MarkerMoney.Marker.Color.g, Config.MarkerMoney.Marker.Color.b, Config.MarkerMoney.Marker.Color.a, false, true, 2, false, false, false, false)
				sleep = false
			end

			if GetDistanceBetweenCoords(coord,v.x,v.y,v.z,true) < 2 then
				sleep = false
				DrawText3Ds(v.x,v.y,v.z + 0.5, v.text)
				if IsControlJustPressed(0, 38) then
                    TriggerEvent('ws_skin_ui:openSaveableMenu')
					TriggerServerEvent('removemoney:pay' , v.removemoney )
				end
			end
		end
		if sleep then
			Citizen.Wait(500)
		end
	end
end)

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.4, 0.4)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextDropShadow(1, 0, 0, 0, 255)
	SetTextEntry("STRING")
	SetTextCentre(true)
	AddTextComponentString(text)
	SetDrawOrigin(x,y,z, 0)
	DrawText(0.0, 0.0)
	local factor = (string.len(text)) / 370
	DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
	ClearDrawOrigin()
end