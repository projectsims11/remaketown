
var sb = document.getElementById("click-sound");
sb.volume = 0.5;

window.addEventListener('message', function(event) {

    var data = event.data;

    switch (event.data.action) {

        case 'OpenPilot':
            $('.con-box').css('display', 'block')
            $('.con-box').fadeIn(200).addClass('scale-up-center')
            $('.con-box').fadeIn(200).removeClass('scale-up-ver-center')
        break;

        case 'ClosePilot':
            $('.con-box').fadeOut(500).addClass('scale-up-ver-center')
        break;

    }
})
    /* ปุ่ม เปลี่ยนธีม */

    $("#moon").click(function(){
      sb.play();
        $('.body-box').css('background-color', 'rgba(0, 0, 0, 0.87)')
        $('.btn-box').css('background-color', 'rgba(99, 96, 96, 0.856)') 
        $('#moon').css('display', 'none')
        $('#sun').css('display', 'block')
        ChangColorDark();
	});

    $("#sun").click(function(){
      sb.play();
        $('.body-box').css('background-color', 'white')
        $('.btn-box').css('background-color', 'rgba(0, 0, 0, 0.87)') 
        $('#sun').css('display', 'none')
        $('#moon').css('display', 'block')
        ChangColorWhite()
	});

      // ธีมมืด
    function ChangColorDark() {
        $("#b1").mouseenter(function(){
            $('#b1').css('background-color', 'rgb(23, 184, 31)') 
        });
        $("#b1").mouseleave(function(){
            $('#b1').css('background-color', 'rgba(99, 96, 96, 0.856)') 
        });

        // 

        $("#b2").mouseenter(function(){
            $('#b2').css('background-color', 'rgb(184, 23, 23)') 
        });
        $("#b2").mouseleave(function(){
            $('#b2').css('background-color', 'rgba(99, 96, 96, 0.856)') 
        });

        // 

        $("#b3").mouseenter(function(){
            $('#b3').css('background-color', 'rgb(32, 155, 192)') 
        });
        $("#b3").mouseleave(function(){
            $('#b3').css('background-color', 'rgba(99, 96, 96, 0.856)') 
        });

        // 

        $("#b4").mouseenter(function(){
            $('#b4').css('background-color', 'rgb(184, 141, 23)') 
        });
        $("#b4").mouseleave(function(){
            $('#b4').css('background-color', 'rgba(99, 96, 96, 0.856)') 
        });


	}


    // ธีมสว่าง

    function ChangColorWhite() {

        $("#b1").mouseenter(function(){
            $('#b1').css('background-color', 'rgb(23, 184, 31)') 
        });
        $("#b1").mouseleave(function(){
            $('#b1').css('background-color', 'rgba(0, 0, 0, 0.87)') 
        });


        $("#b2").mouseenter(function(){
            $('#b2').css('background-color', 'rgb(184, 23, 23)') 
        });
        $("#b2").mouseleave(function(){
            $('#b2').css('background-color', 'rgba(0, 0, 0, 0.87)') 
        });

        // 

        $("#b3").mouseenter(function(){
            $('#b3').css('background-color', 'rgb(32, 155, 192)') 
        });
        $("#b3").mouseleave(function(){
            $('#b3').css('background-color', 'rgba(0, 0, 0, 0.87)') 
        });

        // 

        $("#b4").mouseenter(function(){
            $('#b4').css('background-color', 'rgb(184, 141, 23)') 
        });
        $("#b4").mouseleave(function(){
            $('#b4').css('background-color', 'rgba(0, 0, 0, 0.87)') 
        });

	}

    function CLPL() {
        $.post('https://FewZ_Autopilot/ClosePL');
        return;
    }

    /* ปุ่ม Start */

    $("#b1").click(function(){
      sb.play();
      $.post('https://FewZ_Autopilot/pilot');
      $('.btn-box').css('left', '12%') 
      $('#b3').show()
      $('#b4').show()
      CLPL();
    });
    

    /* ปุ่ม Stop */

    $("#b2").click(function(){
        $.post('https://FewZ_Autopilot/stoppilot');
        $('#b3').hide()
        $('#b4').hide()
        $('.btn-box').css('left', '35%') 
        CLPL();
    });
    

    /* ปุ่ม Speed Down */

    $("#b3").click(function(){
      sb.play();
      $.post('https://FewZ_Autopilot/speeddown');
      CLPL();
    });


    /* ปุ่ม Speed Up */

    $("#b4").click(function(){
      sb.play();
      $.post('https://FewZ_Autopilot/speedup');
      CLPL();
    });
        
    

	document.onkeyup = function (data) {
		if (data.which == 27) {
			$.post('https://FewZ_Autopilot/ClosePL');
			return;
		} 
	};




