_G['Preference']

RegisterNetEvent("koth:setPosition")
AddEventHandler("koth:setPosition", function (x, y, z, rotation)
    local ped = PlayerPedId()

    SetEntityCoords(ped, x, y, z, false, false, true)
    
    if type(rotation) ~= "nil" then
        local CurrRotation = GetEntityRotation(ped)
        print(CurrRotation)
        SetEntityRotation(CurrRotation.x, CurrRotation.y, CurrRotation.z + rotation)
    end
    return true
end)