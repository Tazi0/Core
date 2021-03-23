function KOTH:Player(playerID)
    local ids = PlayerIdentifiers(playerID)
    if ids[Config.Player.Connection] == "" then return nil end

    local uuid = Config.Player.Connection .. "ID"
    local res = MySQL.Sync.fetchAll('SELECT * FROM users WHERE ' .. uuid ..'=@ID', { ['@ID'] = ids[Config.Player.Connection] })

    if type(res) ~= "table" then 
        res = {
            cash = 0,
            level = 0,
            xp = 0,
            deaths = 0,
            streak = 0
        }

        MySQL.Sync.execute('INSERT INTO users (steamID, discordID) VALUES (@steamID, @discordID)', { ['@discordID'] =  ids.discord, ['@steamID'] = ids.steam })
    else
        if res[1] == nil then return nil end
        res = res[1]
    end

    ids.prefered = Config.Player.Connection

    return {
        __raw = res,
        Money = {
            __ids = ids,
            cash = tonumber(res.cash),
            add = function(self, amount)
                  if type(self) ~= "table" then return false end

                  self.cash = self.cash + amount

                  MySQL.Sync.execute("UPDATE users SET cash = cash + @added WHERE ".. uuid .."=@ID", { ['@ID'] = ids[Config.Player.Connection], ['@added'] = amount})
                  return self.cash
            end,
            remove = function(self, amount)
                  if type(self) ~= "table" then return false end
                  if self.cash < amount then return false end

                  self.cash = self.cash - amount

                  MySQL.Sync.execute("UPDATE users SET cash = cash - @added WHERE ".. uuid .."=@ID", { ['@ID'] = ids[Config.Player.Connection], ['@added'] = amount})
                  return self.cash
            end,
            reset = function(self)
                  if type(self) ~= "table" then return false end

                  self.cash = 0

                  MySQL.Sync.execute("UPDATE users SET cash = 0 WHERE ".. uuid .."=@ID", { ['@ID'] = ids[Config.Player.Connection]})
                  return true
            end
        },
        Level = {
            xp = tonumber(res.xp),
            level = tonumber(res.level),
            addXP = function(self, amount)
                  if type(self) ~= "table" then return false end

                  self.xp = self.xp + amount

                  MySQL.Sync.execute("UPDATE users SET xp = xp + @added WHERE ".. uuid .."=@ID", { ['@ID'] = ids[Config.Player.Connection], ['@added'] = amount})
                  return self.xp
            end,
            removeXP = function(self, amount)
                  if type(self) ~= "table" then return false end
                  if self.xp < amount then return false end

                  self.xp = self.xp - amount

                  MySQL.Sync.execute("UPDATE users SET xp = xp - @added WHERE ".. uuid .."=@ID", { ['@ID'] = ids[Config.Player.Connection], ['@added'] = amount})
                  return self.xp
            end,
            reset = function(self)
                  if type(self) ~= "table" then return false end

                  self.xp = 0

                  MySQL.Sync.execute("UPDATE users SET xp = 0 WHERE ".. uuid .."=@ID", { ['@ID'] = ids[Config.Player.Connection]})
                  return true
            end
        },
        Identifiers = ids,
        Deaths = tonumber(res.deaths),
        Kills = tonumber(res.kills),
        Streak = tonumber(res.streak),
        Weapons = {
            items = table.split(res.weapons, ","),
            add = function(self, weapon)
                if type(self) ~= "table" then return false end
                local hash = GetHashKey(weapon)

                if hash ~= nil then
                    table.insert(self.items, weapon)
                    local str = table.join(self.items, ",")
                    MySQL.Sync.execute("UPDATE users SET weapons = @str WHERE ".. uuid .."=@ID", { ['@str'] = str, ['@ID'] = ids[Config.Player.Connection]})
                    return true
                end

                return false
            end,
            remove = function(self, weapon)
                if type(self) ~= "table" then return false end
                local hash = GetHashKey(weapon)

                if hash ~= nil then
                    table.remove(self.items, weapon)
                    local str = table.join(self.items, ",")
                    MySQL.Sync.execute("UPDATE users SET weapons = @str WHERE ".. uuid .."=@ID", { ['@str'] = str, ['@ID'] = ids[Config.Player.Connection]})
                    return true
                end
            end,
            reset = function(self)
                if type(self) ~= "table" then return false end

                self.items = {}
                MySQL.Sync.execute("UPDATE users SET weapons = '' WHERE ".. uuid .."=@ID", { ['@ID'] = ids[Config.Player.Connection] })

                return true
            end
        },
        Vehicles = {
            items = table.split(res.vehicles, ","),
            add = function(self, vehicle)
                if type(self) ~= "table" then return false end
                local hash = GetHashKey(vehicle)

                if hash ~= nil then
                    table.insert(self.items, vehicle)
                    local str = table.join(self.items, ",")
                    MySQL.Sync.execute("UPDATE users SET vehicles = @str WHERE ".. uuid .."=@ID", { ['@str'] = str, ['@ID'] = ids[Config.Player.Connection]})
                    return true
                end

                return false
            end,
            remove = function(self, vehicle)
                if type(self) ~= "table" then return false end
                local hash = GetHashKey(vehicle)

                if hash ~= nil then
                    table.remove(self.items, vehicle)
                    local str = table.join(self.items, ",")
                    MySQL.Sync.execute("UPDATE users SET vehicles = @str WHERE ".. uuid .."=@ID", { ['@str'] = str, ['@ID'] = ids[Config.Player.Connection]})
                    return true
                end
            end,
            reset = function(self)
                if type(self) ~= "table" then return false end

                self.items = {}
                MySQL.Sync.execute("UPDATE users SET vehicles = '' WHERE ".. uuid .."=@ID", { ['@ID'] = ids[Config.Player.Connection] })

                return true
            end
        },
        LastLoggedIn = res.lastLoggedIn,
        Class = nil,
        Team = nil,
        Invincible = false,
        setPos = function(self, x, y, z, rotation)
            TriggerClientEvent("koth:setPosition", self.Identifiers.id, x, y, z, rotation)
        end
    }
end

AddEventHandler("playerConnecting", function(name, setKickReason, deferrals)
    -- ID hasn't been set yet so can't add to system!
    local src = source
    local player = KOTH:Player(src)

    if(type(player.Identifiers[Config.Player.Connection]) == "nil") then
        deferrals.done(_R(Config.Lang.player.restart, Config.Player.Connection))
    end
end)

AddEventHandler("koth:createPlayer", function()
    local src = source
    if KOTH.Players[tostring(src)] ~= nil then return false end

    KOTH.Players[tostring(src)] = KOTH:Player(src)
end)

AddEventHandler('playerDropped', function (reason)
    local player = KOTH.Players[source]

    if(type(player) ~= "nil") then KOTH.Players[source] = nil end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then return end

    for _, src in ipairs(GetPlayers()) do
        TriggerEvent("koth:createPlayer")
    end
end)

AddEventHandler("koth:getPlayer", function(src, cb)
    if source ~= "" then src = source end

    cb(KOTH.Players[tostring(src)])
end)

AddEventHandler("koth:respawn", function(src)
    if source ~= "" then src = source end

    local player = KOTH.Players[tostring(src)]
    if player == nil or player.Team == nil then return false end

    local spawn = Config.Zone.Active.Teams[tostring(player.Team)].spawn

    local addX, addY = getRandomPointInCircle(5)
    local x, y = spawn[1] + addX, spawn[2] + addY
    local model = Config.Teams[tostring(player.Team)].Model

    TriggerClientEvent("koth:teleport", src, x, y, spawn[3], nil, model, true)
end)