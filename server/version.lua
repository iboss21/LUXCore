LUX.Version = "1.0.0"
LUX.UpdateChecker = {}

-- Check for Updates
function LUX.UpdateChecker.Check()
    PerformHttpRequest("https://example.com/luxcore/latest-version", function(err, text, headers)
        if err == 200 and text then
            local latestVersion = text:match("^%s*(.-)%s*$") -- Trim whitespace
            if LUX.UpdateChecker.IsNewVersion(latestVersion) then
                LUX.Functions.Log("A new version of LUXCore is available: " .. latestVersion, "info", "UpdateChecker")

                -- Log to Discord if enabled
                if Config.Logging.Discord.Enabled then
                    LUX.Logging.DiscordLog("A new version of LUXCore is available: " .. latestVersion, "info")
                end

                -- Notify console
                print(string.format("^2[LUXCore]^0: Update available! Current version: %s | Latest version: %s", LUX.Version, latestVersion))
            else
                LUX.Functions.Log("LUXCore is up to date. Current version: " .. LUX.Version, "info", "UpdateChecker")
            end
        else
            LUX.Functions.Log("Failed to check for updates. Error: " .. tostring(err), "error", "UpdateChecker")
        end
    end, "GET")
end

-- Check if a new version is available
function LUX.UpdateChecker.IsNewVersion(latestVersion)
    if not latestVersion or latestVersion == "" then
        return false
    end

    local currentParts = LUX.Version:split("%.")
    local latestParts = latestVersion:split("%.")

    for i = 1, math.max(#currentParts, #latestParts) do
        local current = tonumber(currentParts[i] or 0) or 0
        local latest = tonumber(latestParts[i] or 0) or 0

        if latest > current then
            return true
        elseif latest < current then
            return false
        end
    end

    return false
end

-- Utility function: Split string into parts
function string:split(delimiter)
    local result = {}
    for match in (self .. delimiter):gmatch("(.-)" .. delimiter) do
        table.insert(result, match)
    end
    return result
end

-- Periodic Update Check
function LUX.UpdateChecker.Start(interval)
    interval = interval or 86400000 -- Default to 24 hours
    CreateThread(function()
        while true do
            Wait(interval)
            LUX.UpdateChecker.Check()
        end
    end)
end

-- Command to Manually Check for Updates
RegisterCommand("luxcore:updatecheck", function(source)
    if source ~= 0 then
        return -- Only allow console to execute
    end

    LUX.Functions.Log("Manually checking for updates...", "info", "UpdateChecker")
    LUX.UpdateChecker.Check()
end, false)

-- Start the periodic update check
LUX.UpdateChecker.Start(86400000) -- Default to every 24 hours
