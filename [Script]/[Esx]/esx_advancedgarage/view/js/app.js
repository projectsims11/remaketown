
window.addEventListener('message', function (event) {
    let item = event.data;
    let data = item;    

    if(item.clear == true) {
        $('.items').empty();
        $('.shop').html();
    }

    if(item.display == true) {
        $('.container').show();
    }

    if(item.display == false) {
        $('.container').fadeOut(100);
    }

    /**
     * 
     * Initial
     */
    if(data.plate !== undefined) {
        let fuel = '0';
        if (data.fuel !== undefined) {
            fuel = data.fuel.toString();
        }

        if (data.garage == 'car') {
            // console.log('Garage');
            $('.items').append(template(data, 'garage'));
        } if (data.garage == 'pound') {
            // console.log('Pound');
            $('.items').append(template(data, 'pound'));
        } if (data.garage == 'pound_police_taken') {
            // console.log('Pounded by police');
            $('.items').append(template(data, 'police'));
        } if (data.garage == 'helicopter') {
            // console.log('Helicopter');
            $('.items').append(template(data, 'helicopter'));
        } if (data.garage == 'boat') {
            // console.log('Boat');
            $('.items').append(template(data, 'boat'));
        }

        $('#headerText').text(`(${data.garage})`);
    }
});

document.addEventListener('DOMContentLoaded', () => $('.container').hide());

function sender(name, item, zone) {
    var Sound = new Audio('Sound.mp3');
        Sound.volume = 0.4;
        Sound.play();
    $.post(`http://esx_advancedgarage/${name}`, JSON.stringify({
        item: item, 
        zone: zone
    }));

    $('.container').fadeOut(100);
    $.post('http://esx_advancedgarage/focusOff');
}

let template = (data, func) => `
    <div class="row item">
        <div class="col1">
            <div class="carlist">
                  <img src="nui://esx_advancedgarage/view/img/${data.name}.png" alt="${data.name} Image" class="item-image" onError="this.onerror=null;this.src='nui://esx_advancedgarage/view/img/default.png';"> 
            </div>
        </div>
        <div class="col2">
            <div class="carlist">
                <div class="label">
                    <div class="data-side">
                        <div class="data-title">
                            <div class="plate">${data.plate}</div>
                            <div class="model">[${data.name}]</div>
                        </div>
                        <div class="data-submeta">
                            <div class="engine flex"><ion-icon name="build-outline"></ion-icon> Engine: ${data.engine / 10}</div>
                            <div class="fuel flex"><ion-icon name="water-outline"></ion-icon> Gas: ${data.fuel}</div>
                            <div class="body flex"><ion-icon name="car-sport-outline"></ion-icon> Body: ${data.body / 10}</div>
                        </div>
                    </div>
                    <button type="button" class="btn" onclick="sender('${func}', '${data.plate2}', '${data.super}')">
                        <ion-icon name="arrow-forward-circle" class="first-check"></ion-icon> 
                        <ion-icon name="arrow-forward-circle-outline" class="second-check"></ion-icon>
                        เบิก
                    </button>
                </div>
            </div>
        </div>
    </div>
`;