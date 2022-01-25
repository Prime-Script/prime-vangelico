-- My First Edit Of The En.Lua (If you translate to other languages | Please forward them to me)

local Translations = {
    error = {
        -- Info
        ["wrong_equipment"] = "Vous n'avez pas le bon équipement !",
        ["required_police"] = "Pas assez de policiers en service...",

        -- Security Cool Down
        ["cooldown"] = "Celui-ci vient d'être touché, il va falloir patienter !",
        ["cooldown_disable"] = "Vous n'avez pas encore piraté le système de sécurité !",

        -- Vangelico Fail
        ["security_fail"] = "Vous n'avez pas réussi à pirater le système de sécurité !",
        ["camera_fail"] = "Vous n'avez pas réussi à détruire la sécurité !",

        -- Smashing Cases
        ["weak_weapon"] = "Cette arme n'est pas assez puissante",
        ["disable_security"] = "Vous devez détruire le système de sécurité !",

        -- Leaving Fingerprints Behind!
        ["fingerprints_left"] = "Vous avez laissé des empreintes digitales sur le verre !",

        -- Prevent Player For Filling Pockets Full
        ["pockets_full"] = "Vous ne pouvez plus porter !",

        -- This will display if user changes the Dispatch System
        ["dispatch_system"] = "Cette dépêche de police n'est pas encore ajoutée !"
    },
    success = {
        -- Vagelico Success
        ["security_success"] = "Vous avez réussi à pirater le système de sécurité !",
        ["camera_success"] = "Vous avez désactivé la sécurité avec succès !",
    },
}

Lang = Locale:new({
phrases = Translations,
warnOnMissing = true})