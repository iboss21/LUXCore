Config = {}
Config.Debug = true
Config.Locale = 'en'
Config.BannerColor = '#FF4500'
Config.ServerLogo = 'https://example.com/logo.png'
Config.Version = '1.0.0'

Config.FrameworkDetection = {
    AutoDetect = true,
    PreferredFramework = nil -- 'QBCore', 'ESX', 'QBox' or nil for auto-detect
}

Config.Database = {
    UseOxmysql = true,
    Debug = false,
    SlowQueryWarning = 500,
    Pool = 5,
    PostgreSQL = {
        Enabled = false,
        ConnectionString = "postgres://user:password@localhost:5432/database"
    }
}

Config.Logging = {
    Enabled = true,
    Discord = {
        Enabled = true,
        WebhookURL = "https://discord.com/api/webhooks/example",
        RoleBasedAccess = true
    },
    FileManager = {
        Enabled = true,
        Path = "logs/"
    },
    API = {
        Enabled = true,
        Endpoint = "https://example.com/api/logs",
        APIKey = "your-api-key"
    }
}

Config.Modules = {
    Inventory = {
        AutoDetect = true,
        SupportedInventories = {
            'tgiann-inventory', 'ox_inventory', 'qs-inventory', 'ps-inventory'
        }
    },
    Appearance = {
        AutoDetect = true,
        SupportedSystems = {
            'illenium-appearance', 'qb-clothing', 'fivem-appearance'
        }
    }
}
