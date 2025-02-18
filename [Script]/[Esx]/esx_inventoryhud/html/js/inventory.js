
var type = "normal";
var CatagoryItem = ["FAVORITE", []]
var disabled = false;
var openMenu = false;
var PutGetitem = false;
var disabledFunction = null;
var defaultsoundvolume = 0.1;
let cacheSlot = null;
var type_value = 'inventory_all';
var type_value2 = "inventory_all";
var oldClass = '[data-category="' + type_value + '"]';
var player;
var PFitemData;
var PfDialogType;
var isModalOpen = false;
var no_drop = false;
var CONFIG = [];
var entercount = 0

var Config = new Object();
Config.closeKeys = [27];


$("body").on("keyup", function (key) {
    // $(".body").removeClass('opClass');
    if (Config.closeKeys.includes(key.which)) {
        if (dialog == true) {
             $(".box-container-give").fadeOut(20);
            $(".content-second").removeClass("blur")
            $(".content-player").removeClass("blur")
            // $(".container-pay").empty();
            dialog = false
        } else {
            closeInventory();
        }
    }
});




function closeInventory() {
    $.post("http://Fxw_inventory/NUIFocusOff", JSON.stringify({
        type: type
    }));
}




// $("body").on("keyup", function (key) {

//     if (Config.closeKeys.includes(key.which)) {
//         closeInventory();

//     }
// });

// const audioout = new Audio();
// audioout.src = "./sound/action.ogg";
// audioout.volume = 0.02;

// var invenhover = new Audio("./sound/hover.mp3");

// const invenhover = new Audio();
// invenhover.src = "./sound/hover.mp3";
// invenhover.play()
// invenhover.volume = 0.1;



dialog = false


