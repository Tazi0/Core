-- To change colors check: https://docs.fivem.net/docs/game-references/blips/#blip-colors

-- Global variable, this will be exported for ever script to use
Preference = {
    lang = "en"
}

-- Resource configuration
Config = {
    Player = {
        Connection = --[[ "steam" or ]] "discord"
    },
    Zones = {
        Blips = {
            --title      x         y     size
            {"First", -473.561, -519.668, 500}
        },
        Sprite = 84, -- https://docs.fivem.net/docs/game-references/blips/#blips
        TimeLoop = 1 -- in minutes
    },
    Teams = {
        red = {
            Hex = "#FF0000",
            Color = 1, -- Check line 1 for more info
            Title = Lang[Preference.lang]["title"]["red"], -- Grabbed from title
            Safezone = {1044.262, 99.416}, -- X, Y
            Spawnzone = {1044.262, 99.416, 10} -- X, Y, Radius
        },
        green = {
            Hex = "#00FF00",
            Color = 2,
            Title = Lang[Preference.lang]["title"]["green"],
            Safezone = {-2137.095, -301.168},
            Spawnzone = {1044.262, 99.416, 10}
        },
        blue = {
            Hex = "#0000FF",
            Color = 3,
            Title = Lang[Preference.lang]["title"]["blue"],
            Safezone = {-1287.114, -3008.143},
            Spawnzone = {1044.262, 99.416, 10}
        }
    },
    -- All of the following are system required
    Preference = Preference,
    Lang = Lang[Preference.lang] or Lang['en']
}


-- Production by:
-- Golf
-- Tazio de Bruin / https://tazio.nl