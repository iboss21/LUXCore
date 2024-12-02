LUX.Logging = {}

function LUX.Logging.DiscordLog(message, level)
    if not Config.Logging.Discord.Enabled or not Config.Logging.Discord.WebhookURL then
        return
    end
    local embed = {{
        ["title"] = string.format("%s Log", level),
        ["description"] = message,
        ["color"] = level == "error" and 15158332 or 3066993,
        ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
    }}
    PerformHttpRequest(Config.Logging.Discord.WebhookURL, function(err, text, headers) end, "POST", json.encode({embeds = embed}), {["Content-Type"] = "application/json"})
end

function LUX.Logging.FileLog(message, level)
    if not Config.Logging.FileManager.Enabled then return end
    local logFile = string.format("%s/%s.log", Config.Logging.FileManager.Path, os.date("%Y-%m-%d"))
    local logMessage = string.format("[%s] [%s]: %s\n", os.date("%H:%M:%S"), level or "info", message)
    local file = io.open(logFile, "a")
    if file then
        file:write(logMessage)
        file:close()
    end
end
