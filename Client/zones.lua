Zones = {
    Entered = {false, nil},
    SafeZone = false,
}

Citizen.CreateThread(function()
    for k,v in pairs(Config.Zones.Blips) do
        TriggerEvent("koth:setBlip", v[1] .. " zone", v[2], v[3], 39, v[4], Config.Zones.Sprite)
    end

    for k,v in pairs(Config.Teams) do
        TriggerEvent("koth:setBlip", v.Title .. " safezone", v.Safezone[1], v.Safezone[2], v.Color, 150, 304)
    end

    while true do
        Wait(1)
        local player = GetPlayerPed(-1)
        local playerloc = GetEntityCoords(player, 0)

        for _, search in pairs(Config.Zones.Blips) do
            local distance = GetDistanceBetweenCoords(search[2], search[3], 0, playerloc['x'], playerloc['y'], 0, true)

            if distance <= search[4] and Zones.Entered[1] == false then
                TriggerServerEvent("koth:addPlayerToZone", search[1])
            elseif distance >= search[4] and Zones.Entered[1] == true then
                TriggerServerEvent("koth:removePlayerFromZone", search[1])
            end
        end

        for _, search in pairs(Config.Teams) do
            local distance = GetDistanceBetweenCoords(search.Safezone[1], search.Safezone[2], 0, playerloc['x'], playerloc['y'], 0, true)

            if distance <= 150 and Zones.SafeZone == false then
                TriggerServerEvent("koth:safezone", distance, _)
            elseif distance >= 150 and Zones.SafeZone == true and Zones.Entered[2] == _ then
                TriggerServerEvent("koth:safezone", distance, _)
                SetEntityInvincible(player, false)
            end
        end
    end
end)

RegisterNetEvent("koth:invincible")
AddEventHandler("koth:invincible", function(zone, on)
    if(on) then
        Zones.SafeZone = true
        Zones.Entered[2] = zone
        TriggerEvent("koth:notification", "You are now ~g~invincible")
    else
        Zones.SafeZone = false
        Zones.Entered[2] = nil
        TriggerEvent("koth:notification", "You are no longer ~r~invincible")
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
        TriggerEvent("koth:notification", "You are in the ~r~danger zone")
    else
        Zones.Entered[1] = false
        Zones.Entered[2] = nil
        TriggerEvent("koth:notification", "You have left the ~g~danger zone")
    end

end)