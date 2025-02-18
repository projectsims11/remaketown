fx_version "adamant"
game "gta5"

description "Fewthz Inventory HUD"

version "1.0.0"

ui_page "html/ui.html"

client_scripts {
	"@es_extended/locale.lua",
	"locales/en.lua",
	"config/config.lua",
	"config/config.weapons.lua",
	"core/core_client.lua",
	"core/core_client_playerinventory.lua",
	"core/core_client_player.lua",
	"core/core_client_vault.lua",
	"core/core_client_thief.lua",
	'@xzero_trunk/export/trunk.lua',
	'@xzero_giveui/export/giveui.lua',
}

server_scripts {
	"@mysql-async/lib/MySQL.lua",
	"@es_extended/locale.lua",
	"locales/en.lua",
	"config/config.lua",
	"core/core_server.lua",

}

files {
	"html/ui.html",
	"html/css/ui.css",
	"html/css/scotty.css",
	"html/css/jquery-ui.css",
	"html/css/bootstrap.min.css",
	"html/js/inventory.js",
	"html/js/config.js",
	"html/js/scotty.js",
	"html/fonts/osifont.ttf",

	-- JS LOCALES
	"html/locales/en.js",

	-- IMAGES
	'html/img/*.png',
	'html/img/*.gif',
	'html/img/items/*.png',
	'html/img/items/*.gif',
}
