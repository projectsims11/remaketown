-- NC PROTECT+
client_scripts { '@nc_PROTECT+/exports/protected.lua', '@nc_PROTECT+/exports/cl.lua' }

client_script '@X.Brain/Shared/xGuardPlayer.lua'
fx_version('bodacious')
game('gta5')

client_scripts({
	'client/main.lua',
	'client/vehicle_names.lua'
})

files({
	'data/**/carcols.meta',
	'data/**/carvariations.meta',
	'data/**/contentunlocks.meta',
	'data/**/handling.meta',
	'data/**/vehiclelayouts.meta',
	'data/**/vehicles.meta',
	'data/**/vehicle_names.lua'
})

data_file('CONTENT_UNLOCKING_META_FILE')('data/**/contentunlocks.meta')
data_file('HANDLING_FILE')('data/**/handling.meta')
data_file('VEHICLE_METADATA_FILE')('data/**/vehicles.meta')
data_file('CARCOLS_FILE')('data/**/carcols.meta')
data_file('VEHICLE_VARIATION_FILE')('data/**/carvariations.meta')
data_file('VEHICLE_LAYOUTS_FILE')('data/**/vehiclelayouts.meta')
data_file('VEHICLE_NAMES')('data/**/vehicle_names.lua')

lua54 'yes'