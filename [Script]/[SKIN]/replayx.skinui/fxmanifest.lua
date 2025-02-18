fx_version 'cerulean'
game 'gta5'

description 'Giant Skinui'
version '1.2.0'
author 'GIANT'


shared_scripts {
	'config/config.basic.lua',
	'config/config.cl-notification.lua',
	'config/config.sv-notification.lua',
	'config/config.blockcloth.lua',
}

client_scripts {
	'client/main.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/main.lua'
}


ui_page 'dist/index.html'


files {
  'dist/index.html',
  'dist/assets/index.css',
  'dist/assets/index.js',
}