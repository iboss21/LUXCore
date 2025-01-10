LUX.Version = "1.0.0"
LUX.UpdateChecker = {}

-- Configuration for Update Checker
LUX.UpdateChecker.Config = {
    UpdateURL = "https://example.com/luxcore/latest-version",
    CheckInterval = 86400000, -- Check every 24 hours (in ms)
    RetryInterval = 600000, -- Retry failed checks every 10 minutes
    NotifyDiscord = true, -- Send update notifications to Discord
    NotifyInConsole = true -- Log updates in the console
}

-- Check for Updates
function LUX.UpdateChecker.Check()
    LUX.Functions.Log("Checking for updates...", "info", "UpdateChecker")

    PerformHttpRequest(LUX.UpdateChecker.Config.UpdateURL, function(err, text, headers)
        if err == 200 and text then
            local latestVersion = text:match("%S+") -- Trim any extra spaces or newlines
            if latestVersion and latestVersion ~= LUX.Version then
                LUX.UpdateChecker.Notify(latestVersion)
            else
                LUX.Functions.Log("LUXCore is up to date. Current version: " .. LUX.Version, "info", "UpdateChecker")
            end
        else
            LUX.Functions.Log("Failed to check for updates. Retrying in " .. (LUX.UpdateChecker.Config.RetryInterval / 60000) .. " minutes.", "error", "UpdateChecker")
            Wait(LUX.UpdateChecker.Config.RetryInterval)
            LUX.UpdateChecker.Check() -- Retry on failure
        end
    end)
end

-- Notify Users of Updates
function LUX.UpdateChecker.Notify(latestVersion)
    local updateMessage = string.format("🚀 A new version of LUXCore is available! Current version: %s | Latest version: %s", LUX.Version, latestVersion)

    -- Console Notification
    if LUX.UpdateChecker.Config.NotifyInConsole then
        LUX.Functions.Log(updateMessage, "info", "UpdateChecker")
    end

    -- Discord Notification
    if LUX.UpdateChecker.Config.NotifyDiscord and Config.Logging.Discord.Enabled then
        PerformHttpRequest(Config.Logging.Discord.WebhookURL, function(err, text, headers) end, "POST", json.encode({
            content = updateMessage,
            username = "LUXCore Update Checker"
        }), {["Content-Type"] = "application/json"})
    end

    -- In-Game Notification (Optional)
    for _, player in ipairs(GetPlayers()) do
        TriggerClientEvent('chat:addMessage', player, {
            args = { "[LUXCore]", updateMessage },
            color = { 255, 165, 0 }
        })
    end
end

-- Periodic Update Check
CreateThread(function()
    while true do
        Wait(LUX.UpdateChecker.Config.CheckInterval)
        LUX.UpdateChecker.Check()
    end
end)

-- Manual Update Check Command
LUX.Functions.RegisterCommand("checkupdates", function(source)
    if source == 0 then -- Console-only command
        LUX.UpdateChecker.Check()
    else
        TriggerClientEvent('chat:addMessage', source, {
            args = { "[LUXCore]", "Update check initiated. Please check the console for results." },
            color = { 255, 165, 0 }
        })
    end
end, true, "Manually check for LUXCore updates.")
