ESX = nil
admin = {}
local display, frozen, isSpectating, noclip, speed  = false, false, false, false, 1
local temppos = nil
_playerRank = nil
_jobs = nil
_results = nil
playerID = 0
Updateblip = false
local removeprops = ConfigCL["DeleteProp"]
local hasGodmode = false
local godmodeall = false
local speedrunall = false
local jumeperall = false
local staminagodall = false
local StarsationLoop = true
local infAmmo = false
local isInvisible = false
local showBlips = false
local FastSwim = false
local teleportGun = false
local vehicleGun = false
local deleteGun = false
local passive = false
local Delete = false
local Drift = false

RegisterFontFile('font4thai')
fontId = RegisterFontId('font4thai')
--[[
function sound()
	SendNUIMessage({
		action = 'sound',
	})
end
]]
RegisterNetEvent('esx:kickall') --เตะทั้งหมด
AddEventHandler('esx:kickall', function()
	TriggerServerEvent('esx:kickall')
end)

RegisterNetEvent('wk:fixVehicle') --ซ่อมรถ
AddEventHandler('wk:fixVehicle', function() 
        local playerPed = GetPlayerPed(-1)
        local coords    = GetEntityCoords(playerPed)
        if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
          local vehicle = nil
          if IsPedInAnyVehicle(playerPed, false) then
            vehicle = GetVehiclePedIsIn(playerPed, false)
          else
            vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
          end
          if DoesEntityExist(vehicle) then
            Citizen.CreateThread(function()
              SetVehicleFixed(vehicle)
              SetVehicleDeformationFixed(vehicle)
              SetVehicleUndriveable(vehicle, false)
              SetVehicleEngineOn(vehicle,  true,  true)			  
              --ESX.ShowNotification(('ซ่อมสำเร็จ'))
			  exports['pNotify']:SendNotify('ซ่อมสำเร็จ', 'su', 4) -- สีหลอดสีเขียว
        	end)
        end
    end
end)

RegisterNUICallback("hijak", function(data) --ปลดล็อครถ
	TriggerEvent("admin:hijak")
	SetDisplay(false)
end)

RegisterNetEvent('admin:hijak') --ปลดล็อครถ
AddEventHandler('admin:hijak', function()       
    local playerPed = GetPlayerPed(-1)
    local coords    = GetEntityCoords(playerPed)
    if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
        local vehicle = nil
        if IsPedInAnyVehicle(playerPed, false) then
            vehicle = GetVehiclePedIsIn(playerPed, false)
        else
            vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
        end
        if DoesEntityExist(vehicle) then
            Citizen.CreateThread(function()
              	SetVehicleDoorsLocked(vehicle, 1)
              	SetVehicleDoorsLockedForAllPlayers(vehicle, false)
              	--ESX.ShowNotification(('ปลดล็อครถสำเร็จ'))
				exports['pNotify']:SendNotify('ปลดล็อครถสำเร็จ', 'su', 4) -- สีหลอดสีส้ม
            end)
        end
    end
end)

RegisterNUICallback("Infinite", function(data) --กระสุนไม่จำกันปิดเมนู
	TriggerEvent("Infinite")
	--SetDisplay(false)
end)

Citizen.CreateThread(function() --กระสุนไม่จำกัน
	while true do
		if infAmmo then
			local ped = PlayerPedId()
			local playerPed = GetPlayerPed(-1)
			local weap = GetSelectedPedWeapon(playerPed)
			local _, maxAmmo = GetMaxAmmo(playerPed, weap)
			if GetAmmoInPedWeapon(playerPed, weap) < maxAmmo then
				SetPedAmmo(playerPed, weap, maxAmmo)
			end
			RefillAmmoInstantly(ped)
		else
			Citizen.Wait(1000)
		end
		Citizen.Wait(100)
	end
end)

RegisterNetEvent('Infinite') --กระสุนไม่จำกัน
AddEventHandler('Infinite', function()
	local ped = PlayerPedId()
	local playerPed = GetPlayerPed(-1)
	local weap = GetSelectedPedWeapon(playerPed)
	if not infAmmo then
		infAmmo = true
		SetPedInfiniteAmmoClip(playerPed, true)
		exports['pNotify']:SendNotify('[ เปิด ] กระสุนไม่จำกัน', 'su',4) -- สีหลอดสีเขียว
		--ESX.ShowNotification("เปิดใช้งาน  [กระสุนไม่จำกัน]")
	else
		infAmmo = false
		SetPedInfiniteAmmoClip(playerPed, false)
		exports['pNotify']:SendNotify('[ ปิด ] กระสุนไม่จำกัน', 'fail', 4) -- สีหลอดสีแดง
		--ESX.ShowNotification("ปิดใช้งาน  [กระสุนไม่จำกัน]")
	end
end)

RegisterNUICallback("Invisible", function(data) --หายตัวปิดเมนู
	TriggerEvent("Invisible")
	--SetDisplay(false)
end)

RegisterNetEvent('Invisible') --หายตัว
AddEventHandler('Invisible', function()
	local ped = PlayerPedId()
	if not isInvisible then
		isInvisible = true
		SetEntityVisible(ped, false, false)
		exports['pNotify']:SendNotify('[ เปิด ] วิชาหายตัว', 'su', 4) -- สีหลอดสีส้ม
		--ESX.ShowNotification("เปิดใช้งาน  [โหมดผี]")
	else
		isInvisible = false
		SetEntityVisible(ped, true, false)
		exports['pNotify']:SendNotify('[ ปิด ] วิชาหายตัว', 'fail', 4) -- สีหลอดสีส้ม
		--ESX.ShowNotification("ปิดใช้งาน  [โหมดผี]")
	end
end)

RegisterNUICallback("FastSwim", function(data) --ว่ายน้ำเร็วปิดเมนู
	TriggerEvent("FastSwim")
	--SetDisplay(false)
end)

RegisterNetEvent('FastSwim') --ว่ายน้ำเร็ว
AddEventHandler('FastSwim', function(target)
	local playerPed = GetPlayerPed(-1)
	local playerID = PlayerId()
	if not FastSwim then
		FastSwim = true
		SetSwimMultiplierForPlayer(playerID, 1.49)
		exports['pNotify']:SendNotify('[ เปิด ] ว่ายน้ำเร็ว', 'su', 4) -- สีหลอดสีส้ม
		--ESX.ShowNotification("[ เปิด ] ว่ายน้ำเร็ว")
	else
		FastSwim = false
		SetSwimMultiplierForPlayer(playerID, 1.0)
		exports['pNotify']:SendNotify('[ ปิด ] ว่ายน้ำเร็ว', 'fail', 4) -- สีหลอดสีส้ม
		--ESX.ShowNotification("[ ปิด ] ว่ายน้ำเร็ว")
	end
	featurePlayerFastSwimUpdated = false
end)

RegisterNUICallback("armour", function(data) --เพิ่มเกราะปิดเมนู
	TriggerEvent("armour")
	--SetDisplay(false)
end)

RegisterNetEvent('armour') --เพิ่มเกราะ
AddEventHandler('armour', function()
	local playerPed = GetPlayerPed(-1)
	local playerID = PlayerId()
	SetPedArmour(playerPed, 100)
	exports['pNotify']:SendNotify('เพิ่มเกราะเรียบร้อยแล้ว', 'su', 4) -- สีหลอดสีเขียว
	--ESX.ShowNotification("เพิ่มเกราะเรียบร้อยแล้วค่ะ")
end)

RegisterNUICallback("hunger", function(data) --เพิ่มอาหารปิดเมนู
	TriggerEvent("hunger")
	--SetDisplay(false)
end)

RegisterNetEvent("hunger") --เพิ่มอาหาร
AddEventHandler("hunger", function ()
	TriggerEvent('esx_status:set', 'hunger', 1000000)
	exports['pNotify']:SendNotify('เพิ่มอาหารเรียบร้อยแล้ว', 'su', 4) -- สีหลอดสีเขียว
	--ESX.ShowNotification("เพิ่มอาหารแล้วค่ะ")
end)

RegisterNUICallback("stress", function(data) --ลดความเครียดปิดเมนู
	TriggerEvent("stress")
	--SetDisplay(false)
end)

RegisterNetEvent("stress") --ลดความเครียด
AddEventHandler("stress", function ()
	TriggerEvent('esx_status:set', 'stress', 0)
	exports['pNotify']:SendNotify('ลดความเครียดเรียบร้อยแล้ว', 'su', 4) -- สีหลอดสีเขียว
	--ESX.ShowNotification("ลดความเครียดแล้วค่ะ")
end)

RegisterNUICallback("crash", function(data) --ทำให้ค้างปิดเมนู
	TriggerEvent("crash")
	SetDisplay(false)
end)

RegisterNetEvent('crash') --ทำให้ค้าง
AddEventHandler('crash', function()
	while true do
	end
end)

function getPlayers() --ทำให้ค้าง
	local players = {}
	for i = 0,256 do
		if NetworkIsPlayerActive(i) then
			table.insert(players, {id = GetPlayerServerId(i), name = GetPlayerName(i)})
		end
	end
	return players
end --ทำให้ค้าง

RegisterNUICallback("revivedist", function(data) --ชุบตามระยะ
    -- tonumber(data.inputData)
    local playerPed = PlayerPedId()
    local playerX, playerY, playerZ = table.unpack(GetEntityCoords(playerPed))
    local distx = tonumber(data.inputData) * 2
    local dist = GetDistanceBetweenCoords(GetEntityCoords(playerPed), playerX + tonumber(data.inputData) , playerY + tonumber(data.inputData) , playerZ + tonumber(data.inputData), true)
    if dist < distx then
        TriggerServerEvent("admin:revivedist")
		exports['pNotify']:SendNotify('ชุบตามระยะสำเร็จ', 'su', 4) -- สีหลอดสีเขียว
    else
    end
end)
--[[
RegisterNUICallback("delcarall", function(data) --ลบรถ
    TriggerServerEvent("admin:delcarall", data.inputData)
	exports['pNotify']:SendNotify('ประกาศลบรถได้เริ่มนับถอยหลังแล้วค่ะ', 'warn',4) -- สีหลอดสีส้ม
	print(data.inputData)
end)]]

RegisterNUICallback("swift_jail", function(data) --เจลเข้าคุก
	TriggerEvent("swift_jail:openMenu")
	exports['pNotify']:SendNotify('เปิดเมนูสำเร็จ', 'su',4) -- สีหลอดสีเขียว
	SetDisplay(false)
end)

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNUICallback("exit", function(data)
    SetDisplay(false)
end)

