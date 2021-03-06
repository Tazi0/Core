KOTH = {}


KOTH = {
    Players = {}
}

-- Blips
RegisterNetEvent("koth:newZone")

-- Classes
RegisterNetEvent("koth:renderClass")
RegisterNetEvent("koth:selectClass")
RegisterNetEvent("koth:selectedWeapon")
RegisterNetEvent("koth:_activeWeapons")

-- Players
RegisterNetEvent("koth:createPlayer")
RegisterNetEvent("koth:getPlayer")

-- Zones
RegisterNetEvent("koth:addPlayerToZone")
RegisterNetEvent("koth:removePlayerFromZone")
RegisterNetEvent("koth:safezone")