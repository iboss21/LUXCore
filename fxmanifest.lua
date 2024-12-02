fx_version 'cerulean'
game 'gta5'

author 'The Lux Empire - LUXCore Systems'
description 'Advanced Modular Core Framework'
version '1.0.0'

shared_scripts {
    'shared/config.lua',
    'shared/locale.lua',
    'shared/functions.lua'
}

client_scripts {
    'client/main.lua',
    'client/events.lua',
    'client/functions.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua',
    'server/events.lua',
    'server/functions.lua'
}

dependencies {
    'oxmysql',
    'ox_lib'
}

lua54 'yes'
