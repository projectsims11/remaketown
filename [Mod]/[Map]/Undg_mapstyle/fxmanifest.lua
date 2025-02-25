resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

fx_version 'bodacious'
game 'gta5'
lua54 'yes' 

client_script {
	'Config/Config.general.lua',
	'Config/Config.notify.lua',
	'Client/client.lua'
}

server_script {
	'Config/Config.general.lua',
	'Server/server.lua'
}

ui_page 'Html/index.html'

files {
	'html/**'
}
