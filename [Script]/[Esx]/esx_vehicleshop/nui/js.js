var carCategories = [];
var curCat = 0;
var blackMoney = false;
var intv = null;
var curTest = 15;

$(window).ready(function() {
    window.addEventListener('message', (event) => {
        let data = event.data;
		switch(data.action) {
		   case "load":
           $("body").show();
           $(".atlmenu").show();
		   init(data);
		   break;
		   case "startTest":
		    $("body").show();
            $(".sol").hide();
            $(".sag").hide();
		   break;
		   case "stopTest":
		    $("body").hide();
            $(".sol").show();
            $(".sag").show();
		   break;
			
		}
    });
});
 
function init(data) {
   garage = data.garage;
   carCategories = [];
   blackMoney = garage.blackMoney;
   curCat = 0;
 
    
   if(garage.blackMoney == true) {
	   $(".buy").css("display","none");
	   $("#bm").css("display","block");
       $("#price").css("display", "none");
       $("#bmprice").css("display", "block");
   }else {
	   $(".buy").css("display","unset");
	   $("#bm").css("display","none");
       $("#price").css("display", "block");
       $("#bmprice").css("display", "none");
   }
   
   if(garage.testDrive == true) {
	   $(".btn-testdrive").css("display","unset");
   }else {
	   $(".btn-testdrive").css("display","none");
   }

   if(garage.showroom == true) {
     $(".buy").css("display","none");
     $(".btn-testdrive").css("display","none");
   }

   if(garage.editPlate == true) {
       $(".btn-plaka").css("display","block");
   }else {
       $(".btn-plaka").css("display","none");
   }
   
   $.each(garage.Vehicles, function (key, val) {  carCategories[carCategories.length] = key; });
   
   loadCat(curCat);
}

$(document).on('click', '.buy', function(e){
   $.post("https://esx_vehicleshop/buy", JSON.stringify({blackMoney: blackMoney}), function(x){ 
        if(x == true) {  
            $("body").hide();
        }else {
            $(".buy").animate({ color: "white",  backgroundColor: "rgb( 255, 0, 0 )" });
            setTimeout(() => {
                $(".buy").animate({ color: "white",  backgroundColor: "rgb( 115,200,50 )" });
            }, 1000);
        }
    });
});

$(document).on('click', '.circle-btn', function(e){
   
   switch($(this).data("type")) {
	   case "previous":
       if(curCat == 0) {
	      curCat = carCategories.length-1; 
       }else {
	    curCat = curCat - 1;
       }	
       loadCat(curCat);
	   break;
	   case "next":
	   if(curCat == carCategories.length-1) {
	      curCat = 0; 
       }else {
	    curCat = curCat + 1;
       }
       loadCat(curCat);
	   break;
   }

});

 
function loadCat(x) {
   $(".vehlist").html("");
   $.each(garage.Vehicles[carCategories[x]], function (key, val) {
	   var active = ``;
	    
	   if(key == 0) {
		  active = `active`;
		  $.post("https://esx_vehicleshop/showCar", JSON.stringify({ name: val.name }), function(x){});
          setPrice(val.price);
          $(".vehcat").html(val.name);
		  $("#vehname").html(val.name);
    

 
		  $("#fuel").html(val.fuel + " LITRE" );
          
          var consum = parseInt(val.consumption);
          if(consum == 3) {
             consum = "HIGH";
          }else if(consum == 2) {
             consum = "MEDIUM";
          }else {
             consum = "LOW";
          }
		  
          $("#consum").html(consum);
      
 		  $("#trunk").html(val.trunk + " KG");
		  
	   }
  
	   $(".vehlist").append(`<div class="vehnamex ${active}"  data-name="${val.name}" data-price="${val.price}" data-trunk="${val.trunk}"  data-consumption="${val.consumption}" data-fuel="${val.fuel}" >${val.label}  <span style="color:lightgreen;float: right;    margin-right: 20px;">${val.price}$</span></div>`);
   });
   $(".vehtitle").html(carCategories[x]);
}


$(document).on('click', '.vehnamex', function(e){
    $(".vehnamex").removeClass("active");
    setTimeout(() => {
        $(this).addClass("active");  
    }, 100);  
    $.post("https://esx_vehicleshop/showCar", JSON.stringify({ name: $(this).data("name") }), function(x){});
    
    $(".vehcat").html($(this).data("name"));
    $("#vehname").html($(this).data("name"));
 
	$("#fuel").html($(this).data("fuel")  + " LITRE" );
	
    
    var consum = parseInt($(this).data("consumption"));
    if(consum == 3) {
       consum = "HIGH";
    }else if(consum == 2) {
       consum = "MEDIUM";
    }else {
       consum = "LOW";
    }
    $("#consum").html(consum);

	$("#trunk").html($(this).data("trunk") + " KG");

    
    setPrice($(this).data("price"));
});

