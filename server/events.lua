LUX.Events = {}

function LUX.Events.RegisterPlayerLoaded(callback)
    local framework, _ = LUX.Framework.Detect()
    if framework == 'QBCore' then
        RegisterNetEvent('QBCore:PlayerLoaded', callback)
    elseif framework == 'ESX' then
        RegisterNetEvent('esx:playerLoaded', callback)
    elseif framework == 'QBox' then
        RegisterNetEvent('QBox:PlayerLoaded', callback)
    else
        LUX.Functions.Log("No supported framework detected for player loaded event registration", "error", "Events")
    end
end
