CreateThread(function()
	while true do
		if NetworkIsPlayerActive(PlayerId()) then
            Wait(1000) 
            QuestState = Config.Quest
            break 
        end
        Wait(0)
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local s = true
        local p = PlayerPedId()
        local c = GetEntityCoords(p)
        local r = Config.Position
        for i=1, #r, 1 do 
            if GetDistanceBetweenCoords(c, r[i].x, r[i].y, r[i].z, true) < Config.Distance then
                s = false
                DrawMarker(32, r[i].x, r[i].y, r[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.7, 0.7, 1.0, 0, 128, 255, 120, false, true, 2, true, false, false, false)
                if GetDistanceBetweenCoords(c, r[i].x, r[i].y, r[i].z, true) < Config.DistancePress then
                    exports["Fewthz_TextUI"]:ShowHelpNotification('Press ~INPUT_CONTEXT~ Open Quest')
                    if IsControlJustReleased(0, 38) then
                        NUIOpenQuest()
                    end
                end
            end
        end
        if s then Citizen.Wait(500) end
    end
end)

Citizen.CreateThread(function()
    if Config.Blip.Blips.Open then
	    local blip1 = AddBlipForCoord(Config.Blip.Pos.x, Config.Blip.Pos.y, Config.Blip.Pos.z)

	    SetBlipSprite (blip1, Config.Blip.Blips.Id)
	    SetBlipDisplay(blip1, 4)
	    SetBlipScale  (blip1, Config.Blip.Blips.Size)
	    SetBlipColour (blip1, Config.Blip.Blips.Color)
	    SetBlipAsShortRange(blip1, true)

	    BeginTextCommandSetBlipName("STRING")
	    AddTextComponentString(Config.Blip.Blips.Text)
	    EndTextCommandSetBlipName(blip1)
    end
end)