fx_version 'adamant'

game 'gta5'

author 'Tuna#1565'
description 'Garage script'

version '1.0.1'

shared_scripts {
	'Config.lua',
	'Common/*.lua'
}

ui_page 'UI/index.html'

files {
	'UI/index.html',
	'UI/styles/*.css',
	'UI/scripts/*.js',
	'UI/images/*.png',
	'UI/fonts/*.otf',
	'UI/vehicles/*.png',
	'UI/vehicles/*.jpg',
	'UI/vehicles/*.jpeg',
	'UI/vehicles/*.svg'
}

client_scripts {
	'Client/*.lua'
}

server_scripts {
	'Server/*.lua'
}

dependencies {
	'2na_core'
}
