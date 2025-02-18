--[[ สนับสนุน azael_dc-serverlogs เวอร์ชัน 1.3.2 ขึ้นไป ]]

-- es_extended\server\main.lua
############################
##### [ ไอเทม-รับ-ส่ง ] ######
############################

local sendToDiscord = ''.. sourceXPlayer.name .. ' ส่ง ' .. ESX.GetItemLabel(itemName) .. ' ให้กับ ' .. targetXPlayer.name .. ' จำนวน ' .. ESX.Math.GroupDigits(itemCount) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'GiveItem', sendToDiscord, sourceXPlayer.source, '^1')	
				
Citizen.Wait(100)
				
local sendToDiscord2 = ''.. targetXPlayer.name .. ' ได้รับ ' .. ESX.GetItemLabel(itemName) .. ' จาก ' .. sourceXPlayer.name .. ' จำนวน ' .. ESX.Math.GroupDigits(itemCount) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'GiveItem', sendToDiscord2, targetXPlayer.source, '^2')

############################
##### [ เงินเขียว-รับ-ส่ง ] #####
############################

local sendToDiscord = ''.. sourceXPlayer.name .. ' ส่ง เงินสด ให้กับ ' .. targetXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'GiveMoney', sendToDiscord, sourceXPlayer.source, '^1')	
			
Citizen.Wait(100)
			
local sendToDiscord2 = ''.. targetXPlayer.name .. ' ได้รับ เงินสด จาก ' .. sourceXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'GiveMoney', sendToDiscord2, targetXPlayer.source, '^2')

############################
##### [ เงินแดง-รับ-ส่ง ] #####
############################

local sendToDiscord = ''.. sourceXPlayer.name .. ' ส่ง '.. Config.AccountLabels[itemName] ..' ให้กับ ' .. targetXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'GiveDirtyMoney', sendToDiscord, sourceXPlayer.source, '^1')	
			
Citizen.Wait(100)
			
local sendToDiscord2 = ''.. targetXPlayer.name .. ' ได้รับ '.. Config.AccountLabels[itemName] ..' จาก ' .. sourceXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'GiveDirtyMoney', sendToDiscord2, targetXPlayer.source, '^2')

############################
##### [ อาวุธ-รับ-ส่ง ] #######
############################

if itemCount > 0 then
	local sendToDiscord = ''.. sourceXPlayer.name .. ' ส่ง '.. weaponLabel ..' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(itemCount) .. ' ให้กับ ' .. targetXPlayer.name .. ''
	TriggerEvent('azael_discordlogs:sendToDiscord', 'GiveWeapon', sendToDiscord, sourceXPlayer.source, '^1')	
		
	Citizen.Wait(100)
		
	local sendToDiscord2 = ''.. targetXPlayer.name .. ' ได้รับ '.. weaponLabel ..' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(itemCount) .. ' จาก ' .. sourceXPlayer.name .. ''
	TriggerEvent('azael_discordlogs:sendToDiscord', 'GiveWeapon', sendToDiscord2, targetXPlayer.source, '^2')
else
	local sendToDiscord = ''.. sourceXPlayer.name .. ' ส่ง '.. weaponLabel ..' ให้กับ ' .. targetXPlayer.name .. ''
	TriggerEvent('azael_discordlogs:sendToDiscord', 'GiveWeapon', sendToDiscord, sourceXPlayer.source, '^1')	
		
	Citizen.Wait(100)
		
	local sendToDiscord2 = ''.. targetXPlayer.name .. ' ได้รับ '.. weaponLabel ..' จาก ' .. sourceXPlayer.name .. ''
	TriggerEvent('azael_discordlogs:sendToDiscord', 'GiveWeapon', sendToDiscord2, targetXPlayer.source, '^2')
end

#########################
##### [ ไอเทม-ทิ้ง ] ######
#########################

local sendToDiscord = ''.. xPlayer.name .. ' ทิ้ง '.. xItem.label ..' จำนวน ' .. ESX.Math.GroupDigits(itemCount) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'RemoveItem', sendToDiscord, xPlayer.source, '^1')

########################
##### [ เงินเขียว-ทิ้ง ] ####
########################

local sendToDiscord = ''.. xPlayer.name .. ' ทิ้ง เงินสด จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'RemoveMoney', sendToDiscord, xPlayer.source, '^1')

########################
##### [ เงินแดง-ทิ้ง ] ####
########################

local sendToDiscord = ''.. xPlayer.name .. ' ทิ้ง ' .. Config.AccountLabels[itemName] .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'RemoveDirtyMoney', sendToDiscord, xPlayer.source, '^1')

########################
##### [ อาวุธ-ทิ้ง ] ######
########################

if itemCount > 0 then
	local sendToDiscord = ''.. xPlayer.name .. ' ทิ้ง ' .. weaponLabel .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(itemCount) .. ''
	TriggerEvent('azael_discordlogs:sendToDiscord', 'RemoveWeapon', sendToDiscord, xPlayer.source, '^1')
else
	local sendToDiscord = ''.. xPlayer.name .. ' ทิ้ง ' .. weaponLabel .. ''
	TriggerEvent('azael_discordlogs:sendToDiscord', 'RemoveWeapon', sendToDiscord, xPlayer.source, '^1')
end

###############################
####### [ ใช้งาน-ไอเทม ] #######
###############################

local sendToDiscord = ''.. xPlayer.name .. ' ใช้ไอเทม ' .. ESX.GetItemLabel(itemName) .. ' จำนวน 1'
TriggerEvent('azael_discordlogs:sendToDiscord', 'UseItem', sendToDiscord, xPlayer.source, '^3')

################################
##### [ ไอเทม-เก็บจากพื้น ] #######
################################

local sendToDiscord = ''.. xPlayer.name .. ' เก็บ ' .. item.label .. ' จำนวน ' .. ESX.Math.GroupDigits(total) ..''
TriggerEvent('azael_discordlogs:sendToDiscord', 'PickupItem', sendToDiscord, xPlayer.source, '^2')

##################################
##### [ เงินเขียว-เก็บจากพื้น ] #######
##################################

local sendToDiscord = ''.. xPlayer.name .. ' เก็บ เงินสด จำนวน $' .. ESX.Math.GroupDigits(pickup.count) ..''
TriggerEvent('azael_discordlogs:sendToDiscord', 'PickupMoney', sendToDiscord, xPlayer.source, '^2')

##################################
##### [ เงินแดง-เก็บจากพื้น ] ########
##################################

local sendToDiscord = ''.. xPlayer.name .. ' เก็บ ' .. Config.AccountLabels[pickup.name] .. ' จำนวน $' .. ESX.Math.GroupDigits(pickup.count) ..''
TriggerEvent('azael_discordlogs:sendToDiscord', 'PickupDirtyMoney', sendToDiscord, xPlayer.source, '^2')

#############################################################################################################################################################################

-- meeta_shops\server\main.lua
##############################
######### [ ซื้อ-ไอเทม ] ########
##############################

local sendToDiscord = '' .. xPlayer.name .. ' ซื้อ ' .. sourceItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(amount) .. ' ราคา $' .. ESX.Math.GroupDigits(price) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'MeetaShops', sendToDiscord, _source, '^2')

#############################################################################################################################################################################

-- meeta_market\server\main.lua
###############################
######### [ ซื้อ-ไอเทม ] ########
###############################

local sendToDiscord = '' .. xPlayer.name .. ' ซื้อ ' .. result[1].label .. ' จำนวน ' .. count .. ' ราคา $' .. ESX.Math.GroupDigits(price) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'MeetaMarketBuy', sendToDiscord, source, '^2')

##############################
######### [ ขาย-ไอเทม ] #######
##############################

local sendToDiscord = '' .. xPlayer.name .. ' ขาย ' .. Item.Text_TH .. ' จำนวน ' .. Count .. ' ได้รับ $' .. ESX.Math.GroupDigits(Price) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'MeetaMarketSell', sendToDiscord, _source, '^2')

#############################################################################################################################################################################

-- xD_animal\server\main.lua
##################################
######### [ ซื้อ-สัตว์เลี้ยง ] #########
##################################

local sendToDiscord = '' .. xPlayer.name .. ' ซื้อ ' .. pet .. ' เสียค่าใช้จ่าย $' .. ESX.Math.GroupDigits(price) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'MarketAnimalBuy', sendToDiscord, _source, '^2')

#############################################################################################################################################################################

-- esx_vehicleshop\client\main.lua
##################################
######### [ ซื้อรถ-จากร้าน ] ########
##################################

local sendToDiscord = '' .. GetPlayerName(PlayerId()) .. ' ซื้อรถ ' .. vehicleData.model .. ' ทะเบียน ' .. vehicleProps.plate .. ' ราคา $' .. ESX.Math.GroupDigits(vehicleData.price) ..''
TriggerServerEvent('azael_discordlogs:sendToDiscord', 'BuyVehicle', sendToDiscord, GetPlayerServerId(PlayerId()), '^2')

#################################
######## [ ขายรถ-คืนร้าน ] #########
#################################

local sendToDiscord = '' .. GetPlayerName(PlayerId()) .. ' ขายรถ ' .. CurrentActionData.label .. ' ทะเบียน ' .. CurrentActionData.plate .. ' ราคา $' .. ESX.Math.GroupDigits(CurrentActionData.price) .. ''
TriggerServerEvent('azael_discordlogs:sendToDiscord', 'ResellVehicle', sendToDiscord, GetPlayerServerId(PlayerId()), '^3')

#############################################################################################################################################################################

-- esx_lscustom
#################################
########### [ แต่งรถ ] ###########
#################################

-- esx_lscustom\server\main.lua

-- ค้นหา 
TriggerClientEvent('esx_lscustom:installMod', _source)

-- if price < societyAccount.money then
-- แก้ไขเป็น
TriggerClientEvent('esx_lscustom:installMod', _source, 'society', price)

-- if price < xPlayer.getMoney() then
-- แก้ไขเป็น
TriggerClientEvent('esx_lscustom:installMod', _source, 'player', price)

-- esx_lscustom/client/main.lua

-- ค้นหา
AddEventHandler('esx_lscustom:installMod', function()

-- แก้ไขเป็น
AddEventHandler('esx_lscustom:installMod', function(type, price)

-- เพิ่มรหัสด้านล่างนี้ ไว้ข้างล่าง TriggerServerEvent('esx_lscustom:refreshOwnedVehicle', myCar)
local vehicleName = GetDisplayNameFromVehicleModel(myCar.model)
if type == 'society' then
	local sendToDiscord = '' .. GetPlayerName(PlayerId()) .. ' แต่งรถ ' .. GetLabelText(vehicleName) .. ' ทะเบียน ' .. myCar.plate .. ' และ เสียค่าใช้จ่าย $' .. ESX.Math.GroupDigits(price) .. ' (เงินหน่วยงาน)'
	TriggerServerEvent('azael_discordlogs:sendToDiscord', 'LsCustom', sendToDiscord, GetPlayerServerId(PlayerId()), '^2')
elseif type == 'player' then
	local sendToDiscord = '' .. GetPlayerName(PlayerId()) .. ' แต่งรถ ' .. GetLabelText(vehicleName) .. ' ทะเบียน ' .. myCar.plate .. ' และ เสียค่าใช้จ่าย $' .. ESX.Math.GroupDigits(price) .. ''
	TriggerServerEvent('azael_discordlogs:sendToDiscord', 'LsCustom', sendToDiscord, GetPlayerServerId(PlayerId()), '^2')
end

#############################################################################################################################################################################

-- esx_lscustomsV2
#################################
########### [ แต่งรถ ] ###########
#################################

-- esx_lscustomsV2\server\server.lua

-- ค้นหา
TriggerClientEvent('LSC:installMod', _source)

-- แก้ไขเป็น
TriggerClientEvent('LSC:installMod', _source, button.price)

-- esx_lscustomsV2\client\client.lua

-- ค้นหา
AddEventHandler('LSC:installMod', function()

-- แก้ไขเป็น
AddEventHandler('LSC:installMod', function(price)

-- เพิ่มรหัสด้านล่างนี้ ไว้ข้างล่าง TriggerServerEvent('LSC:refreshOwnedVehicle', myCar)
local vehicleName = GetDisplayNameFromVehicleModel(myCar.model)
local sendToDiscord = '' .. GetPlayerName(PlayerId()) .. ' แต่งรถ ' .. GetLabelText(vehicleName) .. ' ทะเบียน ' .. myCar.plate .. ' และ เสียค่าใช้จ่าย $' .. ESX.Math.GroupDigits(price) .. ''
TriggerServerEvent('azael_discordlogs:sendToDiscord', 'LsCustomV2', sendToDiscord, GetPlayerServerId(PlayerId()), '^2')

#############################################################################################################################################################################

-- meeta_carinventory\server\server.lua
#################################
######## [ ไอเทม-เก็บเข้ารถ ] ######
#################################

local sendToDiscord = '' .. xPlayer.name .. ' เก็บ ' .. label .. ' จำนวน ' .. ESX.Math.GroupDigits(count) .. ' ไว้ในรถ ทะเบียน ' .. plate .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'PutItemVehicle', sendToDiscord, xPlayer.source, '^2')

#################################
######## [ อาวุธ-เก็บเข้ารถ ] #######
#################################

if count > 0 then
	local sendToDiscord = '' .. xPlayer.name .. ' เก็บ ' .. label .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(count) .. ' ไว้ในรถ ทะเบียน ' .. plate .. ''
	TriggerEvent('azael_discordlogs:sendToDiscord', 'PutWeaponVehicle', sendToDiscord, xPlayer.source, '^2')
else
	local sendToDiscord = '' .. xPlayer.name .. ' เก็บ ' .. label .. ' ไว้ในรถ ทะเบียน ' .. plate .. ''
	TriggerEvent('azael_discordlogs:sendToDiscord', 'PutWeaponVehicle', sendToDiscord, xPlayer.source, '^2')
end

##################################
######## [ เงิน-เก็บเข้ารถ ] #########
##################################

if type == "item_account" then
	local sendToDiscord = '' .. xPlayer.name .. ' เก็บ ' .. label .. ' จำนวน $' .. ESX.Math.GroupDigits(count) .. ' ไว้ในรถ ทะเบียน ' .. plate .. ''
	TriggerEvent('azael_discordlogs:sendToDiscord', 'PutMoneyVehicle', sendToDiscord, xPlayer.source, '^3')
elseif type == "item_money" then
	local sendToDiscord = '' .. xPlayer.name .. ' เก็บ ' .. label .. ' จำนวน $' .. ESX.Math.GroupDigits(count) .. ' ไว้ในรถ ทะเบียน ' .. plate .. ''
	TriggerEvent('azael_discordlogs:sendToDiscord', 'PutMoneyVehicle', sendToDiscord, xPlayer.source, '^2')
end

##############################
##### [ ไอเทม-ออกจากรถ ] #####
##############################

local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. label .. ' จำนวน ' .. ESX.Math.GroupDigits(count) .. ' ออกจากรถ ทะเบียน ' .. plate .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'GetItemVehicle', sendToDiscord, xPlayer.source, '^1')

###############################
###### [ อาวุธ-ออกจากรถ ] ######
###############################

if result[1].count > 0 then
	local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. label .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(result[1].count) .. ' ออกจากรถ ทะเบียน ' .. plate .. ''
	TriggerEvent('azael_discordlogs:sendToDiscord', 'GetWeaponVehicle', sendToDiscord, xPlayer.source, '^1')
else
	local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. label .. ' ออกจากรถ ทะเบียน ' .. plate .. ''
	TriggerEvent('azael_discordlogs:sendToDiscord', 'GetWeaponVehicle', sendToDiscord, xPlayer.source, '^1')
end

################################
####### [ เงิน-ออกจากรถ ] #######
################################

if type == "item_account" then
	local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. label .. ' จำนวน $' .. ESX.Math.GroupDigits(count) .. ' ออกจากรถ ทะเบียน ' .. plate .. ''
	TriggerEvent('azael_discordlogs:sendToDiscord', 'GetMoneyVehicle', sendToDiscord, xPlayer.source, '^3')
elseif type == "item_money" then
	local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. label .. ' จำนวน $' .. ESX.Math.GroupDigits(count) .. ' ออกจากรถ ทะเบียน ' .. plate .. ''
	TriggerEvent('azael_discordlogs:sendToDiscord', 'GetMoneyVehicle', sendToDiscord, xPlayer.source, '^1')
end

#############################################################################################################################################################################

-- monster_inventory_trunk\server\esx_trunk-sv.lua
##############################
##### [ ไอเทม-ออกจากรถ ] #####
##############################

local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. targetItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(count) .. ' ออกจากรถ ทะเบียน ' .. plate .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'GetItemVehicle', sendToDiscord, xPlayer.source, '^1')

################################
####### [ เงิน-ออกจากรถ ] #######
################################

local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. item .. ' จำนวน $' .. ESX.Math.GroupDigits(count) .. ' ออกจากรถ ทะเบียน ' .. plate .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'GetMoneyVehicle', sendToDiscord, xPlayer.source, '^3')

###############################
###### [ อาวุธ-ออกจากรถ ] ######
###############################

