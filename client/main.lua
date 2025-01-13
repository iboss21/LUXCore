
-- LUXCore - Client Main Logic
-- Handles primary client-side functionality and event listeners

local Config = require('shared/config')

-- Initialize client-side logic
CreateThread(function()
    print('[LUXCore Client] Initializing client logic...')

    -- Enable/disable minimap
    if Config.UI.MinimapEnabled then
        print('[LUXCore Client] Minimap enabled.')
        -- Logic to enable minimap
    else
        print('[LUXCore Client] Minimap disabled.')
        -- Logic to disable minimap
    end
end)
