-- Global variable, this will be exported for ever script to use
Preference = {
    lang = "en"
}

-- Resource configuration
Config = {
    Preference = Preference,
    Player = {
        Connection = "discord", -- discord | steam
        NPC = false -- false | true
    },
    Menu = {
        Placement = "topleft", -- topleft | topcenter | topright | centerleft | center | centerright | bottomleft | bottomcenter | bottomright
        Size = "size-125" -- size-100 | size-110 | size-125 | size-150 | size-175 | size-200
    },
    Zone = {
        Available = {
            -- To change colors check: https://docs.fivem.net/docs/game-references/blips/#blip-colors
            --  x         y     size
            {
                Zone = {-473.561, -519.668, 500}, -- x | y | size
                Teams = {
                    red = {
                        safe = {1044.262, 99.416}, -- x | y
                        class = {957.747, 160.111, 79.85, 60} -- x | y | z | r
                    },
                    green = {
                        safe = {654.182, 38.722},
                        class = {670.62, 2.72, 83.09, 294.7}
                    },
                    blue = {
                        safe = {862.124, -143.362},
                        class = {871.52, -122.9, 78.38, 34.69}
                    }
                }
            },
            {
                Zone = {-339.992, -1945.989, 500},
                Teams = {
                    red = {
                        safe = {-1098.904, -2935.309},
                        class = {-1054.49, -2913.35, 12.96, 60}
                    },
                    green = {
                        safe = {-1123.189, -1712.315},
                        class = {-1156.3, -1729.32, 3.2, 294.7}
                    },
                    blue = {
                        safe = {-201.87, -2607.559},
                        class = {-275.37, -2592.53, 5, 34.69}
                    }
                }
            }
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
    Teams = {
        red = {
            Hex = "#FF0000", -- HEX color (used to mix colors & for UI)
            Color = 1, -- ^1 = Red
            Title = Lang[Preference.lang]["team"]["red"], -- Title of the team (defined in language file)
            SafezoneShooting = false -- True = enabled to shoot in safezone
        },
        green = {
            Hex = "#00FF00",
            Color = 2,
            Title = Lang[Preference.lang]["team"]["green"],
            SafezoneShooting = false
        },
        blue = {
            Hex = "#0000FF",
            Color = 3,
            Title = Lang[Preference.lang]["team"]["blue"],
            SafezoneShooting = false
        }
    },
    Lang = Lang[Preference.lang]
}