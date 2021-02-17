-- Each team will have this
_TeamBase = {
      Players = {
            length = 0,
            add = function(self, playerID)
                  if type(self) ~= "table" then return false end
                  local index = tablefind(self, playerID)
                  if index ~= nil then self:remove(playerID) end
                  
                  TriggerClientEvent("koth:notification", playerID, _R(Config.Lang.team.joined, self.__team))
                  table.insert(self, playerID)
                  self.length = self.length + 1
            end,
            remove = function(self, playerID)
                  if type(self) ~= "table" or self[playerID] ~= nil then return false end
                  local index = tablefind(self, playerID)
                  if index == nil then return false end
                  
                  TriggerClientEvent("koth:notification", playerID,  _R(Config.Lang.team.left, self.__team))
                  table.remove(self, index)
                  self.length = self.length - 1
            end
      },
      Points = 0,
      reset = function(self)
            if type(self) ~= "table" then return false end
            self.Points = 0
            self.Players = {
                  length = 0,
                  add = self.Players.add,
                  remove = self.Players.remove
            }
      end
}

-- place the _TeamBase to each team
for i, team in pairs(Config.Teams) do
      for j, e in pairs(_TeamBase) do
            if type(_TeamBase[j]) == "table" then
                  Config.Teams[i][j] = {__team = i}
                  for k, l in pairs(_TeamBase[j]) do 
                        if type(_TeamBase[j][k]) == "nil" then return end
                        Config.Teams[i][j][k] = l
                  end
            else
                  if Config.Teams[i][j] ~= nil then return end
                  Config.Teams[i][j] = e
            end
      end
      KOTH.Teams[i] = Config.Teams[i]
end

RegisterCommand("team", function(source, args, raw)
      if(type(KOTH.Teams[args[1]]) == "nil") then return false end
      local player = KOTH.Players[tostring(source)]
      if(type(player) == "nil") then return false end
      if(type(player.Team) ~= "nil") then KOTH.Teams[player.Team].Players:remove(source) end

      KOTH.Players[tostring(source)].Team = args[1]

      KOTH.Teams[args[1]].Players:add(source)
end, false)

RegisterCommand("reset", function(source, args, raw)
      KOTH.Teams[args[1]]:reset()
      print(dump(KOTH.Teams[args[1]]))
end, false)

RegisterNetEvent("koth:getTeam")
AddEventHandler("koth:getTeam", function(team, cb)
    if team == nil or cb == nil then return false end
    cb(KOTH.Teams[tostring(team)])
end)