if ammo ~= nil and ammo > 0 then
	local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. ESX.GetWeaponLabel(weaponName) .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(ammo) .. ' ออกจากรถ ทะเบียน ' .. plate .. ''
	TriggerEvent('azael_discordlogs:sendToDiscord', 'GetWeaponVehicle', sendToDiscord, xPlayer.source, '^1')
else
	local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. ESX.GetWeaponLabel(weaponName) .. ' ออกจากรถ ทะเบียน ' .. plate .. ''
	TriggerEvent('azael_discordlogs:sendToDiscord', 'GetWeaponVehicle', sendToDiscord, xPlayer.source, '^1')
end

#################################
######## [ ไอเทม-เก็บเข้ารถ ] ######
#################################

local sendToDiscord = '' .. xPlayer.name .. ' เก็บ ' .. label .. ' จำนวน ' .. ESX.Math.GroupDigits(count) .. ' ไว้ในรถ ทะเบียน ' .. plate .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'PutItemVehicle', sendToDiscord, xPlayer.source, '^2')

##################################
######## [ เงิน-เก็บเข้ารถ ] #########
##################################

local sendToDiscord = '' .. xPlayer.name .. ' เก็บ ' .. label .. ' จำนวน $' .. ESX.Math.GroupDigits(count) .. ' ไว้ในรถ ทะเบียน ' .. plate .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'PutMoneyVehicle', sendToDiscord, xPlayer.source, '^3')

#################################
######## [ อาวุธ-เก็บเข้ารถ ] #######
#################################

if count > 0 then
	local sendToDiscord = '' .. xPlayer.name .. ' เก็บ ' .. ESX.GetWeaponLabel(item) .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(count) .. ' ไว้ในรถ ทะเบียน ' .. plate .. ''
	TriggerEvent('azael_discordlogs:sendToDiscord', 'PutWeaponVehicle', sendToDiscord, xPlayer.source, '^2')
else
	local sendToDiscord = '' .. xPlayer.name .. ' เก็บ ' .. ESX.GetWeaponLabel(item) .. ' ไว้ในรถ ทะเบียน ' .. plate .. ''
	TriggerEvent('azael_discordlogs:sendToDiscord', 'PutWeaponVehicle', sendToDiscord, xPlayer.source, '^2')
end

#############################################################################################################################################################################

-- meeta_house\server\main.lua
#################################
##########  [ ซื้อบ้าน ] ###########
#################################

local sendToDiscord = '' .. xPlayer.name .. ' ซื้อบ้าน ' .. propertyName .. ' ราคา $' .. ESX.Math.GroupDigits(property.price) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'BuyHouse', sendToDiscord, _source, '^2')

#################################
####### [ ไอเทม-เก็บเข้าบ้าน ] ######
#################################

local sendToDiscord = '' .. xPlayer.name .. ' เก็บ ' .. label .. ' จำนวน ' .. ESX.Math.GroupDigits(count) .. ' ไว้ในบ้าน'
TriggerEvent('azael_discordlogs:sendToDiscord', 'PutItemHouse', sendToDiscord, xPlayer.source, '^2')

#################################
####### [ อาวุธ-เก็บเข้าบ้าน ] ####### 
#################################

if count > 0 then
	local sendToDiscord = '' .. xPlayer.name .. ' เก็บ ' .. label .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(count) .. ' ไว้ในบ้าน'
	TriggerEvent('azael_discordlogs:sendToDiscord', 'PutWeaponHouse', sendToDiscord, xPlayer.source, '^2')
else
	local sendToDiscord = '' .. xPlayer.name .. ' เก็บ ' .. label .. ' ไว้ในบ้าน'
	TriggerEvent('azael_discordlogs:sendToDiscord', 'PutWeaponHouse', sendToDiscord, xPlayer.source, '^2')
end

#################################
######## [ เงิน-เก็บเข้าบ้าน ] #######
#################################

if type == "item_account" then
	local sendToDiscord = '' .. xPlayer.name .. ' เก็บ ' .. label .. ' จำนวน $' .. ESX.Math.GroupDigits(count) .. ' ไว้ในบ้าน'
	TriggerEvent('azael_discordlogs:sendToDiscord', 'PutMoneyHouse', sendToDiscord, xPlayer.source, '^3')
elseif type == "item_money" then
	local sendToDiscord = '' .. xPlayer.name .. ' เก็บ ' .. label .. ' จำนวน $' .. ESX.Math.GroupDigits(count) .. ' ไว้ในบ้าน'
	TriggerEvent('azael_discordlogs:sendToDiscord', 'PutMoneyHouse', sendToDiscord, xPlayer.source, '^2')
end

###############################
##### [ ไอเทม-ออกจากบ้าน ] #####
###############################

local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. label .. ' จำนวน ' .. ESX.Math.GroupDigits(count) .. ' ออกจากบ้าน'
TriggerEvent('azael_discordlogs:sendToDiscord', 'GetItemHouse', sendToDiscord, xPlayer.source, '^1')

################################
##### [ อาวุธ-ออกจากบ้าน ] ######
################################

if result[1].count > 0 then
	local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. label .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(result[1].count) .. ' ออกจากบ้าน'
	TriggerEvent('azael_discordlogs:sendToDiscord', 'GetWeaponHouse', sendToDiscord, xPlayer.source, '^1')
else
	local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. label .. ' ออกจากบ้าน'
	TriggerEvent('azael_discordlogs:sendToDiscord', 'GetWeaponHouse', sendToDiscord, xPlayer.source, '^1')
end

#################################
######  [ เงิน-ออกจากบ้าน ] ######
#################################

if type == "item_account" then
	local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. label .. ' จำนวน $' .. ESX.Math.GroupDigits(count) .. ' ออกจากบ้าน'
	TriggerEvent('azael_discordlogs:sendToDiscord', 'GetMoneyHouse', sendToDiscord, xPlayer.source, '^3')
elseif type == "item_money" then
	local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. label .. ' จำนวน $' .. ESX.Math.GroupDigits(count) .. ' ออกจากบ้าน'
	TriggerEvent('azael_discordlogs:sendToDiscord', 'GetMoneyHouse', sendToDiscord, xPlayer.source, '^1')
end

#############################################################################################################################################################################

-- esx_property\server\main.lua
#################################
##########  [ ซื้อบ้าน ] ###########
#################################

local sendToDiscord = '' .. xPlayer.name .. ' ซื้อบ้าน ' .. propertyName .. ' ราคา $' .. ESX.Math.GroupDigits(property.price) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'BuyHouse', sendToDiscord, xPlayer.source, '^2')

###############################
##### [ ไอเทม-ออกจากบ้าน ] #####
###############################

local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. inventoryItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(count) .. ' ออกจากบ้าน'
TriggerEvent('azael_discordlogs:sendToDiscord', 'GetItemHouse', sendToDiscord, xPlayer.source, '^1')

#################################
######  [ เงิน-ออกจากบ้าน ] ######
#################################

local sendToDiscord = '' .. xPlayer.name .. ' นำ Dirty Money จำนวน $' .. ESX.Math.GroupDigits(count) .. ' ออกจากบ้าน'
TriggerEvent('azael_discordlogs:sendToDiscord', 'GetMoneyHouse', sendToDiscord, xPlayer.source, '^3')

################################
##### [ อาวุธ-ออกจากบ้าน ] ######
################################

if ammo ~= nil and ammo > 0 then
	local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. ESX.GetWeaponLabel(weaponName) .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(ammo) .. ' ออกจากบ้าน'
	TriggerEvent('azael_discordlogs:sendToDiscord', 'GetWeaponHouse', sendToDiscord, xPlayer.source, '^1')
else
	local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. ESX.GetWeaponLabel(weaponName) .. ' ออกจากบ้าน'
	TriggerEvent('azael_discordlogs:sendToDiscord', 'GetWeaponHouse', sendToDiscord, xPlayer.source, '^1')
end

#################################
####### [ ไอเทม-เก็บเข้าบ้าน ] ######
#################################

local sendToDiscord = '' .. xPlayer.name .. ' เก็บ ' .. inventory.getItem(item).label .. ' จำนวน ' .. ESX.Math.GroupDigits(count) .. ' ไว้ในบ้าน'
TriggerEvent('azael_discordlogs:sendToDiscord', 'PutItemHouse', sendToDiscord, xPlayer.source, '^2')

#################################
######## [ เงิน-เก็บเข้าบ้าน ] #######
#################################

local sendToDiscord = '' .. xPlayer.name .. ' เก็บ Dirty Money จำนวน $' .. ESX.Math.GroupDigits(count) .. ' ไว้ในบ้าน'
TriggerEvent('azael_discordlogs:sendToDiscord', 'PutMoneyHouse', sendToDiscord, xPlayer.source, '^3')

#################################
####### [ อาวุธ-เก็บเข้าบ้าน ] ####### 
#################################

if count > 0 then
	local sendToDiscord = '' .. xPlayer.name .. ' เก็บ ' .. ESX.GetWeaponLabel(item) .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(count) .. ' ไว้ในบ้าน'
	TriggerEvent('azael_discordlogs:sendToDiscord', 'PutWeaponHouse', sendToDiscord, xPlayer.source, '^2')
else
	local sendToDiscord = '' .. xPlayer.name .. ' เก็บ ' .. ESX.GetWeaponLabel(item) .. ' ไว้ในบ้าน'
	TriggerEvent('azael_discordlogs:sendToDiscord', 'PutWeaponHouse', sendToDiscord, xPlayer.source, '^2')
end

#############################################################################################################################################################################

-- esx_inventoryhud\server\main.lua
#################################
######### [ ส่งกุญแจ-รถ ] ########
#################################

local sendToDiscord = '' .. sourceXPlayer.name .. ' ส่ง กุญแจรถ ทะเบียน ' .. itemName .. ' ไปยัง ' .. targetXPlayer.name .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'GiveKeyCar', sendToDiscord, _source, '^3')

Citizen.Wait(100)

local sendToDiscord2 = '' .. targetXPlayer.name .. ' ได้รับ กุญแจรถ ทะเบียน ' .. itemName .. ' จาก ' .. sourceXPlayer.name .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'GiveKeyCar', sendToDiscord2, target, '^2')

#################################
######### [ ส่งกุญแจ-บ้าน ] #######
#################################

local sendToDiscord = '' .. sourceXPlayer.name .. ' ส่ง กุญแจบ้าน ' .. itemName .. ' ไปยัง ' .. targetXPlayer.name .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'GiveKeyHouse', sendToDiscord, _source, '^3')

Citizen.Wait(100)

local sendToDiscord2 = '' .. targetXPlayer.name .. ' ได้รับ กุญแจบ้าน ' .. itemName .. ' จาก ' .. sourceXPlayer.name .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'GiveKeyHouse', sendToDiscord2, target, '^2')

##############################
######### [ ซื้อ-ไอเทม ] #######
##############################

local sendToDiscord = '' .. xPlayer.name .. ' ซื้อ ' .. list[i].label .. ' จำนวน ' .. ESX.Math.GroupDigits(count) .. ' ราคา $' .. ESX.Math.GroupDigits(totalPrice) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'InventoryShopItem', sendToDiscord, xPlayer.source, '^2')

##############################
######### [ ซื้อ-อาวุธ ] #######
##############################

local sendToDiscord = '' .. xPlayer.name .. ' ซื้อ ' .. list[i].label .. ' ราคา $' .. ESX.Math.GroupDigits(totalPrice) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'InventoryShopWeapon', sendToDiscord, xPlayer.source, '^2')

##############################
######### [ ซื้อ-กระสุน ] #######
##############################

local sendToDiscord = '' .. xPlayer.name .. ' ซื้อ กระสุน ของ ' .. list[i].label .. ' จำนวน ' .. ESX.Math.GroupDigits(count) .. ' ราคา $' .. ESX.Math.GroupDigits(totalPrice) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'InventoryShopAmmo', sendToDiscord, xPlayer.source, '^2')

#############################################################################################################################################################################

-- meeta_processing\server\server.lua
#################################
######### [ แปรรูป-ไอเทม ] #######
#################################

local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. Zone.Items[1].Text .. ' จำนวน ' .. ESX.Math.GroupDigits(Zone.Items[1].ItemCount) .. ' ' .. Zone.Items[1].Unit .. ' ใช้ในการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'ProcessItem', sendToDiscord, _source, '^1')

Citizen.Wait(100)

local sendToDiscord2 = '' .. xPlayer.name .. ' ได้รับ ' .. Zone.Items[1].Get.Text .. ' จำนวน ' .. ESX.Math.GroupDigits(Zone.Items[1].Get.ItemCount) .. ' ' .. Zone.Items[1].Get.Unit .. ' จากการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'ProcessItem', sendToDiscord2, _source, '^2')

-- Bonus

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับโบนัส ' .. v.Text .. ' จำนวน ' .. ESX.Math.GroupDigits(v.ItemCount) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'ProcessItem', sendToDiscord, _source, '^9')

-- Proccess full

local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. Item.Text .. ' จำนวน ' .. ESX.Math.GroupDigits(RemoveCount) .. ' ' .. Item.Unit .. ' ใช้ในการแปรรูปทั้งหมด'
TriggerEvent('azael_discordlogs:sendToDiscord', 'ProcessItem', sendToDiscord, _source, '^3')

Citizen.Wait(100)

local sendToDiscord2 = '' .. xPlayer.name .. ' ได้รับ ' .. Item.Get.Text .. ' จำนวน ' .. ESX.Math.GroupDigits(GetCount) .. ' ' .. Item.Get.Unit .. ' จากการแปรรูปทั้งหมด'
TriggerEvent('azael_discordlogs:sendToDiscord', 'ProcessItem', sendToDiscord2, _source, '^5')

#############################################################################################################################################################################

-- meeta_sell\server\server.lua
#################################
######### [ ขาย-ไอเทม ] #########
#################################

-- sellFunction

local sendToDiscord = '' .. xPlayer.name .. ' ขาย ' .. Item.Text_TH .. ' จำนวน ' .. ESX.Math.GroupDigits(Count) .. ' ' .. Item.Unit .. ' ได้รับ เงินสด จำนวน $' .. ESX.Math.GroupDigits(Price) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'SaleItem', sendToDiscord, _source, '^2')

-- confirmToSell

local sendToDiscord = '' .. xPlayer.name .. ' ขาย ' .. xItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(ItemCount) .. ' ได้รับ เงินสด จำนวน $' .. ESX.Math.GroupDigits(ItemPrice) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'SaleItem', sendToDiscord, _source, '^2')

#############################################################################################################################################################################

-- esx_jb_eden_garage2\client.lua
#################################
######### [ เก็บรถ-การาจ ] ########
#################################

-- ค้นหา TriggerServerEvent('eden_garage:modifystate', vehicleProps.plate, true)

local sendToDiscord = '' .. GetPlayerName(PlayerId()) .. ' เก็บ รถ ทะเบียน ' .. vehicleProps.plate .. ' เข้า Garage และ เสียค่าใช้จ่าย $' .. ESX.Math.GroupDigits(Config.Price) .. ''
TriggerServerEvent('azael_discordlogs:sendToDiscord', 'PutVehicleGarage', sendToDiscord, GetPlayerServerId(PlayerId()), '^7')

#################################
######### [ เรียกรถ-การาจ ] #######
#################################

-- ค้นหา TriggerServerEvent('eden_garage:modifystate', vehicle.plate, false)

local sendToDiscord = '' .. GetPlayerName(PlayerId()) .. ' นำ รถ ทะเบียน ' .. vehicle.plate .. ' ออกจาก Garage '
TriggerServerEvent('azael_discordlogs:sendToDiscord', 'GetVehicleGarage', sendToDiscord, GetPlayerServerId(PlayerId()), '^2')

#################################
########## [ เรียกรถ-พาวท์ ] #######
#################################

-- ค้นหา TriggerServerEvent('eden_garage:modifystate', plate, true)

local sendToDiscord = '' .. GetPlayerName(PlayerId()) .. ' นำ รถ ทะเบียน ' .. plate .. ' ออกจาก Pound '
TriggerServerEvent('azael_discordlogs:sendToDiscord', 'GetVehiclePound', sendToDiscord, GetPlayerServerId(PlayerId()), '^2')

#############################################################################################################################################################################

-- monster_garage\client\main.lua
########################################
######### [ เก็บ-ยานพาหนะ-การาจ ] #######
########################################

-- ค้นหา function StoreVehicle(vehicle, vehicleProps)

local sendToDiscord = '' .. GetPlayerName(PlayerId()) .. ' เก็บ ' .. GetDisplayNameFromVehicleModel(vehicleProps.model) .. ' ทะเบียน ' .. vehicleProps.plate .. ' เข้า Garage'
TriggerServerEvent('azael_discordlogs:sendToDiscord', 'PutVehicleGarage', sendToDiscord, GetPlayerServerId(PlayerId()), '^7')

#########################################
######### [ เรียก-ยานพาหนะ-การาจ ] #######
#########################################

-- ค้นหา function SpawnVehicle(vehicle, plate)

local sendToDiscord = '' .. GetPlayerName(PlayerId()) .. ' นำ ' .. GetDisplayNameFromVehicleModel(vehicle.model) .. ' ทะเบียน ' .. plate .. ' ออกจาก Garage '
TriggerServerEvent('azael_discordlogs:sendToDiscord', 'GetVehicleGarage', sendToDiscord, GetPlayerServerId(PlayerId()), '^2')

