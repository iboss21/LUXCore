LUX.Inventory = {}

-- Inventory Detection
function LUX.Inventory.Detect()
    local supportedInventories = {
        'tgiann-inventory',
        'ox_inventory',
        'qs-inventory',
        'ps-inventory'
    }
    for _, inventory in ipairs(supportedInventories) do
        if GetResourceState(inventory) == 'started' then
            return inventory
        end
    end
    return nil
end

-- Inventory Utilities
function LUX.Inventory.GetInventory(playerId)
    local inventory = LUX.Inventory.Detect()
    if inventory == 'ox_inventory' then
        return exports.ox_inventory:GetInventory(playerId)
    elseif inventory == 'tgiann-inventory' then
        return exports['tgiann-inventory']:GetPlayerInventory(playerId)
    elseif inventory == 'qs-inventory' then
        return exports['qs-inventory']:GetInventory(playerId)
    else
        LUX.Functions.Log("No supported inventory system detected", "error", "Inventory")
        return nil
    end
end

function LUX.Inventory.AddItem(playerId, item, count)
    local inventory = LUX.Inventory.Detect()
    if inventory == 'ox_inventory' then
        exports.ox_inventory:AddItem(playerId, item, count)
    elseif inventory == 'tgiann-inventory' then
        exports['tgiann-inventory']:AddItem(playerId, item, count)
    else
        LUX.Functions.Log("No supported inventory system detected for adding items", "error", "Inventory")
    end
end
