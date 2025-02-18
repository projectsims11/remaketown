ConfigSv = {}
ConfigCL = {}
ConfigJs = {}

--==================== Config JS ====================--
--เชื่อมรูปกระเป๋า nui://nc_inventory/html/img/items/
ConfigJs["JS"] = "nui://Fewthz_inventory/html/img/items/"

--==================== Config Client ====================--

--เชื่อมสกิน
ConfigCL["SetSkin"] = function(data)
    TriggerEvent('esx_skin:openSaveableMenu', source) --ตัวอย่าง
end

--เชื่อมแต่งรถ
ConfigCL["SetVehicle"] = function(data)
    exports.Fewthz_Lscustom_ui:openByMenuAdmin()
end

--เชื่อมกระเป๋า
ConfigCL["Inventory"] = function(data) -- เปิดกระเป๋า
    TriggerEvent("Fewthz_inventory:openPlayerInventory", data.playerid, data) 
    --exports.nc_inventory:SearchInventory(data.playerid, data)
    SetDisplay(false)
end

--ลบ prop
ConfigCL["DeleteProp"] = {
    "prop_boxpile_07d",
}

--==================== Config Server ====================--
-- Zone All
ConfigSv["ReviveAll"] = function(source, target, xPlayer)

	local sendToDiscord = ' แอดมิน ' .. xPlayer.name .. ' ชุปทั้งเซิฟเวอร์ '
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, source, '^2')
    TriggerClientEvent('mythic_notify:client:SendAlert', -1, { type = 'success', text = 'ชุบทั้งหมดโดยแอดมิน', length = 2500 })

end

ConfigSv["HealAll"] = function(source, target, xPlayer)

	local sendToDiscord = ' แอดมิน ' .. xPlayer.name .. ' ฮีลทั้งเซิฟเวอร์ '
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, source, '^2')
    TriggerClientEvent('mythic_notify:client:SendAlert', -1, { type = 'success', text = 'ฮีลทั้งหมดโดยแอดมิน', length = 2500 })

end

ConfigSv["GodAll"] = function(source, target, xPlayer)

	local sendToDiscord = ' แอดมิน ' .. xPlayer.name .. ' เสกเป็นอมตะทั้งเซิฟ '
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, source, '^2')
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'เสกเป็นอมตะทั้งเซิฟ', length = 2500 })

end

ConfigSv["SlayAll"] = function(source, target, xPlayer)

	local sendToDiscord = ' แอดมิน ' .. xPlayer.name .. ' ฆ่าผู้เล่นทั้งหมด '
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, source, '^2')
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'ฆ่าผู้เล่นทั้งเซิฟ', length = 2500 })

end

ConfigSv["TeleportAll"] = function(source, target, xPlayer)

	local sendToDiscord = ' แอดมิน ' .. xPlayer.name .. ' ดึงผู้เล่นทั้งหมด '
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, source, '^2')
    TriggerClientEvent('mythic_notify:client:SendAlert', -1, { type = 'success', text = 'ท่านถูกดึงโดยแอดมิน', length = 2500 })

end

--============================================================--


--==================== Discord log Zone Player ====================--

ConfigSv["Revive"] = function(source, target, xPlayer)

	local sendToDiscord = ' แอดมิน ' .. xPlayer.name .. ' ชุป ให้ '..GetPlayerName(target)..''
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, source, '^2')
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = ' ชุป '..GetPlayerName(target)..'', length = 2500 })

end

ConfigSv["Heal"] = function(source, target, xPlayer)

	local sendToDiscord = ' แอดมิน ' .. xPlayer.name .. ' ฮีล ให้ '..GetPlayerName(target)..''
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, source, '^2')
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = ' ฮีล '..GetPlayerName(target)..'', length = 2500 })

end

ConfigSv["Skin"] = function(source, target, xPlayer)

	local sendToDiscord = ' แอดมิน ' .. xPlayer.name .. ' เปิดเมนูสกิน ให้ '..GetPlayerName(target)..''
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, source, '^2')
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = ' เปิดเมนูสกิน ให้ '..GetPlayerName(target)..'', length = 2500 })

end

ConfigSv["Freeze"] = function(source, target, xPlayer)

	local sendToDiscord = ' แอดมิน ' .. xPlayer.name .. ' ล็อคขาผู้เล่น '..GetPlayerName(target)..''
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, source, '^2')
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = ' ล็อคขาผู้เล่น '..GetPlayerName(target)..'', length = 2500 })

end

ConfigSv["God"] = function(source, target, xPlayer)

	local sendToDiscord = ' แอดมิน ' .. xPlayer.name .. ' เสก ให้' ..GetPlayerName(target)..' เป็นอมตะ '
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, source, '^2')
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'เสกเป็นอมตะ', length = 2500 })

end

ConfigSv["Slay"] = function(source, target, xPlayer)

	local sendToDiscord = ' แอดมิน ' .. xPlayer.name .. ' ฆ่า ' ..GetPlayerName(target)..''
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, source, '^2')
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'ฆ่าผู้เล่น', length = 2500 })

end

