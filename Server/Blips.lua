AddEventHandler("koth:newZone", function()
    local i = math.random(#Config.Zone.Available)

    Config.Zone.Active = Config.Zone.Available[i]

    Citizen.CreateThread(function()
        Citizen.Wait(200)
        Active:reset()
        
        while Config.Zone.Active == nil do
            Wait(1)
        end

        local ped = Config.Classes.model

        -- Team -> Blips | Class ped | Invincibility
        for k, team in pairs(Config.Zone.Active.Teams) do
            TriggerClientEvent("koth:spawnPed", -1, ped, {menu = k, x = team.class[1], y = team.class[2], z = team.class[3], rotation = team.class[4]})
            TriggerClientEvent("koth:setBlip", -1, _R(Config.Lang.zones.blips.safezone, firstUpper(k)), team.safe[1], team.safe[2], Config.Teams[k].Color, 150, 304)
            TriggerClientEvent("koth:checkSafeZone", -1, {x = team.safe[1], y = team.safe[2], team = k})
        end

        -- Kill zone -> Blip | Color change
        TriggerClientEvent("koth:setBlip", -1, Config.Lang.zones.blips.kill, Config.Zone.Active.Zone[1], Config.Zone.Active.Zone[2], 39, Config.Zone.Active.Zone[3], Config.Zone.Sprite)
        TriggerClientEvent("koth:checkZone", -1, Config.Zone.Active.Zone)
    end)
end)

TriggerEvent("koth:newZone")