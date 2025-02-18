fx_version 'adamant'

game 'gta5'

description "Fewthz_GIFTBOX"

version "1.0"

ui_page "html/ui.html"

shared_script {
	'@es_extended/locale.lua',
	'config.lua',
	'config.function.lua',
}

client_script {
	"config.lua",
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	"core/core_server.lua",
}
