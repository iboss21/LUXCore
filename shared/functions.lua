LUX = {}
LUX.Functions = {}
LUX.Modules = {}
LUX.Config = {}

-- Advanced Logging Functionality with File and API Support
function LUX.Functions.Log(message, level, module, saveToFile)
    local levels = {["info"] = "^2INFO^0", ["warning"] = "^3WARNING^0", ["error"] = "^1ERROR^0", ["debug"] = "^5DEBUG^0"}
    local prefix = string.format("[%s] [%s] [%s]: ", os.date("%Y-%m-%d %H:%M:%S"), levels[level or "info"], module or "LUXCore")
    print(prefix .. message)

    -- Save to file if enabled
    if saveToFile and Config.Logging.FileManager.Enabled then
        local logFile = string.format("%s/%s.log", Config.Logging.FileManager.Path or "logs", os.date("%Y-%m-%d"))
        local file = io.open(logFile, "a")
        if file then
            file:write(prefix .. message .. "\n")
            file:close()
        end
    end

    -- Send to API if enabled
    if Config.Logging.API.Enabled then
        PerformHttpRequest(Config.Logging.API.Endpoint, function(err, response, headers) end, "POST", json.encode({
            timestamp = os.date("%Y-%m-%d %H:%M:%S"),
            level = level,
            module = module,
            message = message,
            apiKey = Config.Logging.API.APIKey
        }), {["Content-Type"] = "application/json"})
    end
end

-- Multilingual Support with Dynamic Fallback
function LUX.Functions.Translate(key, ...)
    local translations = Locale.Languages[Config.Locale] or {}
    local fallbackTranslations = Locale.Languages["en"] or {} -- Fallback to English if key not found
    local template = translations[key] or fallbackTranslations[key]
    if template then
        return string.format(template, ...)
    end
    return key -- Return the key itself if no translation is found
end

-- Module Initialization
function LUX.Functions.InitializeModules()
    for moduleName, module in pairs(LUX.Modules) do
        if module.Initialize then
            LUX.Functions.Log("Initializing module: " .. moduleName, "info", "ModuleManager")
            module:Initialize()
        end
    end
end

-- Framework Detection and Setup
function LUX.Functions.DetectFramework()
    local framework = Config.FrameworkDetection.PreferredFramework
    if not framework and Config.FrameworkDetection.AutoDetect then
        if GetResourceState("qb-core") == "started" then
            framework = "QBCore"
        elseif GetResourceState("es_extended") == "started" then
            framework = "ESX"
        end
    end
    LUX.Functions.Log("Framework detected: " .. (framework or "None"), "info", "FrameworkDetection")
    return framework
end

-- Error Handling Wrapper
function LUX.Functions.SafeCall(func, ...)
    local status, result = pcall(func, ...)
    if not status then
        LUX.Functions.Log("Error: " .. tostring(result), "error", "SafeCall")
    end
    return result
end

-- Performance Monitoring
function LUX.Functions.TrackPerformance(actionName, func, ...)
    local startTime = os.clock()
    local result = {LUX.Functions.SafeCall(func, ...)}
    local endTime = os.clock()
    local elapsedTime = math.floor((endTime - startTime) * 1000) -- Time in ms
    LUX.Functions.Log(string.format("Action '%s' completed in %dms", actionName, elapsedTime), "debug", "PerformanceTracker")
    return table.unpack(result)
end

-- Event Registration Helper
function LUX.Functions.RegisterEvent(eventName, handler)
    RegisterNetEvent(eventName)
    AddEventHandler(eventName, function(...)
        LUX.Functions.SafeCall(handler, ...)
    end)
    LUX.Functions.Log("Event registered: " .. eventName, "info", "EventManager")
end

-- Command Registration Helper
function LUX.Functions.RegisterCommand(commandName, handler, restricted, description)
    RegisterCommand(commandName, function(source, args, rawCommand)
        LUX.Functions.SafeCall(handler, source, args, rawCommand)
    end, restricted or false)
    LUX.Functions.Log("Command registered: " .. commandName .. " (" .. (description or "No Description") .. ")", "info", "CommandManager")
end

-- Database Query Wrapper
function LUX.Functions.DatabaseQuery(query, parameters, callback)
    local dbType, dbObject = LUX.Database.Detect()
    if dbType == "oxmysql" then
        dbObject:execute(query, parameters, callback)
    elseif dbType == "mysql-async" then
        dbObject.Async.fetchAll(query, parameters, callback)
    else
        LUX.Functions.Log("No supported database detected for query: " .. query, "error", "Database")
    end
end

-- Utility Functions
function LUX.Functions.DeepCopy(original)
    local copy
    if type(original) == "table" then
        copy = {}
        for k, v in pairs(original) do
            copy[k] = LUX.Functions.DeepCopy(v)
        end
    else
        copy = original
    end
    return copy
end

function LUX.Functions.TableLength(tbl)
    local count = 0
    for _ in pairs(tbl) do count = count + 1 end
    return count
end

-- Global Initialization
function LUX.Initialize()
    LUX.Functions.Log("LUXCore initialization started...", "info", "LUXCore")
    LUX.Config.Framework = LUX.Functions.DetectFramework()
    LUX.Functions.InitializeModules()
    LUX.Functions.Log("LUXCore initialization completed successfully!", "info", "LUXCore")
end
