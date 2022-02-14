local QBCore = exports['qb-core']:GetCoreObject()
local CurrentCops = -0
local copsCalled = false
local requiredItems = {}
local isLoggedIn = true
PlayerJob = {}

-- Thermite The Security System On Top Of The Roof
RegisterNetEvent('thermite:UseThermite')
AddEventHandler('thermite:UseThermite', function()
    if QBCore ~= nil and isLoggedIn then
        local pos = GetEntityCoords(PlayerPedId())
        if #(pos - vector3(Config.JewelLocation["ThermiteSecurity"].x, Config.JewelLocation["ThermiteSecurity"].y,Config.JewelLocation["ThermiteSecurity"].z)) < 1.0 then
            if CurrentCops >= Config.RequiredCops then
                QBCore.Functions.TriggerCallback("qb-jewellery:Callback:Cooldown",function(isCooldown)
                    if not isCooldown then
                        QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem)
                            if hasItem then
                                TriggerEvent('inventory:client:requiredItems', requiredItems, false)
                                TriggerServerEvent("qb-jewellery:server:SetHackSecurityStatus", "isBusy", true)
                                exports["memorygame"]:thermiteminigame(Config.CorrectBlocks, Config.IncorrectBlocks, Config.TimeToShow, Config.TimeToLose,
                                function() -- Successfully Disable Cameras
                                    ThermiteAnimation() 
                                    ThermiteSuccess()
                                    TriggerServerEvent('qb-jewellery:BeginCooldown')

                                    -- Door Dependency (NUI or QB)
                                    if Config.DoorLock == "nui" then
                                        -- Successfully Complete Thermite Game (Open Door)
                                        TriggerServerEvent('nui_doorlock:server:updateState', "vangelicodoor", false, false, false, true)
                                    else if Config.DoorLock == "qb" then
                                        -- Successfully Complete Thermite Game (Open Door)
                                        TriggerServerEvent('qb-doorlock:server:updateState', Config.QBDoorID, false)
                                    else
                                        if Config.Locales == true then
                                            QBCore.Functions.Notify(Lang:t("error.door_system"), "error", 3500)
                                        else
                                            QBCore.Functions.Notif('This Door System Is Not Added!', 'error')
                                        end
                                    end
                                end

                                end,
                                function() -- Fail To Disable Cameras
                                    ThermiteFailed()
                                end)                        
                            else
                                if Config.Locales == true then
                                    QBCore.Functions.Notify(Lang:t("error.wrong_equipment"), "error", 3500)
                                else
                                    QBCore.Functions.Notify("You Don\'t Have The Correct Equipment!", "error")
                                end
                            end
                        end, "thermite")
                    else
                        if Config.Locales == true then
                            QBCore.Functions.Notify(Lang:t("error.cooldown"), "error", 3500)
                        else
                            QBCore.Functions.Notify("This Has Just Been Hit, You'll Have To Wait!", "error")
                        end
                    end      
                end)
            else
                if Config.Locales == true then
                    QBCore.Functions.Notify(Lang:t("error.required_police"), "error", 3500)
                else
                    QBCore.Functions.Notify('Not Enough Police ('.. Config.RequiredCops ..') Required!', 'error')
                end 
            end 
        end   
    else
        Citizen.Wait(3000)
    end
end)

-- Effect for Thermite
RegisterNetEvent("Peely-ptfxparticle")
AddEventHandler("Peely-ptfxparticle", function(method)
    local ptfx

    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Citizen.Wait(1)
    end
        ptfx = vector3(-596.05, -282.71, 50.25)
    SetPtfxAssetNextCall("scr_ornate_heist")
    local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", ptfx, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
    Citizen.Wait(5000)
    StopParticleFxLooped(effect, 0)
end)

