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

function LUX.Framework.RegisterCommand(command, callback)
    local framework, object = LUX.Framework.Detect()
    if framework == 'QBCore' then
        object.Functions.AddCommand(command, callback)
    elseif framework == 'ESX' then
        RegisterCommand(command, callback, false)
    elseif framework == 'QBox' then
        object.Commands.Register(command, callback)
    else
        LUX.Functions.Log("No supported framework detected for command registration", "error", "Framework")
    end
end
