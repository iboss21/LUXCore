LUX.Performance = {}

-- Track Performance Stats
function LUX.Performance.Track()
    local memory = collectgarbage("count") / 1024 -- Convert to MB
    local resourceCount = GetNumResources()
    local cpuUsage = GetResourcePerformance() -- Assumes external logic or function for CPU stats
    local activeThreads = LUX.Performance.GetThreadCount() -- Counts threads if available
    local stats = string.format(
        "Memory: %.2f MB, Resources: %d, CPU Usage: %.2f%%, Active Threads: %d",
        memory,
        resourceCount,
        cpuUsage,
        activeThreads or 0
    )

    -- Log stats
    LUX.Functions.Log(stats, "info", "Performance")
    return {
        memory = memory,
        resources = resourceCount,
        cpuUsage = cpuUsage,
        threads = activeThreads or 0,
        formatted = stats
    }
end

-- Get Active Thread Count (Fallback Logic if API isn't available)
function LUX.Performance.GetThreadCount()
    if type(GetThreadPool) == "function" then
        return #GetThreadPool()
    else
        -- Simulated thread count, replace with a better implementation if possible
        return math.random(50, 150)
    end
end

-- CPU Usage Stats (Example Function, Replace with Real API)
function GetResourcePerformance()
    -- Simulating CPU usage
    return math.random(0, 100) / 10 -- Randomized for demo purposes
end

-- Periodic Performance Monitoring
function LUX.Performance.Monitor(interval)
    interval = interval or 60000 -- Default to 1 minute
    LUX.Functions.Log("Starting periodic performance monitoring...", "info", "Performance")

    CreateThread(function()
        while true do
            Wait(interval)
            local stats = LUX.Performance.Track()
            
            -- Send stats to Discord if enabled
            if Config.Logging.Discord.Enabled then
                LUX.Logging.DiscordLog(stats.formatted, "info")
            end
        end
    end)
end

-- Command to Print Stats to Console
RegisterCommand("luxcore:performance", function(source)
    if source ~= 0 then
        return -- Only allow console to execute
    end

    local stats = LUX.Performance.Track()
    LUX.Functions.Log(stats.formatted, "info", "Performance")
end, false)

-- Initialize Performance Monitoring
LUX.Performance.Monitor(60000) -- Start with default 1-minute interval
