window.addEventListener("message", function(event){
    if (event.data.action == "getfuel") {
        $(".box_info").css({
            left: '1.5%',
            opacity: '1'
        });
        $(".status_fuel").css('width', event.data.fuel + "%");
        $(".carlos_coin").html(parseInt(event.data.money) + " .-");
    } else {
        $(".box_info").css({
            left: '-5%',
            opacity: '0'
        });
    };
});