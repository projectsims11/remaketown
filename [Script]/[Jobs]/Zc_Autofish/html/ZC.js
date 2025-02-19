function pad (str) {
  str = str.toString();
  return str.length < 2 ? pad("0" + str, 2) : str;
}
$(function () {
  window.addEventListener("message", function (event) {
    var item = event.data;
    if (item !== undefined) {
      if (item.id !== undefined) {
        $("#myid").html(item.id)
      }
      if (item.gray !== undefined) {
        if(item.graytype.toUpperCase() == 'Q'){
          $('#buttonQtext').css('opacity', item.gray);
        }else if(item.graytype.toUpperCase() == 'R'){
          $('#buttonRtext').css('opacity', item.gray);
        }else if(item.graytype.toUpperCase() == 'X'){
          $('#buttonXtext').css('opacity', item.gray);
        }else if(item.graytype.toUpperCase() == 'G'){
          $('#buttonGtext').css('opacity', item.gray);
        }else if(item.graytype.toUpperCase() == 'ENTER'){
          $('#buttonEntertext').css('opacity', item.gray);
        }
      }
      if (item.type !== undefined) {
        var minutes = pad(Math.floor(item.time / 60));
        var seconds = pad(item.time - minutes * 60);
        var _thistime = minutes + ":" +seconds
        if (item.type) {
         // $('body').css("background-color", "#00000060");
          $("#time").html(_thistime)
          $("#main2")
          .animate({ "opacity": "1.0" }, "slow");
          $("#main1")
          .animate({ "margin-bottom": "0%" }, "slow");
        } else {
        //  $('body').css("background-color", "#00000000");
          $("#time").html(_thistime)
          $("#main2")
          .animate({ "opacity": "0.0" }, "slow");
          $("#main1")
          .animate({ "margin-bottom": "-10%" }, "slow");
        }
      }

    }
  });
});