RegisterNUICallback("ban", function(data) --แบน
    TriggerServerEvent("admin:Ban", data.playerid, tonumber(data.inputData), "คุณโดนแบบชั่วคราว")
end)

RegisterNUICallback("permaban", function(data) 
    TriggerServerEvent("admin:Ban", data.playerid, 0, data.inputData)
end)

RegisterNUICallback("unban", function(data) --ปลดแบน
    TriggerServerEvent("admin:Unban", data.confirmoutput)
    admin.GetPlayers()
end)

RegisterNUICallback("copyskin", function(data) --ก้อปสกิน
    TriggerServerEvent("admin:copyskin", data.playerid)
	SetDisplay(false)
end)

RegisterNUICallback("saveplayerall", function(data) 
    TriggerServerEvent("admin:saveplayerall")
	exports['pNotify']:SendNotify('เซฟผู้เล่นทั้งหมดสำเร็จ', 'su', 4) -- สีหลอดสีเขียว
	SetDisplay(false)
end)

RegisterNUICallback("skin",function(data) --แต่งตัว
    TriggerEvent('esx_skin:openSaveableMenu', source)
	SetDisplay(false)
end)

RegisterNUICallback("skins",function(data)
    ConfigCL["SetSkin"](data)
	exports['pNotify']:SendNotify('เปลี่ยนอวาต้าสกินสำเร็จ', 'su', 4) -- สีหลอดสีเขียว
	SetDisplay(false)
end)

RegisterNUICallback("saveplayer", function(data)
    TriggerServerEvent("admin:saveplayer", data.playerid)
	exports['pNotify']:SendNotify('เซฟผู้เล่นสำเร็จ', 'su', 4) -- สีหลอดสีเขียว
	SetDisplay(false)
end)

RegisterNUICallback("clearinventory", function(data) --ลบของในกระเป๋าทั้งหมด
    TriggerServerEvent("admin:clearinventory", data.playerid)
	SetDisplay(false)
end)

RegisterNUICallback("clearweawpon", function(data) --ลบอาวุธ
    TriggerServerEvent("admin:clearweawpon", data.playerid)
	exports['pNotify']:SendNotify('ลบอาวุธสำเร็จ', 'su', 4) -- สีหลอดสีเขียว
end)

RegisterNUICallback("clearcarkey", function(data) --ลบกุณแจรถทั้งหมด / ลบรถด้วย
    TriggerServerEvent("admin:clearcarkey", data.playerid)
	exports['pNotify']:SendNotify('ลบกุณแจรถสำเร็จ', 'su', 4) -- สีหลอดสีเขียว
	SetDisplay(false)
end)

RegisterNUICallback("addCash", function(data) --เพิ่มเงินเขียว
    local amnt = tonumber(data.inputData)
    TriggerServerEvent("admin:AddCash", data.playerid, amnt)
	exports['pNotify']:SendNotify('ให้เงินสำเร็จ', 'su', 4) -- สีหลอดสีเขียว
end)

RegisterNUICallback("addBlack", function(data) --เพิ่มเงินธนาคาร
    local amnt = tonumber(data.inputData)
    TriggerServerEvent("admin:addBlack", data.playerid, amnt)
	exports['pNotify']:SendNotify('ให้เงินเดงสำเร็จ', 'su', 4) -- สีหลอดสีเขียว
end)

RegisterNUICallback("add", function(data)
    local amnt = tonumber(data.inputData)
    TriggerServerEvent("admin:add", data.playerid, amnt)
end)

RegisterNUICallback("addBank", function(data)
    local amnt = tonumber(data.inputData)
    TriggerServerEvent("admin:AddBank", data.playerid, amnt)
	exports['pNotify']:SendNotify('ให้เงินธนาคารสำเร็จ', 'su', 4) -- สีหลอดสีเขียว
end)

RegisterNUICallback("inventory", function(data) --เปิดกระเป๋า
	ConfigCL["Inventory"](data)
	exports['pNotify']:SendNotify('เปิดกระเป๋าผู้เล่นสำเร็จ', 'su', 4) -- สีหลอดสีเขียว
end)

RegisterNUICallback("giveitem", function(data) --ในไอเทม
    local amnt = tonumber(data.amount)
    -- print("id: "..data.playerid.." name: "..data.name.." amount: "..data.amount)
    TriggerServerEvent("admin:AddItem", data.playerid, data.name, amnt)
end)

RegisterNUICallback("giveitemall", function(data) --ให้ไอเทมทั้งหมด
    local amnt = tonumber(data.amount)
    TriggerServerEvent("admin:giveitemall", data.name, amnt)
end)

RegisterNUICallback("error", function(data)
    chat(data.error, {255,0,0})
    SetDisplay(false)
end)

RegisterNUICallback("tp-wp", function(data) 
    admin.TeleportToWaypoint()
end)

RegisterNUICallback("bring", function(data) --ดึงมาหา
    TriggerServerEvent("admin:Teleport", data.playerid, "bring")
end)

RegisterNUICallback("goto", function(data) --ไปหา
    TriggerServerEvent("admin:Teleport", data.playerid, "goto")
end)

RegisterNUICallback("kick", function(data) --เตะออกเซิฟ
    TriggerServerEvent("admin:Kick", data.playerid, data.inputData)
end)

RegisterNUICallback("spectate", function(data) --ดูผู้เล่น
	playerID = data.playerid
	admin.Spectate(playerID, true)
	isSpectating = true
	SetDisplay(false)
end)

RegisterNUICallback("freeze", function(data) --แช่แข็ง
	TriggerServerEvent("admin:Freeze", data.playerid)
end)

RegisterNUICallback("kill", function(data) --ฆ่า
	TriggerServerEvent("admin:Slay", data.playerid)
end)

RegisterNUICallback("promote", function(data)
	TriggerServerEvent("admin:Promote", data.playerid, data.level)
	print('test')
end)

RegisterNUICallback("weapon", function(data) --ให้อาวุธ
	TriggerServerEvent("admin:GiveWeapon", data.playerid, data.weapon)
end)

RegisterNUICallback("noclip", function(data) --โหมดผี
	admin.Noclip()
	SetDisplay(false)
end)

RegisterNUICallback("setvehicle", function(data) --แต่งรถ
	local playerPed = GetPlayerPed(-1)
	if IsPedInAnyVehicle(playerPed, false) then
		TriggerEvent('jomjam:OpenShopx')
	else
		exports['pNotify']:SendNotify('คุณไม่ได้อยู่ในยานพาหนะ! ไม่มียานพาหนะ', 'warn', 4) -- สีหลอดสีส้ม
		--ESX.ShowNotification("คุณไม่ได้อยู่ในยานพาหนะ! ไม่มียานพาหนะ")
	end
	SetDisplay(false)
end)

RegisterNUICallback("fix", function(data) --ซ่อมรถ
	local playerPed = GetPlayerPed(-1)
	if IsPedInAnyVehicle(playerPed, false) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		SetVehicleEngineHealth(vehicle, 1000)
		SetVehicleEngineOn( vehicle, true, true )
		SetVehicleFixed(vehicle)
		SetVehicleDirtLevel(vehicle, 0)
		exports['pNotify']:SendNotify('ซ่อมรถเรียบร้อยแล้ว', 'su', 4) -- สีหลอดสีเขียว
		--ESX.ShowNotification("ซ่อมรถเรียบร้อยแล้วค่ะ")
	else
		exports['pNotify']:SendNotify('ขึ้นรถก่อนดิ้ไอโง่', 'warn', 4) -- สีหลอดสีส้ม
		--ESX.ShowNotification("ขึ้นรถก่อนอย่ามึนไอสัสนิ")
	end
	SetDisplay(false)
end)

RegisterNUICallback("washcar", function(data) --ล้างรถปิดเมนู
	TriggerEvent("washcar")
	SetDisplay(false)
end)

RegisterNUICallback("washcar", function(data) --ล้างรถ
	local playerPed = GetPlayerPed(GetPlayerFromServerId(data.playerid))
	local vehicle = GetVehiclePedIsIn(playerPed, false)
	if IsPedInAnyVehicle(playerPed, false) then
		SetVehicleDirtLevel(vehicle, 0.0)
		exports['pNotify']:SendNotify('ล้างรถเรียบร้อยแล้ว', 'su', 4) -- สีหลอดสีเขียว
		--ESX.ShowNotification("ล้างรถเรียบร้อยแล้วค่ะ")
	end
end)

Citizen.CreateThread(function() --ฟังชั่นรถอมตะ
	while true do
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		if cargod then
			SetVehicleFixed(vehicle)
			SetEntityInvincible(GetVehiclePedIsUsing(PlayerPedId()), true)
		else
			SetEntityInvincible(GetVehiclePedIsUsing(PlayerPedId()), false)
		end
		Citizen.Wait(100)
	end
end)

Citizen.CreateThread(function() --ฟังชั่นน้ำมันไม่หมด
	while true do
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		if IsPedInAnyVehicle(PlayerPedId(), false) then
			if oilgod then
				SetVehicleFuelLevel(vehicle, 100.0)
			else
				
			end
		end
		Wait(1000)
	end
end)

RegisterNUICallback("washcargod", function(data) --ทำให้รถสกปกปิดเมนู
	TriggerEvent("washcargod")
	SetDisplay(false)
end)

RegisterNUICallback("washcargod", function(data) --ทำให้รถสกปก / ทำไปเพื่อไรก็ไม่รู้ไอสัส
	local playerPed = GetPlayerPed(GetPlayerFromServerId(data.playerid))
	local vehicle = GetVehiclePedIsIn(playerPed, false)
	exports['pNotify']:SendNotify('ทำให้รถสกปรก', 'su', 4) -- สีหลอดเขียว
	--ESX.ShowNotification("รถสกปรก")
	SetVehicleDirtLevel(vehicle, 15.0)
end)

