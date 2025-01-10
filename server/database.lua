LUX.Database = {}

-- Database Detection
function LUX.Database.Detect()
    if GetResourceState('oxmysql') == 'started' then
        return 'oxmysql', exports.oxmysql
    elseif GetResourceState('mysql-async') == 'started' then
        return 'mysql-async', MySQL
    elseif Config.Database.PostgreSQL.Enabled then
        return 'postgresql', nil -- Placeholder for PostgreSQL integration
    end
    return nil, nil
end

-- Query Execution
function LUX.Database.Execute(query, parameters, callback)
    local dbType, dbObject = LUX.Database.Detect()
    local startTime = GetGameTimer()
    local wrappedCallback = function(result)
        local endTime = GetGameTimer()
        local timeTaken = endTime - startTime
        LUX.Database.LogSlowQuery(query, timeTaken)
        if callback then callback(result) end
    end

    if dbType == 'oxmysql' then
        dbObject:execute(query, parameters, wrappedCallback)
    elseif dbType == 'mysql-async' then
        dbObject.Async.fetchAll(query, parameters, wrappedCallback)
    elseif dbType == 'postgresql' then
        -- PostgreSQL placeholder for execution
        LUX.Functions.Log("PostgreSQL query execution is not yet implemented.", "warning", "Database")
    else
        LUX.Functions.Log("No supported database detected for query execution.", "error", "Database")
    end
end

-- Scalar Query Execution (for single-value results)
function LUX.Database.Scalar(query, parameters, callback)
    local dbType, dbObject = LUX.Database.Detect()
    if dbType == 'oxmysql' then
        dbObject:scalar(query, parameters, callback)
    elseif dbType == 'mysql-async' then
        dbObject.Async.fetchScalar(query, parameters, callback)
    elseif dbType == 'postgresql' then
        LUX.Functions.Log("PostgreSQL scalar queries are not yet implemented.", "warning", "Database")
    else
        LUX.Functions.Log("No supported database detected for scalar queries.", "error", "Database")
    end
end

-- Insert Query Execution
function LUX.Database.Insert(query, parameters, callback)
    local dbType, dbObject = LUX.Database.Detect()
    if dbType == 'oxmysql' then
        dbObject:insert(query, parameters, callback)
    elseif dbType == 'mysql-async' then
        dbObject.Async.insert(query, parameters, callback)
    elseif dbType == 'postgresql' then
        LUX.Functions.Log("PostgreSQL insert queries are not yet implemented.", "warning", "Database")
    else
        LUX.Functions.Log("No supported database detected for insert queries.", "error", "Database")
    end
end

-- Update Query Execution
function LUX.Database.Update(query, parameters, callback)
    local dbType, dbObject = LUX.Database.Detect()
    if dbType == 'oxmysql' then
        dbObject:execute(query, parameters, callback)
    elseif dbType == 'mysql-async' then
        dbObject.Async.execute(query, parameters, callback)
    elseif dbType == 'postgresql' then
        LUX.Functions.Log("PostgreSQL update queries are not yet implemented.", "warning", "Database")
    else
        LUX.Functions.Log("No supported database detected for update queries.", "error", "Database")
    end
end

-- Transaction Support
function LUX.Database.Transaction(queries, parameters, callback)
    local dbType, dbObject = LUX.Database.Detect()
    if dbType == 'oxmysql' then
        dbObject:transaction(queries, parameters, callback)
    elseif dbType == 'mysql-async' then
        LUX.Functions.Log("MySQL-Async does not natively support transactions.", "warning", "Database")
    elseif dbType == 'postgresql' then
        LUX.Functions.Log("PostgreSQL transactions are not yet implemented.", "warning", "Database")
    else
        LUX.Functions.Log("No supported database detected for transactions.", "error", "Database")
    end
end

-- Advanced Logging for Slow Queries
function LUX.Database.LogSlowQuery(query, timeTaken)
    if timeTaken > Config.Database.SlowQueryWarning then
        LUX.Functions.Log(string.format("Slow query detected: %s (Time: %dms)", query, timeTaken), "warning", "Database")
    end
end

-- Utility Function to Escape Inputs
function LUX.Database.Escape(value)
    local dbType, dbObject = LUX.Database.Detect()
    if dbType == 'oxmysql' then
        return dbObject:escape(value)
    elseif dbType == 'mysql-async' then
        -- MySQL-Async does not provide an escape function; fallback to manual escaping
        return tostring(value):gsub("'", "\\'"):gsub('"', '\\"')
    else
        LUX.Functions.Log("No supported database detected for escaping inputs.", "error", "Database")
        return tostring(value)
    end
end
