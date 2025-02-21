fx_version 'cerulean'
games { 'gta5' }
author 'GodyLector'
lua54 'yes'
version '1.1.0'

shared_scripts {
     "config/config.general.lua",
     "config/config.rarity.lua",
     "config/config.items.lua"
}

client_scripts {
     "client/main.lua"
}

server_scripts {
     '@oxmysql/lib/MySQL.lua',
     "config/config.lists.lua",
     "config/config.settings.lua",
     "config/server/config.functions.lua",
     "server/ct.lua",
     "server/main.lua"
}

ui_page 'ui/index.html'

files {
     'ui/**/*'
}