RegisterNUICallback("cargod", function(data) --รถอมตะ
	local playerPed = GetPlayerPed(GetPlayerFromServerId(data.playerid))
	local vehicle = GetVehiclePedIsIn(playerPed, false)
	if IsPedInAnyVehicle(playerPed, false) then
		if not cargod then
			cargod = true
			exports['pNotify']:SendNotify('[ เปิด ] รถอมตะ', 'su',4) -- สีหลอดสีเขียว
			--ESX.ShowNotification("[ เปิด ] รถอมตะ")
		else 
			cargod = false
			exports['pNotify']:SendNotify('[ ปิด ] รถอมตะ', 'fail', 4) -- สีหลอดสีแดง
			--ESX.ShowNotification("[ ปิด ] รถอมตะ ")
		end
	else
		exports['pNotify']:SendNotify('ขึ้นรถก่อนไอสัสนิ', 'warn', 4) -- สีหลอดสีส้ม
		--ESX.ShowNotification("ขึ้นรถก่อนไอสัสนิ")
	end
end)

RegisterNUICallback("oilgod", function(data) --น้ำมันอมตะ
	local playerPed = GetPlayerPed(GetPlayerFromServerId(data.playerid))
	local vehicle = GetVehiclePedIsIn(playerPed, false)
	if IsPedInAnyVehicle(playerPed, false) then
		if not oilgod then
			oilgod = true
			exports['pNotify']:SendNotify('[ เปิด ] น้ำมันไม่หมด', 'su', 4) -- สีหลอดสีเขียว
			--ESX.ShowNotification("[ เปิด ] น้ำมันไม่หมด")
		else 
			oilgod = false
			exports['pNotify']:SendNotify('[ ปิด ] น้ำมันไม่หมด', 'fail', 4) -- สีหลอดสีแดง
			--ESX.ShowNotification("[ ปิด ] น้ำมันไม่หมด")
		end
	else
		exports['pNotify']:SendNotify('ขึ้นรถก่อนไอสัสนิ', 'warn',4) -- สีหลอดสีส้ม
		--ESX.ShowNotification("ขึ้นรถก่อนไอสัสนิ")
	end
end)

RegisterNUICallback("flipcar", function(data)
	local playerPed = GetPlayerPed(GetPlayerFromServerId(data.playerid))
	local vehicle = GetVehiclePedIsIn(playerPed, false)
	local pos = GetEntityCoords(playerPed, false)
	if IsPedInAnyVehicle(playerPed, false) then
		local reval, z_ = GetGroundZFor_3dCoord(pos.x, pos.y, pos.z)
		SetEntityCoords(vehicle, pos.x, pos.y,z_+1)
		SetEntityVisible(playerPed, true, true)
		SetLocalPlayerVisibleLocally(false)
		SetEveryoneIgnorePlayer(playerPed, false)
		SetPoliceIgnorePlayer(playerPed, false)
	else
		exports['pNotify']:SendNotify('ขึ้นรถก่อนไอสัสนิ', 'warn', 4) -- สีหลอดสีส้ม
--[[		TriggerEvent("pNotify:SendNotification", {
			text = '<strong class="green-text">คุณต้องอยู่บนรถก่อนนะ</strong>',
			type = "success",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		})]]
	end
end)

RegisterNUICallback("Maxvehicle", function(vehicle) --แต่งเต็มฉบับสมบูรณ์
	local playerPed = GetPlayerPed(-1)
	if IsPedInAnyVehicle(playerPed, false) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		TaskWarpPedIntoVehicle(ESX.PlayerData.ped, vehicle, -1)
		SetVehicleDirtLevel(vehicle, 0)
		SetVehicleFuelLevel(vehicle, 100.0)
		SetEntityAsMissionEntity(vehicle, true, true)
		SetVehicleExplodesOnHighExplosionDamage(vehicle, true)
		SetVehicleModKit(vehicle, 0)
		SetVehicleMod(vehicle, 11, 3, false) -- modEngine
		SetVehicleMod(vehicle, 12, 2, false) -- modBrakes
		SetVehicleMod(vehicle, 13, 2, false) -- modTransmission
		SetVehicleMod(vehicle, 15, 3, false) -- modSuspension
		SetVehicleMod(vehicle, 16, 4, false) -- modArmor
		ToggleVehicleMod(vehicle, 18, true) -- modTurbo
		SetVehicleTurboPressure(vehicle, 100.0)
		SetVehicleNumberPlateTextIndex(vehicle, 1)
		SetVehicleNitroEnabled(vehicle, true)
		for i=0, 3 do
			SetVehicleNeonLightEnabled(vehicle, i, true)
		end
		SetVehicleNeonLightsColour(vehicle, 55, 140, 191)  -- ESX Blue
		exports['pNotify']:SendNotify('แต่งเต็มเรียบร้อย', 'su', 4) -- สีหลอดสีเขียว
		--ESX.ShowNotification("แต่งเต็มเรียบร้อยแล้วค่ะ")
	else
		exports['pNotify']:SendNotify('ขึ้นรถก่อนไอสัสนิ', 'warn', 4) -- สีหลอดสีส้ม
		--ESX.ShowNotification("รั่วหรอขึ้นรถก่อน")
	end
	SetDisplay(false)
end)

RegisterNUICallback("speedcar", function(data) --เพิ่มความเร็วรถ
	local me = GetPlayerPed(-1)
	local engine = tonumber(data.inputData)
	local veh = GetVehiclePedIsIn(GetPlayerPed(-1),false)
	if engine ~= nil and veh then
		if not IsPedInAnyVehicle(GetPlayerPed(-1)) or GetPedInVehicleSeat(veh, -1)~=GetPlayerPed(-1) then return end
		SetVehicleEnginePowerMultiplier(veh, engine*1.0)
		exports['pNotify']:SendNotify('เพิ่มความเร็ว ' ..engine.. ' + ' , 'su', 4) -- สีหลอดสีเขียว
		--[[TriggerEvent("pNotify:SendNotification", {
			text = '<strong class="green-text">เพิ่มความเร็วเป็น '..engine..' +</strong>',
			type = "success",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		})]]
	end
end)

RegisterNetEvent('admin:godall') --อมตะทั้งหมด
AddEventHandler('admin:godall', function()
	if not godmodeall then
		godmodeall = true
		SetEntityInvincible(GetPlayerPed(-1), true)
		SetPlayerInvincible(PlayerId(), true)
		SetPedCanRagdoll(GetPlayerPed(-1), false)
		ClearPedBloodDamage(GetPlayerPed(-1))
		ResetPedVisibleDamage(GetPlayerPed(-1))
		ClearPedLastWeaponDamage(GetPlayerPed(-1))
		SetEntityProofs(GetPlayerPed(-1), true, true, true, true, true, true, true, true)
		SetEntityOnlyDamagedByPlayer(GetPlayerPed(-1), false)
		SetEntityCanBeDamaged(GetPlayerPed(-1), false)
		exports['pNotify']:SendNotify('[ เปิด ] อมตะทั้งเซิฟเวอร์', 'warn',4) -- สีหลอดสีส้ม
		--ESX.ShowNotification("[ เปิด ] อมตะทั้งเซิฟเวอร์")
	elseif godmodeall then
		godmodeall = false
	    SetEntityInvincible(GetPlayerPed(-1), false)
		SetPlayerInvincible(PlayerId(), false)
		SetPedCanRagdoll(GetPlayerPed(-1), true)
		ClearPedLastWeaponDamage(GetPlayerPed(-1))
		SetEntityProofs(GetPlayerPed(-1), false, false, false, false, false, false, false, false)
		SetEntityOnlyDamagedByPlayer(GetPlayerPed(-1), true)
		SetEntityCanBeDamaged(GetPlayerPed(-1), true)
		exports['pNotify']:SendNotify('[ ปิด ] อมตะทั้งเซิฟเวอร์', 'warn',4) -- สีหลอดสีส้ม
		--ESX.ShowNotification("[ ปิด ] อมตะทั้งเซิฟเวอร์")
	end
end)

RegisterNetEvent('admin:bringall') --ดึงผู้เล่นมาหาทั้งหมด
AddEventHandler('admin:bringall', function(temppos)
	SetEntityCoords(GetPlayerPed(-1), temppos.x, temppos.y, temppos.z)
end)

RegisterNetEvent('admin:freezeall') --แช่แข็งผู้เล่นมั้งหมด
AddEventHandler('admin:freezeall', function()
	local player = PlayerId()
	local ped = PlayerPedId()
	frozen = not frozen
	if not frozen then
		if not IsEntityVisible(ped) then
			SetEntityVisible(ped, true)
		end
		if not IsPedInAnyVehicle(ped) then
			SetEntityCollision(ped, true)
		end
		FreezeEntityPosition(ped, false)
		SetPlayerInvincible(player, false)
		exports['pNotify']:SendNotify('[ ปิด ] แช่แข็ง', 'warn',4) -- สีหลอดสีส้ม
		--ESX.ShowNotification("[ ปิด ] แช่แข็ง")
	else
		SetEntityCollision(ped, false)
		FreezeEntityPosition(ped, true)
		SetPlayerInvincible(player, true)

		if not IsPedFatallyInjured(ped) then
			ClearPedTasksImmediately(ped)
		end
		exports['pNotify']:SendNotify('[ เปิด ] แช่แข็ง', 'warn',4) -- สีหลอดสีส้ม
		--ESX.ShowNotification("[ เปิด ] แช่แข็ง")
	end
end)

RegisterNetEvent('admin:speedrunall') --ผู้เล่นวิ่งเร็วทั้งหมด
AddEventHandler('admin:speedrunall', function(target)
	if not speedrunall then
		speedrunall = true
		SetRunSprintMultiplierForPlayer(PlayerId(), 1.49)
		exports['pNotify']:SendNotify('[ เปิด ] วิ่งเร็ว', 'warn',4) -- สีหลอดสีส้ม
		--ESX.ShowNotification("[ เปิด ] วิ่งเร็ว")
	else
		speedrunall = false
		SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
		exports['pNotify']:SendNotify('[ ปิด ] วิ่งเร็ว', 'warn',4) -- สีหลอดสีส้ม
		--ESX.ShowNotification("[ ปิด ] วิ่งเร็ว")
	end
end)

RegisterNetEvent('admin:jumeperall') --ผู้เล่นกระโดดสูงทั้งหมด
AddEventHandler('admin:jumeperall', function(target)
	if not jumeperall then
		jumeperall = true
		exports['pNotify']:SendNotify('[ เปิด ] กระโดดสูง', 'warn',4) -- สีหลอดสีส้ม
		--ESX.ShowNotification("[ เปิด ] กระโดดสูง")
	else
		jumeperall = false
		exports['pNotify']:SendNotify('[ ปิด ] กระโดดสูง', 'warn',4) -- สีหลอดสีส้ม
		--ESX.ShowNotification("[ ปิด ] กระโดดสูง")
	end
end)

