LUXCore = {}
LUXCore.Players = {}

-- Initialize LUXCore
CreateThread(function()
    LUXCore.Framework = detectFramework()
    LUXCore.Database = detectDatabase()
    LUXCore.Inventory = detectInventory()
    if Config.Debug then
        print(string.format("[LUXCore] Detected Framework: %s", LUXCore.Framework or "None"))
        print(string.format("[LUXCore] Detected Database: %s", LUXCore.Database or "None"))
        print(string.format("[LUXCore] Detected Inventory: %s", LUXCore.Inventory or "None"))
    end
end)

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

local function VerifyResourceName()
    local resourceName = GetCurrentResourceName()
    if resourceName ~= "LUXCore" then
        print("^1[LUXCore] ERROR: Resource folder has been renamed to '" .. resourceName .. "'. Shutting down...^0")
        if Config.Logging.Discord.Enabled then
            LUX.Logging.DiscordLog("Resource folder renamed to '" .. resourceName .. "'. Shutting down LUXCore.", "error")
        end
        StopResource(resourceName)
        return false
    end
    return true
end

-- Call the verification function on resource start
AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        VerifyResourceName()
    end
end)
