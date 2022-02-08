Config = Config or {}

------ / Door System | If you use qb-doorlock then use "qb" | If you use nui_doorlock then use "nui"
Config.DoorLock = "nui"

------ / This will be the ID of the Door that you are using only use this section if you are using qb-doorlock
Config.QBDoorID = 1 -- Enter the Door ID only if you're using qb-doorlock

------ / These are the only working Dispatch Systems that are in place for the alert, however more can be added!
------ / "Linden" | More Dispatch System's Coming Soon
Config.Dispatch = "Linden"

------ / Police Required To Start Heist
Config.RequiredCops = 3

------ / Set CoolDown Between Each Of Heist JewelLocation
Config.Cooldown = 360

------ / Set CoolDown For VitrineCases (Prevents Spam Looting) | This Prevents people from "scuffing" inside and taking loot
Config.Timeout = 90 * (60 * 1000)

------ / Hack The Security System / Laptop Minigame
Config.VangelicoTime = 15
Config.VangelicoBlocks = 4
Config.VangelicoRepeat = 2

------ / Destroy The Security System / Thermite Minigame
Config.CorrectBlocks = 16
Config.IncorrectBlocks = 3 
Config.TimeToShow = 6 
Config.TimeToLose = 20

------ / Heist Locations (HackSecurity = Roof Of Vangelico | DisableCameras = Inside Vangelico)
Config.JewelLocation = {
    ["ThermiteSecurity"] = {
        x = -596.26,
        y = -283.87,
        z = 50.32,
        isDone = false,
        isBusy = false,
    },
    ["DisableCameras"] = {
        x = -629.38,
        y = -230.46,
        z = 38.06,
        isDone = false,
        isBusy = false,
    },
}


------ / If set to true it will show the Poly Zones | If set to false it will hide the PolyZones (Green Zones)

Config.PolyZone = false

