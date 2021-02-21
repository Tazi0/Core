RegisterCommand("notif", function(source, args)
    exports.GTA_Notif:GTA_NUI_ShowNotification({
        text = "Hello world !",
        type = "success"
    })
end, false)