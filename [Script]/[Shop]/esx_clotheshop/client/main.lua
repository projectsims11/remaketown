
local hasAlreadyEnteredMarker, hasPaid, currentActionData = false, false, {}
local lastZone, currentAction, currentActionMsg
ESX = nil
local Tesing = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function OpenShopMenuSelect()
	ESX.UI.Menu.CloseAll()
	Tesing = true
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_clothes', {
		title = 'ร้านเสื้อผ้า',
		align = 'top-left',
		elements = {
		{label = 'เสื้อ', value = 'clothes'},
		{label = 'กางเกง', value = 'pants'},
		{label = 'รองเท้า', value = 'shoes'},
		{label = 'กระเป๋า', value = 'bags'},
		{label = 'สร้อยคอ', value = 'chain'},
		{label = 'นาฬิกา', value = 'watch'},



		}
	}, function(data, menu)
		if data.current.value == 'clothes' then
			OpenShopMenu()
		elseif data.current.value == 'pants' then
			OpenShopMenu2()
		elseif data.current.value == 'shoes' then
			OpenShopMenu3()
		elseif data.current.value == 'bags' then
			OpenShopMenu4()
		elseif data.current.value == 'chain' then
			OpenShopMenu5()
		elseif data.current.value == 'watch' then
			OpenShopMenu6()
		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenShopMenu()

	local _clothes = string.lower('torso'), string.lower('tshirt'), string.lower('decals')
	local restrict = {}

	restrict = { _clothes .. '_1', _clothes .. '_2', 'arms' }
	hasPaid = false

	TriggerEvent('esx_skin:openRestrictedMenu', function(data, menu)
		menu.close()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm', {
			title = _U('valid_this_purchase', Config.ClothesPrice),
			align = 'top-left',
			elements = {
				{label = _U('no'), value = 'no'},
				{label = _U('yes'), value = 'yes'}
		}}, function(data, menu)
			menu.close()

			if data.current.value == 'yes' then
				-- ESX.TriggerServerCallback('esx_clotheshop:buyClothes', function(bought)
					local bought = exports["alonedev_check"]:Money()
					if bought > Config.ClothesPrice then 
						TriggerEvent('skinchanger:getSkin', function(skin)
							skin['helmet_1'] = -1
							skin['helmet_2'] = 0
							skin['glasses_1'] = -1
							skin['glasses_2'] = 0
							skin['ears_1'] = -1
							skin['ears_2'] = 0
							skin['mask_1'] = -1
							skin['mask_2'] = 0
							TriggerServerEvent('esx_skin:save', skin)
						end)
						TriggerEvent("pNotify:SendNotification", {
							text = 'คุณซื้อ <strong class="blue-text">เสื้อ</strong> เรียบร้อยแล้ว',
							type = "information",
							timeout = 3000,
							layout = "centerRight",
							queue = "global"
						})
						TriggerServerEvent('esx_clotheshop:pay' ,Config.ClothesPrice )

						HasPaid = true

						ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'save_dressing',
						{
							title = "บันทึกชุด",
							align = 'top-left',
							elements = {
								{label = _U('no'),  value = 'no'},
								{label = _U('yes'), value = 'yes'}
							}
						}, function(data2, menu2)
							menu2.close()

							if data2.current.value == 'yes' then
								ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'outfit_name', {
									title = "ใส่ชื่อชุด (2-20 ตัวอักษร)"
								}, function(data3, menu3)

									if data3.value == nil then
										TriggerEvent("pNotify:SendNotification", {
											text = '<center><strong class="red-text">คำเตือน</strong> กรุณาใส่ชื่อชุดของคุณด้วย<center>',
											type = "information",
											timeout = 3000,
											layout = "centerRight",
											queue = "global"
										})
									else
										if utf8.len(data3.value) >= 20 then
											TriggerEvent("pNotify:SendNotification", {
												text = '<center><strong class="red-text">คำเตือน</strong> ชื่อชุดของคุณยาวเกินไป<center>',
												type = "information",
												timeout = 3000,
												layout = "centerRight",
												queue = "global"
											})
										elseif utf8.len(data3.value) < 2 then
											TriggerEvent("pNotify:SendNotification", {
												text = '<center><strong class="red-text">คำเตือน</strong> ชื่อชุดของคุณสั้นเกินไป<center>',
												type = "information",
												timeout = 3000,
												layout = "centerRight",
												queue = "global"
											})	
										else
											TriggerEvent('skinchanger:getSkin', function(skin)
												if skin.sex == 0 then
													TriggerServerEvent('esx_clotheshop:saveOutfit', '[ช] '..data3.value, skin, 'torso')
												else
													TriggerServerEvent('esx_clotheshop:saveOutfit', '[ญ] '..data3.value, skin, 'torso')
												end
											end)
											-- TriggerEvent('skinchanger:getSkin', function(skin)
											-- 	TriggerServerEvent('esx_clotheshop:saveOutfit', data3.value, skin, 'torso')
											-- end)
											menu3.close()
										end
										
									end
			
								end, function(data3, menu3)
									menu3.close()
								end)
							end
						end)

					else
						ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
							TriggerEvent('skinchanger:loadSkin', skin)
						end)

						TriggerEvent("pNotify:SendNotification", {
							text = '<center><strong class="red-text">คำเตือน</strong> คุณมีเงินไม่เพียงพอ<center>',
							type = "information",
							timeout = 3000,
							layout = "centerRight",
							queue = "global"
						})
					end
				-- end)
			elseif data.current.value == 'no' then
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
					TriggerEvent('skinchanger:loadSkin', skin)
				end)
			end

			currentAction     = 'shop_menu'
			currentActionMsg  = _U('press_menu')
			currentActionData = {}
		end, function(data, menu)
			menu.close()

			currentAction     = 'shop_menu'
			currentActionMsg  = _U('press_menu')
			currentActionData = {}
		end)

	end, function(data, menu)
		menu.close()

		currentAction     = 'shop_menu'
		currentActionMsg  = _U('press_menu')
		currentActionData = {}
	end, {
		'tshirt_1', 'tshirt_2',
		'torso_1', 'torso_2',
		'decals_1', 'decals_2',
		'arms',
		--'chain_1', 'chain_2'
	}, restrict)
