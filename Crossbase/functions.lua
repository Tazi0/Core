function round(x) return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5) end
-- https://gist.github.com/kuccello/9c6fefb2df5cac1f9b64/9f1755ff77f4c973352e63c1f578ad75ffba4525
function getRandomPointInCircle(radius)
    local t = 2*math.pi*math.random()
    local u = math.random()+math.random()
    local r = nil
    if u > 1 then r = 2-u else r = u end
    return round(radius*r*math.cos(t)), round(radius*r*math.sin(t))
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

function table.invert(t)
    local s={}
    for k,v in ipairs(t) do
        s[v]=k
    end
    return s
end

function table.find(tab,el)
    for index, value in pairs(tab) do
        if value == el then
            return index
        end
    end
end

function table.split(s, delimiter)
    result = {};
    if s == nil then return {} end
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

function table.join(arr, delimiter)
    str = ""
    for k,v in pairs(arr) do
        str = str .. delimiter .. v
    end
    return string.sub(str, 1);
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