RegisterNetEvent("koth:menu")
AddEventHandler("koth:menu", function(arr)
    local menu = MenuV:CreateMenu(arr.title or "No title", arr.description or "No description", 'topleft', 0, 0, 255, 'size-125', 'default', 'menuv', 'namespace', 'native')

    if arr.items then
        render(menu, arr.items, {})
    end

    if arr.key ~= nil then
        menu:OpenWith('keyboard', arr.key)
    else
        menu:Open()
    end
end)

RegisterNetEvent("koth:closeMenu")
AddEventHandler("koth:closeMenu", function(menu)
    MenuV:CloseMenu(menu)
end)

function render(menu, arr, list)
    for i=1, #arr do
        local item = arr[i]
        local menuItem = nil

        local addList = {
            label = item.label or "No label", 
            description = item.description or "No description", 
            value = item.active or 0,
            disabled = item.disabled or false,
            icon = item.icon or '',
            min = item.min or 0,
            max = item.max or 0
        }

        -- IMPORTANT ITEMS WILL HAVE STAR
        if item.important == true then
            addList['icon'] = "⭐"
        end

        if item.type == "checked" then -- ! Checked
            menuItem = menu:AddCheckbox(addList)
        elseif item.type == "options" then -- ! Options
            addList['values'] = item.values
            menuItem = menu:AddSlider(addList)
        elseif item.type == "button" then -- ! Button / Sub menu
            if item.submenu ~= nil then 
                local s = item.submenu
                local submenu = MenuV:CreateMenu(s.title or "No title", s.description or "No description", 'topleft', 0, 0, 255, 'size-125', 'default', 'menuv', 'sub-menu', 'native')
                render(submenu, s.items, list)
                addList["value"] = submenu
            end
            menuItem = menu:AddButton(addList)
        elseif item.type == "confirm" then -- ! Confirm
            menuItem = menu:AddConfirm(addList)
        elseif item.type == "slider" then -- ! Slider
            menuItem = menu:AddRange(addList)
        end
    
        if(item.submenu == nil) then 
            table.insert(list, menuItem)

            menuItem:On('change', function(item, newValue, oldValue)
                for _,v in pairs(list) do
                    if v == item then
                        local e = arr[i]
                        if e == nil then return TriggerEvent("koth:notification", "~r~This menu item isn't found") end
                        if e.change == nil then return false end
                        e.change(menu, newValue, oldValue)
                        break
                    end
                end
            end)

            menuItem:On('select', function(item)
                for _,v in pairs(list) do
                    if v == item then
                        local e = arr[i]
                        if e == nil then return TriggerEvent("koth:notification", "~r~This menu item isn't found") end
                        if e.select == nil then return false end
                        e.select(menu)
                        break
                    end
                end
            end)
        end
    end
end