window.addEventListener("message", function (event) {
    const data = event.data;

    if (event.data.action == "display") {
        type = event.data.type;
        disabled = false;
        if (type === "normal") {


            const audio = new Audio();
            audio.src = "./sound/Open.mp3";
            audio.play()
            audio.volume = 0.1;
            $(".inventory").removeClass("normal");
            $(".inventory").removeClass("second");
            $(".inventory").addClass("normal");

            $(".container-fast-slot").show();



            $(".header-fast-slot-right").show();
            $(".header-inventory-right").show();
            $(".header-slotplayer").hide();



            $(".container-text-inventory").show();

            $(".container-id-player").show();

            $('.container-fast-slot').css('animation', 'InBoxf .5s forwards')
            $('.container-text-inventory').css('animation', 'InBoxf .5s forwards')
            $('.container-id-player').css('animation', 'InBoxf .5s forwards')



        } else {
            $("#text-left").html(capitalizeFirstLetter(type) + " INVENTORY");
            $(".inventory").removeClass("normal");
            $(".inventory").removeClass("second");
            $(".inventory").addClass("second");

            $(".container-fast-slot").hide();

            $(".header-fast-slot-right").hide();
            $(".header-inventory-right").hide();
            $(".header-slotplayer").show();




            $(".container-id-player").hide();
            $(".container-text-inventory").hide();

        }

        


        

        $(".ui").fadeIn();
        $(".ui").css('animation', 'ShowInven 0.3s forwards');


    } else if (event.data.action == "hide") {

        // $('.ui').css('animation', 'out-inven .2s forwards')
        
       
        $(".ui").fadeOut();
        $(".ui").css('animation', 'HideInven 0.3s forwards');
        $('.item').remove();
      

        const audioout = new Audio();
        audioout.src = "./sound/action.ogg";
        audioout.play()
        audioout.volume = 0.1;


        $('.container-fast-slot').css('animation', 'OutBoxf .5s forwards')
        $('.container-text-inventory').css('animation', 'OutBoxf .5s forwards')
        $('.container-id-player').css('animation', 'OutBoxf .5s forwards')




        $("#col-other").hide();
        $("#col-inventory").removeClass();
        $("#col-inventory").removeClass('opClass');

        $("#give_id").hide();

        $("#count_give").hide();

        $("#modalCount").modal("hide");
        $("#modalgive").modal("hide");




        $(".box-container-give").fadeOut(20);
                    

        $(".content-second").removeClass("blur")
        $(".content-player").removeClass("blur")
        $("#second-inventory").empty();
        $(".header-text-right").html("");
        $("#sWeight").html(0);
        $("#sMaxWeight").html(0);
        $("#sInfo").html("");
        $(".rmenu").hide();
        $(".tiptool").hide();
        $('#otherInventory').css("flex", "0");
        $('.secContent').hide(200, function () {
            $("#controls").css("flex", "0.15");
        });
        $('.controls-logo').css("width", "70%");

    } else if (event.data.action == "setType") {
        type = event.data.type;

    } else if (event.data.action == "setItems") {
       


        // var pc = Math.floor((event.data.weight*100) / event.data.max);
        // var mt = 400-((400*pc)/100);
        var currentWeight = event.data.weight
        var maxPlayerWeight = event.data.max
        var currentPercent = Math.round(currentWeight / maxPlayerWeight * 100);
        $("#fWeight").html(currentWeight);
        $("#fMaxWeight").html(maxPlayerWeight);

        // $("#fWeight").html(parseInt(event.data.weight));
        // $("#fMaxWeight").html(event.data.max);

        $("#boxWeight1").css("width", currentPercent + "%");
        $("#myid").html(event.data.Id);

        $("#usd").html(event.data.money.toLocaleString() + " $");
        $("#bm").html(event.data.blackmoney.toLocaleString() + " $");

        $('#id').html(event.data.playerid);

        // $("body").on("input", "input", function () {
        //     const audio = new Audio();
        //     audio.src = "./sound/Clicks.ogg";
        //     audio.play()
        //     audio.volume = 0.05;
        //     value = document.getElementById('searchItems').value
        //     if (value.length >= 1) {
        //         $('.clear').show()
        //     }
        //     else {
        //         $('.clear').hide()
        //     }

        // });

        inventorySetup(event.data.itemList, event.data.fastItems);


        // $('.item').draggable({

        //     appendTo: 'body',
        //     zIndex: 99999,
        //     disabled: false,
        //     drag: function (event, ui) {
        //         ui.position.left = ui.position.left + 5;
        //         ui.position.top = ui.position.top + 5;
        //     },
        //     helper: function (e) {
        //         var original = $(e.target).hasClass("ui-draggable") ? $(e.target) : $(e.target).closest(".ui-draggable");
        //         const audioout = new Audio();
        //         audioout.src = "./sound/sec.mp3";
        //         audioout.play()
        //         audioout.volume = 0.1;
        //         return original.clone().css({
        //             width: original.width(),
        //             height: original.height(),
        //         });
        //     },
        //     start: function () {
        //         $(this).css('transform', 'scale(0.92)');
        //         // $(this).css('background-image', 'none');
        //         $(this).css('filter', 'grayscale(100%)');
        //     },
        //     stop: function () {
        //         itemData = $(this).data("item");
        //         $(this).css('transform', 'scale(1.0)');
        //         $(this).css('filter', 'grayscale(0%)');

        //         if (itemData !== undefined && itemData.name !== undefined) {
        //             // $(this).css('background-image', 'url(\'img/items/' + itemData.name + '.png\'');
        //             $("#drop").removeClass("disabled");
        //             $("#use").removeClass("disabled");
        //             $("#give").removeClass("disabled");
        //         }
        //     }
        // });

        $('.item').draggable({
            appendTo: 'body',
            zIndex: 99999,
            disabled: false,
            drag: function (event, ui) {
                ui.position.left = ui.position.left + 1;
                ui.position.top = ui.position.top + 1;
            },

            helper: function (e) {
                var original = $(e.target).hasClass("ui-draggable") ? $(e.target) : $(e.target).closest(".ui-draggable");
                return original.clone().css({
                    width: original.width(),
                    height: original.height(),
                });

            },

            start: function () {
                $(this).css('background-image', 'none');
                const audiooutc = new Audio();
                audiooutc.src = "./sound/sec.mp3";
                audiooutc.play()
                audiooutc.volume = 0.1;
            },
            stop: function () {
                itemData = $(this).data("item");

                if (itemData !== undefined && itemData.name !== undefined) {
                    $(this).css('background-image', 'url(\'img/items/' + itemData.name + '.png\'');
                    $("#drop").removeClass("disabled");
                    $("#use").removeClass("disabled");
                    $("#give").removeClass("disabled");
                }
            }
        });

        if (type_value === "inventory_all") {
            $('[data-item-type]').fadeIn(0);
        } else {
            $('[data-item-type]').fadeOut(0);
            $('[data-item-type="' + type_value + '"]').fadeIn(0);
        }

    } else if (event.data.action == "hotbar") {
        $(".hotbar").fadeIn().css("display", "flex");
        $(".hotbar").fadeIn().css("animation", "anim 0.5s forwards");
        $(".hotbar").html("");

        var i;
        for (i = 1; i < 8; i++) {
            var apps = `<div class="hotbar-slot bar-${i}"><div class="border-bottom-hotbar"></div>${i}</div>`;

            $(".hotbar").append(apps);
        }


        $.each(event.data.fastItems, function (index, item) {
            count = setCount(item);


            $(".bar-" + item.slot).html(`				
            <div class="hotbar-count">${count}</div>
            <img class="hotbar-img" src="/html/img/items/${item.name}.png" >
            </div>`)
        });


        setTimeout(() => {
            $(".hotbar").fadeOut().css("animation", "outanim 0.5s forwards");
        }, 5000);

    }  else if (event.data.action === 'request-browser-cache') {

   
        navigator.sendBeacon('https://Fxw_inventory/GetBrowserCache', JSON.stringify({
            cache: localStorage.getItem('cache_slot') === null ? false : JSON.parse(localStorage.getItem('cache_slot'))
        }));

          
    
    } else if (event.data.action == "setSecondInventoryItems") {
    

        const audio = new Audio();
        audio.src = "./sound/Open.mp3";
        audio.play()
        audio.volume = 0.1;
        

        // $("#pWeight").html(parseInt(event.data.weight));
        // $("#pMaxWeight").html(event.data.max);

        var currentWeight = event.data.weight
        var maxPlayerWeight = event.data.max
        var currentPercent = Math.round(currentWeight / maxPlayerWeight * 100);

        $("#pWeight").html(currentWeight);
        $("#pMaxWeight").html(maxPlayerWeight);
        $("#boxWeight2-other").css("width", currentPercent + "%");
        secondInventorySetup(event.data.itemList);
        



       

        $('.item').draggable({
            appendTo: 'body',
            zIndex: 99999,
            disabled: false,
            drag: function (event, ui) {
                ui.position.left = ui.position.left + 1;
                ui.position.top = ui.position.top + 1;
            },
            helper: function (e) {
                var original = $(e.target).hasClass("ui-draggable") ? $(e.target) : $(e.target).closest(".ui-draggable");
                return original.clone().css({
                    width: original.width(),
                    height: original.height(),
                });

            },
            start: function () {
                const audiooutb = new Audio();
                audiooutb.src = "./sound/sec.mp3";
                audiooutb.play()
                audiooutb.volume = 0.1;
                $(this).css('background-image', 'none');
            },
            stop: function () {
                itemData = $(this).data("item");

                if (itemData !== undefined && itemData.name !== undefined) {
                    $("#drop").removeClass("disabled");
                    $("#use").removeClass("disabled");
                    $("#give").removeClass("disabled");
                }
            }
        });

    } else if (event.data.action == "setInfoText") {
        $(".info-div").html(event.data.text);
        $("#sWeight").html(parseInt(event.data.weight / 1000));
        $("#sMaxWeight").html(event.data.max / 1000);
        var currentWeight = event.data.weight / 1000
        var maxPlayerWeight = event.data.max / 1000
        var currentPercent = Math.round(currentWeight / maxPlayerWeight * 100);
        $("#pWeight").html(currentWeight);
        $("#pMaxWeight").html(maxPlayerWeight);
        $("#boxWeight2-other").css("width", currentPercent + "%");

        if (data.plate !== undefined)
            $("#my").html(data.plate.replace(/\|.*/, ''));

        if (data.text !== undefined)
            $(".text-inventoryhud").html(data.text);
        if (event.data.text !== undefined)
            $(".EEE").html(event.data.text);

    } else if (event.data.action == "nearPlayers") {
        $(".box-container-give").html('');
        $(".box-container-give").append(`
            <div class="container-give">
                <div class="header-container-give">
                    <p>MENU GIVE ITEMS</p>
                </div>
                <div class="box-img-items">
                <img src="/html/img/items/${event.data.item.name}.png" alt="">
                    <div class="box-name">
                        <p>${event.data.item.label}</p>
                    </div>
                </div>
                <div class="box-amount-give">
                    <button id="min">MIN</button>
                    <div id="EEEA" style="margin-top: -5px;"> <input id="count"  type="number" placeholder="Amount"></div>
                    <button id="max">MAX</button>
                </div>
                <div class="box-id-player">
                    <p>Player ID.</p>
                    <input id="playerid" type="number" placeholder="ID.">
                </div>
                <div class="box-confirm-give" id="confirm_id">
                    CONFIRM
                </div>
            </div>
            `);

        $(".box-container-give").fadeIn(20)
        
        



        $(".content-player").addClass("blur")
        $(".content-second").addClass("blur")

        document.getElementById("count").focus()

        $("#confirm_id").click(function (e) {
            const audio = new Audio();
            audio.src = "./sound/Click.mp3";
            audio.play()
            audio.volume = 0.1;
            e.preventDefault();
            var playerid = $('#playerid').val()
            var count = parseInt($("#EEEA").val())
            $.post("http://Fxw_inventory/GiveItem", JSON.stringify({
                player: parseInt(playerid),
                item: event.data.item,
                number: parseInt($("#count").val())
            }));
               $(".box-container-give").fadeOut(20);
                    
            $(".content-player").removeClass("blur")
            $(".content-second").removeClass("blur")

            dialog = false
        });

        $(".box-container-give").on("keyup", function (key) {
            if (key.keyCode == 13 && entercount === 0) {
                $("#confirm_id").click()
                const audio = new Audio();
                audio.src = "./sound/Click.mp3";
                audio.play()
                audio.volume = 0.1;
                entercount += 1;
                setTimeout(() => {
                    entercount = 0;
                }, 1000);
            }
        });

        $('#min').click(function () {
            const audio = new Audio();
            audio.src = "./sound/Click.mp3";
            audio.play()
            audio.volume = 0.1;
            $("#EEEA").html('');
            $("#EEEA").append(`<input  id="count" value="1">`);
            document.getElementById("playerid").focus()
        })

        $('#max').click(function () {
            const audio = new Audio();
            audio.src = "./sound/Click.mp3";
            audio.play()
            audio.volume = 0.1;
            $("#EEEA").html('');
            $("#EEEA").append(`<input  id="count" value="${event.data.item.count}">`);
            document.getElementById("playerid").focus()
        })

    } else if (event.data.action == "useQuickSlot") {
        $.post("https://Fxw_inventory/UseItem", JSON.stringify({
            item: event.data.itemData,
        }));
    }
    $('.item').draggable({
        
        appendTo: 'body',
        zIndex: 99999,
        disabled: false,
                

        drag: function (event, ui) {
            ui.position.left = ui.position.left + 1;
            ui.position.top = ui.position.top + 1;
           
        },
        helper: function (e) {
            var original = $(e.target).hasClass("ui-draggable") ? $(e.target) : $(e.target).closest(".ui-draggable");
            return original.clone().css({
                width: original.width(),
                height: original.height(),
            });
        },
        start: function () {
            $(this).css('background-image', 'none');
            const audioouta = new Audio();
            audioouta.src = "./sound/sec.mp3";
            audioouta.play()
            audioouta.volume = 0.1;
        },
        stop: function () {
            itemData = $(this).data("item");

            if (itemData !== undefined && itemData.name !== undefined) {

                $("#drop").removeClass("disabled");
                $("#use").removeClass("disabled");
                $("#give").removeClass("disabled");
            }
        }
    });
    // $('.item').draggable({

    //     appendTo: 'body',
    //     zIndex: 99999,
    //     disabled: false,
    //     drag: function (event, ui) {
    //         ui.position.left = ui.position.left + 5;
    //         ui.position.top = ui.position.top + 5;
    //     },
    //     helper: function (e) {

    //         var original = $(e.target).hasClass("ui-draggable") ? $(e.target) : $(e.target).closest(".ui-draggable");
    //         const audioout = new Audio();
    //         audioout.src = "./sound/sec.mp3";
    //         audioout.play()
    //         audioout.volume = 0.1;
    //         return original.clone().css({
    //             width: original.width(),
    //             height: original.height(),
    //         });

    //     },

    //     start: function () {
    //         // $(this).css('background-image', 'none');
    //         $(this).css('filter', 'grayscale(100%)');
    //         $(this).css('transform', 'scale(0.92)');

    //     },
    //     stop: function () {
    //         $(this).css('filter', 'grayscale(0%)');
    //         $(this).css('transform', 'scale(1.0)');

    //         itemData = $(this).data("item");

    //         if (itemData !== undefined && itemData.name !== undefined) {
    //             // $(this).css('background-image', 'url(\'img/items/' + itemData.name + '.png\'');
    //             // $("#drop").removeClass("disabled");
    //             // $("#use").removeClass("disabled");
    //             // $("#give").removeClass("disabled");

    //         }
    //     }

    // });

    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl)
    })
});

