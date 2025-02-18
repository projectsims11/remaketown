fx_version 'cerulean'

game 'gta5'

author 'FewZ'
description 'FewZ_DEPOSITCAR'

client_scripts {
    'core/cl_depositcar.lua'
}
server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'core/sv_depositcar.lua', 
    '@es_extended/locale.lua'
}

shared_script {
    'config.lua'
}