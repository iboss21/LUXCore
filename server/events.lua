LUX.Events = {}

-- Register Player Loaded Event
function LUX.Events.RegisterPlayerLoaded(callback)
    local framework, _ = LUX.Framework.Detect()
    if framework == 'QBCore' then
        RegisterNetEvent('QBCore:PlayerLoaded', callback)
        LUX.Functions.Log("PlayerLoaded event registered for QBCore.", "info", "Events")
    elseif framework == 'ESX' then
        RegisterNetEvent('esx:playerLoaded', callback)
        LUX.Functions.Log("PlayerLoaded event registered for ESX.", "info", "Events")
    elseif framework == 'QBox' then
        RegisterNetEvent('QBox:PlayerLoaded', callback)
        LUX.Functions.Log("PlayerLoaded event registered for QBox.", "info", "Events")
    else
        LUX.Functions.Log("No supported framework detected for PlayerLoaded event registration.", "error", "Events")
    end
end

-- Register Player Unloaded Event
function LUX.Events.RegisterPlayerUnloaded(callback)
    local framework, _ = LUX.Framework.Detect()
    if framework == 'QBCore' then
        RegisterNetEvent('QBCore:PlayerUnloaded', callback)
        LUX.Functions.Log("PlayerUnloaded event registered for QBCore.", "info", "Events")
    elseif framework == 'ESX' then
        RegisterNetEvent('esx:playerDropped', callback)
        LUX.Functions.Log("PlayerUnloaded event registered for ESX (playerDropped).", "info", "Events")
    elseif framework == 'QBox' then
        RegisterNetEvent('QBox:PlayerUnloaded', callback)
        LUX.Functions.Log("PlayerUnloaded event registered for QBox.", "info", "Events")
    else
        LUX.Functions.Log("No supported framework detected for PlayerUnloaded event registration.", "error", "Events")
    end
end

-- Register Any Event (Framework-Agnostic)
function LUX.Events.Register(eventName, callback)
    if not eventName or eventName == "" then
        LUX.Functions.Log("No event name provided for registration.", "error", "Events")
        return
    end

    RegisterNetEvent(eventName, callback)
    LUX.Functions.Log("Event registered: " .. eventName, "info", "Events")
end

-- Trigger Server-Side Event
function LUX.Events.Trigger(eventName, ...)
    if not eventName or eventName == "" then
        LUX.Functions.Log("No event name provided for triggering.", "error", "Events")
        return
    end

    TriggerEvent(eventName, ...)
    LUX.Functions.Log("Event triggered: " .. eventName, "debug", "Events")
end

-- Trigger Client-Side Event (For a Specific Player)
function LUX.Events.TriggerClient(playerId, eventName, ...)
    if not playerId or not eventName or eventName == "" then
        LUX.Functions.Log("Invalid player ID or event name for client event triggering.", "error", "Events")
        return
    end

    TriggerClientEvent(eventName, playerId, ...)
    LUX.Functions.Log(string.format("Client event triggered: %s for Player ID: %s", eventName, playerId), "debug", "Events")
end

-- Trigger Client-Side Event (For All Players)
function LUX.Events.TriggerAllClients(eventName, ...)
    if not eventName or eventName == "" then
        LUX.Functions.Log("No event name provided for triggering client-side event for all players.", "error", "Events")
        return
    end

    TriggerClientEvent(eventName, -1, ...)
    LUX.Functions.Log("Client event triggered for all players: " .. eventName, "debug", "Events")
end
