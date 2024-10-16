Config = {}
Config.TimePerTicket = 60000 -- ms
Config.Locale = "EN" -- DE or EN
Config.SpawnName = "adder"
Config.SpawnPoint = vec3(-1091.18, -2872.30, 13.96) -- place your own vector3 coords.
Config.Plate = "Bumper"
Config.BuyPoint = vec3(-1092.69, -2867.14, 13.96)


function _(str, ...)
    if Locales[Config.Locale] and Locales[Config.Locale][str] then
        return string.format(Locales[Config.Locale][str], ...)
    else
        return 'Translation [' .. str .. '] does not exist'
    end
end
