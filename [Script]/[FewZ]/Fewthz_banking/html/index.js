var audio3 = new Audio('j.wav');
audio3.volume = 0.8;

$(function () {
    // function - Display เปิดปิดเมนู
    function display(bool) {        
        if (bool) {
            // $("body").show();
            $("body").addClass("show");
            // $(".body").addClass("show");
            audio3.play();
        } else {
            $("body").removeClass("show");
            // $("body").hide();
        }
 
    }
    display(false)
    // function - Display เปิดปิดเมนู

    $(function() {
        window.addEventListener('message', function(event) {
            if (event.data.type === "openGeneral"){
                $('#body').show();
            } else if(event.data.type === "ui") {
                    $('.username2').html(event.data.playerid);
                    $(".username1").html(event.data.player);
            } else if (event.data.type === "closeAll"){

            }
        });
    });
    



    window.addEventListener('message', function(event) {
        
        var item = event.data;

        // function - Display เปิดปิดเมนู
        if (item.type === "ui") {
            audio3.play();
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }
        // function - Display เปิดปิดเมนู


        $("#logo").css("background", "url(" + item.logo + ") center center no-repeat" )
        $("#logo").css("background-size", "cover" )
        
        if (item.type === "update") {
            $("#moneyAmount").html(item.money.toLocaleString() + " $")
            $("#monneyacount").html(item.monneyacount.toLocaleString() + " $")
        }

    })
    // Ui Callback -> Lua.
    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('http://Fewthz_banking/exit', JSON.stringify({}));  
            return
        }
    };


    $("#close").click(function () {
        $.post('http://Fewthz_banking/exit', JSON.stringify({})); 
        return
    })
    // Ui Callback -> Lua.    


    $("#completeWithdrawButton").click(function () {
        var withdrawInput = $('#withdrawInput').val();
        if (withdrawInput.length > 0) {
            $.post('http://Fewthz_banking/withdrawl', JSON.stringify({
                withdrawl: withdrawInput,
            }));
            document.getElementById('withdrawInput').value = ''
        }  
    });
    $("#completeDepositButton").click(function () {
        var depositInput = $('#depositInput').val();
        if (depositInput.length > 0) {
            $.post('http://Fewthz_banking/deposit', JSON.stringify({
                amountw: depositInput,
            }));
            document.getElementById('depositInput').value = ''
        }
    });
    $("#completeTransferButton").click(function () {
        var transferAmountInput = $('#transferAmountInput').val();
        var transferIdInput = $('#transferIdInput').val();
        if (transferAmountInput.length > 0) {

            if (transferIdInput.length > 0) {
                $.post('http://Fewthz_banking/transfer', JSON.stringify({
                    transferAmountInput: transferAmountInput,
                    transferIdInput: transferIdInput,
                }));
            }
            document.getElementById('transferIdInput').value = ''
            
        }
        function processRequest(e) {
            if (sek.readyState == 4 && sek.status == 200) {
                var string = sek.responseText.toString();
                var array = string.split("avatarfull");
                var array2 = array[1].toString().split('"');
                $('#avatar').attr('src', array2[2].toString());
            }
        }

    });
    
})
