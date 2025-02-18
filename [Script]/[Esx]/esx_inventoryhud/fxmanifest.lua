

fx_version 'adamant'

game {'gta5'}

author 'Fxw'

version '1.1'

ui_page "html/ui.html"

shared_scripts {
	'@es_extended/imports.lua',
	'@es_extended/locale.lua',
}

client_scripts {
	'@es_extended/imports.lua',
	"@es_extended/locale.lua",
	"locales/en.lua",
	"config.inventory.lua",
	"config.giveitem.lua",
	"config.category.lua",
	"config.itemvault.lua",
	"config.options.lua",
	"config.player.lua",
	"config.weapon.lua",
	"client/client.lua",
	"client/thief.lua",
	"client/playerinventory.lua",
	
	"client/player.lua",
	"client/vault.lua",
	"client/trunk.lua",
	'@xzero_trunk/export/trunk.lua',
	'@xzero_giveui/export/giveui.lua',
}

server_scripts {
	'@es_extended/imports.lua',
	"@oxmysql/lib/MySQL.lua",
	"@es_extended/locale.lua",
	"config.inventory.lua",
	"config.giveitem.lua",
	"config.category.lua",
	"config.itemvault.lua",
	"config.options.lua",
	"config.weapon.lua",
	"config.player.lua",
	"server/server.lua",
	"locales/en.lua",
}

files {
	"html/ui.html",
	"html/css/ui.css",

	"html/css/dialog.css",

	'html/js/*.js',
	"html/locales/en.js",
	"html/font/pricedown.otf",
	"html/font/Schluber.otf",
	"html/font/Schluber.ttf",

	"html/**",
	'html/img/*.png',
	'html/img/*.gif',
	'html/img/items/*.png',
	'html/img/items/*.gif',
	'html/sound/*.mp3',
	'html/sound/*.wav',
}

export 'LoadDataVehicle'