#########################################
########## [ เรียก-ยานพาหนะ-พาวท์ ] #######
#########################################

-- ค้นหา function SpawnPoundedVehicle(vehicle, plate)

local sendToDiscord = '' .. GetPlayerName(PlayerId()) .. ' นำ ' .. GetDisplayNameFromVehicleModel(vehicle.model) .. ' ทะเบียน ' .. plate .. ' ออกจาก Pound '
TriggerServerEvent('azael_discordlogs:sendToDiscord', 'GetVehiclePound', sendToDiscord, GetPlayerServerId(PlayerId()), '^2')

#############################################################################################################################################################################

-- meeta_drugs\server\server.lua
#################################
########### [ เก็บ-กัญชา ] ########
#################################

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. xItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(xItemCount) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobWeed', sendToDiscord, source, '^2')

#################################
########### [ เก็บ-ฝิ่น ] ##########
#################################

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. xItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(xItemCount) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobMeth', sendToDiscord, source, '^2')

#################################
########### [ เก็บ-โคเคน ] ########
#################################

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. xItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(xItemCount) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobCoke', sendToDiscord, source, '^2')

#############################################################################################################################################################################

-- caruby_coke\server\main.lua
###############################
######### [ เก็บ-โคเคน ] ########
###############################

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. xItem.label .. ' จำนวน 1'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobCoke', sendToDiscord, source, '^2')

#################################
######### [ แปรรูป-โคเคน ] ########
#################################

local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. xCoke.label .. ' จำนวน 2 ใช้ในการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobCokeProcess', sendToDiscord, _source, '^1')

Citizen.Wait(100)

local sendToDiscord2 = '' .. xPlayer.name .. ' ได้รับ ' .. xPooch.label .. ' จำนวน 1 จากการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobCokeProcess', sendToDiscord2, _source, '^2')

###############################
######### [ ขาย-โคเคน ] ########
###############################

if Config.GiveBlack then
	local sendToDiscord = '' .. xPlayer.name .. ' ขาย ' .. xItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(amount) .. ' ได้รับ Dirty Money $' .. ESX.Math.GroupDigits(price) .. ''
	TriggerEvent('azael_discordlogs:sendToDiscord', 'JobCokeSell', sendToDiscord, source, '^3')
else
	local sendToDiscord = '' .. xPlayer.name .. ' ขาย ' .. xItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(amount) .. ' ได้รับ Money $' .. ESX.Math.GroupDigits(price) .. ''
	TriggerEvent('azael_discordlogs:sendToDiscord', 'JobCokeSell', sendToDiscord, source, '^2')
end

#############################################################################################################################################################################

-- fm_cottage\server\main.lua
##################################
######### [ เก็บกระท่อม ] ##########
##################################

local randomItem = math.random(1,10)

xPlayer.addInventoryItem(xItem.name, randomItem)

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. xItem.label .. ' จำนวน ' .. randomItem .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'CottageJob', sendToDiscord, source, '^2')

-- fm_cottagepack\server.lua
#######################################
########### [ แปรรูปกระท่อม ] ##########
#######################################

local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. xMin.label .. ' จำนวน 5 ใช้ในการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'ProcessItem', sendToDiscord, _source, '^1')

Citizen.Wait(100)

local sendToDiscord2 = '' .. xPlayer.name .. ' ได้รับ ' .. xMax.label .. ' จำนวน 1 จากการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'ProcessItem', sendToDiscord2, _source, '^2')

#############################################################################################################################################################################
-- meeta_selldrug\server\server.lua
#################################
######## [ ขาย-ยาเสพติด ] #######
#################################

if Data.DirtMoney then
	local sendToDiscord = '' .. xPlayer.name .. ' ขาย ' .. Data.ItemLabel .. ' จำนวน 1 ได้รับ Dirty Money จำนวน $' .. ESX.Math.GroupDigits(payment_price) .. ''
	TriggerEvent('azael_discordlogs:sendToDiscord', 'SellDrug', sendToDiscord, source, '^3')
end

#################################
######## [ ขาย-อาหาร ] #########
#################################

if not Data.DirtMoney then
	local sendToDiscord = '' .. xPlayer.name .. ' ขาย ' .. Data.ItemLabel .. ' จำนวน 1 ได้รับ เงินสด จำนวน $' .. ESX.Math.GroupDigits(payment_price) .. ''
	TriggerEvent('azael_discordlogs:sendToDiscord', 'SellFood', sendToDiscord, source, '^2')
end

-- stasiek_selldrugs\server\main.lua
#################################
######## [ ขายยาเสพติด ] ########
#################################

local sendToDiscord = '' .. xPlayer.name .. ' ขาย ' .. ESX.GetItemLabel(drugType) .. ' จำนวน ' .. x .. ' ได้รับ Dirty Money จำนวน $' .. ESX.Math.GroupDigits(blackMoney) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'SellDrug', sendToDiscord, _source, '^2')

#############################################################################################################################################################################

-- esx_blanchisseur\server\main.lua
#################################
###### [ เงินแดงแลกเงินเขียว ] ######
#################################

-- washMoney

local sendToDiscord = '' .. xPlayer.name .. ' เปลี่ยน Dirty Money จำนวน $' .. ESX.Math.GroupDigits(amount) .. ' เป็น เงินสด จำนวน $' .. ESX.Math.GroupDigits(washedMoney) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'WashDirtyMoney', sendToDiscord, source, '^2')	

-- function WhiteningMoney

local sendToDiscord = '' .. xPlayer.name .. ' เปลี่ยน Dirty Money จำนวน $' .. ESX.Math.GroupDigits(Config.Slice) .. ' เป็น เงินสด จำนวน $' .. ESX.Math.GroupDigits(washedMoney) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'WashDirtyMoney', sendToDiscord, source, '^5')

-- blackmoney\server\main.lua
#################################
###### [ เงินแดงแลกเงินเขียว ] ######
#################################

local sendToDiscord = '' .. xPlayer.name .. ' เปลี่ยน Dirty Money จำนวน $' .. ESX.Math.GroupDigits(Config.Zone.Main.add) .. ' เป็น เงินสด จำนวน $' .. ESX.Math.GroupDigits(Config.Zone.Main.add) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'WashDirtyMoney', sendToDiscord, _source, '^2')	

#############################################################################################################################################################################

-- meeta_advanced_craft\server\main.lua
#################################
######### [ คราฟ-อาวุธ ] #########
#################################

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. ESX.GetWeaponLabel(ItemName) .. ' จำนวน ' .. ESX.Math.GroupDigits(count) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'CraftWeapon', sendToDiscord, _source, '^1')

#################################
######### [ คราฟ-กระสุน ] ########
#################################

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. ESX.GetWeaponLabel(ItemName) .. ' จำนวน ' .. ESX.Math.GroupDigits(count) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'CraftAmmo', sendToDiscord, _source, '^3')

#################################
######### [ คราฟ-ไอเทม ] ########
#################################

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. ESX.GetItemLabel(itemName) .. ' จำนวน ' .. ESX.Math.GroupDigits(count) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'CraftItem', sendToDiscord, _source, '^2')

#############################################################################################################################################################################

-- new_banking\server.lua
#################################
########## [ ฝากเงิน ] ###########
#################################

-- deposit

local moneyBalance = xPlayer.getMoney()	
local bankBalance = xPlayer.getAccount('bank').money

local sendToDiscord = '' .. xPlayer.name .. ' ฝากเงิน จำนวน $' .. ESX.Math.GroupDigits(amount) .. ' คงเหลือในกระเป๋า $' .. ESX.Math.GroupDigits(moneyBalance) .. ' มีเงินในบัญชี $' .. ESX.Math.GroupDigits(bankBalance) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'BankDeposit', sendToDiscord, _source, '^2')

#################################
########## [ ถอนเงิน ] ###########
#################################

-- withdraw

local bankBalance = xPlayer.getAccount('bank').money
local moneyBalance = xPlayer.getMoney()

local sendToDiscord = '' .. xPlayer.name .. ' ถอนเงิน จำนวน $' .. ESX.Math.GroupDigits(amount) .. ' ในบัญชีคงเหลือ $' .. ESX.Math.GroupDigits(bankBalance) .. ' มีเงินในกระเป๋า $' .. ESX.Math.GroupDigits(moneyBalance) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'BankWithdraw', sendToDiscord, _source, '^1')

#################################
########## [ โอนเงิน ] ###########
#################################

-- transfer

local xBankBalance = xPlayer.getAccount('bank').money
local zBankBalance = zPlayer.getAccount('bank').money
			
local sendToDiscord = '' .. xPlayer.name .. ' โอนเงิน ไปยัง ' .. zPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(amountt) .. ' ในบัญชีคงเหลือ $' .. ESX.Math.GroupDigits(xBankBalance) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'BankTransfer', sendToDiscord, _source, '^3')

Citizen.Wait(100)
			
local sendToDiscord2 = '' .. zPlayer.name .. ' ได้รับเงิน จาก ' .. xPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(amountt) .. ' มีเงินในบัญชีทั้งหมด $' .. ESX.Math.GroupDigits(zBankBalance) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'BankTransfer', sendToDiscord2, to, '^2')

#############################################################################################################################################################################

-- gcphone\server\bank.lua
#################################
########## [ โอนเงิน-มือถือ ] ######
#################################

local xBankBalance = xPlayer.getAccount('bank').money
local zBankBalance = zPlayer.getAccount('bank').money
											
local sendToDiscord = '' .. xPlayer.name .. ' โอนเงิน ไปยัง ' .. zPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(amountt) .. ' ในบัญชีคงเหลือ $' .. ESX.Math.GroupDigits(xBankBalance) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'BankTransferPhone', sendToDiscord, _source, '^3')
								
Citizen.Wait(100)
											
local sendToDiscord2 = '' .. zPlayer.name .. ' ได้รับเงิน จาก ' .. xPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(amountt) .. ' มีเงินในบัญชีทั้งหมด $' .. ESX.Math.GroupDigits(zBankBalance) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'BankTransferPhone', sendToDiscord2, to, '^2')

#############################################################################################################################################################################

-- esx_billing\server\main.lua
#################################
######## [ เรียกเก็บเงิน ] ##########
#################################

-- Player

local sendToDiscord = '' .. xPlayer.name .. ' เรียกเก็บเงินค่า ' .. label .. ' กับ ' .. xTarget.name .. ' จำนวน $' .. ESX.Math.GroupDigits(amount) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'SendBill', sendToDiscord, xPlayer.source, '^2')

Citizen.Wait(100)
														
local sendToDiscord2 = '' .. xTarget.name .. ' ค้างชำระค่า ' .. label .. ' กับ ' .. xPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(amount) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'SendBill', sendToDiscord2, xTarget.source, '^1')

-- Society

local sendToDiscord = '' .. xPlayer.name .. ' เรียกเก็บเงินค่า ' .. label .. ' กับ ' .. xTarget.name .. ' จำนวน $' .. ESX.Math.GroupDigits(amount) .. ' Target: [' .. sharedAccountName .. ']'
TriggerEvent('azael_discordlogs:sendToDiscord', 'SendBill', sendToDiscord, xPlayer.source, '^2')

Citizen.Wait(100)
														
local sendToDiscord2 = '' .. xTarget.name .. ' ค้างชำระค่า ' .. label .. ' กับ ' .. xPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(amount) .. ' Target: [' .. sharedAccountName .. ']'
TriggerEvent('azael_discordlogs:sendToDiscord', 'SendBill', sendToDiscord2, xTarget.source, '^1')

#################################
########### [ จ่ายบิล ] ###########
#################################

-- Player

local sendToDiscord = '' .. xPlayer.name .. ' ชำระเงินค่า ' .. result[1].label .. ' ให้กับ ' .. xTarget.name .. ' จำนวน $' .. ESX.Math.GroupDigits(amount) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'PayBill', sendToDiscord, xPlayer.source, '^2')

Citizen.Wait(100)
															
local sendToDiscord2 = '' .. xTarget.name .. ' ได้รับเงินค่า ' .. result[1].label .. ' จาก ' .. xPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(amount) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'PayBill', sendToDiscord2, xTarget.source, '^5')

-- Society

local sendToDiscord = '' .. xPlayer.name .. ' ชำระเงินค่า ' .. result[1].label .. ' จำนวน $' .. ESX.Math.GroupDigits(amount) .. ' Target: ['.. target .. ']'
TriggerEvent('azael_discordlogs:sendToDiscord', 'PayBill', sendToDiscord, xPlayer.source, '^2')
																					
if xTarget ~= nil then
	Citizen.Wait(100)
																						
	local sendToDiscord2 = '' .. xTarget.name .. ' ได้รับเงินค่า ' .. result[1].label .. ' จาก ' .. xPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(amount) .. ' Target: ['.. target .. ']'
	TriggerEvent('azael_discordlogs:sendToDiscord', 'PayBill', sendToDiscord2, xTarget.source, '^5')
end

#############################################################################################################################################################################

-- ตำรวจยึด และ ผู้เล่นโขมย ไอเทม (UI กระเป๋า)
-- esx_inventoryhud\server\main.lua
#################################
########### [ ยึด-ไอเทม ] ########
#################################

local sendToDiscord = '' .. targetXPlayer.name .. ' ยึด ' .. sourceItem.label .. ' จาก ' .. sourceXPlayer.name .. ' จำนวน ' .. ESX.Math.GroupDigits(itemCount) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'SeizeItem', sendToDiscord, targetXPlayer.source, '^2')

Citizen.Wait(100)
										
local sendToDiscord2 = '' .. sourceXPlayer.name .. ' ถูกยึด ' .. sourceItem.label .. ' โดย ' .. targetXPlayer.name .. ' จำนวน ' .. ESX.Math.GroupDigits(itemCount) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'SeizeItem', sendToDiscord2, sourceXPlayer.source, '^3')

#################################
########### [ ยึด-เงินเขียว ] ########
#################################

local sendToDiscord = '' .. targetXPlayer.name .. ' ยึด เงินสด จาก ' .. sourceXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'SeizeMoney', sendToDiscord, targetXPlayer.source, '^3')

Citizen.Wait(100)
					
local sendToDiscord2 = '' .. sourceXPlayer.name .. ' ถูกยึด เงินสด โดย ' .. targetXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'SeizeMoney', sendToDiscord2, sourceXPlayer.source, '^2')

#################################
########### [ ยึด-เงินแดง ] ########
#################################

local sendToDiscord = '' .. targetXPlayer.name .. ' ยึด ' .. itemName .. ' จาก ' .. sourceXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'SeizeDirtyMoney', sendToDiscord, targetXPlayer.source, '^3')

Citizen.Wait(100)
					
local sendToDiscord2 = '' .. sourceXPlayer.name .. ' ถูกยึด ' .. itemName .. ' โดย ' .. targetXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(itemCount) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'SeizeDirtyMoney', sendToDiscord2, sourceXPlayer.source, '^2')

#################################
########### [ ยึด-อาวุธ ] ##########
#################################

local weaponLabel = ESX.GetWeaponLabel(itemName)

if itemCount > 0 then
	local sendToDiscord = '' .. targetXPlayer.name .. ' ยึด ' .. weaponLabel .. ' จาก ' .. sourceXPlayer.name .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(itemCount) .. ''
	TriggerEvent('azael_discordlogs:sendToDiscord', 'SeizeWeapon', sendToDiscord, targetXPlayer.source, '^3')

	Citizen.Wait(100)
				
	local sendToDiscord2 = '' .. sourceXPlayer.name .. ' ถูกยึด ' .. weaponLabel .. ' โดย ' .. targetXPlayer.name .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(itemCount) .. ''
	TriggerEvent('azael_discordlogs:sendToDiscord', 'SeizeWeapon', sendToDiscord2, sourceXPlayer.source, '^2')
else
	local sendToDiscord = '' .. targetXPlayer.name .. ' ยึด ' .. weaponLabel .. ' จาก ' .. sourceXPlayer.name .. '  จำนวน 1'
	TriggerEvent('azael_discordlogs:sendToDiscord', 'SeizeWeapon', sendToDiscord, targetXPlayer.source, '^3')

	Citizen.Wait(100)
				
	local sendToDiscord2 = '' .. sourceXPlayer.name .. ' ถูกยึด ' .. weaponLabel .. ' โดย ' .. targetXPlayer.name .. ' จำนวน 1'
	TriggerEvent('azael_discordlogs:sendToDiscord', 'SeizeWeapon', sendToDiscord2, sourceXPlayer.source, '^2')
end

#############################################################################################################################################################################

-- แบบ Menu F6 (ตำรวจ)
-- esx_policejob\server\main.lua
#################################
########### [ ยึด-ไอเทม ] ########
#################################

local sendToDiscord = '' .. sourceXPlayer.name .. ' ยึด ' .. sourceItem.label .. ' จาก ' .. targetXPlayer.name .. ' จำนวน ' .. ESX.Math.GroupDigits(amount) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'PoliceSeizeItem', sendToDiscord, sourceXPlayer.source, '^5')

Citizen.Wait(100)
					
local sendToDiscord2 = '' .. targetXPlayer.name .. ' ถูกยึด ' .. sourceItem.label .. ' โดย ' .. sourceXPlayer.name .. ' จำนวน ' .. ESX.Math.GroupDigits(amount) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'PoliceSeizeItem', sendToDiscord2, targetXPlayer.source, '^7')

