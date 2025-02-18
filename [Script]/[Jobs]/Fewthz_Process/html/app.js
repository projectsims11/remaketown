$("document").ready(function () {
  window.addEventListener("message", function (event) {
    var e = event.data;
    let configurl = e.texturl;
  	result = configurl;
    switch (e.action) {
      case "Start_Process":
        // ess(e.duration);
        $("#pic-pro-1").empty();
        $("#pic-pro-2").empty();
        $("#item-pro-1").empty();
        $("#item-pro-2").empty();
        $("#val-pro-1").empty();
        $("#val-pro-2").empty();
        $("#sp-pro").empty();
        $(".dev-process-container").fadeIn(1000);

        $("#pic-pro-1").attr(
          "src",
          `${result}${e.itemone}.png`
        );
        $("#pic-pro-2").attr(
          "src",
          `${result}${e.itemtwo}.png`
        );
        $("#item-pro-1").text(e.textone);
        $("#item-pro-2").text(e.texttwo);
        $("#val-pro-1").text(e.itemoneneed);
        $("#val-pro-2").text(`จำนวน x ${e.itemtwogive}`);

        if (e.bonus.length > 0) {
          e.bonus?.map((index, val) => {
            $("#sp-pro").append(`
                <img src="${result}${index.itemname}.png" width="40" height="40">
            `);
          });
        }

        break;
      case "Process_Cancel":
        $(".dev-process-container").fadeOut(1000);
        $("#sp-pro").empty();
        break;
    }
    document.onkeyup = function (data) {
      if (data.which == 88) {
        $.post("https://Fewthz_Process/Exit", JSON.stringify({}));
        return;
      }
    };
  });
});

function ess(du) {
  var hp = 0;
  var id = setInterval(frame, du / 100);
  function frame() {
    if (hp === 100) {
      clearInterval(id);
      hp = 0;
    } else {
      hp = hp + 1;
      $(".dev-job-progress").css("width", hp + "%");
    }
  }
}
