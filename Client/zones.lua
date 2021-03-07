Zones = {
    Entered = {false, nil},
    SafeZone = false
}

Citizen.CreateThread(function()
    TriggerServerEvent("koth:createPlayer") -- Creates the player
    TriggerServerEvent("koth:blipRender") -- Renders the blips

    Citizen.CreateThread(function()
        while true do
            Wait(100)
            local playerPed = GetPlayerPed(-1)
            if IsEntityDead(playerPed) then
                TriggerServerEvent("koth:respawn")
            end
        end
    end)
end)

AddEventHandler("koth:checkZone", function(zone)
    Citizen.CreateThread(function()
        while true do
            Wait(1)
            local player = GetPlayerPed(-1)
            local playerloc = GetEntityCoords(player, 0)

            local distance = GetDistanceBetweenCoords(zone[1], zone[2], 0, playerloc['x'], playerloc['y'], 0, true)

            if distance <= zone[3] and Zones.Entered[1] == false then
                TriggerServerEvent("koth:addPlayerToZone", zone[1])
                Zones.Entered[1] = true
            elseif distance >= zone[3] and Zones.Entered[1] == true then
                TriggerServerEvent("koth:removePlayerFromZone", zone[1])
                Zones.Entered[1] = false
            end
        end
    end)
end)

AddEventHandler("koth:checkSafeZone", function(zone)
    Citizen.CreateThread(function()
        while true do
            Wait(1)

            local player = GetPlayerPed(-1)
            local playerloc = GetEntityCoords(player, 0)
            local distance = GetDistanceBetweenCoords(zone.x, zone.y, 0, playerloc['x'], playerloc['y'], 0, true)

            if distance <= 150 and Zones.SafeZone == false then
                TriggerServerEvent("koth:safezone", distance, zone.team)
                DisablePlayerFiring(player, true)
            elseif distance >= 150 and Zones.SafeZone == true and Zones.Entered[2] == zone.team then
                TriggerServerEvent("koth:safezone", distance, zone.team)
                SetEntityInvincible(player, false)
                DisablePlayerFiring(player, false)
            end
        end
    end)
end)

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

AddEventHandler("koth:dangerzone", function(on, zone)
    if on then
        Zones.Entered[2] = zone
        TriggerEvent("koth:notification", Config.Lang.zones.inDangerZone)
    else
        Zones.Entered[2] = nil
        TriggerEvent("koth:notification", Config.Lang.zones.noDangerZone)
    end

end)

-- https://github.com/danini1705/No-NPC/blob/master/main.lua / Disable NPC
if not Config.Player.NPC then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            SetVehicleDensityMultiplierThisFrame(0.0) 
            SetPedDensityMultiplierThisFrame(0.0)
            SetRandomVehicleDensityMultiplierThisFrame(0.0)
            SetParkedVehicleDensityMultiplierThisFrame(0.0)
            SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
            SetGarbageTrucks(false)
            SetRandomBoats(false)
            SetCreateRandomCops(false)
            SetCreateRandomCopsNotOnScenarios(false)
            SetCreateRandomCopsOnScenarios(false)
            StartAudioScene('CHARACTER_CHANGE_IN_SKY_SCENE')
            
            local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
            ClearAreaOfVehicles(x, y, z, 1000, false, false, false, false, false)
            RemoveVehiclesFromGeneratorsInArea(x - 500.0, y - 500.0, z - 500.0, x + 500.0, y + 500.0, z + 500.0);
        end
    end)
end