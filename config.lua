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
    Zones = {
        Blips = {
            -- To change colors check: https://docs.fivem.net/docs/game-references/blips/#blip-colors
            --title      x         y     size
            {"First", -473.561, -519.668, 500}
        },
        Sprite = 84,
        TimeLoop = 1 -- in minutes
    },
    Teams = {
        red = {
            Hex = "#FF0000",
            Color = 1,
            Title = Lang[Preference.lang]["title"]["red"],
            Safezone = {1044.262, 99.416}
        },
        green = {
            Hex = "#00FF00",
            Color = 2,
            Title = Lang[Preference.lang]["title"]["green"],
            Safezone = {-2137.095, -301.168}
        },
        blue = {
            Hex = "#0000FF",
            Color = 3,
            Title = Lang[Preference.lang]["title"]["blue"],
            Safezone = {-1287.114, -3008.143}
        }
    },
    Lang = Lang[Preference.lang]
}