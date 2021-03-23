KOTH = {}


KOTH = {
    Players = {}
}

-- Blips
RegisterServerEvent("koth:newZone")
RegisterServerEvent("koth:blipRender")

-- Classes
RegisterServerEvent("koth:renderClass")
RegisterServerEvent("koth:selectClass")

RegisterServerEvent("koth:buyWeapon")
RegisterServerEvent("koth:buyAmmo")
RegisterServerEvent("koth:amountAmmo")
RegisterServerEvent("koth:equipWeapon")
RegisterServerEvent("koth:_activeWeapons")

-- Players
RegisterServerEvent("koth:createPlayer")
RegisterServerEvent("koth:getPlayer")
RegisterServerEvent("koth:respawn")

-- Teams
RegisterServerEvent("koth:playerTeam")


-- Vehicles
RegisterServerEvent("koth:renderVehicles")
RegisterServerEvent("koth:spawnVehicle")
RegisterServerEvent("koth:_activeVehicleTab")

-- Zones
RegisterServerEvent("koth:addPlayerToZone")
RegisterServerEvent("koth:removePlayerFromZone")
RegisterServerEvent("koth:safezone")

-- Other
RegisterServerEvent("koth:Preference", function(cb) cb(Preference) end)