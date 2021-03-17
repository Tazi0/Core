
window.addEventListener('message', (event) => {

if(event.data.type == "setVehicleData") {
    $('.vehicle-info').html("");
    
    for(const person of event.data.persons) {
        addPersonToVehicle(person.driver, person.name);
    }
}
});
function addPersonToVehicle(driver, name) {
    let icon = (driver) ? "fas fa-car" : 'fas fa-user';

    let element = `
        <div class="info-wrapper">
            <div class="info">
                ${name} <i class="${icon}"></i>
            </div>
        </div>
    `;

    $('.vehicle-info').append(element);
}


