activeWeapons = nil

RegisterNetEvent("koth:renderClass")
AddEventHandler("koth:renderClass", function(team)
    if source ~= "" then src = source end

    local player = KOTH.Cache.Players[tostring(src)]
    local ped = GetPlayerPed(src)

    if player == nil or player.Team ~= team or player.Team == nil then return TriggerClientEvent("koth:notification", src, "You are not on ~y~".. team .. "~s~'s team") end

    local classes = Config.Classes
    local id = randomString(5)

    local arr = {
        title = classes.title,
        description = classes.description,
        items = {}
    }

    function loop(class)
        local sub = {
            title = class.label,
            description = "Choose your weapons",
            items = {}
        }

        if class.label == nil then
            return error(2040)
        end

        if Config.Weapons[class.label] ~= nil then
            for l,w in pairs(Config.Weapons[class.label]) do
                local title = "Extra"

                if l == 1 then title = "Primary"
                elseif l == 2 then title = "Secondary"
                end

                local add = { --! 2.2
                    label = title,
                    type = "button",
                    submenu = {
                        title = title,
                        description = "Choose your weapons",
                        items = {}
                    }
                }

                for _,e in ipairs(Config.Weapons[class.label][l]) do
                    local label = e[1] or e
                    local title = nil
                    local active = false
                    local disabled = false

                    if type(e) == "table" then
                        if player.Level.level < e[2] then
                            disabled = true
                        end
                    end

                    for k, v in ipairs(weaponHash) do
                        if v == label then
                            title = weaponHash[k-1]
                            break
                        end
                    end

                    if activeWeapons ~= nil then
                        for k, v in ipairs(activeWeapons) do
                            if v == label then
                                active = true
                                break
                            end
                        end
                    end

                    local weapon = {
                        label = title or "Unknown",
                        type = "checked",
                        active = active,
                        change = "koth:selectedWeapon",
                        disabled = disabled
                    }

                    table.insert(add.submenu.items, weapon)
                end

                table.insert(sub.items, add)
            end
        end

        local add = {
            label = class.label,
            description = "You can click on me",
            type = "button"
        }

        if #sub.items ~= 0 then
            add['submenu'] = sub
            add['select'] = "koth:selectClass"
        else
            add["disabled"] = true
            error(2042, add.label)
        end

        if class.level == nil or class.level > player.Level.level then
            if class.level == nil then
                add["disabled"] = true
                error(2041, add.label)
            else
                add["description"] = "You need to be level ~y~" .. class.level .. "~s~ you are ~y~" .. player.Level.level
                add['submenu'] = nil
            end
        end

        table.insert(arr.items, add)
    end

    local function has_value(tab, val)
        for i, v in ipairs(tab) do
            if v.label == val then
                return i
            end
        end

        return false
    end

    -- if player.Class == nil then
        for k,v in ipairs(classes.items) do
            loop(v)
        end
    -- else
    --     ! Removed feature, this would only show selected class once selected.
    --     print(player.Class)
    --     local v = has_value(classes.items, player.Class)
    --     loop(classes.items[v])
    -- end

    TriggerClientEvent("koth:menu", src, arr, id)
    TriggerClientEvent("koth:inMenu", src)
end)

RegisterNetEvent("koth:selectClass")
AddEventHandler("koth:selectClass", function(menu, item)
    KOTH.Cache.Players[tostring(source)].Class = item.data.Label
end)

RegisterNetEvent("koth:selectedWeapon")
AddEventHandler("koth:selectedWeapon", function(menu, item, oldValue, newValue)
    local label = item.data.Label
    local weaponMenu = menu.data.Title:lower()
    local class = KOTH.Cache.Players[tostring(source)].Class

    if class == nil then return error(2051, source) end

    local i = nil
    local typeMenu = 3
    
    for k,v in pairs(menu.data.Items.data) do
        if type(v) == "table" and v.data ~= nil and v.data.Label == label then
            i = k
        end
    end

    if i == nil then return false end

    if weaponMenu == "primary" then
        typeMenu = 1
    elseif weaponMenu == "secondary" then
        typeMenu = 2
    end


    local weapon = Config.Weapons[class][typeMenu][i]
    local equip = false
    local ammo = nil

    if typeMenu == 1 then
        equip = true
    end

    if type(weapon) == "table" then 
        ammo = weapon[3]
        weapon = weapon[1]
    end

    TriggerClientEvent("koth:ToggleWeapon", source, weapon, ammo, equip)
end)

RegisterNetEvent("koth:_activeWeapons")
AddEventHandler("koth:_activeWeapons", function(arr)
    activeWeapons = arr
end)