Zones = {
    Entered = {false, nil},
    SafeZone = false
}

Citizen.CreateThread(function()
    TriggerServerEvent("koth:createPlayer") -- Creates the player

    for k,v in pairs(Config.Teams) do
        TriggerEvent("koth:setBlip", _R(Config.Lang.zones.blips.safezone, v.Title), v.Safezone[1], v.Safezone[2], v.Color, 150, 304)
    end

    while true do
        Wait(1)
        local player = GetPlayerPed(-1)
        local playerloc = GetEntityCoords(player, 0)

        -- Safezone for each team
        for _, search in pairs(Config.Teams) do
            local distance = GetDistanceBetweenCoords(search.Safezone[1], search.Safezone[2], 0, playerloc['x'], playerloc['y'], 0, true)

            if distance <= 150 and Zones.SafeZone == false then
                TriggerServerEvent("koth:safezone", distance, _)
                DisablePlayerFiring(player, true)
            elseif distance >= 150 and Zones.SafeZone == true and Zones.Entered[2] == _ then
                TriggerServerEvent("koth:safezone", distance, _)
                SetEntityInvincible(player, false)

                if search.SafezoneShooting then
                    DisablePlayerFiring(player, false)
                end
            end
        end
    end
end)

RegisterNetEvent("koth:checkZone")
AddEventHandler("koth:checkZone", function(zone)
    Citizen.CreateThread(function()
        while true do
            Wait(1)
            local player = GetPlayerPed(-1)
            local playerloc = GetEntityCoords(player, 0)

            local distance = GetDistanceBetweenCoords(zone[1], zone[2], 0, playerloc['x'], playerloc['y'], 0, true)

            if distance <= zone[3] and Zones.Entered[1] == false then
                TriggerServerEvent("koth:addPlayerToZone", zone[1])
            elseif distance >= zone[3] and Zones.Entered[1] == true then
                TriggerServerEvent("koth:removePlayerFromZone", zone[1])
            end
        end
    end)
end)

RegisterNetEvent("koth:invincible")
AddEventHandler("koth:invincible", function(zone, on)
    if(on) then
        Zones.SafeZone = true
        Zones.Entered[2] = zone
        TriggerEvent("koth:notification", Config.Lang.zones.invincible)
    else
        Zones.SafeZone = false
        Zones.Entered[2] = nil
        TriggerEvent("koth:notification", Config.Lang.zones.notInvincible)
    end
    local player = GetPlayerPed(-1)

    SetEntityInvincible(player, on)
    SetPlayerInvincible(PlayerId(), on)
    -- SetPedCanRagdoll(player, not on)
    ClearPedBloodDamage(player)
    ResetPedVisibleDamage(player)
    ClearPedLastWeaponDamage(player)
    SetEntityProofs(player, on, on, on, on, on, on, on, on)
    SetEntityOnlyDamagedByPlayer(player, not on)
    SetEntityCanBeDamaged(player, not on)
end)

RegisterNetEvent("koth:dangerzone", function(on, zone)
    if on then
        Zones.Entered[1] = true
        Zones.Entered[2] = zone
        TriggerEvent("koth:notification", Config.Lang.zones.inDangerZone)
    else
        Zones.Entered[1] = false
        Zones.Entered[2] = nil
        TriggerEvent("koth:notification", Config.Lang.zones.noDangerZone)
    end

end)