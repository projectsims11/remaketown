var prices = {}
var page = "menu";
var maxes = {}
var zone = null

function closeMain() {
    $("body").fadeOut()
    $(".container").addClass('closetest')
}

function openMain() {
    $("body").fadeIn()
    $(".container").removeClass('closetest')
}

$(".close").click(function() {
    $.post('http://FewZ_Shop/quit', JSON.stringify({}));
});

document.onkeyup = function(data) {
    if (data.which == 27) {
        setTimeout(3000)
        $.post('http://FewZ_Shop/quit', JSON.stringify({}));
    }
}

window.addEventListener('message', function(event) {

    var item = event.data;

    if (item.message == "show") {
        if (item.clear == true) {
            $(".home").empty();
            prices = {}
            maxes = {}
            zone = null
        }
        openMain();


        $('#cash').html(item.cash);
        $('#balance').html(item.balance);
    }
    if (item.message == "moeny") {
        $('#cash').html(formatMoney(item.cash));
        $('#balance').html(formatMoney(item.balance));
    }
    
    if (item.message == "hide") {
        closeMain();
        $("#popup").hide();
        $(".popup").empty();
        $("#Main").removeClass("blur")
    }

    if (item.message == "add") {
        $(".home").append(`<div class="card" name=${item.label} price=${item.price}  img=${item.img} item=${item.item} number=${item.number}>
                                            <div class="hover-buy" ><span class="hover-buy-text"><i class="fad fa-coins"></i>  ซื้อ</span> </div>
                                            <div class="item-price" > $${formatMoney(item.price)}</div>
                                            <div class="item-image" align="center" style="padding: 15px 0 15px 0;">
                                                <img src = "nui://${item.img}/${item.item}.png"  style = "width: 100px;height: 100px;" > 
                                                <div class = "item-name"  align = "center" > ${item.label} </div>
                                            </div>          
                                        </div>`);
        prices[item.item] = item.price;
        maxes[item.item] = item.max;
        zone = item.loc;
    }



   
});

$( document ).ready(function(event) {

    $(".home").on("click", ".card", function() {
        var Sound = new Audio('click.mp3');
            Sound.volume = 0.5;
            Sound.play();
        var $button = $(this);
        var $name = $button.attr('name')
        var $price = $button.attr('price')
        var $img = $button.attr('img')
        var $item = $button.attr('item')
        var $number = $button.attr('number')
    
        var $pricebank = Number($price)
        var $vat_price = ( $pricebank * 7 ) / 100;
        var $result = $pricebank + $vat_price 
    
    
        $("#Main").addClass("blur")
        $("#popup").fadeIn()
    
        $(".popup").append(`<img src="nui://${$img}/${$item}.png" >
        <div class="huakuypasavit">
        <div class="pricemoney"><span class = "title1" > ${$name} </span><span class="title2">$${formatMoney($price)} / ชิ้น</span>  </div>
        <div class="inpussy">
            <span class="minus">-</span><input class="number" id="count" min="1" max="100" value="1"type="number" placeholder="ใส่จำนวน"></input><span class="plus">+</span>
        </div>
        <div class="titleform"> Choose you payment</div>
        <div class="buymoney">
            <button class="BTN1" id="Button" name=${$item} money="Cash"><i class="fad fa-wallet"></i> Cash<div><i class="fas fa-usd-circle"></i> ${formatMoney($price)}</div></button>
            <button class="BTN2" id="Button" name=${$item} money="Bank"><i class="fad fa-university"></i> Bank+Vat7%<div><i class="fas fa-usd-circle"></i> ${formatMoney($result)}</div></button>
        </div>
       </div>`)
       
       $('.minus').click(function () {
            var Sound = new Audio('click.mp3');
                Sound.volume = 0.5;
                Sound.play();
            var $input = $(this).parent().find('input');
            var count = parseInt($input.val()) - 1;
            count = count < 1 ? 1 : count;
            $input.val(count);
            $input.change();
            return false;
        });
        $('.plus').click(function () {
            var Sound = new Audio('click.mp3');
                Sound.volume = 0.5;
                Sound.play();
            var $input = $(this).parent().find('input');
            $input.val(parseInt($input.val()) + 1);
            $input.change();
    
            // console.log($input.val());
            $.post("http://FewZ_Shop/SetCount", JSON.stringify({
                number: $input.val()
            }));
            return false;
        });
    });

    
});



//     $(".popup").append(`<img src="nui://${$img}/${$item}.png" >
//         <div><span class = "title1" > ${$name} </span><span class="title2">$${$price}</span>  </div>
//         <input class="number" id="count" value="1" type="number"></input>
//         <div class="sec">ต้องการชำระด้วย</div>
//         <div class="but"><button class="BTN T2" id="Button" name=${$item} money="Cash"><i class="fad fa-wallet"></i> เงินสด</button><button class="BTN T2" id="Button" name=${$item} money="Bank"><i class="fad fa-university"></i> ธนาคาร</button></div> `)
// });

$(".popup").on("click", "Button", function() {
    var Sound = new Audio('click.mp3');
        Sound.volume = 0.5;
        Sound.play();
    var $button = $(this);
    var $name = $button.attr('name')
    var $count = parseInt($(".number").val())
    var $class = $button.attr('money')

    $("#popup").hide()
    $(".popup").empty();
    $("#Main").removeClass("blur")

    $.post('http://FewZ_Shop/purchase', JSON.stringify({
        item: $name,
        count: $count,
        class: $class,
        loc: zone
    }));
});

$("#close").on("click", function() {
    var Sound = new Audio('click.mp3');
        Sound.volume = 0.5;
        Sound.play();
    $("#Main").removeClass("blur")
    $("#popup").hide()
    $(".popup").empty();
});

function formatMoney(n, c, d, t) {
    var c = isNaN(c = Math.abs(c)) ? 2 : c,
        d = d == undefined ? "." : d,
        t = t == undefined ? "," : t,
        s = n < 0 ? "-" : "",
        i = String(parseInt(n = Math.abs(Number(n) || 0).toFixed(c))),
        j = (j = i.length) > 3 ? j % 3 : 0;

    return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t);
};