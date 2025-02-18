

fx_version "adamant"

game "gta5"

client_scripts {
	"Config.lua",
	"core/function.lua",
	"core/core_skin.lua",
	"core/core_tazer.lua",
	"core/core_name.lua",
	"core/core_menu.lua",
	"core/core_dead.lua",
	"core/core_label.lua",
	"core/core_freeze.lua",
	"core/core_delprop.lua",
}

server_scripts {
	"core/server_reskin.lua"
}

ui_page "html/ui.html"
files {
    'html/ui.html',
    'html/style.css',
    'html/ui.js',
}