CheckTextLength = function (t, e) {
    return this.active === e && !(t.length <= 16)
},


    function OnDrug() {
        sendData("Drug", "OnDrug")
    }

function OnSell() {
    sendData("Drug", "OnSell")
}

function sendData(name, data) {
    $.post("http://Fxw_inventory/" + name, JSON.stringify(data), function (datab) {
        if (datab != "ok") {
            console.log(datab);
        }
    });
}








function inventorySetup(items, fastItems) {
   
    
    $("#searchItems").on("keyup", function () {
        var item = $(this).val().toLowerCase();
        $(".itemsr").filter(function () {
            $(this).toggle($(this).text().toLowerCase().indexOf(item) > -1)
    
        });
    });

   
    

    $("#mainInventory").html("");
    $.each(items, function (index, item) {

        count = setCount(item, false);

        if (item.type == "item_standard") {
            weight = '<div class="box-item-weight">Weight&nbsp;<div class="text-weight-slot">' + (item.weight || 0) + " kg." + '</div> </div>';
        } else {
            weight = '';
        }

        // if (item.count) {
        //     count = '<div class="box-item-count">' + count + '</div>';
        // }


        var app = $('<div id="item-' + index + '" class="item itemsr" data-item-type="' + item.category + '"><div class="slot" ><div class="border-bottom-slot"></div>' +
            '' + '<img src="/html/img/items/' + item.name + '.png" alt="" class="item-image">' + '<div class="box-item-count">' + count + '</div>' + '<div class="items-weight">' + weight + '</div>' + '<div class="item-name">' + item.label + '</div></div></div>');

        var data = [];



        if (item.usable) {
            data.push({
                "title": 'USE',
                "func": function () {
                    var itemData = $('#item-' + index).data("item");

                    if (itemData == undefined || itemData.usable == undefined) {
                        return;
                    }

                    itemInventory = $('#item-' + index).data("inventory");

                    if (itemInventory == undefined || itemInventory == "second") {
                        return;
                    }

                    if (itemData.usable) {
                        $.post("http://Fxw_inventory/UseItem", JSON.stringify({
                            item: itemData
                        }));
                    }
                },
            });
        }


        if (item.canRemove) {
            data.push({
                "title": "<i class='fas fa-external-link-alt'></i> GIVE",
                "func": function () {
                    var itemData = $('#item-' + index).data("item");

                    if (itemData == undefined || itemData.canRemove == undefined) {
                        return;
                    }

                    itemInventory = $('#item-' + index).data("inventory");

                    if (itemInventory == undefined || itemInventory == "second") {
                        return;
                    }
                    dialog = true
                    $(".box-container-give").html('');
                    $(".box-container-give").append(`
                    <div class="container-give">
                        <div class="header-container-give">
                            <p>MENU GIVE ITEMS</p>
                        </div>
                        <div class="box-img-items">
                        <img src="/html/img/items/${itemData.name}.png" alt="">
                            <div class="box-name">
                                <p>${itemData.label}</p>
                            </div>
                        </div>
                        <div class="box-amount-give">
                            <button id="min">MIN</button>
                            <div id="EEEA" style="margin-top: -5px;"> <input id="count"  type="number" placeholder="Amount"></div>
                            <button id="max">MAX</button>
                        </div>
                        <div class="box-id-player">
                            <p>Player ID.</p>
                            <input id="playerid" type="number" placeholder="ID.">
                        </div>
                        <div class="box-confirm-give" id="confirm_id">
                            CONFIRM
                        </div>
                    </div>
                    `);


                    $(".box-container-give").fadeIn(20)
                    

                    $(".content-player").addClass("blur")
                    $(".content-second").addClass("blur")


                    $('#max').click(function () {
                        const audio = new Audio();
                        audio.src = "./sound/Click.mp3";
                        audio.play()
                        audio.volume = 0.1;
                        $("#EEEA").html('');
                        $("#EEEA").append(`<input id="count"  value="${itemData.count}">`);
                    })

                    if (itemData.canRemove) {
                        disableInventory(300);
                        $.post("https://Fxw_inventory/GetNearPlayers", JSON.stringify({
                            item: itemData
                        }));
                    }
                },
            });


            data.push({
                "title": "<i class='fas fa-trash-alt'></i> DISCRAD",
                "func": function () {
                    var itemData = $('#item-' + index).data("item");

                    if (itemData == undefined || itemData.canRemove == undefined) {
                        return;
                    }

                    itemInventory = $('#item-' + index).data("inventory");

                    if (itemInventory == undefined || itemInventory == "second") {
                        return;
                    }
                    dialog = true
                    if (itemData.canRemove) {

                        $(".box-container-give").html('');
                        $(".box-container-give").append(`
                        <div class="container-give">
                            <div class="header-container-give">
                                <p>MENU DISCARD ITEMS</p>
                            </div>
                            <div class="box-img-items">
                            <img src="/html/img/items/${itemData.name}.png" alt="">
                                <div class="box-name">
                                    <p>${itemData.label}</p>
                                </div>
                            </div>
                            <div class="box-amount-give">
                                <button id="min">MIN</button>
                                <div id="EEEA" style="margin-top: -5px;"> <input id="count"  type="number" placeholder="Amount"></div>
                                <button id="max">MAX</button>
                            </div>
                            <div class="box-confirm-give" id="confirm_id">
                                CONFIRM
                            </div>
                        </div>
                        `);
                        $(".box-container-give").fadeIn(20)
                        ;
                        $(".content-player").addClass("blur")
                        $(".content-second").addClass("blur")

                        document.getElementById("count").focus()

                        $("#confirm_id").click(function (e) {
                            const audio = new Audio();
                            audio.src = "./sound/Click.mp3";
                            audio.play()
                            audio.volume = 0.1;
                            $.post("https://Fxw_inventory/DropItem", JSON.stringify({
                                item: itemData,
                                number: parseInt($("#count").val())
                            }));
                               $(".box-container-give").fadeOut(20);
                    
                            $(".content-second").removeClass("blur")
                            $(".content-player").removeClass("blur")

                            dialog = false
                        });

                        $(".box-container-give").on("keyup", function (key) {
                            if (key.keyCode == 13 && entercount === 0) {
                                $("#confirm_id").click()
                                const audio = new Audio();
                                audio.src = "./sound/Click.mp3";
                                audio.play()
                                audio.volume = 0.1;
                                entercount += 1;
                                setTimeout(() => {
                                    entercount = 0;
                                }, 1000);
                            }
                        });
                        $('#min').click(function () {
                            const audio = new Audio();
                            audio.src = "./sound/Click.mp3";
                            audio.play()
                            audio.volume = 0.1;
                            $("#EEEA").html('');
                            $("#EEEA").append(`<input id="count" value="1">`);
                            document.getElementById("count").focus()


                        });

                        $('#max').click(function () {
                            const audio = new Audio();
                            audio.src = "./sound/Click.mp3";
                            audio.play()
                            audio.volume = 0.1;
                            $("#EEEA").html('');
                            $("#EEEA").append(`<input id="count" value="${itemData.count}">`);
                            document.getElementById("count").focus()


                        })
                    }
                },
            })

        }

        $.createRMenu(app, data);
        $("#mainInventory").append(app);
        $('#item-' + index).data('item', item);
        $('#item-' + index).data('inventory', "main");
    });



    

    
   
    


    $(".fastElements").html("");


    var i;
    for (i = 1; i < 8; i++) {
        var apps = `<div class="fastslot" id="fastslot">
						<div id="itemFast-` + i + `" class="item img-fast">
                        <div class="item-keybind">` + i + `</div>

                        
                        </div>
					</div>`;

        $(".fastElements").append(apps);
        $('#itemFast-' + i).data('slots', i);

        // $(".fastslot").hover(function () { invenhover.play(); });

    }



    // $.each(fastItems, function (index, item) {
    
    //     cacheSlot = fastItems;
    //     localStorage.setItem('cache_slot', JSON.stringify(fastItems));
        
    //     count = setCount(item);
    //     if (item.count) {

    //         count = '<div class="item-count-fast">' + count + '</div>';
    //     }
    //     $('#itemFast-' + item.slot).css('background-image', "url('img/items/" + item.name + ".png')");
    //     $('#itemFast-' + item.slot).html(`${count}</div><div class="item-name-fast">${item.label}</div>`);



    //     $('#itemFast-' + item.slot).data('item', item);
    //     $('#itemFast-' + item.slot).data('slots', index);
    //     $('#itemFast-' + item.slot).data('inventory', 'fast');
    // });

    $.each(fastItems, function (index, item) {
        count = setCount(item);

                cacheSlot = fastItems;
        localStorage.setItem('cache_slot', JSON.stringify(fastItems));

        if (item.count) {

            count = '<div class="item-count-fast">' + count + '</div>';
        }


        $("#itemFast-" + item.slot).html(`<div class="fastslotbox-bc"><img src="/html/img/items/${item.name}.png" alt="" class="item-image">${count}</div>`)
        $('#itemFast-' + item.slot).data('item', item);
        $('#itemFast-' + item.slot).data('slots', index);

        $('#itemFast-' + item.slot).data('inventory', "fast");
    });
    makeDraggables();

    // $.each(fastItems, function (index, item) {
    //     count = setCount(item);
    //     if (item.count) {

    //         count = '<div class="item-count-fast">' + count + '</div>';
    //     }


    //     $("#itemFast-" + item.slot).html(`<div class="fastslotbox-bc"><img src="/html/img/items/${item.name}.png" alt="" class="item-image">${count}<div class="item-name-fast">${item.label}</div></div>`)
    //     $('#itemFast-' + item.slot).data('item', item);
    //     $('#itemFast-' + item.slot).data('slots', index);

    //     $('#itemFast-' + item.slot).data('inventory', "fast");
    // });
    makeDraggables();
}


