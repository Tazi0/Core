Citizen.CreateThread(function()
    for k,v in pairs(Zones.Blips) do
        TriggerEvent("koth:setBlip", v[1] .. " zone", v[2], v[3], v[5], v[4])
    end

    while true do
        Wait(1)
        local player = GetPlayerPed(-1)
        local playerloc = GetEntityCoords(player, 0)

        for _, search in pairs(Zones.Blips) do
            local distance = GetDistanceBetweenCoords(search[2], search[3], 0, playerloc['x'], playerloc['y'], 0, true)

            if distance <= search[5] and Zones.Entered[1] == false then
                missionTextDisplay("You entered a danger zone", 1000)
                TriggerServerEvent("koth:addPlayerToZone", -1, search[1])
                Zones.Entered[1] = true
                Zones.Entered[2] = search[1]
            elseif distance >= search[5] and Zones.Entered[1] == true then
                missionTextDisplay("You left the danger zone", 1000)
                Zones.Entered[1] = false
                Zones.Entered[2] = nil
            end
        end
    end
end)