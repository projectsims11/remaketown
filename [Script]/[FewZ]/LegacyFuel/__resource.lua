
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page 'html/html.html'

server_scripts {
	"@mysql-async/lib/MySQL.lua",
	'config.lua',
	'source/fuel_server.lua'
}

client_scripts {
	'config.lua',
	'source/fuel_client.lua'
}

exports {
	'GetFuel',
	'SetFuel'
}

files {
	'html/**'
}