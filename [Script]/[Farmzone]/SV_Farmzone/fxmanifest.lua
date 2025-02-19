--client_scripts { '@SCRIPTX-AC/export/secured.cl.lua' }
--server_scripts { '@SCRIPTX-AC/export/secured.sv.lua' }

fx_version 'cerulean'
game 'gta5'
author 'RePlayX Modify'
description 'replayx.farmzone'
version '1.0.0'
client_script {
    'core/cl_farmzone.lua'
}

server_script {
    '@mysql-async/lib/MySQL.lua',
    'core/sv_farmzone.lua'
}

shared_script {
    'shared/config.lua', 
    'shared/func_farmzone.lua'
}

dependency 'oxmysql'