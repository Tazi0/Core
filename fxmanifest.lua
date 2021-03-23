-- 
-- The files in this folder are copyrighted by the KOTH Framework
-- Any editing or disruptive use of these files will not be supported
-- The distrobution of the files is never allowed and access to the resource will be stopped.
-- For any support contact the Developers of the KOTH Framework
-- 

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