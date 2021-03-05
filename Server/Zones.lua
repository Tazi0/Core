_Zone = {
    Teams = {
        red = 0,
        blue = 0,
        green = 0
    },
    Players = {},
    add = function(self, playerID)
        if type(self) ~= "table" then return false end

        local player = KOTH.Cache.Players[tostring(playerID)]

        if player.Team == nil or self.Players[playerID] ~= nil then return false end

        self.Teams[player.Team] = self.Teams[player.Team] + 1
        table.insert(self.Players, playerID)
    end,
    remove = function(self, playerID)
        if type(self) ~= "table" then return false end

        local player = KOTH.Cache.Players[tostring(playerID)]

        if player.Team == nil then return false end

        self.Teams[player.Team] = self.Teams[player.Team] - 1
        table.remove(self.Players, playerID)
    end,
    Points = 0,
    loop = function(self)
        Citizen.CreateThread(function()
            Wait(60000*Config.Zone.TimeLoop)

            local highest = 0
            local team = nil
            local teams = self.Teams

            for j, l in pairs(teams) do
                if highest < l then
                    team = j
                    highest = l
                end
            end

            if highest ~= 0 or team ~= nil then
                Config.Teams[team].Points = Config.Teams[team].Points + 1
                -- Todo: trigger UI to update the points
                -- TriggerEvent("koth:teamPoint", -1, team, Teams[team].Points)
            else
                -- print("no winner found")
            end

            self:loop()
        end)
    end
}

-- Make an new kill zone
Active = _Zone
Config.Zone.Active = Config.Zone.Available[math.random( #Config.Zone.Available )]

Citizen.CreateThread(function()
    Citizen.Wait(200)
    TriggerClientEvent("koth:setBlip", -1, Config.Lang.zones.blips.kill, Config.Zone.Active[1], Config.Zone.Active[2], 39, Config.Zone.Active[3], Config.Zone.Sprite)
    TriggerClientEvent("koth:checkZone", -1, Config.Zone.Active)
end)

RegisterNetEvent("koth:newZone")
AddEventHandler("koth:newZone", function()
    Active = _Zone

    Config.Zone.Active = Config.Zone.Available[math.random( #Config.Zone.Available )]

    Citizen.CreateThread(function()
        Citizen.Wait(200)
        TriggerClientEvent("koth:setBlip", -1, Config.Lang.zones.blips.kill, Config.Zone.Active[1], Config.Zone.Active[2], 39, Config.Zone.Active[3], Config.Zone.Sprite)
        TriggerClientEvent("koth:checkZone", -1, Config.Zone.Active)
    end)
end)

RegisterNetEvent("koth:addPlayerToZone")
AddEventHandler("koth:addPlayerToZone", function(zone)
    local player = KOTH.Cache.Players[tostring(source)]

    if player == nil or player.Team == nil then 
        if player ~= nil and player.Team == nil then
            TriggerClientEvent("koth:notification", source, _R(Config.Lang.zones.noTeam))
        end
        return false
    end
    
    if zone == nil then return false end

    
    local result = Active:add(source)
    
    if result == false then return false end
    TriggerClientEvent("koth:dangerzone", source, true, zone)

    local team = nil
    local highest = 0

    for k, v in pairs(Active.Teams) do
        if v ~= nil and highest < v then
            team = k
            highest = v
        end
    end

    if highest ~= 0 then
        TriggerClientEvent("koth:changeBlip", -1, Config.Lang.zones.blips.kill, {color = Config.Teams[team].Color})
    end
end)

RegisterNetEvent("koth:removePlayerFromZone")
AddEventHandler("koth:removePlayerFromZone", function(zone)
    local player = KOTH.Cache.Players[tostring(source)]

    if player == nil or player.Team == nil then return false end
    if zone == nil then return false end

    Active:remove(source)
    TriggerClientEvent("koth:dangerzone", source, false)

    local team = nil
    local highest = 0

    for k, v in pairs(Active.Teams) do
        if v ~= nil and highest < v then
            team = k
            highest = lv
        end
    end

    if highest ~= 0 then
        TriggerClientEvent("koth:changeBlip", -1, Config.Lang.zones.blips.kill, {color = Config.Teams[team].Color})
    else
        TriggerClientEvent("koth:changeBlip", -1, Config.Lang.zones.blips.kill, {color = 39})
    end
end)

RegisterNetEvent("koth:safezone")
AddEventHandler("koth:safezone", function(distance, zone)
    if KOTH == nil then return false end
    local player = KOTH.Cache.Players[tostring(source)]

    if player == nil or player.Team == nil then 
        if player.Team == nil then
            TriggerClientEvent("koth:notification", source, _R(Config.Lang.zones.noTeam))
        end
        return false
    end

    if distance <= 150 and player.Team == zone and player.Invincible == false then
        TriggerClientEvent("koth:invincible", source, zone, true)
        KOTH.Cache.Players[tostring(source)].Invincible = true
    elseif distance >= 150 and player.Team == zone and player.Invincible == true then
        TriggerClientEvent("koth:invincible", source, zone, false)
        KOTH.Cache.Players[tostring(source)].Invincible = false
    elseif distance <= 150 and player.Team ~= zone then
        TriggerClientEvent("koth:notification", source, _R(Config.Lang.zones.wrongZone, player.Team));
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