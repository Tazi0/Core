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

function _R(string, ...)
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

function zoneLoop()
    Citizen.CreateThread(function()
        Wait(60000*1)
        print("loop")
        local highest = 0
        local team = nil

        for k,v in pairs(Zones.Active) do
            local teams = v.Teams

            for j, l in pairs(teams) do
                if highest < l then
                    team = j
                    highest = l
                end
            end
        end

        if highest ~= 0 or team ~= nil then 
            Teams[team].Points = Teams[team].Points + 1
            -- Todo: trigger UI to update the points
            -- TriggerEvent("koth:teamPoint", -1, team, Teams[team].Points)
        else
            print("no winner found")
        end

        zoneLoop()
    end)
end