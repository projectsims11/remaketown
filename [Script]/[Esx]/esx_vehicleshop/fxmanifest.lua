fx_version 'cerulean'
game 'gta5'

ui_page 'nui/index.html'

client_scripts { 'config.lua', 'client.lua', 'utils.lua'}

server_scripts { 'config.lua', '@mysql-async/lib/MySQL.lua','server.lua'}
 
files {
	'nui/index.html',
	'nui/*.png',
	'nui/style.css',
	'nui/Chairdrobe.otf',
	'nui/js.js',	
}

exports { 'GeneratePlate' }