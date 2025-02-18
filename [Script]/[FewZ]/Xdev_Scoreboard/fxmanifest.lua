fx_version 'adamant'
game 'gta5'

ui_page 'html/index.html'

files {
	'html/*',
    'html/img/*.png',
	'html/sounds/*.mp3'
}

client_scripts {
	'config.lua',
	'core/client.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'core/server.lua'
}