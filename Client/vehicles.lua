AddEventHandler("koth:spawnVehicle", function(vehicle, x, y, z, r, spawnInside)
    local ped = GetPlayerPed(-1)
	local player = PlayerId()
	local vehicle = GetHashKey(vehicle)

    RequestModel(vehicle)

	while not HasModelLoaded(vehicle) do
		Wait(1)
	end

	local coords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, 5.0, 0)
	local car = CreateVehicle(vehicle, x, y, z, r, true, false)
	SetVehicleOnGroundProperly(car)
	if(spawnInside == true) then SetPedIntoVehicle(ped, car, -1) end
	SetModelAsNoLongerNeeded(vehicle)
end)