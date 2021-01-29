-- Each team will have this
_TeamBase = {
      Players = {
            length = 0,
            add = function(self, playerID)
                  if type(self) ~= "table" then return false end
                  table.insert(self, playerID)
                  self.length = self.length + 1
            end,
            remove = function(self, playerID)
                  if type(self) ~= "table" or _TeamBase.Players[playerID] ~= nil then return false end
                  local index = tablefind(self, playerID)

                  if index == nil then return false end
                  table.remove(self, index)
                  self.length = self.length - 1
            end

      },
      Points = 0
}

-- Any custom variable
Teams = {
   red = {
      Hex = "#FF0000",
      Title = Lang["title"]["red"]
   },
   green = {
      Hex = "#00FF00",
      Title = Lang["title"]["green"]
   },
   blue = {
      Hex = "#0000FF",
      Title = Lang["title"]["blue"]
   }
}

-- place the _TeamBase to each team
for i, team in pairs(Teams) do
      for j, e in pairs(_TeamBase) do
            if Teams[i][j] ~= nil then return end
            Teams[i][j] = e
      end
end


-- ! Testing ! --
-- Teams["red"].Players:add("123")

-- print(dump(Teams["red"].Players))
-- print(Teams["red"].Players.length)

-- Teams["red"].Players:remove("123")

-- print(dump(Teams["red"].Players))

-- print(dump(Lang))