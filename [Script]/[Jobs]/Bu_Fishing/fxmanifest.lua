fx_version "cerulean"
game "gta5"

author "BU SCRIPT"
description "BU FISHING"
version "2.5.4"

server_scripts {
  "config/cfg.setting.lua",
  "config/cfg.interface.lua",
  "config/cfg.discord.lua",
  "config/cfg.items.lua",
  "config/cfg.list.lua",
  "config/cfg.rental.lua",
  "code/ct.lua",
  "code/sv.lua",
}

client_scripts {
  "config/cfg.function.lua",
  "code/ot.lua",
  "code/ce.lua"
}

ui_page "code/html/ui.html"
file "code/html/**"