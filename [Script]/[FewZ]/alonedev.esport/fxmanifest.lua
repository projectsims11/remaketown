fx_version 'adamant' 
game 'gta5' 
 
description 'alonedev'
version '1.0'

shared_scripts {
  'config_aed.lua',
  'config_armor.lua',
  'config_painkiller.lua',
}

client_scripts {
  "aed/client.lua",
  "armor/client.lua",
  "painkiller/client.lua",
}
  
server_script {
  "aed/server.lua",
  "armor/server.lua",
  "painkiller/server.lua",
}
