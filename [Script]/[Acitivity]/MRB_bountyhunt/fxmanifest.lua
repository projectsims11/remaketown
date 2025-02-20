fx_version 'adamant'
game 'gta5'

description 'developed by MRB'

server_scripts {
	'config/events.lua',
	'config/config.lua',
	'config/webhook.lua',
	'server/main.lua',
	'config/notify.lua',
	'config/functions.lua'
}

client_scripts {
	'config/events.lua',
	'config/config.lua',
	'client/main.lua',
	'config/notify.lua',
	'config/functions.lua'
}

ui_page "html/index.html"

files{
	"html/index.html",
	"html/style.css",
	'html/img/*',
	'html/sounds/*',
	"html/script.js",
	"html/jquery.transform2d.js",
	"stream/*.ydr",
}
data_file 'DLC_ITYP_REQUEST' 'stream/ta_prop_treasure.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/ta_santabag.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/ta_santahat.ytyp'

export "MRB_IsHunting"