fx_version 'bodacious'
game 'gta5'

author 'jomjam.shop'
description ''
version '2.0'

lua54 'on'
is_cfxv2 'yes'
use_fxv2_oal 'true'

ui_page 'html/index.html'
files {
	'html/index.html',
	'html/js/**/*.js',
	'html/css/**/*.css',
	'html/img/**/*.png',
	'html/sounds/**/*.ogg'
}

client_scripts {	
	'config.lua',
	'config_menus.lua',
	'config_labels.lua',
	'config_vehicles.lua',
	'core/core_cl.lua',
	'core/function.lua',
	'core/job.lua'
}

server_scripts {	
	'config.lua',
	'config_menus.lua',
	'config_labels.lua',
	'config_vehicles.lua',
	'core/core_sv.lua'
}server_scripts { '@mysql-async/lib/MySQL.lua' }