fx_version 'adamant'

game 'gta5'

lua54 "yes"

author 'alonedev-shop'

ui_page('html/index.html')

shared_scripts {
    'config/*.lua'
}

client_scripts {
    "core/client.lua"
}

server_scripts {
    "core/server.lua"
}

files {
	"html/**"
}
  