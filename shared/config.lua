
-- LUXCore - Configuration File
-- Centralized configuration for all components: server, client, dashboard, and logs.
-- This file ensures modularity and extensive customization.

Config = {}

-- General Settings
Config.General = {
    Framework = 'auto',             -- Framework to use: 'ESX', 'QBCore', or 'auto' for auto-detection.
    DebugMode = true,               -- Enable/disable debug messages (true/false).
    LogToFile = true,               -- Enable/disable logging to file (true/false).
    LogFilePath = 'logs/luxcore.log', -- Path to the log file.
    AutoSaveInterval = 600,         -- Interval in seconds for auto-saving data.
    SessionTimeout = 1800,          -- Time in seconds before inactive players are disconnected.
    MaintenanceMode = false,        -- Enable/disable maintenance mode (true/false).
    MaintenanceMessage = 'The server is under maintenance. Please try again later.' -- Maintenance message for players.
}

-- Version Control
Config.Version = {
    CurrentVersion = '3.0.0',       -- Current version of LUXCore.
    AutoUpdateCheck = true,         -- Automatically check for updates (true/false).
    UpdateCheckInterval = 3600,     -- Interval in seconds for update checks.
    NotifyOnNewVersion = true,      -- Notify admins if a new version is available (true/false).
}

-- UI Settings
Config.UI = {
    EnableAdvancedHUD = true,       -- Enable/disable advanced HUD features (true/false).
    HUDOpacity = 0.85,              -- Opacity level for HUD elements (0.0 to 1.0).
    ThemeColor = '#FF5733',         -- Default theme color for UI elements.
    MinimapEnabled = true,          -- Enable/disable the minimap (true/false).
    ShowHealthBars = true,          -- Display health and armor bars (true/false).
    CrosshairEnabled = false        -- Enable/disable a custom crosshair (true/false).
}

-- Logging Settings
Config.Logging = {
    EnableDiscordLogs = true,       -- Send critical logs to Discord (true/false).
    DiscordWebhookURL = '',         -- Discord webhook URL for logs.
    LogRotation = true,             -- Enable log file rotation (true/false).
    MaxLogFileSize = 10 * 1024,     -- Maximum log file size in kilobytes before rotation.
}

-- Economy Settings
Config.Economy = {
    EnableTaxes = true,             -- Enable/disable taxation (true/false).
    TaxRate = 0.1,                  -- Tax rate applied to transactions (0.0 to 1.0).
    EnableBanking = true,           -- Enable/disable banking system (true/false).
    MaxBankBalance = 1000000        -- Maximum allowable bank balance.
}

-- Combat Settings
Config.Combat = {
    EnableHeadshots = true,         -- Enable/disable headshot multipliers (true/false).
    HeadshotMultiplier = 2.5,       -- Damage multiplier for headshots.
    EnableArmorDecay = true,        -- Enable/disable armor decay over time (true/false).
    ReviveTime = 60                 -- Time in seconds to revive a player.
}

-- Original Content Preserved
--[[ 
    Configuration File for LUXCore
    Author: The Lux Empire - LUXCore Systems
    Description: This file contains all configurable options for the LUXCore framework. 
                 Each setting is structured to provide scalability, extensibility, and clarity.
                 Ensure to modify these values according to your server's requirements.
]]

--Config = {}

--[[ 
    General Settings
    Description: These are the core settings for the framework, including debug options, localization, 
                 server branding, and maintenance mode toggles.
]]
Config.Debug = true -- Enable/Disable Debug Mode (true = show detailed logs)
Config.Locale = 'en' -- Default Locale for Translations (e.g., 'en', 'fr', 'de')
Config.BannerColor = '#FF4500' -- Hexadecimal Color Code for Banners in Logs/Notifications
Config.ServerLogo = 'https://example.com/logo.png' -- URL to the Server Logo for Branding
Config.Version = '1.0.0' -- Framework/Server Version
Config.MaintenanceMode = false -- Enable Maintenance Mode (true = only admins can connect)

--[[ 
    Framework Detection
    Description: Automatically detects and integrates with a preferred framework (e.g., QBCore, ESX, QBox).
                 If AutoDetect is true, it will detect and load the active framework dynamically.
]]
Config.FrameworkDetection = {
    AutoDetect = true, -- Automatically Detect Active Framework
    PreferredFramework = nil -- Set Preferred Framework ('QBCore', 'ESX', 'QBox') or leave nil for Auto-Detect
}

--[[ 
    Database Configuration
    Description: Handles the settings for database systems used in the server. Supports multiple backends like 
                 oxmysql, PostgreSQL, and SQLite.
]]
Config.Database = {
    UseOxmysql = true, -- Use oxmysql for Database Operations
    Debug = false, -- Enable Debug Mode for Database Queries
    SlowQueryWarning = 500, -- Log Queries Taking Longer Than This (in ms)
    PoolSize = 5, -- Maximum Number of Connections in the Database Pool
    FallbackToSQLite = true, -- Automatically Use SQLite if No Other Database is Enabled
    PostgreSQL = {
        Enabled = false, -- Enable PostgreSQL Support
        ConnectionString = "postgres://user:password@localhost:5432/database" -- PostgreSQL Connection String
    },
    SQLite = {
        Path = "database.sqlite" -- File Path for SQLite Database
    }
}

