local vehicleTab;

AddEventHandler("koth:renderVehicles", function(team)
    local src = source

    local player = KOTH.Players[tostring(src)]
    local ped = GetPlayerPed(src)

    if player == nil or player.Team ~= team or player.Team == nil then return TriggerClientEvent("koth:notification", src, _R(Config.Lang.team.notSameTeam, team)) end

    local menu = {
        title = _R(Config.Lang.vehicles.menu.title),
        description = "Select your vehicle",
        items = {}
    }

    for i, v in pairs(Config.Vehicles.Items) do

        local arr = {
            label = i,
            type = "button",
            submenu = {
                title = i,
                description = _R(Config.Lang.vehicles.menu.select, i),
                items = {}
            }
        }

        for l, w in pairs(v) do
            local item = {
                label = w.title,
                type = "button"
            }

            if player.Level.level >= w.level then
                if table.find(player.Vehicles.items, w.vehicle) then
                    item.select = "koth:spawnVehicle"
                    item.description = _R(Config.Lang.vehicles.menu.free)
                elseif w.buy == nil and w.rent ~= nil then
                    item.description = _R(Config.Lang.vehicles.menu.type, Config.Lang.menu.rent, Config.Money.Currency, w.rent)
                    item.select = "koth:spawnVehicle"
                elseif w.rent == nil and w.buy ~= nil then
                    item.description = _R(Config.Lang.vehicles.menu.type, Config.Lang.menu.rent, Config.Money.Currency, w.buy)
                    item.select = "koth:spawnVehicle"
                elseif w.rent ~= nil and w.buy ~= nil then
                    item.submenu = {
                        title = w.title,
                        description = _R(Config.Lang.vehicles.menu.option),
                        items = {
                            {
                                label = Config.Lang.menu.rent,
                                description = _R(Config.Lang.vehicles.menu.type, Config.Lang.menu.rent, Config.Money.Currency, w.rent),
                                type = "button",
                                select = "koth:spawnVehicle"
                            },
                            {
                                label = Config.Lang.menu.buy,
                                description = _R(Config.Lang.vehicles.menu.type, Config.Lang.menu.rent, Config.Money.Currency, w.buy),
                                type = "button",
                                select = "koth:spawnVehicle"
                            }
                        }
                    }
                    item.description = _R(Config.Lang.vehicles.menu.both)
                    item.select = "koth:_activeVehicleTab"
                else
                    item.description = _R(Config.Lang.vehicles.menu.none)
                end
            else
                item.description = _R(Config.Lang.classes.lowerLevel, w.level, player.Level.level)
            end

            table.insert(arr.submenu.items, item)
        end
        table.insert(menu.items, arr)
    end

    TriggerClientEvent("koth:menu", src, menu)
end)

AddEventHandler("koth:_activeVehicleTab", function(menu, item, oldvalue, newValue)
    vehicleTab = menu.data.Title
end)

AddEventHandler("koth:spawnVehicle", function(menu, item, oldValue, newValue)
    local src = source
    local label = item.data.Label
    local player = KOTH.Players[tostring(src)]

    local configItem;

    local vehicleTitle;
    local vehicle;
    local hash;
    local category;
    local type;
    local price;

    if label ~= Config.Lang.menu.buy and label ~= Config.Lang.menu.rent then -- If it's not a sub menu
        vehicleTitle = label
        category = menu.data.Title
    else
        type = label:lower()
        vehicleTitle = menu.data.Title
        category = vehicleTab
    end

    if vehicleTitle == nil then return false end

    for i, v in ipairs(Config.Vehicles.Items[category]) do
        if v.title == vehicleTitle then
            vehicle = v
            break
        end
    end

    if vehicle == nil then return false end

    if type == nil then
        if vehicle.rent == nil then type = "buy"
        elseif vehicle.buy == nil then type = "rent"
        end
    end

    hash = vehicle.vehicle
    price = vehicle[type]
    local spawn = Config.Zone.Active.Teams[player.Team].vehicleSpawn

    if table.find(player.Vehicles.items, hash) then
        return TriggerClientEvent("koth:spawnVehicle", src, hash, spawn[1], spawn[2], spawn[3], spawn[4], true)
    end
    
    local res = player.Money:remove(price)

    if res == false then
        return TriggerClientEvent("koth:notification", src, _R(Config.Lang.vehicles.noMoney))
    end

    if(type == "buy") then
        player.Vehicles:add(hash)
    end

    TriggerClientEvent("koth:spawnVehicle", src, hash, spawn[1], spawn[2], spawn[3], spawn[4], true)
end)