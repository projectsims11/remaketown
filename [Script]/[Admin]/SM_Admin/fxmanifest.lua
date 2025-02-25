fx_version "adamant"
game "gta5"

description "SM_Admin"
version "3011"
author "SnowMan zack mod"

lua54 "yes"

shared_scripts {
	"config.general.lua",
	"config.functions.lua",
}

client_scripts {
	"code/client.lua",
	"code/vSync/cl_vSync.lua",
}

server_scripts {
	"@mysql-async/lib/MySQL.lua",
	"config.server.lua",
	"code/server.lua",
	"code/vSync/sv_vSync.lua",
}

ui_page "html/index.html"

files {
	"html/index.html",
	"html/styles.css",
	"html/script.js",
	"html/sound/*.mp3",
	"html/sound/*.ogg",
	"html/img/*.png",
	"html/img/vehicles/*.png",
	
}
