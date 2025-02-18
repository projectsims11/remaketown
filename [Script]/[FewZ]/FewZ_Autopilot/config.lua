Config = {}

-- Enables --
Config.EnableAutodrive               = true
Config.EnableColAvoidance            = false
Config.EnableReverseCamera           = false   -- If reverse camera off, lines also off but sound effects still working. 
Config.EnableReverseLines            = false   -- Turn on/off reverse guidelines. (Camera and sound effects still work)
Config.EnableSportMode               = false   -- Disable all functions while active.

-- Keycodes --
Config.ReverseKeycode                = 73     -- Default (X) = 73
Config.AutodriveKeycode              = 47     --  G Default (F1) = 288 
Config.AutodriveIncreaseSpeedKey     = 96     -- Default (Numpad +) = 96
Config.AutodriveDecreaseSpeedKey     = 97     -- Default (Numpad -) = 97
Config.SportModeKey                  = 246    --  Y Default (F2) = 289

-- Models --
--Config.AllowedModels                 = {"models", "thrax","krieger"} -- Uppercase or Lowercase for all model names

-- Speed --
Config.AutodriveMaxSpeed             = 124    -- Mph
Config.AutodriveMinSpeed             = 62     -- Mph
Config.BeepSoundVolume               = 0.1   -- Max 1.0, Min 0.1
