_Zone = {
    Teams = {
        red = 0,
        blue = 0,
        green = 0
    },
    add = function(self, playerID)
        if type(self) ~= "table" then return false end

        local player = Player(playerID)

        if player.Team == nil then print "Player isn't in a team" end

        self.Teams[player.Team] = self.Teams[player.Team] + 1
    end,
    Points = 0,
    loop = zoneLoop()
}

Zones["Active"] = {}

for k,v in pairs(Zones.Blips) do
    Zones.Active[k] = _Zone
end