
--[[
	Author: CanonX2
	Special: Fivem Server
    Discord : https://discord.gg/Ns9jcjvuxc
--]]

ConfigSv = {}

ConfigSv["Routers"] = {
	["getSharedObject"] = "esx:getSharedObject",		
	["getNotify"] = "mythic_notify:client:SendAlert",
    ["getSetJob"] = "esx:setJob",
}

ConfigSv["License_Key"] = "#" -- หากเปลี่ยนหรือลบทิ้งจะไม่สามารถใช้งานได้

ConfigSv["Extended"] = "1.2" -- 1.1 หรือ 1.2 เท่านั้น

ConfigSv["NoItemLimit"] = false -- ไม่ตรวจว่ามีของในตัวอยู่เท่าไร จะสามารถคราฟของเกินจำนวนได้

ConfigSv["Craft_Table_Sound_Distance"] = 50.0 -- ระยะสูงสุดที่จะได้ยินเสียงหากตั้งค่าเสียงไว้
ConfigSv["Craft_Table_Sound"] = { -- ตารางเสียง กรุณาลงใน html/sound และใส่ใน resource ด้วยก่อนใช้งาน (รองรับ ogg อย่างเดียว) 
	["Success"] = "success", -- ชื่อไฟล์เสียงเมื่อตอนคราฟเสร็จ เช่น success.ogg พิมพืแค่ success
	["Failed"] = "failed" -- ชื่อไฟล์เสียงเมื่อตอนล้มเหลว
}

ConfigSv["DiscordCraftingLog"] = true -- หากปรับเป็น false จะเป็นปิดการใช่งานlogของระบบ ต้องนำ EventของระบบLogอื่นมาวางในฟังชั้น ConfigSv["Other_Discord_LogEvent"]

ConfigSv["Craft_Discord_Log"] = { -- Discord Webhook 
	["Item"] = "#", -- ใส่ webhook สำหรับให้ข้อความไปออกเมื่อคราฟของได้
	["Weapon"] = "#" -- ใส่ webhook สำหรับให้ข้อความไปออกเมื่อคราฟปืนได้
}

ConfigSv["Other_Discord_LogEvent"] = function(player ,source ,status ,item ,count ,percent, percent_fail, type)
	if type == "item_standard" then
		local sendToDiscord = '' .. player.name .. ' ได้คราฟ ' .. item .. ' จำนวน ' .. count .. ' เปอร์เซน ' .. percent ..''
		TriggerEvent('azael_discordlogs:sendToDiscord', 'CraftingItem', sendToDiscord, source, '^2')
	elseif type == "item_weapon" then 
		local sendToDiscord = '' .. player.name .. ' ได้คราฟ ' .. item .. ' จำนวน ' .. count .. ' เปอร์เซน ' .. percent ..''
		TriggerEvent('azael_discordlogs:sendToDiscord', 'CraftingWeapon', sendToDiscord, source, '^2')
	end
end

--[[
	[+]ตัวอย่างการตั้งค่าในการคราฟไอเทม
	[+]หมวน (cost) หากใช้ Extended เวอชั้น 1.1 ต้องต้องเป็น cash หาก 1.2 จะใช้เป็น money
	[+]เพิ่มเติมสำรหับการตั้งการคราฟที่ต้องมีอาวุธในตัวถึงจะคราฟได้ ให้ตั้งชื่ออาวุธในส่วน (weaponrequest) 
	[+]หากตั้งเงื่นไขต้องการอาวุธแล้วต้องการให้อาวุธนั้นหายไปหลักจากการคราฟ (removeweaponaftercraft) ให้เปิดในสวนนี้เป็นจริง (true/false)
	[+]ฟังชั้นที่เพิ่มขึ้นมาสำหรับอัพเกรดอาวุธ (persentremove_fail) ในส่วน (protect_follw_black) คือไอเทมป้องการคราฟไอเทมผิดพลาดแล้วอาวุธหายไป หรือ ไอเทมกันแตกเวลาอัพเกรด
	[+]ฟั้งชั้น (follw_black) คืออาวุธที่จะยอนเลเวลกลับเวลาอัพเกรดไม่สำเร็จ (persent_fall) การตั้งเปอร์เซ็นในการอัพเกรดอาวุธ
	[+]=====================================================================================================[+]
		item = "WEAPON_POOLCUE_LV3",
		fail_chance = 85,
		custom_percent_failitem = 0,
		fail_item = {
			["exps"] = 50, 
		}, 			
		cost = {
			["money"] = 5000, 
			["black_money"] = 4000, 
		},				
		blueprint = {
			["blueprint_poolcue_1"] = 2,
			["diamond_darkbule"] = 2,
			["diamond_yellow"] = 1,	
			["diamond_red"] = 1,	
			["steel_bar"] = 30,
			["pro_wood"] = 40,	
			["exps"] = 600,				
		},
		weaponrequest = "WEAPON_POOLCUE_LV2",
		removeweaponaftercraft = true,
		persentremove_fail = {
			protect_follw_black = "unbrokencard",
			follw_black = "WEAPON_POOLCUE_LV1",
			persent_fall = 30,
		},
		equipment = { 
			["goldencard"] = true
		},
	[+]=====================================================================================================[+]
	[+]หากชอบในระบบโต๊ะคราฟของเราหรือมีฟังชั้นเพิ่มเติมสามารถแนะนำหรือแจ้งทางเราได้ หรือ จะอุดหนุนหรือขอคีย์เข้าการใช้งาน
	[+]ติดต่อได้ที่ Discord : https://discord.gg/rsqCwW4jMX ฝากแชร์ต่อกันด้วยนะครับจะได้มีการอัพเดทใหม่ๆมาเรื่อยๆ
--]]

