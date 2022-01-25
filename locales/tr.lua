-- My First Edit Of The En.Lua (If you translate to other languages | Please forward them to me)

local Translations = {
    error = {
        -- Info
        ["wrong_equipment"] = "Doğru Ekipmana Sahip Değilsiniz!",
        ["required_police"] = "Yeterli Sayıda Polis Yok!",

        -- Security Cool Down
        ["cooldown"] = "Yeni Soygun Yapıldı.Biraz Bekle!",
        ["cooldown_disable"] = "Henüz Güvenlik Sistemini Hacklemediniz!",

        -- Vangelico Fail
        ["security_fail"] = "Güvenlik Sistemini Hackleyemediniz!",
        ["camera_fail"] = "Güvenliği Devre Dışı Bırakmadınız!",

        -- Smashing Cases
        ["weak_weapon"] = "Bu Silah Yeterince Güçlü Değil",
        ["disable_security"] = "Güvenlik Sistemini Devre Dışı Bırakmanız Gerekiyor!",

        -- Leaving Fingerprints Behind!
        ["fingerprints_left"] = "Camda Parmak İzi Bıraktınız!",

        -- Prevent Player For Filling Pockets Full
        ["pockets_full"] = "Üzerin Dolu.Daha fazla taşıyamazsın.",

        -- This will display if user changes the Dispatch System
        ["dispatch_system"] = "Bu Sevk Sistemi Henüz Eklenmedi!"
    },
    success = {
        -- Vagelico Success
        ["security_success"] = "Güvenlik Sistemini Başarıyla Hacklediniz!",
        ["camera_success"] = "Güvenliği Başarıyla Devre Dışı Bıraktınız!",
    },
}

Lang = Locale:new({
phrases = Translations,
warnOnMissing = true})