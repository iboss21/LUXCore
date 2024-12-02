LUX.Loader = {}

-- Load Modules Dynamically
function LUX.Loader.LoadModules()
    local modules = {
        'shared/functions.lua',
        'server/functions.lua',
        'client/functions.lua'
    }
    for _, module in ipairs(modules) do
        if Config.Debug then
            LUX.Functions.Log("Loading module: " .. module, "info", "Loader")
        end
        local success, err = pcall(function()
            dofile(module)
        end)
        if not success then
            LUX.Functions.Log("Failed to load module: " .. module .. " - " .. err, "error", "Loader")
        end
    end
end