------ / Set Location Of Each Vitrine Case
Config.Locations = {
    [1] = {
        ["coords"] = vector4(-626.06, -234.19, 39.22, 216.17),
        ["isOpened"] = false,
        ["isBusy"] = false,
    }, 
    [2] = {
        ["coords"] = vector4(-626.58, -233.47, 39.22, 216.17),
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [3] = {
        ["coords"] = vector4(-625.4, -238.3, 39.22, 216.17),
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [4] = {
        ["coords"] = vector4(-626.46, -239.02, 39.24, 216.17),
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [5] = {
        ["coords"] = vector4(-627.59, -234.26, 38.97, 216.17),
        ["isOpened"] = false,
        ["isBusy"] = false,
    }, 
    [6] = {
        ["coords"] = vector4(-627.13, -234.79, 38.86, 216.17),
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [7] = {
        ["coords"] = vector4(-624.25, -226.71, 39.22, 216.17),
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [8] = {
        ["coords"] = vector4(-625.2, -227.32, 39.22, 216.17),
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [9] = {
        ["coords"] = vector4(-623.72, -228.68, 39.24, 216.17),
        ["isOpened"] = false,
        ["isBusy"] = false,
    }, 
    [10] = {
        ["coords"] = vector4(-623.96, -230.76, 39.22, 127.04),
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [11] = {
        ["coords"] = vector4(-621.4, -228.77, 39.22, 127.04),
        ["isOpened"] = false,
        ["isBusy"] = false,
    }, 
    [12] = {
        ["coords"] = vector4(-619.25, -227.31, 39.24, 310.89),
        ["isOpened"] = false,
        ["isBusy"] = false,
    }, 
    [13] = {
        ["coords"] = vector4(-620.02, -226.36, 39.22, 304),
        ["isOpened"] = false,
        ["isBusy"] = false,
    }, 
    [14] = {
        ["coords"] = vector4(-617.86, -229.26, 39.22, 127.04),
        ["isOpened"] = false,
        ["isBusy"] = false,
    }, 
    [15] = {
        ["coords"] = vector4(-617.14, -230.28, 39.24, 127.04),
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [16] = {
        ["coords"] = vector4(-620.09, -230.63, 39.22, 127.04),
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [17] = {
        ["coords"] = vector4(-620.46, -232.87, 39.22, 216.17),
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [18] = {
        ["coords"] = vector4(-622.62, -232.63, 39.22, 127.04),
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [19] = {
        ["coords"] = vector4(-618.9, -234.17, 39.22, 216.17),
        ["isOpened"] = false,
        ["isBusy"] = false, 
    },
    [20] = {
        ["coords"] = vector4(-619.93, -234.85, 39.22, 216.17),
        ["isOpened"] = false,
        ["isBusy"] = false,
    }
}

------- / Add Weapons Here That You Want To Be Able To Smash The Vitrine Cases
Config.WhitelistedWeapons = {

    -- Melee

    [GetHashKey("weapon_hammer")] = {
        ["timeOut"] = 12000
    },

    -- Pistols

    [GetHashKey("weapon_pistol")] = {
        ["timeOut"] = 12000
    },
    [GetHashKey("weapon_snspistol")] = {
        ["timeOut"] = 12000
    },
    [GetHashKey("weapon_heavypistol")] = {
        ["timeOut"] = 12000
    },
    [GetHashKey("weapon_pistol50")] = {
        ["timeOut"] = 12000
    },
    [GetHashKey("weapon_machinepistol")] = {
        ["timeOut"] = 12000
    },

    -- Small Machine Guns

    [GetHashKey("weapon_assaultsmg")] = {
        ["timeOut"] = 12000
    },
    [GetHashKey("weapon_microsmg")] = {
        ["timeOut"] = 12000
    },
    [GetHashKey("weapon_minismg")] = {
        ["timeOut"] = 12000
    },

    -- Light Machine Guns

    -- Assault Rifles
    [GetHashKey("weapon_assaultrifle")] = {
        ["timeOut"] = 12000
    },
    [GetHashKey("weapon_specialcarbine")] = {
        ["timeOut"] = 12000
    },
    [GetHashKey("weapon_gusenberg")] = {
        ["timeOut"] = 12000
    },
    [GetHashKey("weapon_advancedrifle")] = {
        ["timeOut"] = 12000
    },
    [GetHashKey("weapon_bullpuprifle")] = {
        ["timeOut"] = 12000
    },
    [GetHashKey("weapon_carbinerifle")] = {
        ["timeOut"] = 12000
    },
    [GetHashKey("weapon_compactrifle")] = {
        ["timeOut"] = 12000
    },
}

------ / Items Inside Vitrine Cases
Config.VitrineRewards = {
    [1] = {
        ["item"] = "rolex",
        ["amount"] = {
            ["min"] = 10,
            ["max"] = 15
        },
    },
    [2] = {
        ["item"] = "diamond_ring",
        ["amount"] = {
            ["min"] = 10,
            ["max"] = 25
        },
    },
    [3] = {
        ["item"] = "goldchain",
        ["amount"] = {
            ["min"] = 10,
            ["max"] = 15
        },
    },
}

------ / Blip Location On The Map | Minimap
Config.JewelleryLocation = {
    ["coords"] = {
        ["x"] = -630.5,
        ["y"] = -237.13,
        ["z"] = 38.08,
    }
}

------ / Set Gloves For Male and Female For Chance Of Fingerprints
Config.MaleNoHandshoes = {
    [0] = true, [1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true, [9] = true, [10] = true, [11] = true, [12] = true, [13] = true, [14] = true, [15] = true, [18] = true, [26] = true, [52] = true, [53] = true, [54] = true, [55] = true, [56] = true, [57] = true, [58] = true, [59] = true, [60] = true, [61] = true, [62] = true, [112] = true, [113] = true, [114] = true, [118] = true, [125] = true, [132] = true
}

Config.FemaleNoHandshoes = {
    [0] = true, [1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true, [9] = true, [10] = true, [11] = true, [12] = true, [13] = true, [14] = true, [15] = true, [19] = true, [59] = true, [60] = true, [61] = true, [62] = true, [63] = true, [64] = true, [65] = true, [66] = true, [67] = true, [68] = true, [69] = true, [70] = true, [71] = true, [129] = true, [130] = true, [131] = true, [135] = true, [142] = true, [149] = true, [153] = true, [157] = true, [161] = true, [165] = true
}
