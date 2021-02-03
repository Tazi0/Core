function Player(playerID)
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
            xp = res.xp,
            level = res.level,
            addXP = function(self, amount)
                  if type(self) ~= "table" then return false end

                  self.xp = self.xp + amount

                  MySQL.Sync.execute("UPDATE users SET xp = xp + @added WHERE ".. uuid .."=@ID", { ['@ID'] = ids[Config.Player.Connection], ['@added'] = amount})
                  return self.xp
            end,
            removeXP = function(self, amount)
                  if type(self) ~= "table" then return false end

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
        Deaths = res.deaths,
        Kills = res.kills,
        Streak = res.streak,
        LastLoggedIn = res.lastLoggedIn,
        Team = nil,
        Invincible = false,
        setPos = function(self, x, y, z, rotation)
            TriggerClientEvent("koth:setPosition", self.Identifiers.id, x, y, z, rotation)
        end
    }
end

AddEventHandler("playerConnecting", function(name, setKickReason, deferrals)
    local src = source
    local player = Player(src)
    if(type(player) == "nil") then
        deferrals.done(_R("Please start %s and restart FiveM", Config.Player.Connection))
    else
        KOTH.Cache.Players[src] = player
    end
end)

AddEventHandler('playerDropped', function (reason)
    local player = KOTH.Cache.Players[source]

    if(type(player) ~= "nil") then KOTH.Cache.Players[source] = nil end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then return end

    for _, src in ipairs(GetPlayers()) do
        KOTH.Cache.Players[src] = Player(src)
    end
end)

RegisterNetEvent("koth:getPlayer")
AddEventHandler("koth:getPlayer", function(src, cb)
    if source ~= "" then src = source end

    cb(KOTH.Cache.Players[tostring(src)])
end)