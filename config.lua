-- Global variable, this will be exported for ever script to use
Preference = {
    lang = "en"
}

-- Resource configuration
Config = {
    Preference = Preference,
    Player = {
        Connection = "discord" -- discord | steam
    },
    Menu = {
        Placement = "topleft", -- topleft | topcenter | topright | centerleft | center | centerright | bottomleft | bottomcenter | bottomright
        Size = "size-125" -- size-100 | size-110 | size-125 | size-150 | size-175 | size-200
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
        model = "s_m_y_blackops_01",
        openKey = "E",
        closeKey = "BACKSPACE",
        items = {
            {
                label = "Basic",
                level = 0
            },
            {
                label = "Medium",
                level = 15
            },
            {
                label = "Boss",
                level = 30
            }
        }
    },
    Weapons = {
        -- Available weapons in "Crossbase -> json.lua -> weaponHash"
        Basic = {
            { -- Primary
                {"weapon_compactrifle", 0, 200}, -- Weapon / Level / Limited to 200 bullets (default is 200)
                "weapon_musket" -- Weapon / Any level / 200 bullets
            },
            { -- Secondary
                "weapon_appistol"
            },
            { -- Extra
                "weapon_machete",
                "weapon_flaregun"
            }
        },
        Medium = {
            { -- Primary
                "weapon_carbinerifle",
                "weapon_pumpshotgun"
            },
            { -- Secondary
                "weapon_pistol"
            },
            { -- Extra
                "weapon_grenade"
            }
        },
        Boss = {
            { -- Primary
                "weapon_assaultrifle",
                "weapon_musket"
            },
            { -- Secondary
                "weapon_pistol",
                "weapon_revolver"
            },
            { -- Extra
                "weapon_grenade",
                "weapon_assaultsmg"
            }
        },
    },
    Kill = {
        Currency = "$",
        Player = 250,
        Vehicle = 500
    },
    Teams = {
        red = {
            Hex = "#FF0000", -- HEX color (used to mix colors & for UI)
            Color = 1, -- ^1 = Red
            Title = Lang[Preference.lang]["team"]["red"], -- Title of the team (defined in language file)
            Safezone = {1044.262, 99.416}, -- X, Y
            SafezoneShooting = true, -- False = enabled to shoot in safezone
            Class = {957.747, 160.111, 79.85, 60} -- X, Y, Z, Rotation
        },
        green = {
            Hex = "#00FF00",
            Color = 2,
            Title = Lang[Preference.lang]["team"]["green"],
            Safezone = {654.182, 38.722},
            SafezoneShooting = true,
            Class = {670.62, 2.72, 83.09, 294.7}
        },
        blue = {
            Hex = "#0000FF",
            Color = 3,
            Title = Lang[Preference.lang]["team"]["blue"],
            Safezone = {862.124, -143.362},
            SafezoneShooting = true,
            Class = {871.52, -122.9, 78.38, 34.69}
        }
    },
    Lang = Lang[Preference.lang]
}