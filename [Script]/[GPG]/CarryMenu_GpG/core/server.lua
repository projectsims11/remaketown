RegisterServerEvent(GetCurrentResourceName()..':cl_down1')
AddEventHandler(GetCurrentResourceName()..':cl_down1', function(targetSrc)
    TriggerClientEvent(GetCurrentResourceName()..':cl_down1', targetSrc)
end)

RegisterServerEvent(GetCurrentResourceName()..':sync')
AddEventHandler(GetCurrentResourceName()..':sync', function(target, animationLib,animationLib2, animation, animation2, distans, distans2, height,targetSrc,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget,typecarry)
	if targetSrc ~= nil and target ~= nil and source ~= nil then
		TriggerClientEvent(GetCurrentResourceName()..':syncTarget', targetSrc, source, animationLib2, animation2, distans, distans2, height, length,spin,controlFlagTarget,animFlagTarget,typecarry)
	end
end)

RegisterServerEvent(GetCurrentResourceName()..':accept')
AddEventHandler(GetCurrentResourceName()..':accept', function(targetSrc,typecarry)
    TriggerClientEvent(GetCurrentResourceName()..':syncMe', tonumber(targetSrc) , typecarry)
end)

RegisterServerEvent(GetCurrentResourceName()..':cl_down2')
AddEventHandler(GetCurrentResourceName()..':cl_down2', function(targetSrc)
	TriggerClientEvent(GetCurrentResourceName()..':cl_down2', targetSrc)
end)

RegisterServerEvent(GetCurrentResourceName()..':errordead')
AddEventHandler(GetCurrentResourceName()..':errordead', function(targetSrc)
	TriggerClientEvent(GetCurrentResourceName()..':errordead', targetSrc)
end)
