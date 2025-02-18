var id = 0;
var K_suck_type = 0;



playerData = [];

$(function() {
    let e = { mod: '<i class="fas fa-user-shield"></i>', Admin: '<i class="fas fa-user-cog"></i>', superAdmin: '<i class="fas fa-star"></i>' };
    // item class Ksuck_menuAdmin
    //เปิด container หรือ ปิด container
    function a(e) {
        
            if (e == 1) {
                if ($("#container").show()) {
                    if (K_suck_type == 1) {
                        $("#Ksuck-container").show()
                    }
                }
            } else //K_suck_type = 0
            {
                $($("#container,#Ksuck-container,#actions, #items, #inputmanager, #bans ").hide(), $(".server").fadeOut(), $("#server").show(), i(!0), id = 0)
            }
        

        // e ?  $("#container").show() : เน้นไปที่ ($("#container, #actions, #items, #inputmanager, #bans").hide() ซ้อน , fadeOut ข้อมูล i ไม่เท่ากับ 0 และ idเท่ากับ 0
    }
    //event ส่งข้อมูล
    //t(a = "Give money to " + playerData[id].name, e = "100$", n = "number", s);
    function t(e, a, t, n) {
        i(), $("#inputmanager").attr("action", n).slideDown(), $("#inputtitle").html(e), $("#datainput").val("").attr("placeholder", a).attr("type", t)
            //i(), 
    }
    //t เรียกฟังชั้น i(), $("#inputmanager")เก็บข้อมูลไปที่ n .slideDown() และ $("#inputtitle").html(e) $("#datainput").val("") รับค่าจาก #datainput # เก็บค้าจาก placeholder เข้าไปใน a และเก็บค่าเป็น type ใน t

    //fade เมนูของหน้าต่าง player และ หน้าประ กาศ ให้เงินธนาคารต่างๆ
    function i(e, a, t) {
        if (e) {
            //แก้
            //.is(":Visible") $("#inputmanager").is(":Visible") if ($(".back").fadeOut(), $("#inputmanager").is(":Visible")) return void $("#inputmanager").slideUp();
            if ($(".back").hide(), $("#inputmanager").is(":Visible")) return void $("#inputmanager").slideUp();
            //.back fade ออกไป  $("#inputmanager").is(":Visible")) เช็ค true false :Visible ข้อมูลที่เหลือจะถูกซ้อน และ retrun  #inputmanager และทำการ slide ขึ้นเพื่อซ้อน
            //if ($("#confirmaction").is(":Visible")) return void $("#confirmaction").slideUp(); 
            // เช็คค่า confirmaction เช็ค true false  และ return ส่งคืน  $("#confirmaction").slideUp(); 

            let e = $("#back").attr("href"), //เก็บค่าข้อมูล back ใน href
                a = $("#back").attr("current-window"); // เก็บค่า current-window ใน current-window #back
            //retrun player menu  i(!1, "#weapons", "#actions"); i(!1, "#vehicles", "#server");


            a && ($(e).fadeIn(), $(a).hide(), $("#back").removeAttr("current-window"));
            //และ a and e เรียกหน้าตัวเองกลับมา a ซ้อนหน้าของตัวเอง
        }
        // เรียกเมนู weapon หรือ เมนูอื่น
        else a && t && ($(t).hide(), $(a).fadeIn(), $("#back").attr("current-window", a).attr("href", t)), $(".back").fadeIn()
            // i(!1, "#weapons", "#actions");
    }

    //เรียกใช้ Event 
    window.addEventListener("message", function(t) {
            let i = t.data; //เรียกข้อมูลมากจาก ฟังชั้น T
            //if("config" === i.type){
            //    configurl = i.texturl
            //}

            // เปิดปิด ui
            if ("ui" === i.type) {
                //เปิดปิด ui
                i.status == true ? a(!0) : a(!1);
            }
            // เมนู Item player เลือกช่องผู้เล่น
            else if ("data" === i.type) { //เรียกดูข้อมูลว่าตรงกับ data ไหม 
                $("#pinner").html("");
                let a = i.data,
                    t = "";
                $.each(a, function(a, i) { e[i.group] && (t = e[i.group]), $("#pinner").append(`<div class = "item" data-playerid=${i.playerid} data-playername=${i.name}><span class="playerid"> ${i.playerid}</span><span>${t} ${i.name}</span></div>`), playerData[i.playerid] = i })
                
            } else if ("bans" === i.type) {
                $("#banlist").html("");
                let e, a = i.banlist;
                $.each(a, function(a, t) { e = 0 == t.time ? "Permanently" : t.time < 0 ? "Expired" : "for " + t.time + " mins", $("#banlist").append(`<div class = "banitem" data-license=${t.license}><span class="bannedplayer">${t.name}</span><span class="time">${e}</span><span class="reason">${t.reason}</span></div>`) })
            }

            
            else if ("items" === i.type) {
                let configurl = i.texturl;

                $("#itemlist").html("");
                let e = i.itemslist;
                $.each(e, function(e, a) {
                        $("#itemlist").append(`<div id="inventoryitemwrap"><div class = "inventoryitem" data-itemname=${a.name}><div class="img"><img src='${configurl}${a.name}.png' width="120px" height="120px" /></div><div class = "name">${a.label}</div></div></div>`); 
                        let t = new Image;
                        result = configurl +  a.name
                        t.src = `${result}.png`, t.onerror = function() { $('.inventoryitem[data-itemname="' + a.name + '"] > .img').html('<i class="fas fa-box centered" style="color:#ffffff;font-size:48px;"></i>') }
                }),
                
                $("#weaponlist").html("");
                let a = i.weaponlist;
                $.each(a, function(e, a) {
                        $("#weaponlist").append(`<div id="inventoryitemwrap"><div class = "inventoryitem" data-weaponname=${a.name}><div class="img"><img src="${configurl}${a.name}.png" width="120px" height="120px" /></div><div class = "name">${a.label}</div></div></div>`);
                        //เพิ่มข้อมูล weaponlist
                        let t = new Image;
                        result = configurl +  a.name
                        t.src =  `${result}.png`, t.onerror = function() { $('.inventoryitem[data-weaponname="' + a.name + '"] > .img').html(""), $('.inventoryitem[data-weaponname="' + a.name + '"] > .name').addClass("centered") }
                    }),
                    $("#jobs").html("");

                let t = i.joblist,
                    n = [];
                $.each(t, function(e, a) { $("#jobs").append(`<option value="${a.name}">${a.label}</option>`), n[a.name] = a.ranks }), $("#jobs").on("change", function() {
                    let e = $(this).val();
                    $("#ranks").html(""), $.each(n[e], function(e, a) { $("#ranks").append(`<option value="${a.grade}">${a.label}</option>`) })
                }), 
                
                $("#vehiclelist").html(""), $("#vehiclelist").html('<div id="inventoryitemwrap"><div class = "inventoryitem" data-vehiclename="blank"><div class="img"><i class="fas fa-trash-alt centered" style="color:#ffffff;font-size:48px;"></i></div><div class = "name">Delete Vehicle</div></div></div>');
                let s = i.vehiclelist;
                $.each(s, function(e, a) { 
                    $("#vehiclelist").append(`<div id="inventoryitemwrap"><div class = "inventoryitem" data-vehiclename=${a.model}><div class="img"><i class="fas fa-car centered" style="color:#ffffff;font-size:48px;"></i></div><div class = "name">${a.label}</div></div></div>`) 
                })

                $("#pedlist").html(""), $("#pedlist").html('<div id="inventoryitemwrap"><div class = "inventoryitem" data-pedname="blank"><div class="img"><i class="fas fa-solid fa-user centered" style="color:#ffffff;font-size:48px;"></i></div><div class = "name">กลับร้างเดิม</div></div></div>');
                let p = i.pedlist;
                $.each(p, function(e, a) {
                    $("#pedlist").append(`<div id="inventoryitemwrap"><div class = "inventoryitem" data-pedname=${a.model}><div class="img"><i class="fas fa-solid fa-user centered" style="color:#ffffff;font-size:48px;"></i></div><div class = "name">${a.label}</div></div></div>`) 
                })
                
            } else if ("coords" == i.type) {
                let e = i.coordData;
                $(".coords").attr("coordData", e.x + ", " + e.y + ", " + e.z).html("<b>X: " + e.x.toFixed(2) + " Y: " + e.y.toFixed(2) + " Z: " + e.z.toFixed(2) + "</b>")
            }
        }),
        //ช่องค้นหา
        $("body").on("input", "#search", function() {
            let e, a, t = $(this).val().toLowerCase();
            $(".item").each(function() { e = $(this).data("playername").toLowerCase(), a = parseInt($(this).data("playerid")), parseInt(t) != a ? ($(this).hide(), e.indexOf(t) < 0 ? $(this).hide() : $(this).show()) : $(this).show() })
        }),
        $("#confirminput").click(function() {
            let k = "K";
            let e = $("#datainput").val(),
                a = $("#inputmanager").attr("action");
            $.post("https://Ksuck_menuAdmin/" + a, JSON.stringify({ playerid: id, inputData: e })), i(!0)
        }),
        $("#confirm").click(function() {
            let k = "K";
            let e = $("#confirmaction").attr("data"),
                a = $("#confirmaction").attr("action");
            $.post("https://Ksuck_menuAdmin/" + a, JSON.stringify({ playerid: id, confirmoutput: e })), i(!0)
        }),

        /*เลือกผู้เล่น และเปิดหน้าเมนู */
        $("body").on("click", "#cancelinput", function() {
            i(!0)
        }),
        /*ซ้อน player menu*/
        $("body").on("click", ".server", function() {
            i(!0), $("#actions, #items, #bans, .server ,#actions").hide(), $("#server").show(), $(".item").removeClass("selected")
                // ปิดเมนู player และไปหน้า admin

        }),
        /* เรียก profile player */
        $("body").on("click", ".item", function() {
            $(".item").removeClass("selected"), $(this).addClass("selected"),
                function(e) {
                    i(!0), id = e, $("#actions").fadeIn(), $(".playername").html(playerData[e].name), $("#server").hide() /*ปิด function server*/ , $(".server").show(); /*ปุ่ม back menu admin*/
                    var a = new Intl.NumberFormat("en-US", {
                        style: "currency",
                        currency: "USD"
                    });
                    //เรียกฟังชั้นเงิน
                    $('.data[data-name="name"]').html(playerData[e].rpname), $('.data[data-name="license"]').html(playerData[e].identifier), $('.data[data-name="money"]').html(a.format(playerData[e].cash) + " USD (Cash) - " + a.format(playerData[e].bank) + " USD (Bank)")
                }($(this).data("playerid"))
        }),

        $("body").on("click", ".banitem", function() {
            let e = $(this).data("license"),
                a = $(this).find(".bannedplayer").text();
            var t, n, s;
            t = "unban", n = e, s = "คุณแน่ใจหรือไม่ที่จะปลดแบน" + a + "?", i(), $("#confirmaction").attr("action", t).attr("data", n).slideDown(), $("#confirmaction #inputtitle").html(s)
        }),

        $("#items").on("click", ".inventoryitem", function() {
            let e = $(this).data("itemname"),
                a = parseInt($("#qty").val());
            $.post("https://Ksuck_menuAdmin/giveitem", JSON.stringify({ playerid: id, name: e, amount: a }))
        }),

        $("#weapons").on("click", ".inventoryitem", function() {
            let e = $(this).data("weaponname");
            $.post("https://Ksuck_menuAdmin/weapon", JSON.stringify({ playerid: id, weapon: e }))
        }),

        $("#vehicles").on("click", ".inventoryitem", function() {
            let e = $(this).data("vehiclename");
            $.post("https://Ksuck_menuAdmin/spawnvehicle", JSON.stringify({ model: e }))
        }),

        $("#peds").on("click", ".inventoryitem", function() {
            let e = $(this).data("pedname");
            $.post("https://Ksuck_menuAdmin/setplayerped", JSON.stringify({ model: e }))
        }),
        // main menu
        $("body").on("click", ".btn", function() {
            let e, a, n, s = $(this).data("action");
            switch (s) {
                case "openplayer":
                    if (K_suck_type == 0) {
                        K_suck_type = 1;
                        $("#Ksuck-container").fadeIn();
                    } else {
                        K_suck_type = 0;
                        $("#Ksuck-container").fadeOut();
                    }
                    break;
                case "kick":
                    t(a = "เตะผู้เล่น " + playerData[id].name + " ด้วยเหตุผล", e = "reason", n = "text", s);
                    break;
                case "addCash":
                    t(a = "ให้เงิน " + playerData[id].name, e = "100$", n = "number", s);
                    break;
                case "addBlackCash":
                    t(a = "ให้เงินแดง " + playerData[id].name, e = "100$", n = "number", s);
                    break;
                case "addBank":
                    t(a = "ให้เงินธนาคาร " + playerData[id].name, e = "100$", n = "number", s);
                    break;
                case "announce":
                    t(a = "คุณจะประกาศอะไร", e = "message", n = "text", s);
                    break;
                case "promote":
                    let o = $(this).data("level");
                    $.post("https://Ksuck_menuAdmin/promote", JSON.stringify({ playerid: id, level: o }));
                    break;
                case "giveWeapon":
                    i(!1, "#weapons", "#actions");
                    break;
                case "giveItem":
                    i(!1, "#items", "#actions");
                    break;
                case "spawnVehicle":
                    i(!1, "#vehicles", "#server");
                    break;
                case "setplayerped":
                    i(!1, "#peds", "#server");
                    break
                case "inventory":
                    $.post("https://Ksuck_menuAdmin/inventory", JSON.stringify({ playerid: id }));
                    break;
                case "ban":
                    t(a = "ตั้งเวลาแบนเป็นนาที", e = "100", n = "number", s);
                    break;
                case "permaban":
                    t(a = "แบน " + playerData[id].name + " ด้วยเหตุผล", e = "เหตุผล", n = "text", s);
                    break;
                case "banlist":
                    i(!1, "#bans", "#server");
                    break;
                case "setJob":
                    let r = $("select#jobs option").filter(":selected").val(),
                        l = $("select#ranks option").filter(":selected").val();
                    $.post("https://Ksuck_menuAdmin/setJob", JSON.stringify({ playerid: id, job: r, rank: l }));
                    break;
                case "setTime":
                    t(a = "เปลี่ยนเวลาในเกม <br /> (เวลา 24 ชั่วโมง)", e = "12:00", n = "time", s);
                    break;
                case "changeWeather":
                    let d = $("select#weatherTypes option").filter(":selected").val();
                    $.post("https://Ksuck_menuAdmin/changeWeather", JSON.stringify({ playerid: id, weather: d }));
                    break;
                    //new
                case "godmode":

                    break;
                default:
                    $.post("https://Ksuck_menuAdmin/" + s, JSON.stringify({ playerid: id }))
            }
        }),
        //#BACK
        $("#back").on("click", function() { i(!0) }), $("#clipboard").click(function() {
            let e = $(".coords").attr("coordData");
            var a = $("<input>");
            $("body").append(a), a.val(e).select(), document.execCommand("copy"), a.remove()
        });

    //main container
    $("#Header").append(""), document.onkeyup = function(e) {
            if (27 == e.which) return $.post("https://Ksuck_menuAdmin/exit", JSON.stringify({})), void a(!1)
        }, $("#tpwp-button").click(function() {
            $.post("https://Ksuck_menuAdmin/tp-wp")
        }), $(".menutitle").on("mousedown", function(e) {
            var a = $("#container").addClass("drag").css("cursor", "move");
            height = a.outerHeight(), width = a.outerWidth(), ypos = a.offset().top + height - e.pageY, xpos = a.offset().left + width - e.pageX, $(document.body).on("mousemove", function(e) {
                var t = e.pageY + ypos - height,
                    i = e.pageX + xpos - width;
                a.hasClass("drag") && a.offset({
                    top: t,
                    left: i
                })
            }).on("mouseup", function(e) {
                a.removeClass("drag")
            })
        })
        //player list  container
    $("#Ksuck-container").append(""), document.onkeyup = function(e) {
            if (27 == e.which) return $.post("https://Ksuck_menuAdmin/exit", JSON.stringify({})), void a(!1)
        }, $("#tpwp-button").click(function() {
            $.post("https://Ksuck_menuAdmin/tp-wp")
        }),
        $(".K-list").on("mousedown", function(e) {
            var a = $("#Ksuck-container").addClass("drag").css("cursor", "move");
            height = a.outerHeight(), width = a.outerWidth(), ypos = a.offset().top + height - e.pageY, xpos = a.offset().left + width - e.pageX, $(document.body).on("mousemove", function(e) {
                var t = e.pageY + ypos - height,
                    i = e.pageX + xpos - width;
                a.hasClass("drag") && a.offset({
                    top: t,
                    left: i
                })
            }).on("mouseup", function(e) {
                a.removeClass("drag")
            })
        })

});


// https://Ksuck_menuAdmin/ main