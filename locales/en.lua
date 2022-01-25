-- My First Edit Of The En.Lua (If you translate to other languages | Please forward them to me)

local Translations = {
    error = {
        -- Info
        ["wrong_equipment"] = "You Don't Have The Correct Equipment!",
        ["required_police"] = "Not Enough Police On Duty...",

        -- Security Cool Down
        ["cooldown"] = "This Has Just Been Hit, You'll Have To Wait!",
        ["cooldown_disable"] = "You Haven't Hacked The Security System Yet!",

        -- Vangelico Fail
        ["security_fail"] = "You Failed To Hack The Security System!",
        ["camera_fail"] = "You Failed To Destroy The Security!",

        -- Smashing Cases
        ["weak_weapon"] = "This Weapon Isn't Strong Enough",
        ["disable_security"] = "You Need To Destroy The Security System!",

        -- Leaving Fingerprints Behind!
        ["fingerprints_left"] = "You've Left Fingerprints On The Glass",

        -- Prevent Player For Filling Pockets Full
        ["pockets_full"] = "You Can't Carry Anymore!",

        -- This will display if user changes the Dispatch System
        ["dispatch_system"] = "This Dispatch System Isn't Added Yet!"
    },
    success = {
        -- Vagelico Success
        ["security_success"] = "You Successfully Hacked The Security System!",
        ["camera_success"] = "You Successfully Destroyed The Security!",
    },
}

Lang = Locale:new({
phrases = Translations,
warnOnMissing = true})