end

function OpenShopMenu2()
	local _clothes = string.lower('pants')
	local restrict = {}

	restrict = { _clothes .. '_1', _clothes .. '_2' }
	hasPaid = false

	TriggerEvent('esx_skin:openRestrictedMenu', function(data, menu)
		menu.close()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm', {
			title = _U('valid_this_purchase',Config.PantsPrice),
			align = 'top-left',
			elements = {
				{label = _U('no'), value = 'no'},
				{label = _U('yes'), value = 'yes'}
		}}, function(data, menu)
			menu.close()

			if data.current.value == 'yes' then
				-- ESX.TriggerServerCallback('esx_clotheshop:buypants', function(bought)
				local bought = exports["alonedev_check"]:Money()
				print(bought)
					if bought > Config.PantsPrice then
						TriggerEvent('skinchanger:getSkin', function(skin)
							skin['helmet_1'] = -1
							skin['helmet_2'] = 0
							skin['glasses_1'] = -1
							skin['glasses_2'] = 0
							skin['ears_1'] = -1
							skin['ears_2'] = 0
							skin['mask_1'] = -1
							skin['mask_2'] = 0
							TriggerServerEvent('esx_skin:save', skin)
						end)
						TriggerServerEvent('esx_clotheshop:pay' ,Config.PantsPrice )

						HasPaid = true

						TriggerEvent("pNotify:SendNotification", {
							text = 'คุณซื้อ <strong class="blue-text">กางเกง</strong> เรียบร้อยแล้ว',
							type = "information",
							timeout = 3000,
							layout = "centerRight",
							queue = "global"
						})

						ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'save_dressing',
						{
							title = "บันทึกชุด",
							align = 'top-left',
							elements = {
								{label = _U('no'),  value = 'no'},
								{label = _U('yes'), value = 'yes'}
							}
						}, function(data2, menu2)
							menu2.close()

							if data2.current.value == 'yes' then
								ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'outfit_name', {
									title = "ใส่ชื่อชุด (2-20 ตัวอักษร)"
								}, function(data3, menu3)

									if data3.value == nil then
										TriggerEvent("pNotify:SendNotification", {
											text = '<center><strong class="red-text">คำเตือน</strong> กรุณาใส่ชื่อชุดของคุณด้วย<center>',
											type = "information",
											timeout = 3000,
											layout = "centerRight",
											queue = "global"
										})
									else
										if utf8.len(data3.value) >= 20 then
											TriggerEvent("pNotify:SendNotification", {
												text = '<center><strong class="red-text">คำเตือน</strong> ชื่อชุดของคุณยาวเกินไป<center>',
												type = "information",
												timeout = 3000,
												layout = "centerRight",
												queue = "global"
											})
										elseif utf8.len(data3.value) < 2 then
											TriggerEvent("pNotify:SendNotification", {
												text = '<center><strong class="red-text">คำเตือน</strong> ชื่อชุดของคุณสั้นเกินไป<center>',
												type = "information",
												timeout = 3000,
												layout = "centerRight",
												queue = "global"
											})	
										else
											-- TriggerEvent('skinchanger:getSkin', function(skin)
											-- 	TriggerServerEvent('esx_clotheshop:saveOutfit', data3.value, skin, 'pants')
											-- end)
											TriggerEvent('skinchanger:getSkin', function(skin)
												if skin.sex == 0 then
													TriggerServerEvent('esx_clotheshop:saveOutfit', '[ช] '..data3.value, skin, 'pants')
												else
													TriggerServerEvent('esx_clotheshop:saveOutfit', '[ญ] '..data3.value, skin, 'pants')
												end
											end)
											menu3.close()
										end
										
									end
			
								end, function(data3, menu3)
									menu3.close()
								end)
							end
						end)

					else
						ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
							TriggerEvent('skinchanger:loadSkin', skin)
						end)

						TriggerEvent("pNotify:SendNotification", {
							text = '<center><strong class="red-text">คำเตือน</strong> คุณมีเงินไม่เพียงพอ<center>',
							type = "information",
							timeout = 3000,
							layout = "centerRight",
							queue = "global"
						})
					end
				-- end)
			elseif data.current.value == 'no' then
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
					TriggerEvent('skinchanger:loadSkin', skin)
				end)
			end

			currentAction     = 'shop_menu'
			currentActionMsg  = _U('press_menu')
			currentActionData = {}
		end, function(data, menu)
			menu.close()

			currentAction     = 'shop_menu'
			currentActionMsg  = _U('press_menu')
			currentActionData = {}
		end)

	end, function(data, menu)
		menu.close()

		currentAction     = 'shop_menu'
		currentActionMsg  = _U('press_menu')
		currentActionData = {}
	end, {
		'pants_1', 'pants_2'
	}, restrict)