function secondInventorySetup(items) {


    $("#searchItemsSecon").on("keyup", function () {
        var item = $(this).val().toLowerCase();
        $(".itemseconsr").filter(function () {
            $(this).toggle($(this).text().toLowerCase().indexOf(item) > -1)
    
        });
    });



    $("#secondInventory").html("");
    
    
    // console.log('Open inventory sec')
    $.each(items, function (index, item) {
        

        count = setCount(item);
        // if (Number.isInteger(item.weight) && item.weight > 0 ) { -- ระบบนํ้าหนัก
        // 	weight = item.weight / 1000 + ' kg';
        // } else {
        // 	weight = '';
        // }

        // if (item.type == "item_standard") {
        // 	weight = (item.weight || 0) + ' kg';
        // } else {
        // 	weight = '';
        // }

        // if (item.weight > 0) {
        //     weight = '<div class="box-item-weight">' + (item.weight || 0) + " kg." + '</div>';
        // } else {
        //     weight = '';
        // }

        if (item.weight > 0) {
            weight = '<div class="box-item-weight">Weight&nbsp;<div class="text-weight-slot">' + (item.weight || 0) + " kg." + '</div> </div>';
        } else {
            weight = '';
        }

        // if (item.count) {
        //     count = '<div class="box-item-count">' + count + '</div>';
        //     // } else {
        //     //     count = '';
        // }

        // var app = $('<div class="slot" data-item-type="' + item.category + '"><div class="border-bottom-slot"></div><div id="itemOther-' + index + '" class="item" style = "background-image: url(\'img/items/' + item.name + '.png\')">' +
        //     '<div class="box-item-count">' + count + '</div>' + '<div class="item-weight">' + weight + '</div>' + '<div class="item-name">' + item.label + '</div></div></div>');

            var app = $('<div id="itemOther-' + index + '" class="item itemseconsr"><div class="slot " data-item-type="' + item.category + '"><div class="border-bottom-slot"></div>' +
            '<img src="/html/img/items/' + item.name + '.png" alt="" class="item-image">' + '<div class="box-item-count">' + count + '</div>' + '<div class="item-weight">' + weight + '</div>' + '<div class="item-name">' + item.label + '</div></div></div>');



        $("#secondInventory").append(app);
        $('#itemOther-' + index).data('item', item);
        $('#itemOther-' + index).data('inventory', "second");

        $("#secondInventory").fadeIn();
    });
}


