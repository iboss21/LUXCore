LUX = LUX or {}
LUX.Dev = {}

-- Live Reload Script Functionality
function LUX.Dev.ReloadScript(scriptName)
    if not scriptName or scriptName == "" then
        LUX.Functions.Log("No script name provided for reload.", "error", "DevTools")
        return
    end
    LUX.Functions.Log("Reloading script: " .. scriptName, "info", "DevTools")
    TriggerEvent("luxcore:reloadScript", scriptName)
end

-- Live Resource Restart
function LUX.Dev.RestartResource(resourceName)
    if not resourceName or resourceName == "" then
        LUX.Functions.Log("No resource name provided for restart.", "error", "DevTools")
        return
    end
    LUX.Functions.Log("Restarting resource: " .. resourceName, "info", "DevTools")
    ExecuteCommand("restart " .. resourceName)
end

-- Memory Usage Logging
function LUX.Dev.LogMemoryUsage()
    local memory = collectgarbage("count")
    LUX.Functions.Log(string.format("Current memory usage: %.2f KB", memory), "info", "DevTools")
end

-- Performance Monitoring
function LUX.Dev.LogPerformance()
    local resources = GetNumResources()
    local resourceList = {}

    for i = 0, resources - 1 do
        local resourceName = GetResourceByFindIndex(i)
        local resourceState = GetResourceState(resourceName)
        table.insert(resourceList, { name = resourceName, state = resourceState })
    end

    LUX.Functions.Log("Performance Report:", "info", "DevTools")
    for _, resource in ipairs(resourceList) do
        LUX.Functions.Log(string.format("Resource: %s | State: %s", resource.name, resource.state), "debug", "DevTools")
    end
end

-- Console Command for Testing
RegisterCommand("luxcore:test", function(source, args)
    if source ~= 0 then
        return
    end
    LUX.Functions.Log("Testing LUXCore Console Command", "info", "DevTools")

    -- Example Tests
    LUX.Dev.LogMemoryUsage()
    LUX.Dev.LogPerformance()
end, false)

-- Console Command to Reload Script
RegisterCommand("luxcore:reload", function(source, args)
    if source ~= 0 then
        return
    end
    local scriptName = args[1]
    if not scriptName or scriptName == "" then
        LUX.Functions.Log("Usage: luxcore:reload <script_name>", "error", "DevTools")
        return
    end
    LUX.Dev.ReloadScript(scriptName)
end, false)

-- Console Command to Restart Resource
RegisterCommand("luxcore:restart", function(source, args)
    if source ~= 0 then
        return
    end
    local resourceName = args[1]
    if not resourceName or resourceName == "" then
        LUX.Functions.Log("Usage: luxcore:restart <resource_name>", "error", "DevTools")
        return
    end
    LUX.Dev.RestartResource(resourceName)
end, false)

-- Periodic Memory Usage Logging (Optional)
CreateThread(function()
    while true do
        Wait(3600000) -- Log every hour
        LUX.Dev.LogMemoryUsage()
    end
end)