end

function OpenShopMenu3()
	local _clothes = string.lower('shoes')
	local restrict = {}

	restrict = { _clothes .. '_1', _clothes .. '_2' }
	hasPaid = false

	TriggerEvent('esx_skin:openRestrictedMenu', function(data, menu)
		menu.close()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm', {
			title = _U('valid_this_purchase',Config.ShoesPrice),
			align = 'top-left',
			elements = {
				{label = _U('no'), value = 'no'},
				{label = _U('yes'), value = 'yes'}
		}}, function(data, menu)
			menu.close()

			if data.current.value == 'yes' then
				-- ESX.TriggerServerCallback('esx_clotheshop:buyshoes', function(bought)
				local bought = exports["alonedev_check"]:Money()
				print(bought)
					if bought > Config.ShoesPrice then
						TriggerEvent('skinchanger:getSkin', function(skin)
							skin['helmet_1'] = -1
							skin['helmet_2'] = 0
							skin['glasses_1'] = -1
							skin['glasses_2'] = 0
							skin['ears_1'] = -1
							skin['ears_2'] = 0
							skin['mask_1'] = -1
							skin['mask_2'] = 0
							TriggerServerEvent('esx_skin:save', skin)
						end)

						TriggerEvent("pNotify:SendNotification", {
							text = 'คุณซื้อ <strong class="blue-text">รองเท้า</strong> เรียบร้อยแล้ว',
							type = "information",
							timeout = 3000,
							layout = "centerRight",
							queue = "global"
						})
						TriggerServerEvent('esx_clotheshop:pay' ,Config.ShoesPrice )

						HasPaid = true

						ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'save_dressing',
						{
							title = "บันทึกชุด",
							align = 'top-left',
							elements = {
								{label = _U('no'),  value = 'no'},
								{label = _U('yes'), value = 'yes'}
							}
						}, function(data2, menu2)
							menu2.close()

							if data2.current.value == 'yes' then
								ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'outfit_name', {
									title = "ใส่ชื่อชุด (2-20 ตัวอักษร)"
								}, function(data3, menu3)

									if data3.value == nil then
										TriggerEvent("pNotify:SendNotification", {
											text = '<center><strong class="red-text">คำเตือน</strong> กรุณาใส่ชื่อชุดของคุณด้วย<center>',
											type = "information",
											timeout = 3000,
											layout = "centerRight",
											queue = "global"
										})
									else
										if utf8.len(data3.value) >= 20 then
											TriggerEvent("pNotify:SendNotification", {
												text = '<center><strong class="red-text">คำเตือน</strong> ชื่อชุดของคุณยาวเกินไป<center>',
												type = "information",
												timeout = 3000,
												layout = "centerRight",
												queue = "global"
											})
										elseif utf8.len(data3.value) < 2 then
											TriggerEvent("pNotify:SendNotification", {
												text = '<center><strong class="red-text">คำเตือน</strong> ชื่อชุดของคุณสั้นเกินไป<center>',
												type = "information",
												timeout = 3000,
												layout = "centerRight",
												queue = "global"
											})	
										else
											-- TriggerEvent('skinchanger:getSkin', function(skin)
											-- 	TriggerServerEvent('esx_clotheshop:saveOutfit', data3.value, skin, 'shoes')
											-- end)
											TriggerEvent('skinchanger:getSkin', function(skin)
												if skin.sex == 0 then
													TriggerServerEvent('esx_clotheshop:saveOutfit', '[ช] '..data3.value, skin, 'shoes')
												else
													TriggerServerEvent('esx_clotheshop:saveOutfit', '[ญ] '..data3.value, skin, 'shoes')
												end
											end)
											menu3.close()
										end
										
									end
			
								end, function(data3, menu3)
									menu3.close()
								end)
							end
						end)

					else
						-- ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
						local skin = exports['esx_skin']:requestCurrectSkin()
							TriggerEvent('skinchanger:loadSkin', skin)
						-- end)

						TriggerEvent("pNotify:SendNotification", {
							text = '<center><strong class="red-text">คำเตือน</strong> คุณมีเงินไม่เพียงพอ<center>',
							type = "information",
							timeout = 3000,
							layout = "centerRight",
							queue = "global"
						})
					end
				-- end)
			elseif data.current.value == 'no' then
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
					TriggerEvent('skinchanger:loadSkin', skin)
				end)
			end

			currentAction     = 'shop_menu'
			currentActionMsg  = _U('press_menu')
			currentActionData = {}
		end, function(data, menu)
			menu.close()

			currentAction     = 'shop_menu'
			currentActionMsg  = _U('press_menu')
			currentActionData = {}
		end)

	end, function(data, menu)
		menu.close()

		currentAction     = 'shop_menu'
		currentActionMsg  = _U('press_menu')
		currentActionData = {}
	end, {
		'shoes_1', 'shoes_2'
	},restrict)
