fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author "nnaridz"
version "1.0.0"

shared_scripts {
    'config/config.general.lua',
    'config/config.editable.lua',
    'config/config.localization.lua'
}

server_scripts {
    'config/config.framework.lua',
    'core/server.lua',
    'config/config.webhook.lua',
	'config/functions/listener.server.lua'
}

client_scripts {
    'config/config.framework.lua',
    'core/client.lua',
	'config/functions/listener.client.lua'
}

ui_page 'interface/index.html'
files {
    'interface/index.html',
    'interface/no-image.png',
    'interface/css/style.css',
    'interface/js/jquery-ui.min.js',
    'interface/js/app.js'
}