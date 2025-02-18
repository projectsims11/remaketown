fx_version 'adamant'

game 'gta5'

server_scripts {
    'config.lua',
	'server/main.lua',
    '@oxmysql/lib/MySQL.lua'
}

client_scripts {
    'config.lua',
	'client/main.lua'
}

ui_page "html/index.html"

files({
    'html/index.html',
    'html/index.js',
    'html/main.css',
    'html/Assets/Vector-1.svg',
    'html/Assets/Vector.svg',
    'html/Assets/card.svg',
    'html/Assets/logo.svg',
    'html/Assets/card.svg',
    'html/Assets/back.svg',
    "html/j.wav",
    "html/wv.wav",
    "html/m.wav",
    "html/w.wav",
    "html/a.wav",
})