end




function OpenShopMenu4()
	local _clothes = string.lower('bags')
	local restrict = {}

	restrict = { _clothes .. '_1', _clothes .. '_2' }
	hasPaid = false

	TriggerEvent('esx_skin:openRestrictedMenu', function(data, menu)
		menu.close()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm', {
			title = _U('valid_this_purchase',Config.BagsPrice),
			align = 'top-left',
			elements = {
				{label = _U('no'), value = 'no'},
				{label = _U('yes'), value = 'yes'}
		}}, function(data, menu)
			menu.close()

			if data.current.value == 'yes' then
				local bought = exports["alonedev_check"]:Money()
				print(bought)
				-- ESX.TriggerServerCallback('esx_clotheshop:buybags', function(bought)
					if bought > Config.BagsPrice then
						TriggerEvent('skinchanger:getSkin', function(skin)
							skin['helmet_1'] = -1
							skin['helmet_2'] = 0
							skin['glasses_1'] = -1
							skin['glasses_2'] = 0
							skin['ears_1'] = -1
							skin['ears_2'] = 0
							skin['mask_1'] = -1
							skin['mask_2'] = 0
							TriggerServerEvent('esx_skin:save', skin)
						end)

						TriggerEvent("pNotify:SendNotification", {
							text = 'คุณซื้อ <strong class="blue-text">กระเป๋า</strong> เรียบร้อยแล้ว',
							type = "information",
							timeout = 3000,
							layout = "centerRight",
							queue = "global"
						})
						TriggerServerEvent('esx_clotheshop:pay' ,Config.BagsPrice )

						HasPaid = true

						ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'save_dressing',
						{
							title = "บันทึกชุด",
							align = 'top-left',
							elements = {
								{label = _U('no'),  value = 'no'},
								{label = _U('yes'), value = 'yes'}
							}
						}, function(data2, menu2)
							menu2.close()

							if data2.current.value == 'yes' then
								ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'outfit_name', {
									title = "ใส่ชื่อชุด (2-20 ตัวอักษร)"
								}, function(data3, menu3)

									if data3.value == nil then
										TriggerEvent("pNotify:SendNotification", {
											text = '<center><strong class="red-text">คำเตือน</strong> กรุณาใส่ชื่อชุดของคุณด้วย<center>',
											type = "information",
											timeout = 3000,
											layout = "centerRight",
											queue = "global"
										})
									else
										if utf8.len(data3.value) >= 20 then
											TriggerEvent("pNotify:SendNotification", {
												text = '<center><strong class="red-text">คำเตือน</strong> ชื่อชุดของคุณยาวเกินไป<center>',
												type = "information",
												timeout = 3000,
												layout = "centerRight",
												queue = "global"
											})
										elseif utf8.len(data3.value) < 2 then
											TriggerEvent("pNotify:SendNotification", {
												text = '<center><strong class="red-text">คำเตือน</strong> ชื่อชุดของคุณสั้นเกินไป<center>',
												type = "information",
												timeout = 3000,
												layout = "centerRight",
												queue = "global"
											})	
										else
											-- TriggerEvent('skinchanger:getSkin', function(skin)
											-- 	TriggerServerEvent('esx_clotheshop:saveOutfit', data3.value, skin, 'bags')
											-- end)
											TriggerEvent('skinchanger:getSkin', function(skin)
												if skin.sex == 0 then
													TriggerServerEvent('esx_clotheshop:saveOutfit', '[ช] '..data3.value, skin, 'bags')
												else
													TriggerServerEvent('esx_clotheshop:saveOutfit', '[ญ] '..data3.value, skin, 'bags')
												end
											end)
											menu3.close()
										end
										
									end
			
								end, function(data3, menu3)
									menu3.close()
								end)
							end
						end)

					else
						ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
							TriggerEvent('skinchanger:loadSkin', skin)
						end)

						TriggerEvent("pNotify:SendNotification", {
							text = '<center><strong class="red-text">คำเตือน</strong> คุณมีเงินไม่เพียงพอ<center>',
							type = "information",
							timeout = 3000,
							layout = "centerRight",
							queue = "global"
						})
					end
				-- end)
			elseif data.current.value == 'no' then
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
					TriggerEvent('skinchanger:loadSkin', skin)
				end)
			end

			currentAction     = 'shop_menu'
			currentActionMsg  = _U('press_menu')
			currentActionData = {}
		end, function(data, menu)
			menu.close()

			currentAction     = 'shop_menu'
			currentActionMsg  = _U('press_menu')
			currentActionData = {}
		end)

	end, function(data, menu)
		menu.close()

		currentAction     = 'shop_menu'
		currentActionMsg  = _U('press_menu')
		currentActionData = {}
	end, {
		'bags_1', 'bags_2'
	},restrict)
