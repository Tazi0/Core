_Zone = {
    Teams = {
        red = 0,
        blue = 0,
        green = 0
    },
    add = function(self, playerID)
        if type(self) ~= "table" then return false end

        local player = KOTH.Cache.Players[tostring(playerID)]

        if player.Team == nil then return end

        self.Teams[player.Team] = self.Teams[player.Team] + 1
    end,
    remove = function(self, playerID)
        if type(self) ~= "table" then return false end

        local player = KOTH.Cache.Players[tostring(playerID)]

        if player.Team == nil then return end

        self.Teams[player.Team] = self.Teams[player.Team] - 1
    end,
    Points = 0,
    loop = function(self)
        Citizen.CreateThread(function()
            Wait(60000*Config.Zones.TimeLoop)

            for k,v in pairs(Zones) do
                local highest = 0
                local team = nil
                local teams = v.Teams

                for j, l in pairs(teams) do
                    if highest < l then
                        team = j
                        highest = l
                    end
                end

                if highest ~= 0 or team ~= nil then
                    -- print("Team: " .. team)
                    Config.Teams[team].Points = Config.Teams[team].Points + 1
                    -- Todo: trigger UI to update the points
                    -- TriggerEvent("koth:teamPoint", -1, team, Teams[team].Points)
                else
                    -- print("no winner found")
                end
            end

            self:loop()
        end)
    end
}

Zones = {}

for k,v in pairs(Config.Zones.Blips) do
    Zones[v[1]] = _Zone
    Zones[v[1]]:loop()
end

RegisterNetEvent("koth:addPlayerToZone")
AddEventHandler("koth:addPlayerToZone", function(zone)
    local player = KOTH.Cache.Players[tostring(source)]

    if player == nil or player.Team == nil then return false end
    if zone == nil then return false end

    
    Zones[zone]:add(source)
    TriggerClientEvent("koth:dangerzone", source, true, zone)

    local team = nil
    local highest = 0

    for k, v in pairs(Zones[zone].Teams) do
        if v ~= nil and highest < v then
            team = k
            highest = v
        end
    end

    if highest ~= 0 then
        TriggerClientEvent("koth:changeBlip", -1, _R(Config.Lang.zones.blips.zone, zone), {color = Config.Teams[team].Color})
    end
end)

RegisterNetEvent("koth:removePlayerFromZone")
AddEventHandler("koth:removePlayerFromZone", function(zone)
    local player = KOTH.Cache.Players[tostring(source)]

    if player == nil or player.Team == nil then return false end
    if zone == nil then return false end

    Zones[zone]:remove(source)
    TriggerClientEvent("koth:dangerzone", source, false)

    local team = nil
    local highest = 0

    for k, v in pairs(Zones[zone].Teams) do
        if v ~= nil and highest < v then
            team = k
            highest = lv
        end
    end

    if highest ~= 0 then
        TriggerClientEvent("koth:changeBlip", -1, _R(Config.Lang.zones.blips.zone, zone), {color = Config.Teams[team].Color})
    else
        TriggerClientEvent("koth:changeBlip", -1, _R(Config.Lang.zones.blips.zone, zone), {color = 39})
    end
end)

RegisterNetEvent("koth:safezone")
AddEventHandler("koth:safezone", function(distance, zone)
    if KOTH == nil then return false end
    local player = KOTH.Cache.Players[tostring(source)]

    if player == nil or player.Team == nil then return false end

    if distance <= 150 and player.Team == zone and player.Invincible == false then
        TriggerClientEvent("koth:invincible", source, zone, true)
        KOTH.Cache.Players[tostring(source)].Invincible = true
    elseif distance >= 150 and player.Team == zone and player.Invincible == true then
        TriggerClientEvent("koth:invincible", source, zone, false)
        KOTH.Cache.Players[tostring(source)].Invincible = false
    elseif distance <= 150 and player.Team ~= zone then
        TriggerClientEvent("koth:notification", source, _R(Config.Lang.zones.wrongZone, player.team));
    else
        TriggerClientEvent("koth:notification", source, _R(Config.Lang.zones.noTeam))
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then return end

    for k, v in pairs(KOTH.Cache.Players) do
        if v.Invincible then
            TriggerClientEvent("koth:invincible", v.Identifiers.id, nil, false)
        end
    end
end)