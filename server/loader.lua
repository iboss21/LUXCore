LUX.Loader = {}

-- Load Modules Dynamically
function LUX.Loader.LoadModules(moduleList, moduleType)
    if not moduleList or type(moduleList) ~= "table" then
        LUX.Functions.Log("Invalid module list provided for loading.", "error", "Loader")
        return
    end

    for _, module in ipairs(moduleList) do
        local modulePath = string.format("%s/%s", moduleType or "shared", module)
        if Config.Debug then
            LUX.Functions.Log("Attempting to load module: " .. modulePath, "info", "Loader")
        end
        local success, err = pcall(function()
            dofile(modulePath)
        end)
        if not success then
            LUX.Functions.Log("Failed to load module: " .. modulePath .. " - " .. tostring(err), "error", "Loader")
        else
            LUX.Functions.Log("Successfully loaded module: " .. modulePath, "info", "Loader")
        end
    end
end

-- Load All Shared Modules
function LUX.Loader.LoadSharedModules()
    local sharedModules = {
        'functions.lua',
        'config.lua',
        'locale.lua'
    }
    LUX.Loader.LoadModules(sharedModules, "shared")
end

-- Load All Server-Side Modules
function LUX.Loader.LoadServerModules()
    local serverModules = {
        'main.lua',
        'events.lua',
        'functions.lua',
        'database.lua'
    }
    LUX.Loader.LoadModules(serverModules, "server")
end

-- Load All Client-Side Modules
function LUX.Loader.LoadClientModules()
    local clientModules = {
        'main.lua',
        'events.lua',
        'functions.lua',
        'ui.lua'
    }
    LUX.Loader.LoadModules(clientModules, "client")
end

-- Initialize Loader
function LUX.Loader.Initialize()
    LUX.Functions.Log("Initializing LUXCore Modules...", "info", "Loader")
    
    -- Load Shared Modules
    LUX.Loader.LoadSharedModules()

    -- Load Server-Side or Client-Side Modules
    if IsDuplicityVersion() then
        LUX.Loader.LoadServerModules()
    else
        LUX.Loader.LoadClientModules()
    end

    LUX.Functions.Log("LUXCore Modules Loaded Successfully!", "info", "Loader")
end
