fx_version 'adamant'
game 'gta5'

description 'ESX Identity x Cb Developer'

version '1.10.1'

server_scripts {
	'@es_extended/locale.lua',
	'@oxmysql/lib/MySQL.lua',
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

ui_page 'html/index.html'

files {
	'html/*',
	'html/img/*',
	'html/sounds/*',
}

dependency 'es_extended'
