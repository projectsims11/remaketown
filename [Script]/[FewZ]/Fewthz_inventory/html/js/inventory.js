var type_value = 'inventory_all';
var oldClass = '[data-category="' + type_value + '"]';


var type = "normal";
var disabled = false;
var openMenu = false;
var PutGetitem = false;
var disabledFunction = null;

var slot_per_row = 5; // ปรับ slot item ต่อแถวในโหมดช่องเก็บของเดี่ยว

var slot_css = "";
var ii = 1;
for (ii = 1; ii <= slot_per_row; ii++) {
    slot_css += "0fr ";
}

window.addEventListener("message", function(event) {
    if (event.data.action == "display") {
        type = event.data.type;
        disabled = false;

        if (type === "normal") {
            $(".inventory").removeClass("normal");      
            $(".inventory").removeClass("second");
            $(".inventory").addClass("normal");
            $(".ui").fadeIn();
            $("#col-other").hide();
            $("#col-inventory").removeClass();
        } else {
            $("#text-left").html(capitalizeFirstLetter(type) + " INVENTORY");

            $(".inventory").removeClass("normal");
            $(".inventory").removeClass("second");
            $(".inventory").addClass("second");
        }

        $(".ui").fadeIn();
    } else if (event.data.action == "hide") {
        $("#dialog").dialog("close");
        $(".ui").fadeOut(200, function() {
            $(".item").remove();
        });
        $(".ipch_dialog").fadeOut(100);

        removeopclass();
        $("#col-other").hide();
        $("#col-inventory").removeClass();
        $("#col-inventory").removeClass('opClass');

        $("#give_id").fadeOut();

        $("#count_give").fadeOut();
        

    } else if (event.data.action == "setType") {
        type = event.data.type;
        
    } else if (event.data.action == "setItems") {
        var currentWeight = event.data.pWeight
        var maxPlayerWeight = event.data.pWeightMax
        var currentPercent = Math.round(currentWeight / maxPlayerWeight * 100);
        $("#fWeight").html(currentWeight);
        $("#fMaxWeight").html(maxPlayerWeight);
        $("#boxWeight1").css("width", currentPercent +"%");

        inventorySetup(event.data.itemList, event.data.fastItems);

        $('.item').draggable({
            appendTo: 'body',
            zIndex: 99999,
            disabled: false,
            drag: function(event, ui) {
                ui.position.left = ui.position.left + 5;
                ui.position.top = ui.position.top + 5;
            },
            helper: function(e) {
                var original = $(e.target).hasClass("ui-draggable") ? $(e.target) : $(e.target).closest(".ui-draggable");
                return original.clone().css({
                    width: original.width(),
                    height: original.height(),
                });
            },
            start: function() {
                $(this).css('background-image', 'none');
            },
            stop: function() {
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
            $('[data-item-type]').hide();
            $('[data-item-type]').show();
        } else {
            $('[data-item-type]').hide();
            $('[data-item-type="' + type_value + '"]').show();
        }
    } else if (event.data.action == "setSecondInventoryItems") {
        var currentWeight = event.data.pWeight
        var maxPlayerWeight = event.data.pWeightMax
        var currentPercent = Math.round(currentWeight / maxPlayerWeight * 100);
        $("#pWeight").html(currentWeight);
        $("#pMaxWeight").html(maxPlayerWeight);
        $("#boxWeight2").css("width", currentPercent +"%");
        secondInventorySetup(event.data.itemList);

        $('.item').draggable({
            appendTo: 'body',
            zIndex: 99999,
            disabled: false,
            drag: function(event, ui) {
                ui.position.left = ui.position.left + 5;
                ui.position.top = ui.position.top + 5;
            },
            helper: function(e) {
                var original = $(e.target).hasClass("ui-draggable") ? $(e.target) : $(e.target).closest(".ui-draggable");
                return original.clone().css({
                    width: original.width(),
                    height: original.height(),
                });
            },
            start: function() {
                $(this).css('background-image', 'none');
            },
            stop: function() {
                itemData = $(this).data("item");

                if (itemData !== undefined && itemData.name !== undefined) {
                    $(this).css('background-image', 'url(\'img/items/' + itemData.name + '.png\'');
                    $("#drop").removeClass("disabled");
                    $("#use").removeClass("disabled");
                    $("#give").removeClass("disabled");
                }
            }
        });
    } else if (event.data.action == "setInfoText") {
        $(".info-div").html(event.data.text);
        var currentWeight = event.data.weight / 1000
        var maxPlayerWeight = event.data.max / 1000
        var currentPercent = Math.round(currentWeight / maxPlayerWeight * 100);
        $("#pWeight").html(currentWeight);
        $("#pMaxWeight").html(maxPlayerWeight);
        $("#boxWeight2").css("width", currentPercent + "%");
    } else if (event.data.action == "nearPlayers") {
        $("#give_id").html('');
        $("#col-inventory").addClass('opClass');
        $("#give_id").append('<div class="form-group mx-sm-3 mb-1" style="margin-top: 5%;"><input type="number" class="form-control text-center" id="give_id_player" min="1" placeholder="กรุณาใส่ไอดี"></div> <div class="text-center"> <button type="button" class="btn btn-outline-light" id="confirm_id" style="width: 90%;margin-top: 15px;">CONFIRM</button></div>');
        $("#give_id").fadeIn();
        $("#confirm_id").click(function(e) {
            e.preventDefault();
            var player = $('#give_id_player').val()
            var count = parseInt($("#count").val())
            console.log(count)
            $.post("http://Fewthz_inventory/GiveItem", JSON.stringify({
                player: parseInt($('#give_id_player').val()),
                item: event.data.item,
                number: parseInt($("#count").val())
            }));
            $("#give_id").fadeOut();
            closeInventory()
        });
    } else if (event.data.action == "showhotbar"){
        showHotbar(event.data.fastItems)
    };
});

function showHotbar(fastItems) {
    $(".hotbar").fadeIn();
    setTimeout(function(){
        $(".hotbar").fadeOut();
    }, 2500);

    setTimeout(function(){
        $("#fastHotbar").html("");
    }, 3000);

    $("#fastHotbar").html("");
    var f;
    for (f = 1; f < 8; f++) {
        var apps = `<div class="fastslot">
						<div class="item" id="itemFast-` + f + `">
                        <div class="item-icon"><i class="fad fa-plus"></i></div>
						</div>
                        <div class="item-name-bg"></div>
					</div>`;

        $("#fastHotbar").append(apps);
    }
    
	$.each(fastItems, function (index, item) {
		count = setCount(item);
		Hotbar[index] = true;
		$('#itemFast-' + item.slot).css('background-image', "url('img/items/" + item.name + ".png')");
		$('#itemFast-' + item.slot).html(
			'<div class="item-count">' + count + '</div> <div class="item-name">' + item.label + '</div>'
		);
		$('#itemFast-' + item.slot).data('item', item);
		$('#itemFast-' + item.slot).data('slots', index);
		$('#itemFast-' + item.slot).data('inventory', 'fast');
	});
}

function OnDrug() {
    sendData("Drug", "OnDrug")
}

function OnSell() {
    sendData("Drug", "OnSell")
}

function sendData(name, data) {
    $.post("http://Fewthz_inventory/" + name, JSON.stringify(data), function(datab) {
        if (datab != "ok") {
            console.log(datab);
        }
    });
}


function closeInventory() {
    $.post("http://Fewthz_inventory/NUIFocusOff", JSON.stringify({
        type: type
    }));
}

function inventorySetup(items, fastItems, search = "") {
    $("#mainInventory").html("");
    $.each(items, function (index, item) {
        
        count = setCount(item, false);
        
        if (item.label.indexOf(search) != -1 || search === "")
 

        var app = $('<div class="slot" data-item-type="' + item.category + '"><div id="item-' + index + '" class="item" style = "background-image: url(\'img/items/' + item.name + '.png\')">' +
        '<div class="item-count"></i>' + ' ' + count + '</div><div class="item-weight"><div class="icon-limit"></div></div> <div class="box-nameslot"></div><div class="item-name">' + item.label + '</div>  </div ><div class="item-name-bg"></div></div>');

         var data = [];


        if (item.usable) {
            data.push({
                "title": 'USE',
                "func": function() {
                    var itemData = $('#item-' + index).data("item");

                    if (itemData == undefined || itemData.usable == undefined) {
                        return;
                    }

                    itemInventory = $('#item-' + index).data("inventory");

                    if (itemInventory == undefined || itemInventory == "second") {
                        return;
                    }

                    if (itemData.usable) {
                        $.post("http://Fewthz_inventory/UseItem", JSON.stringify({
                            item: itemData
                        }));
                    }
                },
            });
        }


        if (item.canRemove) {
            data.push({
                "title": "GIVE",
                "func": function() {
                    var itemData = $('#item-' + index).data("item");

                    if (itemData == undefined || itemData.canRemove == undefined) {
                        return;
                    }

                    itemInventory = $('#item-' + index).data("inventory");

                    if (itemInventory == undefined || itemInventory == "second") {
                        return;
                    }

                    $("#count_give").html('');
                    $("#col-inventory").addClass('opClass');
                    $("#count_give").append('<div class="count_id_class"><div class="form-group mx-sm-3 mb-1" style="margin-top: 5%;"><div id="count_input"><input type="number" class="form-control text-center" min="1" id="count" placeholder="กรุณาใส่จำนวน"></div></div><div class="text-center"> <button type="button" class="btn btn-outline-light" id="confirm_count" style="width: 90%;margin-top: 15px;">CONFIRM</button></div></div><div class="count_id_classbt text-center" ><button type="button" class="btn btn-outline-light" id="confirm_count_max" style="margin-top: 0px;">MAX</button></div>');
                    $("#count_give").fadeIn();

                    $("#confirm_count").click(function(e) {
                        e.preventDefault();
                        if (itemData.canRemove) {
                            disableInventory(300);
                            $.post("http://Fewthz_inventory/GetNearPlayers", JSON.stringify({
                                item: itemData
                            }));
                            $("#count_give").fadeOut();
                        }
                    });

                    $("#confirm_count_max").click(function() {
                        $("#count_input").html('');
                        $("#count_input").append('<input type="number" class="form-control text-center" id="count" placeholder="กรุณาใส่จำนวน" value="' + itemData.count + '">');
                    });
                },
            });


            data.push({
                "title": "DORP",
                "func": function() {
                    var itemData = $('#item-' + index).data("item");

                    if (itemData == undefined || itemData.canRemove == undefined) {
                        return;
                    }

                    itemInventory = $('#item-' + index).data("inventory");

                    if (itemInventory == undefined || itemInventory == "second") {
                        return;
                    }

                    if (itemData.canRemove) {

                        $("#count_give").html('');
                        $("#col-inventory").addClass('opClass');
                        $("#count_give").append('<div class="count_id_class"><div class="form-group mx-sm-3 mb-1" style="margin-top: 5%;"><div id="count_input"><input type="number" class="form-control text-center" min="1" id="count" placeholder="กรุณาใส่จำนวน"></div></div><div class="text-center"> <button type="button" class="btn btn-outline-light" id="confirm_count" style="width: 90%;margin-top: 15px;">CONFIRM</button></div></div><div class="count_id_classbt text-center" ><button type="button" class="btn btn-outline-light" id="confirm_count_max" style="margin-top: 0px;">MAX</button></div>');
                        $("#count_give").fadeIn();

                        $("#confirm_count").click(function(e) {
                            e.preventDefault();
                            if (itemData.canRemove) {
                                disableInventory(300);
                                $.post("http://Fewthz_inventory/DropItem", JSON.stringify({
                                    item: item,
                                    number: parseInt($("#count").val())
                                }));
                                $("#count_give").fadeOut();
                            }
                        });

                        $("#confirm_count_max").click(function() {
                            $("#count_input").html('');
                            $("#count_input").append('<input type="number" class="form-control text-center" id="count" placeholder="กรุณาใส่จำนวน" value="' + itemData.count + '">');
                        });
                    }
                },
            });

        }

        $.createRMenu(app, data);
        $("#mainInventory").append(app);
        $('#item-' + index).data('item', item);
        $('#item-' + index).data('inventory', "main");
    });
    $("#fastSlotElements").html("");
    var p;
    for (p = 1; p < 8; p++) {
        var apps = `<div class="fastslot">
                            <div class="item" id="itemFast-` + p + `">
                           
                            <div class="item-keybind">` + p + `</div>
                            <div class="item-name-bg"></div>
                            
					</div>`;

        $("#fastSlotElements").append(apps);
    }

	Hotbar = [false, false, false, false, false];
	$.each(fastItems, function (index, item) {
		count = setCount(item);
		Hotbar[index] = true;
		$('#itemFast-' + item.slot).css('background-image', "url('img/items/" + item.name + ".png')");
		$('#itemFast-' + item.slot).html(
			'<div class="item-count">' + count + '</div>   <div class="icon-limit"></div> <div class="item-name">' + item.label + '</div>'
            
		);
		$('#itemFast-' + item.slot).data('item', item);
		$('#itemFast-' + item.slot).data('slots', index);
		$('#itemFast-' + item.slot).data('inventory', 'fast');
	});
	makeDraggables();
}



function secondInventorySetup(items) {

    $("#secondInventory").html("");

    $.each(items, function(index, item) {
        count = setCount(item);
        if (Number.isInteger(item.weight) && item.weight > 0) {
            weight = item.weight / 1000 + ' kg';
        } else {
            weight = '';
        }

        $("#secondInventory").append('<div class="slot"><div id="itemOther-' + index + '" class="item" style = "background-image: url(\'img/items/' + item.name + '.png\')">' +
            '<div class="item-count">' + count + '</div><div class="item-weight"></div><div class="item-name">' + item.label + '</div> </div ><div class="item-name-bg"></div></div>');
        $('#itemOther-' + index).data('item', item);
        $('#itemOther-' + index).data('inventory', "second");
    });

    $("#secondInventory").fadeIn();
}

function opclass() {
    $("#col-inventory").addClass('opClass');
    $("#col-other").addClass('opClass');
}

function removeopclass() {
    $("#col-inventory").removeClass('opClass');
    $("#col-other").removeClass('opClass');
}

function itemDescriptionOn(obj) {
    $(".bgDescription").fadeIn();
    itemData = $(obj).data("item");
    if (itemData.label !== undefined) {
        var element = $(" <div ><p> <span> ชื่อไอเทม: " + itemData.label + " </span></p></div> <div><p> <span> น้ำหนักไอเทม : " + (itemData.weight / 1000) + " </span></p></div> <div><p> จำนวนไอเทม : " + itemData.count + " </p></div>").fadeIn(200);
        $("#itemDescription").html("");
        $("#itemDescription").append(element);
        setTimeout(function() {
            $(element).fadeOut(100, function() { $(this).remove(); });
            $(".bgDescription").fadeOut();
        }, 3500);
    }
}


function makeDraggables() {
    $('#itemFast-1').droppable({
        hoverClass: 'FasthoverControl',
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");
            if (type === "normal" && (itemInventory === "main" || itemInventory === "fast")) {
                $.post("https://Fewthz_inventory/PutIntoFast", JSON.stringify({
                    item: itemData,
                    slot: 1,
                }));
            }
        }
    });
    $('#itemFast-2').droppable({
        hoverClass: 'FasthoverControl',
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "normal" && (itemInventory === "main" || itemInventory === "fast")) {
                $.post("https://Fewthz_inventory/PutIntoFast", JSON.stringify({

                    item: itemData,
                    slot: 2
                }));
            }
        }
    });
    $('#itemFast-3').droppable({
        hoverClass: 'FasthoverControl',
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "normal" && (itemInventory === "main" || itemInventory === "fast")) {
                $.post("https://Fewthz_inventory/PutIntoFast", JSON.stringify({
                    item: itemData,
                    slot: 3
                }));
            }
        }
    });
    $('#itemFast-4').droppable({
        hoverClass: 'FasthoverControl',
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "normal" && (itemInventory === "main" || itemInventory === "fast")) {
                $.post("https://Fewthz_inventory/PutIntoFast", JSON.stringify({
                    item: itemData,
                    slot: 4
                }));
            }
        }
    });
    $('#itemFast-5').droppable({
        hoverClass: 'FasthoverControl',
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "normal" && (itemInventory === "main" || itemInventory === "fast")) {
                $.post("https://Fewthz_inventory/PutIntoFast", JSON.stringify({
                    item: itemData,
                    slot: 5
                }));
            }
        }
    });
    $('#itemFast-6').droppable({
        hoverClass: 'FasthoverControl',
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "normal" && (itemInventory === "main" || itemInventory === "fast")) {
                $.post("https://Fewthz_inventory/PutIntoFast", JSON.stringify({
                    item: itemData,
                    slot: 6
                }));
            }
        }
    });
    $('#itemFast-7').droppable({
        hoverClass: 'FasthoverControl',
        drop: function(event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "normal" && (itemInventory === "main" || itemInventory === "fast")) {
                $.post("https://Fewthz_inventory/PutIntoFast", JSON.stringify({
                    item: itemData,
                    slot: 7
                }));
            }
        }
    });
 
}