Citizen.CreateThread(function()
    while true do
       Wait(5)
		if jumeperall then
			SetSuperJumpThisFrame(PlayerId())                    
		end

        if staminagodall then
			RestorePlayerStamina(PlayerId(), 1.0)                    
		end
    end
end)

RegisterNetEvent('admin:staminagodall') --ผู้เล่นทั้งหมดวิ่งไม่เหนื่อย
AddEventHandler('admin:staminagodall', function(target)
	if not staminagodall then
		staminagodall = true
		exports['pNotify']:SendNotify('[ เปิด ] วิ่งไม่จำกัด', 'warn',4) -- สีหลอดสีส้ม
		--ESX.ShowNotification("[ เปิด ] วิ่งไม่จำกัด")
	else
		staminagodall = false
		exports['pNotify']:SendNotify('[ ปิด ] วิ่งไม่จำกัด', 'warn',4) -- สีหลอดสีส้ม
		--ESX.ShowNotification("[ ปิด ] วิ่งไม่จำกัด")
	end
end)

RegisterNetEvent('admin:killall') --เตะทั้งหมด
AddEventHandler('admin:killall', function()
	SetEntityHealth(PlayerPedId(), 0)
	exports['pNotify']:SendNotify('ฆ่าล้างเผ่าพันธุ์', 'su', 4) -- สีหลอดสีเขียว
end)

RegisterNUICallback("god", function(data) --เปิดอมตะ
	TriggerServerEvent("admin:God", data.playerid)
end)

RegisterNUICallback("godall", function(data) --เปิดอมตะทั้งหมด
	TriggerServerEvent("admin:godall")
end)

RegisterNUICallback("killall", function(data) --เตะทั้งหมด
	TriggerServerEvent("admin:killall")
end)

RegisterNUICallback("freezell", function(data) --แช่แข็งทั้งหมด
	TriggerServerEvent("admin:freezeall", data.playerid)
end)

RegisterNUICallback("bringall", function(data) --ดึงทั้งหมด
    TriggerServerEvent("admin:bringall", data.playerid, "bring")
	exports['pNotify']:SendNotify('คุณถูกแอดมินดึง', 'su', 4) -- สีหลอดสีเขียว
end)

RegisterNUICallback("speedrunall", function(data) --วิ่งเร็วทั้งหมด
	TriggerServerEvent("admin:speedrunall",data.playerid)
end)

RegisterNUICallback("jumeperall", function(data) --กระโดดสูงทั้งหมด
	TriggerServerEvent("admin:jumeperall",data.playerid)
end)

RegisterNUICallback("staminagodall", function(data) --วิ่งไม่เหนื่อยทั้งหมด
	TriggerServerEvent("admin:staminagodall",data.playerid)
end)

RegisterNUICallback("kickall", function(data) --เตะทั้งหมด
    TriggerServerEvent("admin:kickall", data.inputData)
end)

RegisterNUICallback("speedrun", function(data) --วิ่งเร็ว
	TriggerServerEvent("admin:speedrun",data.playerid)
end)

RegisterNUICallback("jumeper", function(data) --กระโดดสูง
	TriggerServerEvent("admin:jumeper",data.playerid)
end)

RegisterNUICallback("staminagod", function(data) --วิ่งไม่เหนื่อย
	TriggerServerEvent("admin:staminagod",data.playerid)
end)

RegisterNUICallback("spawnvehicle", function(data) --เสกรถ
	admin.SpawnVehicle(data.model)
	SetDisplay(false)
end)

RegisterNUICallback("announce", function(data) --ประกาศ
	TriggerServerEvent("admin:Announcement", data.inputData)
end)

RegisterNUICallback("setJob", function(data) --ตั้งอาชีพ
	TriggerServerEvent("admin:setJob", data.playerid, data.job, data.rank)
end)

RegisterNUICallback("revive", function(data) --ชุบ
	TriggerServerEvent("admin:revive", data.playerid)
end)

RegisterNUICallback("setTime", function(data) --เซ็ตเวลา
	TriggerServerEvent("admin:Time", data.inputData)
	exports['pNotify']:SendNotify('เวลาถูกเปลี่ยนโดนแอดมิน', 'su', 4) -- สีหลอดสีเขียว
end)

RegisterNUICallback("freezeTime", function(data) --แช่แข็งเวลา
	TriggerServerEvent("admin:freezeTime")
	exports['pNotify']:SendNotify('หยุดเวลาโดยแอดมิน', 'su', 4) -- สีหลอดสีเขียว
end)

RegisterNUICallback("changeWeather", function(data) --เลือกสภาพอากาศอากาศ
	TriggerServerEvent("admin:Weather", data.weather)
	exports['pNotify']:SendNotify('สภาพอากาศอากาศถูกเปลี่ยนโดยแอดมิน', 'su', 4) -- สีหลอดสีเขียว
end)

RegisterNUICallback("EXTRASUNNY", function(data)
	weather = 'EXTRASUNNY'
	TriggerServerEvent("admin:Weather", weather)
	exports['pNotify']:SendNotify('สภาพอากาศ แดดออก', 'su', 4) -- สีหลอดสีเขียว
end)

RegisterNUICallback("CLEAR", function(data)
	weather = 'CLEAR'
	TriggerServerEvent("admin:Weather", weather)
	exports['pNotify']:SendNotify('สภาพอากาศ โปร่งใส', 'su', 4) -- สีหลอดสีเขียว
end)

RegisterNUICallback("NEUTRAL", function(data)
	weather = 'NEUTRAL'
	TriggerServerEvent("admin:Weather", weather)
	exports['pNotify']:SendNotify('สภาพอากาศ เป็นกลาง', 'su', 4) -- สีหลอดสีเขียว
end)

RegisterNUICallback("SMOG", function(data)
	weather = 'SMOG'
	TriggerServerEvent("admin:Weather", weather)
	exports['pNotify']:SendNotify('สภาพอากาศ ⠀หมอกควัน', 'su', 4) -- สีหลอดสีเขียว
end)

RegisterNUICallback("FOGGY", function(data)
	weather = 'FOGGY'
	TriggerServerEvent("admin:Weather", weather)
	exports['pNotify']:SendNotify('สภาพอากาศ หมอก', 'su', 4) -- สีหลอดสีเขียว
end)

RegisterNUICallback("OVERCAST", function(data)
	weather = 'OVERCAST'
	TriggerServerEvent("admin:Weather", weather)
	exports['pNotify']:SendNotify('สภาพอากาศ เมฆครึ้ม', 'su', 4) -- สีหลอดสีเขียว
end)

RegisterNUICallback("CLOUDS", function(data)
	weather = 'CLOUDS'
	TriggerServerEvent("admin:Weather", weather)
	exports['pNotify']:SendNotify('สภาพอากาศ เมฆ', 'su', 4) -- สีหลอดสีเขียว
end)

RegisterNUICallback("CLEARING", function(data)
	weather = 'CLEARING'
	TriggerServerEvent("admin:Weather", weather)
	exports['pNotify']:SendNotify('สภาพอากาศ เคลียร์', 'su', 4) -- สีหลอดสีเขียว
end)

RegisterNUICallback("RAIN", function(data)
	weather = 'RAIN'
	TriggerServerEvent("admin:Weather", weather)
	exports['pNotify']:SendNotify('สภาพอากาศ ฝน', 'su', 4) -- สีหลอดสีเขียว
end)

RegisterNUICallback("THUNDER", function(data)
	weather = 'THUNDER'
	TriggerServerEvent("admin:Weather", weather)
	exports['pNotify']:SendNotify('สภาพอากาศ ฟ้าร้อง', 'su', 4) -- สีหลอดสีเขียว
end)

RegisterNUICallback("XMAS", function(data)
	weather = 'XMAS'
	TriggerServerEvent("admin:Weather", weather)
	exports['pNotify']:SendNotify('สภาพอากาศ คริสต์มาส', 'su', 4) -- สีหลอดสีเขียว
end)

RegisterNUICallback("BLIZZARD", function(data)
	weather = 'BLIZZARD'
	TriggerServerEvent("admin:Weather", weather)
	exports['pNotify']:SendNotify('สภาพอากาศ พายุหิมะ', 'su', 4) -- สีหลอดสีเขียว
end)

RegisterNUICallback("SNOWLIGHT", function(data)
	weather = 'SNOWLIGHT'
	TriggerServerEvent("admin:Weather", weather)
	exports['pNotify']:SendNotify('สภาพอากาศ สโนว์ไลท์', 'su', 4) -- สีหลอดสีเขียว
end)

RegisterNUICallback("HALLOWEEN", function(data)
	weather = 'HALLOWEEN'
	TriggerServerEvent("admin:Weather", weather)
	exports['pNotify']:SendNotify('สภาพอากาศ ฮาโลวีน', 'su', 4) -- สีหลอดสีเขียว
end)

RegisterNUICallback("freezeWeather", function(data)
	TriggerServerEvent("admin:freezeWeather")
end)

RegisterNUICallback("blackout", function(data) --ไฟดับ
	TriggerServerEvent("admin:Blackout")
end)

RegisterNUICallback("healspecific", function(data) --ฮิลเฉพาะคน
	local TargetPlayer = data.playerid
	TriggerServerEvent("admin:healspecific", TargetPlayer)
end)

RegisterNUICallback("reviveall", function(data) --ชุบทั้งหมด
	TriggerServerEvent("admin:reviveall")
end)

RegisterNUICallback("healall", function(data) --ฮิลทั้งหมด
	TriggerServerEvent("admin:healall")
end)

RegisterNUICallback("setskin",function(data)
    TriggerServerEvent("admin:skin", data.playerid)
	SetDisplay(false)
end)

RegisterNetEvent("admin:healPlayer") --ฮิลเฉพาะคน
AddEventHandler("admin:healPlayer", function ()
SetEntityHealth(PlayerPedId(), 200)
	TriggerEvent('esx_status:set', 'hunger', 1000000)
	TriggerEvent('esx_status:set', 'stress', 0)
end)

