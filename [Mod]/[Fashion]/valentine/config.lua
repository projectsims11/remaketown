
--[[
	Author: CannonX2
	Special: Fivem Server
--]]

Config = {}

Config["debug"] = true

Config["routers"] = {		
    ["getSharedObject"] = "esx:getSharedObject",
}
--xPos = 0.160, yPos = 0.000, zPos = 0.005, xRot = 180.400, yRot = -90.300, zRot = 0.000,
Config["item_setting"] = {
    ["072air_baloon2tone"] = { -- item name
        ["obj_model"] = "072air_baloon2tone", -- model name
        ["obj_setting"] = {
            ["bone"] = 24818,  -- bone id
            ["position"] = { 
				["x"] = 0.0,
				["y"] = 0.0,
				["z"] = 0.0, 
            },
            ["rotation"] = {
                ["x"] = 0.0, 
				["y"] = 90.0, 
				["z"] = 0.0,
            }
        },
        ["spawn_prop_model"] = function(return_status) -- client
			return_status(true)	-- callback status
		end,
        ["delete_prop_model"] = function(return_status) -- client
			TriggerEvent("mythic_progbar:client:progress", {
				name = "nexz_fashion",
				duration = 3000,
				label = "กำลังถอดแฟชั้น",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				},
				-- animation = {
				-- 	animDict = "misstrevor3",	
				-- 	anim = "bike_chat_b_loop_1",						
				-- 	flags = 1,
				-- },			
			}, function(status)	
				if not status then
					return_status(true)	 -- callback status
				else	
					return_status(false) -- callback status
				end		
				ClearPedTasks(PlayerPedId())
				ClearPedTasksImmediately(GetPlayerPed(-1))													
			end)
		end,
    },
	["072air_baloonbag"] = { -- item name
        ["obj_model"] = "072air_baloonbag", -- model name
        ["obj_setting"] = {
            ["bone"] = 24818,  -- bone id
            ["position"] = { 
				["x"] = 0.0,
				["y"] = 0.0,
				["z"] = 0.0, 
            },
            ["rotation"] = {
                ["x"] = 0.0, 
				["y"] = 90.0, 
				["z"] = 0.0,
            }
        },
        ["spawn_prop_model"] = function(return_status) -- client
			return_status(true)	-- callback status
		end,
        ["delete_prop_model"] = function(return_status) -- client
			TriggerEvent("mythic_progbar:client:progress", {
				name = "nexz_fashion",
				duration = 3000,
				label = "กำลังถอดแฟชั้น",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				},
				-- animation = {
				-- 	animDict = "misstrevor3",	
				-- 	anim = "bike_chat_b_loop_1",						
				-- 	flags = 1,
				-- },			
			}, function(status)	
				if not status then
					return_status(true)	 -- callback status
				else	
					return_status(false) -- callback status
				end		
				ClearPedTasks(PlayerPedId())
				ClearPedTasksImmediately(GetPlayerPed(-1))													
			end)
		end,
    },
	["072bear"] = { -- item name
        ["obj_model"] = "072bear", -- model name
        ["obj_setting"] = {
            ["bone"] = 24818,  -- bone id
            ["position"] = { 
				["x"] = -0.2,
				["y"] = 0.0,
				["z"] = 0.0, 
            },
            ["rotation"] = {
                ["x"] = 0.0, 
				["y"] = 90.0, 
				["z"] = 0.0,
            }
        },
        ["spawn_prop_model"] = function(return_status) -- client
			return_status(true)	-- callback status
		end,
        ["delete_prop_model"] = function(return_status) -- client
			TriggerEvent("mythic_progbar:client:progress", {
				name = "nexz_fashion",
				duration = 3000,
				label = "กำลังถอดแฟชั้น",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				},
				-- animation = {
				-- 	animDict = "misstrevor3",	
				-- 	anim = "bike_chat_b_loop_1",						
				-- 	flags = 1,
				-- },			
			}, function(status)	
				if not status then
					return_status(true)	 -- callback status
				else	
					return_status(false) -- callback status
				end		
				ClearPedTasks(PlayerPedId())
				ClearPedTasksImmediately(GetPlayerPed(-1))													
			end)
		end,
    },
	["072bouquet"] = { -- item name
        ["obj_model"] = "072bouquet", -- model name
        ["obj_setting"] = {
            ["bone"] = 24818,  -- bone id
            ["position"] = { 
				["x"] = 0.0,
				["y"] = -0.15,
				["z"] = 0.0, 
            },
            ["rotation"] = {
                ["x"] = 0.0, 
				["y"] = 90.0, 
				["z"] = 0.0,
            }
        },
        ["spawn_prop_model"] = function(return_status) -- client
			return_status(true)	-- callback status
		end,
        ["delete_prop_model"] = function(return_status) -- client
			TriggerEvent("mythic_progbar:client:progress", {
				name = "nexz_fashion",
				duration = 3000,
				label = "กำลังถอดแฟชั้น",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				},
				-- animation = {
				-- 	animDict = "misstrevor3",	
				-- 	anim = "bike_chat_b_loop_1",						
				-- 	flags = 1,
				-- },			
			}, function(status)	
				if not status then
					return_status(true)	 -- callback status
				else	
					return_status(false) -- callback status
				end		
				ClearPedTasks(PlayerPedId())
				ClearPedTasksImmediately(GetPlayerPed(-1))													
			end)
		end,
    },
	["072chocolate"] = { -- item name
        ["obj_model"] = "072chocolate", -- model name
        ["obj_setting"] = {
            ["bone"] = 24818,  -- bone id
            ["position"] = { 
				["x"] = 0.0,
				["y"] = 0.0,
				["z"] = 0.0, 
            },
            ["rotation"] = {
                ["x"] = 0.0, 
				["y"] = 90.0, 
				["z"] = 0.0,
            }
        },
        ["spawn_prop_model"] = function(return_status) -- client
			return_status(true)	-- callback status
		end,
        ["delete_prop_model"] = function(return_status) -- client
			TriggerEvent("mythic_progbar:client:progress", {
				name = "nexz_fashion",
				duration = 3000,
				label = "กำลังถอดแฟชั้น",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				},
				-- animation = {
				-- 	animDict = "misstrevor3",	
				-- 	anim = "bike_chat_b_loop_1",						
				-- 	flags = 1,
				-- },			
			}, function(status)	
				if not status then
					return_status(true)	 -- callback status
				else	
					return_status(false) -- callback status
				end		
				ClearPedTasks(PlayerPedId())
				ClearPedTasksImmediately(GetPlayerPed(-1))													
			end)
		end,
    },
	["072heart"] = { -- item name
        ["obj_model"] = "072heart", -- model name
        ["obj_setting"] = {
            ["bone"] = 31086,  -- bone id
            ["position"] = { 
				["x"] = -0.1,
				["y"] = 0.1,
				["z"] = 0.05, 
            },
            ["rotation"] = {
                ["x"] = 0.0, 
				["y"] = 90.0, 
				["z"] = 0.0,
            }
        },
        ["spawn_prop_model"] = function(return_status) -- client
			return_status(true)	-- callback status
		end,
        ["delete_prop_model"] = function(return_status) -- client
			TriggerEvent("mythic_progbar:client:progress", {
				name = "nexz_fashion",
				duration = 3000,
				label = "กำลังถอดแฟชั้น",
				useWhileDead = false,
				canCancel = false,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				},
				-- animation = {
				-- 	animDict = "misstrevor3",	
				-- 	anim = "bike_chat_b_loop_1",						
				-- 	flags = 1,
				-- },			
			}, function(status)	
				if not status then
					return_status(true)	 -- callback status
				else	
					return_status(false) -- callback status
				end		
				ClearPedTasks(PlayerPedId())
				ClearPedTasksImmediately(GetPlayerPed(-1))													
			end)
		end,
    },
}