#################################
########### [ ยึด-เงินเขียว ] ########
#################################

local sendToDiscord = '' .. sourceXPlayer.name .. ' ยึด เงินสด จาก ' .. targetXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(amount) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'PoliceSeizeMoney', sendToDiscord, sourceXPlayer.source, '^5')

Citizen.Wait(100)
					
local sendToDiscord2 = '' .. targetXPlayer.name .. ' ถูกยึด เงินสด โดย ' .. sourceXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(amount) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'PoliceSeizeMoney', sendToDiscord2, targetXPlayer.source, '^7')

#################################
########### [ ยึด-เงินแดง ] ########
#################################

local sendToDiscord = '' .. sourceXPlayer.name .. ' ยึด ' .. itemName .. ' จาก ' .. targetXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(amount) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'PoliceSeizeDirtyMoney', sendToDiscord, sourceXPlayer.source, '^5')

Citizen.Wait(100)
					
local sendToDiscord2 = '' .. targetXPlayer.name .. ' ถูกยึด ' .. itemName .. ' โดย ' .. sourceXPlayer.name .. ' จำนวน $' .. ESX.Math.GroupDigits(amount) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'PoliceSeizeDirtyMoney', sendToDiscord2, targetXPlayer.source, '^7')

#################################
########### [ ยึด-อาวุธ ] ##########
#################################

if amount > 0 then
	local sendToDiscord = '' .. sourceXPlayer.name .. ' ยึด ' .. ESX.GetWeaponLabel(itemName) .. ' จาก ' .. targetXPlayer.name .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(amount) .. ''
	TriggerEvent('azael_discordlogs:sendToDiscord', 'PoliceSeizeWeapon', sendToDiscord, sourceXPlayer.source, '^5')

	Citizen.Wait(100)
				
	local sendToDiscord2 = '' .. targetXPlayer.name .. ' ถูกยึด ' .. ESX.GetWeaponLabel(itemName) .. ' โดย ' .. sourceXPlayer.name .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(amount) .. ''
	TriggerEvent('azael_discordlogs:sendToDiscord', 'PoliceSeizeWeapon', sendToDiscord2, targetXPlayer.source, '^7')
else
	local sendToDiscord = '' .. sourceXPlayer.name .. ' ยึด ' .. ESX.GetWeaponLabel(itemName) .. ' จาก ' .. targetXPlayer.name .. '  จำนวน 1'
	TriggerEvent('azael_discordlogs:sendToDiscord', 'PoliceSeizeWeapon', sendToDiscord, sourceXPlayer.source, '^5')

	Citizen.Wait(100)
				
	local sendToDiscord2 = '' .. targetXPlayer.name .. ' ถูกยึด ' .. ESX.GetWeaponLabel(itemName) .. ' โดย ' .. sourceXPlayer.name .. ' จำนวน 1'
	TriggerEvent('azael_discordlogs:sendToDiscord', 'PoliceSeizeWeapon', sendToDiscord2, targetXPlayer.source, '^7')
end

#################################
######### [ ยึด-กุญแจรถ ] #########
#################################

local sendToDiscord = '' .. sourceXPlayer.name .. ' ยึด กุญแจรถ จาก ' .. targetXPlayer.name .. ' ทะเบียน ' .. itemName .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'PoliceSeizeKeyCar', sendToDiscord, sourceXPlayer.source, '^5')

Citizen.Wait(100)
					
local sendToDiscord2 = '' .. targetXPlayer.name .. ' ถูกยึด กุญแจรถ โดย ' .. sourceXPlayer.name .. ' ทะเบียน ' .. itemName .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'PoliceSeizeKeyCar', sendToDiscord2, targetXPlayer.source, '^7')

#################################
######### [ ยึด-กุญแจบ้าน ] ########
#################################

local sendToDiscord = '' .. sourceXPlayer.name .. ' ยึด กุญแจบ้าน จาก ' .. targetXPlayer.name .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'PoliceSeizeKeyHouse', sendToDiscord, sourceXPlayer.source, '^5')

Citizen.Wait(100)
					
local sendToDiscord2 = '' .. targetXPlayer.name .. ' ถูกยึด กุญแจบ้าน โดย ' .. sourceXPlayer.name .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'PoliceSeizeKeyHouse', sendToDiscord2, targetXPlayer.source, '^7')

##########################################
######### [ ไอเทม-ออกจากคลัง ] ##########
##########################################

local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. inventoryItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(count) .. ' ออกจากคลัง'
TriggerEvent('azael_discordlogs:sendToDiscord', 'PoliceGetStockItem', sendToDiscord, xPlayer.source, '^3')

#######################################
######### [ ไอเทม-เก็บเข้าคลัง ] ##########
#######################################

local sendToDiscord = '' .. xPlayer.name .. ' เก็บ ' .. inventoryItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(count) .. ' เข้าคลัง'
TriggerEvent('azael_discordlogs:sendToDiscord', 'PolicePutStockItem', sendToDiscord, xPlayer.source, '^2')

###########################################
########### [ อุปกรณ์-เก็บเข้าคลัง ] ############
###########################################

local sendToDiscord = '' .. xPlayer.name .. ' เก็บ ' .. ESX.GetWeaponLabel(weaponName) .. ' เข้าคลัง'
TriggerEvent('azael_discordlogs:sendToDiscord', 'PolicePutArmoryWeapon', sendToDiscord, xPlayer.source, '^2')

###########################################
########### [ อุปกรณ์-เบิกจากคลัง ] ###########
###########################################

local sendToDiscord = '' .. xPlayer.name .. ' เบิก ' .. ESX.GetWeaponLabel(weaponName) .. ' และ กระสุน จำนวน 500 จากคลัง'
TriggerEvent('azael_discordlogs:sendToDiscord', 'PoliceGetArmoryWeapon', sendToDiscord, xPlayer.source, '^3')

###################################
########### [ ซื้อ-อาวุธ ] ############
###################################

-- Weapon

local sendToDiscord = '' .. xPlayer.name .. ' ซื้อ ' .. ESX.GetWeaponLabel(weaponName) .. ' และ กระสุน จำนวน 100 ราคา $' .. ESX.Math.GroupDigits(selectedWeapon.price) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'PoliceBuyWeapon', sendToDiscord, xPlayer.source, '^4')

-- Weapon Component

local sendToDiscord = '' .. xPlayer.name .. ' ซื้อ ' .. component.label .. ' ส่วนประกอบของอาวุธ ' .. ESX.GetWeaponLabel(weaponName) .. ' ราคา $' .. ESX.Math.GroupDigits(price)  .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'PoliceBuyWeapon', sendToDiscord, xPlayer.source, '^5')

###################################
########### [ ซื้อ-รถตำรวจ ] #########
###################################

local sendToDiscord = '' .. xPlayer.name .. ' ซื้อรถ ' .. vehicleProps.model .. ' ทะเบียน ' .. vehicleProps.plate .. ' ราคา $' .. ESX.Math.GroupDigits(price) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'PoliceBuyVehicle', sendToDiscord, xPlayer.source, '^2')

-- esx_policejob\client\main.lua
###################################
########### [ งัด-รถ ] ############
###################################

local plate = GetVehicleNumberPlateText(vehicle)
local sendToDiscord = '' .. GetPlayerName(PlayerId()) .. ' งัดรถ ทะเบียน ' .. plate .. ''
TriggerServerEvent('azael_discordlogs:sendToDiscord', 'PoliceHijack', sendToDiscord, GetPlayerServerId(PlayerId()), '^5')

###################################
########### [ ส่งรถไปพาวท์ ] ########
###################################

-- Garage

local plate = GetVehicleNumberPlateText(vehicle)
local sendToDiscord = '' .. GetPlayerName(PlayerId()) .. ' ส่งรถ ทะเบียน ' .. plate .. ' ไปยังพาวท์'
TriggerServerEvent('azael_discordlogs:sendToDiscord', 'PoliceImPound', sendToDiscord, GetPlayerServerId(PlayerId()), '^5')

-- Pound

local plate = GetVehicleNumberPlateText(vehicle)
local sendToDiscord = '' .. GetPlayerName(PlayerId()) .. ' ยึดรถ ทะเบียน ' .. plate .. ' ไปยังพาวท์'
TriggerServerEvent('azael_discordlogs:sendToDiscord', 'PoliceImPound', sendToDiscord, GetPlayerServerId(PlayerId()), '^3')

#############################################################################################################################################################################

-- xD_jail\server\server.lua
#####################################
########### [ เข้า-เรือนจำ ] ###########
#####################################

local sourcexPlayer = ESX.GetPlayerFromId(src)
local targetxPlayer = ESX.GetPlayerFromId(targetSrc)

local sendToDiscord = '' .. sourcexPlayer.name .. ' ส่ง ' .. targetxPlayer.name .. ' ไปยังเรือนจำ เป็นเวลา ' .. jailTime .. ' นาที ในข้อหา ' ..  jailReason .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'PoliceJail', sendToDiscord, src, '^4')

Citizen.Wait(100)

local sendToDiscord = '' .. targetxPlayer.name .. ' ถูก ' .. sourcexPlayer.name .. ' ส่งตัวไปยังเรือนจำ เป็นเวลา ' .. jailTime .. ' นาที ในข้อหา ' ..  jailReason .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'PoliceJail', sendToDiscord, targetSrc, '^8')

#####################################
########### [ ออก-เรือนจำ ] ##########
#####################################

local sendToDiscord = '' .. xPlayer.name .. ' ถูกปล่อยตัวจากเรือนจำ'
TriggerEvent('azael_discordlogs:sendToDiscord', 'PoliceUnJail', sendToDiscord, src, '^2')

#############################################################################################################################################################################

-- monster_vault\server\main.lua
################################################
########### [ หน่วยงาน-ไอเทม-ออกเซฟ ] ###########
################################################

-- Society

local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. inventoryItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(count) .. ' ออกจากตู้นิรภัย'
TriggerEvent('azael_discordlogs:sendToDiscord', 'VaultGetItemJob', sendToDiscord, _source, '^2')

########################################
########### [ ไอเทม-ออกเซฟ ] ###########
########################################

-- Vault

local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. inventoryItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(count) .. ' ออกจากตู้นิรภัย'
TriggerEvent('azael_discordlogs:sendToDiscord', 'VaultGetItem', sendToDiscord, _source, '^2')

################################################
########### [ หน่วยงาน-เงินเเดง-ออกเซฟ ] ##########
################################################

-- Society

local sendToDiscord = '' .. xPlayer.name .. ' นำ Derty Money จำนวน $' .. ESX.Math.GroupDigits(count) .. ' ออกจากตู้นิรภัย'
TriggerEvent('azael_discordlogs:sendToDiscord', 'VaultGetMoneyJob', sendToDiscord, _source, '^3')

########################################
########### [ เงินเเดง-ออกเซฟ ] ##########
########################################

-- Vault

local sendToDiscord = '' .. xPlayer.name .. ' นำ Derty Money จำนวน $' .. ESX.Math.GroupDigits(count) .. ' ออกจากตู้นิรภัย'
TriggerEvent('azael_discordlogs:sendToDiscord', 'VaultGetMoney', sendToDiscord, _source, '^3')

###############################################
########### [ หน่วยงาน-อาวุธ-ออกเซฟ ] ##########
###############################################

-- Society

if ammo ~= nil and ammo > 0 then
	local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. ESX.GetWeaponLabel(weaponName) .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(ammo) .. ' ออกจากตู้นิรภัย'
	TriggerEvent('azael_discordlogs:sendToDiscord', 'VaultGetWeaponJob', sendToDiscord, _source, '^1')
else
	local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. ESX.GetWeaponLabel(weaponName) .. ' ออกจากตู้นิรภัย'
	TriggerEvent('azael_discordlogs:sendToDiscord', 'VaultGetWeaponJob', sendToDiscord, _source, '^1')
end

######################################
########### [ อาวุธ-ออกเซฟ ] ##########
######################################

-- Vault

if ammo ~= nil and ammo > 0 then
	local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. ESX.GetWeaponLabel(weaponName) .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(ammo) .. ' ออกจากตู้นิรภัย'
	TriggerEvent('azael_discordlogs:sendToDiscord', 'VaultGetWeapon', sendToDiscord, _source, '^1')
else
	local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. ESX.GetWeaponLabel(weaponName) .. ' ออกจากตู้นิรภัย'
	TriggerEvent('azael_discordlogs:sendToDiscord', 'VaultGetWeapon', sendToDiscord, _source, '^1')
end

###############################################
########### [ หน่วยงาน-ไอเทม-เข้าเซฟ ] ##########
###############################################

-- Society

local sendToDiscord = '' .. xPlayer.name .. ' ฝาก ' .. inventory.getItem(item).label .. ' จำนวน ' .. ESX.Math.GroupDigits(count) .. ' เข้าตู้นิรภัย'
TriggerEvent('azael_discordlogs:sendToDiscord', 'VaultPutItemJob', sendToDiscord, _source, '^2')

#######################################
########### [ ไอเทม-เข้าเซฟ ] ##########
#######################################

-- Vault

local sendToDiscord = '' .. xPlayer.name .. ' ฝาก ' .. inventory.getItem(item).label .. ' จำนวน ' .. ESX.Math.GroupDigits(count) .. ' เข้าตู้นิรภัย'
TriggerEvent('azael_discordlogs:sendToDiscord', 'VaultPutItem', sendToDiscord, _source, '^2')

################################################
########### [ หน่วยงาน-เงินเเดง-เข้าเซฟ ] ##########
################################################

-- Societ

local sendToDiscord = '' .. xPlayer.name .. ' ฝาก Derty Money จำนวน $' .. ESX.Math.GroupDigits(count) .. ' เข้าตู้นิรภัย'
TriggerEvent('azael_discordlogs:sendToDiscord', 'VaultPutMoneyJob', sendToDiscord, _source, '^3')

########################################
########### [ เงินเเดง-เข้าเซฟ ] ##########
########################################

-- Vault

local sendToDiscord = '' .. xPlayer.name .. ' ฝาก Derty Money จำนวน $' .. ESX.Math.GroupDigits(count) .. ' เข้าตู้นิรภัย'
TriggerEvent('azael_discordlogs:sendToDiscord', 'VaultPutMoney', sendToDiscord, _source, '^3')

####################################################
############# [ หน่วยงาน-อาวุธ-เข้าเซฟ ] ##############
####################################################

-- Societ

if count > 0 then
	local sendToDiscord = '' .. xPlayer.name .. ' ฝาก ' .. ESX.GetWeaponLabel(item) .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(count) .. ' เข้าตู้นิรภัย'
	TriggerEvent('azael_discordlogs:sendToDiscord', 'VaultPutWeaponJob', sendToDiscord, _source, '^1')
else
	local sendToDiscord = '' .. xPlayer.name .. ' ฝาก ' .. ESX.GetWeaponLabel(item) .. ' เข้าตู้นิรภัย'
	TriggerEvent('azael_discordlogs:sendToDiscord', 'VaultPutWeaponJob', sendToDiscord, _source, '^1')
end

############################################
############# [ อาวุธ-เข้าเซฟ ] ##############
############################################

-- Vault

if count > 0 then
	local sendToDiscord = '' .. xPlayer.name .. ' ฝาก ' .. ESX.GetWeaponLabel(item) .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(count) .. ' เข้าตู้นิรภัย'
	TriggerEvent('azael_discordlogs:sendToDiscord', 'VaultPutWeapon', sendToDiscord, _source, '^1')
else
	local sendToDiscord = '' .. xPlayer.name .. ' ฝาก ' .. ESX.GetWeaponLabel(item) .. ' เข้าตู้นิรภัย'
	TriggerEvent('azael_discordlogs:sendToDiscord', 'VaultPutWeapon', sendToDiscord, _source, '^1')
end

#############################################################################################################################################################################

-- cjjoeza_vault\server\main.lua
################################################
########### [ หน่วยงาน-ไอเทม-ออกเซฟ ] ###########
################################################

-- Society

local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. inventoryItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(count) .. ' ออกจากตู้นิรภัย'
TriggerEvent('azael_discordlogs:sendToDiscord', 'VaultGetItemJob', sendToDiscord, _source, '^2')

########################################
########### [ ไอเทม-ออกเซฟ ] ###########
########################################

-- Vault

local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. inventoryItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(count) .. ' ออกจากตู้นิรภัย'
TriggerEvent('azael_discordlogs:sendToDiscord', 'VaultGetItem', sendToDiscord, _source, '^2')

################################################
########### [ หน่วยงาน-เงินเเดง-ออกเซฟ ] ##########
################################################

-- Society

local sendToDiscord = '' .. xPlayer.name .. ' นำ Derty Money จำนวน $' .. ESX.Math.GroupDigits(count) .. ' ออกจากตู้นิรภัย'
TriggerEvent('azael_discordlogs:sendToDiscord', 'VaultGetMoneyJob', sendToDiscord, _source, '^3')

########################################
########### [ เงินเเดง-ออกเซฟ ] ##########
########################################

-- Vault

local sendToDiscord = '' .. xPlayer.name .. ' นำ Derty Money จำนวน $' .. ESX.Math.GroupDigits(count) .. ' ออกจากตู้นิรภัย'
TriggerEvent('azael_discordlogs:sendToDiscord', 'VaultGetMoney', sendToDiscord, _source, '^3')