function Interval(time) {
    var timer = false;
    this.start = function() {
        if (this.isRunning()) {
            clearInterval(timer);
            timer = false;
        }

        timer = setInterval(function() {
            disabled = false;
        }, time);
    };
    this.stop = function() {
        clearInterval(timer);
        timer = false;
    };
    this.isRunning = function() {
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
    $("#searchItems").focusout(() => {
        $(".search-box").removeClass("onfocus");
    })

    $(".searchIcon").click(() => {
        $(".search-box").addClass("onfocus");
        $("#searchItems").focus()
    })

    $("#count").focus(function () {
        $(this).val("")
    }).blur(function () {
        if ($(this).val() == "") {
            $(this).val("1")
        }
    });

    $("body").on("keyup", function (key) {
        if (Config.closeKeys.includes(key.which)) {
            closeInventory();
        } else if ([13].includes(key.which) && isModalOpen) {
            confirmBTN()
        }
    });

    $('#playerInventory').droppable({
        drop: function(event, ui) {

            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "trunk" && itemInventory === "second") {

                $("#count_give").html('');
                opclass();
                $("#count_give").append('<div class="count_id_class"><div class="form-group mx-sm-3 mb-1" style="margin-top: 5%;"><div id="count_input"><input type="number" class="form-control text-center" id="count" min="1" placeholder="กรุณาใส่จำนวน"></div></div><div class="text-center"> <button type="button" class="btn btn-outline-light" id="confirm_count" style="width: 90%;margin-top: 15px;">CONFIRM</button></div></div><div class="count_id_classbt text-center" ><button type="button" class="btn btn-outline-light" id="confirm_count_max" style="margin-top: 0px;">MAX</button></div>');
                $("#count_give").fadeIn();

                $("#confirm_count").click(function(e) {
                    e.preventDefault();

                    $.post("http://Fewthz_inventory/TakeFromTrunk", JSON.stringify({
                        item: itemData,
                        number: parseInt($("#count").val())
                    }));
                    $("#count_give").fadeOut();
                    removeopclass();
                });
                $("#confirm_count_max").click(function() {
                    $("#count_input").html('');
                    $("#count_input").append('<input type="number" class="form-control text-center" id="count" placeholder="กรุณาใส่จำนวน" value="' + itemData.count + '">');
                });

            } else if (type === "player" && itemInventory === "second") {
                $("#count_give").html('');
                opclass();
                $("#count_give").append('<div class="count_id_class"><div class="form-group mx-sm-3 mb-1" style="margin-top: 5%;"><div id="count_input"><input type="number" class="form-control text-center" min="1"  id="count" placeholder="กรุณาใส่จำนวน"></div></div><div class="text-center"> <button type="button" class="btn btn-outline-light" id="confirm_count" style="width: 90%;margin-top: 15px;">CONFIRM</button></div></div><div class="count_id_classbt text-center" ><button type="button" class="btn btn-outline-light" id="confirm_count_max" style="margin-top: 0px;">MAX</button></div>');
                $("#count_give").fadeIn();

                $("#confirm_count").click(function(e) {
                    e.preventDefault();

                    $.post("http://Fewthz_inventory/TakeFromPlayer", JSON.stringify({
                        item: itemData,
                        number: parseInt($("#count").val())
                    }));
                    $("#count_give").fadeOut();
                    removeopclass();
                });
                $("#confirm_count_max").click(function() {
                    $("#count_input").html('');
                    $("#count_input").append('<input type="number" class="form-control text-center" id="count" placeholder="กรุณาใส่จำนวน" value="' + itemData.count + '">');
                });
            } else if (type === "thief" && itemInventory === "second") {
                $("#count_give").html('');
                opclass();
                $("#count_give").append('<div class="count_id_class"><div class="form-group mx-sm-3 mb-1" style="margin-top: 5%;"><div id="count_input"><input type="number" class="form-control text-center" min="1"  id="count" placeholder="กรุณาใส่จำนวน"></div></div><div class="text-center"> <button type="button" class="btn btn-outline-light" id="confirm_count" style="width: 90%;margin-top: 15px;">CONFIRM</button></div></div><div class="count_id_classbt text-center" ><button type="button" class="btn btn-outline-light" id="confirm_count_max" style="margin-top: 0px;">MAX</button></div>');
                $("#count_give").fadeIn();

                $("#confirm_count").click(function(e) {
                    e.preventDefault();

                    $.post("http://Fewthz_inventory/ThiefFromPlayer", JSON.stringify({
                        item: itemData,
                        number: parseInt($("#count").val())
                    }));
                    $("#count_give").fadeOut();
                    removeopclass();
                });
                $("#confirm_count_max").click(function() {
                    $("#count_input").html('');
                    $("#count_input").append('<input type="number" class="form-control text-center" id="count" placeholder="กรุณาใส่จำนวน" value="' + itemData.count + '">');
                });
            } else if (type === "vault" && itemInventory === "second") {
                $("#count_give").html('');
                opclass();
                $("#count_give").append('<div class="count_id_class"><div class="form-group mx-sm-3 mb-1" style="margin-top: 5%;"><div id="count_input"><input type="number" class="form-control text-center" min="1"  id="count" placeholder="กรุณาใส่จำนวน"></div></div><div class="text-center"> <button type="button" class="btn btn-outline-light" id="confirm_count" style="width: 90%;margin-top: 15px;">CONFIRM</button></div></div><div class="count_id_classbt text-center" ><button type="button" class="btn btn-outline-light" id="confirm_count_max" style="margin-top: 0px;">MAX</button></div>');
                $("#count_give").fadeIn();

                $("#confirm_count").click(function(e) {
                    e.preventDefault();

                    $.post("http://Fewthz_inventory/TakeFromVault", JSON.stringify({
                        item: itemData,
                        number: parseInt($("#count").val())
                    }));
                    $("#count_give").fadeOut();
                    removeopclass();
                });
                $("#confirm_count_max").click(function() {
                    $("#count_input").html('');
                    $("#count_input").append('<input type="number" class="form-control text-center" id="count" placeholder="กรุณาใส่จำนวน" value="' + itemData.count + '">');
                });
            } else if (type === "Shops" && itemInventory === "second") {
                $("#count_give").html('');
                opclass();
                $("#count_give").append('<div class="count_id_class"><div class="form-group mx-sm-3 mb-1" style="margin-top: 5%;"><div id="count_input"><input type="number" class="form-control text-center" min="1"  id="count" placeholder="กรุณาใส่จำนวน"></div></div><div class="text-center"> <button type="button" class="btn btn-outline-light" id="confirm_count" style="width: 90%;margin-top: 15px;">CONFIRM</button></div></div><div class="count_id_classbt text-center" ><button type="button" class="btn btn-outline-light" id="confirm_count_max" style="margin-top: 0px;">MAX</button></div>');
                $("#count_give").fadeIn();

                $("#confirm_count").click(function(e) {
                    e.preventDefault();

                    $.post("http://Fewthz_inventory/TakeFromShops", JSON.stringify({
                        item: itemData,
                        number: parseInt($("#count").val())
                    }));
                    $("#count_give").fadeOut();
                    removeopclass();
                });
                $("#confirm_count_max").click(function() {
                    $("#count_input").html('');
                    $("#count_input").append('<input type="number" class="form-control text-center" id="count" placeholder="กรุณาใส่จำนวน" value="' + itemData.count + '">');
                });


            } else {
                itemSlot = ui.draggable.data("slots");
                if (type === "normal" && (itemInventory === "fast")) {
                    Hotbar[itemSlot] = false;
                    $.post("https://Fewthz_inventory/TakeFromFast", JSON.stringify({
                        item: itemData,
                    }));
                }
            }
        }
    });

    $('#otherInventory').droppable({
        drop: function(event, ui) {


            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");


            if (type === "trunk" && itemInventory === "main") {

                $("#count_give").html('');
                opclass();
                $("#count_give").append('<div class="count_id_class"><div class="form-group mx-sm-3 mb-1" style="margin-top: 5%;"><div id="count_input"><input type="number" class="form-control text-center" min="1" id="count" placeholder="กรุณาใส่จำนวน"></div></div><div class="text-center"> <button type="button" class="btn btn-outline-light" id="confirm_count" style="width: 90%;margin-top: 15px;">CONFIRM</button></div></div><div class="count_id_classbt text-center" ><button type="button" class="btn btn-outline-light" id="confirm_count_max" style="margin-top: 0px;">MAX</button></div>');
                $("#count_give").fadeIn();

                $("#confirm_count").click(function(e) {
                    e.preventDefault();

                    $.post("http://Fewthz_inventory/PutIntoTrunk", JSON.stringify({
                        item: itemData,
                        number: parseInt($("#count").val())
                    }));
                    removeopclass();
                    $("#count_give").fadeOut();
                });
                $("#confirm_count_max").click(function() {
                    $("#count_input").html('');
                    $("#count_input").append('<input type="number" class="form-control text-center" id="count" placeholder="กรุณาใส่จำนวน" value="' + itemData.count + '">');
                });


            } else if (type === "vault" && itemInventory === "main") {
                $("#count_give").html('');
                opclass();
                $("#count_give").append('<div class="count_id_class"><div class="form-group mx-sm-3 mb-1" style="margin-top: 5%;"><div id="count_input"><input type="number" class="form-control text-center" min="1" id="count" placeholder="กรุณาใส่จำนวน"></div></div><div class="text-center"> <button type="button" class="btn btn-outline-light" id="confirm_count" style="width: 90%;margin-top: 15px;">CONFIRM</button></div></div><div class="count_id_classbt text-center" ><button type="button" class="btn btn-outline-light" id="confirm_count_max" style="margin-top: 0px;">MAX</button></div>');
                $("#count_give").fadeIn();

                $("#confirm_count").click(function(e) {
                    e.preventDefault();

                    $.post("http://Fewthz_inventory/PutIntoVault", JSON.stringify({
                        item: itemData,
                        number: parseInt($("#count").val())
                    }));
                    removeopclass();
                    $("#count_give").fadeOut();
                });
                $("#confirm_count_max").click(function() {
                    $("#count_input").html('');
                    $("#count_input").append('<input type="number" class="form-control text-center" id="count" placeholder="กรุณาใส่จำนวน" value="' + itemData.count + '">');
                });

            } else if (type === "player" && itemInventory === "main") {

                $("#count_give").html('');
                opclass();
                $("#count_give").append('<div class="count_id_class"><div class="form-group mx-sm-3 mb-1" style="margin-top: 5%;"><div id="count_input"><input type="number" class="form-control text-center" min="1" id="count" placeholder="กรุณาใส่จำนวน"></div></div><div class="text-center"> <button type="button" class="btn btn-outline-light" id="confirm_count" style="width: 90%;margin-top: 15px;">CONFIRM</button></div></div><div class="count_id_classbt text-center" ><button type="button" class="btn btn-outline-light" id="confirm_count_max" style="margin-top: 0px;">MAX</button></div>');
                $("#count_give").fadeIn();

                $("#confirm_count").click(function(e) {
                    e.preventDefault();

                    $.post("http://Fewthz_inventory/PutIntoPlayer", JSON.stringify({
                        item: itemData,
                        number: parseInt($("#count").val())
                    }));
                    removeopclass();
                    $("#count_give").fadeOut();
                });
                $("#confirm_count_max").click(function() {
                    $("#count_input").html('');
                    $("#count_input").append('<input type="number" class="form-control text-center" id="count" placeholder="กรุณาใส่จำนวน" value="' + itemData.count + '">');
                });

            } else if (type === "thief" && itemInventory === "main") {

                $("#count_give").html('');
                opclass();
                $("#count_give").append('<div class="count_id_class"><div class="form-group mx-sm-3 mb-1" style="margin-top: 5%;"><div id="count_input"><input type="number" class="form-control text-center" min="1" id="count" placeholder="กรุณาใส่จำนวน"></div></div><div class="text-center"> <button type="button" class="btn btn-outline-light" id="confirm_count" style="width: 90%;margin-top: 15px;">CONFIRM</button></div></div><div class="count_id_classbt text-center" ><button type="button" class="btn btn-outline-light" id="confirm_count_max" style="margin-top: 0px;">MAX</button></div>');
                $("#count_give").fadeIn();

                $("#confirm_count").click(function(e) {
                    e.preventDefault();

                    $.post("http://Fewthz_inventory/PutIntoThief", JSON.stringify({
                        item: itemData,
                        number: parseInt($("#count").val())
                    }));
                    removeopclass();
                    $("#count_give").fadeOut();
                });
                $("#confirm_count_max").click(function() {
                    $("#count_input").html('');
                    $("#count_input").append('<input type="number" class="form-control text-center" id="count" placeholder="กรุณาใส่จำนวน" value="' + itemData.count + '">');
                });
            }
        }
    });

    $("#count").on("keypress keyup blur", function(event) {
        $(this).val($(this).val().replace(/[^\d].+/, ""));
        if ((event.which < 48 || event.which > 57)) {
            event.preventDefault();
        }
    });
});

function capitalizeFirstLetter(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
}

$('body').on('click', '[data-category]', function(){
    var type = $(this).attr('data-category');
    
    
    if (type === "inventory_all") {
        $('[data-item-type]').fadeOut('fast');
        $('[data-item-type]').fadeIn('fast');
    } else {
        $('[data-item-type]').fadeOut('fast');
        $('[data-item-type="' + type + '"]').fadeIn('fast');
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
    open: function() {
        var clickOutsideTriggerEl = $(this.options.clickOutsideTrigger),
            that = this;
        if (this.options.clickOutside) {
            // Add document wide click handler for the current dialog namespace
            $(document).on('click.ui.dialogClickOutside' + that.eventNamespace, function(event) {
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
    close: function() {
        // Remove document wide click handler for the current dialog
        $(document).off('click.ui.dialogClickOutside' + this.eventNamespace);
        // Invoke parent close method 
        this._super();
    },
});