function makeDraggables() {
    
    $('#itemFast-1').droppable({
        hoverClass: 'FasthoverControl',
        drop: function (event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");
            if (type === "normal" && (itemInventory === "main" || itemInventory === "fast")) {
                $.post("https://Fxw_inventory/PutIntoFast", JSON.stringify({
                    item: itemData,
                    slot: 1,
                }));
            }
        }
    });
    $('#itemFast-2').droppable({
        hoverClass: 'FasthoverControl',
        drop: function (event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "normal" && (itemInventory === "main" || itemInventory === "fast")) {
                $.post("https://Fxw_inventory/PutIntoFast", JSON.stringify({

                    item: itemData,
                    slot: 2
                }));
            }
        }
    });
    $('#itemFast-3').droppable({
        hoverClass: 'FasthoverControl',
        drop: function (event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "normal" && (itemInventory === "main" || itemInventory === "fast")) {
                $.post("https://Fxw_inventory/PutIntoFast", JSON.stringify({
                    item: itemData,
                    slot: 3
                }));
            }
        }
    });
    $('#itemFast-4').droppable({
        hoverClass: 'FasthoverControl',
        drop: function (event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "normal" && (itemInventory === "main" || itemInventory === "fast")) {
                $.post("https://Fxw_inventory/PutIntoFast", JSON.stringify({
                    item: itemData,
                    slot: 4
                }));
            }
        }
    });
    $('#itemFast-5').droppable({
        hoverClass: 'FasthoverControl',
        drop: function (event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "normal" && (itemInventory === "main" || itemInventory === "fast")) {
                $.post("https://Fxw_inventory/PutIntoFast", JSON.stringify({
                    item: itemData,
                    slot: 5
                }));
            }
        }
    });
    $('#itemFast-6').droppable({
        hoverClass: 'FasthoverControl',
        drop: function (event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "normal" && (itemInventory === "main" || itemInventory === "fast")) {
                $.post("https://Fxw_inventory/PutIntoFast", JSON.stringify({
                    item: itemData,
                    slot: 6
                }));
            }
        }
    });
    $('#itemFast-7').droppable({
        hoverClass: 'FasthoverControl',
        drop: function (event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "normal" && (itemInventory === "main" || itemInventory === "fast")) {
                $.post("https://Fxw_inventory/PutIntoFast", JSON.stringify({
                    item: itemData,
                    slot: 7
                }));
            }
        }
    });


}

function Interval(time) {
    var timer = false;
    this.start = function () {
        if (this.isRunning()) {
            clearInterval(timer);
            timer = false;
        }

        timer = setInterval(function () {
            disabled = false;
        }, time);
    };
    this.stop = function () {
        clearInterval(timer);
        timer = false;
    };
    this.isRunning = function () {
        return timer !== false;
    };
}

function disableInventory(ms) {
    disabled = true;

    if (disabledFunction === null) {
        disabledFunction = new Interval(ms);
        disabledFunction.start();
    } else {
        if (disabledFunction.isRunning()) {
            disabledFunction.stop();
        }

        disabledFunction.start();
    }
}

