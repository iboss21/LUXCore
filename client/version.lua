
-- LUXCore - Client Version Management
-- Handles client-side version checks and compatibility validation.

local Config = require('shared/config') -- Load shared configuration

-- Current client version
local currentVersion = Config.Version.CurrentVersion

-- Check compatibility with server version
RegisterNetEvent('luxcore:checkVersion', function(serverVersion)
    print(string.format('[LUXCore] Checking client-server version compatibility: Client [%s], Server [%s]', currentVersion, serverVersion))
    if serverVersion ~= currentVersion then
        print('[LUXCore] WARNING: Version mismatch detected. Please update your client.')
        TriggerEvent('chat:addMessage', { args = { '[LUXCore]', 'Your client version is outdated. Update to the latest version for full compatibility.' } })
    else
        print('[LUXCore] Client and server versions are compatible.')
    end
end)

-- Command to display current client version
RegisterCommand('luxversion', function()
    print(string.format('[LUXCore] Current client version: %s', currentVersion))
    TriggerEvent('chat:addMessage', { args = { '[LUXCore]', string.format('Client Version: %s', currentVersion) } })
end, false)

-- Initialize client version checker
CreateThread(function()
    Wait(2000) -- Wait for server handshake
    TriggerServerEvent('luxcore:getServerVersion') -- Request server version
end)
