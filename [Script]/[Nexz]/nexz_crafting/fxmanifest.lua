
--[[
	Author: CanonX2
	Special: Fivem Server
    Discord : https://discord.gg/Ns9jcjvuxc
--]]

fx_version 'adamant'

game 'gta5'

ui_page 'html/Index.html'

files {
    'html/Index.html',
    'html/style.css',
    'html/script.js',
	'html/sounds/*.ogg',
}

client_scripts {
	'config_cl.lua',
    'client/client.lua',
}

server_scripts {
	'config_sv.lua',
	'server/main.lua',
}

