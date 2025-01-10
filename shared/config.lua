Config = {}

-- General Settings
Config.Debug = true -- Enable/Disable Debug Mode
Config.Locale = 'en' -- Default Locale for Translations
Config.BannerColor = '#FF4500' -- Hex Color for Banners
Config.ServerLogo = 'https://example.com/logo.png' -- URL to Server Logo
Config.Version = '1.0.0' -- Framework/Server Version
Config.MaintenanceMode = false -- Enable Maintenance Mode for Updates

-- Framework Detection
Config.FrameworkDetection = {
    AutoDetect = true, -- Auto Detect Framework
    PreferredFramework = nil -- Set Preferred Framework ('QBCore', 'ESX', 'QBox') or nil for Auto-Detect
}

-- Database Settings
Config.Database = {
    UseOxmysql = true, -- Prefer oxmysql for Database
    Debug = false, -- Enable Debugging for Database Queries
    SlowQueryWarning = 500, -- Log Queries Taking Longer Than This (ms)
    PoolSize = 5, -- Database Connection Pool Size
    FallbackToSQLite = true, -- Use SQLite if Other Databases Are Not Available
    PostgreSQL = {
        Enabled = false, -- Enable PostgreSQL
        ConnectionString = "postgres://user:password@localhost:5432/database" -- PostgreSQL Connection String
    },
    SQLite = {
        Path = "database.sqlite", -- SQLite Database File Path
    }
}

-- Logging Settings
Config.Logging = {
    Enabled = true, -- Enable Logging
    Levels = { 'info', 'warning', 'error', 'debug' }, -- Allowed Log Levels
    Discord = {
        Enabled = true, -- Log to Discord Webhook
        WebhookURL = "https://discord.com/api/webhooks/example", -- Webhook URL
        RoleBasedAccess = true, -- Role-Based Logging on Discord
        Throttle = 60 -- Minimum Interval (Seconds) Between Logs to Discord
    },
    FileManager = {
        Enabled = true, -- Save Logs to Files
        Path = "logs/", -- Directory for Log Files
        MaxFileSizeMB = 10, -- Max File Size Before Rolling Over
        RetentionDays = 30 -- Days to Retain Old Logs
    },
    API = {
        Enabled = true, -- Log to External API
        Endpoint = "https://example.com/api/logs", -- API Endpoint
        APIKey = "your-api-key" -- API Authentication Key
    }
}

-- Server Maintenance
Config.Maintenance = {
    Enabled = false, -- Maintenance Mode Toggle
    KickMessage = "Server is under maintenance. Please try again later." -- Message for Players During Maintenance
}

-- Feature Toggles
Config.Features = {
    UseWeatherSync = true, -- Enable Weather Synchronization
    UseRealTime = false, -- Use Real-World Time on the Server
    EnableVoiceProximity = true -- Enable Proximity-Based Voice Chat
}

-- Module Configuration
Config.Modules = {
    Inventory = {
        AutoDetect = true, -- Auto-Detect Inventory System
        SupportedInventories = { -- Supported Inventory Systems
            'tgiann-inventory', 'ox_inventory', 'qs-inventory', 'ps-inventory', 'disc-inventory'
        }
    },
    Appearance = {
        AutoDetect = true, -- Auto-Detect Appearance System
        SupportedSystems = { -- Supported Appearance Systems
            'illenium-appearance', 'qb-clothing', 'fivem-appearance'
        }
    },
    Economy = {
        CurrencySymbol = '$', -- In-Game Currency Symbol
        InflationRate = 1.02, -- Adjusts Economy for Roleplay (1.00 = No Change)
        TaxRates = { -- Taxes for Various Activities
            Income = 0.15, -- Income Tax (15%)
            Sales = 0.08 -- Sales Tax (8%)
        }
    }
}

-- Event System
Config.Events = {
    AutoCleanup = true, -- Automatically Cleanup Unused Objects
    EventLogLevel = 'info', -- Log Level for Event Notifications
    MaxConcurrentEvents = 10 -- Max Simultaneous Events
}

-- Notification System
Config.Notifications = {
    DefaultDuration = 5000, -- Default Notification Display Time (ms)
    UseCustomStyles = true, -- Enable Custom Notification Styles
    BannerURL = "https://example.com/banner.png" -- URL for Notification Banner
}

-- Security Settings
Config.Security = {
    AntiCheatEnabled = true, -- Enable Anti-Cheat System
    MaxLoginAttempts = 5, -- Maximum Allowed Login Attempts
    IPWhitelist = { '127.0.0.1', '192.168.1.1' }, -- Whitelisted IPs
    VPNDetection = true, -- Detect and Restrict VPN Connections
    AutoBanThreshold = 3 -- Number of Violations Before Automatic Ban
}

-- Debugging and Developer Tools
Config.DevTools = {
    EnableConsole = true, -- Enable In-Game Console for Debugging
    ShowFPS = true, -- Display FPS Counter for Developers
    DebugLogsToFile = true -- Save Debug Logs to File
}

-- UI Configuration
Config.UI = {
    Theme = 'dark', -- Default Theme (light/dark)
    WelcomeMessage = "Welcome to Our Server! Enjoy Your Stay.", -- Custom Welcome Message
    EnableHUD = true, -- Enable Heads-Up Display
    CustomHUDPath = "hud/custom_hud.html" -- Path to Custom HUD
}

-- Additional Enhancements
Config.Performance = {
    EnableResourceMonitor = true, -- Enable Real-Time Resource Monitoring
    AutoOptimize = true, -- Automatically Optimize Server Resources
    GarbageCollectorInterval = 60000 -- Interval (ms) for Garbage Collection
}
