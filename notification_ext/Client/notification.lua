local type_alert =
{
    "fail", -- Default if not specified. This can be changed in Data/script.js L:39
    "warning",
    "success",
    "info"
}
local position_alert =
{
    "top",
    "topLeft",
    "topCenter",
    "topRight",
    "center",
    "centerLeft",
    "centerRight",
    "bottom",
    "bottomLeft",
    "bottomCenter",
    "bottomRight"
}

RegisterNetEvent("KOTH:NOTIFICATION_EXT")
AddEventHandler("KOTH:NOTIFICATION_EXT", function(text, type, position)
    KOTH:NOTIFICATION_EXT ({
        text = data_text
        type = data_type 
        position = data_position 
    })
end)



-- Functions
function KOTH:NOTIFICATION_EXT(options)
    local text = setup.text or " "
    local config_alert = setup.type or type_alert[1]
    local typeAlert = type_alert[config_alert]
    local positionAlert = position_alert or "centerRight"

    SendNuiMessage({
        type = "notification_main"
        activate = true
        data_type = config_alert
        data_position = config_position
        data_text = text
    })
end