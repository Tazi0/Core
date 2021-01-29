function tablefind(tab,el)
    for index, value in pairs(tab) do
        if value == el then
            return index
        end
    end
end

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      local sub = false
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ', '
         sub = true
      end
      if sub then s = s:sub(0, #s - 2) 
      else s = s:sub(0, #s - 1) end
      return s .. ' }'
   else
      return tostring(o)
   end
end