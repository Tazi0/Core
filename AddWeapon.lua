self.AddWeapon = function(WeaponName, Ammo, Components, Tint)
    if Inventory.PreventItem(Inventory.Weapons, WeaponName) then
        Ammo = Ammo or 0
        Components = Components or nil
        Tint = Tint or 0

        local PlayerInventory = Inventory.GetPlayerItems(self.Source)
        local Found = false
        for i in pairs(PlayerInventory) do
            if i == WeaponName then
                PlayerInventory[WeaponName]["Ammo"] = Ammo
                PlayerInventory[WeaponName]["Components"] = Components
                PlayerInventory[WeaponName]["Tint"] = Tint
                Found = true
                break
            end
        end
        if not Found then
            PlayerInventory[WeaponName] = {}
            PlayerInventory[WeaponName]["Ammo"] = Ammo
            PlayerInventory[WeaponName]["Components"] = Components
            PlayerInventory[WeaponName]["Tint"] = Tint
        end

        Inventory.Update(self.Source, PlayerInventory)
    else
        print("^3[Warning]^7Weapon ^5[".. WeaponName .."]^7 doesn't exists in database")
    end
end
