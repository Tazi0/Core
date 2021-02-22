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
    'config.lua',
    'Client/*.lua'
    'notification_ext/Client/*.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'Language/*.lua',
    'Crossbase/*.lua',
    'config.lua',
    'Server/*.lua'
}

ui_page "notification_ext/Data/index.html"

files {
    "html/index.html",
    "html/script.js",
    "html/style.css"
}

dependencies {
    'menuv',
    'mysql-async'
}