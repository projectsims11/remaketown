
--[[
	Author: CanonX2
	Special: Fivem Server
    Discord : https://discord.gg/Ns9jcjvuxc
	Readme : ระบบถูกออกแบบมาให้ใช้กับ extended 1.2 90% บางฟังชั้น 1.1 อาจจะตั้องแก้ไขเองเพิ่มเติม
--]]

local ESX = nil
local Routers = nil
local CraftingTable = {}
local PlayerData = nil
local CraftingType = {}
local ListObject = {}
local CategoryListCl = {}
local Nametable = "โต๊ะคราฟไอเทม"
local MenuOn = false
local number = 1
local category = 1
local craftting_process = false
local extended = "1.2"

Citizen.CreateThread(function()
	Citizen.Wait(3500) 
	TriggerServerEvent('nexz_crafting:GetSetupResources')
end)

RegisterNetEvent('nexz_crafting:SetConfigData')
AddEventHandler('nexz_crafting:SetConfigData', function(cfg ,exver ,re)
	SendNUIMessage({
		acton = 'srcimg',
		src = Config["Image_Source"],
	})
	Routers = re
	extended = exver
	CategoryListCl = cfg
	StartEvent()
	print("^7[^1CLP^7][^4".. GetCurrentResourceName() .."^7] - Loading resources success.")	
end)

function StartEvent()
	Citizen.CreateThread(function()
		while ESX == nil do
			TriggerEvent(Routers["getSharedObject"],function(obj)ESX = obj end)
			Citizen.Wait(0)
		end
		
		PlayerData = ESX.GetPlayerData()
					
		while PlayerData.job == nil do
			Citizen.Wait(0)
		end
	end)

	function DoesPlayerExist(pServerId)
		local playerId = GetPlayerFromServerId(tonumber(pServerId))
		if playerId ~= -1 then
			return true
		end
	end

	RegisterNetEvent('nexz_crafting:PlayWithinDistanceCl')
	AddEventHandler('nexz_crafting:PlayWithinDistanceCl', function(playerNetId, maxDistance, soundFile, soundVolume)
		if not DoesPlayerExist(playerNetId) then return end
		local lCoords = GetEntityCoords(PlayerPedId())
		local eCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(playerNetId)))
		local distIs  = Vdist(lCoords.x, lCoords.y, lCoords.z, eCoords.x, eCoords.y, eCoords.z)
		if(distIs <= maxDistance) then
			SendNUIMessage({
				acton     = 'Sound',
				transactionType     = 'playSound',
				transactionFile     = soundFile,
				transactionVolume   = soundVolume
			})
		end
	end)

	RegisterNetEvent('nexz_crafting:RemoveWeaponCl')
	AddEventHandler('nexz_crafting:RemoveWeaponCl', function(weapon)
		RemoveWeaponFromPed(GetPlayerPed(-1), weapon)
	end)

	-- Display object
	Citizen.CreateThread(function()
		for k,v in pairs(Config["Craft_Table"]) do	
			if v.Disable_Model == false and v.Disable_Model ~= nil then
				Objects = vector3(v.Position.x , v.Position.y ,v.Position.z - 1)
				ESX.Game.SpawnLocalObject(v.Model, Objects, function(obj) 
					SetEntityHeading(obj ,v.Position.h)
					SetEntityVelocity(obj, 0.0, 0.0, -2.0)
					PlaceObjectOnGroundProperly(obj)
					FreezeEntityPosition(obj, true)		
					table.insert(ListObject, obj)		
				end)
			end
		end
	end)

	draw = draw or {}
function draw.Simple3DText(x, y, z, text, sc)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local p = GetGameplayCamCoords()
	local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
	local scale = (1 / distance) * 2
	local fov = (1 / GetGameplayCamFov()) * 100
	scale = scale * fov
	if sc then scale = scale * sc end
	if onScreen then
		SetTextScale(0.0 * scale, 0.35 * scale)
		SetTextFont(0)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 255)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(2, 0, 0, 0, 150)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
	end