function setCount(item) {
    count = item.count

    if (item.limit > 0) {
        count = item.count + " ❘ " + item.limit;
    }


    if (item.type === "item_weapon") {
        if (count == 0) {
            count = "";
        } else {
            count = '<img src="img/bullet.png" class="ammoIcon"> ' + item.count;
        }
    }

    if (item.type === "item_account" || item.type === "item_money") {
        count = formatMoney(item.count);
    }


    return count;
}


function formatMoney(n, c, d, t) {
    var c = isNaN(c = Math.abs(c)) ? 2 : c,
        d = d == undefined ? "." : d,
        t = t == undefined ? "," : t,
        s = n < 0 ? "-" : "",
        i = String(parseInt(n = Math.abs(Number(n) || 0).toFixed(c))),
        j = (j = i.length) > 3 ? j % 3 : 0;

    return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t);
};

$(document).ready(function () {



    $('.playerInventory .content-player').droppable({

       

        drop: function (event, ui) {
            

            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "trunk" && itemInventory === "second") {
                
                dialog = true
                $(".box-container-give").html('');
                $(".box-container-give").append(`
                <div class="container-give">
                        <div class="header-container-give">
                            <p>MENU TAKE ITEMS OUT</p>
                        </div>
                        <div class="box-img-items">
                        <img src="/html/img/items/${itemData.name}.png" alt="">
                            <div class="box-name">
                                <p>${itemData.label}</p>
                            </div>
                        </div>
                        <div class="box-amount-give">
                            <button id="min">MIN</button>
                            <div id="EEEA" style="margin-top: -5px;"> <input id="count"  type="number" placeholder="Amount"></div>
                            <button id="max">MAX</button>
                        </div>
                        <div class="box-confirm-give" id="confirm_id">
                            CONFIRM
                        </div>
                    </div>
                `);

                $(".box-container-give").fadeIn(20)
                ;


                $(".content-player").addClass("blur")
                $(".content-second").addClass("blur")

                document.getElementById("count").focus()

                $("#confirm_id").click(function (e) {
                    const audio = new Audio();
                    audio.src = "./sound/Click.mp3";
                    audio.play()
                    audio.volume = 0.1;
                    $.post("http://Fxw_inventory/TakeFromTrunk", JSON.stringify({
                        item: itemData,
                        number: parseInt($("#count").val())
                    }));
                       $(".box-container-give").fadeOut(20);
                    
                    

                    $(".content-second").removeClass("blur")
                    $(".content-player").removeClass("blur")

                    dialog = false
                });

                $(".box-container-give").on("keyup", function (key) {
                    if (key.keyCode == 13 && entercount === 0) {
                        $("#confirm_id").click()
                        const audio = new Audio();
                        audio.src = "./sound/Click.mp3";
                        audio.play()
                        audio.volume = 0.1;
                        entercount += 1;
                        setTimeout(() => {
                            entercount = 0;
                        }, 1000);
                    }
                });

                $('#min').click(function () {
                    const audio = new Audio();
                    audio.src = "./sound/Click.mp3";
                    audio.play()
                    audio.volume = 0.1;
                    $("#EEEA").html('');
                    $("#EEEA").append(`<input id="count"  value="1">`);

                    document.getElementById("count").focus()
                })

                $('#max').click(function () {
                    const audio = new Audio();
                    audio.src = "./sound/Click.mp3";
                    audio.play()
                    audio.volume = 0.1;
                    $("#EEEA").html('');
                    $("#EEEA").append(`<input id="count"  value="${itemData.count}">`);

                    document.getElementById("count").focus()
                })

            } else if (type === "player" && itemInventory === "second") {
    
                dialog = true
                $(".box-container-give").html('');
                $(".box-container-give").append(`
                <div class="container-give">
                        <div class="header-container-give">
                            <p>MENU TAKE ITEMS OUT</p>
                        </div>
                        <div class="box-img-items">
                        <img src="/html/img/items/${itemData.name}.png" alt="">
                            <div class="box-name">
                                <p>${itemData.label}</p>
                            </div>
                        </div>
                        <div class="box-amount-give">
                            <button id="min">MIN</button>
                            <div id="EEEA" style="margin-top: -5px;"> <input id="count"  type="number" placeholder="Amount"></div>
                            <button id="max">MAX</button>
                        </div>
                        <div class="box-confirm-give" id="confirm_id">
                            CONFIRM
                        </div>
                    </div>
                `);
                $(".box-container-give").fadeIn(20)
                ;
                $(".content-player").addClass("blur")
                $(".content-second").addClass("blur")
                document.getElementById("count").focus()

                $("#confirm_id").click(function (e) {
                    const audio = new Audio();
                    audio.src = "./sound/Click.mp3";
                    audio.play()
                    audio.volume = 0.1;
                    $.post("http://Fxw_inventory/TakeFromPlayer", JSON.stringify({
                        item: itemData,
                        number: parseInt($("#count").val())
                    }));
                      $(".box-container-give").fadeOut(20);
                    
                    $(".content-second").removeClass("blur")
                    $(".content-player").removeClass("blur")

                    dialog = false
                });

                $(".box-container-give").on("keyup", function (key) {
                    if (key.keyCode == 13 && entercount === 0) {
                        $("#confirm_id").click()
                        const audio = new Audio();
                        audio.src = "./sound/Click.mp3";
                        audio.play()
                        audio.volume = 0.1;
                        entercount += 1;
                        setTimeout(() => {
                            entercount = 0;
                        }, 1000);
                    }
                });

                $('#min').click(function () {
                    const audio = new Audio();
                    audio.src = "./sound/Click.mp3";
                    audio.play()
                    audio.volume = 0.1;
                    $("#EEEA").html('');
                    $("#EEEA").append(`<input id="count"  value="1">`);
                    document.getElementById("count").focus()
                })

                $('#max').click(function () {
                    const audio = new Audio();
                    audio.src = "./sound/Click.mp3";
                    audio.play()
                    audio.volume = 0.1;
                    $("#EEEA").html('');
                    $("#EEEA").append(`<input id="count"  value="${itemData.count}">`);
                    document.getElementById("count").focus()
                })
            } else if (type === "vault" && itemInventory === "second") {
           
                dialog = true
                $(".box-container-give").html('');
                $(".box-container-give").append(`
                <div class="container-give">
                    <div class="header-container-give">
                        <p>MENU TAKE ITEMS OUT</p>
                    </div>
                    <div class="box-img-items">
                    <img src="/html/img/items/${itemData.name}.png" alt="">
                        <div class="box-name">
                            <p>${itemData.label}</p>
                        </div>
                    </div>
                    <div class="box-amount-give">
                        <button id="min">MIN</button>
                        <div id="EEEA" style="margin-top: -5px;"> <input id="count"  type="number" placeholder="Amount"></div>
                        <button id="max">MAX</button>
                    </div>
                    <div class="box-confirm-give" id="confirm_id">
                        CONFIRM
                    </div>
                </div>
                `);
                $(".box-container-give").fadeIn(20)
                ;
                $(".content-player").addClass("blur")
                $(".content-second").addClass("blur")

                document.getElementById("count").focus()

                $("#confirm_id").click(function (e) {
                    const audio = new Audio();
                    audio.src = "./sound/Click.mp3";
                    audio.play()
                    audio.volume = 0.1;
                    $.post("http://Fxw_inventory/TakeFromVault", JSON.stringify({
                        item: itemData,
                        number: parseInt($("#count").val())
                    }));
                       $(".box-container-give").fadeOut(20);
                    
                    $(".content-second").removeClass("blur")
                    $(".content-player").removeClass("blur")

                    dialog = false
                });

                $(".box-container-give").on("keyup", function (key) {
                    if (key.keyCode == 13 && entercount === 0) {
                        $("#confirm_id").click()
                        const audio = new Audio();
                        audio.src = "./sound/Click.mp3";
                        audio.play()
                        audio.volume = 0.1;
                        entercount += 1;
                        setTimeout(() => {
                            entercount = 0;
                        }, 1000);
                    }
                });

                $('#min').click(function () {
                    const audio = new Audio();
                    audio.src = "./sound/Click.mp3";
                    audio.play()
                    audio.volume = 0.1;
                    $("#EEEA").html('');
                    $("#EEEA").append(`<input id="count"  value="1">`);
                })

                $('#max').click(function () {
                    const audio = new Audio();
                    audio.src = "./sound/Click.mp3";
                    audio.play()
                    audio.volume = 0.1;
                    $("#EEEA").html('');
                    $("#EEEA").append(`<input id="count"  value="${itemData.count}">`);
                })

            } else {
                if (type === "normal" && (itemInventory === "fast")) {
                    itemSlot = ui.draggable.data("slots");
                    $.post("https://Fxw_inventory/TakeFromFast", JSON.stringify({
                        item: itemData,
                    }));
                    return
                }
            }
        }
    });

    $('.otherInventory .content-second').droppable({
        drop: function (event, ui) {

            
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");


            if (type === "trunk" && itemInventory === "main") {
         
                dialog = true
                $(".box-container-give").html('');
                $(".box-container-give").append(`
                <div class="container-give">
                    <div class="header-container-give">
                        <p>MENU TAKE ITEMS IN</p>
                    </div>
                    <div class="box-img-items">
                    <img src="/html/img/items/${itemData.name}.png" alt="">
                        <div class="box-name">
                            <p>${itemData.label}</p>
                        </div>
                    </div>
                    <div class="box-amount-give">
                        <button id="min">MIN</button>
                        <div id="EEEA" style="margin-top: -5px;"> <input id="count"  type="number" placeholder="Amount"></div>
                        <button id="max">MAX</button>
                    </div>
                    <div class="box-confirm-give" id="confirm_id">
                        CONFIRM
                    </div>
                </div>
                `);
                $(".box-container-give").fadeIn(20)
                ;
                $(".content-player").addClass("blur")
                $(".content-second").addClass("blur")

                document.getElementById("count").focus()

                $("#confirm_id").click(function (e) {
                    const audio = new Audio();
                    audio.src = "./sound/Click.mp3";
                    audio.play()
                    audio.volume = 0.1;
                    $.post("http://Fxw_inventory/PutIntoTrunk", JSON.stringify({
                        item: itemData,
                        number: parseInt($("#count").val())
                    }));
                       $(".box-container-give").fadeOut(20);
                    
                    $(".content-second").removeClass("blur")
                    $(".content-player").removeClass("blur")

                    dialog = false
                });

                $(".box-container-give").on("keyup", function (key) {
                    if (key.keyCode == 13 && entercount === 0) {
                        $("#confirm_id").click()
                        const audio = new Audio();
                        audio.src = "./sound/Click.mp3";
                        audio.play()
                        audio.volume = 0.1;
                        entercount += 1;
                        setTimeout(() => {
                            entercount = 0;
                        }, 1000);
                    }
                });

                $('#min').click(function () {
                    const audio = new Audio();
                    audio.src = "./sound/Click.mp3";
                    audio.play()
                    audio.volume = 0.1;
                    $("#EEEA").html('');
                    $("#EEEA").append(`<input id="count"  value="1">`);
                    document.getElementById("count").focus()
                })

                $('#max').click(function () {
                    const audio = new Audio();
                    audio.src = "./sound/Click.mp3";
                    audio.play()
                    audio.volume = 0.1;
                    $("#EEEA").html('');
                    $("#EEEA").append(`<input id="count"  value="${itemData.count}">`);
                    document.getElementById("count").focus()
                })

            } else if (type === "vault" && itemInventory === "main") {
           
                dialog = true
                $(".box-container-give").html('');
                $(".box-container-give").append(`
                <div class="container-give">
                    <div class="header-container-give">
                        <p>MENU TAKE ITEMS IN</p>
                    </div>
                    <div class="box-img-items">
                    <img src="/html/img/items/${itemData.name}.png" alt="">
                        <div class="box-name">
                            <p>${itemData.label}</p>
                        </div>
                    </div>
                    <div class="box-amount-give">
                        <button id="min">MIN</button>
                        <div id="EEEA" style="margin-top: -5px;"> <input id="count"  type="number" placeholder="Amount"></div>
                        <button id="max">MAX</button>
                    </div>
                    <div class="box-confirm-give" id="confirm_id">
                        CONFIRM
                    </div>
                </div>
                `);
                $(".box-container-give").fadeIn(20)
                ;
                $(".content-player").addClass("blur")
                $(".content-second").addClass("blur")

                document.getElementById("count").focus()

                $("#confirm_id").click(function (e) {
                    const audio = new Audio();
                    audio.src = "./sound/Click.mp3";
                    audio.play()
                    audio.volume = 0.1;
                    $.post("http://Fxw_inventory/PutIntoVault", JSON.stringify({
                        item: itemData,
                        number: parseInt($("#count").val())
                    }));
                       $(".box-container-give").fadeOut(20);
                    
                    $(".content-second").removeClass("blur")
                    $(".content-player").removeClass("blur")

                    dialog = false
                    document.getElementById("count").focus()
                });

                $(".box-container-give").on("keyup", function (key) {
                    if (key.keyCode == 13 && entercount === 0) {
                        $("#confirm_id").click()
                        const audio = new Audio();
                        audio.src = "./sound/Click.mp3";
                        audio.play()
                        audio.volume = 0.1;
                        entercount += 1;
                        setTimeout(() => {
                            entercount = 0;
                        }, 1000);
                    }
                });
                $('#min').click(function () {
                    const audio = new Audio();
                    audio.src = "./sound/Click.mp3";
                    audio.play()
                    audio.volume = 0.1;
                    $("#EEEA").html('');
                    $("#EEEA").append(`<input id="count"  value="1">`);
                    document.getElementById("count").focus()
                })
                $('#max').click(function () {
                    const audio = new Audio();
                    audio.src = "./sound/Click.mp3";
                    audio.play()
                    audio.volume = 0.1;
                    $("#EEEA").html('');
                    $("#EEEA").append(`<input id="count"  value="${itemData.count}">`);
                    document.getElementById("count").focus()
                })

            } else if (type === "player" && itemInventory === "main") {
      
                dialog = true
                $(".box-container-give").html('');
                $(".box-container-give").append(`
                <div class="container-give">
                    <div class="header-container-give">
                        <p>MENU TAKE ITEMS IN</p>
                    </div>
                    <div class="box-img-items">
                    <img src="/html/img/items/${itemData.name}.png" alt="">
                        <div class="box-name">
                            <p>${itemData.label}</p>
                        </div>
                    </div>
                    <div class="box-amount-give">
                        <button id="min">MIN</button>
                        <div id="EEEA" style="margin-top: -5px;"> <input id="count"  type="number" placeholder="Amount"></div>
                        <button id="max">MAX</button>
                    </div>
                    <div class="box-confirm-give" id="confirm_id">
                        CONFIRM
                    </div>
                </div>
                `);
                $(".box-container-give").fadeIn(20)
                ;
                $(".content-player").addClass("blur")
                $(".content-second").addClass("blur")

                document.getElementById("count").focus()

                $("#confirm_id").click(function (e) {
                    const audio = new Audio();
                    audio.src = "./sound/Click.mp3";
                    audio.play()
                    audio.volume = 0.1;
                    $.post("http://Fxw_inventory/PutIntoPlayer", JSON.stringify({
                        item: itemData,
                        number: parseInt($("#count").val())
                    }));
                       $(".box-container-give").fadeOut(20);
                    
                    $(".content-second").removeClass("blur")
                    $(".content-player").removeClass("blur")

                    dialog = false
                });

                $(".box-container-give").on("keyup", function (key) {
                    if (key.keyCode == 13 && entercount === 0) {
                        $("#confirm_id").click()
                        const audio = new Audio();
                        audio.src = "./sound/Click.mp3";
                        audio.play()
                        audio.volume = 0.1;
                        entercount += 1;
                        setTimeout(() => {
                            entercount = 0;
                        }, 1000);
                    }
                });
                $('#min').click(function () {
                    const audio = new Audio();
                    audio.src = "./sound/Click.mp3";
                    audio.play()
                    audio.volume = 0.1;
                    $("#EEEA").html('');
                    $("#EEEA").append(`<input id="count"  value="1">`);
                    document.getElementById("count").focus()
                })
                $('#max').click(function () {
                    const audio = new Audio();
                    audio.src = "./sound/Click.mp3";
                    audio.play()
                    audio.volume = 0.1;
                    $("#EEEA").html('');
                    $("#EEEA").append(`<input id="count"  value="${itemData.count}">`);
                })
            }
        }
    });

    $("#count").on("keypress keyup blur", function (event) {
        $(this).val($(this).val().replace(/[^\d].+/, ""));
        if ((event.which < 48 || event.which > 57)) {
            event.preventDefault();
        }
    });
});

