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
    Classes = {
        title = "Classes",
        description = "Choose your class",
        items = {
            {
                label = "Noob",
                level = 0
            },
            {
                label = "Cheese",
                level = 5
            },
            {
                label = "Boss",
                level = 10
            }
        }
    },
    Weapons = {
        Noob = {
            { -- Primary
                {"weapon_assaultrifle", 0, 200}, -- Weapon / Level / Limited to 200 bullets
                "weapon_musket" -- Weapon / Any level / 200 bullets
            },
            { -- Secondary
                "weapon_pistol",
                "weapon_revolver"
            },
            { -- Extra
                "weapon_grenade",
                "weapon_snowball"
            }
        },
        Cheese = {
            { -- Primary
                {"weapon_assaultrifle", 0, 200}, -- Weapon / Level / Limited to 200 bullets
                "weapon_musket" -- Weapon / Any level / 200 bullets
            },
            { -- Secondary
                "weapon_pistol",
                "weapon_revolver"
            },
            { -- Extra
                "weapon_grenade",
                "weapon_snowball"
            }
        },
        Boss = {
            { -- Primary
                {"weapon_assaultrifle", 0, 200}, -- Weapon / Level / Limited to 200 bullets
                "weapon_musket" -- Weapon / Any level / 200 bullets
            },
            { -- Secondary
                "weapon_pistol",
                "weapon_revolver"
            },
            { -- Extra
                "weapon_grenade",
                "weapon_snowball"
            }
        },
    },
    Teams = {
        red = {
            Hex = "#FF0000",
            Color = 1,
            Title = Lang[Preference.lang]["title"]["red"],
            Safezone = {1044.262, 99.416},
            Crate = {957.747, 160.111, 79.85, 60} -- X, Y, Z, Rotation
        },
        green = {
            Hex = "#00FF00",
            Color = 2,
            Title = Lang[Preference.lang]["title"]["green"],
            Safezone = {654.182, 38.722},
            Crate = {670.878, 47.826, 79.85, 60} -- X, Y, Z, Rotation
        },
        blue = {
            Hex = "#0000FF",
            Color = 3,
            Title = Lang[Preference.lang]["title"]["blue"],
            Safezone = {862.124, -143.362},
            Crate = {880.338, -125.153, 79.85, 60} -- X, Y, Z, Rotation
        }
    },
    Lang = Lang[Preference.lang]
}