ConfigSv["GiveWeapon"] = function(source, target, xPlayer, weapon)

	local sendToDiscord = ' แอดมิน '.. xPlayer.name .. ' เพิ่ม ' .. weapon .. ' ให้ '.. target.name .. ' โดยเมนู ADMIN ' 
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, xPlayer.source, '^1')
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = ' เพิ่ม ' .. weapon .. ' ให้ '.. target.name .. ' โดยเมนู ADMIN ', length = 2500 })

end

ConfigSv["GiveWeaponAmmo"] = function(source, target, xPlayer, weapon)

	local sendToDiscord = ' แอดมิน '.. xPlayer.name .. ' เพิ่มกระสุน ' .. weapon .. ' ให้ '.. target.name .. ' โดยเมนู ADMIN ' 
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, xPlayer.source, '^1')
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = ' เพิ่ม ' .. weapon .. ' ให้ '.. target.name .. ' โดยเมนู ADMIN ', length = 2500 })

end

ConfigSv["GiveItem"] = function(source, target, xPlayer, selectedItem, amount)

	local sendToDiscord = ' แอดมิน '.. xPlayer.name .. ' เพิ่ม ' .. selectedItem .. ' จำนวน ' .. ESX.Math.GroupDigits(amount) .. ' ให้ '.. target.name .. ' โดยเมนู ADMIN ' 
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, xPlayer.source, '^5')
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = ' เพิ่ม ' .. selectedItem .. ' จำนวน ' .. ESX.Math.GroupDigits(amount) .. ' ให้ '.. target.name .. ' โดยเมนู ADMIN ', length = 2500 })

end

ConfigSv["GiveCash"] = function(source, target, xPlayer, selectedItem, amount)

	local sendToDiscord = ' แอดมิน '.. xPlayer.name .. ' เพิ่ม เงินสด จำนวน ' .. amount .. ' ให้แก่ ผู้เล่นชื่อ ' .. target.name .. ' โดยเมนู ADMIN ' 
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, xPlayer.source, '^2')
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = ' เพิ่ม เงินสด จำนวน ' .. amount .. ' ให้แก่ ผู้เล่นชื่อ ' .. target.name .. ' โดยเมนู ADMIN ', length = 2500 })

end

ConfigSv["GiveBlackCash"] = function(source, target, xPlayer, selectedItem, amount)

	local sendToDiscord = ' แอดมิน '.. xPlayer.name .. ' เพิ่ม เงินแดง จำนวน ' .. amount .. ' ให้แก่ ผู้เล่นชื่อ ' .. target.name .. ' โดยเมนู ADMIN ' 
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, xPlayer.source, '^2')
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = ' เพิ่ม เงินแดง จำนวน ' .. amount .. ' ให้แก่ ผู้เล่นชื่อ ' .. target.name .. ' โดยเมนู ADMIN ', length = 2500 })

end

ConfigSv["GiveCashBank"] = function(source, target, xPlayer, selectedItem, amount)

	local sendToDiscord = ' แอดมิน '.. xPlayer.name .. ' เพิ่ม เงินธนาคาร จำนวน ' .. amount .. ' ให้แก่บัญชี ผู้เล่นชื่อ ' .. target.name .. ' โดยเมนู ADMIN ' 
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, xPlayer.source, '^2')
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = ' เพิ่ม เงินธนาคาร จำนวน ' .. amount .. ' ให้แก่บัญชี ผู้เล่นชื่อ ' .. target.name .. ' โดยเมนู ADMIN ', length = 2500 })

end

ConfigSv["Kick"] = function(source, target, xPlayer, reason)

	local sendToDiscord = ' แอดมิน '.. xPlayer.name .. ' เตะผู้เล่นชื่อ ' .. target.name .. ' สาเหตุจาก ' .. reason ..  ' โดยเมนู ADMIN ' 
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, xPlayer.source, '^6')
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = ' เตะผู้เล่นชื่อ ' .. target.name .. ' สาเหตุจาก ' .. reason ..  ' โดยเมนู ADMIN ', length = 2500 })

end

ConfigSv["Ban"] = function(source, target, xPlayer, reason)

	local sendToDiscord = ' แอดมิน '.. xPlayer.name .. ' แบนผู้เล่นชื่อ ' .. target.name .. ' โดยเมนู ADMIN ' 
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, xPlayer.source, '^1')
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = ' แบนผู้เล่นชื่อ ' .. target.name .. ' โดยเมนู ADMIN ', length = 2500 })

end

ConfigSv["setJob"] = function(source, target, xPlayer, targetPlayer, job, rank)

	local sendToDiscord = 'Admin '.. xPlayer.name .. ' แต่งตั้งอาชีพให้ ' .. targetPlayer.name .. ' เป็น ' ..job.. ' ตำแหน่ง ' ..rank..  ' โดยเมนู ADMIN ' 
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, xPlayer.source, '^4')
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = ' แต่งตั้งอาชีพให้ ' .. targetPlayer.name .. ' เป็น ' ..job.. ' ตำแหน่ง ' ..rank..  ' โดยเมนู ADMIN ', length = 2500 })

end

--============================================================--