end




function OpenShopMenu5()
	local _clothes = string.lower('chain')
	local restrict = {}

	restrict = { _clothes .. '_1', _clothes .. '_2' }
	hasPaid = false

	TriggerEvent('esx_skin:openRestrictedMenu', function(data, menu)
		menu.close()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm', {
			title = _U('valid_this_purchase',Config.ChainPrice),
			align = 'top-left',
			elements = {
				{label = _U('no'), value = 'no'},
				{label = _U('yes'), value = 'yes'}
		}}, function(data, menu)
			menu.close()

			if data.current.value == 'yes' then
				local bought = exports["alonedev_check"]:Money()
				print(bought)
				-- ESX.TriggerServerCallback('esx_clotheshop:buychain', function(bought)
					if bought > Config.ChainPrice then
						TriggerEvent('skinchanger:getSkin', function(skin)
							skin['helmet_1'] = -1
							skin['helmet_2'] = 0
							skin['glasses_1'] = -1
							skin['glasses_2'] = 0
							skin['ears_1'] = -1
							skin['ears_2'] = 0
							skin['mask_1'] = -1
							skin['mask_2'] = 0
							TriggerServerEvent('esx_skin:save', skin)
						end)

						TriggerEvent("pNotify:SendNotification", {
							text = 'คุณซื้อ <strong class="blue-text">สร้อยคอ</strong> เรียบร้อยแล้ว',
							type = "information",
							timeout = 3000,
							layout = "centerRight",
							queue = "global"
						})
						TriggerServerEvent('esx_clotheshop:pay' ,Config.ChainPrice )

						HasPaid = true

						ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'save_dressing',
						{
							title = "บันทึกชุด",
							align = 'top-left',
							elements = {
								{label = _U('no'),  value = 'no'},
								{label = _U('yes'), value = 'yes'}
							}
						}, function(data2, menu2)
							menu2.close()

							if data2.current.value == 'yes' then
								ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'outfit_name', {
									title = "ใส่ชื่อชุด (2-20 ตัวอักษร)"
								}, function(data3, menu3)

									if data3.value == nil then
										TriggerEvent("pNotify:SendNotification", {
											text = '<center><strong class="red-text">คำเตือน</strong> กรุณาใส่ชื่อชุดของคุณด้วย<center>',
											type = "information",
											timeout = 3000,
											layout = "centerRight",
											queue = "global"
										})
									else
										if utf8.len(data3.value) >= 20 then
											TriggerEvent("pNotify:SendNotification", {
												text = '<center><strong class="red-text">คำเตือน</strong> ชื่อชุดของคุณยาวเกินไป<center>',
												type = "information",
												timeout = 3000,
												layout = "centerRight",
												queue = "global"
											})
										elseif utf8.len(data3.value) < 2 then
											TriggerEvent("pNotify:SendNotification", {
												text = '<center><strong class="red-text">คำเตือน</strong> ชื่อชุดของคุณสั้นเกินไป<center>',
												type = "information",
												timeout = 3000,
												layout = "centerRight",
												queue = "global"
											})	
										else
											-- TriggerEvent('skinchanger:getSkin', function(skin)
											-- 	TriggerServerEvent('esx_clotheshop:saveOutfit', data3.value, skin, 'chain')
											-- end)
											TriggerEvent('skinchanger:getSkin', function(skin)
												if skin.sex == 0 then
													TriggerServerEvent('esx_clotheshop:saveOutfit', '[ช] '..data3.value, skin, 'chain')
												else
													TriggerServerEvent('esx_clotheshop:saveOutfit', '[ญ] '..data3.value, skin, 'chain')
												end
											end)
											menu3.close()
										end
										
									end
			
								end, function(data3, menu3)
									menu3.close()
								end)
							end
						end)

					else
						ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
							TriggerEvent('skinchanger:loadSkin', skin)
						end)

						TriggerEvent("pNotify:SendNotification", {
							text = '<center><strong class="red-text">คำเตือน</strong> คุณมีเงินไม่เพียงพอ<center>',
							type = "information",
							timeout = 3000,
							layout = "centerRight",
							queue = "global"
						})
					end
				-- end)
			elseif data.current.value == 'no' then
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
					TriggerEvent('skinchanger:loadSkin', skin)
				end)
			end

			currentAction     = 'shop_menu'
			currentActionMsg  = _U('press_menu')
			currentActionData = {}
		end, function(data, menu)
			menu.close()

			currentAction     = 'shop_menu'
			currentActionMsg  = _U('press_menu')
			currentActionData = {}
		end)

	end, function(data, menu)
		menu.close()

		currentAction     = 'shop_menu'
		currentActionMsg  = _U('press_menu')
		currentActionData = {}
	end, {
		'chain_1', 'chain_2'
	},restrict)
