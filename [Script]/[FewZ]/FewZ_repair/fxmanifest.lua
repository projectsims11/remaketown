fx_version 'adamant'

game 'gta5'

description 'FewZ_repair'

author 'FewZ'

version '1.0.2'

client_script {
  'config.lua',
  'functions.lua',
  'sources/client.lua'
}

server_script {
  'config.lua',
  'sources/server.lua'
}

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/style.css',
	'html/app.js',
	'html/click.mp3',
  'html/open.mp3',
  'html/close.mp3',
}
