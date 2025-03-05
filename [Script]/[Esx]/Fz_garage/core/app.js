window.addEventListener('message', function (event) {
    var item = event.data;
    if (item.clear == true) {
        $(".box-itemlist").empty();
        
    }
    if (item.display == true) {
        $(".box-body").show();
        

        $('.box-body').css('animation','In .5s forwards')

        var sound = new Audio('name.mp3');
        sound.volume = 0.3;
        sound.play();
    }
    if (item.display == false) {
        $('.box-body').css('animation','Out .5s forwards')
        $(".box-body").fadeOut();

     
    }
});

document.addEventListener('DOMContentLoaded', function () {
    $('.box-body').css('animation','Out .5s forwards')
    $(".box-body").hide();
    
    $(".hantrainer").hide();
    $(".console").hide();
    
});

function car(item, zone) {
    $.post('http://Fz_garage/store', JSON.stringify({
        item: item, zone: zone
    }));
    $(".box-body").fadeOut();
    $.post('http://Fz_garage/focusOff');
    $('.box-body').css('animation','Out .5s forwards')

}

// $("#submit").click(function () {
// let inputValue = $("#renameid").val()

// if (inputValue.length >= 10){
//     $.post("http://Fz_garage/error", JSON.stringify({
//         error: "You can't type that many characters."
//     }))
//     return
// }


// $('.box-dialog').hide();
// $.post('http://Fz_garage/join', JSON.stringify({
//     rename: inputValue, 
// }));

// })
document.onkeyup = function (data) {
    if (data.which == 27) {
        $(".box-dialog").hide();
        $(".box-dialog").fadeOut();
        
        $.post('http://Fz_garage/exit', JSON.stringify({}));
        return
    }
};

function rename() {
    // $(".box-dialog").hide();
    $(".box-dialog").show();
    print('asdasd')
    $.post('http://Fz_garage/rename', JSON.stringify({
    })); 
}

function cancel() {
    // $(".box-dialog").hide();
    $(".box-dialog").hide();
    print('asdasd')
    $.post('http://Fz_garage/cancel', JSON.stringify({
    })); 
}

function confirm() {
    // $(".box-dialog").hide();
    // $(".box-dialog").hide();
    // print('asdasd')
    // $.post('http://Fz_garage/cancel', JSON.stringify({
    // })); 

    $(".box-dialog").hide();
    
    let inputValue = $("#renameid").val()

    if (inputValue.length >= 10){
        $.post("http://Fz_garage/error", JSON.stringify({
            error: "You can't type that many characters."
        }))
        return
    }
    

    // $('body').hide();

    
    $.post('http://Fz_garage/join', JSON.stringify({
        firstname: inputValue,
        // lastname: inputValue2,
        
    }));
    
}


// sound.play();
// $('.box-container').fadeOut()
// $('.box-container').css('animation','Out .5s forwards')
// $.post('http://esx_duty/on', JSON.stringify({
// })); 

function yar(item, zone) {
    $.post('http://Fz_garage/step', JSON.stringify({
        item: item, zone: zone
    }));
    $(".box-body").fadeOut();
    $('.box-body').css('animation','Out .5s forwards')
    $.post('http://Fz_garage/focusOff');
   
}

function tar(item, zone) {
    $.post('http://Fz_garage/stue', JSON.stringify({
        item: item, zone: zone
    }));
    $(".box-body").fadeOut();
    $('.box-body').css('animation','Out .5s forwards')
    $.post('http://Fz_garage/focusOff');

}

function openetrunk(item, zone) {
    $.post('http://Fz_garage/openetrunk', JSON.stringify({
        item: item, zone: zone
    }));
    $(".box-body").fadeOut();
    $('.box-body').css('animation', 'Out .5s forwards')
    $.post('http://Fz_garage/focusOff');

}


// function audio() {
//     const audio = new Audio();
//     audio.src = "click.mp3";
//     audio.volume = 0.5;
// }

function mar(item, zone) {
    $.post('http://Fz_garage/string', JSON.stringify({
        item: item, zone: zone
    }));
    $(".box-body").fadeOut();
    $('.box-body').css('animation','Out .5s forwards')
    $.post('http://Fz_garage/focusOff');

}

window.addEventListener('message', function (event) {
    var data = event.data;
    if (data.clear !== undefined) {
       $(".shop").html();
    }
});

window.addEventListener('message', function (event) {
    var data = event.data;
    if (data.sound !== undefined) {
    }
});



