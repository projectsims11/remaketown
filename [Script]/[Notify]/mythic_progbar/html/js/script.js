$("document").ready(function () {
    MythicProgBar = {};
    MythicProgBar.Progress = function (ruchie) {
      $(".progress-container").css({display: "block"});
      $("#progress-bar").stop().css({width: 0, "background-color": "#ffbb00"}).animate({width: "100%"}, {duration: parseInt(ruchie.duration), complete: function () {
        $(".progress-container").css({display: "none"});
        $("#progress-bar").css("width", 0);
        $.post("http://mythic_progbar/actionFinish", JSON.stringify({}));
      }});
    };
    MythicProgBar.ProgressCancel = function () {
      $(".progress-container").css({display: "block"});
      $("#progress-bar").stop().css({width: "100%", "background-color": "#ffbb00"});
      setTimeout(function () {
        $(".progress-container").css({display: "none"});
        $("#progress-bar").css("width", 0);
        $.post("http://mythic_progbar/actionCancel", JSON.stringify({}));
      }, 1e3);
    };
    MythicProgBar.CloseUI = function () {
      $(".main-container").css({display: "none"});
      $(".character-box").removeClass("active-char");
      $(".character-box").attr("data-ischar", "false");
      $("#delete").css({display: "none"});
    };
    window.addEventListener("message", function (chico) {
      switch (chico.data.action) {
        case "mythic_progress":
          MythicProgBar.Progress(chico.data);
          break;
        case "mythic_progress_cancel":
          MythicProgBar.ProgressCancel();
          break;
      }
    });
  });
  