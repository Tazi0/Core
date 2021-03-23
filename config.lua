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
        Size = "size-125", -- size-100 | size-110 | size-125 | size-150 | size-175 | size-200
        openKey = "E",
        closeKey = "BACKSPACE"
    },
    Zone = {
        Available = {
            -- To change colors check: https://docs.fivem.net/docs/game-references/blips/#blip-colors
            --  x         y     size
            {
                Zone = {-473.561, -519.668, 500}, -- x | y | size (Kill zone)
                Teams = {
                    red = {
                        safeZone = {1044.262, 99.416}, -- x | y (Safe zone where they can't be killed)
                        classModel = {957.747, 160.111, 79.85, 60}, -- x | y | z | r (Where the model will be to buy/rent weapons)
                        vehicleModel = {976.22, 184.93, 79.83, 165.35}, -- x | y | z | r (Where the model to spawn the vehicles will be)
                        vehicleSpawn = {983.14, 171.06, 79.92, 139.41}, -- x | y | z | r (Where the vehicle's are going to be spawned)
                        spawn = {1018.04, 38.84, 81.89} -- x | y | z (Where the team member will be spawned when killed)
                    },
                    green = {
                        safeZone = {654.182, 38.722},
                        classModel = {670.62, 2.72, 83.09, 294.7},
                        vehicleModel = {688.32, 34.15, 83.14, 182.98},
                        vehicleSpawn = {680.28, 20.32, 84.17, 200.79},
                        spawn = {683.39, -3.38, 84.19}
                    },
                    blue = {
                        safeZone = {862.124, -143.362},
                        classModel = {871.52, -122.9, 78.38, 34.69},
                        vehicleModel = {853.21, -112.34, 78.35, 287.52},
                        vehicleSpawn = {870.62, -103.22, 78.44, 55.67},
                        spawn = {874.75, -109.28, 79.45}
                    }
                }
            }--,
            -- {
            --     Zone = {-339.992, -1945.989, 500},
            --     Teams = {
            --         red = {
            --             safeZone = {-1098.904, -2935.309},
            --             classModel = {-1054.49, -2913.35, 12.96, 60},
            --             spawn = {-1071.73, -2970.94, 13.96}
            --         },
            --         green = {
            --             safeZone = {-1123.189, -1712.315},
            --             classModel = {-1156.3, -1729.32, 3.2, 294.7},
            --             spawn = {-1165.48, -1702.43, 4.32}
            --         },
            --         blue = {
            --             safeZone = {-201.87, -2607.559},
            --             classModel = {-275.37, -2592.53, 5, 34.69},
            --             spawn = {-261.1, -2583.84, 6}
            --         }
            --     }
            -- }
        },
        Sprite = 84,
        TimeLoop = 1 -- in minutes
    },
    Classes = {
        title = "Classes",
        description = "Choose your class",
        model = "s_m_y_blackops_01",
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
    Vehicles = {
        Config = { -- Data object, this will not be rendered
            SpawnInside = true -- true | false
        },
        Items = {
            Transport = {
                {
                    title = "BMX", -- Title of the vehicle
                    vehicle = "bmx", -- Name
                    level = 0, -- Minimum level
                    rent = 100, -- Rent price
                    buy = nil -- Can't buy
                }, {
                    title = "Nemesis",
                    vehicle = "nemesis",
                    level = 5,
                    rent = 500,
                    buy = 1000
                }, {
                    title = "Crusader",
                    vehicle = "crusader",
                    level = 10,
                    rent = 1000,
                    buy = nil
                }
            }
        }  
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