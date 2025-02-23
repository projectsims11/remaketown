fx_version 'cerulean'
game 'gta5'

author 'Ruby'
description 'Check online time every 1 Min and 1Hr reward'
version '1.0.0'

-- Server and Client Scripts
server_scripts {
    '@es_extended/locale.lua',  -- ESX support
    'server.lua'  -- Your server-side script
}

client_scripts {
    'client.lua'  -- Your client-side script
}

dependencies {
    'es_extended',  -- ESX framework dependency
    'swift_quest'    -- Dependency for the swift_quest export
}
