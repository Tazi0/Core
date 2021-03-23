AddEventHandler("koth:menu", function(arr, id)
    local res = KOTH:Menu(arr, id)
end)

KOTH.Menu = function(self, arr, id)
    local menu = MenuV:CreateMenu(arr.title or Config.Lang.menu.noTitle, arr.description, Config.Menu.Placement, 0, 0, 255, Config.Menu.Size, 'default', 'menuv', id or randomString(5), 'native')

    if arr.items then
        render(menu, arr.items, {})
    end

    if arr.key ~= nil then
        menu:OpenWith('keyboard', arr.key)
    else
        menu:Open()
    end

    self.OpenMenus[id or menu.UUID] = menu
    return menu
end

AddEventHandler("koth:closeMenu", function(uuid)
    local menu = KOTH.OpenMenus[uuid]
    if menu == nil then return false end
    menu:Close()
end)

function render(menu, arr, list)
    for i=1, #arr do
        local item = arr[i]
        local menuItem = nil

        local addList = {
            label = item.label or Config.Lang.menu.noLabel, 
            description = item.description, 
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
                local submenu = MenuV:CreateMenu(s.title or Config.Lang.menu.noTitle, s.description, Config.Menu.Placement, 0, 0, 255, Config.Menu.Size, 'default', 'menuv', randomString(5), 'native')
                render(submenu, s.items, list)
                addList["value"] = submenu
            end
            menuItem = menu:AddButton(addList)
        elseif item.type == "confirm" then -- ! Confirm
            menuItem = menu:AddConfirm(addList)
        elseif item.type == "slider" then -- ! Slider
            menuItem = menu:AddRange(addList)
        end
        
        table.insert(list, menuItem)
    
        if(item.submenu == nil) then 
            menuItem:On('change', function(item, newValue, oldValue)
                for _,v in pairs(list) do
                    if v == item then
                        local e = arr[i]
                        if e == nil then return TriggerEvent("koth:notification", Config.Lua.menu.notFound) end
                        if e.change == nil then return false end
                        if type(e.change) == "table" then e.change(menu, item, newValue, oldValue)
                        else TriggerServerEvent(e.change, menu, item, newValue, oldValue) end
                        break
                    end
                end
            end)
        end

        menuItem:On('select', function(item)
            for _,v in pairs(list) do
                if v == item then
                    local e = arr[i]
                    if e == nil then return TriggerEvent("koth:notification", "~r~This menu item isn't found") end
                    if e.select == nil then return false end
                    if type(e.select) == "table" then e.select(menu, item)
                    else TriggerServerEvent(e.select, menu, item) end
                    break
                end
            end
        end)
    end
end