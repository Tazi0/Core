Citizen.CreateThread(function()
	alreadyDead = false

    while true do
        Citizen.Wait(50)
        local playerPed = GetPlayerPed(-1)

		if IsEntityDead(playerPed) and not alreadyDead then
			killer = GetPedSourceOfDeath(playerPed)

            if killer == 0 then return false end -- Self kill or by NPC

			killerSRC = nil

            for _, src in ipairs(GetPlayers()) do
                if killer == GetPlayerPed(src) then
					killerSRC = src
                    break
				end
            end

            if killerSRC == nil then return false end -- Not found

            if IsEntityAVehicle(playerPed) then
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                
                if GetVehicleBodyHealth(vehicle) == 0 then
                    -- vehicle kill
                    TriggerServerEvent("koth:kill", killerSRC, vehicle)
                else
                    -- kill in vehicle
                    TriggerServerEvent("koth:kill", killerSRC)
                end
            else
                -- standing kill
                TriggerServerEvent("koth:kill", killerSRC)
            end

			alreadyDead = true
        end

        if not IsEntityDead(playerPed) then
			alreadyDead = false
		end
    end
end)