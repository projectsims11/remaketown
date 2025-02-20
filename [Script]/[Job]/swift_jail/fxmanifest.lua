fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author "nnaridz"
version "1.4.1"

shared_scripts {
    'config/general.lua',
    'config/localization.lua',
    'config/editable_functions.lua'
}

client_scripts {
    'config/framework.lua',
    'core/client.lua',
    'config/functions/client_listener.lua'
}

server_scripts {
    'config/framework.lua',
    'core/server.lua',
    'config/webhook.lua',
    'config/functions/server_listener.lua'
}

ui_page 'interface/index.html'
files {
    'interface/index.html',
    'interface/js/jquery-ui.min.js',
    'interface/js/app.js',
    'interface/css/style.css',
    'interface/assets/*.mp3',
}