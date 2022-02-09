-- My First Edit Of The En.Lua (If you translate to other languages | Please forward them to me)

local Translations = {
    error = {
        -- Info
        ["wrong_equipment"] = "You Don't Have The Right Equipment!",
        ["required_police"] = "Not Enough Police On Duty...",

        -- Security Cool Down
        ["cooldown"] = "This Has Just Been Hit, You'll Have To Wait!",
        ["cooldown_disable"] = "You Haven't Unlocked The Front Door Yet!",

        -- Vangelico Fail
        ["security_fail"] = "You Failed To Unlock The Front Door",
        ["camera_fail"] = "You Failed To Disable The Cameras!",

        -- Smashing Cases
        ["weak_weapon"] = "This Weapon Isn't Strong Enough",
        ["disable_security"] = "You Need To Disable The Cameras!",

        -- Leaving Fingerprints Behind!
        ["fingerprints_left"] = "You've Left Fingerprints On The Glass...",

        -- Prevent Player For Filling Pockets Full
        ["pockets_full"] = "You Can't Carry Anymore...",

        -- This will display if user changes the Dispatch System
        ["dispatch_system"] = "This Dispatch System Isn't Added Yet!",

        -- Smash The Case System
        ["smashed_already"] = "This Case Has Already Been Smashed!",
        ["distance_check"] = "You Are Not Close Enough To The Case!",

        -- Police Reboot Security System
        ["fingerprints"] = "You've Left Fingerprints On The Glass!",

        -- Door Check
        ["door_system"] = "This Door System Is Not Added!",

        -- Police Reboot Security System
        ["reboot_timer"] = "The System Will Reboot In 30 Seconds!",
    },
    success = {
        -- Vagelico Success
        ["security_success"] = "You Successfully Unlocked The Front Door!",
        ["camera_success"] = "You Successfully Disable The Cameras!",

        -- Confirming The System Reboot
        ["door_locked"] = "The System Has Rebooted, And The Door Has Been Locked!",
    },
}

Lang = Locale:new({
phrases = Translations,
warnOnMissing = true})