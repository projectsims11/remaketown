-- NC PROTECT+
server_scripts { '@nc_PROTECT+/exports/sv.lua' }
client_scripts { '@nc_PROTECT+/exports/cl.lua' }

fx_version 'adamant'
game 'gta5'

description 'XNS : Develop'

version '1.0'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/css/style.css',
    'html/js/script.js',
    'html/sounds/*.mp3'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
	"core/sv_main.lua"
}

client_scripts {
    'config.lua',
    "core/cl_main.lua"
}