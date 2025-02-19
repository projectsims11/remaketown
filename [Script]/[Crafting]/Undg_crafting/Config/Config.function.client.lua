TextUi = function(coords) -- TEXT จะขึ้นตอนอยู่ใกล้ๆ กล่อง ใช้แบบ No Loop
    --exports["Undg_TextUi"]:TEXT_TEXT3D('PRESS <span>E</span> TO OPEN TABLE CRAFT')
end
 
HideTextUI = function()
    --exports["Undg_TextUi"]:TEXT_HIDETEXT()
end

Draw3DText = function(x,y,z,textInput,fontId,scaleX,scaleY)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)    
	local scale = (1/dist)*20
	local fov = (1/GetGameplayCamFov())*100
	local scale = scale*fov 
	local fontId = RegisterFontId('font4thai')	
	RegisterFontFile('font4thai') 	 
	SetTextScale(scaleX*scale, scaleY*scale)
	SetTextFont(fontId)
	SetTextProportional(1)
	SetTextColour(250, 250, 250, 255)		
	SetTextDropshadow(1, 1, 1, 1, 255)
	SetTextEdge(2, 0, 0, 0, 150)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(textInput)
	SetDrawOrigin(x,y,z+2, 0)
	DrawText(0.0, 0.0)
	ClearDrawOrigin()
end