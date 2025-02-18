--[[ สนับสนุน azael_dc-serverlogs เวอร์ชัน 1.3.2 ขึ้นไป ]]

-- es_extended\server\commands.lua

-- Support es_extended 1.1.0
###############################
####### [ ใช้คำสั่ง-แอดมิน ] #####
###############################

-- setjob

if source == xPlayer.source then
    local sendToDiscord = ''.. xPlayer.name .. ' เปลี่ยนอาชีพให้ตนเอง เป็น ' .. args[2] .. ' ระดับ ' .. args[3] .. ''
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, xPlayer.source, '^2')
else
    local AdminPlayer = ESX.GetPlayerFromId(source)

    local sendToDiscord = ''.. AdminPlayer.name .. ' เปลี่ยนอาชีพให้ ' .. xPlayer.name .. ' เป็น ' .. args[2] .. ' ระดับ ' .. args[3] .. ''
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, AdminPlayer.source, '^3')

    Citizen.Wait(100)

    local sendToDiscord = ''.. xPlayer.name .. ' ถูกเปลี่ยนอาชีพ เป็น ' .. args[2] .. ' ระดับ ' .. args[3] .. ' โดย ' .. AdminPlayer.name ..''
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, xPlayer.source, '^2')
end

-- setmoney

if money_type == 'cash' or  money_type == 'bank' or money_type == 'black'  then
    if _source == target then
        local sendToDiscord = ''.. xPlayer.name .. ' กำหนด ' .. money_type .. ' ให้ตนเอง เป็น $' .. ESX.Math.GroupDigits(money_amount) .. ''
        TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, xPlayer.source, '^2')
    else
        local AdminPlayer = ESX.GetPlayerFromId(_source)
    
        local sendToDiscord = ''.. AdminPlayer.name .. ' กำหนด ' .. money_type .. ' ให้ '.. xPlayer.name .. ' เป็น $' .. ESX.Math.GroupDigits(money_amount) .. ''
        TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, AdminPlayer.source, '^3')
    
        Citizen.Wait(100)
    
        local sendToDiscord = ''.. xPlayer.name .. ' ถูกกำหนด ' .. money_type .. ' เป็น $' .. ESX.Math.GroupDigits(money_amount) .. ' โดย ' .. AdminPlayer.name ..''
        TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, xPlayer.source, '^2')
    end
end

-- giveaccountmoney

if _source == xPlayer.source then
    local sendToDiscord = ''.. xPlayer.name .. ' เพิ่ม ' .. account .. ' จำนวน $' .. ESX.Math.GroupDigits(amount) .. ' ให้ตนเอง'
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, xPlayer.source, '^2')
else
    local AdminPlayer = ESX.GetPlayerFromId(_source)

    local sendToDiscord = ''.. AdminPlayer.name .. ' เพิ่ม ' .. account .. ' จำนวน $' .. ESX.Math.GroupDigits(amount) .. ' ให้ '.. xPlayer.name .. ''
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, AdminPlayer.source, '^3')

    Citizen.Wait(100)

    local sendToDiscord = ''.. xPlayer.name .. ' ได้รับ ' .. account .. ' จำนวน $' .. ESX.Math.GroupDigits(amount) .. ' โดย ' .. AdminPlayer.name ..''
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, xPlayer.source, '^2')
end

-- giveitem

if _source == xPlayer.source then
    local sendToDiscord = ''.. xPlayer.name .. ' เพิ่ม ' .. ESX.GetItemLabel(item) .. ' จำนวน ' .. ESX.Math.GroupDigits(count) .. ' ให้ตนเอง'
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, xPlayer.source, '^2')
else
    local AdminPlayer = ESX.GetPlayerFromId(_source)

    local sendToDiscord = ''.. AdminPlayer.name .. ' เพิ่ม ' .. ESX.GetItemLabel(item) .. ' จำนวน ' .. ESX.Math.GroupDigits(count) .. ' ให้ '.. xPlayer.name .. ''
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, AdminPlayer.source, '^3')

    Citizen.Wait(100)

    local sendToDiscord = ''.. xPlayer.name .. ' ได้รับ ' .. ESX.GetItemLabel(item) .. ' จำนวน ' .. ESX.Math.GroupDigits(count) .. ' โดย ' .. AdminPlayer.name ..''
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, xPlayer.source, '^2')
end

-- giveweapon

if source == xPlayer.source then
    local sendToDiscord = ''.. xPlayer.name .. ' เพิ่ม ' .. ESX.GetWeaponLabel(weaponName) .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(tonumber(args[3])) .. ' ให้ตนเอง'
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, xPlayer.source, '^2')
else
    local AdminPlayer = ESX.GetPlayerFromId(source)

    local sendToDiscord = ''.. AdminPlayer.name .. ' เพิ่ม ' .. ESX.GetWeaponLabel(weaponName) .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(tonumber(args[3])) .. ' ให้ '.. xPlayer.name .. ''
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, AdminPlayer.source, '^3')

    Citizen.Wait(100)

    local sendToDiscord = ''.. xPlayer.name .. ' ได้รับ ' .. ESX.GetWeaponLabel(weaponName) .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(tonumber(args[3])) .. ' โดย ' .. AdminPlayer.name ..''
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, xPlayer.source, '^2')
end

######################################################################################################################################################################################################

-- Support es_extended 1.2.0 & v1-final (legacy)
###############################
####### [ ใช้คำสั่ง-แอดมิน ] ######
###############################

-- setjob