end






function OpenShopMenu6()
	local _clothes = string.lower('watch')
	local restrict = {}

	restrict = { _clothes .. '_1', _clothes .. '_2' }
	hasPaid = false

	TriggerEvent('esx_skin:openRestrictedMenu', function(data, menu)
		menu.close()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm', {
			title = _U('valid_this_purchase',Config.WatchPrice),
			align = 'top-left',
			elements = {
				{label = _U('no'), value = 'no'},
				{label = _U('yes'), value = 'yes'}
		}}, function(data, menu)
			menu.close()

			if data.current.value == 'yes' then
				local bought = exports["alonedev_check"]:Money()
				print(bought)
				-- ESX.TriggerServerCallback('esx_clotheshop:buywatch', function(bought)
					if bought > Config.WatchPrice then
						TriggerEvent('skinchanger:getSkin', function(skin)
							skin['helmet_1'] = -1
							skin['helmet_2'] = 0
							skin['glasses_1'] = -1
							skin['glasses_2'] = 0
							skin['ears_1'] = -1
							skin['ears_2'] = 0
							skin['mask_1'] = -1
							skin['mask_2'] = 0
							TriggerServerEvent('esx_skin:save', skin)
						end)

						TriggerEvent("pNotify:SendNotification", {
							text = 'คุณซื้อ <strong class="blue-text">นาฬิกา</strong> เรียบร้อยแล้ว',
							type = "information",
							timeout = 3000,
							layout = "centerRight",
							queue = "global"
						})
						TriggerServerEvent('esx_clotheshop:pay' ,Config.WatchPrice )

						HasPaid = true

						ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'save_dressing',
						{
							title = "บันทึกชุด",
							align = 'top-left',
							elements = {
								{label = _U('no'),  value = 'no'},
								{label = _U('yes'), value = 'yes'}
							}
						}, function(data2, menu2)
							menu2.close()

							if data2.current.value == 'yes' then
								ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'outfit_name', {
									title = "ใส่ชื่อชุด (2-20 ตัวอักษร)"
								}, function(data3, menu3)

									if data3.value == nil then
										TriggerEvent("pNotify:SendNotification", {
											text = '<center><strong class="red-text">คำเตือน</strong> กรุณาใส่ชื่อชุดของคุณด้วย<center>',
											type = "information",
											timeout = 3000,
											layout = "centerRight",
											queue = "global"
										})
									else
										if utf8.len(data3.value) >= 20 then
											TriggerEvent("pNotify:SendNotification", {
												text = '<center><strong class="red-text">คำเตือน</strong> ชื่อชุดของคุณยาวเกินไป<center>',
												type = "information",
												timeout = 3000,
												layout = "centerRight",
												queue = "global"
											})
										elseif utf8.len(data3.value) < 2 then
											TriggerEvent("pNotify:SendNotification", {
												text = '<center><strong class="red-text">คำเตือน</strong> ชื่อชุดของคุณสั้นเกินไป<center>',
												type = "information",
												timeout = 3000,
												layout = "centerRight",
												queue = "global"
											})	
										else
											-- TriggerEvent('skinchanger:getSkin', function(skin)
											-- 	TriggerServerEvent('esx_clotheshop:saveOutfit', data3.value, skin, 'watch')
											-- end)
											TriggerEvent('skinchanger:getSkin', function(skin)
												if skin.sex == 0 then
													TriggerServerEvent('esx_clotheshop:saveOutfit', '[ช] '..data3.value, skin, 'watch')
												else
													TriggerServerEvent('esx_clotheshop:saveOutfit', '[ญ] '..data3.value, skin, 'watch')
												end
											end)
											menu3.close()
										end
										
									end
			
								end, function(data3, menu3)
									menu3.close()
								end)
							end
						end)

					else
						ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
							TriggerEvent('skinchanger:loadSkin', skin)
						end)

						TriggerEvent("pNotify:SendNotification", {
							text = '<center><strong class="red-text">คำเตือน</strong> คุณมีเงินไม่เพียงพอ<center>',
							type = "information",
							timeout = 3000,
							layout = "centerRight",
							queue = "global"
						})
					end
				-- end)
			elseif data.current.value == 'no' then
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
					TriggerEvent('skinchanger:loadSkin', skin)
				end)
			end

			currentAction     = 'shop_menu'
			currentActionMsg  = _U('press_menu')
			currentActionData = {}
		end, function(data, menu)
			menu.close()

			currentAction     = 'shop_menu'
			currentActionMsg  = _U('press_menu')
			currentActionData = {}
		end)

	end, function(data, menu)
		menu.close()

		currentAction     = 'shop_menu'
		currentActionMsg  = _U('press_menu')
		currentActionData = {}
	end, {
		'watches_1', 'watches_2'
	},restrict)
