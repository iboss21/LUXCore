LUX.Inventory = {}

-- Inventory Detection
function LUX.Inventory.Detect()
    local supportedInventories = {
        'tgiann-inventory',
        'ox_inventory',
        'qs-inventory',
        'ps-inventory',
        'mf-inventory',
        'esx_inventoryhud',
        'origin_inventory',
        'disc-inventoryhud',
        'custom_inventory' -- Placeholder for custom inventories
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
    elseif inventory == 'ps-inventory' then
        return exports['ps-inventory']:GetPlayerInventory(playerId)
    elseif inventory == 'mf-inventory' then
        return exports['mf-inventory']:GetInventory(playerId)
    elseif inventory == 'esx_inventoryhud' then
        return exports['esx_inventoryhud']:GetPlayerInventory(playerId)
    elseif inventory == 'origin_inventory' then
        return exports['origin_inventory']:GetInventory(playerId)
    elseif inventory == 'disc-inventoryhud' then
        return exports['disc-inventoryhud']:GetPlayerInventory(playerId)
    elseif inventory == 'custom_inventory' then
        return exports['custom_inventory']:GetInventory(playerId) -- Custom inventory placeholder
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
    elseif inventory == 'qs-inventory' then
        exports['qs-inventory']:AddItem(playerId, item, count)
    elseif inventory == 'ps-inventory' then
        exports['ps-inventory']:AddItem(playerId, item, count)
    elseif inventory == 'mf-inventory' then
        exports['mf-inventory']:AddItem(playerId, item, count)
    elseif inventory == 'esx_inventoryhud' then
        TriggerClientEvent('esx_inventoryhud:addItem', playerId, item, count)
    elseif inventory == 'origin_inventory' then
        exports['origin_inventory']:AddItem(playerId, item, count)
    elseif inventory == 'disc-inventoryhud' then
        exports['disc-inventoryhud']:AddItem(playerId, item, count)
    elseif inventory == 'custom_inventory' then
        exports['custom_inventory']:AddItem(playerId, item, count) -- Custom inventory placeholder
    else
        LUX.Functions.Log("No supported inventory system detected for adding items", "error", "Inventory")
    end
end

function LUX.Inventory.RemoveItem(playerId, item, count)
    local inventory = LUX.Inventory.Detect()
    if inventory == 'ox_inventory' then
        exports.ox_inventory:RemoveItem(playerId, item, count)
    elseif inventory == 'tgiann-inventory' then
        exports['tgiann-inventory']:RemoveItem(playerId, item, count)
    elseif inventory == 'qs-inventory' then
        exports['qs-inventory']:RemoveItem(playerId, item, count)
    elseif inventory == 'ps-inventory' then
        exports['ps-inventory']:RemoveItem(playerId, item, count)
    elseif inventory == 'mf-inventory' then
        exports['mf-inventory']:RemoveItem(playerId, item, count)
    elseif inventory == 'esx_inventoryhud' then
        TriggerClientEvent('esx_inventoryhud:removeItem', playerId, item, count)
    elseif inventory == 'origin_inventory' then
        exports['origin_inventory']:RemoveItem(playerId, item, count)
    elseif inventory == 'disc-inventoryhud' then
        exports['disc-inventoryhud']:RemoveItem(playerId, item, count)
    elseif inventory == 'custom_inventory' then
        exports['custom_inventory']:RemoveItem(playerId, item, count) -- Custom inventory placeholder
    else
        LUX.Functions.Log("No supported inventory system detected for removing items", "error", "Inventory")
    end
end

-- Check if a player has a specific item
function LUX.Inventory.HasItem(playerId, item)
    local inventory = LUX.Inventory.Detect()
    local playerInventory = LUX.Inventory.GetInventory(playerId)
    if not playerInventory then return false end

    for _, invItem in pairs(playerInventory) do
        if invItem.name == item then
            return true
        end
    end
    return false
end

-- Transfer an item from one player to another
function LUX.Inventory.TransferItem(fromPlayerId, toPlayerId, item, count)
    if not LUX.Inventory.HasItem(fromPlayerId, item) then
        LUX.Functions.Log("Player does not have the item to transfer", "error", "Inventory")
        return false
    end

    LUX.Inventory.RemoveItem(fromPlayerId, item, count)
    LUX.Inventory.AddItem(toPlayerId, item, count)
    LUX.Functions.Log("Item successfully transferred", "info", "Inventory")
    return true
end

-- Toggle an item (e.g., equip or unequip)
function LUX.Inventory.ToggleItem(playerId, item, state)
    if state then
        LUX.Inventory.AddItem(playerId, item, 1)
        LUX.Functions.Log("Item equipped", "info", "Inventory")
    else
        LUX.Inventory.RemoveItem(playerId, item, 1)
        LUX.Functions.Log("Item unequipped", "info", "Inventory")
    end
end