-- Thermite Animations
function ThermiteAnimation() 
    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") and not HasModelLoaded("hei_p_m_bag_var22_arm_s") and not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Citizen.Wait(50)
    end
    local ped = PlayerPedId()
    SetEntityHeading(ped, 297)
    Citizen.Wait(100)

    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
    local bagscene = NetworkCreateSynchronisedScene(-596.04, -283.71, 50.32, rotx, roty, rotz + 297, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), -596.09, -283.75, 50.32,  true,  true, false)

    SetEntityCollision(bag, false, true)
    NetworkAddPedToSynchronisedScene(ped, bagscene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.2, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, bagscene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
    SetPedComponentVariation(ped, 5, 0, 0, 0)
    NetworkStartSynchronisedScene(bagscene)
    Citizen.Wait(1500)
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local bomba = CreateObject(GetHashKey("hei_prop_heist_thermite"), x, y, z + 0.3,  true,  true, true)

    SetEntityCollision(bomba, false, true)
    AttachEntityToEntity(bomba, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
    Citizen.Wait(2000)
    DeleteObject(bag)
    SetPedComponentVariation(ped, 5, 45, 0, 0)
    DetachEntity(bomba, 1, 1)
    FreezeEntityPosition(bomba, true)
    TriggerServerEvent("Peely-particleserver", method)
    SetPtfxAssetNextCall("scr_ornate_heist")
    local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", ptfx, 0.0, 0.0, 0.0, 1.0, false, false, false, false)

    NetworkStopSynchronisedScene(bagscene)
    TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
    TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_loop", 8.0, 8.0, 3000, 49, 1, 0, 0, 0)
    Citizen.Wait(5000)
    ClearPedTasks(ped)
    DeleteObject(bomba)
    StopParticleFxLooped(effect, 0)
end

-- Disable the Security System
RegisterNetEvent('hackinglaptop:UseHackinglaptop')
AddEventHandler('hackinglaptop:UseHackinglaptop', function()
    local pos = GetEntityCoords(PlayerPedId())
    if #(pos - vector3(Config.JewelLocation["DisableCameras"].x, Config.JewelLocation["DisableCameras"].y,Config.JewelLocation["DisableCameras"].z)) < 1.5 then
        QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem)
            if Config.JewelLocation["ThermiteSecurity"].isDone then
                if hasItem then
                    TriggerEvent('inventory:client:requiredItems', requiredItems, false)
                    TriggerServerEvent("qb-jewellery:server:SetThermiteSecurityStatus", "isBusy", true)
                    QBCore.Functions.Progressbar("power_hack", "Connecting...", math.random(5500, 5600), false, true, {
                           useWhileDead = false,
                           canCancel = false,
                           controlDisables = {
                           disableMovement = true,
                           disableCarMovement = false,
                           disableMouse = false,
                           disableCombat = false,
                        },
                    })
                    SecurityAnimation()
                    Wait(2000)
                    exports['hacking']:OpenHackingGame(Config.VangelicoTime, Config.VangelicoBlocks, Config.VangelicoRepeat, 
                    function(Success)
                        if Success then
                            SecuritySuccess()
                            SecuritySuccessAnim()
                        else
                            SecurityFailed()
                            SecurityFailedAnim()
                        end
                    end)                        
                else
                    if Config.Locales == true then
                    QBCore.Functions.Notify(Lang:t("error.wrong_equipment"), "error", 3500)
                    else
                        QBCore.Functions.Notify("You Don\'t Have The Correct Equipment!", "error")
                    end
                end

            else
                if Config.Locales == true then
                    QBCore.Functions.Notify(Lang:t("error.cooldown_disable"), "error", 3500)
                else
                    QBCore.Functions.Notify("You Haven't Hacked The Security System Yet!", "error")
                end
            end
            
        end, "usb_green")
        
    end

end)

-- Location For Laptop Aninmation
local hackCoord = {x = -629.60, y = -230.05, z = 38.45, h = 36.8}

