ESX = nil 

Citizen.CreateThread(function() 
	while ESX == nil do 
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
		Citizen.Wait(1000) 
	end 
end) 

function DelProp()
	for _, v in pairs(GetGamePool('CObject')) do
		if IsEntityAttachedToEntity(PlayerPedId(), v) then
			SetEntityAsMissionEntity(v, true, true)
			DeleteObject(v)
		end
	end
	exports.pNotify:SendNotification({
		text = "<b style='color: green; text-align: center;'>ลบพร๊อพบนตัวคุณเรียบร้อยเเล้ว</b>",
		type = "success",
		queue = "lmao",
		timeout = 1500,
		layout = "topRight"
	})
end

RegisterCommand(Config.CommandDelProp, function()
	DelProp()
end, false)