irmBTN = () => {
    if ($("#count").val() !== "") {
        if (PfDialogType === "Give") {
            $.post("https://Fxw_inventory/GiveItem", JSON.stringify({
                player: player,
                item: PFitemData,
                number: parseInt(document["querySelector"]("#count")["value"])
            }));
        } else if (PfDialogType === "DropItem") {
            disableInventory(300);
            $.post("https://Fxw_inventory/DropItem", JSON.stringify({
                item: PFitemData,
                number: parseInt(document["querySelector"]("#count")["value"])
            }));
        } else if (PfDialogType === "PutInto") {
            disableInventory(500);
            $.post(`https://Fxw_inventory/PutInto${capitalizeFirstLetter(type)}`, JSON.stringify({
                item: PFitemData,
                number: parseInt(document["querySelector"]("#count")["value"])
            }));
        } else if (PfDialogType === "TakeFrom") {
            disableInventory(500);
            $.post(`https://Fxw_inventory/TakeFrom${capitalizeFirstLetter(type)}`, JSON.stringify({
                item: PFitemData,
                number: parseInt(document["querySelector"]("#count")["value"])
            }));
        } else if (PfDialogType === "DropItem") {
            disableInventory(300);
            $.post("https://Fxw_inventory/DropItem", JSON.stringify({
                item: PFitemData,
                number: parseInt(document["querySelector"]("#count")["value"])
            }));
        }
        $("#modalCount").modal("hide");
        $("#count").val("");
    }
}