if xPlayer.source == args.playerId.source then
    local sendToDiscord = ''.. xPlayer.name .. ' เปลี่ยนอาชีพให้ตนเอง เป็น ' .. args.job .. ' ระดับ ' .. args.grade .. ''
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, xPlayer.source, '^2')
else
    local sendToDiscord = ''.. xPlayer.name .. ' เปลี่ยนอาชีพให้ ' .. args.playerId.name ..' เป็น ' .. args.job .. ' ระดับ ' .. args.grade .. ''
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, xPlayer.source, '^3')

    Citizen.Wait(100)

    local sendToDiscord = ''.. args.playerId.name .. ' ถูกเปลี่ยนอาชีพเป็น ' .. args.job .. ' ระดับ ' .. args.grade .. ' โดย ' .. xPlayer.name ..' '
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, args.playerId.source, '^2')
end

-- setaccountmoney

if xPlayer.source == args.playerId.source then
    local sendToDiscord = ''.. xPlayer.name .. ' กำหนด ' .. args.account .. ' ให้ตนเอง เป็น $' .. ESX.Math.GroupDigits(args.amount) .. ''
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, xPlayer.source, '^2')
else
    local sendToDiscord = ''.. xPlayer.name .. ' กำหนด ' .. args.account .. ' ให้ '.. args.playerId.name .. ' เป็น $' .. ESX.Math.GroupDigits(args.amount) .. ''
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, xPlayer.source, '^3')

    Citizen.Wait(100)

    local sendToDiscord = ''.. args.playerId.name .. ' ถูกกำหนด ' .. args.account .. ' เป็น $' .. ESX.Math.GroupDigits(args.amount) .. ' โดย ' .. xPlayer.name ..''
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, args.playerId.source, '^2')
end

-- giveaccountmoney

if xPlayer.source == args.playerId.source then
    local sendToDiscord = ''.. xPlayer.name .. ' เพิ่ม ' .. args.account .. ' จำนวน $' .. ESX.Math.GroupDigits(args.amount) .. ' ให้ตนเอง'
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, xPlayer.source, '^2')
else
    local sendToDiscord = ''.. xPlayer.name .. ' เพิ่ม ' .. args.account .. ' จำนวน $' .. ESX.Math.GroupDigits(args.amount) .. ' ให้ '.. args.playerId.name .. ''
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, xPlayer.source, '^3')

    Citizen.Wait(100)

    local sendToDiscord = ''.. args.playerId.name .. ' ได้รับ ' .. args.account .. ' จำนวน $' .. ESX.Math.GroupDigits(args.amount) .. ' โดย ' .. xPlayer.name ..''
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, args.playerId.source, '^2')
end

-- giveitem

if xPlayer.source == args.playerId.source then
    local sendToDiscord = ''.. xPlayer.name .. ' เพิ่ม ' .. ESX.GetItemLabel(args.item) .. ' จำนวน ' .. ESX.Math.GroupDigits(args.count) .. ' ให้ตนเอง'
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, xPlayer.source, '^2')
else
    local sendToDiscord = ''.. xPlayer.name .. ' เพิ่ม ' .. ESX.GetItemLabel(args.item) .. ' จำนวน ' .. ESX.Math.GroupDigits(args.count) .. ' ให้ '.. args.playerId.name .. ' '
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, xPlayer.source, '^3')

    Citizen.Wait(100)

    local sendToDiscord = ''.. args.playerId.name .. ' ได้รับ ' .. ESX.GetItemLabel(args.item) .. ' จำนวน ' .. ESX.Math.GroupDigits(args.count) .. ' โดย ' .. xPlayer.name ..''
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, args.playerId.source, '^2')
end

-- giveweapon

if xPlayer.source == args.playerId.source then
    local sendToDiscord = ''.. xPlayer.name .. ' เพิ่ม ' .. ESX.GetWeaponLabel(args.weapon) .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(args.ammo) .. ' ให้ตนเอง'
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, xPlayer.source, '^2')
else
    local sendToDiscord = ''.. xPlayer.name .. ' เพิ่ม ' .. ESX.GetWeaponLabel(args.weapon) .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(args.ammo) .. ' ให้ '.. args.playerId.name .. ''
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, xPlayer.source, '^3')

    Citizen.Wait(100)

    local sendToDiscord = ''.. args.playerId.name .. ' ได้รับ ' .. ESX.GetWeaponLabel(args.weapon) .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(args.ammo) .. ' โดย ' .. xPlayer.name ..''
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, args.playerId.source, '^2')
end

-- giveweaponcomponent

if xPlayer.source == args.playerId.source then
    local sendToDiscord = ''.. xPlayer.name .. ' เพิ่ม ' .. component.label .. ' ส่วนประกอบของ ' .. ESX.GetWeaponLabel(args.weaponName) .. ' ให้ตนเอง'
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, xPlayer.source, '^2')
else
    local sendToDiscord = ''.. xPlayer.name .. ' เพิ่ม ' .. component.label .. ' ส่วนประกอบของ ' .. ESX.GetWeaponLabel(args.weaponName) .. ' ให้ '.. args.playerId.name .. ''
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, xPlayer.source, '^3')

    Citizen.Wait(100)

    local sendToDiscord = ''.. args.playerId.name .. ' ได้รับ ' .. component.label .. ' ส่วนประกอบของ ' .. ESX.GetWeaponLabel(args.weaponName) .. ' โดย ' .. xPlayer.name ..''
    TriggerEvent('azael_discordlogs:sendToDiscord', 'AdminCommands', sendToDiscord, args.playerId.source, '^2')
end
