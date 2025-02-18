Config                      = {}
Config.Locale               = GetConvar('esx:locale', 'en')

Config.Accounts             = {
	bank = {
		label = 'ธนาคาร',
		round = true
	},
	black_money = {
		label = 'เงินดำ',
		round = true
	},
	money = {
		label = 'เงิน',
		round = true
	}
}

Config["Function_Base"] = {
	['Update_Weapon']            = true,      -- [ Config : เปิด / ปิดการ อัพเดท อาวุธและกระสุน ] --
	['Font'] = 'Kanit'                    -- [ Config : ฟ้อนต์ สามารถเปลี่ยนฟ้อนต์ได้เองเลย ชื่อฟ้อนต์ในโฟลเดอร์ stream ] --
}

Config.StartingAccountMoney = { money = 0, bank = 0, black_money = 0 }
Config.StartingInventoryItems = false -- table/false

Config.DefaultSpawns = { -- If you want to have more spawn positions and select them randomly uncomment commented code or add more locations
	{ x = -257.261536, y = -980.571411, z = 31.217529, heading = 28.346457 }
}

Config.AdminGroups = {
	['superadmin'] = true,
	['admin'] = true
}

Config.LicenseType               = "steam" -- steam, license, discord, xbl, liveid, ip
Config.EnablePaycheck            = true      -- enable paycheck
Config.LogPaycheck               = true     -- Logs paychecks to a nominated Discord channel via webhook (default is false)
Config.EnableSocietyPayouts      = false     -- pay from the society account that the player is employed at? Requirement: esx_society
Config.PaycheckInterval          = 30 * 60000 -- how often to recieve pay checks in milliseconds
Config.EnableDebug               = false     -- Use Debug options?
Config.EnableWantedLevel         = false     -- Use Normal GTA wanted Level?
Config.EnablePVP                 = true      -- Allow Player to player combat

Config.DistanceGive              = 4.0   -- Max distance when giving items, weapons etc.
Config.AdminLogging              = true -- Logs the usage of certain commands by those with group.admin ace permissions (default is false)

Config.CustomNotificationEnabled = true -- ESX.Shownotification
Config.CustomNotification        = function(message, notifyType, length)
	print(message)
end

Config.SpawnVehMaxUpgrades       = true       -- admin vehicles spawn with max vehcle settings
Config.CustomAIPlates            = 'ADMIN' -- Custom plates for AI vehicles

Config.RemoveHudComponents       = {
	[1] = false,                         --WANTED_STARS,
	[2] = false,                         --WEAPON_ICON
	[3] = false,                         --CASH
	[4] = false,                         --MP_CASH
	[5] = false,                         --MP_MESSAGE
	[6] = false,                         --VEHICLE_NAME
	[7] = false,                         -- AREA_NAME
	[8] = false,                         -- VEHICLE_CLASS
	[9] = false,                         --STREET_NAME
	[10] = false,                        --HELP_TEXT
	[11] = false,                        --FLOATING_HELP_TEXT_1
	[12] = false,                        --FLOATING_HELP_TEXT_2
	[13] = false,                        --CASH_CHANGE
	[14] = false,                        --RETICLE
	[15] = false,                        --SUBTITLE_TEXT
	[16] = false,                        --RADIO_STATIONS
	[17] = false,                        --SAVING_GAME,
	[18] = false,                        --GAME_STREAM
	[19] = false,                        --WEAPON_WHEEL
	[20] = false,                        --WEAPON_WHEEL_STATS
	[21] = false,                        --HUD_COMPONENTS
	[22] = false,                        --HUD_WEAPONS
}