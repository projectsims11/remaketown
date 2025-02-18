fx_version 'adamant'
game 'gta5'

description 'FewZ_Carhud'

version '0.1'

ui_page "ui/ui.html"

files {
    'ui/ui.html',
    'ui/css/*.css',
    'ui/js/*.js',
    'ui/img/*.png',
    'ui/img/*.svg',
    'ui/*.ogg',
    'ui/sounds/*'
}


client_scripts {
    "client.lua",
    'config.lua'
}
