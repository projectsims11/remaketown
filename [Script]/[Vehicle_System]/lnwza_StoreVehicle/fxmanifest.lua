fx_version 'adamant'

game 'gta5'

description 'lnwza_Jobs'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server/main.lua',
}

client_scripts {
	'config.lua',
	'client/main.lua',
}