local type_alert =
{
    "fail", -- Default if not specified. This can be changed in Data/script.js L:39
    "warning",
    "success"
}
local position_alert =
{
    "top-right",
    "top-middle",
    "top-left",
    ""
}

RegisterNetEvent("KOTH:NOTIFICATION_EXT")
AddEventHandler("KOTH:NOTIFICATION_EXT", function(data_text, data_type)
    exports.GTA_Notif:KOTH:NOTIFICATION_EXT ({
        text = data_text
        type = data_type -- Fail/Warning/Success
    })
end)



-- Functions
function KOTH:NOTIFICATION_EXT(setup)
    local text = setup.text or " "
    local config_alert = setup.type or type_alert[1]
    local typeAlert = type_alert[config_alert]

    SendNuiMessage({
        type = "notification_main"
        activate = true
        data_type = config_alert
        data_text = text
    })
end