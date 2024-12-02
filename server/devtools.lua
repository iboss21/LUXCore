LUX.Dev = {}

-- Live Reload Script Functionality
function LUX.Dev.ReloadScript(scriptName)
    if not scriptName or scriptName == "" then
        LUX.Functions.Log("No script name provided for reload.", "error", "DevTools")
        return
    end
    TriggerEvent("luxcore:reloadScript", scriptName)
end

-- Console Command Example
RegisterCommand("luxcore:test", function(source, args)
    if source ~= 0 then
        return
    end
    LUX.Functions.Log("Testing LUXCore Console Command", "info", "DevTools")
end, false)