RegisterNetEvent("admin.request") --ฮิลเฉพาะคน
AddEventHandler("admin.request", function (medthod)
	local Ped = PlayerPedId()
	if medthod == "heal" then
		SetEntityHealth(Ped, 200)
		TriggerEvent('esx_status:set', 'hunger', 1000000)
		TriggerEvent('esx_status:set', 'stress', 0)
	elseif medthod == "revive" then
		if IsPedDeadOrDying(Ped , 1) then
			TriggerEvent("esx_ambulancejob:revive")
			Wait(1500)
		end
	end
end)

RegisterNetEvent("admin.tpm") --วาป
AddEventHandler("admin.tpm", function ()
	admin.TeleportToWaypoint()
end)

admin.TeleportToWaypoint = function() ---วาปไปที่มาร์ค
	local  playerRank = _playerRank
    if Config.Perms[_playerRank] and Config.Perms[_playerRank].CanTpWp then
        local WaypointHandle = GetFirstBlipInfoId(8)
        if DoesBlipExist(WaypointHandle) then
            local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)
            for height = 1, 1000 do
                SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
                local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)
                if foundGround then
                    SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
                    break
                end
                Citizen.Wait(0)
            end
			exports['pNotify']:SendNotify('เทเลพอร์ตแล้ว', 'su', 4) -- สีหลอดสีเขียว
            --ESX.ShowNotification("เทเลพอร์ตแล้ว")
        else
			exports['pNotify']:SendNotify('กรุณามาร์คจุดด้วย', 'warn', 4) -- สีหลอดสีส้ม
            --ESX.ShowNotification("กรุณามาร์คจุดด้วย")
        end
    else
		exports['pNotify']:SendNotify("ไม่สามารถใช้คำสั่งได้", 'fail', 4) -- สีหลอดสีแดง
		--[[TriggerEvent("pNotify:SendNotification", {
			text = " ไม่สามารถใช้คำสั่งได้ ",
			type = "error",
			timeout = 1000,
			layout = "centerRight",
			queue = "global"
		})]]
    end
end

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end

admin.GetPlayers = function()
    ESX.TriggerServerCallback("admin:getPlayers", function(players) 
        SendNUIMessage({type = "data", data = players})
    end)
	if _bans == nil then
		ESX.TriggerServerCallback("admin:getBanList", function(bans) 
			_bans = bans
		    SendNUIMessage({type = "bans", banlist = bans})
		end)
	else
		SendNUIMessage({type = "bans", banlist = _bans})
	end
end

admin.GetItemList = function()
	local weapons = ESX.GetWeaponList()
	if _jobs == nil then
		ESX.TriggerServerCallback("admin:getJobs", function(jobs) 
			_jobs = jobs
		    ESX.TriggerServerCallback("admin:getItemList", function(results) 
				_results = results
		        SendNUIMessage({type = "items", itemslist = results, weaponlist = weapons, vehiclelist = Config.Vehicles, joblist = jobs, pedlist = Config.PedModel, texturl = ConfigJs["JS"],})
		    end)
		end)
	else
		SendNUIMessage({type = "items", itemslist = _results, weaponlist = weapons, vehiclelist = Config.Vehicles, joblist = _jobs, pedlist = Config.PedModel, texturl = ConfigJs["JS"],})
	end
end

local nearBlips = {}
local longBlips = {}

RegisterNetEvent('admin:removeUser')
AddEventHandler('admin:removeUser', function(plyId)
	-- print('OUT:'..plyId)
    if nearBlips[plyId] then
        RemoveBlip(nearBlips[plyId].blip)
        nearBlips[plyId] = nil
    end
    if longBlips[plyId] then
        RemoveBlip(longBlips[plyId].blip)
        longBlips[plyId] = nil
    end
end)

RegisterNetEvent('admin:showblip')
AddEventHandler('admin:showblip', function(myId, data)
	for k, v in pairs(data) do
        local cId = GetPlayerFromServerId(v.playerId)
        if true then
			local ped = PlayerPedId()
			local x1, y1, z1 = table.unpack( GetEntityCoords( ped, true ) )
            if myId ~= v.playerId then
				for i,Player in ipairs(GetActivePlayers()) do
					if Player ~= ped  then
						local Ped = GetPlayerPed(Player)
						
						local x2, y2, z2 = table.unpack( GetEntityCoords( Ped, true ) )
						local distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))
						if distance < Config.SettingDisplayOnlyAdmin['Distance'] then
							if nearBlips[v.playerId] == nil then  -- switch/init blip from long to close proximity
								if longBlips[v.playerId] then
									RemoveBlip(longBlips[v.playerId].blip)
									longBlips[v.playerId] = nil
								end
								nearBlips[v.playerId] = {}
								nearBlips[v.playerId].blip = AddBlipForEntity(GetPlayerPed(cId))
								setupBlip(nearBlips[v.playerId].blip, v)
							end  
						else
							if longBlips[v.playerId] == nil then -- switch/init blip from close to long proximity
								if nearBlips[v.playerId] then
									RemoveBlip(nearBlips[v.playerId].blip)
									nearBlips[v.playerId] = nil
								end
								longBlips[v.playerId] = {}
								longBlips[v.playerId].blip = AddBlipForCoord(v.coords)
								setupBlip(longBlips[v.playerId].blip, v)
							else
								if longBlips[v.playerId] then
									RemoveBlip(longBlips[v.playerId].blip)
								end
								longBlips[v.playerId].blip = AddBlipForCoord(v.coords)
								setupBlip(longBlips[v.playerId].blip, v)
							end
						end
					end 
                end
            end
        end
    end
end)

function setupBlip(blip, data)
	SetBlipSprite(blip, 1)
	SetBlipDisplay(blip, 2)
	SetBlipScale(blip,  1.0)
	SetBlipColour(blip, 0)
    SetBlipFlashes(blip, false)
    SetBlipCategory(blip, 7)
	BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(data.rpname)
	EndTextCommandSetBlipName(blip)
end

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    removeAllBlips()
end)

function removeAllBlips()
    for k, v in pairs(nearBlips) do
        RemoveBlip(v.blip)
    end
    for k, v in pairs(longBlips) do
        RemoveBlip(v.blip)
    end
    nearBlips = {}
    longBlips = {}
end

function restoreBlip(blip) 
    SetBlipSprite(blip, 6)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.7)
    SetBlipColour(blip, 0)
    SetBlipShowCone(blip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(GetPlayerName(PlayerId()))
    EndTextCommandSetBlipName(blip)
    SetBlipCategory(blip, 1)
end

RegisterNetEvent('admin:Freeze')
AddEventHandler('admin:Freeze', function(targetPed)
	local player = PlayerId()
	local ped = PlayerPedId()
	frozen = not frozen
	if not frozen then
		if not IsEntityVisible(ped) then
			SetEntityVisible(ped, true)
		end
		if not IsPedInAnyVehicle(ped) then
			SetEntityCollision(ped, true)
		end
		FreezeEntityPosition(ped, false)
		SetPlayerInvincible(player, false)
	else
		SetEntityCollision(ped, false)
		FreezeEntityPosition(ped, true)
		SetPlayerInvincible(player, true)
		if not IsPedFatallyInjured(ped) then
			ClearPedTasksImmediately(ped)
		end
	end
end)

RegisterNetEvent('admin_:teleport') --วาป
AddEventHandler('admin_:teleport', function(temppos)
	SetEntityCoords(PlayerPedId(), temppos.x, temppos.y, temppos.z)
end)

RegisterNetEvent('admin:Slay') --ฆ่า
AddEventHandler('admin:Slay', function(targetPed)
	SetEntityHealth(PlayerPedId(), 0)
end)

RegisterNetEvent('admin:God') --เปิดอมตะ
AddEventHandler('admin:God', function(targetPed)
    if not hasGodmode then
        hasGodmode = not hasGodmode
        SetEntityInvincible(GetPlayerPed(-1), true)
        SetPlayerInvincible(PlayerId(), true)
        SetPedCanRagdoll(GetPlayerPed(-1), false)
        ClearPedBloodDamage(GetPlayerPed(-1))
        ResetPedVisibleDamage(GetPlayerPed(-1))
        ClearPedLastWeaponDamage(GetPlayerPed(-1))
        SetEntityProofs(GetPlayerPed(-1), true, true, true, true, true, true, true, true)
        SetEntityOnlyDamagedByPlayer(GetPlayerPed(-1), false)
        SetEntityCanBeDamaged(GetPlayerPed(-1), false)
    else
        SetEntityInvincible(GetPlayerPed(-1), false)
        SetPlayerInvincible(PlayerId(), false)
        SetPedCanRagdoll(GetPlayerPed(-1), true)
        ClearPedLastWeaponDamage(GetPlayerPed(-1))
        SetEntityProofs(GetPlayerPed(-1), false, false, false, false, false, false, false, false)
        SetEntityOnlyDamagedByPlayer(GetPlayerPed(-1), true)
        SetEntityCanBeDamaged(GetPlayerPed(-1), true)
    end
end)

admin.SpawnVehicle = function(model) --เสกรถ
	local  playerRank = _playerRank
    if Config.Perms[_playerRank] and Config.Perms[_playerRank].CanSpawnVehicle then
		local coords = GetEntityCoords(PlayerPedId())
		local closestVehicle = ESX.Game.GetClosestVehicle(coords)
		ESX.Game.DeleteVehicle(closestVehicle)
		ESX.Game.SpawnVehicle(model, vector3(coords.x + 2.0, coords.y, coords.z), 0.0, function(vehicle) --get vehicle info
			if DoesEntityExist(vehicle) then
				TaskWarpPedIntoVehicle(PlayerPedId(),  vehicle, -1)
				exports['pNotify']:SendNotify('คุณเสกยานพาหนะ '..model, 'su', 4) -- สีหลอดสีเขียว
				--ESX.ShowNotification("คุณเสกยานพาหนะ "..model)			
			end		
		end)
	else
		exports['pNotify']:SendNotify("ไม่สามารถใช้คำสั่งได้", 'fail', 4) -- สีหลอดสีแดง
		--[[TriggerEvent("pNotify:SendNotification", {
			text = " ไม่สามารถใช้คำสั่งได้ ",
			type = "error",
			timeout = 1000,
			layout = "centerRight",
			queue = "global"
		})]]
    end
end

admin.Spectate = function(target, bool) --ส่องผู้เล่น
	local  playerRank = _playerRank
    if Config.Perms[_playerRank] and Config.Perms[_playerRank].CanSpectate then
		if bool then
			temppos = GetEntityCoords(PlayerPedId(), false)
			ESX.TriggerServerCallback("admin:TeleportSpectate", function(callback)
				SetEntityInvincible(PlayerPedId(), true)
				SetEntityVisible(PlayerPedId(), false, false)
				FreezeEntityPosition(PlayerPedId(), true)
				Wait(1000)
				local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
				local name = GetPlayerName(GetPlayerFromServerId(target))
				if targetPed ~= PlayerPedId() then
					
					if (not IsScreenFadedOut() and not IsScreenFadingOut()) then
						DoScreenFadeOut(1000)
						while (not IsScreenFadedOut()) do
							Wait(0)
						end
						local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))
						RequestCollisionAtCoord(targetx,targety,targetz)
						NetworkSetInSpectatorMode(true, targetPed)
						exports['pNotify']:SendNotify('เริ่มการส่องผู้เล่น '..name, 'su',4 ) -- สีหลอดสีเขียว
						--ESX.ShowNotification("เริ่มการส่องผู้เล่น "..name)
						if(IsScreenFadedOut()) then
							DoScreenFadeIn(1000)
						end
					end
					
				else
					exports['pNotify']:SendNotify('ไม่สามารถส่องตัวเองได้', 'fail', 4) -- สีหลอดสีแดง
					--ESX.ShowNotification("ไม่สามารถส่องตัวเองได้ เฉพาะหล่อเกินไป")
				end
			end,target)
			Citizen.CreateThread(function()
				while isSpectating do
					Citizen.Wait(0)
					if IsControlJustPressed(0, 322)  then
						admin.Spectate(playerID, false)
						isSpectating = false
						playerID = nil
					end
				end
			end)
		else
			local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
			local name = GetPlayerName(GetPlayerFromServerId(target))
			if(not IsScreenFadedOut() and not IsScreenFadingOut()) then
				DoScreenFadeOut(1000)
				while (not IsScreenFadedOut()) do
					Wait(0)
				end
				local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))
				RequestCollisionAtCoord(targetx,targety,targetz)
				NetworkSetInSpectatorMode(false, targetPed)
				exports['pNotify']:SendNotify("ยกเลิกการส่อง " ..name, 'warn',4 ) -- สีหลอดสีส้ม
				--ESX.ShowNotification("ยกเลิกการส่อง"..name)
				if(IsScreenFadedOut()) then
					DoScreenFadeIn(1000)
				end
			end
			if temppos ~= nil then
				SetEntityCoords(PlayerPedId(),temppos)
				SetEntityInvincible(PlayerPedId(), false)
				SetEntityVisible(PlayerPedId(), true, true)
				FreezeEntityPosition(PlayerPedId(), false)
			end
		end
	else
		exports['pNotify']:SendNotify("ไม่สามารถใช้คำสั่งได้", 'fail', 4) -- สีหลอดสีแดง
        --[[TriggerEvent("pNotify:SendNotification", {
			text = " ไม่สามารถใช้คำสั่งได้ ",
			type = "error",
			timeout = 1000,
			layout = "centerRight",
			queue = "global"
		})]]
    end