--[[ 
    Logging Configuration
    Description: Controls logging options, including logging to Discord, files, and external APIs.
                 Use this to track server events, errors, and debugging information.
]]
Config.Logging = {
    Enabled = true, -- Enable Logging System
    Levels = { 'info', 'warning', 'error', 'debug' }, -- Allowed Log Levels
    Discord = {
        Enabled = true, -- Enable Logging to Discord Webhook
        WebhookURL = "https://discord.com/api/webhooks/example", -- Discord Webhook URL
        RoleBasedAccess = true, -- Restrict Logging Visibility Based on Discord Roles
        Throttle = 60 -- Minimum Interval Between Logs Sent to Discord (in seconds)
    },
    FileManager = {
        Enabled = true, -- Enable File-Based Logging
        Path = "logs/", -- Directory for Log Files
        MaxFileSizeMB = 10, -- Maximum Size for Log Files Before Creating a New One (in MB)
        RetentionDays = 30 -- Number of Days to Retain Old Log Files
    },
    API = {
        Enabled = true, -- Enable Logging to External API
        Endpoint = "https://example.com/api/logs", -- External API Endpoint for Logs
        APIKey = "your-api-key" -- API Key for Authentication
    }
}

--[[ 
    Security Settings
    Description: Protects the server against malicious users. Includes anti-cheat, IP whitelisting, 
                 VPN detection, and configurable auto-ban policies.
]]
Config.Security = {
    AntiCheatEnabled = true, -- Enable Built-In Anti-Cheat Mechanisms
    MaxLoginAttempts = 5, -- Maximum Number of Login Attempts Before Blocking
    IPWhitelist = { '127.0.0.1', '192.168.1.1' }, -- IP Addresses Allowed to Bypass Restrictions
    VPNDetection = true, -- Detect and Restrict VPN Connections
    AutoBanThreshold = 3, -- Number of Violations Before Automatically Banning a User
    PasswordPolicy = { -- Password Rules for User Accounts
        MinLength = 8, -- Minimum Password Length
        RequireSpecialChar = true, -- Require Special Characters (!, @, #, etc.)
        RequireNumber = true -- Require At Least One Number
    },
    TwoFactorAuthentication = true -- Enable Two-Factor Authentication for Admins
}

--[[ 
    Feature Toggles
    Description: Dynamically enable or disable server features to match your roleplay environment. 
                 This system allows easy control of major functionalities like weather sync, economy, and voice chat.
]]
Config.FeatureFlags = {
    WeatherSync = true, -- Enable Weather Synchronization with External API
    RealTimeClock = false, -- Use Real-World Time on the Server
    VoiceChatProximity = true, -- Enable Proximity-Based Voice Chat
    AdvancedEconomy = true -- Enable Advanced Economy Features
}

--[[ 
    Performance Monitoring
    Description: Tracks server resource usage, garbage collection intervals, and optimizes performance 
                 by preventing bottlenecks.
]]
Config.Performance = {
    EnableResourceMonitor = true, -- Enable Real-Time Resource Monitoring
    AutoOptimize = true, -- Automatically Optimize Server Resources
    GarbageCollectorInterval = 60000, -- Interval for Running Garbage Collection (in ms)
    ResourceWarningThreshold = 5.0, -- Log Warning if Resource Time Exceeds This Value (in ms)
    SlowQueryThreshold = 1000 -- Log Database Queries Taking Longer Than This Time (in ms)
}

--[[ 
    Module Configuration
    Description: Auto-detect and load supported modules for inventory, appearance, and economy systems. 
                 Allows easy integration with third-party systems.
]]
Config.Modules = {
    Inventory = {
        AutoDetect = true, -- Automatically Detect Active Inventory System
        SupportedInventories = { -- List of Supported Inventory Systems
            'tgiann-inventory', 'ox_inventory', 'qs-inventory', 'ps-inventory', 'disc-inventory'
        }
    },
    Appearance = {
        AutoDetect = true, -- Automatically Detect Active Appearance System
        SupportedSystems = { -- List of Supported Appearance Systems
            'illenium-appearance', 'qb-clothing', 'fivem-appearance'
        }
    },
    Economy = {
        CurrencySymbol = '$', -- Symbol Used for In-Game Currency
        InflationRate = 1.02, -- Inflation Rate Applied to Prices (1.00 = No Change)
        TaxRates = { -- Tax Rates for Economy Activities
            Income = 0.15, -- Income Tax Rate (15%)
            Sales = 0.08 -- Sales Tax Rate (8%)
        }
    }
}

--[[ 
    Configuration Validation
    Description: Validates critical settings to ensure the server starts without errors. Logs warnings if 
                 any required configuration is missing or misconfigured.
]]
Config.Validate = function()
    if not Config.Locale or Config.Locale == '' then
        print("^1[Config] Error: Locale is not defined.^0")
        return false
    end
    if not Config.Version or Config.Version == '' then
        print("^1[Config] Error: Version is not defined.^0")
        return false
    end
    if not Config.Database.UseOxmysql and not Config.Database.PostgreSQL.Enabled then
        print("^1[Config] Error: No database system is enabled.^0")
        return false
    end
    print("^2[Config] Validation Passed.^0")
    return true
end