end

	-- Display Texts
	local Texts = false
	AddEventHandler('nexz_crafting:Displaytexts', function()
		Texts = true
		while Texts do
			Citizen.Wait(1)
			if not MenuOn then
				local letSleep = true
				local playerPed = PlayerPedId()
				local coords    = GetEntityCoords(playerPed)
				for k,v in pairs(Config["Craft_Table"]) do	
					local distance = GetDistanceBetweenCoords(coords, v.Position.x , v.Position.y , v.Position.z, true)
					if distance < 10 then
						if distance < 5 then
							if v.Disable_Model == false and v.Disable_Model ~= nil then
								letSleep = false
								if v.Name ~= nil then
									--ESX.Game.Utils.DrawText3D({x = v.Position.x, y = v.Position.y, z = v.Position.z+0.4}, '<font face="'..Config["Font"]..'">'..v.Name..'</font>', 1.0)
									draw.Simple3DText(v.Position.x, v.Position.y, v.Position.z + 0.4, "<FONT FACE = 'sarabun'>"..v.Name , 1.7)
								end
								if v.Desc ~= nil then
									--ESX.Game.Utils.DrawText3D({x = v.Position.x, y = v.Position.y, z = v.Position.z+0.25}, '<font face="'..Config["Font"]..'">'..v.Desc..'</font>', 0.8)
									draw.Simple3DText(v.Position.x, v.Position.y, v.Position.z + 0.25, "<FONT FACE = 'sarabun'>"..v.Desc , 1.2)
								end
							end
						else
							Texts = false
						end
					end
				end
				if letSleep == true then
					Citizen.Wait(1500)
				end	
			else
				Citizen.Wait(1500)		
			end	
		end
	end)

	-- Display Blip
	Citizen.CreateThread(function()
		for k,v in pairs(Config["Craft_Table"]) do	
			if v.Map_blip == true and v.Map_blip ~= nil then
				blips = AddBlipForCoord(v.Position.x , v.Position.y , v.Position.z)
				Blip_Name = "Crafting Table"
				Blip_Scale = 0.9
				Blip_Sprite = 605
				Blip_Color = 24
				if v.Blip_scale ~= nil then
					Blip_Scale = v.Blip_scale
				end
				if v.Blip_sprite ~= nil then
					Blip_Sprite = v.Blip_sprite
				end
				if v.Blip_color ~= nil then
					Blip_Color = v.Blip_color
				end
				if v.Blip_name ~= nil then
					Blip_Name = v.Blip_name
				end
				SetBlipDisplay(blips, 4)
				SetBlipSprite (blips, Blip_Sprite)
				SetBlipScale  (blips, Blip_Scale)
				SetBlipColour (blips, Blip_Color)
				SetBlipAsShortRange(blips, true)
				AddTextEntry('BLIP_CRAFTING', Blip_Name)
				BeginTextCommandSetBlipName("BLIP_CRAFTING")
				EndTextCommandSetBlipName(blips)
			end
		end
	end)

	-- Display markers
	local Markers = false
	AddEventHandler('nexz_crafting:Displaymarkers', function()
		while Markers do
			Citizen.Wait(2)
			if not MenuOn then
				local letSleep = true
				local playerPed = PlayerPedId()
				local coords    = GetEntityCoords(playerPed)
				for k,v in pairs(Config["Craft_Table"]) do	
					local distance = GetDistanceBetweenCoords(coords, v.Position.x , v.Position.y , v.Position.z, true)
					if distance < 15 then
						if distance < 10 then
							if v.Marker == true and v.Marker ~= nil then	
								letSleep = false		
								Marker_Type = 1
								Marker_Scale = {0.5,0.5,0.5}
								Marker_Color = {0,0,0}
								if v.Marker_Scale ~= nil then
									Marker_Scale = v.Marker_Scale
								end
								if v.Marker_Type ~= nil then
									Marker_Type = v.Marker_Type
								end
								if v.Marker_Color ~= nil then
									Marker_Color = v.Marker_Color
								end
								DrawMarker(Marker_Type, v.Position.x , v.Position.y , v.Position.z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Marker_Scale[1], Marker_Scale[2], Marker_Scale[3], Marker_Color[1], Marker_Color[2], Marker_Color[3], 100, false, true, 2, true, false, false, false)
							end
						else
							Markers = false	
						end
					end
				end
				if letSleep == true then
					Citizen.Wait(1500)
				end	
			else
				Citizen.Wait(1500)	
			end
		end
	end)


	Citizen.CreateThread(function()
		while true do
			local letSleep = 1500
			if craftting_process then
				letSleep = 0
				DisableAllControlActions(0)
			end
			Citizen.Wait(letSleep)
		end
	end)

	-- Display markers
	Citizen.CreateThread(function()
		Citizen.Wait(3000)
		PlayerData = ESX.GetPlayerData()
		local GetJob = true
		while true do
			Citizen.Wait(5)
			if not MenuOn then
				local letSleep = true
				local playerPed = PlayerPedId()
				local coords    = GetEntityCoords(playerPed)
				for k,v in pairs(Config["Craft_Table"]) do	
					local statusjob = false
					local distance = GetDistanceBetweenCoords(coords, v.Position.x , v.Position.y , v.Position.z, true)
					if distance < 10 then
						letSleep = false		
						if v.Marker == true and v.Marker ~= nil then	
							if distance < 9 and Markers == false then
								TriggerEvent('nexz_crafting:Displaymarkers')
							end		
						end		

						if v.Disable_Model == false and v.Disable_Model ~= nil then
							if distance < 4 and Texts == false then
								TriggerEvent('nexz_crafting:Displaytexts')	
							end									
						end		

						if distance < v.Max_Distance then
							if v.job ~= nil then
								if v.job[1] ~= nil then
									for k,v in pairs(v.job) do	
										if PlayerData.job.name == v then
											statusjob = true
										end	
									end	
								end
							else
								statusjob = true
							end
						
							if statusjob then
								ShowHelpNotification('<font face="'..Config["Font"]..'">กด ~y~[E] ~s~เพื่อเปิดเมนูคราฟไอเทม~s~</font>')	
								if IsControlJustReleased(0, Config["Keys"]["E"]) then						
									TriggerEvent("nexz_crafting:OpenMenuCraft", v.Category ,v.Position ,v.Table_Name)
									Citizen.Wait(1500)			
								end 
							else
								ShowHelpNotification('<font face="'..Config["Font"]..'">~r~ไม่สามามารถเปิดหน้าโต๊ะคราฟได้~s~</font>')
							end
						end
					end					
				end
				if letSleep then
					Citizen.Wait(2500)
				end	
			else
				Citizen.Wait(1500)				
			end
		end
	end)

	AddEventHandler('nexz_crafting:OpenMenuCraft', function(id ,position ,tablename)
		--TriggerScreenblurFadeIn(1)
		if tablename == nil then tablename = "โต๊ะคราฟ" end	
		local Frist = true
		Nametable 	= tablename
		Inventorys 	= ESX.GetPlayerData().inventory	
		Accounts 	= ESX.GetPlayerData().accounts	
		for s,o in pairs(id) do
			for k,v in pairs(CategoryListCl[o].list) do
				local label = ""
				for key, value in pairs(Inventorys) do
					if v.item == value.name then
						label = value.label
					end
				end

				local cost = {}
				if extended == "1.2" then
					for key, value in pairs(Accounts) do
						for ks, vls in pairs(v.cost) do
							if ks == Accounts[key].name then
								table.insert(cost, {name = ks, amox = vls ,label = Accounts[key].label})
							end	
						end
					end
				elseif extended == "1.1" then
					for ks, vls in pairs(v.cost) do
						if ks == "black_money" then
							table.insert(cost, {name = ks, amox = vls ,label = "เงินผิดกฏหมาย"})
						end	
						if ks == "money" then
							table.insert(cost, {name = ks, amox = vls ,label = "เงินถูกกฏหมาย"})
						end	
						if ks == "cash" then
							table.insert(cost, {name = ks, amox = vls ,label = "เงินถูกกฏหมาย"})
						end	
					end
				end
			

				local blueprint = {}
				for key, value in pairs(Inventorys) do
					for ks, vls in pairs(v.blueprint) do
						if ks == value.name then
							table.insert(blueprint, {name = ks, amox = vls ,label = value.label})
						end	
					end
				end

				local equipment = {}
				if v.equipment ~= nil then
					for ks, vls in pairs(v.equipment) do
						for key, value in pairs(Inventorys) do			
							if ks == value.name then
								table.insert(equipment, {name = ks, status = vls ,label = value.label})
							end	
						end
					end
				else
					equipment = nil	
				end

				local weaponrequest = {}
				local removeweaponaftercraftcraft = false

				if v.removeweaponaftercraft ~= nil then
					removeweaponaftercraftcraft = v.removeweaponaftercraft
				end	

				if v.weaponrequest ~= nil then
					if string.find(v.weaponrequest, "WEAPON_", 1) == nil then
						for key, value in pairs(Inventorys) do
							if v.weaponrequest == value.name then
								table.insert(weaponrequest, {name = v.weaponrequest, status = removeweaponaftercraftcraft,type = "item_standard",label = value.label})
							end
						end
					else
						table.insert(weaponrequest, {name = v.weaponrequest, status = removeweaponaftercraftcraft,type = "item_weapon",label = ESX.GetWeaponLabel(v.weaponrequest)})
					end
				else
					weaponrequest = nil	
				end

				local persentremove_fail = {}
				if v.persentremove_fail ~= nil then
					local protect_follw_black = nil

					if v.persentremove_fail['protect_follw_black'] ~= nil then
						protect_follw_black = v.persentremove_fail['protect_follw_black']
					end	

					if string.find(v.persentremove_fail['follw_black'], "WEAPON_", 1) == nil then
						for key, value in pairs(Inventorys) do
							if v.persentremove_fail['follw_black'] == value.name then
								table.insert(persentremove_fail, {protectfollwblackitem = protect_follw_black ,itrmlosblack = v.persentremove_fail['follw_black'] ,name = v.weaponrequest, persent = v.persentremove_fail['persent_fall'] , type = "item_standard",label = value.label})
							end
						end
					else
						table.insert(persentremove_fail, {protectfollwblackitem = protect_follw_black ,itrmlosblack = v.persentremove_fail['follw_black'] ,name = v.weaponrequest, persent = v.persentremove_fail['persent_fall'] , type = "item_weapon",label = ESX.GetWeaponLabel(v.persentremove_fail['follw_black'])})
					end
				else
					persentremove_fail = nil	
				end

				local fail_item = {}
				local custom_percent_failitem = 0
				if v.fail_item ~= nil then
					if v.custom_percent_failitem ~= nil then
						custom_percent_failitem = v.custom_percent_failitem
					end
					for key, value in pairs(Inventorys) do
						for ks, vls in pairs(v.fail_item) do
							if ks == value.name then
								table.insert(fail_item, {name = ks, amox = vls ,label = value.label})
							end	
						end
					end
				else
					fail_item = nil	
				end

				if Frist == true then
					category = o
					if string.find(v.item, "WEAPON_", 1) == nil then
						table.insert(CraftingTable, { Category = o , categoryname = CategoryListCl[o].name, position = position ,id = k ,type = "item_standard" ,item=v.item ,label=label ,fail_chance=v.fail_chance ,fail_item = fail_item, custom_percent_failitem = custom_percent_failitem ,cost=cost ,blueprint=blueprint  ,equipment= equipment, weaponrequest=weaponrequest,persentremove_fail = persentremove_fail, status = true })
					else	
						table.insert(CraftingTable, { Category = o , categoryname = CategoryListCl[o].name, position = position ,id = k ,type = "item_weapon" ,item=v.item ,label=ESX.GetWeaponLabel(v.item) ,fail_chance=v.fail_chance ,fail_item = fail_item, custom_percent_failitem = custom_percent_failitem ,cost=cost ,blueprint=blueprint  ,equipment= equipment, weaponrequest=weaponrequest,persentremove_fail = persentremove_fail, status = true })
					end
					Frist = false
				else
					if string.find(v.item, "WEAPON_", 1) == nil then
						table.insert(CraftingTable, { Category = o, categoryname = CategoryListCl[o].name, position = position ,id = k ,type = "item_standard" ,item=v.item ,label=label ,fail_chance=v.fail_chance ,fail_item = fail_item, custom_percent_failitem = custom_percent_failitem ,cost=cost ,blueprint=blueprint  ,equipment= equipment, weaponrequest=weaponrequest,persentremove_fail = persentremove_fail, status = false })
					else	
						table.insert(CraftingTable, { Category = o, categoryname = CategoryListCl[o].name, position = position ,id = k ,type = "item_weapon" ,item=v.item ,label=ESX.GetWeaponLabel(v.item) ,fail_chance=v.fail_chance ,fail_item = fail_item, custom_percent_failitem = custom_percent_failitem ,cost=cost ,blueprint=blueprint  ,equipment= equipment, weaponrequest=weaponrequest,persentremove_fail = persentremove_fail, status = false })
					end
				end
			end
			table.insert(CraftingType, { Category = o, categoryname = CategoryListCl[o].name})
		end
		MenuOn = true
		SetNuiFocus(true, true)	
		SendNUIMessage({ 
			acton = 'openmenu',
			nametable = tablename,
			data = CraftingTable,
			datatype = CraftingType,
			category = category,
		})
	end)

	RegisterNUICallback('ChooseType', function(s)	
		category = s.category
		local frist = true
		for k,v in pairs(CraftingTable) do
			if v.Category == s.category then
				if frist then
					v.status = true
					frist = false
				else
					v.status = false	
				end
			else
				v.status = false	
			end		
		end
		SendNUIMessage({ 
			acton = 'openmenu',
			nametable = Nametable,
			slesc = 'choose',
			data = CraftingTable,
			datatype = CraftingType,
			category = category,
			number = number,
		})
	end)

	RegisterNUICallback('Choose', function(s)	
		number = s.number
		for k,v in pairs(CraftingTable) do
			if v.Category == category then
				if v.id == s.data.id then
					if v.item == s.data.item then
						v.status = true
					end	
				else
					v.status = false	
				end		
			end		
		end
		SendNUIMessage({ 
			acton = 'openmenu',
			nametable = Nametable,
			slesc = 'choose',
			data = CraftingTable,
			datatype = CraftingType,
			category = category,
			number = number,
		})
	end)

	RegisterNUICallback('SetCount', function(s)	
		number = s.number
		SendNUIMessage({ 
			acton = 'openmenu',
			nametable = Nametable,
			slesc = 'choose',
			data = CraftingTable,
			datatype = CraftingType,
			category = category,
			number = number,
		})
	end)

	RegisterNUICallback('Crafting', function(s)	
		if craftting_process then return end
		craftting_process = true
		Inventorys 	= ESX.GetPlayerData().inventory
		Accounts 	= ESX.GetPlayerData().accounts
		local StatusCraft = true	
		local StatusMoney = true	
		local StatusBlackMoney = true	
		local StatusEquipment = true	
		local Statusweaponrequest = true	
		local money = {}	
		local black_money = {}	
		for k,v in pairs(CraftingTable) do
			if v.status == true then

				if v.weaponrequest ~= nil then
					for ks, vls in pairs(v.weaponrequest) do
						if string.find(vls.name, "WEAPON_", 1) == nil then
							for key, value in pairs(Inventorys) do	
								if vls.name == value.name then
									if value.count <= 0 then
										TriggerEvent('nexz_crafting:Notification','ไม่พบไอเทมที่ต้องการ')							
										Statusweaponrequest = false
									end
								end
							end
						else
							local PlayerPed 	= PlayerPedId()
							local weaponHash = GetHashKey(vls.name)
							if not HasPedGotWeapon(PlayerPed, weaponHash, false) then
								TriggerEvent('nexz_crafting:Notification','ไม่พบไอเทมที่ต้องการ')				
								Statusweaponrequest = false
							end
						end	
					end		
				end	

				if Statusweaponrequest == true then
					for ks, vls in pairs(v.cost) do	

						if vls.name == "black_money" then
							table.insert(black_money ,{name = vls.name ,amox = vls.amox})
						end
					
						if extended == "1.2" then
							if vls.name == "money" then
								table.insert(money ,{name = vls.name ,amox = vls.amox})
							end
						elseif extended == "1.1" then
							if vls.name == "cash" then
								table.insert(money ,{name = vls.name ,amox = vls.amox})
							end
						end

						if extended == "1.2" then
							if black_money[1] ~= nil then
								for ks, vls in pairs(black_money) do	
									for key, value in pairs(Accounts) do		
										if vls.name == "black_money" then
											if Accounts[key].name == vls.name then							
												if Accounts[key].money < vls.amox * s.data then
													StatusBlackMoney = false
													TriggerEvent('nexz_crafting:Notification','จำนวนเงินแดงมีไม่เพียงพอ')
												end
											end	
										end	
									end
								end
							end
						
							if StatusBlackMoney == true then
								if money[1] ~= nil then
									for ks, vls in pairs(money) do	
										for key, value in pairs(Accounts) do		
											if vls.name == "money" then
												if Accounts[key].name == vls.name then							
													if Accounts[key].money < vls.amox * s.data then
														StatusMoney = false
														TriggerEvent('nexz_crafting:Notification','จำนวนเงินเขียวมีไม่เพียงพอ')
													end
												end	
											end	
										end
									end
								end
							end	
						elseif extended == "1.1" then
							local nexz_accounts = {}
							ESX.TriggerServerCallback('nexz_crafting:ChackMoney', function(accounts)	
								nexz_accounts = accounts						
								if black_money[1] ~= nil then
									for ks, vls in pairs(black_money) do	
										for key, value in pairs(nexz_accounts) do																					
											if value.name == vls.name then						
												if value.money < vls.amox * s.data then
													StatusBlackMoney = false
													TriggerEvent('nexz_crafting:Notification','จำนวนเงินแดงมีไม่เพียงพอ')
												end
											end	
										end
									end
								end

								if StatusBlackMoney == true then
									if money[1] ~= nil then
										for ks, vls in pairs(money) do	
											for key, value in pairs(nexz_accounts) do													
												if value.name == vls.name then								
													if value.money < vls.amox * s.data then
														StatusMoney = false
														TriggerEvent('nexz_crafting:Notification','จำนวนเงินเขียวมีไม่เพียงพอ')
													end
												end	
											end
										end
									end
								end	
							end)										
						end				
					end
				end
			
				if StatusMoney == true and StatusBlackMoney == true and Statusweaponrequest == true then
					if v.equipment ~= nil then
						for key, value in pairs(Inventorys) do		
							for ks, vls in pairs(v.equipment) do
								if vls.name == value.name then
									if vls.status == true then
										if value.count <= 0 then
											TriggerEvent('nexz_crafting:Notification','ไม่พบอุปกรณ์ที่ต้องใช้')
											StatusEquipment = false
										end
									end
								end
							end
						end		
					end		
				end	

		
				if Statusweaponrequest == true and StatusMoney == true and StatusBlackMoney == true and StatusEquipment == true then
					for key, value in pairs(Inventorys) do		
						for ks, vls in pairs(v.blueprint) do
							if vls.name == value.name then
								if value.count < vls.amox * s.data then
									TriggerEvent('nexz_crafting:Notification','วัสดุอุปกรณ์มีไม่เพียงพอ')
									StatusCraft = false
								end
							end
						end
					end		
				end	

				SetTimeout(500, function()
					if StatusCraft == true and StatusMoney == true and StatusBlackMoney == true and StatusEquipment == true and Statusweaponrequest == true then
						TriggerEvent('nexz_crafting:Crafting', v.type, v.blueprint , v.cost, v.item , s.data , v.fail_chance ,v.position ,v.fail_item, v.custom_percent_failitem ,v.weaponrequest, v.persentremove_fail)
					end		
				end)	

				SetTimeout(1500, function()
					craftting_process = false
				end)

			end		
		end
	end)

	RegisterNUICallback('Close', function(s)	
		MenuOn = false
		CraftingTable = {}
		CraftingType = {}
		SetNuiFocus(false, false)	
		SendNUIMessage({ 
			acton = 'closemenus',
		})
	end)

	AddEventHandler('nexz_crafting:Notification', function(reason)
		SendNUIMessage({ 
			notification = 'notification',
			text = reason,
		})
	end)

	AddEventHandler('nexz_crafting:CloseMenu', function()
		MenuOn = false
		CraftingTable = {}
		CraftingType = {}
		SetNuiFocus(false, false)	
		SendNUIMessage({ 
			acton = 'closemenus',
		})
	end)

	AddEventHandler('nexz_crafting:Crafting', function(type ,item, money, give ,count , statuscount ,position ,failitem,custom_percent_failitem ,weaponrequest ,persentremove_fail)
		ESX.TriggerServerCallback('nexz_crafting:ChackItem', function(status)	
			if status then
				SetEntityHeading(GetPlayerPed(-1), position.h)
				TriggerEvent("nexz_crafting:CloseMenu")
				MenuOn = true
				TriggerEvent("nexz_crafting:NotificationCraft", position, function(Status)
					if Status then
						MenuOn = false
						ClearPedTasksImmediately(GetPlayerPed(-1))
						TriggerServerEvent("nexz_crafting:CraftItem", type, item ,money ,give ,count ,statuscount ,failitem, custom_percent_failitem ,weaponrequest ,persentremove_fail)
					else
						MenuOn = false
						ClearPedTasksImmediately(GetPlayerPed(-1))																						
					end
				end)	
			end
		end, item)
	end)

	local CrafystatusNoft = 0
	local persent = 0

	AddEventHandler('nexz_crafting:NotificationCraft', function(position , cb)
		persent = 0
		CrafystatusNoft = true
		isAnim = false
		TriggerEvent('nexz_crafting:NotificationCraftShow', position)
		while CrafystatusNoft do
			Citizen.Wait(2)
			if not isAnim then
				local Player = PlayerPedId()
				if (DoesEntityExist(Player) and not IsEntityDead(Player)) then
					loadAnimDict(Config["Animation"][1])
					TaskPlayAnim(Player, Config["Animation"][1], Config["Animation"][2], 3.0, 1.0, -1, 31, 0, 0, 0, 0 )     
				end
				isAnim = true
			end
			persent = persent + 0.15
			if persent >= 100 then
				CrafystatusNoft = false
				cb(true)
			end		
			if IsControlJustReleased(0, Config["Keys"]["E"]) then
				CrafystatusNoft = false	
				cb(false)
			end 
		end
	end)

	AddEventHandler('nexz_crafting:NotificationCraftShow', function(position)
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)
		local distance = GetDistanceBetweenCoords(coords, position.x , position.y , position.z, true)
		while CrafystatusNoft do
			Citizen.Wait(2)
			ShowHelpNotification('<font face="'..Config["Font"]..'">กด ~r~[E] ~s~เพื่อยกเลิกการคราฟไอเทม~s~</font>')	
			DisableControlAction(0, 289)
			if distance < 5 then
				ESX.Game.Utils.DrawText3D({x = position.x, y = position.y, z = position.z+0.55}, '<font face="'..Config["Font"]..'">~y~กำลังคราฟไอเทม</font>', 0.8)
				ESX.Game.Utils.DrawText3D({x = position.x, y = position.y, z = position.z+0.4}, '<font face="'..Config["Font"]..'">กด ~g~[E] ~s~เพื่อยกเลิก</font>', 0.6)
				ESX.Game.Utils.DrawText3D({x = position.x, y = position.y, z = position.z+0.25}, '<font face="'..Config["Font"]..'">'..string.format("%.2f",persent)..'%</font>', 0.6)
			end
		end
	end)

	function loadAnimDict(dict)
		while (not HasAnimDictLoaded(dict)) do
			RequestAnimDict(dict)
			Citizen.Wait(5)
		end
	end

	AddEventHandler("onResourceStop", function(resource)
		if resource == GetCurrentResourceName() then
			for k, v in pairs(ListObject) do
				ESX.Game.DeleteObject(v)
				DeleteEntity(v)
			end
		end
	end)
	
	RegisterNetEvent(Routers["getSetJob"])
	AddEventHandler(Routers["getSetJob"], function(job)
		PlayerData.job = job
	end)

	function ShowHelpNotification(msg, thisFrame, beep, duration)
		AddTextEntry('nexz_crafting_sol', msg)
	
		if thisFrame then
			DisplayHelpTextThisFrame('nexz_crafting_sol', false)
		else
			if beep == nil then beep = true end
			BeginTextCommandDisplayHelp('nexz_crafting_sol')
			EndTextCommandDisplayHelp(0, false, beep, duration or -1)
		end
	end
end
