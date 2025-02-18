window.addEventListener("message", function (event) {
  var item = event.data;

  const audio = new Audio();
  audio.src = "sounds/audio.mp3";
  audio.volume = 0.7

  if (item !== undefined) {
    if (item.type == "ui") {
      if (item.display == true) {
        $("#body").fadeIn(200);
        audio.play();
      } else {
        $("#body").fadeOut(200);
      }
    } else if (item.type == "update") {
      /* by DEV */
      if (item.my_id != undefined) {
        $("#Id").html('ID : ' + item.my_id);
      }
      if (item.my_name != undefined) {
        $("#PlayerName").html(': ' + item.my_name);
      }
      if (item.my_job != undefined) {
        $("#PlayerJob").html(': ' + item.my_job);
      }
      if (item.my_job_label != undefined) {
        $("#PlayerJobLabel").html(': ' + item.my_job_label);
      }
      if (item.my_phone != undefined) {
        $("#PlayerPhone").html(': ' + item.my_phone);
      }
      if (item.my_ping != undefined) {
        $("#PlayerPing").html('PING : ' + item.my_ping);
      }
      if (item.players != undefined) {
        $("#PlayerOnline").html('PLAYERS : ' + item.players);
      }
      if (item.police != undefined) {
        $("#PoliceOnline").html(item.police);
      }
      if (item.ems != undefined) {
        $("#DoctorOnline").html(item.ems);
      }
      if (item.mechanic != undefined) {
        $("#MechanicOnline").html(item.mechanic);
      }
      if (item.council != undefined) {
        $("#CouncilOnline").html(item.council);
      }
      /* by DEV */
    } else if (item.type == "SetDiscordImg") {
      $("#Profile-Player").attr("src", item.avatar);
    }

    if (item.display == true) {
      var xhr = new XMLHttpRequest();
      xhr.responseType = "text";
      xhr.open('GET', event.data.steamid, true);
      xhr.send();
      xhr.onreadystatechange = processRequest;

      function processRequest(e) {
        if (xhr.readyState == 4 && xhr.status == 200) {
          var string = xhr.responseText.toString();
          var array = string.split("avatarfull");
          var array2 = array[1].toString().split('"');
          $('#Profile-Player').attr('src', array2[2].toString());
        }
      }
    }

  }
});

let dateToday = document.getElementById("calendar");
let today = new Date();
let day = `${today.getDate() < 10 ? "0" : ""}${today.getDate()}`;

let month = `${(today.getMonth() + 1) < 10 ? "0" : ""}${today.getMonth() + 1}`;
let year = today.getFullYear();

dateToday.textContent = `${day}/${month}/${year}`;

function checkTime(i) {
  if (i < 10) {
    i = "0" + i;
  }
  return i;
}

function startTime() {
  var today = new Date();
  var h = today.getHours();
  var m = today.getMinutes();
  var s = today.getSeconds();
  m = checkTime(m);
  s = checkTime(s);
  document.getElementById('time').textContent = `${h}:${m}`;
  t = setTimeout(function () {
    startTime()
  }, 500);
}
startTime();