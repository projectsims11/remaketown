fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'nnaridz'
version '1.2.2'

shared_scripts {
    'config/general.lua',
    'config/editable_functions.lua',
    'config/localization.lua',
}

client_scripts {
    'config/framework.lua', 
    'core/client.lua',
    'config/functions/client_listener.lua'
}

server_scripts {
    'config/framework.lua',
    'core/server.lua',
    'config/functions/server_listener.lua'
}

ui_page 'interface/index.html'
files {
    'interface/index.html',
    'interface/css/style.css',
    'interface/js/app.js',
    'interface/assets/*.mp3'
}