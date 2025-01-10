Locale = {}
Locale.Languages = {
    ['en'] = {
        ['framework_detected'] = "Detected Framework: %s",
        ['database_detected'] = "Detected Database: %s",
        ['inventory_detected'] = "Detected Inventory: %s",
        ['framework_missing'] = "No supported framework detected!",
        ['database_missing'] = "No supported database detected!",
        ['module_initialized'] = "Module '%s' has been initialized.",
        ['module_failed'] = "Failed to initialize module '%s'.",
        ['event_registered'] = "Event '%s' has been registered.",
        ['command_registered'] = "Command '%s' has been registered with description: %s"
    },
    ['fr'] = {
        ['framework_detected'] = "Cadre détecté : %s",
        ['database_detected'] = "Base de données détectée : %s",
        ['inventory_detected'] = "Inventaire détecté : %s",
        ['framework_missing'] = "Aucun cadre pris en charge détecté !",
        ['database_missing'] = "Aucune base de données prise en charge détectée !",
        ['module_initialized'] = "Le module '%s' a été initialisé.",
        ['module_failed'] = "Échec de l'initialisation du module '%s'.",
        ['event_registered'] = "L'événement '%s' a été enregistré.",
        ['command_registered'] = "La commande '%s' a été enregistrée avec la description : %s"
    }
}

-- Example of adding a new language dynamically
function Locale.AddLanguage(code, translations)
    if not Locale.Languages[code] then
        Locale.Languages[code] = translations
        LUX.Functions.Log("Added new language: " .. code, "info", "Locale")
    else
        LUX.Functions.Log("Language already exists: " .. code, "warning", "Locale")
    end
end

--[[

Key Enhancements
Expanded Keys:

Added more common keys such as module_initialized, module_failed, event_registered, and command_registered for logging purposes.
Dynamic Language Addition:

Added a Locale.AddLanguage function to allow for adding new languages dynamically at runtime.
Future-Proof Translations:

Structured keys for easy addition of new strings or languages in the future.
Extensibility:

By centralizing string management, it's easier to add new functionality without duplicating messages.

local framework = "QBCore"
LUX.Functions.Log(LUX.Functions.Translate('framework_detected', framework), "info", "FrameworkDetection")

Adding a New Language Dynamically

Locale.AddLanguage('es', {
    ['framework_detected'] = "Marco detectado: %s",
    ['database_detected'] = "Base de datos detectada: %s",
    ['inventory_detected'] = "Inventario detectado: %s",
    ['framework_missing'] = "¡No se detectó un marco compatible!",
    ['database_missing'] = "¡No se detectó una base de datos compatible!",
    ['module_initialized'] = "El módulo '%s' se ha inicializado.",
    ['module_failed'] = "No se pudo inicializar el módulo '%s'.",
    ['event_registered'] = "El evento '%s' ha sido registrado.",
    ['command_registered'] = "El comando '%s' ha sido registrado con la descripción: %s"
})

]]--
