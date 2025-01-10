LUX.Logging = {}

-- Discord Log
function LUX.Logging.DiscordLog(message, level)
    if not Config.Logging.Discord.Enabled or not Config.Logging.Discord.WebhookURL then
        LUX.Functions.Log("Discord logging is disabled or webhook URL is not configured.", "warning", "Logging")
        return
    end

    local embed = {{
        ["title"] = string.format("%s Log", string.upper(level or "INFO")),
        ["description"] = message,
        ["color"] = level == "error" and 15158332 or (level == "warning" and 15844367 or 3066993),
        ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
    }}

    PerformHttpRequest(Config.Logging.Discord.WebhookURL, function(err, text, headers)
        if err ~= 200 then
            LUX.Functions.Log("Failed to send Discord log: " .. (text or "Unknown error"), "error", "Logging")
        end
    end, "POST", json.encode({embeds = embed}), {["Content-Type"] = "application/json"})
end

-- File Log
function LUX.Logging.FileLog(message, level)
    if not Config.Logging.FileManager.Enabled then
        LUX.Functions.Log("File logging is disabled.", "warning", "Logging")
        return
    end

    local logFile = string.format("%s/%s.log", Config.Logging.FileManager.Path, os.date("%Y-%m-%d"))
    local logMessage = string.format("[%s] [%s]: %s\n", os.date("%H:%M:%S"), string.upper(level or "INFO"), message)

    local file, err = io.open(logFile, "a")
    if not file then
        LUX.Functions.Log("Failed to write to log file: " .. (err or "Unknown error"), "error", "Logging")
        return
    end

    file:write(logMessage)
    file:close()
end

-- Centralized Log Function
function LUX.Logging.Log(message, level)
    level = string.lower(level or "info")

    -- Console Logging
    LUX.Functions.Log(message, level, "Logging")

    -- Discord Logging
    if Config.Logging.Discord.Enabled then
        LUX.Logging.DiscordLog(message, level)
    end

    -- File Logging
    if Config.Logging.FileManager.Enabled then
        LUX.Logging.FileLog(message, level)
    end
end

-- API Logging
function LUX.Logging.APILog(message, level)
    if not Config.Logging.API.Enabled or not Config.Logging.API.Endpoint then
        LUX.Functions.Log("API logging is disabled or endpoint is not configured.", "warning", "Logging")
        return
    end

    PerformHttpRequest(Config.Logging.API.Endpoint, function(err, text, headers)
        if err ~= 200 then
            LUX.Functions.Log("Failed to send API log: " .. (text or "Unknown error"), "error", "Logging")
        end
    end, "POST", json.encode({
        level = string.upper(level or "INFO"),
        message = message,
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
        apiKey = Config.Logging.API.APIKey
    }), {["Content-Type"] = "application/json"})
end
