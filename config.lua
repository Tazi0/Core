-- Resource configuration
Config = {
    Preference = Preference,
    Player = {
        Connection = "discord", -- discord | steam
        NPC = false, -- false | true
        AfkKick = true
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
                        class = {957.747, 160.111, 79.85, 60}, -- x | y | z | r
                        spawn = {1018.04, 38.84, 81.89} -- x | y | z
                    },
                    green = {
                        safe = {654.182, 38.722},
                        class = {670.62, 2.72, 83.09, 294.7},
                        spawn = {683.39, -3.38, 84.19}
                    },
                    blue = {
                        safe = {862.124, -143.362},
                        class = {871.52, -122.9, 78.38, 34.69},
                        spawn = {874.75, -109.28, 79.45}
                    }
                }
            },
            {
                Zone = {-339.992, -1945.989, 500},
                Teams = {
                    red = {
                        safe = {-1098.904, -2935.309},
                        class = {-1054.49, -2913.35, 12.96, 60},
                        spawn = {-1071.73, -2970.94, 13.96}
                    },
                    green = {
                        safe = {-1123.189, -1712.315},
                        class = {-1156.3, -1729.32, 3.2, 294.7},
                        spawn = {-1165.48, -1702.43, 4.32}
                    },
                    blue = {
                        safe = {-201.87, -2607.559},
                        class = {-275.37, -2592.53, 5, 34.69},
                        spawn = {-261.1, -2583.84, 6}
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
            { -- Primary (default: rent = 1000, buy = 2000, bullets = 150, level = 0)
                {
                    weapon = "weapon_compactrifle", -- Weapon hash
                    level = 0, -- Any level
                    rent = 0, -- Free rent
                    buy = 1500, -- $1500 to buy the weapon (free to spawn weapon after)
                    bullets = 100 -- Max amount of bullets you can buy
                },
                {
                    weapon = "weapon_musket", 
                    level = 20, -- Minimum level 20
                    rent = 100, -- $100 rent
                    buy = nil, -- Can't buy
                    bullets = 60
                }
            },
            { -- Secondary (default: rent = 500, buy = 1500, bullets = 100, level = 0)
                "weapon_appistol" -- Weapon / Any Level
            },
            { -- Extra (default: rent = 100, buy = 1000, bullets = 20, level = 0)
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
    Money = {
        Currency = "$"
    },
    Teams = {
        red = {
            Hex = "#FF0000", -- HEX color (used to mix colors & for UI)
            Color = 1, -- ^1 = Red
            SafezoneShooting = false, -- True = enabled to shoot in safezone
            Model = "s_m_y_blackops_03"
        },
        green = {
            Hex = "#00FF00",
            Color = 2,
            SafezoneShooting = false,
            Model = "s_m_y_blackops_03"
        },
        blue = {
            Hex = "#0000FF",
            Color = 3,
            SafezoneShooting = false,
            Model = "s_m_y_blackops_03"
        }
    },
    Lang = Lang[Preference.lang]
}