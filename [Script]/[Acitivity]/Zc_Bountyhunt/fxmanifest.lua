-- NC PROTECT+
server_scripts { '@nc_PROTECT+/exports/protected.lua', '@nc_PROTECT+/exports/sv.lua' }
client_scripts { '@nc_PROTECT+/exports/protected.lua', '@nc_PROTECT+/exports/cl.lua' }

fx_version 'adamant'

game 'gta5'
lua54 'yes' 

description 'ZC-DEV'

version '1.0.0'


client_scripts {
	'config.lua',
    'clientx.lua',
	'client.lua'
}
server_scripts {
	'config.lua',
	'server.lua'
}

ui_page 'ui/index.html'
files {
    'ui/index.html',
    'ui/css/*.css',
    'ui/js/*.js',
    'ui/sounds/*.ogg',
    'ui/sounds/*.mp3'
}