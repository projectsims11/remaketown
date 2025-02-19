
responsivescreen = () => {
  let innerWidth = window.innerWidth;
  let baseWidth = 1920;
  $(".hud").css("zoom", ((innerWidth / baseWidth) * 100) / 100);
};
window.addEventListener("resize", responsivescreen);

window.addEventListener("message", function (e) {
  switch(e.data.action) {
    case "open":
      $("body").show();
      $(".set").removeClass("openr").addClass("open");
      $(".left").removeClass("openleftr").addClass("openleft");
      $(".right").removeClass("openrightr").addClass("openright");
      $(".c-set").removeClass("c-setopenr").addClass("c-setopen");
      $(".logo").removeClass("openlogor").addClass("openlogo");
    break;

    case "close":
      // $(".hud").addClass("openr").removeClass("open");
      // $(".left").addClass("openleftr").removeClass("openleft");
      // $(".right").addClass("openrightr").removeClass("openright");
      // $(".c-set").addClass("c-setopenr").removeClass("c-setopen");
      // $(".logo").addClass("openlogor").removeClass("openlogo");
      $("body").fadeOut();
      $("#belt-sound")[0].pause();
      $("#belt-sound")[0].currentTime = 0;
    break;

    case "update":
      calculate.rpm(e.data.data.rpm);
      calculate.car(e.data.data.car);
      calculate.IsCar(e.data.data.IsCar);
      calculate.fuel(e.data.data.fuel);
      calculate.engine(e.data.data.engine);
      calculate.belt(e.data.data.isBelt);
      calculate.locked(e.data.data.isLocked);
      calculate.type(e.data.data.type);
      calculate.pauseMenu(e.data.data.pauseMenu);
      // calculate.wheel(e.data.data.wheel1, e.data.data.wheel2, e.data.data.wheel3, e.data.data.wheel4);
      calculate.treeDx(e.data.data.steering);
      $("#kmh").html(e.data.data.speed);
      $("#num-gear").html(e.data.data.gear==0 ? "R" : e.data.data.gear);

      if (e.data.data.type == 0) {
        if (e.data.data.wheel1 == 0) {
          $("#wheel").attr("src", "img/wheel.png");
        } else if (e.data.data.wheel1 == 1) {
          $("#wheel").attr("src", "img/wheel_pink.png");
        } else if (e.data.data.wheel1 == 2) {
          $("#wheel").attr("src", "img/wheel_red.png");
        }
      
        if (e.data.data.wheel2 == 0) {
          $("#wheel2").attr("src", "img/wheel4.png");
        } else if (e.data.data.wheel2 == 1) {
          $("#wheel2").attr("src", "img/wheel_pink4.png");
        } else if (e.data.data.wheel2 == 2) {
          $("#wheel2").attr("src", "img/wheel_red4.png");
        }
      
        if (e.data.data.wheel3 == 0) {
          $("#wheel3").attr("src", "img/wheel2.png");
        } else if (e.data.data.wheel3 == 1) {
          $("#wheel3").attr("src", "img/wheel_pink2.png");
        } else if (e.data.data.wheel3 == 2) {
          $("#wheel3").attr("src", "img/wheel_red2.png");
        }
      
        if (e.data.data.wheel4 == 0) {
          $("#wheel4").attr("src", "img/wheel3.png");
        } else if (e.data.data.wheel4 == 1) {
          $("#wheel4").attr("src", "img/wheel_pink3.png");
        } else if (e.data.data.wheel4 == 2) {
          $("#wheel4").attr("src", "img/wheel_red3.png");
        }

      } else if (e.data.data.type == 1) {
        
        if (e.data.data.wheel3 == 0) {
          $("#wheel3").attr("src", "img/bike_wheel2.png");
        } else if (e.data.data.wheel3 == 1) {
          $("#wheel3").attr("src", "img/bike_wheel2_pink.png");
        } else if (e.data.data.wheel3 == 2) {
          $("#wheel3").attr("src", "img/bike_wheel2_red.png");
        }

        if (e.data.data.wheel1 == 0) {
          $("#wheel").attr("src", "img/bike_wheel.png");
        } else if (e.data.data.wheel1 == 1) {
          $("#wheel").attr("src", "img/bike_wheel_pink.png");
        } else if (e.data.data.wheel1 == 2) {
          $("#wheel").attr("src", "img/bike_wheel_red.png");
        }

      }

    break;

    case "playSound":
      playsound(e.data.sound, e.data.volume);
    break;

    case "panel":
      $(".top-panel").fadeIn()
    break;

    case "panel-status":
      if(e.data.frontHood){
        $('.frontHood').css('background-color','rgba(197,116,0,1)')
      }else{
        $('.frontHood').css('background-color','rgb(75, 75, 75)')
      }
      if(e.data.windowFrontLeft){
        $('.windowFrontLeft').css('background-color','rgba(197,116,0,1)')
      }else{
        $('.windowFrontLeft').css('background-color','rgb(75, 75, 75)')
      }
      if(e.data.doorFrontLeft){
        $('.doorFrontLeft').css('background-color','rgba(197,116,0,1)')
      }else{
        $('.doorFrontLeft').css('background-color','rgb(75, 75, 75)')
      }
      if(e.data.seatFrontLeft){
        $('.seatFrontLeft').css('background-color','rgba(197,116,0,1)')
      }else{
        $('.seatFrontLeft').css('background-color','rgb(75, 75, 75)')
      }
      if(e.data.seatFrontRight){
        $('.seatFrontRight').css('background-color','rgba(197,116,0,1)')
      }else{
        $('.seatFrontRight').css('background-color','rgb(75, 75, 75)')
      }
      if(e.data.doorFrontRight){
        $('.doorFrontRight').css('background-color','rgba(197,116,0,1)')
      }else{
        $('.doorFrontRight').css('background-color','rgb(75, 75, 75)')
      }
      if(e.data.windowFrontRight){
        $('.windowFrontRight').css('background-color','rgba(197,116,0,1)')
      }else{
        $('.windowFrontRight').css('background-color','rgb(75, 75, 75)')
      }
      if(e.data.interiorLight){
        $('.interiorLight').css('background-color','rgba(197,116,0,1)')
      }else{
        $('.interiorLight').css('background-color','rgb(75, 75, 75)')
      }
      if(e.data.rearHood){
        $('.rearHood').css('background-color','rgba(197,116,0,1)')
      }else{
        $('.rearHood').css('background-color','rgb(75, 75, 75)')
      }
      if(e.data.windowRearLeft){
        $('.windowRearLeft').css('background-color','rgba(197,116,0,1)')
      }else{
        $('.windowRearLeft').css('background-color','rgb(75, 75, 75)')
      }
      if(e.data.doorRearLeft){
        $('.doorRearLeft').css('background-color','rgba(197,116,0,1)')
      }else{
        $('.doorRearLeft').css('background-color','rgb(75, 75, 75)')
      }
      if(e.data.seatRearLeft){
        $('.seatRearLeft').css('background-color','rgba(197,116,0,1)')
      }else{
        $('.seatRearLeft').css('background-color','rgb(75, 75, 75)')
      }
      if(e.data.seatRearRight){
        $('.seatRearRight').css('background-color','rgba(197,116,0,1)')
      }else{
        $('.seatRearRight').css('background-color','rgb(75, 75, 75)')
      }
      if(e.data.doorRearRight){
        $('.doorRearRight').css('background-color','rgba(197,116,0,1)')
      }else{
        $('.doorRearRight').css('background-color','rgb(75, 75, 75)')
      }
      if(e.data.windowRearRight){
        $('.windowRearRight').css('background-color','rgba(197,116,0,1)')
      }else{
        $('.windowRearRight').css('background-color','rgb(75, 75, 75)')
      }
      if(e.data.rearHood2){
        $('.rearHood2').css('background-color','rgba(197,116,0,1)')
      }else{
        $('.rearHood2').css('background-color','rgb(75, 75, 75)')
      }
      if(e.data.ignition){
        $('.ignition').css('background-color','rgba(197,116,0,1)')
      }else{
        $('.ignition').css('background-color','rgb(75, 75, 75)')
      }
    break;
  }
});

