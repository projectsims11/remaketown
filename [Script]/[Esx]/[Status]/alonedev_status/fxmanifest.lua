fx_version 'adamant'

game 'gta5'

author 'alonedev-shop'

version '1.0.0'

shared_scripts {
	'config/*.lua',
}
server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/main.lua'
}
client_scripts {
	'client/classes/status.lua',
	'client/main.lua'
}

