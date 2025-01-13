
-- LUXCore - Shared Functions
-- Provides utility functions for both server and client scripts

local Config = require('shared/config')

-- Function to calculate tax on a given amount
function CalculateTax(amount)
    local tax = amount * Config.Economy.TaxRate
    return math.floor(tax)
end

-- Add more shared functions as needed