document.onkeyup = function(data){
  if (data.which == 27){
    $('.top-panel').fadeOut()
    $.post(`https://${GetParentResourceName()}/NUIFocusOff`, JSON.stringify({}));
  }
}
$('#ignition').click(function(){
  $.post(`https://${GetParentResourceName()}/ignition`, JSON.stringify({}));
})
$('#frontHood').click(function(){
  $.post(`https://${GetParentResourceName()}/doors`, JSON.stringify({
    door: 4
  }));
})
$('#rearHood').click(function(){
  $.post(`https://${GetParentResourceName()}/doors`, JSON.stringify({
    door: 5
  }));
})
$('#rearHood2').click(function(){
  $.post(`https://${GetParentResourceName()}/doors`, JSON.stringify({
    door: 6
  }));
})
$('#interiorLight').click(function(){
  $.post(`https://${GetParentResourceName()}/interiorLight`, JSON.stringify({}));
})
$('#bombbay').click(function(){
  $.post(`https://${GetParentResourceName()}/bombbay`, JSON.stringify({}));
})
$('#windowFrontLeft').click(function(){
  $.post(`https://${GetParentResourceName()}/windows`, JSON.stringify({
    window: 0,
    door: 0
  }));
})
$('#doorFrontLeft').click(function(){
  $.post(`https://${GetParentResourceName()}/doors`, JSON.stringify({
    door: 0
  }));
})
$('#seatFrontLeft').click(function(){
  $.post(`https://${GetParentResourceName()}/seatchange`, JSON.stringify({
    seat: -1
  }));
})
$('#seatFrontRight').click(function(){
  $.post(`https://${GetParentResourceName()}/seatchange`, JSON.stringify({
    seat: 0,
  }));
})
$('#doorFrontRight').click(function(){
  $.post(`https://${GetParentResourceName()}/doors`, JSON.stringify({
    door: 1
  }));
})
$('#windowFrontRight').click(function(){
  $.post(`https://${GetParentResourceName()}/windows`, JSON.stringify({
    window: 1,
    door: 1
  }));
})
$('#windowRearLeft').click(function(){
  $.post(`https://${GetParentResourceName()}/windows`, JSON.stringify({
    window: 2,
    door: 2
  }));
})
$('#doorRearLeft').click(function(){
  $.post(`https://${GetParentResourceName()}/doors`, JSON.stringify({
    door: 2
  }));
})
$('#seatRearLeft').click(function(){
  $.post(`https://${GetParentResourceName()}/seatchange`, JSON.stringify({
    seat: 1,
  }));
})
$('#seatRearRight').click(function(){
  $.post(`https://${GetParentResourceName()}/seatchange`, JSON.stringify({
    seat: 2,
  }));
})
$('#doorRearRight').click(function(){
  $.post(`https://${GetParentResourceName()}/doors`, JSON.stringify({
    door: 3
  }));
})
$('#windowRearRight').click(function(){
  $.post(`https://${GetParentResourceName()}/windows`, JSON.stringify({
    window: 3,
    door: 3
  }));
})

function Progress(percent, element) {
  var circle = document.querySelector(element);
  var radius = circle.r.baseVal.value;
  var circumference = radius * 2 * Math.PI;

  circle.style.strokeDasharray = `${circumference} ${circumference}`;
  circle.style.strokeDashoffset = `${circumference}`;

  const offset = circumference - ((-percent * 100) / 100 / 100) * circumference;
  circle.style.strokeDashoffset = -offset;
}

playsound = function(filename, volume) {
  var xhr = new XMLHttpRequest();
  xhr.open("HEAD", `./sounds/${filename}`, false);
  xhr.send();

  if (xhr.status != "404") {
    var sound = new Audio('./sounds/' + filename);
    sound.volume = volume;
    sound.play();
  }
}