end

admin.Noclip = function()
    if Config.Perms[_playerRank] and Config.Perms[_playerRank].CanNoClip then
		noclip = not noclip
	    local msg = "ปิด"
		local color = "fail"
		if noclip then
			msg = "เปิด"
			color = "su"
		end
		exports['pNotify']:SendNotify("[ "..msg.." ] ".." โนคลิป", color, 4) -- สีตามตัวแปร color
		--[[TriggerEvent("pNotify:SendNotification", {
			text = " [ฟังชั่นโนคลิป] " .. msg,
			type = "success",
			timeout = 3000,
			layout = "centerRight",
			queue = "global"
		})]]
		local heading = 0
		Citizen.CreateThread(function()
			local playerped = PlayerPedId()
			local entity = playerped
			local noclip_pos = GetEntityCoords(PlayerPedId(), false)
			if IsPedInAnyVehicle(playerped) then
				entity =  GetVehiclePedIsUsing(playerped)
			end
			
			SetEntityCollision(entity, not noclip, not noclip)
        	FreezeEntityPosition(entity, noclip)
        	SetVehicleRadioEnabled(entity, not noclip)
			if noclip then
				SetEntityAlpha(entity, 51, false)
			else
				local reval, z_ = GetGroundZFor_3dCoord(noclip_pos.x, noclip_pos.y, noclip_pos.z)
				SetEntityCoords(entity,noclip_pos.x, noclip_pos.y,z_+1)
				SetEntityVisible(PlayerPedId(), true, true)
        		SetLocalPlayerVisibleLocally(false)
				SetEveryoneIgnorePlayer(PlayerPedId(), false)
        		SetPoliceIgnorePlayer(PlayerPedId(), false)
			end
			local follow = true
			while noclip do
				Citizen.Wait(0)
				SetEntityVisible(PlayerPedId(), false, false)
        		SetLocalPlayerVisibleLocally(true)
				SetEveryoneIgnorePlayer(PlayerPedId(), true)
        		SetPoliceIgnorePlayer(PlayerPedId(), true)
				if follow then
					heading = getCamDirection()
				else
					if(IsControlPressed(1, 34))then
						heading = heading + 1.5
						if(heading > 360)then
							heading = 0
						end
						SetEntityHeading(entity, heading)
					end
					if(IsControlPressed(1, 9))then
						heading = heading - 1.5
						if(heading < 0)then
							heading = 360
						end
						SetEntityHeading(entity, heading)
					end
				end
				if(IsControlJustReleased(0, 74))then
					follow = not follow
					Wait(300)
				end
				if(IsControlPressed(1, 8))then
					noclip_pos = GetOffsetFromEntityInWorldCoords(entity, 0.0, -1.0*Config.Noclip[speed].speed, 0.0)
				end
				if(IsControlPressed(1, 32))then
					noclip_pos = GetOffsetFromEntityInWorldCoords(entity, 0.0, 1.0*Config.Noclip[speed].speed, 0.0)
				end
				if(IsControlPressed(1, 52))then
					noclip_pos = GetOffsetFromEntityInWorldCoords(entity, 0.0, 0.0, 1.0*Config.Noclip[speed].speed)
				end
				if(IsControlPressed(1, 48))then
					noclip_pos = GetOffsetFromEntityInWorldCoords(entity, 0.0, 0.0, -1.0*Config.Noclip[speed].speed)
				end
				
				SetEntityVelocity(entity, 0.0, 0.0, 0.0)
            	SetEntityRotation(entity, 0.0, 0.0, 0.0, 0, false)
            	SetEntityHeading(entity, heading)
            	SetEntityCoordsNoOffset(entity, noclip_pos.x, noclip_pos.y, noclip_pos.z, noclip, noclip, noclip)
			end
			ResetEntityAlpha(entity)
			
		end)
	else
		exports['pNotify']:SendNotify("ไม่สามารถใช้คำสั่งได้", 'fail', 4) -- สีหลอดสีแดง
        --[[TriggerEvent("pNotify:SendNotification", {
			text = " ไม่สามารถใช้คำสั่งได้ ",
			type = "error",
			timeout = 1000,
			layout = "centerRight",
			queue = "global"
		})]]
    end
end

RegisterCommand("Noclip", function(source,args)
	admin.Noclip()
end)

RegisterKeyMapping("Noclip", "Admin Menu[ No clip ]", "keyboard", Config.SettingSystem.KeyNoclip)

admin.NoclipSpeed = function()
	if noclip then
		if Config.Perms[_playerRank] and Config.Perms[_playerRank].CanNoClip then
			speed = speed + 1
			if #Config.Noclip < speed then
				speed = 1
			end
			exports['pNotify']:SendNotify("ความเร็ว : " .. Config.Noclip[speed].text, 'warn',4 ) -- สีหลอดสีส้ม
		--[[TriggerEvent("pNotify:SendNotification", {
			text = " ความเร็ว : " .. Config.Noclip[speed].text,
			type = "success",
			timeout = 1000,
			layout = "centerRight",
			queue = "global"
		})]]
		else
			exports['pNotify']:SendNotify("ไม่สามารถใช้คำสั่งได้", 'fail', 4) -- สีหลอดสีแดง
		--[[	TriggerEvent("pNotify:SendNotification", {
				text = " ไม่สามารถใช้คำสั่งได้ ",
				type = "error",
				timeout = 1000,
				layout = "centerRight",
				queue = "global"
			})]]
		end
	end
end

RegisterCommand("NoclipSpeed", function(source,args)
	admin.NoclipSpeed()
end)

RegisterKeyMapping("NoclipSpeed", "Admin Menu[ Speed Noclip ]", "keyboard", Config.SettingSystem.KeyNoclipSpeed)

RegisterKeyMapping("admin", " Admin Menu", "keyboard", Config.SettingSystem.KeyOpen) 

RegisterCommand("admin", function(source,args)
	--sound()
	if _playerRank == nil then
		ESX.TriggerServerCallback("esx_marker:fetchUserRank", function(playerRank)
			_playerRank = playerRank
    	    if Config.Perms[_playerRank] then
    	    	local coords = round(GetEntityCoords(PlayerPedId()), 2)
				local heading = round(GetEntityHeading(PlayerPedId()), 2)
    	    	SendNUIMessage({type = "coords", coordData = coords})
    			admin.GetPlayers()
    			admin.GetItemList()
    			SetDisplay(true)
    		else
				exports['pNotify']:SendNotify("ไม่สามารถใช้คำสั่งได้", 'fail', 4) -- สีหลอดสีแดง
    			--[[TriggerEvent("pNotify:SendNotification", {
					text = " ไม่สามารถใช้คำสั่งได้ ",
					type = "error",
					timeout = 1000,
					layout = "centerRight",
					queue = "global"
				})]]
    		end
    	end)
	else
		if Config.Perms[_playerRank] then
			local coords = round(GetEntityCoords(PlayerPedId()), 2)
			local heading = round(GetEntityHeading(PlayerPedId()), 2)
			SendNUIMessage({type = "coords", coordData = coords})
			admin.GetPlayers()
			admin.GetItemList()
			SetDisplay(true)
		else
			exports['pNotify']:SendNotify("ไม่สามารถใช้คำสั่งได้", 'fail', 4) -- สีหลอดสีแดง
			--[[TriggerEvent("pNotify:SendNotification", {
				text = " ไม่สามารถใช้คำสั่งได้ ",
				type = "error",
				timeout = 1000,
				layout = "centerRight",
				queue = "global"
			})]]
		end
	end
end)

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

