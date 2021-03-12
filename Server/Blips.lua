AddEventHandler("koth:newZone", function(render)
    local i = math.random(#Config.Zone.Available)

    Config.Zone.Active = Config.Zone.Available[i]

    Citizen.CreateThread(function()
        Citizen.Wait(200)
        Active:reset()
        
        if render then 
            TriggerClientEvent("koth:deleteBlips", -1) 
            TriggerEvent("koth:blipRender") end
    end)
end)

TriggerEvent("koth:newZone", false)

AddEventHandler("koth:blipRender", function()
    if source ~= "" then src = source else src = -1 end
    local ped = Config.Classes.model

    while Config.Zone.Active == nil do
        Wait(1)
    end

    -- Team -> Blips | Class ped | Vehicle ped | Invincibility
    for k, team in pairs(Config.Zone.Active.Teams) do
        TriggerClientEvent("koth:setBlip", src, _R(Config.Lang.zones.blips.safezone, firstUpper(k)), team.safeZone[1], team.safeZone[2], Config.Teams[k].Color, 150, 304)
        TriggerClientEvent("koth:spawnPed", src, ped, {
            open = {
                serverTrigger = "koth:renderClass",
                helpMessage = Config.Lang.classes.helpMessage,
                clientTrigger = "koth:_getWeapons",
                team = k,
                teamLimit = true,
                keys = {
                    open = Config.Menu.openKey or "E",
                    close = Config.Menu.closeKey or "BACKSPACE",
                },
                freezePlayer = true
            },
            x = team.classModel[1], 
            y = team.classModel[2], 
            z = team.classModel[3], 
            rotation = team.classModel[4]
        })
        TriggerClientEvent("koth:spawnPed", src, ped, {
            open = {
                serverTrigger = "koth:renderVehicles",
                helpMessage = Config.Lang.vehicles.helpMessage,
                team = k,
                teamLimit = true,
                keys = {
                    open = Config.Menu.openKey or "E",
                    close = Config.Menu.closeKey or "BACKSPACE",
                },
                freezePlayer = true
            },
            x = team.vehicleModel[1], 
            y = team.vehicleModel[2], 
            z = team.vehicleModel[3], 
            rotation = team.vehicleModel[4]
        })
        TriggerClientEvent("koth:checkSafeZone", src, {x = team.safeZone[1], y = team.safeZone[2], team = k})
    end

    -- Kill zone -> Blip | Color change
    TriggerClientEvent("koth:setBlip", src, Config.Lang.zones.blips.kill, Config.Zone.Active.Zone[1], Config.Zone.Active.Zone[2], 39, Config.Zone.Active.Zone[3], Config.Zone.Sprite)
    TriggerClientEvent("koth:checkZone", src, Config.Zone.Active.Zone)
end)

RegisterCommand("reset", function(source, args, raw)
    TriggerEvent("koth:newZone", true)

    for _, src in ipairs(GetPlayers()) do
        local player = KOTH.Players[src]

        if player ~= nil then
            TriggerEvent("koth:respawn", src)
        end
    end
end, false)