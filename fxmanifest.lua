fx_version 'bodacious'
game 'gta5'

author 'Golf, Tazio'
description 'King of The Hill Framework'
version '0.0.1'

-- What to run
client_scripts {
    '@menuv/menuv.lua',
    'Language/*.lua',
    'Crossbase/*.lua',
    'export.lua',
    'config.lua',
    'Client/*.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'Language/*.lua',
    'Crossbase/*.lua',
    'export.lua',
    'config.lua',
    'Server/*.lua'
}

dependencies {
    'menuv',
    'mysql-async'
}