let calculate = {}

calculate.rpm = function(rpmx) {
  $("#rpmxx").css("height", (rpmx)+"%");
  $("#rpmx").css("height", (rpmx)+"%");
  $('#Text-rpmx').html(Math.round(rpmx*100));
}

calculate.car = function(car) {
  if (car == "motorcycles") {
   $(".car").css("background-image", "url(/web/img/bike.png)");
  } else if (car == "car") {
    $(".car").css("background-image", "url(/web/img/car.png)");
  } else if (car == "boat") {
    $(".car").css("background-image", "url(/web/img/boat.png)");
  } else if (car == "Helicopters") {
    $(".car").css("background-image", "url(/web/img/heli.png)");
  } else if (car == "bike") {
    $(".car").css("background-image", "url(/web/img/jak.png)");
  }
  
}

calculate.IsCar = function(IsCar) {
 if (IsCar == false) {
  $("#belt").hide();
 } else {
  $("#belt").show();
 }
 
}

calculate.pauseMenu = function(pauseMenu) {
  if (pauseMenu == 0) {
    $(".container").fadeIn(300);
  } else {
    $(".container").fadeOut(300);
  }
}

calculate.fuel = function(fuel) {
  $("#fuel").css("height", (fuel)+"%");
  $('#Text-fuel').html(Math.round(fuel) +"%")
}

calculate.engine = function(engine) {
  $("#engine").css("height", (engine)+"%");
  $('#Text-engine').html(Math.round(engine) +"%")
}

calculate.belt = function(isBelt) {
  if (isBelt) {
    $("#belt").removeClass("pp");
    $("#belt-sound")[0].pause();
    $("#belt-sound")[0].currentTime = 0;
  } else {
    $("#belt").addClass("pp");
    $("#belt-sound")[0].play();
    $("#belt-sound")[0].volume = 0.1;
  }
}

calculate.locked = function(isLocked) {
  if (isLocked == 2) {
    $("#lock").removeClass("pp");
  } else {
    $("#lock").addClass("pp");
  }
}

calculate.treeDx = function(steering) {
  if (steering < -1) {
    $(".hud").removeClass("left-turn");
    $(".hud").addClass("right-turn");
  } else if (steering > 1) {
    $(".hud").removeClass("right-turn");
    $(".hud").addClass("left-turn");
  } else {
    $(".hud").removeClass("left-turn");
    $(".hud").removeClass("right-turn");
  }
}

calculate.type = function(type) {  
  if (type == 1) {
    $("#wheel").show();
    $("#wheel2").hide();
    $("#wheel3").show();
    $("#wheel4").hide();
    $("#belt-sound")[0].pause();
  } else if (type == 4) {
    $("#wheel").hide();
    $("#wheel2").hide();
    $("#wheel3").hide();
    $("#wheel4").hide();
    $("#belt-sound")[0].pause();
  } else if (type == 2) {
    $("#wheel").hide();
    $("#wheel2").hide();
    $("#wheel3").hide();
    $("#wheel4").hide();
    $("#belt-sound")[0].pause();
  } else if (type == 3) {
    $("#wheel").hide();
    $("#wheel2").hide();
    $("#wheel3").hide();
    $("#wheel4").hide();
    $("#belt-sound")[0].pause();
  } else {
    $("#wheel").show();
    $("#wheel2").show();
    $("#wheel3").show();
    $("#wheel4").show();
  }
}

// calculate.wheel = function(wheel1, wheel2, wheel3, wheel4) {
//   if (wheel1 == 0) {
//     $("#wheel").attr("src", "img/wheel.png");
//   } else if (wheel1 == 1) {
//     $("#wheel").attr("src", "img/wheel_pink.png");
//   } else if (wheel1 == 2) {
//     $("#wheel").attr("src", "img/wheel_red.png");
//   }

//   if (wheel2 == 0) {
//     $("#wheel2").attr("src", "img/wheel4.png");
//   } else if (wheel2 == 1) {
//     $("#wheel2").attr("src", "img/wheel_pink4.png");
//   } else if (wheel2 == 2) {
//     $("#wheel2").attr("src", "img/wheel_red4.png");
//   }

//   if (wheel3 == 0) {
//     $("#wheel3").attr("src", "img/wheel2.png");
//   } else if (wheel3 == 1) {
//     $("#wheel3").attr("src", "img/wheel_pink2.png");
//   } else if (wheel3 == 2) {
//     $("#wheel3").attr("src", "img/wheel_red2.png");
//   }

//   if (wheel4 == 0) {
//     $("#wheel4").attr("src", "img/wheel3.png");
//   } else if (wheel4 == 1) {
//     $("#wheel4").attr("src", "img/wheel_pink3.png");
//   } else if (wheel4 == 2) {
//     $("#wheel4").attr("src", "img/wheel_red3.png");
//   }
// }