$(document).on('keydown', function() {
    switch(event.keyCode) {
        case 27: 
            $("body").hide();
			$.post("https://esx_vehicleshop/close", JSON.stringify({}), function(x){});
            break;
    }
});


$(document).on('click', '.btn-testdrive', function(e){
    $("body").hide();
    $(".atlmenu").hide();
	$.post("https://esx_vehicleshop/testdrive", JSON.stringify({}), function(x){});
});


var right = false;
var left = false;
document.getElementById("tl").addEventListener("mousedown", async function(){
    left = true;
    while (left){
        $.post('https://esx_vehicleshop/left');
        await wait(7);
    } 
});

document.getElementById("tl").addEventListener("mouseup", function() { left = false;  right = false; });
 
document.getElementById("tr").addEventListener("mousedown", async function(){
    right = true;
    while (right){
        $.post('https://esx_vehicleshop/right');
        await wait(7);
    }   
});
document.getElementById("tr").addEventListener("mouseup", function() { left = false;  right = false; });
 
function wait(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

$(document).on('click', '.pick-color', function(e){
    var rgb = RGBvalues.color($(this).css("background-color"));
    $.post("https://esx_vehicleshop/setcolour", JSON.stringify({rgb: rgb}), function(x){});
});

$(document).on('click', '.pick-color2', function(e){
     if($(".colorpicker").css("display") == "none") {
        $(".colorpicker").css("display", "block");
     }else {
        $(".colorpicker").css("display", "none");
     }

});
function setPrice(x) { 
    $("#bmprice").html(`$`+x);
    $("#price").html("$"+x);
}


var plate = "";

$(document).on('click', '.btn-plaka', function(e){
   if($(this).data("type") == "show") {
	 $(".plaka").css("display", "block");  
   }
   if($(this).data("type") == "buy") {
    plate = "";
    $('.inp').each(function(i, obj) {
        plate = plate + obj.value;
    });
    
    $.post("https://esx_vehicleshop/checkPlatePrice", JSON.stringify({plate: plate}), function(x){
       if(x == true) {  $(".plaka").css("display", "none"); }     
    });  
   }
});

$(document).on('click', '.btn-plakax', function(e){
    $(".plaka").css("display", "none");
});
 
var RGBvalues = (function() {

    var _hex2dec = function(v) {
        return parseInt(v, 16)
    };

    var _splitHEX = function(hex) {
        var c;
        if (hex.length === 4) {
            c = (hex.replace('#','')).split('');
            return {
                r: _hex2dec((c[0] + c[0])),
                g: _hex2dec((c[1] + c[1])),
                b: _hex2dec((c[2] + c[2]))
            };
        } else {
             return {
                r: _hex2dec(hex.slice(1,3)),
                g: _hex2dec(hex.slice(3,5)),
                b: _hex2dec(hex.slice(5))
            };
        }
    };

    var _splitRGB = function(rgb) {
        var c = (rgb.slice(rgb.indexOf('(')+1, rgb.indexOf(')'))).split(',');
        var flag = false, obj;
        c = c.map(function(n,i) {
            return (i !== 3) ? parseInt(n, 10) : flag = true, parseFloat(n);
        });
        obj = {
            r: c[0],
            g: c[1],
            b: c[2]
        };
        if (flag) obj.a = c[3];
        return obj;
    };

    var color = function(col) {
        var slc = col.slice(0,1);
        if (slc === '#') {
            return _splitHEX(col);
        } else if (slc.toLowerCase() === 'r') {
            return _splitRGB(col);
        } else {
            console.log('!Ooops! RGBvalues.color('+col+') : HEX, RGB, or RGBa strings only');
        }
    };

    return {
        color: color
    };
}());

 

$(document).ready(function() {
    $('.colorpicker').minimalColorpicker({
        color: '#4513e9',
        onUpdateColor: function(e, color) {
            $.post("https://esx_vehicleshop/setcolour", JSON.stringify({rgb: color.rgb}), function(x){});
        }
    });
});




jQuery.fn.minimalColorpicker = function(options) {

    var defaults = {
        color: '#000000'
    };

    var settings = $.extend({}, defaults, options);

    return this.each(function() {
        var self = $(this);
        var hue = $('<div />').addClass('hue');
        var hueDrag = $('<div />').addClass('drag');
        var field = $('<div />').addClass('field');
        var fieldOverlay = $('<div />').addClass('fieldOverlay');
        var fieldDrag = $('<div />').addClass('drag');
        var input = $('<input />').val('#ffffff');
        var rgbList = $('<ul />');
        rgbList.append($('<li />').html('<strong>255</strong>R'));
        rgbList.append($('<li />').html('<strong>255</strong>G'));
        rgbList.append($('<li />').html('<strong>255</strong>B'));

        if(tinycolor(settings.color).isValid()) {
            self.color = tinycolor(settings.color).toHsl();
        }

        if(tinycolor(self.data('color')).isValid()) {
            self.color = tinycolor(self.data('color')).toHsl();
        }

        hue.append(hueDrag);
        self.append(hue);
        fieldOverlay.append(fieldDrag);
        field.append(fieldOverlay);
        self.append(field);
       // self.append(input);
       // self.append(rgbList);

        self.hue = hue.get(0);
        self.hue.drag = hueDrag.get(0);

        self.fieldBase = field.get(0);
        self.field = fieldOverlay.get(0);
        self.field.drag = fieldDrag.get(0);

        self.updateHue = function(e) {
            self.setHue(e.offsetY / hue.outerHeight() * 360);
            if(self.hue.onmousemove === null) {
                self.hue.onmousemove = function(e) {
                    if(e.target === self.hue) {
                        self.setHue(e.offsetY / hue.outerHeight() * 360);
                        e.stopPropagation();
                    }
                }
            }
            self.clearMousemove('hue');
        }

        self.updateColor = function(e) {
            self.setColorPos(e.offsetX, e.offsetY);
            if(self.field.onmousemove === null) {
                self.field.onmousemove = function(e) {
                    if(e.target === self.field) {
                        self.setColorPos(e.offsetX, e.offsetY);
                        e.stopPropagation();
                    }
                }
            }
            self.clearMousemove('field');
        }

        self.setColorPos = function(x, y) {
            self.field.drag.style.setProperty('--x', x);
            self.field.drag.style.setProperty('--y', y);
            self.color = tinycolor({
                h: self.color.h,
                s: ((x / (field.outerWidth() - 1)) * 100),
                v: ((1 - y / (field.outerHeight() - 1)) * 100)
            }).toHsl();
            self.setColor();
        }

        self.setHue = function(a) {
            self.color.h = a;
            self.setColor();
        }

        self.setColor = function(e) {
            var c = tinycolor(self.color);
            chsv = c.toHsv();
            c = c.toHslString();
            self.field.drag.style.setProperty('--x', Math.round((chsv.s) * (field.outerWidth() - 1)) + 'px');
            self.field.drag.style.setProperty('--y', Math.round((1 - chsv.v) * (field.outerHeight())) + 'px');
            self.hue.drag.style.setProperty('--y', self.color.h / 360 * hue.outerHeight() + 'px');
            self.fieldBase.style.setProperty('--backgroundHue', self.color.h);
            if(options.onUpdateColor !== undefined) {
                options.onUpdateColor(e, {
                    hex: tinycolor(self.color).toHex(),
                    rgb: tinycolor(self.color).toRgb(),
                    rgbString: tinycolor(self.color).toRgbString()
                });
            }
            self.setOutput();
        }

        self.setOutput = function(e) {
            input.val('#' + tinycolor(self.color).toHex());
            rgbList.find('li:nth-child(1) strong').text(tinycolor(self.color).toRgb().r);
            rgbList.find('li:nth-child(2) strong').text(tinycolor(self.color).toRgb().g);
            rgbList.find('li:nth-child(3) strong').text(tinycolor(self.color).toRgb().b);
        }

        self.updateOutput = function(e) {
            if(input.val().length == 7 && tinycolor(input.val()).isValid()) {
                var c = tinycolor(input.val());
                self.color = c.toHsl();
                self.setColorPos(Math.round((c.toHsv().s) * (field.outerWidth() - 1)), Math.round((1 - c.toHsv().v) * (field.outerHeight())));
                self.setColor();
                self.setOutput();
            }
        }

        self.clearMousemove = function(m) {
            if(document.onmouseup === null) {
                document.onmouseup = function(e) {
                    self[m].onmousemove = null;
                    document.onmouseup = null;
                }
            }
        }

        //input.on('change keyup', self.updateOutput);
        field.on('mousedown', self.updateColor);
        hue.on('mousedown', self.updateHue);

        self.setColor();
        self.setHue(self.color.h);
        self.setOutput();

    });

}















