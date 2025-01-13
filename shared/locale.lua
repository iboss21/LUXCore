
-- LUXCore - Localization
-- Manages language support and dynamic string replacement

local Config = require('shared/config')

local Locale = {
    en = {
        greeting = "Welcome to LUXCore!",
        goodbye = "Thank you for playing!"
    },
    fr = {
        greeting = "Bienvenue sur LUXCore!",
        goodbye = "Merci de jouer!"
    }
}

-- Function to fetch a localized string
function GetLocalizedString(key, lang)
    lang = lang or Config.General.DefaultLanguage
    return Locale[lang] and Locale[lang][key] or Locale.en[key]
end

-- Add more localization keys and functions as needed
