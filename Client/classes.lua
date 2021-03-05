local uuid = nil

Citizen.CreateThread(function()
    TriggerEvent("koth:_getWeapons")
    SetEveryoneIgnorePlayer(GetPlayerPed(-1), true) -- Police ignore player
    local open = false
    Wait(0)

    for k, team in pairs(Config.Teams) do
        if team.Class ~= nil then 
            local x = team.Class[1] + .0 or nil
            local y = team.Class[2] + .0 or nil
            local z = team.Class[3] + .0 or GetHeightmapBottomZForPosition(x, y) + 3 or nil
            local r = team.Class[4] or 30

            RequestModel(GetHashKey(Config.Classes.model))

            while not HasModelLoaded(GetHashKey(Config.Classes.model)) do
                Citizen.Wait(1)
            end

            local ped = CreatePed(4, GetHashKey(Config.Classes.model), x, y, z, r, true, true)

            SetEntityCompletelyDisableCollision(ped, false, false)
            SetBlockingOfNonTemporaryEvents(ped, true)
            FreezeEntityPosition(ped, true)
            SetEntityInvincible(ped, true)
        end
    end
    
    while true do
        Wait(0)

        for k,v in pairs(Config.Teams) do
            local team = v
            if team.Class ~= nil then
                local x = team.Class[1] + .0 or nil
                local y = team.Class[2] + .0 or nil
                local z = team.Class[3] + .0 or GetHeightmapBottomZForPosition(x, y) + 3 or nil

                if x ~= nil or y ~= nil or z ~= nil then
                    if near(GetPlayerPed(-1), x, y, z) then
                        DisplayHelpText(Config.Lang.classes.helpMessage)

                        if IsControlJustPressed(1, keys[Config.Classes.openKey]) and not open then
                            TriggerServerEvent("koth:renderClass", k)
                            open = true
                        else
                            if IsControlJustPressed(1, keys[Config.Classes.closeKey]) then
                                FreezeEntityPosition(PlayerPedId(), false)
                            end
                        end
                    else
                        open = false
                    end
                end
            end
        end
    end
end)

RegisterNetEvent("koth:ToggleWeapon", function(type, ammo, equip)
    local hash = GetHashKey(type)
    local ped = GetPlayerPed(GetPlayerFromServerId(source))

    if hash == nil then return false end
    
    if HasPedGotWeapon(ped, hash, false) then
        RemoveWeaponFromPed(ped, hash)
    else
        local remainingAmmo = GetAmmoInPedWeapon(ped, hash)

        if ammo == nil then
            ammo = 200 - tonumber(remainingAmmo)
        else
            ammo = ammo - tonumber(remainingAmmo)
        end

        GiveWeaponToPed(ped, hash, ammo or 200, false, equip or true)
    end
end)

RegisterNetEvent("koth:inMenu")
AddEventHandler("koth:inMenu", function()
    FreezeEntityPosition(PlayerPedId(), true)
end)

RegisterNetEvent("koth:_getWeapons")
AddEventHandler("koth:_getWeapons", function()
    local arr = {}
    local ped = GetPlayerPed(GetPlayerFromServerId(source))

    for k,v in ipairs(weaponHash) do
        local hash = GetHashKey(v)

        if hash ~= nil then
            local doesIt = GetWeaponClipSize(hash)
            if doesIt ~= 0 and HasPedGotWeapon(ped, hash, false) then
                table.insert(arr, weaponHash[k])
            end
        end
    end

    TriggerServerEvent("koth:_activeWeapons", arr)
end)

RegisterNetEvent("koth:removeWeapons")
AddEventHandler("koth:removeWeapons", function()
    local ped = GetPlayerPed(GetPlayerFromServerId(source))
    
    for k,v in ipairs(weaponHash) do
        local hash = GetHashKey(v)

        if hash ~= nil then
            local doesIt = GetWeaponClipSize(hash)
            if doesIt ~= 0 and HasPedGotWeapon(ped, hash, false) then
                RemoveWeaponFromPed(ped, hash)
            end
        end
    end
end)

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end