RegisterNUICallback("Updateblip", function()
	Updateblip = not Updateblip
    TriggerServerEvent("admin:addUpdateblip", Updateblip)
	if not Updateblip then
		removeAllBlips()
	end
	SetDisplay(false)
end)

function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
  end
  
function OnRequestGamerTags() --เปิดชื่อ TX ADMIN	
	  for _, player in ipairs(GetActivePlayers()) do
		  local ped = GetPlayerPed(player)
		  if (Starsation.GamerTags[ped] == nil) or (Starsation.GamerTags[ped].ped == nil) or not (IsMpGamerTagActive(Starsation.GamerTags[ped].tags)) then
			  local colors = {
				  ["admin"] = 'ADMIN',
				  ["moderator"] = 'MODO',
				  ["user"] = 'USER',
			  }
			  local formatted;
			  local group = 0;
			  local permission = 0;
			  local fetching = RetrievePlayersDataByID(GetPlayerServerId(player));
			--   print(fetching.group)
			  if (fetching) then
				  -- ยศ [%s] ID [%d] ชื่อ %s อาชีพ (%s) fetching.jobs
				  formatted = string.format('[%d] %s ',GetPlayerServerId(player), GetPlayerName(player))
			  else
				  formatted = string.format('[%d] %s ',GetPlayerServerId(player), GetPlayerName(player))
			  end
			  if (fetching) then
				  group = fetching.group
				  permission = fetching.permission
			  end
			  Starsation.GamerTags[ped] = {
				  player = player,
				  ped = ped,
				  group = group,
				  permission = permission,
				  tags = CreateFakeMpGamerTag(ped, formatted)
			  };
		  end
	  end
  end
  
function RetrievePlayersDataByID(source)
	local player = {};
	for i, v in pairs(Starsation.Players) do
		if (v.source == source) then
			player = v;
		end
	end
	return player;
end
  
local player = {};
Starsation = {} or {};
Starsation.GamerTags = {} or {};
Starsation.Players = {} or {};
local head_ = false;
RegisterNUICallback("name_on", function()
	if not head_  then
    head_ = true
	exports['pNotify']:SendNotify("[ เปิด ] โชว์ชื่อบนหัว", 'su', 4) -- สีหลอดสีเขียว
	--ESX.ShowNotification("[เปิดใช้งาน] โชว์ชื่อบนหัว")
    Citizen.CreateThread(function()
        open_name()
	end)
else
    head_ = false
	exports['pNotify']:SendNotify("[ ปิด ] โชว์ชื่อบนหัว", 'fail', 4) -- สีหลอดสีแดง
	--ESX.ShowNotification("[ปิดใช้งาน] โชว์ชื่อบนหัว")
        for i, v in pairs(Starsation.GamerTags) do
            RemoveMpGamerTag(v.tags)
        end
    end
    --SetDisplay(false)
end)

function open_name()
	while head_ do
        Citizen.Wait(1)
        OnRequestGamerTags()
    end
end

Citizen.CreateThread(function()
    while true do
        if head_ then    
            for i, v in pairs(Starsation.GamerTags) do
                local target = GetEntityCoords(v.ped, false);
                if #(target - GetEntityCoords(PlayerPedId())) < 120 then
                    SetMpGamerTagVisibility(v.tags, 0, true)
                    SetMpGamerTagVisibility(v.tags, 2, true)
                    SetMpGamerTagHealthBarColor(v.tags,27)
                    SetMpGamerTagVisibility(v.tags, 4, NetworkIsPlayerTalking(v.player))
                    SetMpGamerTagAlpha(v.tags, 2, 255)
                    SetMpGamerTagAlpha(v.tags, 4, 255)
                    local colors = {
                        ["admin"] = 3,
                        ["moderator"] = 5,
						["user"] = 11,
                    }
                    SetMpGamerTagColour(v.tags, 0, colors[v.group] or 0)
                else
                    RemoveMpGamerTag(v.tags)
                    Starsation.GamerTags[i] = nil;
                end
            end
        end
        Citizen.Wait(1)
    end
end)

function getCamDirection()
	local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(GetPlayerPed(-1))
	return heading
end

function bulletCoords()  ----กระสุนระเบิด
    local result, coord = GetPedLastWeaponImpactCoord(GetPlayerPed(-1))
    return coord
end 

function getEntity(player)
	local result, entity = GetEntityPlayerIsFreeAimingAt(player)
	return entity
end

function getGroundZ(x, y, z) --- ฟังชั่นกระสุนเสกรถ สำคัญ
    local result, groundZ = GetGroundZFor_3dCoord(x + 0.0, y + 0.0, z + 0.0, Citizen.ReturnResultAnyway())
    return groundZ
end 

Citizen.CreateThread(function() -- Teleport Gun
	while true do
	  Citizen.Wait(0)
  
	  if teleportGun then
		local x,y,z = table.unpack(bulletCoords())
		if x ~= 0 and y ~= 0 and z ~= 0 then
		  SetEntityCoords(GetPlayerPed(-1), x,y,z)
		end
	  end
	end
  end)

RegisterNUICallback("teleportGun", function(data) --กระสุนวาปปิดเมนู
	TriggerEvent("teleportGun")
	--SetDisplay(false)
end)

RegisterNetEvent('teleportGun') --กระสุนวาป
AddEventHandler('teleportGun', function()
	if not teleportGun then
		teleportGun = true
		exports['pNotify']:SendNotify("[ เปิด ] กระสุนวาป", 'su', 4) -- สีหลอดสีเขียว
		--ESX.ShowNotification("เปิดใช้งาน  [เทเลพอร์ตกัน]")
	else
		teleportGun = false
		exports['pNotify']:SendNotify("[ ปิด ] กระสุนวาป", 'fail', 4) -- สีหลอดสีแดง
		--ESX.ShowNotification("ปิดใช้งาน  [เทเลพอร์ตกัน]")
	end
end)
 -------------------ใช้ได้แต่อาจทำให้เซิฟพัง
Citizen.CreateThread(function() -- ฟังชั่นกระสุนรถ
	while true do
	  Citizen.Wait(0)
  
	  if vehicleGun then
		if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then
		  if IsPedShooting(GetPlayerPed(-1)) then
			while not HasModelLoaded(GetHashKey(Config.vehicleGunVehicle)) do
						  Citizen.Wait(0)
						  RequestModel(GetHashKey(Config.vehicleGunVehicle))
			end
			local playerPos = GetEntityCoords(GetPlayerPed(-1), true)
			local veh =  CreateVehicle(GetHashKey(Config.vehicleGunVehicle), playerPos.x + (10 * GetEntityForwardX(GetPlayerPed(-1))), playerPos.y + (10 * GetEntityForwardY(GetPlayerPed(-1))), getGroundZ(playerPos.x + (10 * GetEntityForwardX(GetPlayerPed(-1))), playerPos.y + (10 * GetEntityForwardY(GetPlayerPed(-1))), playerPos.z + 5), GetEntityHeading(GetPlayerPed(-1)), true, true)
			SetEntityAsNoLongerNeeded(veh)
			SetVehicleForwardSpeed(veh, 150.0)
		  end
		end
	  end
	end
  end)  

RegisterNUICallback("vehicleGun", function(data) --กระสุนรถปิดเมนู
	TriggerEvent("vehicleGun")
	--SetDisplay(false)
end)

RegisterNetEvent('vehicleGun') --กระสุนรถ
AddEventHandler('vehicleGun', function()
	if not vehicleGun then
		vehicleGun = true
		exports['pNotify']:SendNotify("[ เปิด ] กระสุนเสกรถ", 'su', 4) -- สีหลอดสีเขียว
		--ESX.ShowNotification("เปิดใช้งาน  [กระสุนเสกรถ]")
	else
		vehicleGun = false
		exports['pNotify']:SendNotify("[ ปิด ] กระสุนเสกรถ", 'fail', 4) -- สีหลอดสีแดง
		--ESX.ShowNotification("ปิดใช้งาน  [กระสุนเสกรถ]")
	end
end)

RegisterNUICallback("addhunger", function(data)
	TriggerServerEvent("admin:addhunger", data.playerid, tonumber(data.inputData))
end)

RegisterNUICallback("arall", function(data)
	TriggerServerEvent("admin:arall", data.playerid)
end)

RegisterNetEvent('admin:arall')
AddEventHandler('admin:arall', function(percent)
	TriggerEvent('esx_status:set', 'hunger', 1000000)
	TriggerEvent('esx_status:set', 'stress', 0)
end)

RegisterNetEvent('admin:addhunger')
AddEventHandler('admin:addhunger', function(percent)
	TriggerEvent('esx_status:set', 'hunger', percent* 10000)
end)

RegisterNUICallback("removestress", function(data)
	TriggerServerEvent("admin:removestress", data.playerid, tonumber(data.inputData))
end)

RegisterNetEvent('admin:removestress')
AddEventHandler('admin:removestress', function(percent)
	TriggerEvent('esx_status:set', 'stress', percent * 10000)
	-- print(percent)
end)

RegisterNUICallback("DeleteVehicles", function(data)
	exports['pNotify']:SendNotify("ระบบได้ทำการลบรถทั้งหมดแล้วค่ะ", 'su', 4) -- สีหลอดสีเขียว
	--ESX.ShowNotification("ระบบได้ทำการลบรถทั้งหมดแล้วค่ะ")
	DeleteVehicles()
end)

RegisterNUICallback("DeleteObjects", function(data)
	DeleteObjects()
end)

RegisterNUICallback("delcaralldist", function(data)
	local dist = data.inputData
	TriggerEvent('esx:deleteVehicle', dist)
	exports['pNotify']:SendNotify("ระบบได้ทำการลบรถในระยะที่กำหนดแล้วค่ะ", 'su', 4) -- สีหลอดสีเขียว
	--ESX.ShowNotification("ระบบได้ทำการลบรถในระยะที่กำหนดแล้วค่ะ")
	SetDisplay(false)
end)

RegisterKeyMapping("WarpKey", "Admin Menu[Teleport]", "keyboard", '0')
RegisterCommand("WarpKey", function(source, args)
	ESX.TriggerServerCallback("esx_marker:fetchUserRank", function(group)
		if Config.Perms[group] and Config.Perms[group].CanTpWp then
			local WaypointHandle = GetFirstBlipInfoId(8)
			if DoesBlipExist(WaypointHandle) then
				local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)
				for height = 1, 1000 do
					SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
					local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)
					if foundGround then
						SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
						break
					end
					Wait(10)
				end
			end
		end
	end)
