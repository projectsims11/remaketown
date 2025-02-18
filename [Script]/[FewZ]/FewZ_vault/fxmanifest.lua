fx_version 'adamant'
game 'gta5'

name 'FewZ_Vault'

server_scripts {
	'@es_extended/locale.lua',
	'@oxmysql/lib/MySQL.lua',
	'core/sql/sql_datastore.lua',
	'core/sql/sql_mainstore.lua',
	'config.lua',
	'core/core_server.lua',
	'config_webhook.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'config.lua',
	'core/core_client.lua'
}

dependencies {
	'es_extended',
	'esx_addonaccount',
	'esx_addoninventory',
	'esx_datastore'
}

exports {
	"getVaultLicense"
}