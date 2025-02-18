game 'gta5'
fx_version 'cerulean'

author 'FewZ-#3099'

lua54 'yes'
version '1.0.0'

client_scripts {
    'client/main.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}

shared_scripts {
    'config.lua',
}