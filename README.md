# LUXCore

**LUXCore** is an advanced, modular core framework designed for FiveM servers. Built with scalability, performance, and compatibility in mind, LUXCore offers seamless integration with popular frameworks, databases, inventory systems, and custom features for developers.

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
- **Database Support**: Compatible with `oxmysql`, `mysql-async`, and PostgreSQL (including slow query logging).
- **Inventory System Support**: Works with major inventory systems such as `ox_inventory`, `tgiann-inventory`, `qs-inventory`, and more.
- **Dynamic Detection**: Automatically detects and adjusts for active resources and systems.
- **Custom Events**: Easy-to-register player-loaded, player-spawned, and custom events for extensibility.
- **Advanced Logging**:
  - Console logging with detailed messages.
  - Discord integration with webhooks for real-time notifications.
  - File-based logging for persistent records.
- **Performance Monitoring**: Tracks memory usage, active threads, and resource performance.
- **Developer Utilities**: Tools for live script reloads, debugging, and modular resource loading.
- **Extensive Configurations**:
  - Configure framework behavior, database pooling, logging options, inventory interactions, and more.
- **Future-Proof Design**: Modular architecture ensures compatibility with future systems and updates.

---

## Installation

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/iboss21/LUXCore.git
   ```

2. **Place LUXCore in your Resources Folder**:
   Copy the `LUXCore` folder to your FiveM `resources` directory.

3. **Add to `server.cfg`**:
   ```cfg
   ensure LUXCore
   ```

4. **Edit Configurations**:
   Navigate to `shared/config.lua` and update the settings as per your server requirements.

5. **Start the Server**:
   Restart your FiveM server and verify that LUXCore is loaded by checking the server console for the LUXCore startup banner.

---

## Configuration

LUXCore is highly customizable. Below are some key configuration options:

### Framework Detection
```lua
Config.FrameworkDetection = {
    AutoDetect = true,
    PreferredFramework = nil -- 'QBCore', 'ESX', or 'QBox'
}
```

### Database Configuration
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

### Logging Options
```lua
Config.Logging = {
    Enabled = true,
    Discord = {
        Enabled = true,
        WebhookURL = "https://discord.com/api/webhooks/example"
    },
    FileManager = {
        Enabled = true,
        Path = "logs/"
    }
}
```

### Inventory Systems
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

LUXCore provides several powerful APIs for interacting with its systems.

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

## Showcase

Here’s how LUXCore integrates into your workflow:

### Logging Example
![Logging Example](https://example.com/logging-preview.png)

### Performance Monitoring
![Performance Monitoring Example](https://example.com/performance-preview.png)

---

## FAQ

**Q:** What frameworks are supported?  
**A:** LUXCore currently supports `QBCore`, `ESX`, and `QBox`.

**Q:** How do I configure my server for PostgreSQL?  
**A:** Enable PostgreSQL in `config.lua` and provide your connection string.

**Q:** Can I contribute to LUXCore?  
**A:** Absolutely! Follow the steps in the [Contribution](#contribution) section.

---

## Contribution

We welcome contributions to improve LUXCore! Follow these steps:

1. Fork the repository.
2. Create a feature branch:
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes:
   ```bash
   git commit -m "Added new feature"
   ```
4. Push to the branch:
   ```bash
   git push origin feature-name
   ```
5. Create a Pull Request.

---

## Roadmap

- [ ] Full PostgreSQL support
- [ ] UI Integration for Live Performance Metrics
- [ ] Enhanced Multi-Framework Compatibility
- [ ] Advanced Monitoring Dashboard

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

## Tags

[![fivem-framework](https://img.shields.io/badge/Tag-fivem--framework-blue)](https://github.com/topics/fivem-framework)
[![fivem-core](https://img.shields.io/badge/Tag-fivem--core-blue)](https://github.com/topics/fivem-core)
[![luxcore](https://img.shields.io/badge/Tag-luxcore-blue)](https://github.com/topics/luxcore)
[![developer-tools](https://img.shields.io/badge/Tag-developer--tools-blue)](https://github.com/topics/developer-tools)

---
