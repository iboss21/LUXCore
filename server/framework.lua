LUX.Framework = {}

-- Framework Detection
function LUX.Framework.Detect()
    if GetResourceState('qb-core') == 'started' then
        return 'QBCore', exports['qb-core']
    elseif GetResourceState('es_extended') == 'started' then
        return 'ESX', exports['es_extended']
    elseif GetResourceState('qbox-core') == 'started' then
        return 'QBox', exports['qbox-core']
    end
    LUX.Functions.Log("No supported framework detected", "error", "Framework")
    return nil, nil
end

-- Framework Player Utilities
function LUX.Framework.GetPlayerData(source)
    local framework, object = LUX.Framework.Detect()
    if framework == 'QBCore' then
        return object.Functions.GetPlayer(source)
    elseif framework == 'ESX' then
        return object.GetPlayerFromId(source)
    elseif framework == 'QBox' then
        return object.Functions.GetPlayer(source)
    else
        LUX.Functions.Log("No supported framework detected for player data retrieval", "error", "Framework")
        return nil
    end
end

-- Framework Identifier Retrieval
function LUX.Framework.GetPlayerIdentifier(source)
    local playerData = LUX.Framework.GetPlayerData(source)
    if playerData then
        if playerData.PlayerData and playerData.PlayerData.citizenid then
            return playerData.PlayerData.citizenid -- QBCore
        elseif playerData.identifier then
            return playerData.identifier -- ESX
        elseif playerData.ID then
            return playerData.ID -- QBox
        end
    end
    LUX.Functions.Log("Failed to retrieve player identifier", "error", "Framework")
    return nil
end

-- Framework Command Registration
function LUX.Framework.RegisterCommand(command, callback, description)
    local framework, object = LUX.Framework.Detect()
    if framework == 'QBCore' then
        object.Functions.AddCommand(command, callback, description or "")
        LUX.Functions.Log("Command registered: " .. command .. " (QBCore)", "info", "Framework")
    elseif framework == 'ESX' then
        RegisterCommand(command, callback, false)
        LUX.Functions.Log("Command registered: " .. command .. " (ESX)", "info", "Framework")
    elseif framework == 'QBox' then
        object.Commands.Register(command, callback)
        LUX.Functions.Log("Command registered: " .. command .. " (QBox)", "info", "Framework")
    else
        LUX.Functions.Log("No supported framework detected for command registration", "error", "Framework")
    end
end

-- Framework Money Handling
function LUX.Framework.AddMoney(source, amount, type)
    local framework, object = LUX.Framework.Detect()
    if framework == 'QBCore' then
        local player = object.Functions.GetPlayer(source)
        if player then
            player.Functions.AddMoney(type or 'cash', amount)
            LUX.Functions.Log("Added money: " .. amount .. " (" .. (type or "cash") .. ") to Player ID: " .. source, "info", "Framework")
        end
    elseif framework == 'ESX' then
        local player = object.GetPlayerFromId(source)
        if player then
            if type == 'bank' then
                player.addAccountMoney('bank', amount)
            else
                player.addMoney(amount)
            end
            LUX.Functions.Log("Added money: " .. amount .. " (" .. (type or "cash") .. ") to Player ID: " .. source, "info", "Framework")
        end
    elseif framework == 'QBox' then
        local player = object.Functions.GetPlayer(source)
        if player then
            player.Functions.AddMoney(type or 'cash', amount)
            LUX.Functions.Log("Added money: " .. amount .. " (" .. (type or "cash") .. ") to Player ID: " .. source, "info", "Framework")
        end
    else
        LUX.Functions.Log("No supported framework detected for adding money", "error", "Framework")
    end
end

-- Framework Role Checking
function LUX.Framework.HasRole(source, role)
    local framework, object = LUX.Framework.Detect()
    if framework == 'QBCore' then
        local player = object.Functions.GetPlayer(source)
        return player and player.PlayerData.job and player.PlayerData.job.name == role
    elseif framework == 'ESX' then
        local player = object.GetPlayerFromId(source)
        return player and player.getJob() and player.getJob().name == role
    elseif framework == 'QBox' then
        local player = object.Functions.GetPlayer(source)
        return player and player.PlayerData.job and player.PlayerData.job.name == role
    else
        LUX.Functions.Log("No supported framework detected for role checking", "error", "Framework")
        return false
    end
end