##############################################
########### [ หน่วยงาน-อาวุธ-ออกเซฟ ] ##########
##############################################

-- Society

if ammo > 0 then
	local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. ESX.GetWeaponLabel(weaponName) .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(ammo) .. ' ออกจากตู้นิรภัย'
	TriggerEvent('azael_discordlogs:sendToDiscord', 'VaultGetWeaponJob', sendToDiscord, _source, '^1')
else
	local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. ESX.GetWeaponLabel(weaponName) .. ' ออกจากตู้นิรภัย'
	TriggerEvent('azael_discordlogs:sendToDiscord', 'VaultGetWeaponJob', sendToDiscord, _source, '^1')
end

######################################
########### [ อาวุธ-ออกเซฟ ] ##########
######################################

-- Vault

if ammo > 0 then
	local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. ESX.GetWeaponLabel(weaponName) .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(ammo) .. ' ออกจากตู้นิรภัย'
	TriggerEvent('azael_discordlogs:sendToDiscord', 'VaultGetWeapon', sendToDiscord, _source, '^1')
else
	local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. ESX.GetWeaponLabel(weaponName) .. ' ออกจากตู้นิรภัย'
	TriggerEvent('azael_discordlogs:sendToDiscord', 'VaultGetWeapon', sendToDiscord, _source, '^1')
end

###############################################
########### [ หน่วยงาน-ไอเทม-เข้าเซฟ ] ##########
###############################################

-- Society

local sendToDiscord = '' .. xPlayer.name .. ' ฝาก ' .. inventory.getItem(item).label .. ' จำนวน ' .. ESX.Math.GroupDigits(count) .. ' เข้าตู้นิรภัย'
TriggerEvent('azael_discordlogs:sendToDiscord', 'VaultPutItemJob', sendToDiscord, _source, '^2')

#######################################
########### [ ไอเทม-เข้าเซฟ ] ##########
#######################################

-- Vault

local sendToDiscord = '' .. xPlayer.name .. ' ฝาก ' .. inventory.getItem(item).label .. ' จำนวน ' .. ESX.Math.GroupDigits(count) .. ' เข้าตู้นิรภัย'
TriggerEvent('azael_discordlogs:sendToDiscord', 'VaultPutItem', sendToDiscord, _source, '^2')

################################################
########### [ หน่วยงาน-เงินเเดง-เข้าเซฟ ] ##########
################################################

-- Society

local sendToDiscord = '' .. xPlayer.name .. ' ฝาก Derty Money จำนวน $' .. ESX.Math.GroupDigits(count) .. ' เข้าตู้นิรภัย'
TriggerEvent('azael_discordlogs:sendToDiscord', 'VaultPutMoneyJob', sendToDiscord, _source, '^3')

########################################
########### [ เงินเเดง-เข้าเซฟ ] ##########
########################################

-- Vault

local sendToDiscord = '' .. xPlayer.name .. ' ฝาก Derty Money จำนวน $' .. ESX.Math.GroupDigits(count) .. ' เข้าตู้นิรภัย'
TriggerEvent('azael_discordlogs:sendToDiscord', 'VaultPutMoney', sendToDiscord, _source, '^3')

####################################################
############# [ หน่วยงาน-อาวุธ-เข้าเซฟ ] ##############
####################################################

-- Society

if count > 0 then
	local sendToDiscord = '' .. xPlayer.name .. ' ฝาก ' .. ESX.GetWeaponLabel(item) .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(count) .. ' เข้าตู้นิรภัย'
	TriggerEvent('azael_discordlogs:sendToDiscord', 'VaultPutWeaponJob', sendToDiscord, _source, '^1')
else
	local sendToDiscord = '' .. xPlayer.name .. ' ฝาก ' .. ESX.GetWeaponLabel(item) .. ' เข้าตู้นิรภัย'
	TriggerEvent('azael_discordlogs:sendToDiscord', 'VaultPutWeaponJob', sendToDiscord, _source, '^1')
end

############################################
############# [ อาวุธ-เข้าเซฟ ] ##############
############################################

-- Vault

if count > 0 then
	local sendToDiscord = '' .. xPlayer.name .. ' ฝาก ' .. ESX.GetWeaponLabel(item) .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(count) .. ' เข้าตู้นิรภัย'
	TriggerEvent('azael_discordlogs:sendToDiscord', 'VaultPutWeapon', sendToDiscord, _source, '^1')
else
	local sendToDiscord = '' .. xPlayer.name .. ' ฝาก ' .. ESX.GetWeaponLabel(item) .. ' เข้าตู้นิรภัย'
	TriggerEvent('azael_discordlogs:sendToDiscord', 'VaultPutWeapon', sendToDiscord, _source, '^1')
end

#############################################################################################################################################################################

-- esx_weaponshop\server\main.lua
##################################
########### [ ซื้อ-อาวุธ ] ##########
##################################

-- Dirty Money

local sendToDiscord = '' .. xPlayer.name .. ' ซื้อ ' .. ESX.GetWeaponLabel(weaponName) .. ' ราคา $' .. ESX.Math.GroupDigits(price) .. ' จ่ายด้วย Dirty Money'
TriggerEvent('azael_discordlogs:sendToDiscord', 'BuyWeapon', sendToDiscord, source, '^3')

-- Money

local sendToDiscord = '' .. xPlayer.name .. ' ซื้อ ' .. ESX.GetWeaponLabel(weaponName) .. ' ราคา $' .. ESX.Math.GroupDigits(price) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'BuyWeapon', sendToDiscord, source, '^2')


#############################################################################################################################################################################

-- meeta_handcuffs\server\server.lua
#######################################
########### [ ใส่-กุญแจมือ ] ############
#######################################

local targetXPlayer = ESX.GetPlayerFromId(target)
        
local sendToDiscord = '' .. xPlayer.name .. ' ใส่กุญแจมือ ' .. targetXPlayer.name .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'Handcuffs', sendToDiscord, source, '^7')

Citizen.Wait(100)

local sendToDiscord2 = '' ..targetXPlayer.name .. ' ถูก ' .. xPlayer.name .. ' ใส่กุญแจมือ'
TriggerEvent('azael_discordlogs:sendToDiscord', 'Handcuffs', sendToDiscord2, target, '^3')

-- meeta_handcuffs\server\server.lua
#######################################
########### [ ไข-กุญแจมือ ] ############
#######################################

local targetXPlayer = ESX.GetPlayerFromId(target)
        
local sendToDiscord = '' .. xPlayer.name .. ' ไขกุญแจมือ ' .. targetXPlayer.name .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'UnHandcuff', sendToDiscord, source, '^7')

Citizen.Wait(100)

local sendToDiscord2 = '' ..targetXPlayer.name .. ' ถูก ' .. xPlayer.name .. ' ไขกุญแจมือ'
TriggerEvent('azael_discordlogs:sendToDiscord', 'UnHandcuff', sendToDiscord2, target, '^3')

-- meeta_handcuffs\client\client.lua
#################################
########### [ ปล้น ] #############
#################################

local sendToDiscord = '' .. GetPlayerName(PlayerId()) .. ' ปล้น ' .. GetPlayerName(closestPlayer) .. ''
TriggerServerEvent('azael_discordlogs:sendToDiscord', 'HandcuffsSearch', sendToDiscord, GetPlayerServerId(PlayerId()), '^1')

Citizen.Wait(100)

local sendToDiscord2 = '' .. GetPlayerName(closestPlayer) .. ' ถูก ' .. GetPlayerName(PlayerId()) .. ' ปล้น'
TriggerServerEvent('azael_discordlogs:sendToDiscord', 'HandcuffsSearch', sendToDiscord2, GetPlayerServerId(closestPlayer), '^7')

-- meeta_handcuffs\client\client.lua
#################################
########### [ อุ้ม ] #############
#################################

local sendToDiscord = '' .. GetPlayerName(PlayerId()) .. ' อุ้ม ' .. GetPlayerName(closestPlayer) .. ''
TriggerServerEvent('azael_discordlogs:sendToDiscord', 'HandcuffsLyftUpp', sendToDiscord, GetPlayerServerId(PlayerId()), '^7')

Citizen.Wait(100)

local sendToDiscord2 = '' .. GetPlayerName(closestPlayer) .. ' ถูก ' .. GetPlayerName(PlayerId()) .. ' อุ้ม'
TriggerServerEvent('azael_discordlogs:sendToDiscord', 'HandcuffsLyftUpp', sendToDiscord2, GetPlayerServerId(closestPlayer), '^3')

#############################################################################################################################################################################

-- esx_ambulancejob\server\main.lua
####################################
########### [ ชุบชีวิต-ผู้เล่น ] #########
####################################

local targetXPlayer = ESX.GetPlayerFromId(target)

local sendToDiscord = ''	.. xPlayer.name .. ' ชุบชีวิต ' .. targetXPlayer.name .. ' ได้รับ $' .. ESX.Math.GroupDigits(Config.ReviveReward) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'DocRevive', sendToDiscord, xPlayer.source, '^5')

Citizen.Wait(100)

local sendToDiscord = ''	.. targetXPlayer.name .. ' ถูก ' .. xPlayer.name .. ' ชุบชีวิต เสียค่าใช้จ่าย $' .. ESX.Math.GroupDigits(Config.ReviveReward) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'DocRevive', sendToDiscord, targetXPlayer.source, '^3')

####################################
########### [ รักษา-ผู้เล่น ] ##########
####################################

local targetXPlayer = ESX.GetPlayerFromId(target)

local sendToDiscord = ''	.. xPlayer.name .. ' ทำการรักษา ' .. targetXPlayer.name .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'DocHeal', sendToDiscord, xPlayer.source, '^5')

Citizen.Wait(100)

local sendToDiscord = ''	.. targetXPlayer.name .. ' ได้รับการรักษา จาก ' .. xPlayer.name .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'DocHeal', sendToDiscord, targetXPlayer.source, '^2')

#######################################
######### [ เสียชีวิต-ลบไอเทม ] ##########
#######################################

-- Money
local xMoney, xDirtyMoney = xPlayer.getMoney(), xPlayer.getAccount('black_money').money
local sendToDiscord = '' .. xPlayer.name .. ' เสียชีวิต ถูกลบ Money $' .. ESX.Math.GroupDigits(xMoney) .. ' เเละ Dirty Money $' .. ESX.Math.GroupDigits(xDirtyMoney) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'DocRemoveRPDeath', sendToDiscord, xPlayer.source, '^3')

-- Item
local sendToDiscord = '' .. xPlayer.name .. ' เสียชีวิต ถูกลบ ' .. ESX.GetItemLabel(xPlayer.inventory[i].name) .. ' จำนวน ' .. ESX.Math.GroupDigits(xPlayer.inventory[i].count) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'DocRemoveRPDeath', sendToDiscord, xPlayer.source, '^7')
Citizen.Wait(100)

-- Weapon
local sendToDiscord = '' .. xPlayer.name .. ' เสียชีวิต ถูกลบ ' .. ESX.GetWeaponLabel(xPlayer.loadout[i].name) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'DocRemoveRPDeath', sendToDiscord, xPlayer.source, '^1')
Citizen.Wait(100)

#######################################
########### [ ซื้อ-รถหมอ ] #############
#######################################

local sendToDiscord = ''	.. xPlayer.name .. ' ซื้อรถ ' .. vehicleProps.model .. ' ทะเบียน ' .. vehicleProps.plate .. ' ราคา $' .. ESX.Math.GroupDigits(price) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'DocBuyCar', sendToDiscord, xPlayer.source, '^2')

#######################################
########### [ ใช้งาน-ไอเทม ] ###########
#######################################

local sendToDiscord = '' .. xPlayer.name .. ' ใช้ ' .. ESX.GetItemLabel(item) .. ' จำนวน 1'
TriggerEvent('azael_discordlogs:sendToDiscord', 'DocRemoveItem', sendToDiscord, xPlayer.source, '^2')

#######################################
########### [ เบิก-ไอเทม ] #############
#######################################

local sendToDiscord = '' .. xPlayer.name .. ' เบิก ' .. xItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(count) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'DocGiveItem', sendToDiscord, xPlayer.source, '^2')

########################################
########### [ ไอเทม-ออกจากคลัง ] ########
########################################

local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. inventoryItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(count) .. ' ออกจากคลัง'
TriggerEvent('azael_discordlogs:sendToDiscord', 'DocGetItem', sendToDiscord, xPlayer.source, '^3')

########################################
########### [ ไอเทม-เก็บเข้าคลัง ] ########
########################################

local sendToDiscord = '' .. xPlayer.name .. ' เก็บ ' .. inventoryItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(count) .. ' เก็บเข้าคลัง'
TriggerEvent('azael_discordlogs:sendToDiscord', 'DocPutItem', sendToDiscord, xPlayer.source, '^2')

#############################################################################################################################################################################

-- esx_mechanicjob\server\main.lua
#######################################
########### [ เบิก-ไอเทม ] #############
#######################################

-- Harvest
local sendToDiscord = ''	.. xPlayer.name .. ' เบิก ' .. ESX.GetItemLabel('gazbottle') .. ' จำนวน 1'
TriggerEvent('azael_discordlogs:sendToDiscord', 'MechanicHarvestItem', sendToDiscord, xPlayer.source, '^2')

-- Harvest2
local sendToDiscord = ''	.. xPlayer.name .. ' เบิก ' .. ESX.GetItemLabel('fixtool') .. ' จำนวน 1'
TriggerEvent('azael_discordlogs:sendToDiscord', 'MechanicHarvestItem', sendToDiscord, xPlayer.source, '^2')

-- Harvest3
local sendToDiscord = ''	.. xPlayer.name .. ' เบิก ' .. ESX.GetItemLabel('carotool') .. ' จำนวน 1'
TriggerEvent('azael_discordlogs:sendToDiscord', 'MechanicHarvestItem', sendToDiscord, xPlayer.source, '^2')

#################################
########### [ คราฟ-ไอเทม ] ######
#################################

-- Craft
local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. ESX.GetItemLabel('gazbottle') .. ' จำนวน 1 ใช้ในการคราฟ'
TriggerEvent('azael_discordlogs:sendToDiscord', 'MechanicCraftItem', sendToDiscord, xPlayer.source, '^1')

Citizen.Wait(100)

local sendToDiscord2 = '' .. xPlayer.name .. ' ได้รับ ' .. ESX.GetItemLabel('blowpipe') .. ' จำนวน 1 จากการคราฟ'
TriggerEvent('azael_discordlogs:sendToDiscord', 'MechanicCraftItem', sendToDiscord2, xPlayer.source, '^2')

-- Craft2
local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. ESX.GetItemLabel('fixtool') .. ' จำนวน 1 ใช้ในการคราฟ'
TriggerEvent('azael_discordlogs:sendToDiscord', 'MechanicCraftItem', sendToDiscord, xPlayer.source, '^1')

Citizen.Wait(100)

local sendToDiscord2 = '' .. xPlayer.name .. ' ได้รับ ' .. ESX.GetItemLabel('fixkit') .. ' จำนวน 1 จากการคราฟ'
TriggerEvent('azael_discordlogs:sendToDiscord', 'MechanicCraftItem', sendToDiscord2, xPlayer.source, '^2')

-- Craft3
local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. ESX.GetItemLabel('carotool') .. ' จำนวน 1 ใช้ในการคราฟ'
TriggerEvent('azael_discordlogs:sendToDiscord', 'MechanicCraftItem', sendToDiscord, xPlayer.source, '^1')

Citizen.Wait(100)

local sendToDiscord2 = '' .. xPlayer.name .. ' ได้รับ ' .. ESX.GetItemLabel('carokit') .. ' จำนวน 1 จากการคราฟ'
TriggerEvent('azael_discordlogs:sendToDiscord', 'MechanicCraftItem', sendToDiscord2, xPlayer.source, '^2')

##################################
########### [ ใช้งาน-ไอเทม ] ######
##################################

-- blowpipe
local sendToDiscord = ''	.. xPlayer.name .. ' ใช้ ' .. ESX.GetItemLabel('blowpipe') .. ' จำนวน 1'
TriggerEvent('azael_discordlogs:sendToDiscord', 'MechanicUseItem', sendToDiscord, xPlayer.source, '^2')

-- fixkit
local sendToDiscord = ''	.. xPlayer.name .. ' ใช้ ' .. ESX.GetItemLabel('fixkit') .. ' จำนวน 1'
TriggerEvent('azael_discordlogs:sendToDiscord', 'MechanicUseItem', sendToDiscord, xPlayer.source, '^2')

-- carokit
local sendToDiscord = ''	.. xPlayer.name .. ' ใช้ ' .. ESX.GetItemLabel('carokit') .. ' จำนวน 1'
TriggerEvent('azael_discordlogs:sendToDiscord', 'MechanicUseItem', sendToDiscord, xPlayer.source, '^2')

########################################
########### [ ไอเทม-ออกจากคลัง ] ########
########################################

local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. item.label .. ' จำนวน ' .. ESX.Math.GroupDigits(count) .. ' ออกจากคลัง'
TriggerEvent('azael_discordlogs:sendToDiscord', 'MechanicGetItem', sendToDiscord, xPlayer.source, '^3')