ConfigSv["Category"] = {	
	[1] = {
		name = "วัตถุดิบชำนาญการ 70%",	
         list = {		
		
			{
				item = "card_aa",
				fail_chance = 30,
				fail_item = {
				--	["exps"] = 50, 
				}, 			
				cost = {
					--["black_money"] = 3500, 
					["money"] = 3000, 
				},				
				blueprint = {
					["watermelon_parts"] = 5,
					["rice_parts"] = 5,
					["shell_parts"] = 5,
					["wood_parts"] = 5,
					["oil_parts"] = 5,
					["bamboo_parts"] = 5,
				},
			},			
			{
				item = "card_a",
				fail_chance = 30,
				fail_item = {
				--	["exps"] = 50, 
				}, 			
				cost = {
				--	["black_money"] = 3500, 
					["money"] = 3000, 
				},				
				blueprint = {
					["orange_parts"] = 5,
					["strawberry_parts"] = 5,
					["shell_parts"] = 5,
					["stone_parts"] = 5,
					["oil_parts"] = 5,
				},
			},	
		}
	},
	[2] = {
		name = "วัตถุดิบชำนาญการ 80%",	
         list = {		
		
			{
				item = "diamond_p",
				fail_chance = 20,
				fail_item = {
				--	["exps"] = 50, 
				}, 			
				cost = {
					--["black_money"] = 3500, 
					["money"] = 1000, 
				},				
				blueprint = {
					["crystalgreen"] = 10,
					["crystalblue"] = 10,
					["crystalwhite"] = 10,
					["diamondblack"] = 10,
				},
			},			
			{
				item = "diamond_r",
				fail_chance = 20,
				fail_item = {
				--	["exps"] = 50, 
				}, 			
				cost = {
				--	["black_money"] = 3500, 
					["money"] = 1000, 
				},				
				blueprint = {
					["crystalgreen"] = 10,
					["crystalblue"] = 10,
					["crystalwhite"] = 10,
					["diamondwhite"] = 10,
				},
			},	
		}
	},
	[3] = {
		name = "หมวดทั่วไป",	
         list = {		
		
			{
				item = "license_vault",
				fail_chance = 0,
				fail_item = {
				--	["exps"] = 50, 
				}, 			
				cost = {
					["money"] = 100000, 
				},				
				blueprint = {
				},
			},			
			{
				item = "card_weapon",
				fail_chance = 0,
				fail_item = {
				--	["exps"] = 50, 
				}, 			
				cost = {
					["black_money"] = 2000, 
					["money"] = 3000, 
				},				
				blueprint = {
					["cement"] = 10,
					["wire"] = 10,
					["copper"] = 50,
					["gold"] = 5,
					["diamond_p"] = 5,
				},
			},	
			{
				item = "card_work",
				fail_chance = 0,
				fail_item = {
				--	["exps"] = 50, 
				}, 			
				cost = {
					["money"] = 2500, 
				},				
				blueprint = {
				},
			},
			{
				item = "card_unweapon",
				fail_chance = 0,
				fail_item = {
				--	["exps"] = 50, 
				}, 			
				cost = {
					["money"] = 500000, 
				},				
				blueprint = {
					["diamond_r"] = 5,
					["cement"] = 20,
					["wire"] = 20,
					["diamond_p"] = 5,
				},
			},
		}
	},
	[4] = {
		name = "หมวดบลูปริ้น",	
    	list = {		

			{
				item = "blue_a",
				fail_chance = 15,
				fail_item = {
				--["exps"] = 50, 
				}, 			
				cost = {
				--	["black_money"] = 1500, 
					["money"] = 5000, 
				},				
				blueprint = {
					["card_aa"] = 1,
					["card_a"] = 5,
				},
			},					
			 {
				item = "blue_b",
				fail_chance = 15,
				fail_item = {
				--["exps"] = 50, 
				}, 			
				cost = {
				--	["black_money"] = 1500, 
					["money"] = 5000, 
				},				
				blueprint = {
				    ["card_aa"] = 1,
					["card_a"] = 5,
				},
			},	
			 {
				item = "blue_c",
				fail_chance = 15,
				fail_item = {
				--["exps"] = 50, 
				}, 			
				cost = {
			--		["black_money"] = 1500, 
					["money"] = 5000, 
				},				
				blueprint = {
				    ["card_aa"] = 1,
					["card_a"] = 5,
				},
			},	
	    }
	},
	[5] = {
		name = "อาวุธ A",
		list = {
        	{
				item = "WEAPON_BAT",
				fail_chance = 15,
				fail_item = {
					["token_fail"] = 1, 
				}, 			
				cost = {
					--["money"] = 7500, 
					["black_money"] = 1500, 
				},				
				blueprint = {
					["diamond_r"] = 3,
					["copper"] = 25,
					["cement"] = 10,
					["afk"] = 50,
					["wire"] = 10,
					["gold"] = 15,
					["iron"] = 20,
					["diamond_p"] = 3,
				},
				equipment = { 
					["card_weapon"] = true, -- => true คือ เปิด false คือปิด
					["blue_a"] = true, -- => true คือ เปิด false คือปิด
				},				
			},	
			{
				item = "WEAPON_POOLCUE",
				fail_chance = 15,
				fail_item = {
					["token_fail"] = 1, 
				}, 			
				cost = {
					--["money"] = 7500, 
					["black_money"] = 1500, 
				},				
				blueprint = {
					["diamond_r"] = 3,
					["copper"] = 25,
					["cement"] = 10,
					["afk"] = 50,
					["wire"] = 10,
					["gold"] = 15,
					["iron"] = 20,
					["diamond_p"] = 3,
				},
				equipment = { 
					["card_weapon"] = true, -- => true คือ เปิด false คือปิด
					["blue_a"] = true, -- => true คือ เปิด false คือปิด
				},				
			},	
			{
				item = "WEAPON_GOLFCLUB",
				fail_chance = 15,
				fail_item = {
					["token_fail"] = 1, 
				}, 			
				cost = {
					--["money"] = 7500, 
					["black_money"] = 1500, 
				},				
				blueprint = {
					["diamond_r"] = 3,
					["copper"] = 25,
					["cement"] = 10,
					["afk"] = 50,
					["wire"] = 10,
					["gold"] = 15,
					["iron"] = 20,
					["diamond_p"] = 3,
				},
				equipment = { 
					["card_weapon"] = true, -- => true คือ เปิด false คือปิด
					["blue_a"] = true, -- => true คือ เปิด false คือปิด
				},				
			},	
			}
		},	
		[6] = {
			name = "อาวุธ B",
			list = {
				{
					item = "WEAPON_BOTTLE",
					fail_chance = 15,
					fail_item = {
						["token_fail"] = 1, 
					}, 			
					cost = {
						--["money"] = 7500, 
						["black_money"] = 3000, 
					},				
					blueprint = {
						["diamond_r"] = 10,
						["copper"] = 20,
						["cement"] = 25,
						["afk"] = 100,
						["wire"] = 25,
						["gold"] = 20,
						["iron"] = 20,
						["diamond_p"] = 10,
					},
					equipment = { 
						["card_weapon"] = true, -- => true คือ เปิด false คือปิด
						["blue_b"] = true, -- => true คือ เปิด false คือปิด
					},				
				},		
				}
			},	
		[7] = {
		name = "อาวุธการันตี",
		list = {
			{
				item = "WEAPON_BAT",
				fail_chance = 0,
				fail_item = {
				--	["exps"] = 500, 
				}, 			
				cost = {
				["money"] = 20000, 
				--["black_money"] = 2000, 
				},				
				blueprint = {
					["token_fail"] = 500,			
				},
				equipment = { 
					--["card_weapon"] = true
				},				
			},	
			{
				item = "WEAPON_GOLFCLUB",
				fail_chance = 0,
				fail_item = {
				--	["exps"] = 500, 
				}, 			
				cost = {
				["money"] = 20000, 
				--["black_money"] = 2000, 
				},				
				blueprint = {
					["token_fail"] = 500,			
				},
				equipment = { 
					--["card_weapon"] = true
				},				
			},	
			 {
				item = "WEAPON_BOTTLE",
				fail_chance = 0,
				fail_item = {
				--	["exps"] = 500, 
				}, 			
				cost = {
				["money"] = 25000, 
				--["black_money"] = 2000, 
				},				
				blueprint = {
					["token_fail"] = 600,			
				},
				equipment = { 
					--["card_weapon"] = true
				},				
			},	
			 {
				item = "WEAPON_POOLCUE",
				fail_chance = 0,
				fail_item = {
				--	["exps"] = 500, 
				}, 			
				cost = {
				["money"] = 30000, 
				--["black_money"] = 2000, 
				},				
				blueprint = {
					["token_fail"] = 800,			
				},
				equipment = { 
					--["card_weapon"] = true
				},				
			},	
			 {
				item = "WEAPON_SWITCHBLADE",
				fail_chance = 0,
				fail_item = {
				--	["exps"] = 500, 
				}, 			
				cost = {
				["money"] = 30000, 
				--["black_money"] = 2000, 
				},				
				blueprint = {
					["token_fail"] = 800,			
				},
				equipment = { 
					--["card_weapon"] = true
				},				
			},	
		}
	},	
	[8] = {
		name = "ทำอาหาร",
		list = {
			{
				item = "bento1",
				fail_chance = 0,
				fail_item = {
				--	["exps"] = 500, 
				}, 			
				cost = {
				["money"] = 100, 
				--["black_money"] = 2000, 
				},				
				blueprint = {
					["water"] = 5,
					["copper"] = 5,
					["gold"] = 5,
					["diamond"] = 5,
					["iron"] = 5,
					["fixkit"] = 5,
					["fixtool"] = 5,
					["marijuana"] = 5,
					["cannabis"] = 3,
					["card_work"] = 3,
					["carokit"] = 3,
					["carotool"] = 3,
					["clothe"] = 3,
				},
				equipment = { 
					--["card_weapon"] = true
				},				
			},	
			{
				item = "bento2",
				fail_chance = 0,
				fail_item = {
				--	["exps"] = 500, 
				}, 			
				cost = {
				["money"] = 100, 
				--["black_money"] = 2000, 
				},				
				blueprint = {
					["rice_pro"] = 5,
					["mushroom_b"] = 5,
					["orangewater_b"] = 5,
					["Pig_a"] = 3,
					["lfish"] = 3,
				},
				equipment = { 
					--["card_weapon"] = true
				},				
			},	
			{
				item = "bento3",
				fail_chance = 0,
				fail_item = {
				--	["exps"] = 500, 
				}, 			
				cost = {
				["money"] = 100, 
				--["black_money"] = 2000, 
				},				
				blueprint = {
					["rice_pro"] = 5,
					["mushroom_b"] = 5,
					["orangewater_b"] = 5,
					["Pig_a"] = 5,
					["lfish"] = 5,
				},
				equipment = { 
					--["card_weapon"] = true
				},				
			},	
		}
	},	
	[9] = {
		name = "หมวดอาวุธ",
		list = {				
			{
				item = "WEAPON_BOTTLE",
				fail_chance = 80,
				fail_item = {
					["exps"] = 500, 
				}, 			
				cost = {
					["money"] = 7500, 
					["black_money"] = 6500, 
				},				
				blueprint = {
					["blueprint_bottle_1"] = 5,
					["diamond_red"] = 2,
					["diamond_darkbule"] = 3,
					["glass"] = 30,					
					["copper_bar"] = 20,
					["ilmenite"] = 10,							
					["exps"] = 2500,							
				},
				equipment = { 
					["card_weapon"] = true
				},				
			},										
			{
				item = "WEAPON_DAGGER",
				fail_chance = 87,
				fail_item = {
					["exps"] = 500, 
				}, 			
				cost = {
					["money"] = 9500, 
					["black_money"] = 7500, 
				},				
				blueprint = {
					["blueprint_dagger_1"] = 5,
					["diamond_darkbule"] = 3,
					["diamond_yellow"] = 5,
					["steel_bar"] = 45,
					["pyrolusite"] = 20,
					["pro_wood"] = 25,	
					["gold_bar"] = 15,								
					["exps"] = 3500,								
				},
				weaponrequest = "WEAPON_BOTTLE",
				equipment = { 
					["card_weapon"] = true
				},				
			},															
			{
				item = "WEAPON_KNUCKLE",
				fail_chance = 90,
				fail_item = {
					["exps"] = 2000, 
				}, 			
				cost = {
					["money"] = 15500, 
					["black_money"] = 9500, 
				},				
				blueprint = {
					["blueprint_knuckleduster_1"] = 5,
					["diamond_darkbule"] = 5,
					["diamond_yellow"] = 3,
					["diamond_red"] = 2,
					["ilmenite"] = 15,					
					["pyrolusite"] = 20,	
					["steel_bar"] = 50,					
					["exps"] = 4500,							
				},
				weaponrequest = "WEAPON_BAT_LV4",
				equipment = { 
					["card_weapon"] = true
				},				
			},	
			{
				item = "WEAPON_HAMMER_LV2",
				fail_chance = 70,
				fail_item = {
					["exps"] = 500, 
				}, 			
				cost = {
					["black_money"] = 2500, 
				},				
				blueprint = {
					["blueprint_hammer_1"] = 2,
					["diamond_darkbule"] = 1,
					["steel_bar"] = 30,
					["gold_bar"] = 5,
					["pro_wood"] = 30,						
					["exps"] = 500,				
				},
				weaponrequest = "WEAPON_HAMMER_LV1",	
				removeweaponaftercraft = true,
				equipment = { 
					["goldencard"] = true
				},
			},	
			{
				item = "WEAPON_POOLCUE_LV3",
				fail_chance = 85,
				fail_item = {
					["exps"] = 50, 
				}, 			
				cost = {
					["money"] = 5000, 
					["black_money"] = 4000, 
				},				
				blueprint = {
					["blueprint_poolcue_1"] = 2,
					["diamond_darkbule"] = 2,
					["diamond_yellow"] = 1,	
					["diamond_red"] = 1,	
					["steel_bar"] = 30,
					["pro_wood"] = 40,	
					["exps"] = 600,				
				},
				weaponrequest = "WEAPON_POOLCUE_LV2",
				removeweaponaftercraft = true,
				persentremove_fail = {
					protect_follw_black = "unbrokencard",
					follw_black = "WEAPON_POOLCUE_LV1",
					persent_fall = 30,
				},
				equipment = { 
					["goldencard"] = true
				},
			},																
		}
	},	
	[10] = {
		name = "คราฟยาต่างๆ",
		list = {
			{
				item = "armor",
				fail_chance = 0,
				fail_item = {
				--	["exps"] = 500, 
				}, 			
				cost = {
				["money"] = 1000, 
				--["black_money"] = 2000, 
				},				
				blueprint = {
					["steelscrap"] = 100,
				},
				equipment = { 
					["card_weapon"] = true
				},				
			},	
			{
				item = "drugrun",
				fail_chance = 0,
				fail_item = {
				--	["exps"] = 500, 
				}, 			
				cost = {
				["money"] = 1000, 
				--["black_money"] = 2000, 
				},				
				blueprint = {
					["capsule"] = 1,
					["weed"] = 5,
				},
				equipment = { 
					["card_weapon"] = true
				},				
			},	
			{
				item = "Aed",
				fail_chance = 0,
				fail_item = {
				--	["exps"] = 500, 
				}, 			
				cost = {
				["money"] = 1500, 
				--["black_money"] = 2000, 
				},				
				blueprint = {
					["capsule"] = 2,
					["weed"] = 10,
				},
				equipment = { 
					["card_weapon"] = true
				},				
			},	
		}
	},																																																		
}


