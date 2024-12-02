LUX.Performance = {}

-- Track Performance Stats
function LUX.Performance.Track()
    local memory = collectgarbage("count")
    local threads = #GetThreadPool() -- Assumes GetThreadPool function exists
    local stats = string.format("Memory: %.2f MB, Threads: %d", memory / 1024, threads)
    LUX.Functions.Log(stats, "info", "Performance")
    return stats
end

-- Periodic Performance Output
CreateThread(function()
    while true do
        Wait(60000) -- Every minute
        local stats = LUX.Performance.Track()
        if Config.Logging.Discord.Enabled then
            LUX.Logging.DiscordLog(stats, "info")
        end
    end
end)
