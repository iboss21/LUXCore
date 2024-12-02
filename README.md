# LUXCore

**LUXCore** is an advanced, modular core framework designed for FiveM servers. Built with scalability, performance, and compatibility in mind, LUXCore offers seamless integration with the most popular frameworks, databases, inventory systems, and custom features for developers.

---

![Version](https://img.shields.io/badge/Version-1.0.0-brightgreen)
![Build](https://img.shields.io/badge/Build-Stable-brightgreen)
![Framework](https://img.shields.io/badge/Framework-LUXCore-blue)
![License](https://img.shields.io/badge/License-MIT-yellowgreen)
![Contributions](https://img.shields.io/badge/Contributions-Welcome-orange)
![Platform](https://img.shields.io/badge/Platform-FiveM-lightgrey)
![Made with ❤️ by](https://img.shields.io/badge/Made%20with%20%E2%9D%A4%EF%B8%8F%20by-iBoss-blue)

---

## Features

- **Framework Integration**: Supports dynamic detection and integration with `QBCore`, `ESX`, and `QBox`.
- **Database Support**: Compatible with `oxmysql`, `mysql-async`, and PostgreSQL (support included for slow query logging).
- **Inventory System Support**: Works with all major inventory systems such as `ox_inventory`, `tgiann-inventory`, `qs-inventory`, and more.
- **Dynamic Detection**: Automatically detects and adjusts for active resources and systems.
- **Custom Events**: Easy-to-register player-loaded, player-spawned, and custom events for extensibility.
- **Advanced Logging**:
  - Console logging with detailed messages and emojis.
  - Discord integration with webhooks for real-time notifications.
  - File-based logging for persistent records.
- **Performance-Oriented**: Includes monitoring for slow database queries and performance bottlenecks.
- **Developer Utilities**: Tools for live script reloads, debugging, and modular resource loading.
- **Extensive Configurations**:
  - Configure framework behavior, database pooling, logging options, inventory interactions, and more.
  - Advanced options for branding, including server logos and Discord configurations.
- **Future-Proof**: Modular design to support any new inventory or framework systems with minimal effort.

---

## Installation

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/YourUsername/LUXCore.git
   ```

2. **Place LUXCore in your Resources Folder**:
   Copy the `LUXCore` folder to your FiveM `resources` directory.

3. **Configure `fxmanifest.lua`**:
   Add the following line to your `server.cfg`:
   ```cfg
   ensure LUXCore
   ```

4. **Edit Configurations**:
   Navigate to `shared/config.lua` and update the settings as per your server requirements.

5. **Start the Server**:
   Restart your FiveM server and verify that LUXCore is loaded by checking the server console for the LUXCore startup banner.

---

## Configuration

### `shared/config.lua`

LUXCore is highly customizable. Below are some key configuration options:

#### Framework Detection
```lua
Config.FrameworkDetection = {
    AutoDetect = true,
    PreferredFramework = nil -- 'QBCore', 'ESX', or 'QBox'
}
```

#### Database Configuration
```lua
Config.Database = {
    UseOxmysql = true,
    Debug = true,
    SlowQueryWarning = 500,
    PostgreSQL = {
        Enabled = false,
        ConnectionString = "postgres://user:password@localhost:5432/database"
    }
}
```

#### Logging Options
```lua
Config.Logging = {
    Enabled = true,
    Discord = {
        Enabled = true,
        WebhookURL = "https://discord.com/api/webhooks/example",
    },
    FileManager = {
        Enabled = true,
        Path = "logs/"
    }
}
```

#### Inventory Systems
```lua
Config.Inventory = {
    AutoDetect = true,
    SupportedInventories = {
        'tgiann-inventory', 'ox_inventory', 'qs-inventory', 'ps-inventory'
    }
}
```

---

## API Reference

LUXCore exposes several powerful APIs to interact with the core systems dynamically.

### Framework Utilities
```lua
-- Detect Framework
local framework, object = LUX.Framework.Detect()

-- Get Player Data
local playerData = LUX.Framework.GetPlayerData(playerId)

-- Register Commands
LUX.Framework.RegisterCommand('exampleCommand', function(source, args)
    print('Command executed!')
end)
```

### Database Utilities
```lua
-- Execute Queries
LUX.Database.Execute("SELECT * FROM players WHERE id = ?", {playerId}, function(results)
    print(results)
end)
```

### Inventory Utilities
```lua
-- Get Inventory
local inventory = LUX.Inventory.GetInventory(playerId)

-- Add Items
LUX.Inventory.AddItem(playerId, 'bread', 5)
```

### Custom Events
```lua
-- Register Player Loaded Event
LUX.Events.RegisterPlayerLoaded(function(playerId)
    print("Player Loaded: " .. playerId)
end)
```

---

## Contribution

We welcome contributions to improve LUXCore! Follow these steps to get started:

1. Fork the repository.
2. Create a feature branch: `git checkout -b feature-name`.
3. Commit your changes: `git commit -m "Added new feature"`.
4. Push to the branch: `git push origin feature-name`.
5. Create a Pull Request.

---

## Credits

- **Developer**: iBoss
- **Website**: [The Lux Empire](https://theluxempire.com)
- **GitHub**: [iBoss21](https://github.com/iBoss21)
- **Tebex Store**: [The Lux Empire Tebex](https://theluxempire.tebex.io)

---

## License

This project is licensed under the [MIT License](LICENSE).

---

## 🔖 Tags

[![fivem-framework](https://img.shields.io/badge/Tag-fivem--framework-blue)](https://github.com/topics/fivem-framework)
[![fivem-core](https://img.shields.io/badge/Tag-fivem--core-blue)](https://github.com/topics/fivem-core)
[![luxcore](https://img.shields.io/badge/Tag-luxcore-blue)](https://github.com/topics/luxcore)
[![qbcore-integration](https://img.shields.io/badge/Tag-qbcore--integration-blue)](https://github.com/topics/qbcore-integration)
[![esx-integration](https://img.shields.io/badge/Tag-esx--integration-blue)](https://github.com/topics/esx-integration)
[![qbox-integration](https://img.shields.io/badge/Tag-qbox--integration-blue)](https://github.com/topics/qbox-integration)
[![oxmysql-support](https://img.shields.io/badge/Tag-oxmysql--support-blue)](https://github.com/topics/oxmysql-support)
[![mysql-async](https://img.shields.io/badge/Tag-mysql--async-blue)](https://github.com/topics/mysql-async)
[![postgresql-support](https://img.shields.io/badge/Tag-postgresql--support-blue)](https://github.com/topics/postgresql-support)
[![inventory-management](https://img.shields.io/badge/Tag-inventory--management-blue)](https://github.com/topics/inventory-management)
[![ox_inventory](https://img.shields.io/badge/Tag-ox--inventory-blue)](https://github.com/topics/ox-inventory)
[![tgiann-inventory](https://img.shields.io/badge/Tag-tgiann--inventory-blue)](https://github.com/topics/tgiann-inventory)
[![qs-inventory](https://img.shields.io/badge/Tag-qs--inventory-blue)](https://github.com/topics/qs-inventory)
[![player-events](https://img.shields.io/badge/Tag-player--events-blue)](https://github.com/topics/player-events)
[![custom-events](https://img.shields.io/badge/Tag-custom--events-blue)](https://github.com/topics/custom-events)
[![fivem-logging](https://img.shields.io/badge/Tag-fivem--logging-blue)](https://github.com/topics/fivem-logging)
[![discord-integration](https://img.shields.io/badge/Tag-discord--integration-blue)](https://github.com/topics/discord-integration)
[![fivem-database](https://img.shields.io/badge/Tag-fivem--database-blue)](https://github.com/topics/fivem-database)
[![modular-framework](https://img.shields.io/badge/Tag-modular--framework-blue)](https://github.com/topics/modular-framework)
[![advanced-config](https://img.shields.io/badge/Tag-advanced--config-blue)](https://github.com/topics/advanced-config)
[![fivem-scripts](https://img.shields.io/badge/Tag-fivem--scripts-blue)](https://github.com/topics/fivem-scripts)
[![developer-tools](https://img.shields.io/badge/Tag-developer--tools-blue)](https://github.com/topics/developer-tools)
[![performance-monitoring](https://img.shields.io/badge/Tag-performance--monitoring-blue)](https://github.com/topics/performance-monitoring)
[![slow-query-logging](https://img.shields.io/badge/Tag-slow--query--logging-blue)](https://github.com/topics/slow-query-logging)
[![dynamic-detection](https://img.shields.io/badge/Tag-dynamic--detection-blue)](https://github.com/topics/dynamic-detection)
[![auto-detection](https://img.shields.io/badge/Tag-auto--detection-blue)](https://github.com/topics/auto-detection)
[![script-dependency](https://img.shields.io/badge/Tag-script--dependency-blue)](https://github.com/topics/script-dependency)
[![resource-management](https://img.shields.io/badge/Tag-resource--management-blue)](https://github.com/topics/resource-management)
[![fivepd-compatible](https://img.shields.io/badge/Tag-fivepd--compatible-blue)](https://github.com/topics/fivepd-compatible)
[![fivem-roleplay](https://img.shields.io/badge/Tag-fivem--roleplay-blue)](https://github.com/topics/fivem-roleplay)
[![advanced-systems](https://img.shields.io/badge/Tag-advanced--systems-blue)](https://github.com/topics/advanced-systems)
[![fivem-performance](https://img.shields.io/badge/Tag-fivem--performance-blue)](https://github.com/topics/fivem-performance)
[![multi-framework](https://img.shields.io/badge/Tag-multi--framework-blue)](https://github.com/topics/multi-framework)
[![open-source](https://img.shields.io/badge/Tag-open--source-blue)](https://github.com/topics/open-source)
[![fivem-development](https://img.shields.io/badge/Tag-fivem--development-blue)](https://github.com/topics/fivem-development)
[![roleplay-systems](https://img.shields.io/badge/Tag-roleplay--systems-blue)](https://github.com/topics/roleplay-systems)

