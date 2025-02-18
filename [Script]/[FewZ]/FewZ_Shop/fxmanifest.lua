fx_version 'adamant'

game {'gta5'}

author 'Fewz'

version '1.1'

ui_page 'Interface/Interface.html'

shared_scripts {
    "Secure.lua",
	"Source/Include.lua"
}

client_scripts {
	'@es_extended/locale.lua',
	"Source/Client.lua",

}

server_scripts {
	'@es_extended/locale.lua',
	"Source/Server.lua"
}

files {
	"Interface/Interface.html",
	"Interface/Style.css",
	"Interface/Custom.css",
	"Interface/Function.js",
	"Interface/**"
}