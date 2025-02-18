fx_version 'adamant'

game 'gta5'

description 'FewZ_vehiclebox'

client_scripts {
    'config.lua',
	'core/client.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'core/server.lua',
}
