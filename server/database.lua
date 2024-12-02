LUX.Database = {}

-- Database Detection
function LUX.Database.Detect()
    if GetResourceState('oxmysql') == 'started' then
        return 'oxmysql', exports.oxmysql
    elseif GetResourceState('mysql-async') == 'started' then
        return 'mysql-async', MySQL
    elseif Config.Database.PostgreSQL.Enabled then
        return 'postgresql', nil
    end
    return nil, nil
end

-- Query Execution
function LUX.Database.Execute(query, parameters, callback)
    local dbType, dbObject = LUX.Database.Detect()
    if dbType == 'oxmysql' then
        dbObject:execute(query, parameters, callback)
    elseif dbType == 'mysql-async' then
        dbObject.Async.fetchAll(query, parameters, callback)
    elseif dbType == 'postgresql' then
        LUX.Functions.Log("PostgreSQL is not fully implemented yet.", "warning", "Database")
    else
        LUX.Functions.Log("No supported database detected for query execution.", "error", "Database")
    end
end

-- Advanced Logging for Slow Queries
function LUX.Database.LogSlowQuery(query, timeTaken)
    if timeTaken > Config.Database.SlowQueryWarning then
        LUX.Functions.Log(string.format("Slow query detected: %s (Time: %dms)", query, timeTaken), "warning", "Database")
    end
end
