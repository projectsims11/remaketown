fx_version 'adamant'
games { 'gta5' }

files {
	'html/*'
}

ui_page "html/ui.html"

server_scripts {
	-- Version
	'version.lua',

	'config.lua',
	'server.lua'
}

client_scripts {
	-- Version
	'version.lua',

	'config.lua',
	'client.lua'
}