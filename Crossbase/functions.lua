function tablefind(tab,el)
    for index, value in pairs(tab) do
        if value == el then
            return index
        end
    end
end

function error(code, data)
    if data == nil then data = "None" end
    if code == "Cannot index a funcref" then return true end
    print("^1("..code..", "..data..") ERROR OPEN DOCUMENTATION^0")
end

function firstUpper(str)
    return str:gsub("(%l)(%w*)", function(a,b) return string.upper(a)..b end)
end

local charset = {}  do -- [0-9a-zA-Z]
    for c = 48, 57  do table.insert(charset, string.char(c)) end
    for c = 65, 90  do table.insert(charset, string.char(c)) end
    for c = 97, 122 do table.insert(charset, string.char(c)) end
end

function randomString(length)
    local str = ''

    for i=1, length do
        str = str .. charset[math.random(#charset)]
    end

    return str
end

function near(player, x, y, z)
    local location = GetEntityCoords(player, 0)

    if GetDistanceBetweenCoords == nil then return location end

    local distance = GetDistanceBetweenCoords(x, y, z, location.x, location.y, location.z, true)

    if distance <= 5 then
        return true
    end
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
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

function table_invert(t)
   local s={}
   for k,v in ipairs(t) do
     s[v]=k
   end
   return s
end

function _R(string, ...)
    if type(string) == "nil" then return false end
   return string.format(string, ...)
end

function PlayerIdentifiers(playerID)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = "",
        id = playerID
    }

    for i = 0, GetNumPlayerIdentifiers(playerID) - 1 do
        local id = GetPlayerIdentifier(playerID, i)

        -- Table
        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end

    return identifiers
end

function missionTextDisplay(text, time)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(text)
    DrawSubtitleTimed(time, 1)
end