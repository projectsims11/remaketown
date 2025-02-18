fx_version 'cerulean'
game 'gta5'
description 'FewZ'
version '1.0'

server_scripts {
	'@async/async.lua',
	'@oxmysql/lib/MySQL.lua',
	'server-config.lua',
	'core/core_server.lua'
}

client_scripts {
	'client-config.lua',
	'core/core_client.lua'
}

shared_script 'core/common.lua'

ui_page 'nui/index.html'

files {
	'nui/index.html',
	'nui/css/style.css',
	'nui/js/app.js'
}

dependencies {
	'es_extended',
	'async',
	'oxmysql',
}
