-- Each team will have this
_TeamBase = {
      Players = {
            length = 0,
            add = function(self, team, playerID)
                  if type(self) ~= "table" then return false end
                  table.insert(self, playerID)
                  self.length = self.length + 1
                  TriggerClientEvent("koth:notification", playerID, _R(Config.Lang.team.joined, team))
            end,
            remove = function(self, team, playerID)
                  if type(self) ~= "table" or self[playerID] ~= nil then return false end
                  local index = table.find(self, playerID)
                  
                  TriggerClientEvent("koth:notification", playerID, _R(Config.Lang.team.left, team))

                  if index == nil then return false end
                  table.remove(self, index)
                  self.length = self.length - 1
            end
      },
      Points = 0
}

-- place the _TeamBase to each team
for i, team in pairs(Config.Teams) do
      for j, e in pairs(_TeamBase) do
            if type(_TeamBase[j]) == "table" then
                  Config.Teams[i][j] = {}
                  for k, l in pairs(_TeamBase[j]) do 
                        if type(_TeamBase[j][k]) == "nil" then return end
                        Config.Teams[i][j][k] = l
                  end
            else
                  if Config.Teams[i][j] ~= nil then return end
                  Config.Teams[i][j] = e
            end
      end
end

RegisterCommand("team", function(source, args, raw)
      TriggerEvent("koth:playerTeam", source, args[1])
	  TriggerClientEvent("koth:resetZoneCheck", source)
	  Citizen.Wait(2000)
	  TriggerEvent("koth:blipRender",source) 
end, false)

AddEventHandler("koth:playerTeam", function(src, team)
      if(type(src) == "number") then source = src else team = src end
      if(type(Config.Teams[team]) == "nil") then return false end
      local player = KOTH.Players[tostring(source)]
      
      if(type(player) == "nil") then return TriggerClientEvent("koth:notifications", Config.Lang.player.notFound) end
      if(type(player.Team) ~= "nil") then Config.Teams[player.Team].Players:remove(player.Team, source) end

      KOTH.Players[tostring(source)].Team = team
      Config.Teams[team].Players:add(team, source)
      
      TriggerEvent("koth:respawn", source)
end)
