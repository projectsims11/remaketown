resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Fz Garage'

version '1.0.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	-- '@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/main.lua'
}


ui_page 'core/index.html'

files {
	'core/index.html',
	'core/style.css',
	'core/app.js',
	'core/logo.png',
	'core/Roboto-Regular.ttf',
	"core/img/*.png",
	'core/*.mp3',


	"stream/bs_prop_garage.ydr",
}



data_file "DLC_ITYP_REQUEST" "stream/bs_prop_garage.ytyp"

lua54 'yes'