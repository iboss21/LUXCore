fx_version 'cerulean'
game 'gta5'

--[[ 
    Metadata
    Author: The Lux Empire - LUXCore Systems
    Description: Advanced Modular Core Framework with Enhanced Features
    Version: 1.0.0
]]
author 'The Lux Empire - LUXCore Systems'
description 'Advanced Modular Core Framework with Enhanced Features'
version '1.0.0'

--[[ 
    Shared Scripts
    Description: Shared resources used by both client and server. Ensure dependencies like ox_lib are loaded first.
]]
shared_scripts {
    '@ox_lib/init.lua', -- Load ox_lib for shared utilities and compatibility
    'shared/config.lua', -- Centralized configuration for all modules
    'shared/locale.lua', -- Localization support for multi-language servers
    'shared/functions.lua' -- Shared utility functions
}

--[[ 
    Client-Side Scripts
    Description: Client-side logic, event handling, and module loading. Dynamically includes all client modules.
]]
client_scripts {
    'client/main.lua', -- Core client-side logic and initialization
    'client/events.lua', -- Handles client-side events
    'client/functions.lua', -- Client-side utility functions
    'client/modules/*.lua' -- Load all client modules dynamically from the "modules" folder
}

--[[ 
    Server-Side Scripts
    Description: Server-side logic, database interaction, and module loading. Dynamically includes all server modules.
]]
server_scripts {
    '@oxmysql/lib/MySQL.lua', -- Required for MySQL database interaction
    'server/main.lua', -- Core server-side logic and initialization
    'server/events.lua', -- Handles server-side events
    'server/functions.lua', -- Server-side utility functions
    'server/modules/*.lua' -- Load all server modules dynamically from the "modules" folder
}

--[[ 
    Dependencies
    Description: Required resources for LUXCore to function. Ensure these are installed and configured properly.
]]
dependencies {
    'oxmysql', -- oxmysql is required for database operations
    'ox_lib' -- ox_lib is required for utility and compatibility features
}

-- Enable Lua 5.4 Support
lua54 'yes'