-- Hack Into Security System!
function SecurityAnimation()
    local animDict = "anim@heists@ornate_bank@hack"
    RequestAnimDict(animDict)
    RequestModel("hei_prop_hst_laptop")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestModel("hei_prop_heist_card_hack_02")
    while not HasAnimDictLoaded(animDict)
        or not HasModelLoaded("hei_prop_hst_laptop")
        or not HasModelLoaded("hei_p_m_bag_var22_arm_s") 
        or not HasModelLoaded("hei_prop_heist_card_hack_02") do
        Wait(100)
    end
    local ped = PlayerPedId()
    local targetPosition, targetRotation = (vec3(GetEntityCoords(ped))), vec3(GetEntityRotation(ped))
    local cardLoc = vector4(-629.60, -230.05, 38.60, 36.8)

    SetEntityHeading(ped, hackCoord.h)
    local animPos = GetAnimInitialOffsetPosition(animDict, "hack_enter", hackCoord.x, hackCoord.y, hackCoord.z+0.80, hackCoord.x, hackCoord.y, hackCoord.z+0.85, 0, 2)
    local animPos2 = GetAnimInitialOffsetPosition(animDict, "hack_loop", hackCoord.x, hackCoord.y, hackCoord.z+0.80, hackCoord.x, hackCoord.y, hackCoord.z+0.85, 0, 2)
    local animPos3 = GetAnimInitialOffsetPosition(animDict, "hack_exit", hackCoord.x, hackCoord.y, hackCoord.z+0.80, hackCoord.x, hackCoord.y, hackCoord.z+0.85, 0, 2)

    netScene = NetworkCreateSynchronisedScene(animPos, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), targetPosition, 1, 1, 0)
    laptop = CreateObject(GetHashKey("hei_prop_hst_laptop"), targetPosition, 1, 1, 0)
    card = CreateObject(GetHashKey("hei_prop_heist_card_hack_02"), cardLoc, 1, 1, 0)

    NetworkAddPedToSynchronisedScene(ped, netScene, animDict, "hack_enter", 1.2, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene, animDict, "hack_enter_bag", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene, animDict, "hack_enter_laptop", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(card, netScene, animDict, "hack_enter_card", 4.0, -8.0, 1)

    netScene2 = NetworkCreateSynchronisedScene(animPos2, targetRotation, 2, false, true, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene2, animDict, "hack_loop", 1.2, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene2, animDict, "hack_loop_bag", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene2, animDict, "hack_loop_laptop", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(card, netScene2, animDict, "hack_loop_card", 4.0, -8.0, 1)

    netScene3 = NetworkCreateSynchronisedScene(animPos3, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene3, animDict, "hack_exit", 1.2, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene3, animDict, "hack_exit_bag", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene3, animDict, "hack_exit_laptop", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(card, netScene3, animDict, "hack_exit_card", 4.0, -8.0, 1)

    SetPedComponentVariation(ped, 5, 0, 0, 0)
    Wait(200)
    NetworkStartSynchronisedScene(netScene)
    Wait(6300)
    NetworkStartSynchronisedScene(netScene2)
end

------- / Trigger Status

RegisterNetEvent('police:SetCopCount')
AddEventHandler('police:SetCopCount', function(amount)
    CurrentCops = amount
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    TriggerServerEvent("qb-jewellery:server:SetJewelLocations")
end)

RegisterNetEvent('qb-jewellery:client:ConfigLocs')
AddEventHandler('qb-jewellery:client:ConfigLocs', function(list)
    Config.JewelLocation = list
end)

-- Hacking Security System!
RegisterNetEvent('qb-jewellery:client:SetThermiteSecurityStatus')
AddEventHandler('qb-jewellery:client:SetThermiteSecurityStatus', function(stateType, state)
    if stateType == "isBusy" then
        Config.JewelLocation["ThermiteSecurity"].isBusy = state
        print("SECURITY IS BUSY")
    elseif stateType == "isDone" then
        Config.JewelLocation["ThermiteSecurity"].isDone = state
        print("SECURITY IS DONE")
    end
end)

-- Disabling The Cameras
RegisterNetEvent('qb-jewellery:client:SetCameraStatus')
AddEventHandler('qb-jewellery:client:SetCameraStatus', function(stateType, state)
    if stateType == "isBusy" then
        Config.JewelLocation["DisableCameras"].isBusy = state
        print("CAMERAS ARE BUSY")
    elseif stateType == "isDone" then
        Config.JewelLocation["DisableCameras"].isDone = state
        print("CAMERAS ARE DONE")
    end
end)

-- Functions


function SecuritySuccessAnim()
    NetworkStartSynchronisedScene(netScene3)
    Wait(2500)
    NetworkStopSynchronisedScene(netScene3)
    DeleteObject(laptop)
    DeleteObject(bag)
    DeleteObject(card)    
end

function SecurityFailedAnim()
    NetworkStartSynchronisedScene(netScene3)
    Wait(2500)
    NetworkStopSynchronisedScene(netScene3)
    DeleteObject(laptop)
    DeleteObject(bag)
    DeleteObject(card)    
end

-- Hack Security Fail
function ThermiteFailed()
    if Config.Locales == true then
    QBCore.Functions.Notify(Lang:t("error.security_fail"), "error", 3500)
    else
        QBCore.Functions.Notify("You Failed To Hack The Security System!", "error")
    end
    PlaySound(-1, "Place_Prop_Fail", "DLC_Dmod_Prop_Editor_Sounds", 0, 0, 1)
    TriggerServerEvent("qb-jewellery:server:SetThermiteSecurityStatus", "isBusy", false)    
end

-- Hack Security Successfully
function ThermiteSuccess()
    if Config.Locales == true then
    QBCore.Functions.Notify(Lang:t("success.security_success"), "success", 3500)
    else
        QBCore.Functions.Notify("You Successfully Hacked The Security System!", "success")
    end
    TriggerServerEvent('qb-jewellery:Server:BeginCooldown')
    TriggerServerEvent("QBCore:Server:RemoveItem", "thermite", 1)
    local pos = GetEntityCoords(PlayerPedId())
    if #(pos - vector3(Config.JewelLocation["ThermiteSecurity"].x, Config.JewelLocation["ThermiteSecurity"].y,Config.JewelLocation["ThermiteSecurity"].z)) < 1.5 then
        TriggerServerEvent("qb-jewellery:server:SetThermiteSecurityStatus", "isDone", true)
        TriggerServerEvent("qb-jewellery:server:SetThermiteSecurityStatus", "isBusy", false)  
    end
end

-- Fail Disabled Cameras
function SecurityFailed()
    if Config.Locales == true then
    QBCore.Functions.Notify(Lang:t("error.camera_fail"), "error", 3500)
    else
        QBCore.Functions.Notify("You Failed To Disabled The Security!", "error")
    end
    PlaySound(-1, "Place_Prop_Fail", "DLC_Dmod_Prop_Editor_Sounds", 0, 0, 1)
    TriggerServerEvent("qb-jewellery:server:SetCameraStatus", "isBusy", false)    
end

-- Successfully Disabling Cameras
function SecuritySuccess()
    if Config.Locales == true then
        QBCore.Functions.Notify(Lang:t("success.camera_success"), "success", 3500)
    else
        QBCore.Functions.Notify("You Have Disabled The Security!", "success")
    end
    local pos = GetEntityCoords(PlayerPedId())
    TriggerServerEvent("QBCore:Server:RemoveItem", "usb_green", 1)
    if #(pos - vector3(Config.JewelLocation["DisableCameras"].x, Config.JewelLocation["DisableCameras"].y,Config.JewelLocation["DisableCameras"].z)) < 1.5 then
        TriggerServerEvent("qb-jewellery:server:SetCameraStatus", "isDone", true)
        TriggerServerEvent("qb-jewellery:server:SetCameraStatus", "isBusy", false)  
    end
end

-- Leaves FingerPrints Behind For Police
function IsWearingHandshoes()
    local armIndex = GetPedDrawableVariation(PlayerPedId(), 3)
    local model = GetEntityModel(PlayerPedId())
    local retval = true
    if model == GetHashKey("mp_m_freemode_01") then
        if Config.MaleNoHandshoes[armIndex] ~= nil and Config.MaleNoHandshoes[armIndex] then
            retval = false
        end
    else
        if Config.FemaleNoHandshoes[armIndex] ~= nil and Config.FemaleNoHandshoes[armIndex] then
            retval = false
        end
    end
    return retval
end

-- Creates Smoke For Thermite
function CreateFire(coords, time)
    for i = 1, math.random(1, 7), 1 do
        TriggerServerEvent("thermite:StartServerFire", coords, 24, false)
    end
    Citizen.Wait(time)
    TriggerServerEvent("thermite:StopFires")
end

-- Creates Animation For Smashing Cases
function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(3)
    end
end

-- Loads Particles For The Glass Cases
function loadParticle()
	if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
		RequestNamedPtfxAsset("scr_jewelheist")
    end
    while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
		Wait(0)
    end
    SetPtfxAssetNextCall("scr_jewelheist")
end

-- Checks Player For Whitelisted Weapon
local function validWeapon()
    local ped = PlayerPedId()
    local pedWeapon = GetSelectedPedWeapon(ped)

    for k, v in pairs(Config.WhitelistedWeapons) do
        if pedWeapon == k then
            return true
        end
    end
    return false
end

-- Creates Stage For Stealing From Cases / Needs Updating
local function smashVitrine(k)
    if Config.JewelLocation["DisableCameras"].isDone then
        if validWeapon() then
            local animDict = "missheist_jewel"
            local animName = "smash_case"
            local ped = PlayerPedId()
            local plyCoords = GetOffsetFromEntityInWorldCoords(ped, 0, 0.6, 0)
            local pedWeapon = GetSelectedPedWeapon(ped)
            if math.random(1, 100) <= 80 and not IsWearingHandshoes() then
                TriggerServerEvent("evidence:server:CreateFingerDrop", plyCoords)
            elseif math.random(1, 100) <= 5 and IsWearingHandshoes() then
                TriggerServerEvent("evidence:server:CreateFingerDrop", plyCoords)
                if Config.Locales == true then
                    QBCore.Functions.Notify(Lang:t("error.fingerprints"), "error")
                else
                    QBCore.Functions.Notify("You've Left Fingerprints On The Glass!", "error")
                end
            end
        smashing = true
        QBCore.Functions.Progressbar("smash_vitrine", "Grabbing Jewellery", Config.WhitelistedWeapons[pedWeapon]["timeOut"], false, true, {
            disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function() -- Done
                TriggerServerEvent('qb-jewellery:server:setVitrineState', "isOpened", true, k)
                TriggerServerEvent('qb-jewellery:server:setVitrineState', "isBusy", false, k)
                TriggerServerEvent('qb-jewellery:server:vitrineReward')
                TriggerServerEvent('qb-jewellery:server:setTimeout')
                smashing = false
                TaskPlayAnim(ped, animDict, "exit", 3.0, 3.0, -1, 2, 0, 0, 0, 0)
            end, function() -- Cancel
                TriggerServerEvent('qb-jewellery:server:setVitrineState', "isBusy", false, k)
                smashing = false
                TaskPlayAnim(ped, animDict, "exit", 3.0, 3.0, -1, 2, 0, 0, 0, 0)
            end)
            TriggerServerEvent('qb-jewellery:server:setVitrineState', "isBusy", true, k)

            CreateThread(function()
                while smashing do
                    loadAnimDict(animDict)
                    TaskPlayAnim(ped, animDict, animName, 3.0, 3.0, -1, 2, 0, 0, 0, 0 )
                    Wait(500)
                    TriggerServerEvent("InteractSound_SV:PlayOnSource", "breaking_vitrine_glass", 0.25)
                    loadParticle()
                    StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", plyCoords.x, plyCoords.y, plyCoords.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
                    Wait(2500)
                end
            end)
        else
            if Config.Locales == true then
                QBCore.Functions.Notify(Lang:t("error.weak_weapon"), "error", 3500)
            else
                QBCore.Functions.Notify("This Weapon Isn't Strong Enough!", "error", 3500)
            end
        end
    else
        if Config.Locales == true then
            QBCore.Functions.Notify(Lang:t("error.disable_security"), "error", 3500)
        else
            QBCore.Functions.Notify("You Need To Disable The Cameras!", "error", 3500)
        end
    end
end

------ / Event for police to reboot alarm system! This will lock the doors after 30 seconds

RegisterNetEvent('nc-vangelico:client:rebootsystem')
AddEventHandler('nc-vangelico:client:rebootsystem', function()
    if Config.Locales == true then
        QBCore.Functions.Notify(Lang:t("error.reboot_timer"), "error", 3500)
    else
        QBCore.Functions.Notify("The System Will Reboot In 30 Seconds!", "error", 3500)
    end

    if Config.DoorLock == "nui" then
        Citizen.Wait(30000)
        TriggerServerEvent('nui_doorlock:server:updateState', "vangelicodoor", true, false, false, true)

        if Config.Locales == true then
            QBCore.Functions.Notify(Lang:t("success.door_locked"), "success", 3500)
        else
            QBCore.Functions.Notify("The System Has Rebooted, And The Door Has Been Locked!", "success", 3500)
        end

    else if Config.DoorLock == "qb" then
        Citizen.Wait(30000)
        TriggerServerEvent('qb-doorlock:server:updateState', Config.QBDoorID, true)

        if Config.Locales == true then
            QBCore.Functions.Notify(Lang:t("success.door_locked"), "success", 3500)
        else
            QBCore.Functions.Notify("The System Has Rebooted, And The Door Has Been Locked!", "success", 3500)
        end
    else
        if Config.Locales == true then
            QBCore.Functions.Notify(Lang:t("error.door_system"), "error", 3500)
        else
            QBCore.Functions.Notify("This Door System Is Not Added!", "error", 3500)
        end
    end
end

end)

------ / Events / Done & Finished

RegisterNetEvent('qb-jewellery:client:setVitrineState', function(stateType, state, k)
    Config.Locations[k][stateType] = state
end)

------ / Export Target / Done & Finished

CreateThread(function()

    -- Start The Heist and open the doors

    exports['qb-target']:AddBoxZone("HackSecurity", vector3(-595.8919, -283.6523, 50.3237), 0.40, 0.90, {
        name = "StartJewel",
        heading = 302.7994,
        debugPoly = Config.PolyZone,
        minZ = 50.3 - 0.2,
        maxZ = 50.3 + 1.0,
    }, {
        options = {
            {
                type = "client",
                event = "thermite:UseThermite",
                icon = 'fas fa-bomb',
                label = 'Place Thermite',
            }
        },
        distance = 2.5,
    })

    -- Turns Cameras Off, start grabbing the loot

    exports['qb-target']:AddBoxZone("DisableSecurity", vector3(-629.38, -230.46, 38.06), 0.2, 0.3, {
        name = "DisableCamera",
        heading = 36.6,
        debugPoly = Config.PolyZone,
        minZ = 38.3 + 0.15,
        maxZ = 38.3 + 0.4,
    }, {
        options = {
            {
                type = "client",
                event = "hackinglaptop:UseHackinglaptop",
                icon = 'fab fa-usb',
                label = 'Connect Laptop',
            },
            {
                type = "client",
                event = "nc-vangelico:client:rebootsystem",
                icon = 'fas fa-power-off',
                label = 'Reboot Security System',
                job = { ["police"] = 0 }
            }
        },
        distance = 3.0,
    })

    -- Break in Jewellery Cases

    for k, v in pairs(Config.Locations) do
        exports['qb-target']:AddBoxZone("JewelleryCase"..k, vector3(v.coords.x, v.coords.y, v.coords.z-1), 0.6, 1.2, {
            name = "JewelleryCase"..k,
            heading = v.coords.w,
            debugPoly = Config.PolyZone,
            minZ = 37.65,
            maxZ = 38.35,
            }, {
                options = { 
                {
                    action = function()
                        smashVitrine(k)
                    end,
                    icon = 'fas fa-gem',
                    label = 'Smash Case!',
                    canInteract = function()
                        if v["isOpened"] or v["isBusy"] then 
                            return false
                        end
                        return true
                    end,
                }
            },
            distance = 1.5,
        })
    end
end)

------ / Blip Location / Done & Finished

Citizen.CreateThread(function()
    Dealer = AddBlipForCoord(Config.JewelleryLocation["coords"]["x"], Config.JewelleryLocation["coords"]["y"], Config.JewelleryLocation["coords"]["z"])

    SetBlipSprite (Dealer, 617)
    SetBlipDisplay(Dealer, 4)
    SetBlipScale  (Dealer, 0.6)
    SetBlipAsShortRange(Dealer, true)
    SetBlipColour(Dealer, 3)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Vangelico Jewellery")
    EndTextCommandSetBlipName(Dealer)
end)