

fx_version 'cerulean'
game 'gta5'

author '2Dev-Shop'
description '2Dev-Shop'
version '1.0'

client_scripts {
	"Secure.lua",
	"Source/Client.lua"
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	"Secure.lua",
	"Source/Server.lua"
}

ui_page "Interface/index.html"

file 'Interface/**'