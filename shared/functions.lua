LUX = {}
LUX.Functions = {}

-- Advanced Logging Functionality
function LUX.Functions.Log(message, level, module)
    local levels = {["info"] = "^2INFO^0", ["error"] = "^1ERROR^0", ["debug"] = "^3DEBUG^0"}
    local prefix = string.format("[%s] [%s] %s: ", os.date("%Y-%m-%d %H:%M:%S"), levels[level or "info"], module or "LUXCore")
    print(prefix .. message)
end

-- Multilingual Support
function LUX.Functions.Translate(key, ...)
    local translations = Locale.Languages[Config.Locale]
    if translations and translations[key] then
        return string.format(translations[key], ...)
    end
    return key -- Fallback to key if translation not found
end
