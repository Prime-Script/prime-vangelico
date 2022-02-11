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
    TriggerClientEvent('hackinglaptop:UseHackinglaptop', source)
 end)

RegisterServerEvent("Peely-particleserver")
AddEventHandler("Peely-particleserver", function(method)
    TriggerClientEvent("Peely-ptfxparticle", -1, method)
end)

RegisterServerEvent("Peely-particleserversec")
AddEventHandler("Peely-particleserversec", function(method)
    TriggerClientEvent("Peely-ptfxparticlesec", -1, method)
end)

RegisterServerEvent('prime-vangelico:SetJewelLocations')
AddEventHandler('prime-vangelico:SetJewelLocations', function()
    local src = source 
    TriggerClientEvent("prime-vangelico:SetJewelLocations", src, Config.JewelLocation)
end)

-- Register Cool Down Events For Locations
RegisterServerEvent('prime-vangelico:BeginCooldown')
AddEventHandler('prime-vangelico:BeginCooldown', function()
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
QBCore.Functions.CreateCallback("prime-vangelico:Callback:Cooldown",function(source, cb)
    if Cooldown then
        cb(true)
    else
        cb(false)
        
    end
end)

-- Callback For Cops
QBCore.Functions.CreateCallback('prime-vangelico:getCops', function(source, cb)
	local amount = 0
    for k, v in pairs(QBCore.Functions.GetQBPlayers()) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
            amount = amount + 1
        end
    end
    cb(amount)
end)

-- Hack On Roof Of Vangelico
RegisterServerEvent('prime-vangelico:SetThermiteSecurityStatus')
AddEventHandler('prime-vangelico:SetThermiteSecurityStatus', function(stateType, state)
    if stateType == "isBusy" then
        Config.JewelLocation["ThermiteSecurity"].isBusy = state
    elseif stateType == "isDone" then
        Config.JewelLocation["ThermiteSecurity"].isDone = state
    end
    TriggerClientEvent('prime-vangelico:client:SetThermiteSecurityStatus', -1, stateType, state)
    TriggerEvent('qb-scoreboard:server:SetActivityBusy', "jewellery", true)
end)

-- Disbaled Cameras In Vangelico
RegisterServerEvent('prime-vangelico:SetCameraStatus')
AddEventHandler('prime-vangelico:SetCameraStatus', function(stateType, state)
    if stateType == "isBusy" then
        Config.JewelLocation["DisableCameras"].isBusy = state
    elseif stateType == "isDone" then
        Config.JewelLocation["DisableCameras"].isDone = state
    end
    TriggerClientEvent('prime-vangelico:client:SetCameraStatus', -1, stateType, state)
end)

RegisterServerEvent('prime-vangelico:policeAlert')
AddEventHandler('prime-vangelico:policeAlert', function()
    local src = source
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            if (Player.PlayerData.job.name == "police") then
                if Config.Dispatch == "linden" then
                    local data = {displayCode = '10-11B', description = 'System Failure', isImportant = 0, recipientList = {'police'}, length = '5000', infoM = 'fas fa-bolt', info = 'Suspicious Activity At Vangelico', 
                    blipSprite = 487, blipColour = 3, blipScale = 1.2}
                    local dispatchData = {dispatchData = data, caller = 'Local', coords = vector3(-596.6, -283.97, 50.34)}
                    TriggerEvent('wf-alerts:svNotify', dispatchData)
                else
                    TriggerClientEvent('QBCore:Notify', src, Lang:t("error.dispatch_system"), "error")
                end
            end
        end
    end
end)


-- Callback

QBCore.Functions.CreateCallback('prime-vangelico:getCops', function(source, cb)
	local amount = 0
    for k, v in pairs(QBCore.Functions.GetQBPlayers()) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
            amount = amount + 1
        end
    end
    cb(amount)
end)

-- Events

RegisterNetEvent('prime-vangelico:setVitrineState', function(stateType, state, k)
    Config.Locations[k][stateType] = state
    TriggerClientEvent('prime-vangelico:client:setVitrineState', -1, stateType, state, k)
end)

RegisterNetEvent('prime-vangelico:vitrineReward', function()
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

QBCore.Functions.CreateCallback('prime-vangelico:setTimeout', function(source, cb)
	if not timeOut then
        timeOut = true
        Citizen.CreateThread(function()
            Citizen.Wait(Config.Timeout)

            for k, v in pairs(Config.Locations) do
                Config.Locations[k]["isOpened"] = false
                TriggerClientEvent('prime-vangelico:client:setVitrineState', -1, 'isOpened', false, k)
                TriggerClientEvent('prime-vangelico:client:setAlertState', -1, false)
            end
            timeOut = false
            alarmTriggered = false
        end)
    end
end)