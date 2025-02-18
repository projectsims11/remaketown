fx_version 'adamant'

game 'gta5'

description 'ESX Ambulance Job'

version '1.7.5'

shared_script '@es_extended/imports.lua'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/fi.lua',
	'locales/fr.lua',
	'locales/es.lua',
	'locales/sv.lua',
	'locales/pl.lua',
	'locales/cs.lua',
	'locales/th.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/fi.lua',
	'locales/fr.lua',
	'locales/es.lua',
	'locales/sv.lua',
	'locales/pl.lua',
	'locales/cs.lua',
	'locales/th.lua',
	'config.lua',
	'client/main.lua',
	'client/job.lua'
}

ui_page 'dist/index.html'

files {
  'dist/index.html',
  'dist/assets/index.*.css',
  'dist/assets/index.*.js',
}


dependencies {
	'es_extended',
	'esx_vehicleshop',
}