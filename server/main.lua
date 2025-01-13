
-- LUXCore - Server Main Logic
-- Enhanced to include dynamic framework detection, player management, server health monitoring,
-- and extensive modular functionality.

local Config = require('shared/config') -- Load configuration

-- Framework Detection
if Config.General.Framework == 'ESX' then
    print('[LUXCore] Framework detected: ESX. Initializing...')
    -- Framework-specific initialization logic for ESX
elseif Config.General.Framework == 'QBCore' then
    print('[LUXCore] Framework detected: QBCore. Initializing...')
    -- Framework-specific initialization logic for QBCore
else
    print('[LUXCore] ERROR: No framework detected. Defaulting to standalone mode.')
    -- Default standalone initialization
end

-- Player Connection Management
AddEventHandler('playerConnecting', function(name, setCallback, deferrals)
    local playerId = source
    print(string.format('[LUXCore] Player connecting: %s (ID: %d)', name, playerId))

    deferrals.defer()
    Wait(0)
    deferrals.update(string.format('[LUXCore] Checking data for player %s...', name))
    Wait(1000) -- Simulate data check

    -- Simulated success
    deferrals.done()
end)

-- Player Disconnection Management
AddEventHandler('playerDropped', function(reason)
    local playerId = source
    print(string.format('[LUXCore] Player %d disconnected: %s', playerId, reason))

    -- Save player data on disconnect (if applicable)
end)

-- Auto-Save Player Data
CreateThread(function()
    while true do
        Wait(Config.General.AutoSaveInterval * 1000)
        print('[LUXCore] Auto-saving player data...')
        -- Add logic for saving player data here
    end
end)

-- Server Health Monitoring
CreateThread(function()
    while true do
        Wait(60000) -- Check server health every minute
        local memoryUsage = collectgarbage("count") / 1024 -- Memory in MB
        print(string.format('[LUXCore] Server memory usage: %.2f MB', memoryUsage))
    end
end)

-- Original Logic Preserved
--[[ 
    LUXCore - Main Initialization Script
    Author: The Lux Empire - LUXCore Systems
    Description: This script handles the initialization of the LUXCore framework, including framework, database, 
    inventory detection, compatibility checks, and dynamic module loading. Built for scalability and extensibility.
]]

LUXCore = {}
LUXCore.Players = {}
LUXCore.Modules = {}

--[[ 
    detectFramework()
    Detects the active framework being used by the server.
    Returns:
        - Framework Name (string): 'QBCore', 'ESX', 'QBox', or nil if no framework is detected.
        - Framework Object (table): Exported object for the detected framework, if available.
]]
function detectFramework()
    if GetResourceState('qb-core') == 'started' then 
        return 'QBCore', exports['qb-core']
    elseif GetResourceState('es_extended') == 'started' then 
        return 'ESX', exports['es_extended']
    elseif GetResourceState('qbox-core') == 'started' then 
        return 'QBox', exports['qbox-core']
    end
    return nil, nil
end

--[[ 
    detectDatabase()
    Detects the active database system being used by the server.
    Returns:
        - Database Name (string): 'oxmysql', 'postgresql', or nil if no database is detected.
        - Database Object (table): Exported object for the detected database, if available.
]]
function detectDatabase()
    if GetResourceState('oxmysql') == 'started' then 
        return 'oxmysql', exports.oxmysql
    elseif Config.Database.PostgreSQL.Enabled then 
        return 'postgresql', nil
    end
    return nil, nil
end

--[[ 
    detectInventory()
    Detects the active inventory system being used by the server.
    Returns:
        - Inventory Name (string): Name of the detected inventory system or nil if no system is detected.
]]
function detectInventory()
    for _, inv in ipairs(Config.Modules.Inventory.SupportedInventories) do
        if GetResourceState(inv) == 'started' then 
            return inv 
        end
    end
    return nil
end

--[[ 
    checkVersionCompatibility()
    Performs compatibility checks to ensure detected frameworks and databases are properly initialized.
    Logs errors if any critical systems are missing or not started.
]]
function checkVersionCompatibility()
    if LUXCore.Framework == 'QBCore' and GetResourceState('qb-core') ~= 'started' then
        print("^1[Compatibility] Error: QBCore is not properly initialized.^0")
    end
    if LUXCore.Database == 'oxmysql' and GetResourceState('oxmysql') ~= 'started' then
        print("^1[Compatibility] Error: oxmysql is not running.^0")
    end
end

--[[ 
    LUXCore.LoadModules()
    Dynamically loads all core modules for LUXCore. Each module is expected to follow a specific structure for 
    seamless integration.
]]
function LUXCore.LoadModules()
    local modules = {
        "server/events.lua",
        "server/functions.lua",
        "server/inventory.lua",
        "server/performance.lua",
        "server/devtools.lua",
        "server/loader.lua"
    }

    for _, module in ipairs(modules) do
        local success, err = pcall(function() dofile(module) end)
        if success then
            print("^2[LUXCore] Module Loaded: ^0" .. module)
        else
            print("^1[LUXCore] Failed to Load Module: ^0" .. module .. " - " .. err)
        end
    end
end

--[[ 
    LUXCore.Initialize()
    Entry point for initializing the LUXCore framework. Handles framework, database, inventory detection, and 
    performs validation and module loading.
]]
function LUXCore.Initialize()
    -- Detect Framework, Database, and Inventory
    LUXCore.Framework, LUXCore.FrameworkObject = detectFramework()
    LUXCore.Database, LUXCore.DatabaseObject = detectDatabase()
    LUXCore.Inventory = detectInventory()

    -- Debug Logging
    if Config.Debug then
        print(string.format("[LUXCore] Detected Framework: %s", LUXCore.Framework or "None"))
        print(string.format("[LUXCore] Detected Database: %s", LUXCore.Database or "None"))
        print(string.format("[LUXCore] Detected Inventory: %s", LUXCore.Inventory or "None"))
    end

    -- Perform Version Compatibility Check
    checkVersionCompatibility()

    -- Validate Configuration
    if not Config.Validate() then
        print("^1[LUXCore] Initialization aborted due to configuration errors.^0")
        return
    end

    -- Load Core Modules
    LUXCore.LoadModules()

    print("^2[LUXCore] Initialization completed successfully.^0")
end

-- Auto-Start Initialization
LUXCore.Initialize()

