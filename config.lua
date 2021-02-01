-- Global variable, this will be exported for ever script to use
Preference = {
    lang = "en"
}

-- Resource configuration
Config = {
    Preference = Preference,
    Player = {
        Connection = "steam" or "discord"
    },
    Lang = Lang[Preference.lang]
}