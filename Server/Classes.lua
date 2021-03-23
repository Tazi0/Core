activeWeapons = nil

AddEventHandler("koth:renderClass", function(team)
    if source ~= "" then src = source end

    local player = KOTH.Players[tostring(src)]
    local ped = GetPlayerPed(src)

    if player == nil or player.Team ~= team or player.Team == nil then return TriggerClientEvent("koth:notification", src, _R(Config.Lang.team.notSameTeam, team)) end

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
            description = Config.Lang.classes.chooseWeapons,
            items = {}
        }

        if class.label == nil then
            return error(2040)
        end

        if Config.Weapons[class.label] ~= nil then
            for l,w in pairs(Config.Weapons[class.label]) do
                local title = Config.Lang.classes.extra

                if l == 1 then title = Config.Lang.classes.primary
                elseif l == 2 then title = Config.Lang.classes.secondary
                end

                local add = { --! 2.2
                    label = title,
                    type = "button",
                    submenu = {
                        title = title,
                        description = Config.Lang.classes.chooseWeapons,
                        items = {}
                    }
                }

                for _,e in ipairs(Config.Weapons[class.label][l]) do
                    local label = e.weapon or e
                    local title = nil
                    local active = false
                    local disabled = false

                    local rent = {
                        price = 1000,
                        disabled = false
                    }
                    local buy = {
                        price = 2000,
                        disabled = false
                    }

                    if type(e) == "table" then
                        if e.level ~= nil and player.Level.level < e.level then
                            disabled = true
                        end

                        if e.rent ~= nil then
                            rent.price = e.rent
                        else
                            rent.disabled = true
                        end

                        if e.buy ~= nil then
                            buy.price = e.buy
                        else
                            buy.disabled = true
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
                        label = title or Config.Lang.weapons.noWeapon,
                        type = "button",
                        submenu = {
                            title = title or Config.Lang.weapons.noWeapon,
                            description = "You want to rent or buy it?",
                            items = {
                                {
                                    label = "Rent",
                                    description = "Rent for ~y~" .. Config.Money.Currency .. rent.price,
                                    type = "button",
                                    select = "koth:buyWeapon",
                                    disabled = rent.disabled
                                }, {
                                    label = "Buy",
                                    description = "Buy for ~y~" .. Config.Money.Currency .. buy.price,
                                    type = "button",
                                    select = "koth:buyWeapon"
                                }
                            }
                        },
                        -- change = "koth:selectedWeapon",
                        disabled = disabled
                    }

                    -- If weapon is bought buy player, have automaticly trigger "koth:selectedWeapon" and remove submenu
                    if table.find(player.Weapons.items, label) then
                        weapon.submenu = nil
                        weapon.select = "koth:equipWeapon"
                    end

                    table.insert(add.submenu.items, weapon)
                end

                table.insert(sub.items, add)
            end
        end

        local add = {
            label = class.label,
            description = Config.Lang.classes.clickMe,
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
                add["description"] = _R(Config.Lang.classes.lowerLevel, class.level, player.Level.level)
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

    for k,v in ipairs(classes.items) do
        loop(v)
    end

    local ammo = {
        label = "Ammo",
        description = "Buy ammo here",
        type = "button",
        submenu = {
            title = "Ammo",
            description = "Buy ammo here",
            items = {}
        }
    }

    for k, v in ipairs(activeWeapons) do
        local weapon = v.weapon;

        local item;
        local equipment;

        for k,v in pairs(Config.Weapons[player.Class]) do
            if type(v) == "table" then
                for j,o in pairs(v) do
                    if type(o) == "table" and o.weapon == weapon then
                        item = o
                        equipment = j
                        break
                    elseif type(o) == "string" and o == weapon then
                        item = o
                        equipment = j
                        break
                    end
                end
            end
        end

        local arr = {
            label = weaponHash[table.find(weaponHash, item.weapon)-1],
            description = "Slide for more ammo, press ~y~Enter~s~ to buy",
            type = "slider",
            min = 0,
            max = 10,
            select = "koth:buyAmmo",
            change = "koth:amountAmmo"
            
        }

        local remainingAmmo = math.floor((item.bullets - v.ammo)/10)

        if remainingAmmo < 10 then
            arr.max = remainingAmmo
        end

        table.insert(ammo.submenu.items, arr)
    end

    table.insert(arr.items, ammo)

    TriggerClientEvent("koth:menu", src, arr, id)
end)

