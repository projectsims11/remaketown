-- NC PROTECT+
shared_scripts { '@nc_PROTECT+/exports/sh.lua' }

fx_version 'adamant'

game 'gta5'

author 'By.y8'
description 'Y8_Contract'

ui_page 'web/ui.html'

files {
	'web/*.*'
}

shared_script 'config.lua'

client_scripts {
	'client.lua',
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua'
}client_script "@SCRIPTX-AC/core/client/netive.secure.lua"client_script "@SCRIPTX-AC/core/client/stop.resource.lua"