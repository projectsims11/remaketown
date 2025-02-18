const audio2 = new Audio();
    window.addEventListener("message", function (event) {
        if (event.data.type==='carhud'){
            $('.speed').html(event.data.kmh)
                $('.gear').html(event.data.gear)
                if (event.data.rpm == undefined){
                    $('.rpmText').html(`RPM 0`)
                    $('.loadrpm').css('width', '0')
                }
                else{
                    $('.loadrpm').css('width', event.data.rpmPercent+'%')
                    $('.rpmText').html(`RPM ${event.data.rpm}000`)
                }     
                // $('.loadrpm').css('width', event.data.rpmPercent)
                $('#fuel').css('height',event.data.fuel+'%')
                $('#health-car').css('height',event.data.carfix+'%')
                
                if(event.data.cartype=='moto'){
                    document.getElementById("typeCar").src=`img/${event.data.cartype}.png`
                    $("#typeCar").css('width','70px')
                    $("#typeCar").css('top','24px')
                    $(".whell-all").hide()
                }
                else if(event.data.cartype=='car'){
                    document.getElementById("typeCar").src=`img/${event.data.cartype}.png`
                    $("#typeCar").css('width','45px')
                    $("#typeCar").css('top','10px')
                    $(".whell-all").show()
                }
                else if(event.data.cartype=='air'){
                    document.getElementById("typeCar").src=`img/${event.data.cartype}.png`
                    $("#typeCar").css('width','56px')
                    $("#typeCar").css('top','13px')
                    $(".whell-all").hide()
                }
                else if(event.data.cartype=='boat'){
                    document.getElementById("typeCar").src=`img/${event.data.cartype}.png`
                    $("#typeCar").css('width','50px')
                    $("#typeCar").css('top','13px')
                    $(".whell-all").hide()
                }
                else if(event.data.cartype=='hall'){
                    document.getElementById("typeCar").src=`img/${event.data.cartype}.png`
                    $("#typeCar").css('width','75px')
                    $("#typeCar").css('top','23px')
                    $(".whell-all").hide()
                }
                if(event.data.wheel_fl == true){
                    $('#lf').addClass('active')
                }
                else {
                    $('#lf').removeClass('active')
                }
                if(event.data.wheel_fr == true){
                    $('#rf').addClass('active')
                }
                else {
                    $('#rf').removeClass('active')
                }
                if(event.data.wheel_bl == true){
                    $('#lb').addClass('active')
                }
                else {
                    $('#lb').removeClass('active')
                }
                if(event.data.wheel_br == true){
                    $('#rb').addClass('active')
                }
                else {
                    $('#rb').removeClass('active')
                }
                if(event.data.doorlock == 1){
                    $('#lock').css('color','rgb(96, 97, 97)')
                }
                else if(event.data.doorlock == undefined){
                    $('#lock').css('color','rgb(96, 97, 97)')
                }
                else{
                    $('#lock').css('color','rgb(25, 142, 252')

                }
                if(event.data.belt == false){
                    const audio = new Audio();
                    audio2.pause()
                    audio.src = "./sounds/buckle.ogg";
                    audio.play()
                    audio.volume = 0.2;
                    
                    document.getElementById("belt").src=`img/belt_active.png`
                }
                else if (event.data.belt == true){
                    const audio = new Audio();
                    audio2.pause()
                    audio.src = "./sounds/unbuckle.ogg";
                    audio.play()
                    audio.volume = 0.2;
                    document.getElementById("belt").src=`img/belt.png`
                }
                else if (event.data.belt == 'alert') {               
                    const audio = new Audio();
                        audio.src = "./sounds/seatbelt.ogg";
                        audio.play()
                        audio.volume = 0.1;
                }
                if(event.data.light == 1){
                    
                    document.getElementById("light").src=`img/light_2.png`
                }
                else{
                    document.getElementById("light").src=`img/light_1.png`
                }
            if (event.data.displayCarhud === true){
                $('.car-container').css('animation','carhudIn .5s forwards')
                $('.health').css('animation','leftIn .5s .4s forwards')
                $('.healthLine').css('animation','leftIn2 .5s .4s forwards')
                $('.fuel').css('animation','rightIn .5s .4s forwards')
                $('.fuelLine').css('animation','rightIn2 .5s .4s forwards')
            
            }
            else if (event.data.displayCarhud === false){
                $('.car-container').css('animation','carhudOut .5s forwards')
                $('.health').css('animation','carhudOut .5s forwards')
                $('.healthLine').css('animation','carhudOut .5s forwards')
                $('.fuel').css('animation','carhudOut .5s forwards')
                $('.fuelLine').css('animation','carhudOut .5s forwards')
            
                $('.shortcut').css('animation','menuOut .7s forwards')
            }
          
        }
        // else {
        //     audio.pause()
        // }
        if (event.data.type === 'menucar'){
            if (event.data.displayMenucar == true ){
                $('.shortcut').css('animation','menuIn .7s forwards')
            }
            else {
                $('.shortcut').css('animation','menuOut .7s forwards')
            }
        }
    })

function enginecontrol(){
    $.post('http://FewZ_Carhud/menuget', JSON.stringify({
            name:"engine"
    }));   
}
function chaircontrol(number){
    $.post('http://FewZ_Carhud/menuget', JSON.stringify({
            name:"chair",
            num:number
    }));   
}
function doorcontrol(number){
    $.post('http://FewZ_Carhud/menuget', JSON.stringify({
            name:"door",
            num:number
    }));   
}
// })


    function hexPercent(percent){
	
		$('#hungy').css('stroke-dashoffset',  ((percent) / 100)* 2160);
	};
