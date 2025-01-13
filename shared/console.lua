
-- LUXCore - Console Commands
-- Adds advanced commands for server administrators and developers

local Config = require('shared/config')

-- Register a command to toggle debug mode
RegisterCommand('luxdebug', function(source, args, rawCommand)
    Config.General.DebugMode = not Config.General.DebugMode
    print(string.format('[LUXCore] Debug mode toggled: %s', tostring(Config.General.DebugMode)))
end, true)

-- Add more console commands as needed
