fx_version 'cerulean'
game 'gta5'
version '1.0'
author 'tworst-script'
shared_scripts {
	'config/*.lua',
}
-- ██████╗  ██████╗ ██╗  ██╗   ██╗    ██╗     ███████╗ █████╗ ██╗  ██╗███████╗ 
-- ██╔══██╗██╔═══██╗██║  ╚██╗ ██╔╝    ██║     ██╔════╝██╔══██╗██║ ██╔╝██╔════╝ 
-- ██████╔╝██║   ██║██║   ╚████╔╝     ██║     █████╗  ███████║█████╔╝ ███████╗ 
-- ██╔═══╝ ██║   ██║██║    ╚██╔╝      ██║     ██╔══╝  ██╔══██║██╔═██╗ ╚════██║ 
-- ██║     ╚██████╔╝███████╗██║       ███████╗███████╗██║  ██║██║  ██╗███████║ 
-- ╚═╝      ╚═════╝ ╚══════╝╚═╝       ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝ 
-- [discord.gg/gaJJjnKGpg] 
client_scripts {
	'client/*.lua',
}
server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/*.lua',
	-- '@mysql-async/lib/MySQL.lua'
}

ui_page "html/index.html"
files {
	'html/index.html',
	'html/*.css',
	'html/font/*.TTF',
	'html/font/*.*',
    'html/audio/*.*',
	'html/sound/*.*',
	'html/img/*.*',
	'html/js/*.js',
}

escrow_ignore {
	'config/*.lua',
	'client/*.lua',
	'server/*.lua',
}

lua54 'yes'

dependency '/assetpacks'

dependency '/assetpacks'