########################################
########### [ ไอเทม-เก็บเข้าคลัง ] ########
########################################

local sendToDiscord = '' .. xPlayer.name .. ' เก็บ ' .. item.label .. ' จำนวน ' .. ESX.Math.GroupDigits(count) .. ' เก็บเข้าคลัง'
TriggerEvent('azael_discordlogs:sendToDiscord', 'MechanicPutItem', sendToDiscord, xPlayer.source, '^2')

-- esx_mechanicjob\client\main.lua
#############################
####### [ เบิก-รถช่าง ] #######
#############################

local plate = GetVehicleNumberPlateText(vehicle)
local sendToDiscord = '' .. GetPlayerName(PlayerId()) .. ' เบิกรถ ทะเบียน ' .. plate .. ''
TriggerServerEvent('azael_discordlogs:sendToDiscord', 'MechanicCarSpawner', sendToDiscord, GetPlayerServerId(PlayerId()), '^2')

#############################
########### [ งัด-รถ ] ########
#############################

local plate = GetVehicleNumberPlateText(vehicle)
local sendToDiscord = '' .. GetPlayerName(PlayerId()) .. ' งัดรถ ทะเบียน ' .. plate .. ''
TriggerServerEvent('azael_discordlogs:sendToDiscord', 'MechanicHijack', sendToDiscord, GetPlayerServerId(PlayerId()), '^5')

#############################
########### [ ซ่อม-รถ ] ######
#############################

local plate = GetVehicleNumberPlateText(vehicle)
local sendToDiscord = '' .. GetPlayerName(PlayerId()) .. ' ซ่อมรถ ทะเบียน ' .. plate .. ''
TriggerServerEvent('azael_discordlogs:sendToDiscord', 'MechanicRepair', sendToDiscord, GetPlayerServerId(PlayerId()), '^5')

#############################
########### [ ล้าง-รถ ] ######
#############################

local plate = GetVehicleNumberPlateText(vehicle)
local sendToDiscord = '' .. GetPlayerName(PlayerId()) .. ' ล้างรถ ทะเบียน ' .. plate .. ''
TriggerServerEvent('azael_discordlogs:sendToDiscord', 'MechanicClean', sendToDiscord, GetPlayerServerId(PlayerId()), '^5')

#################################
########### [ เก็บรถ-สถานี ] ######
#################################

local plate = GetVehicleNumberPlateText(vehicle)
local sendToDiscord = '' .. GetPlayerName(PlayerId()) .. ' เก็บรถทะเบียน ' .. plate .. ''
TriggerServerEvent('azael_discordlogs:sendToDiscord', 'MechanicImpVeh', sendToDiscord, GetPlayerServerId(PlayerId()), '^3')

#############################################################################################################################################################################

-- fm_cabbage\server\main.lua
#################################
######### [ เก็บกระหล่ำปี ] ########
#################################

local randomItem = math.random(1,5)
		
xPlayer.addInventoryItem(xItem.name, randomxItem)

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. xItem.label .. ' จำนวน ' .. randomItem .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'WorkingAllJob', sendToDiscord, source, '^2')

#############################################################################################################################################################################

-- fm_Cherry\server\main.lua
#################################
######### [ เก็บเชอรรี่ ] ###########
#################################

local randomItem = math.random(1,5)
		
xPlayer.addInventoryItem(xItem.name, randomxItem)

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. xItem.label .. ' จำนวน ' .. randomItem .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'WorkingAllJob', sendToDiscord, source, '^2')

-- fm_Cherrypack\server.lua
##################################
######### [ แปรรูปเชอรรี่ ] ##########
##################################

local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. xMin.label .. ' จำนวน 3 ใช้ในการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'ProcessItem', sendToDiscord, _source, '^1')

Citizen.Wait(100)

local sendToDiscord2 = '' .. xPlayer.name .. ' ได้รับ ' .. xMax.label .. ' จำนวน 1 จากการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'ProcessItem', sendToDiscord2, _source, '^2')

#############################################################################################################################################################################

-- fm_egg\server\main.lua
#################################
######### [ เก็บไข่ไก่ ] ###########
#################################

local randomItem = math.random(1,5)
		
xPlayer.addInventoryItem(xItem.name, randomxItem)

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. xItem.label .. ' จำนวน ' .. randomItem .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'WorkingAllJob', sendToDiscord, source, '^2')

-- fm_egg\server\main.lua
###################################
######### [ แปรรูปไข่ไก่ ] ###########
###################################

local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. xMin.label .. ' จำนวน 3 ใช้ในการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'ProcessItem', sendToDiscord, _source, '^1')

Citizen.Wait(100)

local sendToDiscord2 = '' .. xPlayer.name .. ' ได้รับ ' .. xMax.label .. ' จำนวน 1 จากการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'ProcessItem', sendToDiscord2, _source, '^2')

#############################################################################################################################################################################

-- azkaban_banana\server\main.lua
#################################
######### [ เก็บกล้วย ] ###########
#################################

local randomItem = math.random(1,5)
		
xPlayer.addInventoryItem(xItem.name, randomxItem)

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. xItem.label .. ' จำนวน ' .. randomItem .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'WorkingAllJob', sendToDiscord, source, '^2')

-- azkaban_banana2\server.lua
###################################
######### [ แปรรูปกล้วย ] ###########
###################################

local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. xMin.label .. ' จำนวน 5 ใช้ในการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'ProcessItem', sendToDiscord, _source, '^1')

Citizen.Wait(100)

local sendToDiscord2 = '' .. xPlayer.name .. ' ได้รับ ' .. xMax.label .. ' จำนวน 1 จากการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'ProcessItem', sendToDiscord2, _source, '^2')

#############################################################################################################################################################################

-- azkaban_orange\server\main.lua
###############################
######### [ เก็บส้ม ] ###########
###############################

local randomItem = math.random(1,5)
		
xPlayer.addInventoryItem(xItem.name, randomxItem)

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. xItem.label .. ' จำนวน ' .. randomItem .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'WorkingAllJob', sendToDiscord, source, '^2')

-- azkaban_orange2\server.lua
##################################
######### [ แปรรูปส้ม ] ###########
##################################

local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. xMin.label .. ' จำนวน 5 ใช้ในการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'ProcessItem', sendToDiscord, _source, '^1')

Citizen.Wait(100)

local sendToDiscord2 = '' .. xPlayer.name .. ' ได้รับ ' .. xMax.label .. ' จำนวน 1 จากการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'ProcessItem', sendToDiscord2, _source, '^2')

#############################################################################################################################################################################

-- meeta_banana\server\server.lua
#############################
######### [ เก็บกล้วย ] #######
#############################

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. xItem.label .. ' จำนวน ' .. xItemCount .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobBanana', sendToDiscord, source, '^2')

-- Bonus

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ โบนัส ' .. ESX.GetItemLabel(v.ItemName) .. ' จำนวน ' .. v.ItemCount .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobBanana', sendToDiscord, source, '^9')

#############################################################################################################################################################################

-- meeta_mining\server\main.lua
###############################
######### [ ขุดเหมือง ] #########
###############################

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. xItem.label .. ' จำนวน ' .. xItemCount .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobMining', sendToDiscord, source, '^2')

-- Bonus

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ โบนัส ' .. ESX.GetItemLabel(v.ItemName) .. ' จำนวน ' .. v.ItemCount .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobMining', sendToDiscord, source, '^9')

#############################################################################################################################################################################

-- meeta_wood\server\main.lua
#############################
######### [ ตัดไม้ ] #########
#############################

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. xItem.label .. ' จำนวน ' .. xItemCount .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobWood', sendToDiscord, source, '^2')

-- Bonus

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ โบนัส ' .. ESX.GetItemLabel(v.ItemName) .. ' จำนวน ' .. v.ItemCount .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobWood', sendToDiscord, source, '^9')

#############################################################################################################################################################################

-- meeta_crab\server\main.lua
#############################
######### [ เก็บปู ] ##########
#############################

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. xItem.label .. ' จำนวน ' .. xItemCount .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobCrab', sendToDiscord, source, '^2')

-- Bonus

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. ESX.GetItemLabel(v.ItemName) .. ' จำนวน ' .. v.ItemCount .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobCrab', sendToDiscord, source, '^9')

#############################################################################################################################################################################

-- meeta_cook_corn\server\server.lua
#############################
####### [ เก็บข้าวโพด ] #######
#############################

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. xItem.label .. ' จำนวน ' .. xItemCount .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobCorn', sendToDiscord, source, '^2')

-- Bonus

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. ESX.GetItemLabel(v.ItemName) .. ' จำนวน ' .. v.ItemCount .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobCorn', sendToDiscord, source, '^9')

#############################################################################################################################################################################

-- loffe_fishing\server\server.lua
#############################
######### [ ตกปลา ] ########
#############################

-- broken_gun

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. ESX.GetItemLabel('broken_gun') .. ' จำนวน 1'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobLoffeFishing', sendToDiscord, _source, '^2')

-- snakeheadfish

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. ESX.GetItemLabel('snakeheadfish') .. ' จำนวน 1'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobLoffeFishing', sendToDiscord, _source, '^2')

-- catfish

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. ESX.GetItemLabel('catfish') .. ' จำนวน 1'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobLoffeFishing', sendToDiscord, _source, '^2')

###############################
######### [ แปรรูปปลา ] ########
###############################

-- loffe_fishing:processcat
-- loffe_fishing:processsnake
-- loffe_fishing:processriver

local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. xMin.label .. ' จำนวน 5 ใช้ในการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobLoffeFishingProcess', sendToDiscord, _source, '^1')

Citizen.Wait(100)

local sendToDiscord2 = '' .. xPlayer.name .. ' ได้รับ ' .. xMax.label .. ' จำนวน 1 จากการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobLoffeFishingProcess', sendToDiscord2, _source, '^2')

###############################
######### [ ขายปลา ] #########
###############################

local sendToDiscord = '' .. xPlayer.name .. ' ขาย ' .. ESX.GetItemLabel('lfish') .. ' จำนวน ' .. ESX.Math.GroupDigits(itemAmount) .. ' ได้รับ เงินสด จำนวน $' .. ESX.Math.GroupDigits(price) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobLoffeFishingSell', sendToDiscord, _source, '^2')

#############################################################################################################################################################################

-- esx_AdvancedFishing\server.lua
#############################
######### [ ตกปลา ] ########
#############################

-- fish2

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. ESX.GetItemLabel('fish2') .. ' จำนวน ' .. ESX.Math.GroupDigits(weight) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobFishing', sendToDiscord, _source, '^2')

-- turtle

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. ESX.GetItemLabel('turtle') .. ' จำนวน 1'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobFishing', sendToDiscord, _source, '^3')

-- shark

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. ESX.GetItemLabel('shark') .. ' จำนวน 1'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobFishing', sendToDiscord, _source, '^1')

###############################
######### [ ขายปลา ] #########
###############################

-- fish2

local sendToDiscord = '' .. xPlayer.name .. ' ขาย ' .. ESX.GetItemLabel('fish2') .. ' จำนวน 5 ได้รับ เงินสด จำนวน $' .. ESX.Math.GroupDigits(payment) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobFishingSelling', sendToDiscord, _source, '^2')

-- turtle

local sendToDiscord = '' .. xPlayer.name .. ' ขาย ' .. ESX.GetItemLabel('turtle') .. ' จำนวน 1 ได้รับ Dirty Money จำนวน $' .. ESX.Math.GroupDigits(payment) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobFishingSelling', sendToDiscord, _source, '^3')

-- shark

local sendToDiscord = '' .. xPlayer.name .. ' ขาย ' .. ESX.GetItemLabel('shark') .. ' จำนวน 1 ได้รับ Dirty Money จำนวน $' .. ESX.Math.GroupDigits(payment) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobFishingSelling', sendToDiscord, _source, '^1')

#############################################################################################################################################################################

-- caruby_farmer\server.lua
###############################
######### [ ขาย-ข้าว ] ##########
###############################

local sendToDiscord = '' .. xPlayer.name .. ' ขาย ' .. xItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(amount) .. ' ได้รับ เงินสด จำนวน $' .. ESX.Math.GroupDigits(price) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobFarmerSell', sendToDiscord, source, '^2')

#############################
######### [ เก็บ-ข้าว ] #######
#############################

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. xItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(rice) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobFarmer', sendToDiscord, source, '^2')

###############################
######### [ แปรรูป-ข้าว ] ########
###############################

local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. xMin.label .. ' จำนวน 5 ใช้ในการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobFarmerProcess', sendToDiscord, _source, '^1')

Citizen.Wait(100)

local sendToDiscord2 = '' .. xPlayer.name .. ' ได้รับ ' .. xMax.label .. ' จำนวน 1 จากการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobFarmerProcess', sendToDiscord2, _source, '^2')

#############################################################################################################################################################################

-- xD_farmer\server\main.lua
#############################
######### [ เก็บหญ้า ] ########
#############################

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. xItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(recv) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobFarmer', sendToDiscord, _source, '^2')

#############################################################################################################################################################################

-- Boiled\server.lua
####################################
######### [ แปรรูปข้าวโพด ] ##########
####################################

local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. xMin.label .. ' จำนวน 1 ใช้ในการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'ProcessItem', sendToDiscord, _source, '^1')

Citizen.Wait(100)

local sendToDiscord2 = '' .. xPlayer.name .. ' ได้รับ ' .. xMax.label .. ' จำนวน 1 จากการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'ProcessItem', sendToDiscord2, _source, '^2')

#############################################################################################################################################################################

-- esx_bottle\server\main.lua
###############################
######### [ ขายขวด ] ##########
###############################

-- bottle
local sendToDiscord = '' .. xPlayer.name .. ' ขาย ' .. ESX.GetItemLabel('bottle') .. ' จำนวน ' .. ESX.Math.GroupDigits(currentBottles) .. ' ได้รับ $' .. ESX.Math.GroupDigits(randomMoney * currentBottles) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobBottleSell', sendToDiscord, src, '^2')

-- plasticbag
local sendToDiscord = '' .. xPlayer.name .. ' ขาย ' .. ESX.GetItemLabel('plasticbag') .. ' จำนวน ' .. ESX.Math.GroupDigits(currentPlastic) .. ' ได้รับ $' .. ESX.Math.GroupDigits(randomMoney * currentPlastic) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobBottleSell', sendToDiscord, src, '^2')

###############################
######### [ เก็บขวด ] ##########
###############################

-- bottle

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. ESX.GetItemLabel('bottle') .. ' จำนวน ' .. ESX.Math.GroupDigits(randomBottle) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobBottle', sendToDiscord, src, '^7')

-- spring

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. ESX.GetItemLabel('spring') .. ' จำนวน 1'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobBottle', sendToDiscord, src, '^7')

-- plasticbag

local random = math.random(1, 3)
xPlayer.addInventoryItem('plasticbag', random)

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. ESX.GetItemLabel('plasticbag') .. ' จำนวน ' .. ESX.Math.GroupDigits(random) ..''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobBottle', sendToDiscord, src, '^7')

-- wetshit

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. ESX.GetItemLabel('wetshit') .. ' จำนวน 1'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobBottle', sendToDiscord, src, '^7')

#############################################################################################################################################################################

-- meeta_oil\server\server.lua
################################
######### [ ขุดน้ำมัน ] ##########
################################

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. xItem.label .. ' จำนวน ' .. xItemCount .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobOil', sendToDiscord, source, '^2')

#############################################################################################################################################################################

-- meeta_grave\server\server.lua
################################
######### [ ขุดกระดูก ] ##########
################################

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. xItem.label .. ' จำนวน ' .. xItemCount .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobGrave', sendToDiscord, source, '^2')

#############################################################################################################################################################################

-- meeta_treasure\server\server.lua
################################
######### [ ขุดสมบัติ ] ##########
################################

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. xItem.label .. ' จำนวน ' .. xItemCount .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobTreasure', sendToDiscord, source, '^2')

-- Bonus

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ โบนัส ' .. ESX.GetItemLabel(v.ItemName) .. ' จำนวน ' .. v.ItemCount .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobTreasure', sendToDiscord, source, '^9')

#############################################################################################################################################################################

-- meeta_uni\server\server.lua
################################
######### [ เก็บหอย ] ##########
################################

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. xItem.label .. ' จำนวน ' .. xItemCount .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobUni', sendToDiscord, source, '^2')

-- Bonus

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ โบนัส ' .. ESX.GetItemLabel(v.ItemName) .. ' จำนวน ' .. v.ItemCount .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobUni', sendToDiscord, source, '^9')

#############################################################################################################################################################################

-- meeta_leather\server\main.lua
################################
######### [ ฆ่า-วัว ] ############
################################

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. xItem.label .. ' จำนวน ' .. xItemCount .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobLeather', sendToDiscord, source, '^2')

#############################################################################################################################################################################

-- meeta_cook_pumpkin\server\server.lua
################################
######### [ เก็บฟักทอง ] ##########
################################

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. xItem.label .. ' จำนวน ' .. xItemCount .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobPumpkin', sendToDiscord, source, '^2')

-- Bonus

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ โบนัส ' .. ESX.GetItemLabel(v.ItemName) .. ' จำนวน ' .. v.ItemCount .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobPumpkin', sendToDiscord, source, '^9')

