local QBCore = exports['qb-core']:GetCoreObject()
local timeOut = false
local alarmTriggered = false
local Cooldown = false

-- First Item Needed
QBCore.Functions.CreateUseableItem("thermite", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("thermite:UseThermite", source)
 end)

-- Second Item Needed
QBCore.Functions.CreateUseableItem("usb_green", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('hackinglaptop:UseHackinglaptop',source)
 end)

RegisterServerEvent("Peely-particleserver")
AddEventHandler("Peely-particleserver", function(method)
    TriggerClientEvent("Peely-ptfxparticle", -1, method)
end)

RegisterServerEvent("Peely-particleserversec")
AddEventHandler("Peely-particleserversec", function(method)
    TriggerClientEvent("Peely-ptfxparticlesec", -1, method)
end)

RegisterServerEvent('qb-jewellery:server:SetJewelLocations')
AddEventHandler('qb-jewellery:server:SetJewelLocations', function()
    local src = source 
    TriggerClientEvent("qb-jewellery:server:SetJewelLocations", src, Config.JewelLocation)
end)

-- Register Cool Down Events For Locations
RegisterServerEvent('qb-jewellery:Server:BeginCooldown')
AddEventHandler('qb-jewellery:Server:BeginCooldown', function()
    Cooldown = true
    local timer = Config.Cooldown * 60000
    while timer > 0 do
        Wait(1000)
        timer = timer - 1000
        if timer == 0 then
            Cooldown = false
        end
    end
end)

-- CallBack For CoolDown
QBCore.Functions.CreateCallback("qb-jewellery:Callback:Cooldown",function(source, cb)
    if Cooldown then
        cb(true)
    else
        cb(false)
        
    end
end)

-- Callback For Cops
QBCore.Functions.CreateCallback('qb-jewellery:server:getCops', function(source, cb)
	local amount = 0
    for k, v in pairs(QBCore.Functions.GetQBPlayers()) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
            amount = amount + 1
        end
    end
    cb(amount)
end)

-- Hack On Roof Of Vangelico
RegisterServerEvent('qb-jewellery:server:SetThermiteSecurityStatus')
AddEventHandler('qb-jewellery:server:SetThermiteSecurityStatus', function(stateType, state)
    if stateType == "isBusy" then
        Config.JewelLocation["ThermiteSecurity"].isBusy = state
    elseif stateType == "isDone" then
        Config.JewelLocation["ThermiteSecurity"].isDone = state
    end
    TriggerClientEvent('qb-jewellery:client:SetThermiteSecurityStatus', -1, stateType, state)
    TriggerEvent('qb-scoreboard:server:SetActivityBusy', "jewellery", false)
end)

-- Disbaled Cameras In Vangelico
RegisterServerEvent('qb-jewellery:server:SetCameraStatus')
AddEventHandler('qb-jewellery:server:SetCameraStatus', function(stateType, state)
    if stateType == "isBusy" then
        Config.JewelLocation["DisableCameras"].isBusy = state
    elseif stateType == "isDone" then
        Config.JewelLocation["DisableCameras"].isDone = state
    end
    TriggerClientEvent('qb-jewellery:client:SetCameraStatus', -1, stateType, state)
end)

-- Callback

QBCore.Functions.CreateCallback('qb-jewellery:server:getCops', function(source, cb)
	local amount = 0
    for k, v in pairs(QBCore.Functions.GetQBPlayers()) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
            amount = amount + 1
        end
    end
    cb(amount)
end)

-- Events

RegisterNetEvent('qb-jewellery:server:setVitrineState', function(stateType, state, k)
    Config.Locations[k][stateType] = state
    TriggerClientEvent('qb-jewellery:client:setVitrineState', -1, stateType, state, k)
end)

RegisterNetEvent('qb-jewellery:server:vitrineReward', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local otherchance = math.random(1, 4)
    local odd = math.random(1, 4)

    if otherchance == odd then
        local item = math.random(1, #Config.VitrineRewards)
        local amount = math.random(Config.VitrineRewards[item]["amount"]["min"], Config.VitrineRewards[item]["amount"]["max"])
        if Player.Functions.AddItem(Config.VitrineRewards[item]["item"], amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.VitrineRewards[item]["item"]], 'add')
        else
            TriggerClientEvent('QBCore:Notify', src, Lang:t("error.pockets_full"), "error")
            --TriggerClientEvent('QBCore:Notify', src, 'You Can\'t Carry Anymore!', 'error')
        end
    end
end)

QBCore.Functions.CreateCallback('qb-jewellery:server:setTimeout', function(source, cb)
	if not timeOut then
        timeOut = true
        Citizen.CreateThread(function()
            Citizen.Wait(Config.Timeout)

            for k, v in pairs(Config.Locations) do
                Config.Locations[k]["isOpened"] = false
                TriggerClientEvent('qb-jewellery:client:setVitrineState', -1, 'isOpened', false, k)
                TriggerClientEvent('qb-jewellery:client:setAlertState', -1, false)
            end
            timeOut = false
            alarmTriggered = false
        end)
    end
end)