fx_version 'cerulean'
game 'gta5'

-- Metadata
author 'The Lux Empire - LUXCore Systems'
description 'Advanced Modular Core Framework with Enhanced Features'
version '1.0.0'

-- Shared Scripts
shared_scripts {
    '@ox_lib/init.lua', -- Load ox_lib first for shared utilities
    'shared/config.lua', -- Centralized configuration
    'shared/locale.lua', -- Localization support
    'shared/functions.lua' -- Common shared functions
}

-- Client-Side Scripts
client_scripts {
    'client/main.lua', -- Core client logic
    'client/events.lua', -- Event handlers
    'client/functions.lua', -- Utility functions
    'client/modules/*.lua' -- Dynamically include all module files
}

-- Server-Side Scripts
server_scripts {
    '@oxmysql/lib/MySQL.lua', -- MySQL support for database interaction
    'server/main.lua', -- Core server logic
    'server/events.lua', -- Event handlers
    'server/functions.lua', -- Utility functions
    'server/modules/*.lua' -- Dynamically include all module files
}

-- Dependencies
dependencies {
    'oxmysql', -- Database dependency
    'ox_lib' -- Utility library for advanced functionality
}

-- Lua 5.4 Support
lua54 'yes'
