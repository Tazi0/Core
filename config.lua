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

-- To change colors check: https://docs.fivem.net/docs/game-references/blips/#blip-colors
Zones = {
        --title      x         y    color size
    Blips = {
        {"First", -473.561, -519.668, 1, 500.0}
    },
    Entered = {false, nil}
}