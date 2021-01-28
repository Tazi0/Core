Teams = {
   red = {
      AddPlayer = function(self, playerID)
            if type(self) ~= "table" then return false end
            table.insert(self.Players, playerID) 
      end,
      RemovePlayer = function(self, playerID)
            if type(self) ~= "table" then return false end
            local index = tablefind(self.Players, playerID)

            if index == nil then return false end
            table.remove(self.Players, index)
      end,
      Players = {}
   }
}

Teams["red"]:AddPlayer("123")

print(dump(Teams["red"].Players))

Teams["red"]:RemovePlayer("123")

print(dump(Teams["red"].Players))

print(dump(Config))