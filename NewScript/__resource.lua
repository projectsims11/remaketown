-- Create By JubJub Studio https://www.facebook.com/BugErr0rJubJub/ 
 
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937' 
 
description 'Create By JubJub Studio' 
 
version '0.0.1' 
 
server_scripts { 
	'@mysql-async/lib/MySQL.lua', 
	'@es_extended/locale.lua', 
	'locales/th.lua', 
	'config.lua', 
	'server/server.lua', 
} 
 
client_scripts { 
	'@es_extended/locale.lua', 
	'locales/th.lua', 
	'config.lua', 
	'client/client.lua', 
} 
