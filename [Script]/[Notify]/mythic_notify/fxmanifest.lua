fx_version 'cerulean'
game 'gta5'

ui_page 'html/ui.html'
files {
	'html/ui.html',
	'html/js/app.js', 
	'html/css/style.css',
}

client_script 'client/main.lua'

exports {
	'SendAlert',
	'PersistentAlert',
	
	'DoShortHudText',
	'DoHudText',
	'DoLongHudText',
	'DoCustomHudText',
	'PersistentHudText',
}