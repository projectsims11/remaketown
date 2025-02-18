fx_version 'adamant'

game 'gta5'

description 'DC - Server logs (Webhook) By. Azael Dev'

version '1.2.7'

server_script {
	'config.lua',
	'config.events.lua',
	'server/main.lua'
}

client_script {
	'config.lua',
	'config.events.lua',
	'client/main.lua'
}

dependencies {
	'es_extended'
}
