local Teams = {
   "red" = {
      AddPlayer = function(self, playerID) {
            table.insert(self.Players, playerID) 
      },
      Players = []
   }
}

print(dump(Teams["red"].Players))

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end