AddEventHandler("koth:selectClass", function(menu, item)
    if KOTH.Players[tostring(source)].Class ~= nil then
        TriggerClientEvent("koth:removeWeapons", source)
    end

    KOTH.Players[tostring(source)].Class = item.data.Label
end)

AddEventHandler("koth:buyWeapon", function(menu, choice, oldValue, newValue)
    local src = source
    local player = KOTH.Players[tostring(src)]
    local title = menu.data.Title
    local _type;
    local item;
    local equipment;
    choice = choice.data.Label:lower()

    
    if player.Class == nil then return error(2051, source) end

    for k, v in ipairs(weaponHash) do
        if v == title then
            _type = weaponHash[k+1]
            break
        end
    end

    for k,v in pairs(Config.Weapons[player.Class]) do
        if type(v) == "table" then
            for j,o in pairs(v) do
                if type(o) == "table" and o.weapon == _type then
                    item = o
                    equipment = j
                    break
                elseif type(o) == "string" and o == _type then
                    item = o
                    equipment = j
                    break
                end
            end
        end
    end
    
    if item == nil then return false end

    local weapon = item.weapon or item
    local price = 0
    local equip = false
    local bullets = 60

    if equipment == 1 then
        equip = true
        bullets = item.bullets or 150
        price = item[choice] or 1000
    elseif equipment == 2 then
        bullets = item.bullets or 100
        price = item[choice] or 500
    elseif equipment == 3 then
        bullets = item.bullets or 20
        price = item[choice] or 100
    end

    if price == nil or price == 0 then
        TriggerClientEvent("koth:ToggleWeapon", src, weapon, bullets, equip)
    else
        if player.Money.cash >= price then
            player.Money:remove(price)
            TriggerClientEvent("koth:ToggleWeapon", src, weapon, bullets, equip)
            player.Weapons:add(weapon)
        else
            TriggerClientEvent("koth:notification", src, "~r~You don't have enough money")
        end
    end
end)

AddEventHandler("koth:buyAmmo", function(menu, item, oldValue, newValue)
    local src = source
    local value = item.data.Value
    local label = item.data.Label
    local player = KOTH.Players[tostring(src)]
    local weapon;

    if value == 0 or value == nil or player == nil then return false end
    value = value * 10

    for k, v in ipairs(weaponHash) do
        if v == label then
            weapon = weaponHash[k+1]
            break
        end
    end

    if weapon == nil or GetHashKey(weapon) == nil then return false end

    local price = value * 5

    if player.Money.cash >= price then
        player.Money:remove(price)
        TriggerClientEvent("koth:addAmmo", src, weapon, value)
        TriggerClientEvent("koth:notification", src, "~g~Added " .. value .. " ammo")
    else
        TriggerClientEvent("koth:notification", src, "~r~You don't have enough money")
    end
end)

AddEventHandler("koth:amountAmmo", function(menu, item, oldValue, newValue)
    TriggerClientEvent("koth:notification", source, "Add ".. tonumber(newValue)*10 .. " ammo")
end)

AddEventHandler("koth:equipWeapon", function(menu, item)
    local player = KOTH.Players[tostring(source)]
    local label = item.data.Label
    local weapon;
    local conf;
    local equipment;

    for k, v in ipairs(weaponHash) do
        if v == label then
            weapon = weaponHash[k+1]
            break
        end
    end

    for k,v in pairs(Config.Weapons[player.Class]) do
        if type(v) == "table" then
            for j,o in pairs(v) do
                if type(o) == "table" and o.weapon == _type then
                    conf = o
                    equipment = j
                    break
                elseif type(o) == "string" and o == _type then
                    conf = o
                    equipment = j
                    break
                end
            end
        end
    end

    local equip = false
    local bullets = 60

    if equipment == 1 then
        equip = true
        bullets = conf.bullets or 150
    elseif equipment == 2 then
        bullets = conf.bullets or 100
    elseif equipment == 3 then
        bullets = conf.bullets or 20
    end

    TriggerClientEvent("koth:ToggleWeapon", source, weapon, bullets, equip)
end)

AddEventHandler("koth:_activeWeapons", function(arr)
    activeWeapons = arr
end)