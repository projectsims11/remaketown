client_scripts { '@logic-hax/export/secured.cl.lua' }
server_scripts { '@logic-hax/export/secured.sv.lua' }

client_script "@bt_defender/module/client.lua"

fx_version "cerulean"

game "gta5"
lua54 "yes"
client_scripts {
	'config.lua',
	'core/cl.lua'
}

file {
	'web/**',
}

ui_page 'web/index.html'