#############################################################################################################################################################################

-- meeta_cook_lettuce\server\server.lua
################################
######### [ เก็บกระหล่ำ ] ##########
################################

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. xItem.label .. ' จำนวน ' .. xItemCount .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobLettuce', sendToDiscord, source, '^2')

-- Bonus

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ โบนัส ' .. ESX.GetItemLabel(v.ItemName) .. ' จำนวน ' .. v.ItemCount .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobLettuce', sendToDiscord, source, '^9')

#############################################################################################################################################################################

-- finver_fishing\server\server.lua
################################
########### [ ตกปลา ] #########
################################

-- catfish

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. ESX.GetItemLabel('catfish') .. ' จำนวน ' .. ESX.Math.GroupDigits(numberOfFish) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobFinverFishing', sendToDiscord, _source, '^2')

-- snakeheadfish

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. ESX.GetItemLabel('snakeheadfish') .. ' จำนวน ' .. ESX.Math.GroupDigits(numberOfFish) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobFinverFishing', sendToDiscord, _source, '^2')

-- lfish

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. ESX.GetItemLabel('lfish') .. ' จำนวน ' .. ESX.Math.GroupDigits(numberOfFish) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobFinverFishing', sendToDiscord, _source, '^2')

################################
########### [ ขายปลา ] #########
################################

local sendToDiscord = '' .. xPlayer.name .. ' ขาย ' .. ESX.GetItemLabel('lfish') .. ' จำนวน ' .. ESX.Math.GroupDigits(itemAmount) .. ' ได้รับ เงินสด จำนวน $' .. ESX.Math.GroupDigits(price) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobFinverFishingSell', sendToDiscord, _source, '^2')

#############################################################################################################################################################################

-- xenoncements\server.lua
################################
########### [ ขโมยปูน ] #########
################################

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. ESX.GetItemLabel(Config.Itemname) .. ' จำนวน 1'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobCements', sendToDiscord, xPlayer.source, '^2')

################################
########### [ ขายปูน ] #########
################################

local sendToDiscord = '' .. xPlayer.name .. ' ขาย ' .. ESX.GetItemLabel('Cablewire') .. ' จำนวน ' .. ESX.Math.GroupDigits(currentWire) .. ' ได้รับ Dirty Money จำนวน $' .. ESX.Math.GroupDigits(randomMoney * currentWire) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobCementsSell', sendToDiscord, xPlayer.source, '^2')

#############################################################################################################################################################################

-- scotty-farm-cow\server.lua
##################################
########### [ รีด-นมวัว ] #########
##################################

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. ESX.GetItemLabel('milk_can') .. ' จำนวน ' .. ESX.Math.GroupDigits(am) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobCow', sendToDiscord, xPlayer.source, '^2')

##################################
########### [ แปรรูป-นมวัว ] #######
##################################

local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. ESX.GetItemLabel('milk_can') .. ' จำนวน 1 ใช้ในการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobCowProcess', sendToDiscord, xPlayer.source, '^1')

Citizen.Wait(100)

local sendToDiscord2 = '' .. xPlayer.name .. ' ได้รับ ' .. ESX.GetItemLabel('milk_bottle') .. ' จำนวน ' .. ESX.Math.GroupDigits(am) .. ' จากการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobCowProcess', sendToDiscord2, xPlayer.source, '^2')

#############################################################################################################################################################################

-- scotty-farm-pig\server.lua
##################################
########### [ ฆ่า-หมู ] ###########
##################################

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. ESX.GetItemLabel('pork') .. ' จำนวน ' .. ESX.Math.GroupDigits(am) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobPig', sendToDiscord, xPlayer.source, '^2')

##################################
########### [ แปรรูป-หมู ] ########
##################################

local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. ESX.GetItemLabel('pork') .. ' จำนวน 1 ใช้ในการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobPigProcess', sendToDiscord, xPlayer.source, '^1')

Citizen.Wait(100)

local sendToDiscord2 = '' .. xPlayer.name .. ' ได้รับ ' .. ESX.GetItemLabel(Config["pork_process_item"]) .. ' จำนวน ' .. ESX.Math.GroupDigits(am) .. ' จากการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobPigProcess', sendToDiscord2, xPlayer.source, '^2')

#############################################################################################################################################################################

-- scotty-timber\server.lua
##################################
########### [ ตัด-ไม้ ] ############
##################################

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. ESX.GetItemLabel('wood_log') .. ' จำนวน ' .. ESX.Math.GroupDigits(am) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobTimber', sendToDiscord, xPlayer.source, '^2')

##################################
########### [ แปรรูป-ไม้ ] ########
##################################

local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. ESX.GetItemLabel('wood_log') .. ' จำนวน 1 ใช้ในการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobTimberProcess', sendToDiscord, xPlayer.source, '^1')

Citizen.Wait(100)

local sendToDiscord2 = '' .. xPlayer.name .. ' ได้รับ ' .. ESX.GetItemLabel('wood_plank') .. ' จำนวน ' .. ESX.Math.GroupDigits(am) .. ' จากการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobTimberProcess', sendToDiscord2, xPlayer.source, '^2')

#############################################################################################################################################################################

-- caruby_chicken\server.lua
##################################
########### [ ฆ่า-ไก่ ] ############
##################################

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. xItem.label .. ' จำนวน 1'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobChicken', sendToDiscord, xPlayer.source, '^2')

##################################
########### [ แปรรูป-ไก่ ] #########
##################################

local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. xMin.label .. ' จำนวน 1 ใช้ในการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobChickenProcess', sendToDiscord, xPlayer.source, '^1')

Citizen.Wait(100)

local sendToDiscord2 = '' .. xPlayer.name .. ' ได้รับ ' .. xMax.label .. ' จำนวน 1 จากการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobChickenProcess', sendToDiscord2, xPlayer.source, '^2')

################################
########### [ ขาย-ไก่ ] #########
################################

local sendToDiscord = '' .. xPlayer.name .. ' ขาย ' .. xItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(amount) .. ' ได้รับ Money จำนวน $' .. ESX.Math.GroupDigits(price) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobChickenSell', sendToDiscord, xPlayer.source, '^2')

#############################################################################################################################################################################

-- caruby_mushroom\server.lua
##################################
########### [ เก็บ-เห็ด ] ###########
##################################

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. xItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(zItem) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobMushroom', sendToDiscord, xPlayer.source, '^2')

##################################
########### [ แปรรูป-เห็ด ] ########
##################################

local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. xMin.label .. ' จำนวน 1 ใช้ในการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobMushroomProcess', sendToDiscord, xPlayer.source, '^1')

Citizen.Wait(100)

local sendToDiscord2 = '' .. xPlayer.name .. ' ได้รับ ' .. xMax.label .. ' จำนวน 1 จากการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobMushroomProcess', sendToDiscord2, xPlayer.source, '^2')

################################
########### [ ขาย-เห็ด ] #########
################################

local sendToDiscord = '' .. xPlayer.name .. ' ขาย ' .. xItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(amount) .. ' ได้รับ Money จำนวน $' .. ESX.Math.GroupDigits(price) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobMushroomSell', sendToDiscord, xPlayer.source, '^2')

#############################################################################################################################################################################

-- caruby_orange\server.lua
##################################
########### [ เก็บ-ส้ม ] ###########
##################################

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. xItem.label .. ' จำนวน 1'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobOrange', sendToDiscord, xPlayer.source, '^2')

##################################
########### [ แปรรูป-ส้ม ] ########
##################################

local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. xMin.label .. ' จำนวน 1 ใช้ในการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobOrangeProcess', sendToDiscord, xPlayer.source, '^1')

Citizen.Wait(100)

local sendToDiscord2 = '' .. xPlayer.name .. ' ได้รับ ' .. xMax.label .. ' จำนวน 1 จากการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobOrangeProcess', sendToDiscord2, xPlayer.source, '^2')

################################
########### [ ขาย-ส้ม ] #########
################################

local sendToDiscord = '' .. xPlayer.name .. ' ขาย ' .. xItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(amount) .. ' ได้รับ Money จำนวน $' .. ESX.Math.GroupDigits(price) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobOrangeSell', sendToDiscord, xPlayer.source, '^2')

#############################################################################################################################################################################

--  caruby_sand\server.lua
##################################
########### [ เก็บ-ทราย ] #########
##################################

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. xItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(zItem) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobSand', sendToDiscord, xPlayer.source, '^2')

##################################
########### [ แปรรูป-ทราย ] #######
##################################

local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. xMin.label .. ' จำนวน 1 ใช้ในการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobSandProcess', sendToDiscord, xPlayer.source, '^1')

Citizen.Wait(100)

local sendToDiscord2 = '' .. xPlayer.name .. ' ได้รับ ' .. xMax.label .. ' จำนวน 1 จากการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobSandProcess', sendToDiscord2, xPlayer.source, '^2')

################################
########### [ ขาย-ทราย ] #######
################################

local sendToDiscord = '' .. xPlayer.name .. ' ขาย ' .. xItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(amount) .. ' ได้รับ Money จำนวน $' .. ESX.Math.GroupDigits(price) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobSandSell', sendToDiscord, xPlayer.source, '^2')

#############################################################################################################################################################################

--  caruby_shell\server.lua
##################################
########### [ เก็บ-หอย ] #########
##################################

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. xItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(zItem) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobShell', sendToDiscord, xPlayer.source, '^2')

##################################
########### [ แปรรูป-หอย ] #######
##################################

local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. xMin.label .. ' จำนวน 1 ใช้ในการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobShellProcess', sendToDiscord, xPlayer.source, '^1')

Citizen.Wait(100)

local sendToDiscord2 = '' .. xPlayer.name .. ' ได้รับ ' .. xMax.label .. ' จำนวน 1 จากการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobShellProcess', sendToDiscord2, xPlayer.source, '^2')

################################
########### [ ขาย-หอย] #######
################################

local sendToDiscord = '' .. xPlayer.name .. ' ขาย ' .. xItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(amount) .. ' ได้รับ Money จำนวน $' .. ESX.Math.GroupDigits(price) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobShellSell', sendToDiscord, xPlayer.source, '^2')

#############################################################################################################################################################################

--  caruby_weed\server.lua
##################################
########### [ เก็บ-กัญชา ] #########
##################################

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. xItem.label .. ' จำนวน 1'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobWeed', sendToDiscord, xPlayer.source, '^2')

##################################
########### [ แปรรูป-กัญชา ] #######
##################################

local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. xWeed.label .. ' จำนวน 2 ใช้ในการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobWeedProcess', sendToDiscord, xPlayer.source, '^1')

Citizen.Wait(100)

local sendToDiscord2 = '' .. xPlayer.name .. ' ได้รับ ' .. zWeed.label .. ' จำนวน 1 จากการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobWeedProcess', sendToDiscord2, xPlayer.source, '^2')

################################
########### [ ขาย-กัญชา] #######
################################

if Config.GiveBlack then
	local sendToDiscord = '' .. xPlayer.name .. ' ขาย ' .. xItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(amount) .. ' ได้รับ Dirty Money จำนวน $' .. ESX.Math.GroupDigits(price) .. ''
	TriggerEvent('azael_discordlogs:sendToDiscord', 'JobWeedSell', sendToDiscord, xPlayer.source, '^3')
else
	local sendToDiscord = '' .. xPlayer.name .. ' ขาย ' .. xItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(amount) .. ' ได้รับ  Money จำนวน $' .. ESX.Math.GroupDigits(price) .. ''
	TriggerEvent('azael_discordlogs:sendToDiscord', 'JobWeedSell', sendToDiscord, xPlayer.source, '^2')
end

#############################################################################################################################################################################

--  caruby_wood\server.lua
##################################
########### [ ตัด-ไม้ ] ###########
##################################

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. xItem.label .. ' จำนวน 1'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobWood', sendToDiscord, xPlayer.source, '^2')

##################################
########### [ แปรรูป-ไม้ ] #######
##################################

local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. xMin.label .. ' จำนวน 3 ใช้ในการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobWoodProcess', sendToDiscord, xPlayer.source, '^1')

Citizen.Wait(100)

local sendToDiscord2 = '' .. xPlayer.name .. ' ได้รับ ' .. xMax.label .. ' จำนวน 1 จากการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobWoodProcess', sendToDiscord2, xPlayer.source, '^2')

################################
########### [ ขาย-ไม้ ] #######
################################

local sendToDiscord = '' .. xPlayer.name .. ' ขาย ' .. xItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(amount) .. ' ได้รับ Money จำนวน $' .. ESX.Math.GroupDigits(price) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobWoodSell', sendToDiscord, xPlayer.source, '^2')

#############################################################################################################################################################################

--  punyapat_banana\server.lua
##################################
########### [ เก็บ-กล้วย ] #########
##################################

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. xItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(a_banana) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobBanana', sendToDiscord, xPlayer.source, '^2')

##################################
########### [ แปรรูป-กล้วย ] #######
##################################

local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. xMin.label .. ' จำนวน 1 ใช้ในการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobBananaProcess', sendToDiscord, xPlayer.source, '^1')

Citizen.Wait(100)

local sendToDiscord2 = '' .. xPlayer.name .. ' ได้รับ ' .. xMax.label .. ' จำนวน 1 จากการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobBananaProcess', sendToDiscord2, xPlayer.source, '^2')

#############################################################################################################################################################################

--  punyapat_crab\server.lua
##################################
########### [ เก็บ-ปู ] ############
##################################

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. xItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(a_crab) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobCrab', sendToDiscord, xPlayer.source, '^2')

##################################
########### [ แปรรูป-ปู ] ##########
##################################

local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. xMin.label .. ' จำนวน 1 ใช้ในการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobCrabProcess', sendToDiscord, xPlayer.source, '^1')

Citizen.Wait(100)

local sendToDiscord2 = '' .. xPlayer.name .. ' ได้รับ ' .. xMax.label .. ' จำนวน 1 จากการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobCrabProcess', sendToDiscord2, xPlayer.source, '^2')

#############################################################################################################################################################################

--  punyapat_oil\server.lua
##################################
########### [ ขุด-น้ำมัน ] #########
##################################

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. xItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(a_oil) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobOil', sendToDiscord, xPlayer.source, '^2')

##################################
########### [ แปรรูป-น้ำมัน ] #######
##################################

local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. xMin.label .. ' จำนวน 1 ใช้ในการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobOilProcess', sendToDiscord, xPlayer.source, '^1')

Citizen.Wait(100)

local sendToDiscord2 = '' .. xPlayer.name .. ' ได้รับ ' .. xMax.label .. ' จำนวน 1 จากการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobOilProcess', sendToDiscord2, xPlayer.source, '^2')

#############################################################################################################################################################################

-- loffe_robbery\server.lua
##################################
########### [ ปล้น-ร้านค้า ] ########
##################################

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ เงินสด จากการปล้น จำนวน $' .. ESX.Math.GroupDigits(randomAmount) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'LoffeRobbery', sendToDiscord, xPlayer.source, '^2')

#############################################################################################################################################################################

-- DiamondBlackjack\sv_blackjack.lua
##################################
########### [ เล่น-แบล็กแจ็ก ] ######
##################################

-- ค้นหา function tryTakeChips(source,amount)

local sendToDiscord = '' .. xPlayer.name .. ' ลงเดิมพัน $' .. ESX.Math.GroupDigits(amount) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'BlackJack', sendToDiscord, xPlayer.source, '^3')

-- ค้นหา TriggerClientEvent("blackjack:notify",source,"~r~-"..tostring(lostAmount).." chips") เเละ วางรหัสด้านล่างนี้ ไว้ข้างล่าง

local sendToDiscord = '' .. GetPlayerName(source) .. ' แพ้ และ เสีย $' .. tostring(lostAmount) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'BlackJack', sendToDiscord, source, '^1')

-- ค้นหา TriggerClientEvent("blackjack:notify",source,"~g~+"..tostring(potentialWinAmount).." chips") เเละ วางรหัสด้านล่างนี้ ไว้ข้างล่าง

local sendToDiscord = '' .. GetPlayerName(source) .. ' ชนะ และ ได้รับ $' .. tostring(potentialWinAmount) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'BlackJack', sendToDiscord, source, '^2')

-- ค้นหา TriggerClientEvent("blackjack:notify",source,"~g~+"..tostring(potentialWinAmount).." chips") เเละ วางรหัสด้านล่างนี้ ไว้ข้างล่าง

local sendToDiscord = '' .. GetPlayerName(source) .. ' ชนะ และ ได้รับ $' .. tostring(potentialWinAmount) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'BlackJack', sendToDiscord, source, '^2')

-- ค้นหา TriggerClientEvent("blackjack:notify",source,"~r~-"..tostring(potentialPushAmount).." chips") เเละ วางรหัสด้านล่างนี้ ไว้ข้างล่าง

local sendToDiscord = '' .. GetPlayerName(source) .. ' แพ้ และ เสีย $' .. tostring(potentialPushAmount) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'BlackJack', sendToDiscord, source, '^1')

#############################################################################################################################################################################

-- esx_thief\server\main.lua
#################################
########### [ ปล้น-ไอเทม ] #######
#################################

