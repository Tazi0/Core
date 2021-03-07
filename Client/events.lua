Blips = {}

AddEventHandler("koth:setPosition", function (x, y, z, rotation)
    local ped = PlayerPedId()

    SetEntityCoords(ped, x + .0, y + .0, z + .0, false, false, true)
    
    if type(rotation) ~= "nil" then
        SetEntityRotation(ped, 0, 0, rotation + .0, 2, true)
    end
    return true
end)

AddEventHandler("koth:setBlip", function (title, x, y, color, radius, sprite)
    local blip = AddBlipForRadius(x, y, 0.0, radius + .0)

    SetBlipAsShortRange(blip, true)
    SetBlipColour(blip, color or 2)
    SetBlipAlpha(blip, 100)

    local marker = AddBlipForCoord(x, y, 0.0)

    SetBlipSprite(marker, sprite)
    SetBlipAsShortRange(marker, true)
    SetBlipColour(marker, color or 2)
    SetBlipScale(marker, 1.0)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(title)
    EndTextCommandSetBlipName(marker)

    Blips[title] = {
        Blip = blip,
        Marker = marker
    }
end)

AddEventHandler("koth:deleteBlips", function()
    for k, v in pairs(Blips) do
        RemoveBlip(v.Blip)
        RemoveBlip(v.Marker)
        Blips[k] = nil
    end
end)

AddEventHandler("koth:changeBlip", function(title, obj)
    local manager = Blips[title]

    if manager == nil then return false end

    local blip = manager.Blip
    local marker = manager.Marker

    for k, v in pairs(obj) do
        if k == "color" then
            SetBlipColour(blip, v)
            SetBlipColour(marker, v)
        end
    end

end)

AddEventHandler("koth:notification", function(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(true, true)
end)