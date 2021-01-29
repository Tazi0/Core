MySQL.ready(function() 
    local player = Player(1)

    print(dump(player))

    -- player.Money:add(10)
    -- player.Money:remove(10)

    player:setPos(10, 10, 10, 10)
end)

function Player(playerID)
    local ids = PlayerIdentifiers(playerID)
    if ids.steam == "" then return false end

    local res = MySQL.Sync.fetchAll('SELECT * FROM users WHERE steamID=@steamID', { ['@steamID'] = ids.steam })


    if type(res) ~= "table" then 
        res = {
            cash = 0,
            level = 0,
            xp = 0,
            deaths = 0,
            streak = 0
        }

        MySQL.Sync.execute('INSERT INTO users (steamID) VALUES (@steamID)', { ['@steamID'] = ids.steam })
    else
        res = res[1]
    end

    return {
        Money = {
            __ids = ids,
            cash = tonumber(res.cash),
            add = function(self, amount)
                  if type(self) ~= "table" then return false end

                  self.cash = self.cash + amount

                  MySQL.Sync.execute("UPDATE users SET cash = cash + @added WHERE steamID=@steamID", { ['@steamID'] = self.__ids.steam, ['@added'] = amount})
                  return self.cash
            end,
            remove = function(self, amount)
                  if type(self) ~= "table" then return false end

                  self.cash = self.cash - amount

                  MySQL.Sync.execute("UPDATE users SET cash = cash - @added WHERE steamID=@steamID", { ['@steamID'] = self.__ids.steam, ['@added'] = amount})
                  return self.cash
            end,
            reset = function(self)
                  if type(self) ~= "table" then return false end

                  self.cash = 0

                  MySQL.Sync.execute("UPDATE users SET cash = 0 WHERE steamID=@steamID", { ['@steamID'] = self.__ids.steam})

                  return true
            end
        },
        Level = {
            xp = res.xp,
            level = res.level,
            addXP = function(self, amount)
                  if type(self) ~= "table" then return false end

                  self.xp = self.xp + amount

                  MySQL.Sync.execute("UPDATE users SET xp = xp + @added WHERE steamID=@steamID", { ['@steamID'] = self.__ids.steam, ['@added'] = amount})
                  return self.xp
            end,
            removeXP = function(self, amount)
                  if type(self) ~= "table" then return false end

                  self.xp = self.xp - amount

                  MySQL.Sync.execute("UPDATE users SET xp = xp - @added WHERE steamID=@steamID", { ['@steamID'] = self.__ids.steam, ['@added'] = amount})
                  return self.xp
            end,
            reset = function(self)
                  if type(self) ~= "table" then return false end

                  self.xp = 0

                  MySQL.Sync.execute("UPDATE users SET xp = 0 WHERE steamID=@steamID", { ['@steamID'] = self.__ids.steam})

                  return true
            end
        },
        Identifiers = ids,
        Deaths = res.deaths,
        Kills = res.kills,
        Streak = res.streak,
        LastLoggedIn = res.lastLoggedIn,
        Team = nil,
        setPos = function(self, x, y, z, rotation)
            TriggerClientEvent("koth:setPosition", self.Identifiers.id, x, y, z, rotation)
        end
    }
end

-- print(Player(1))