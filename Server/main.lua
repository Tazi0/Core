for _, playerId in ipairs(GetPlayers()) do
  local name = GetPlayerName(playerId)
  print(('Player %s with id %i is in the server'):format(name, playerId))
  -- ('%s'):format('text') is same as string.format('%s', 'text)
end
