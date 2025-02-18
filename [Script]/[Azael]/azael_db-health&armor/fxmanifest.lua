fx_version 'adamant'

game 'gta5'

description 'DB - Health and Armor By. Azael Dev'

version '1.1.5'

server_scripts {
	'config.server.lua',
	'server/main.lua'
}

client_scripts {
	'config.client.lua',
	'client/main.lua'
}

dependencies {
	'es_extended',
	'mysql-async',
    'esx_status'
}
