safeZonePoeple = {}

Citizen.CreateThread(function()
    local redInZone = 0 
    local greeninZone = 0
    local blueinZone = 0
    
    local redPoints = 0
    local greenPoints = 0
    local bluePoints = 0

    local redPlayers = 0
    local greenPlayers = 0
    local bluePlayers = 0

    RegisterNetEvent("koth:updateZoneStats")
    AddEventHandler("koth:updateZoneStats", function()
        
        if not stats.player then stats.players = { 0, 0, 0 } end
        if not stats.points then stats.points = { 0, 0, 0 } end
        if not stats.points then stats.points = { 0, 0, 0 } end

        redInZone = stats.players[1]
        greenInZone = stats.players[2]
        blueInZone = stats.players[3]

        redPoints = stats.points[1]
        greenPoints = stats.points[2]
        bluePoints = stats.points[3]

        redPlayers = stats.total[1]
        greenPlayers = stats.total[2]
        bluePlayers = stats.total[3]

        SendNuiMessage({
            type = 'updateTeam',
            team = 1,
            zone = redInZone,
            points = redPoints,
            players = redPlayers
        })

        SendNuiMessage({
            type = 'updateTeam',
            team = 2,
            zone = greenInZone,
            points = greenPoints,
            players = greenPlayers
        })

        -- Update Blue
        SendNuiMessage({
            type = 'updateTeam',
            team = 3,
            zone = blueInZone,
            points = bluePoints,
            players = bluePlayers
        })
    end)
end)

        local displayUI = true

RegisterCommand("toggleui", function()
    displayUI = not displayUI
    SendNuiMessage({
        type = 'setEnabled',
        state = displayUI
    })
end)


-- Update Money, XP, 


