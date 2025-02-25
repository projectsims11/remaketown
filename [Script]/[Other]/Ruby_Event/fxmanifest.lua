fx_version 'cerulean'
game 'gta5'

author 'Ruby'
description 'Auto notify event'
version '1.0.0'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js',
    'html/images/*.png',
    'html/*.mp3'
}
shared_script 'config.lua'

client_script {
    'client.lua'
}

server_scripts {
    'server.lua'
}