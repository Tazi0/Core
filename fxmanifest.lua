fx_version 'bodacious'
game 'gta5'

author 'Golf, Tazio'
description 'King of The Hill Framework'
version '0.0.1'

-- What to run
client_scripts {
    'config.lua',
    'Client/*.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
    'Server/*.lua'
}