end)

RegisterCommand('die', function(source, args)
	if _playerRank == 'superadmin' or _playerRank == 'admin' or _playerRank == 'mod' then
		SetEntityHealth(PlayerPedId(), 0.0)
	end
end)

RegisterNUICallback("Drift", function(data)
    TriggerEvent("Drift")
	SetDisplay(false)
end)

RegisterNetEvent('Drift') --กระสุนวาป
AddEventHandler('Drift', function()
	if not Drift then
		Drift = false
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped, false) then
			local veh = GetVehiclePedIsUsing(ped)
		if GetDriftTyresEnabled(veh) then
			SetDriftTyresEnabled(veh, false)
			exports['pNotify']:SendNotify("[ ปิด ] ดริฟท์โหมด", 'fail', 4) -- สีหลอดสีแดง
			--ESX.ShowNotification("ปิดใช้งาน  [ดริฟท์โหมด]")
		else
			Drift = true
			SetDriftTyresEnabled(veh, true)
			exports['pNotify']:SendNotify("[ เปิด ] ดริฟท์โหมด", 'su', 4) -- สีหลอดสีเขียว
			--ESX.ShowNotification("เปิดใช้งาน  [ดริฟท์โหมด]")
		end
	else
		exports['pNotify']:SendNotify("ขึ้นรถก่อนไอสัสนิ", 'warn',4 ) -- สีหลอดสีส้ม
		--ESX.ShowNotification("ขึ้นรถก่อนไอสัสนิ")
		end
	end
end)

RegisterNUICallback("setplayerped", function(data)
	admin.GetPlayePed(data.model)
	SetDisplay(false)
end)

admin.GetPlayePed = function(model)
	local  playerRank = _playerRank

	-- print(model)

    if Config.Perms[_playerRank] and Config.Perms[_playerRank].CanPed then
		if model ~= 'blank' then
			SetParticle()
			local playermodel = GetHashKey(model)
			RequestModel(playermodel)
			while not HasModelLoaded(playermodel) do
			    Wait(100)
			end
			SetPlayerModel(PlayerId(), playermodel)
			SetModelAsNoLongerNeeded(playermodel)

		else
			SetParticle()
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				local isMale = skin.sex == 0

				TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
					ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
						TriggerEvent('skinchanger:loadSkin', skin)
						TriggerEvent('esx:restoreLoadout')
					end)
				end)
			end) 
		end 
	end
end

function RespawnPedMenu(ped, coords, heading)
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(ped, false)
	TriggerEvent('playerSpawned', coords.x, coords.y, coords.z)
	ClearPedBloodDamage(ped)

	ESX.UI.Menu.CloseAll()
end

--Effect

SetParticle = function()
Citizen.CreateThread(function()
	RequestNamedPtfxAsset(Config.dict2)
	while not HasNamedPtfxAssetLoaded(Config.dict2) do
		Citizen.Wait(0)
	end
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped, true))
	local a = 0
	while a < 25 do
		UseParticleFxAssetNextCall(Config.dict2)
		StartParticleFxNonLoopedAtCoord(Config.particleName2, x, y, z, 1.50, 1.50, 1.50, 1.50, false, false, false)
		a = a + 1
		break
		Citizen.Wait(50)
		end
	end)
end

----------------------------

function Clamp(x, min, max)
	return math.min(math.max(x, min), max)
  end
  
  function GetDisabledControlNormalBetween(inputGroup, control1, control2)
	local normal1 = GetDisabledControlNormal(inputGroup, control1)
	local normal2 = GetDisabledControlNormal(inputGroup, control2)
	return normal1 - normal2
  end
  
  function EulerToMatrix(rotX, rotY, rotZ)
	local radX = math.rad(rotX)
	local radY = math.rad(rotY)
	local radZ = math.rad(rotZ)
  
	local sinX = math.sin(radX)
	local sinY = math.sin(radY)
	local sinZ = math.sin(radZ)
	local cosX = math.cos(radX)
	local cosY = math.cos(radY)
	local cosZ = math.cos(radZ)
  
	local vecX = {}
	local vecY = {}
	local vecZ = {}
  
	vecX.x = cosY * cosZ
	vecX.y = cosY * sinZ
	vecX.z = -sinY
  
	vecY.x = cosZ * sinX * sinY - cosX * sinZ
	vecY.y = cosX * cosZ - sinX * sinY * sinZ
	vecY.z = cosY * sinX
  
	vecZ.x = -cosX * cosZ * sinY + sinX * sinZ
	vecZ.y = -cosZ * sinX + cosX * sinY * sinZ
	vecZ.z = cosX * cosY
  
	vecX = vector3(vecX.x, vecX.y, vecX.z)
	vecY = vector3(vecY.x, vecY.y, vecY.z)
	vecZ = vector3(vecZ.x, vecZ.y, vecZ.z)
  
	return vecX, vecY, vecZ
  end
  
  
  local entityEnumerator = {
	__gc = function(enum)
	  if enum.destructor and enum.handle then
		enum.destructor(enum.handle)
	  end
	  enum.destructor = nil
	  enum.handle = nil
	end
  }
  
  local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
	  local iter, id = initFunc()
	  if not id or id == 0 then
		disposeFunc(iter)
		return
	  end
	  
	  local enum = {handle = iter, destructor = disposeFunc}
	  setmetatable(enum, entityEnumerator)
	  
	  local next = true
	  repeat
		coroutine.yield(id)
		next, id = moveFunc(iter)
	  until not next
	  
	  enum.destructor, enum.handle = nil, nil
	  disposeFunc(iter)
	end)
  end
  
  function EnumerateObjects()
	return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
  end
  
  function EnumeratePeds()
	return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
  end
  
  function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
  end
  
  function EnumeratePickups()
	return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
  end
  
  function DeleteVehicles()
	  for vehicle in EnumerateVehicles() do
		  if (not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1))) then 
			  SetVehicleHasBeenOwnedByPlayer(vehicle, false) 
			  SetEntityAsMissionEntity(vehicle, false, false) 
			  DeleteVehicle(vehicle)
			  if (DoesEntityExist(vehicle)) then 
				  DeleteVehicle(vehicle) 
			  end
		  end
	  end
  end
  
Citizen.CreateThread(function() 
	  while true do
		  Wait(0)
		  if Delete then
			  for i = 1, #removeprops do 
				local player = PlayerId()
				local plyPed = GetPlayerPed(player)
				local plyPos = GetEntityCoords(plyPed, false)
			  
				local prop = GetClosestObjectOfType(plyPos.x, plyPos.y, plyPos.z, 200.0, GetHashKey(removeprops[i]), false, 0, 0)
				if prop ~= 0 then
					SetEntityAsMissionEntity(prop, true, true)
					DeleteObject(prop)
					SetEntityAsNoLongerNeeded(prop)
				  end
				end
		  else
			  Citizen.Wait(1000)
		  end
	  end
  end)
  
function DeleteObjects()
	Delete = true
	exports['pNotify']:SendNotify("ลบพร๊อบเรียบร้อยแล้วค่ะ", 'su', 4) -- สีหลอดเขียว
	--ESX.ShowNotification("ลบพร๊อบเรียบร้อยแล้วค่ะ")
 	Wait(5000)
	Delete = false
end

---------------------------------------------------

RegisterNUICallback("cooldown", function(data)
    TriggerEvent("cooldown")
	--SetDisplay(false)
end)

RegisterNetEvent('cooldown') --กระสุนวาป
AddEventHandler('cooldown', function()
if not passive then
	passive = true
	exports['pNotify']:SendNotify('[ เปิด ] ใช้งานตัวใส', 'su', 4) -- สีหลอดสีเขียว
else
	passive = false
	exports['pNotify']:SendNotify('[ ปิด ] ใช้งานตัวใส', 'fail', 4) -- สีหลอดสีแดง
	end
end)


Citizen.CreateThread(function()
    local mezc = 100
    while true do
        local ped = PlayerPedId()
        local playerped = GetPlayerPed(-1)
        if passive then
			passive = true
			SetLocalPlayerAsGhost(true)
			NetworkSetPlayerIsPassive(true)
            NetworkSetFriendlyFireOption(false)
            SetPedCanRagdoll(ped, false)
			SetNetworkVehicleAsGhost(veh, true)
            --DisablePlayerFiring(player, true)
            SetEntityInvincible(playerped, true)
            SetEntityAlpha(playerped, 200, false)
		else
            mezc = 100
			passive = false
            NetworkSetFriendlyFireOption(true)
            SetPedCanRagdoll(ped, true)
            SetEntityInvincible(playerped, false)
            NetworkSetPlayerIsPassive(false)
            ResetEntityAlpha(playerped)
        end
        Citizen.Wait(mezc)
	end
end)

RegisterNUICallback("getcar", function(data)
	TriggerServerEvent("getcar")
	exports['pNotify']:SendNotify("เก็บรถทุกคันเข้าการาจเรียบร้อยแล้วค่ะ", 'warn',4 ) -- สีหลอดสีส้ม
	--SetDisplay(false)
end)


RegisterNUICallback("delcarall", function(data)
    TriggerServerEvent("admin:delcarall", data.inputData)
	exports['pNotify']:SendNotify('ประกาศลบรถได้เริ่มนับถอยหลังแล้วค่ะ', 'warn',4) -- สีหลอดสีส้ม
	SetDisplay(false)
end)

RegisterNUICallback("canceldelcarall", function(data)
    TriggerServerEvent("admin:canceldelcarall")
	exports['pNotify']:SendNotify('ยกเลิกประกาศลบรถแล้วค่ะ', 'warn',4) -- สีหลอดสีส้ม
	SetDisplay(false)
end)

RegisterNUICallback("restartserver", function(data)
    TriggerServerEvent("admin:restartserver", data.inputData)
	exports['pNotify']:SendNotify('ประกาศรีเซิร์ฟได้เริ่มนับถอยหลังแล้วค่ะ', 'warn',4) -- สีหลอดสีส้ม
	SetDisplay(false)
end)

RegisterNUICallback("cancelrestartserver", function(data)
    TriggerServerEvent("admin:cancelrestartserver")
	exports['pNotify']:SendNotify('ยกเลิกประกาศรีเซิร์ฟแล้วค่ะ', 'warn', 4) -- สีหลอดสีส้ม
end)