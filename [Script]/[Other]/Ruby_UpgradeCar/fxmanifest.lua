fx_version 'cerulean'
game 'gta5'

author 'Ruby'
description 'Fully Updgrade Car'
version '1.0.0'


server_script {
    'config.lua',
    'server.lua'
}

client_script {
    'client.lua'
}

dependencies {
    'es_extended' -- Ensure ESX is loaded before this resource
}