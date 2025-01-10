LUXCore = {}
LUXCore.Players = {}

-- Framework, Database, Inventory Detection
function detectFramework()
    if GetResourceState('qb-core') == 'started' then return 'QBCore'
    elseif GetResourceState('es_extended') == 'started' then return 'ESX'
    elseif GetResourceState('qbox-core') == 'started' then return 'QBox' end
    return nil
end

function detectDatabase()
    if GetResourceState('oxmysql') == 'started' then return 'oxmysql'
    elseif Config.Database.PostgreSQL.Enabled then return 'postgresql' end
    return nil
end

function detectInventory()
    for _, inv in ipairs(Config.Modules.Inventory.SupportedInventories) do
        if GetResourceState(inv) == 'started' then return inv end
    end
    return nil
end

-- Initialize LUXCore
function LUXCore.Initialize()
    -- Detect Framework
    LUXCore.Framework = detectFramework()
    LUXCore.Database = detectDatabase()
    LUXCore.Inventory = detectInventory()

    -- Debug Logging
    if Config.Debug then
        LUX.Functions.Log(string.format("Detected Framework: %s", LUXCore.Framework or "None"), "info", "Initialization")
        LUX.Functions.Log(string.format("Detected Database: %s", LUXCore.Database or "None"), "info", "Initialization")
        LUX.Functions.Log(string.format("Detected Inventory: %s", LUXCore.Inventory or "None"), "info", "Initialization")
    end

    -- Verify Resource Name
    if not VerifyResourceName() then
        return
    end

    -- Framework-Specific Initialization
    LUXCore.InitializeFramework()
end

-- Framework-Specific Initialization
function LUXCore.InitializeFramework()
    if LUXCore.Framework == 'QBCore' then
        LUX.Functions.Log("Initializing QBCore-specific features.", "info", "Initialization")
        -- Add QBCore-specific initialization logic here
    elseif LUXCore.Framework == 'ESX' then
        LUX.Functions.Log("Initializing ESX-specific features.", "info", "Initialization")
        -- Add ESX-specific initialization logic here
    elseif LUXCore.Framework == 'QBox' then
        LUX.Functions.Log("Initializing QBox-specific features.", "info", "Initialization")
        -- Add QBox-specific initialization logic here
    else
        LUX.Functions.Log("No framework detected. Initialization skipped.", "warning", "Initialization")
    end
end

-- Verify Resource Name
local function VerifyResourceName()
    local resourceName = GetCurrentResourceName()
    if resourceName ~= "LUXCore" then
        LUX.Functions.Log("Resource folder has been renamed to '" .. resourceName .. "'. Shutting down...", "error", "Initialization")
        if Config.Logging.Discord.Enabled then
            LUX.Logging.DiscordLog("Resource folder renamed to '" .. resourceName .. "'. Shutting down LUXCore.", "error")
        end
        StopResource(resourceName)
        return false
    end
    return true
end

-- Resource Event Handling
AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        LUXCore.Initialize()
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        LUX.Functions.Log("LUXCore resource stopped.", "info", "Resource")
    end
end)

-- Reload Command (For Development)
RegisterCommand('luxcore:reload', function(source)
    if source ~= 0 then
        return -- Allow only console to reload
    end

    LUXCore.Initialize()
    LUX.Functions.Log("LUXCore reloaded successfully.", "info", "Reload")
end, false)

-- Debug Command
RegisterCommand('luxcore:debug', function(source, args)
    if source ~= 0 then
        return -- Allow only console to debug
    end

    LUX.Functions.Log("LUXCore Debug Information:", "info", "Debug")
    LUX.Functions.Log("Framework: " .. (LUXCore.Framework or "None"), "info", "Debug")
    LUX.Functions.Log("Database: " .. (LUXCore.Database or "None"), "info", "Debug")
    LUX.Functions.Log("Inventory: " .. (LUXCore.Inventory or "None"), "info", "Debug")
end, false)