function capitalizeFirstLetter(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
}




$('body').on('click', '[data-category]', function () {
    var type = $(this).attr('data-category');

    const audio = new Audio();
    audio.src = "./sound/Click.mp3";
    audio.play()
    audio.volume = 0.1;

    if (type === "inventory_all") {
        $('[data-item-type]').fadeIn(0).addClass('fast');
    } else {
        $('[data-item-type]').fadeOut(0).addClass('fast');
        $('[data-item-type="' + type + '"]').fadeIn(0).addClass('fast');
    }
    type_value = type;

    $(oldClass).removeClass('selected');
    $(this).addClass('selected');
    oldClass = this
});


$.widget('ui.dialog', $.ui.dialog, {
    options: {
        // Determine if clicking outside the dialog shall close it
        clickOutside: false,
        // Element (id or class) that triggers the dialog opening 
        clickOutsideTrigger: ''
    },
    open: function () {
        var clickOutsideTriggerEl = $(this.options.clickOutsideTrigger),
            that = this;
        if (this.options.clickOutside) {
            // Add document wide click handler for the current dialog namespace
            $(document).on('click.ui.dialogClickOutside' + that.eventNamespace, function (event) {
                var $target = $(event.target);
                if ($target.closest($(clickOutsideTriggerEl)).length === 0 &&
                    $target.closest($(that.uiDialog)).length === 0) {
                    that.close();
                }
            });
        }
        // Invoke parent open method
        this._super();
    },
    close: function () {
        // Remove document wide click handler for the current dialog
        $(document).off('click.ui.dialogClickOutside' + this.eventNamespace);
        // Invoke parent close method 
        this._super();
    },
});