local sendToDiscord = '' .. sourceXPlayer.name .. ' ปล้น ' .. targetXPlayer.name .. ' ได้รับ ' .. sourceItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(amount) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'StealItem', sendToDiscord, sourceXPlayer.source, '^2')

Citizen.Wait(100)

local sendToDiscord2 = '' .. targetXPlayer.name .. ' ถูก ' .. sourceXPlayer.name .. ' ปล้น ' .. sourceItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(amount) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'StealItem', sendToDiscord2, targetXPlayer.source, '^3')

#################################
########### [ ปล้น-เงินเขียว ] #####
#################################

local sendToDiscord = '' .. sourceXPlayer.name .. ' ปล้น ' .. targetXPlayer.name .. ' ได้รับ เงินสด จำนวน $' .. ESX.Math.GroupDigits(amount) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'StealMoney', sendToDiscord, sourceXPlayer.source, '^2')

Citizen.Wait(100)

local sendToDiscord2 = '' .. targetXPlayer.name .. ' ถูก ' .. sourceXPlayer.name .. ' ปล้น เงินสด จำนวน $' .. ESX.Math.GroupDigits(amount) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'StealMoney', sendToDiscord2, targetXPlayer.source, '^3')

#################################
########### [ ปล้น-เงินแดง ] #####
#################################

local sendToDiscord = '' .. sourceXPlayer.name .. ' ปล้น ' .. targetXPlayer.name .. ' ได้รับ Dirty Money จำนวน $' .. ESX.Math.GroupDigits(amount) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'StealDirtyMoney', sendToDiscord, sourceXPlayer.source, '^2')

Citizen.Wait(100)

local sendToDiscord2 = '' .. targetXPlayer.name .. ' ถูก ' .. sourceXPlayer.name .. ' ปล้น Dirty Money จำนวน $' .. ESX.Math.GroupDigits(amount) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'StealDirtyMoney', sendToDiscord2, targetXPlayer.source, '^3')

#################################
########### [ ปล้น-อาวุธ ] ########
#################################

if amount > 0 then
	local sendToDiscord = '' .. sourceXPlayer.name .. ' ปล้น ' .. targetXPlayer.name .. ' ได้รับ ' .. ESX.GetWeaponLabel(itemName) .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(amount) .. ''
	TriggerEvent('azael_discordlogs:sendToDiscord', 'StealWeapon', sendToDiscord, sourceXPlayer.source, '^2')

	Citizen.Wait(100)

	local sendToDiscord2 = '' .. targetXPlayer.name .. ' ถูก ' .. sourceXPlayer.name .. ' ปล้น ' .. ESX.GetWeaponLabel(itemName) .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(amount) .. ''
	TriggerEvent('azael_discordlogs:sendToDiscord', 'StealWeapon', sendToDiscord2, targetXPlayer.source, '^3')
else
	local sendToDiscord = '' .. sourceXPlayer.name .. ' ปล้น ' .. targetXPlayer.name .. ' ได้รับ ' .. ESX.GetWeaponLabel(itemName) .. ''
	TriggerEvent('azael_discordlogs:sendToDiscord', 'StealWeapon', sendToDiscord, sourceXPlayer.source, '^2')

	Citizen.Wait(100)

	local sendToDiscord2 = '' .. targetXPlayer.name .. ' ถูก ' .. sourceXPlayer.name .. ' ปล้น ' .. ESX.GetWeaponLabel(itemName) .. ''
	TriggerEvent('azael_discordlogs:sendToDiscord', 'StealWeapon', sendToDiscord2, targetXPlayer.source, '^3')
end

#############################################################################################################################################################################

-- esx_weed\server\main.lua
################################
########### [ ขาย-กัญชา ] #######
################################

if Config.GiveBlack then
	local sendToDiscord = '' .. xPlayer.name .. ' ขาย ' .. xItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(amount) .. ' ได้รับ Dirty Money จำนวน $' .. ESX.Math.GroupDigits(price) .. ''
	TriggerEvent('azael_discordlogs:sendToDiscord', 'JobWeedSell', sendToDiscord, xPlayer.source, '^3')
else
	local sendToDiscord = '' .. xPlayer.name .. ' ขาย ' .. xItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(amount) .. ' ได้รับ  Money จำนวน $' .. ESX.Math.GroupDigits(price) .. ''
	TriggerEvent('azael_discordlogs:sendToDiscord', 'JobWeedSell', sendToDiscord, xPlayer.source, '^2')
end

##################################
########### [ เก็บ-กัญชา ] #########
##################################

local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. xItem.label .. ' จำนวน 1'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobWeed', sendToDiscord, xPlayer.source, '^2')

##################################
########### [ แปรรูป-กัญชา ] #######
##################################

local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. xWeed.label .. ' จำนวน 2 ใช้ในการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobWeedProcess', sendToDiscord, xPlayer.source, '^1')

Citizen.Wait(100)

local sendToDiscord2 = '' .. xPlayer.name .. ' ได้รับ ' .. zWeed.label .. ' จำนวน 1 จากการแปรรูป'
TriggerEvent('azael_discordlogs:sendToDiscord', 'JobWeedProcess', sendToDiscord2, xPlayer.source, '^2')

#############################################################################################################################################################################

-- caruby_market\server.lua
################################
########### [ ตลาดโลก ] #######
################################

-- Sell-Item
local sendToDiscord = '' .. xPlayer.name .. ' ขาย ' .. sourceItem.label .. ' จำนวน ' .. amount .. ' ราคา $' .. ESX.Math.GroupDigits(price) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'GlobalMarket', sendToDiscord, xPlayer.source, '^2')

-- Sell-Weapon
local sendToDiscord = '' .. xPlayer.name .. ' ขาย ' .. item.label .. ' และ กระสุน จำนวน ' .. ammo .. ' ราคา $' .. ESX.Math.GroupDigits(price) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'GlobalMarket', sendToDiscord, xPlayer.source, '^2')

-- # Money

-- Buy-Item
local sendToDiscord = '' .. xPlayer.name .. ' ซื้อ ' .. sourceItem.label .. ' จำนวน ' .. amount .. ' ราคา $' .. ESX.Math.GroupDigits(price) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'GlobalMarket', sendToDiscord, xPlayer.source, '^3')

-- Buy-Weapon
local sendToDiscord = '' .. xPlayer.name .. ' ซื้อ ' .. itemLabel .. ' และ กระสุน จำนวน ' .. ammo .. ' ราคา $' .. ESX.Math.GroupDigits(price) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'GlobalMarket', sendToDiscord, xPlayer.source, '^3')

-- # Black Money

-- Buy-Item
local sendToDiscord = '' .. xPlayer.name .. ' ซื้อ ' .. sourceItem.label .. ' จำนวน ' .. amount .. ' ราคา $' .. ESX.Math.GroupDigits(price) .. ' (เงินเเดง)'
TriggerEvent('azael_discordlogs:sendToDiscord', 'GlobalMarket', sendToDiscord, xPlayer.source, '^3')

-- Buy-Weapon
local sendToDiscord = '' .. xPlayer.name .. ' ซื้อ ' .. itemLabel .. ' และ กระสุน จำนวน ' .. ammo .. ' ราคา $' .. ESX.Math.GroupDigits(price) .. ' (เงินเเดง)'
TriggerEvent('azael_discordlogs:sendToDiscord', 'GlobalMarket', sendToDiscord, xPlayer.source, '^3')

-- Sell-Item-Cancel
local sendToDiscord = '' .. xPlayer.name .. ' ยกเลิก ขาย ' .. sourceItem.label .. ' จำนวน ' .. amount .. ' ราคา $' .. ESX.Math.GroupDigits(price) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'GlobalMarket', sendToDiscord, xPlayer.source, '^1')

-- Sell-Weapon-Cancel
local sendToDiscord = '' .. xPlayer.name .. ' ยกเลิก ขาย ' .. itemLabel .. ' และ กระสุน จำนวน ' .. ammo .. ' ราคา $' .. ESX.Math.GroupDigits(price) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'GlobalMarket', sendToDiscord, xPlayer.source, '^2')

#############################################################################################################################################################################

-- w1ms_worldshop\server\main.lua
#################################
########### [ ฝากขาย ] #########
#################################

if data.type == 1 then
	local sendToDiscord = '' .. xPlayer.name .. ' ฝากขาย ' .. data.label .. ' จำนวน ' .. ESX.Math.GroupDigits(data.amount) .. ' ราคา $' .. ESX.Math.GroupDigits(data.price) .. ' (Money)'
	TriggerEvent('azael_discordlogs:sendToDiscord', 'WorldShopDeposited', sendToDiscord, xPlayer.source, '^2')
else
	local sendToDiscord = '' .. xPlayer.name .. ' ฝากขาย ' .. data.label .. ' จำนวน ' .. ESX.Math.GroupDigits(data.amount) .. ' ราคา $' .. ESX.Math.GroupDigits(data.price) .. ' (Dirty Money)'
	TriggerEvent('azael_discordlogs:sendToDiscord', 'WorldShopDeposited', sendToDiscord, xPlayer.source, '^3')
end

################################
########### [ เรียกคืน ] ##########
#################################

local sendToDiscord = '' .. xPlayer.name .. ' เรียกคืน ' .. label .. ' จำนวน ' .. ESX.Math.GroupDigits(amount) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'WorldShopRestore', sendToDiscord, xPlayer.source, '^7')

#################################
########### [ รับเงิน ] ###########
#################################

if pay_type == 1 then
	local sendToDiscord = '' .. xPlayer.name .. ' รับ Money จำนวน $' .. ESX.Math.GroupDigits(price) .. ''
	TriggerEvent('azael_discordlogs:sendToDiscord', 'WorldShopClaim', sendToDiscord, xPlayer.source, '^2')
else
	local sendToDiscord = '' .. xPlayer.name .. ' รับ Dirty Money จำนวน $' .. ESX.Math.GroupDigits(price) .. ''
	TriggerEvent('azael_discordlogs:sendToDiscord', 'WorldShopClaim', sendToDiscord, xPlayer.source, '^3')
end

#################################
########### [ ซื้อ ] ##############
#################################

if paytype == 1 then
	local sendToDiscord = '' .. xPlayer.name .. ' ซื้อ ' .. label .. ' จำนวน ' .. ESX.Math.GroupDigits(amount) .. ' ราคา $' .. ESX.Math.GroupDigits(price) .. ' (Money)'
	TriggerEvent('azael_discordlogs:sendToDiscord', 'WorldShopBuy', sendToDiscord, xPlayer.source, '^2')
else
	local sendToDiscord = '' .. xPlayer.name .. ' ฝากขาย ' .. label .. ' จำนวน ' .. ESX.Math.GroupDigits(amount) .. ' ราคา $' .. ESX.Math.GroupDigits(price) .. ' (Dirty Money)'
	TriggerEvent('azael_discordlogs:sendToDiscord', 'WorldShopBuy', sendToDiscord, xPlayer.source, '^3')
end

#############################################################################################################################################################################

-- esx_qalle-sellvehicles\server\main.lua
######################################
########### [ ขาย-รถมือสอง ] ##########
######################################

local sendToDiscord = '' .. xPlayer.name .. ' ขาย ยานพาหนะ ทะเบียน ' .. plate .. ' ราคา $' .. ESX.Math.GroupDigits(price) .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'UsedCarSell', sendToDiscord, xPlayer.source, '^3')

######################################
########### [ ซื้อ-รถมือสอง ] ##########
######################################

local sendToDiscord = '' .. xPlayer.name .. ' ซื้อ ยานพาหนะ ทะเบียน ' .. plate .. ' ราคา $' .. ESX.Math.GroupDigits(price) .. ' (เงินธนาคาร)'
TriggerEvent('azael_discordlogs:sendToDiscord', 'UsedCarBuy', sendToDiscord, xPlayer.source, '^2')

#############################################################################################################################################################################

-- esx_boatshop\client\main.lua
##################################
######### [ ซื้อเรือ-จากร้าน ] #######
##################################

local sendToDiscord = '' .. GetPlayerName(PlayerId()) .. ' ซื้อเรือ ' .. vehicleData.model .. ' ทะเบียน ' .. vehicleProps.plate .. ' ราคา $' .. ESX.Math.GroupDigits(vehicleData.price) ..''
TriggerServerEvent('azael_discordlogs:sendToDiscord', 'BuyBoat', sendToDiscord, GetPlayerServerId(PlayerId()), '^2')

#################################
######## [ ขายเรือ-คืนร้าน ] #######
#################################

local sendToDiscord = '' .. GetPlayerName(PlayerId()) .. ' ขายเรือ ' .. CurrentActionData.label .. ' ทะเบียน ' .. CurrentActionData.plate .. ' ราคา $' .. ESX.Math.GroupDigits(CurrentActionData.price) .. ''
TriggerServerEvent('azael_discordlogs:sendToDiscord', 'ResellBoat', sendToDiscord, GetPlayerServerId(PlayerId()), '^3')

#############################################################################################################################################################################

-- esx_boat\client\main.lua
##################################
######### [ ซื้อเรือ-จากร้าน ] #######
##################################

local sendToDiscord = '' .. GetPlayerName(PlayerId()) .. ' ซื้อเรือ ' .. data.current.name .. ' ทะเบียน ' .. plate .. ' ราคา $' .. ESX.Math.GroupDigits(data.current.price) ..''
TriggerServerEvent('azael_discordlogs:sendToDiscord', 'BuyEsxBoat', sendToDiscord, GetPlayerServerId(PlayerId()), '^2')

#############################################################################################################################################################################

-- esx_accessories\server\main.lua
##################################
####### [ ร้าน-เครื่องประดับ ] ########
##################################

local sendToDiscord = '' .. xPlayer.name .. ' เสียค่าใช้จ่าย $' .. ESX.Math.GroupDigits(Config.Price) .. ' ให้ ร้านเครื่องประดับ'
TriggerEvent('azael_discordlogs:sendToDiscord', 'AccessoriesShop', sendToDiscord, xPlayer.source, '^3')

#############################################################################################################################################################################

-- esx_barbershop\server\main.lua
##################################
######### [ ร้าน-ตัดผม ] ##########
##################################

local sendToDiscord = '' .. xPlayer.name .. ' เสียค่าใช้จ่าย $' .. ESX.Math.GroupDigits(Config.Price) .. ' ให้ ร้านตัดผม'
TriggerEvent('azael_discordlogs:sendToDiscord', 'BarberShop', sendToDiscord, xPlayer.source, '^3')

#############################################################################################################################################################################

-- esx_clotheshop\server\main.lua
##################################
######### [ ร้าน-เสื้อผ้า ] ##########
##################################

local sendToDiscord = '' .. xPlayer.name .. ' เสียค่าใช้จ่าย $' .. ESX.Math.GroupDigits(Config.Price) .. ' ให้ ร้านเสื้อผ้า'
TriggerEvent('azael_discordlogs:sendToDiscord', 'ClotheShop', sendToDiscord, xPlayer.source, '^3')

#############################################################################################################################################################################

-- esx_tattooshop\server\main.lua
##################################
######### [ ร้าน-สัก ] ############
##################################

local sendToDiscord = '' .. xPlayer.name .. ' เสียค่าใช้จ่าย $' .. ESX.Math.GroupDigits(price) .. ' ให้ ร้านสัก'
TriggerEvent('azael_discordlogs:sendToDiscord', 'TattooShop', sendToDiscord, xPlayer.source, '^3')

#############################################################################################################################################################################

-- esx_duty\server\main.lua
########################################
######### [ หน่วนงาน-เข้าออกเวร ] #########
#########################################

if xPlayer.job.name == 'police' or xPlayer.job.name == 'ambulance' or xPlayer.job.name == 'mechanic' then
	local sendToDiscord = '' .. xPlayer.name .. ' หน่วยงาน ' .. xPlayer.job.name .. ' ออกเวร'
	TriggerEvent('azael_discordlogs:sendToDiscord', 'JobDuty', sendToDiscord, xPlayer.source, '^3')
elseif xPlayer.job.name == 'offpolice' or xPlayer.job.name == 'offambulance' or xPlayer.job.name == 'offmechanic' then
	local sendToDiscord = '' .. xPlayer.name .. ' หน่วยงาน ' .. string.gsub(xPlayer.job.name, 'off', '') .. ' เข้าเวร'
	TriggerEvent('azael_discordlogs:sendToDiscord', 'JobDuty', sendToDiscord, xPlayer.source, '^2')
end

#############################################################################################################################################################################

-- esx_outlawalert\server\main.lua
##################################
######### [ ขโมยรถ ] ############
##################################

local sendToDiscord = '' .. GetPlayerName(source) .. ' ขโมย ' .. vehicleLabel .. ' บริเวณ ' .. streetName .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'AlertCarJack', sendToDiscord, source, '^3')

##############################
######### [ ต่อสู้ ] ############
##############################

local sendToDiscord = '' .. GetPlayerName(source) .. ' ต่อสู้ บริเวณ ' .. streetName .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'AlertCombat', sendToDiscord, source, '^3')

##############################
######### [ ใช้อาวุธปืน ] #######
##############################

local sendToDiscord = '' .. GetPlayerName(source) .. ' ใช้อาวุธปืน บริเวณ ' .. streetName .. ''
TriggerEvent('azael_discordlogs:sendToDiscord', 'AlertGunShot', sendToDiscord, source, '^3')

#############################################################################################################################################################################
