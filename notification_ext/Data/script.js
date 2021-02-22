let max_timer_notif = 5000 // 5 Seconds

function Notify(event)
{
    (() => {
        let n = document.createElement("div");
        let id = Math.random().toString(36).substr(2,10);

        
        n.setAttribute("id", id);
        n.classList.add("notification", event.data.type);
        n.innerText = event.data.text;
        
        let notificationArea = document.getElementById("notification-area");
        notificationArea.appendChild(n);

        setTimeout(()=>
        {
            var notifications = notificationArea.getElementsByClassName("notification")
            for(let i=0; i<notifications.length; i++)
            {
                if(notifications[i].getAttribute("id") == id)
                {
                    notifications[i].remove();
                    break;
                }
            }
        }, max_timer_notif);
    })();
}

window.addEventListener('message', function(event)
{
    if (event.data.type =="notification_main")
    {
        if(event.data.activate == true)

        if(!event.data.data_type.match(/^(fail|warning|success)$/)) {
            fetch('http://GTA_Notif/fail')
            return
    }

    fetch('http://GTA_Notif/main')

    Notify(event);
    }
})