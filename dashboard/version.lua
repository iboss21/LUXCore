LUX.Version = "1.0.0"
LUX.UpdateChecker = {}

-- Configuration for Update Checker
LUX.UpdateChecker.Config = {
    UpdateURL = "https://example.com/luxcore/latest-version", -- URL to fetch the latest version
    CheckInterval = 86400000, -- Periodic check interval (24 hours)
    RetryInterval = 600000, -- Retry interval in case of failure (10 minutes)
    NotifyOnUpdate = true -- Enable notifications for updates
}

-- Check for Updates
function LUX.UpdateChecker.Check(callback)
    LUX.Functions.Log("Checking for updates...", "info", "UpdateChecker")

    PerformHttpRequest(LUX.UpdateChecker.Config.UpdateURL, function(err, text, headers)
        local latestVersion = text and text:match("%S+") -- Trim any extra spaces or newlines
        local updateAvailable = false

        if err == 200 and latestVersion then
            if latestVersion ~= LUX.Version then
                updateAvailable = true
                LUX.Functions.Log("A new version of LUXCore is available: " .. latestVersion, "info", "UpdateChecker")
                if LUX.UpdateChecker.Config.NotifyOnUpdate then
                    LUX.UpdateChecker.Notify(latestVersion)
                end
            else
                LUX.Functions.Log("LUXCore is up to date. Current version: " .. LUX.Version, "info", "UpdateChecker")
            end
        else
            LUX.Functions.Log("Failed to check for updates. Retrying in " .. (LUX.UpdateChecker.Config.RetryInterval / 60000) .. " minutes.", "error", "UpdateChecker")
            Wait(LUX.UpdateChecker.Config.RetryInterval)
            LUX.UpdateChecker.Check() -- Retry on failure
        end

        if callback then
            callback(updateAvailable, latestVersion)
        end
    end)
end

-- Notify Users of Updates
function LUX.UpdateChecker.Notify(latestVersion)
    local updateMessage = string.format("🚀 A new version of LUXCore is available! Current version: %s | Latest version: %s", LUX.Version, latestVersion)

    -- Log to Console
    LUX.Functions.Log(updateMessage, "info", "UpdateChecker")

    -- Optional: Broadcast to in-game players (e.g., admins)
    for _, player in ipairs(GetPlayers()) do
        if IsPlayerAdmin(player) then -- Replace with your admin check logic
            TriggerClientEvent('chat:addMessage', player, {
                args = { "[LUXCore]", updateMessage },
                color = { 255, 165, 0 }
            })
        end
    end
end

-- Periodic Update Check
CreateThread(function()
    while true do
        LUX.UpdateChecker.Check()
        Wait(LUX.UpdateChecker.Config.CheckInterval) -- Wait before next check
    end
end)

-- Manual Update Check Command
LUX.Functions.RegisterCommand("checkupdates", function(source)
    if source == 0 then -- Console command
        LUX.UpdateChecker.Check(function(updateAvailable, latestVersion)
            if updateAvailable then
                LUX.Functions.Log("Update available! Latest version: " .. latestVersion, "info", "UpdateChecker")
            else
                LUX.Functions.Log("No updates available. You are up-to-date!", "info", "UpdateChecker")
            end
        end)
    else
        TriggerClientEvent('chat:addMessage', source, {
            args = { "[LUXCore]", "Update check initiated. Please check the console for results." },
            color = { 255, 165, 0 }
        })
    end
end, true, "Manually check for updates.")
