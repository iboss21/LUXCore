
-- LUXCore - Development Tools
-- Provides debugging and testing utilities for developers

local Config = require('shared/config')

-- Function to print all active players
function DebugActivePlayers()
    print('[LUXCore DevTools] Listing all active players...')
    -- Logic to list all players currently online
end

-- Register a command to debug active players
RegisterCommand('luxdebugplayers', function()
    DebugActivePlayers()
end, true)
