var canSelect = true

window.addEventListener('message', function(event) {
	data = event.data;
   
    $("#item-pic").empty();
    $(".text-time").html(data.getitem + " sec");

    $(".text-countitem").html(data.countitem);
    $(".text-y").html(data.removeitem);
    $(".text-b").html(data.fishingrod);
    $(".text-p").html(data.PercentMain);

    
    // $("#item-pic").attr(
    //   "src",
    //   `nui://Fewthz_inventory/html/img/items/${data.countitem}.png`
    // );

    
    switch (data.action) {
        case 'OpenMenu':
            $("body").fadeIn(500)
            // ess(data.getitemtime);
        break
        case 'CloseMenu':
            $("body").fadeOut(500)
            
        break
        
    }

    
});