fx_version 'adamant'

game 'gta5'

files {
	'view/index.html',
	'view/css/style.css',
	'view/js/app.js',
	'view/*.mp3'
}

ui_page {
	'view/index.html'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/main.lua'
}

dependencies {
	'es_extended',
}