end





AddEventHandler('esx_clotheshop:hasEnteredMarker', function(zone)
	currentAction     = 'shop_menu'
	currentActionMsg  = _U('press_menu')
	currentActionData = {}
end)

AddEventHandler('esx_clotheshop:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	currentAction = nil

	-- if not hasPaid then
	-- 	--TriggerEvent('esx_skin:getLastSkin', function(skin) -- Error Fix Shelterx
	-- 	TriggerEvent('esx_skin:loadSkin', function(skin)

	-- 		TriggerEvent('skinchanger:loadSkin', skin)
	-- 	end)
	-- end
	if Tesing == true then
		ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
			TriggerEvent('skinchanger:loadSkin', skin)
		end)
		Tesing = false
	end
end)

-- Create Blips
Citizen.CreateThread(function()
	for k,v in ipairs(Config.Shops) do
		local blip = AddBlipForCoord(v)

		SetBlipSprite (blip, 73)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.7)
		SetBlipColour (blip, 81)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(_U('clothes'))
		EndTextCommandSetBlipName(blip)
	end
end)

-- Enter / Exit marker events & draw markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerCoords, isInMarker, currentZone, letSleep = GetEntityCoords(GetPlayerPed(-1)), false, nil, true

		for k,v in pairs(Config.Shops) do
			local distance = #(playerCoords - v)

			if distance < Config.DrawDistance then
				letSleep = false
				DrawMarker(Config.MarkerType, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, nil, nil, false)

				if distance < Config.MarkerSize.x then
					isInMarker, currentZone = true, k
				end
			end
		end

		if (isInMarker and not hasAlreadyEnteredMarker) or (isInMarker and lastZone ~= currentZone) then
			hasAlreadyEnteredMarker, lastZone = true, currentZone
			TriggerEvent('esx_clotheshop:hasEnteredMarker', currentZone)
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('esx_clotheshop:hasExitedMarker', lastZone)
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if currentAction then
			exports["Fewthz_TextUI"]:ShowHelpNotification(currentActionMsg)

			if IsControlJustReleased(0, 38) then
				if currentAction == 'shop_menu' then
					OpenShopMenuSelect()
				end

				currentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)