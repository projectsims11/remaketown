fx_version "cerulean"
game "gta5"

author "BU SCRIPT"
description "BU EXTRA"
version "2.1"

server_scripts {
  "@mysql-async/lib/MySQL.lua",
  "config/cfg.setting.lua",
  "config/cfg.interface.lua",
  "config/cfg.discord.lua",
  "config/cfg.redeem.lua",
  "config/cfg.list.lua",
  "config/cfg.expire.lua",
  "config/functions/cfg.function.sv.lua",
  --"code/ct.lua",
  "code/sv.lua",
  "code/crack.lua"
}

client_scripts {
  "config/functions/cfg.function.ce.lua",
  "code/ot.lua",
  "code/ce.lua"
}

ui_page "code/html/ui.html"
file "code/html/**"