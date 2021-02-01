RegisterNetEvent("koth:setPosition")
AddEventHandler("koth:setPosition", function (x, y, z, rotation)
    local ped = PlayerPedId()

    SetEntityCoords(ped, x + .0, y + .0, z + .0, false, false, true)
    
    if type(rotation) ~= "nil" then
        SetEntityRotation(ped, 0, 0, rotation + .0, 2, true)
    end
    return true
end)

RegisterNetEvent("koth:setBlip")
AddEventHandler("koth:setBlip", function (title, x, y, radius, color)
    local blip = AddBlipForRadius(x, y, 194.0, radius)

    SetBlipAsShortRange(blip, true)
    SetBlipColour(blip, color or 2)
    SetBlipAlpha(blip, 100)

    local marker = AddBlipForCoord(x, y, 194.0)

    SetBlipSprite(marker, 84)
    SetBlipAsShortRange(marker, true)
    SetBlipColour(marker, color or 2)
    SetBlipScale(marker, 1.0)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(title)
    EndTextCommandSetBlipName(marker)
end)