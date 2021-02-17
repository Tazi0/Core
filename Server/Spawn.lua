function round(x) return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5) end
-- https://gist.github.com/kuccello/9c6fefb2df5cac1f9b64/9f1755ff77f4c973352e63c1f578ad75ffba4525
function getRandomPointInCircle(radius)
  local t = 2*math.pi*math.random()
  local u = math.random()+math.random()
  local r = nil
  if u > 1 then r = 2-u else r = u end
  return round(radius*r*math.cos(t)), round(radius*r*math.sin(t))
end 


function _spawn(src)
    local player = KOTH.Players[tostring(src)]

    if player.Team == nil then return false end
    local team = KOTH.Teams[player.Team]
    if team == nil or team.Spawnzone == nil then return false end

    local addX, addY = getRandomPointInCircle(team.Spawnzone[3])
    local x, y = team.Spawnzone[1] + addX, team.Spawnzone[2] + addY

    TriggerClientEvent("koth:respawn", src, x, y)
end


AddEventHandler("playerSpawned", function(source, spawnInfo)

    print(source, dump(spawnInfo))
    
end)

RegisterCommand("respawn", function (source, args, raw)
    TriggerEvent("koth:respawn", source, Config.Lang.deaths.unknown)
end, false)

RegisterNetEvent("koth:respawn")
AddEventHandler("koth:respawn", function(source, reason)
    -- _spawn(source)
    -- print("EXEC", source, reason)

    TriggerEvent("koth:getPlayer", source, function(player)
        TriggerEvent("koth:setPlayer", source, "Deaths", player.Deaths + 1)
    end)

    TriggerEvent("koth:getPlayer", source, function(player)
        print(player.Deaths)
    end)
end)