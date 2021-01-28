RegisterNetEvent("KOTH:LoadPlayer")
AddEventHandler('KOTH:LoadPlayer', function(Sex, PlayerSkin, Position)
    local Model 
    local MaleModel
    local FemaleModel

    -- Sex of the model
    if Sex == "Male" then
        Model = MaleModel
    else
        Model = FemaleModel
    end

    

    SetPlayerModel(PlayerID(), Model)


-- PlayerSkin for model
    if Sex == "Male" then

-- Insert
    elseif Sex == "Female"
-- Insert
    end

-- Player Position
SetEntityCoords(PlayerPedId(), Position.x, Position.y, Position.z, false, false, false, true)

Player.Loaded = true
DoScreenFadeIn(1000)

end)

RegisterNetEvent("KOTH:Notification")
AddEventHandler("KOTH:Notification", function(Message)
    -- Insert Notification function
end)

RegisterNetEvent("KOTH:DeathDetection")
AddEventHandler("KOTH:DeathDetection", function(Data)
    AnimpostfxPlay("DeathFailOut", 0, true)
    PlaySoundFrontend(-1, "Bed", "WastedSounds", true)
end)

