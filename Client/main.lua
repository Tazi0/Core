RegisterNetEvent("koth:setPosition")
AddEventHandler("koth:setPosition", function (x, y, z, rotation)
    local ped = PlayerPedId()

    SetEntityCoords(ped, x + .0, y + .0, z + .0, false, false, true)
    
    if type(rotation) ~= "nil" then
        SetEntityRotation(ped, 0, 0, rotation + .0, 2, true)
    end
    return true
end)