window.addEventListener('message', function (event) {
    var data = event.data;

  

    if (data.plate !== undefined) {
        
  

        var fuel = '0'
        if (data.fuel !== undefined) {
            fuel = data.fuel.toString();
        
        }
        
        
        if (data.garage == "car") {
            $(".box-itemlist").prepend(`
           

            <div class="itemlist">
            <div class="logo-car">
                <ion-icon name="car-sport" class="ic-car"></ion-icon>
                    
            </div>
            <div class="name-car">
            `+data.model+`&nbsp;( `+data.plate+` )
            </div>
            <div class="engin">
                <div class="text-engin">
                    <i class='bx bxs-car-mechanic' ></i>&nbsp;ENGIN
                </div>
                <div class="box-percent-engin">
                    <div class="load-engin" id="loadengin"></div>
                </div>
                <div class="percent-engin">
                `+(data.engine/10)+` %
                </div>
            </div>
            <div class="fuel">
                <div class="text-fuel">
                    <ion-icon name="water"></ion-icon>&nbsp;FUEL
                </div>
                <div class="box-percent-fuel">
                    <div class="load-fuel" id="loadfuel"></div>
                </div>
                <div class="percent-fuel">
                 `+fuel+` %
                </div>
            </div>
            <div class="confrim" onclick="car('`+data.plate2+`', '`+data.super+`')">
                เบิกรถ&nbsp;<ion-icon name="arrow-down-circle"></ion-icon>
            </div>
            <div class="confrim-trunk" onclick="openetrunk('`+ data.plate2 + `', '` + data.super +`')">
                เปิดหลังรถ&nbsp;<ion-icon name="arrow-down-circle"></ion-icon>
            </div>
        </div>
        
    
            `);
        } if (data.garage == "pound") {
            $(".box-itemlist").prepend(`
         
    

           
            <div class="itemlist">
            <div class="logo-car">
                <ion-icon name="car-sport" class="ic-car"></ion-icon>
                    
            </div>
            <div class="name-car">
            `+data.model+`&nbsp;( `+data.plate+` )
            </div>
            <div class="engin">
                <div class="text-engin">
                    <i class='bx bxs-car-mechanic' ></i>&nbsp;ENGIN
                </div>
                <div class="box-percent-engin">
                    <div class="load-engin" id="loadengin"></div>
                </div>
                <div class="percent-engin">
                `+(data.engine/10)+` %
                </div>
            </div>
            <div class="fuel">
                <div class="text-fuel">
                    <ion-icon name="water"></ion-icon>&nbsp;FUEL
                </div>
                <div class="box-percent-fuel">
                    <div class="load-fuel" id="loadfuel"></div>
                </div>
                <div class="percent-fuel">
                 `+fuel+` %
                </div>
            </div>
            <div class="confrim_pound" onclick="mar('`+data.plate2+`', '`+data.super+`')">
                Pound &nbsp;<ion-icon name="arrow-down-circle"></ion-icon>
            </div>
        </div>


            `);
        } if (data.garage == "police") {
            $(".box-itemlist").prepend(`


  
           
            <div class="itemlist">
            <div class="logo-car">
                <ion-icon name="car-sport" class="ic-car"></ion-icon>
                    
            </div>
            <div class="name-car">
            `+data.model+`&nbsp;( `+data.plate+` )
            </div>
            <div class="engin">
                <div class="text-engin">
                    <i class='bx bxs-car-mechanic' ></i>&nbsp;ENGIN
                </div>
                <div class="box-percent-engin">
                    <div class="load-engin" id="loadengin"></div>
                </div>
                <div class="percent-engin">
                `+(data.engine/10)+` %
                </div>
            </div>
            <div class="fuel">
                <div class="text-fuel">
                    <ion-icon name="water"></ion-icon>&nbsp;FUEL
                </div>
                <div class="box-percent-fuel">
                    <div class="load-fuel" id="loadfuel"></div>
                </div>
                <div class="percent-fuel">
                 `+fuel+` %
                </div>
            </div>
            <div class="confrim" onclick="tar('`+data.plate2+`', '`+data.super+`')">
                เบิกรถ&nbsp;<ion-icon name="arrow-down-circle"></ion-icon>
            </div>
            <div class="confrim-trunk" onclick="openetrunk('`+ data.plate2 + `', '` + data.super +`')">
                เปิดหลังรถ&nbsp;<ion-icon name="arrow-down-circle"></ion-icon>
            </div>
        </div>

            `);
        } if (data.garage == "ambulance") {
            $(".box-itemlist").prepend(`
        


            
            <div class="itemlist">
            <div class="logo-car">
                <ion-icon name="car-sport" class="ic-car"></ion-icon>
                    
            </div>
            <div class="name-car">
            `+data.model+`&nbsp;( `+data.plate+` )
            </div>
            <div class="engin">
                <div class="text-engin">
                    <i class='bx bxs-car-mechanic' ></i>&nbsp;ENGIN
                </div>
                <div class="box-percent-engin">
                    <div class="load-engin" id="loadengin"></div>
                </div>
                <div class="percent-engin">
                `+(data.engine/10)+` %
                </div>
            </div>
            <div class="fuel">
                <div class="text-fuel">
                    <ion-icon name="water"></ion-icon>&nbsp;FUEL
                </div>
                <div class="box-percent-fuel">
                    <div class="load-fuel" id="loadfuel"></div>
                </div>
                <div class="percent-fuel">
                 `+fuel+` %
                </div>
            </div>
            <div class="confrim" onclick="yar('`+data.plate2+`', '`+data.super+`')">
                เบิกรถ&nbsp;<ion-icon name="arrow-down-circle"></ion-icon>
            </div>
            <div class="confrim-trunk" onclick="openetrunk('`+ data.plate2 + `', '` + data.super +`')">
                เปิดหลังรถ&nbsp;<ion-icon name="arrow-down-circle"></ion-icon>
            </div>
        </div>

            `);
        }
        $("#loadengin").css("width", data.engine/10 + "%");
        $("#loadfuel").css("width", data.fuel + "%");
    }
});