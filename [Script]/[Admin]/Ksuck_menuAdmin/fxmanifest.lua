fx_version 'adamant'

game 'gta5'

description ' Admin Menu'

version '1.0.0'

client_scripts {
	'client/main.lua',
    'client/utils.lua',
	'client/solarSync.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/main.lua',
	'server/solarSync.lua'
}

shared_scripts {
    'Config.lua',
    'Config.general.lua',
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/index.js',
    'html/index.css',
    'html/img/solarscripts.png'

}


