RegisterNetEvent("koth:respawn")
AddEventHandler("koth:respawn", function(x, y)

    local z = GetHeightmapBottomZForPosition(x, y) + 3

    exports.spawnmanager:spawnPlayer({
        x = x + .0,
        y = y + .0,
        z = z + .0,
        heading = 0.0,
        model = 'a_m_m_farmer_01',
        skipFade = false
    })
end)

-- Citizen.CreateThread(function()
--     while true do
--         Wait(100)
--         local playerPed = GetPlayerPed(-1)
--         if IsEntityDead(playerPed) then
--             TriggerServerEvent("koth:respawn")
--         end
--     end
-- end)

Citizen.CreateThread(function()
	alreadyDead = false
    while true do
        Citizen.Wait(50)
        local playerPed = GetPlayerPed(-1)
		if IsEntityDead(playerPed) and not alreadyDead then
			killer = GetPedSourceOfDeath(playerPed)

            if(killer == 0) then return false end -- Self kill or by NPC
            print(killer)
			killername = false
			for id = 0, 64 do
				if killer == GetPlayerPed(id) then
					killername = GetPlayerName(id)
				end
			end

            if IsEntityAVehicle(playerPed) then
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                if GetVehicleBodyHealth(vehicle) == 0 then
                    -- vehicle kill
                else
                    -- kill in vehicle
                end
            else
                -- standing kill
            end
            
			alreadyDead = true
        end
        if not IsEntityDead(playerPed) then
			alreadyDead = false
		end
    end
end)