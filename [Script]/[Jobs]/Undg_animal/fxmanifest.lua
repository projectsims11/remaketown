fx_version 'bodacious'
game 'gta5'
lua54 'yes' 

client_script {
	'Config/Config.function.client.lua',
	'Config/Config.notify.lua',
	'Client/client.lua'
}

server_script {
	'@oxmysql/lib/MySQL.lua',
	'Config/Config.general.lua',
	'Config/Config.notify.lua',
	'Config/Config.function.server.lua',
	'Config/Config.server.lua',
	'Server/server.lua',
}

shared_script '@es_extended/imports.lua'

ui_page 'Html/index.html'

files {
    'Html/index.html', 
    'Html/js/*.js', 
    'Html/css/*.css',
	'Html/img/*.jpg',
    'Html/img/*.png',
    'Html/sound/*.mp3',
	'Html/sound/*.wav',
}
