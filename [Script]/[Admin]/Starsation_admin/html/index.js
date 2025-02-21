let itemImageURL = "nui://Fewthz_inventory/html/img/items/";
var id = 0,
    playerData = [];
$(function () {
    let e = {
        mod: '<i class="fas fa-user-shield"></i>',
        admin: '<i class="fas fa-user-cog"></i>',
        superadmin: '<i class="fas fa-star"></i>',
    };
    function a(e) {
        e ? $("#container").show() : ($("#container, #actions, #items, #inputmanager, #bans").hide(), $(".server").fadeOut(), $("#server").show(), i(true), (id = 0));
    }
    function t(e, a, t, n) {
        i();
        $("#inputmanager").attr("action", n).slideDown();
        $("#inputtitle").html(e);
        $("#datainput").val("").attr("placeholder", a).attr("type", t);
    }
    function i(e, a, t) {
        if (e) {
            if (($(".back").fadeOut(), $("#inputmanager").is(":Visible"))) {
                return void $("#inputmanager").slideUp();
            }
            if ($("#confirmaction").is(":Visible")) {
                return void $("#confirmaction").slideUp();
            }
            let e = $("#back").attr("href"),
                a = $("#back").attr("current-window");
            a && ($(e).fadeIn(), $(a).hide(), $("#back").removeAttr("current-window"));
        } else {
            a && t && ($(t).hide(), $(a).fadeIn(), $("#back").attr("current-window", a).attr("href", t));
            $(".back").fadeIn();
        }
    }
    window.addEventListener("message", function (t) {
        let i = t.data;
        if ("ui" === i.type) 1 == i.status ? a(!0) : a(!1);
        else {
            if ("data" === i.type) {
                $("#pinner").html("");
                let a = i.data,
                    t = "";
                $.each(a, function (a, i) {
                    e[i.group] && (t = e[i.group]),
                        $("#online").html(i.online),
                        ($("#pinner").append('<div class = "item" data-playerid=' + i.playerid + " data-playername=" + i.name + '><span class="playerid"> ' + i.playerid + "</span><span>" + t + " " + i.name + "</span></div>"),
                        (playerData[i.playerid] = i));
                });
            } else {
                if ("bans" === i.type) {
                    $("#banlist").html("");
                    let e,
                        a = i.banlist;
                    $.each(a, function (a, t) {
                        (e = 0 == t.time ? "Permanently" : t.time < 0 ? "Expired" : "for " + t.time + " mins"),
                            $("#banlist").append(
                                '<div class = "banitem" data-license=' +
                                    t.license +
                                    '><span class="bannedplayer">' +
                                    t.name +
                                    '</span><span class="time">' +
                                    e +
                                    '</span><span class="reason">' +
                                    t.reason +
                                    "</span></div>"
                            );
                    });
                } else {
                    if ("items" === i.type) {
                        function searchITEM(name) {
                            $("#itemlist").html("");
                            let e = i.itemslist.filter(item => item.name.includes(name));
                            $.each(e, function (e, a) {
                              $("#itemlist").append(
                                `<div id="inventoryitemwrap"><div class = "inventoryitem" data-itemname=${a.name}><div class="img"><img src="nui://Fewthz_inventory/html/img/items//${a.name}.png" width="100px" height="100px" /></div><div class = "name">${a.label}</div></div></div>`
                              );
                              let t = new Image();
                              (t.src = `nui://Fewthz_inventory/html/img/items//${a.name}.png`),
                                (t.onerror = function () {
                                  $('.inventoryitem[data-itemname="' + a.name + '"] > .img').html(
                                    '<i class="fas fa-box centered" style="color:#ffffff;font-size:48px;"></i>'
                                  );
                                });
                            }),
                              $("#weaponlist").html("");
                          }
                        
                          document.getElementById('itemSearch').addEventListener('keyup', e => searchITEM(e.target.value));
                          $("#itemlist").html("");
                          let e = i.itemslist;
                          $.each(e, function (e, a) {
                            $("#itemlist").append(
                              `<div id="inventoryitemwrap"><div class = "inventoryitem" data-itemname=${a.name}><div class="img"><img src="nui://Fewthz_inventory/html/img/items//${a.name}.png" width="100px" height="100px" /></div><div class = "name">${a.label}</div></div></div>`
                            );
                            let t = new Image();
                            (t.src = `nui://Fewthz_inventory/html/img/items//${a.name}.png`),
                              (t.onerror = function () {
                                $('.inventoryitem[data-itemname="' + a.name + '"] > .img').html(
                                  '<i class="fas fa-box centered" style="color:#ffffff;font-size:48px;"></i>'
                                );
                              });
                          }),
                        $("#itemlistall").html("");
                        let _0x57f79c = i.itemslist;
                        $.each(_0x57f79c, function (e, a) {
                            $("#itemlistall").append(
                                '<div id="inventoryitemwrap"><div class = "inventoryitem" data-itemname=' +
                                    a.name +
                                    '><div class="img"><img src="' +
                                    itemImageURL +
                                    a.name +
                                    '.png" width="96px" height="96px" /></div><div class = "name">' +
                                    a.label +
                                    "</div></div></div>"
                            );
                            let t = new Image();
                            t.src = itemImageURL + a.name + ".png";
                            t.onerror = function () {
                                $('.inventoryitem[data-itemname="' + a.name + '"] > .img').html('<i class="fas fa-box centered" style="color:#ffffff;font-size:48px;"></i>');
                            };
                        });
                        $("#weaponlist").html("");
                        let a = i.weaponlist;
                        $.each(a, function (e, a) {
                            $("#weaponlist").append(
                                '<div id="inventoryitemwrap"><div class = "inventoryitem" data-weaponname=' +
                                    a.name +
                                    '><div class="img"><img src="' +
                                    itemImageURL +
                                    a.name +
                                    '.png" width="96px" height="96px" /></div><div class = "name">' +
                                    a.label +
                                    "</div></div></div>"
                            );
                            let t = new Image();
                            t.src = itemImageURL+ a.name + ".png";
                            t.onerror = function () {
                                $('.inventoryitem[data-weaponname="' + a.name + '"] > .img').html("");
                                $('.inventoryitem[data-weaponname="' + a.name + '"] > .name').addClass("centered");
                            };
                        });
                        $("#jobs").html("");
                        let _0xa35796 = i.joblist,
                            _0x24f660 = [];
                        $.each(_0xa35796, function (_0x5edef6, _0xff168e) {
                            $("#jobs").append('<option value="' + _0xff168e.name + '">' + _0xff168e.label + "</option>");
                            _0x24f660[_0xff168e.name] = _0xff168e.ranks;
                        });
                        $("#jobs").on("change", function () {
                            let _0x5eb10e = $(this).val();
                            $("#ranks").html("");
                            $.each(_0x24f660[_0x5eb10e], function (_0xa7b5a7, _0xdd11d9) {
                                $("#ranks").append('<option value="' + _0xdd11d9.grade + '">' + _0xdd11d9.label + "</option>");
                            });
                        });
                        $("#vehiclelist").html("");
                        $("#vehiclelist").html(
                            '<div id="inventoryitemwrap"><div class = "inventoryitem" data-vehiclename="blank"><div class="img"><i class="fas fa-trash-alt centered" style="color:#ffffff;font-size:48px;"></i></div><div class = "name">ลบรถ</div></div></div>'
                        );
                        let _0x5c87d0 = i.vehiclelist;
                        $.each(_0x5c87d0, function (_0x55a41a, _0x4d970c) {
                            $("#vehiclelist").append(
                                '<div id="inventoryitemwrap"><div class = "inventoryitem" data-vehiclename=' +
                                    _0x4d970c.model +
                                    '><div class="img"><i class="fas fa-car centered" style="color:#ffffff;font-size:48px;"></i></div><div class = "name">' +
                                    _0x4d970c.label +
                                    "</div></div></div>"
                            );
                        });

                        $("#pedlist").html(""); 
                        $("#pedlist").html(
                            '<div id="inventoryitemwrap"><div class = "inventoryitem" data-pedname="blank"><div class="img"><i class="fas fa-solid fa-user centered" style="color:#ffffff;font-size:48px;"></i></div><div class = "name">กลับร้างเดิม</div></div></div>'
                            );
                        let p = i.pedlist;
                        $.each(p, function(e, a) {
                            $("#pedlist").append(
                                `<div id="inventoryitemwrap"><div class = "inventoryitem" data-pedname=${a.model}><div class="img"><i class="fas fa-solid fa-user centered" style="color:#ffffff;font-size:48px;"></i></div><div class = "name">${a.label}</div></div></div>`);
                        });

                    } else {
                        if ("coords" == i.type) {
                            let _0x258152 = i.coordData;
                            $(".coords")
                                .attr("coordData", _0x258152.x + ", " + _0x258152.y + ", " + _0x258152.z)
                                .html("<b>X: " + _0x258152.x.toFixed(2) + " Y: " + _0x258152.y.toFixed(2) + " Z: " + _0x258152.z.toFixed(2) + "</b>");
                        }
                    }
                }
            }
        }
    });
    $("body").on("input", "#search", function () {
        let e,
            a,
            t = $(this).val().toLowerCase();
        $(".item").each(function () {
            (e = $(this).data("playername").toLowerCase()),
                (a = parseInt($(this).data("playerid"))),
                parseInt(t) != a ? ($(this).hide(), e.indexOf(t) < 0 ? $(this).hide() : $(this).show()) : $(this).show();
        });
    });
    $("body").on("input", "#searchitemall", function () {
        let e,
            a,
            t = $(this).val().toLowerCase();
        $(".item").each(function () {
            e = $(this).data("itemname").toLowerCase();
            a = parseInt($(this).data("itemname"));
            parseInt(t) != a ? ($(this).hide(), e.indexOf(t) < 0 ? $(this).hide() : $(this).show()) : $(this).show();
        });
    });
    $("#confirminput").click(function () {
        let e = $("#datainput").val(),
            a = $("#inputmanager").attr("action");
        $.post("https://Starsation_admin/" + a, JSON.stringify({ playerid: id, inputData: e })), i(!0)
    });
    $("#confirm").click(function () {
        let _0x4320d = $("#confirmaction").attr("data"),
            _0x2474a3 = $("#confirmaction").attr("action");
        const _0x41c690 = {
            playerid: id,
            confirmoutput: _0x4320d,
        };
        $.post("https://Starsation_admin/" + _0x2474a3, JSON.stringify(_0x41c690));
        i(true);
        $.post("https://Starsation_admin/" + _0x2474a3, JSON.stringify(_0x41c690)), i(true);
    });
    $("body").on("click", "#cancelinput", function () {
        i(true);
    });
    $("body").on("click", ".server", function () {
        i(true), $("#actions, #items, #bans, .server").hide(), $("#server").show(), $(".item").removeClass("selected");
    });
    $("body").on("click", ".item", function () {
        $(".item").removeClass("selected"),
            $(this).addClass("selected"),
            (function (e) {
                i(true);
                id = e;
                $("#actions").fadeIn();
                $(".playername").html(playerData[e].name);
                $("#server").hide();
                $(".server").show();
                var _0x50b2e8 = new Intl.NumberFormat("en-US", {
                    style: "currency",
                    currency: "USD",
                });
                $('.data[data-name="name"]').html(playerData[e].rpname);
                $('.data[data-name="jobs"]').html(playerData[e].jobs);
                $('.data[data-name="phone"]').html(playerData[e].phone);
                $('.data[data-name="license"]').html(playerData[e].identifier);
                $('.data[data-name="money"]').html(_0x50b2e8.format(playerData[e].cash) + " บาท (Cash) - " + _0x50b2e8.format(playerData[e].bank) + " บาท (Bank)");
            })($(this).data("playerid"));
    });
    $("body").on("click", ".banitem", function () {
        let _0x679e88 = $(this).data("license"),
            _0x1c0329 = $(this).find(".bannedplayer").text();
        var _0x33eb73, _0x200ddc, _0x21097d;
        _0x33eb73 = "unban";
        _0x200ddc = _0x679e88;
        _0x21097d = "Are you sure you want to unban " + _0x1c0329 + "?";
        i();
        $("#confirmaction").attr("action", _0x33eb73).attr("data", _0x200ddc).slideDown();
        $("#confirmaction #inputtitle").html(_0x21097d);
    });
    $("#items").on("click", ".inventoryitem", function () {
        let _0x2efd8d = $(this).data("itemname"),
            _0xbcb40d = parseInt($("#qty").val());
        const _0x45403e = {
            playerid: id,
            name: _0x2efd8d,
            amount: _0xbcb40d,
        };
        $.post("https://Starsation_admin/giveitem", JSON.stringify(_0x45403e));
    });
    $("#itemsall").on("click", ".inventoryitem", function () {
        let _0x4d9a3b = $(this).data("itemname"),
            _0x5e69d0 = parseInt($("#qtyall").val());
        const _0x448647 = {
            playerid: id,
            name: _0x4d9a3b,
            amount: _0x5e69d0,
        };
        $.post("https://Starsation_admin/giveitemall", JSON.stringify(_0x448647));
    });
    $("#weapons").on("click", ".inventoryitem", function () {
        let _0x3e536c = $(this).data("weaponname");
        const _0x147e37 = {
            playerid: id,
            weapon: _0x3e536c,
        };
        $.post("https://Starsation_admin/weapon", JSON.stringify(_0x147e37));
    });
    $("#vehicles").on("click", ".inventoryitem", function () {
        let e = $(this).data("vehiclename");
        $.post("https://Starsation_admin/spawnvehicle", JSON.stringify({ model: e }))
    });

    $("#peds").on("click", ".inventoryitem", function() {
        let e = $(this).data("pedname");
        $.post("https://Starsation_admin/setplayerped", JSON.stringify({ model: e }))
    }),

    $("body").on("click", ".btn", function () {
        let e, a, n, s = $(this).data("action");
        switch (s) {
            case "kick":
                t((a = "เตะ " + playerData[id].name + ""), (e = "สาเหตุ"), (n = "text"), s);
                break;
            case "kickall":
                t((a = "เตะผู้เล่นทั้งหมด"), (e = "สาเหตุ"), (n = "text"), s);
                break;
            case "addCash":
                t((a = "ให้เงิน" + playerData[id].name), (e = "100$"), (n = "number"), s);
                break;
            case "addBlack":
                t((a = "ให้เงินแดง " + playerData[id].name), (e = "100$"), (n = "number"), s);
                break;
            case "addBank":
                t(a = "ให้เงินธนาคาร " + playerData[id].name, e = "100$", n = "number", s);
                break;
            case "announce":
                t((a = "ประกาศ"), (e = "ใส่ข้อความ"), (n = "text"), s);
                break;
            case "delcarall":
                t((a = "ต้องใช้เวลาเท่าไหร่"), (e = "10"), (n = "number"), s);
                break;
            case "delcaralldist":
                t((a = "ระยะเท่าไหร่"), (e = "1"), (n = "number"), s);
                break;
            case "crash":
                t((a = "ไอดีผู้เล่นที่จะทำให้ค้าง"), (e = "1"), (n = "number"), s);
                break;
            case "restartserver":
                t((a = "ต้องใช้เวลาเท่าไหร่"), (e = "10"), (n = "number"), s);
                break;
            case "speedcar":
                t((a = "ปรับความเร็ว"), (e = "1"), (n = "number"), s);
                break;
            case "addhunger":
                t((a = "เปอร์เซ็น"), (e = "1 - 100"), (n = "number"), s);
                break;
            case "removestress":
                t((a = "เปอร์เซ็น"), (e = "1 - 100"), (n = "number"), s);
                break;
            case "revivedist":
                t((a = "ระยะเท่าไหร่"), (e = "1"), (n = "number"), s);
                break;
            case "giveitemall":
                i(false, "#itemsall", "#server");
                break;
            case "promote":
                let o = $(this).data("level");
                $.post("https://Starsation_admin/promote", JSON.stringify({ playerid: id, level: o }));
                break;
            case "giveWeapon":
                i(false, "#weapons", "#actions");
                break;
            case "giveItem":
                i(false, "#items", "#actions");
                break;
            case "spawnVehicle":
                i(!1, "#vehicles", "#server");
                break;
            case "setplayerped":
                i(!1, "#peds", "#server");
                break;
            case "inventory":
                const q = {};
                (q.playerid = id), $.post("https://Starsation_admin/inventory", JSON.stringify(q));
                break;
            case "ban":
                t((a = "ตั้งเวลาแบนเป็นนาที"), (e = "100"), (n = "number"), s);
                break;
            case "permaban":
                t((a = "แบน " + playerData[id].name + " ด้วยเหตุผล"), (e = "เหตุผล"), (n = "text"), s);
                break;
            case "banlist":
                i(false, "#bans", "#server");
                break;
            case "vehicleslist":
                i(false, "#vehicle", "#server");
                break;
            case "weatherslist":
                i(false, "#weathers", "#server");
                break;
            case "allplayerlist":
                i(false, "#allplayer", "#server");
                break;
            case "deletecarlist":
                i(false, "#deletecar", "#server");
                break;
            case "reserverlist":
                i(false, "#reserver", "#server");
                break;
            case "setJob":
                let r = $("select#jobs option").filter(":selected").val(),
                    l = $("select#ranks option").filter(":selected").val();
                const x = {};
                (x.playerid = id), (x.job = r), (x.rank = l), $.post("https://Starsation_admin/setJob", JSON.stringify(x));
                break;
            case "setTime":
                t((a = "เปลี่ยนเวลาในเกม <br /> (เวลา 24 ชั่วโมง)"), (e = "12:00"), (n = "time"), s);
                break;
            case "changeWeather":
                let _0x20bdc6 = $("select#weatherTypes option").filter(":selected").val();
                const _0x1df80e = {};
                (_0x1df80e.playerid = id), (_0x1df80e.weather = _0x20bdc6), $.post("https://Starsation_admin/changeWeather", JSON.stringify(_0x1df80e));
                break;
            default:
                // const _0x11dbd9 = {};
                // (_0x11dbd9.playerid = id), $.post("https://Starsation_admin/" + s, JSON.stringify(_0x11dbd9));

                $.post("https://Starsation_admin/" + s, JSON.stringify({ playerid: id }))
        }
    }),
    $("#back").on("click", function () {
        i(true);
    }),
    $("#clipboard").click(function () {
        let e = $(".coords").attr("coordData");
        var a = $("<input>");
        $("body").append(a),
          a.val(e).select(),
          document.execCommand("copy"),
          a.remove();
      });
    $("#inner").append("");
    document.onkeyup = function (_0x4b1efc) {
        if (27 == _0x4b1efc.which) {
            return $.post("https://Starsation_admin/exit", JSON.stringify({})), void a(false);
        }
    },
    $("#tpwp-button").click(function () {
        $.post("https://Starsation_admin/tp-wp");
    }),
    $("header").on("mousedown", function (e) {
        var a = $("#container").addClass("drag").css("cursor", "move");
        height = a.outerHeight();
        width = a.outerWidth();
        ypos = a.offset().top + height - e.pageY;
        xpos = a.offset().left + width - e.pageX;
        $(document.body)
            .on("mousemove", function (e) {
                var t = e.pageY + ypos - height,
                    i = e.pageX + xpos - width;
                const _0x307288 = {
                    top: t,
                    left: i,
                };
                a.hasClass("drag") && a.offset({ top: t, left: i })
            }).on("mouseup", function(e) { a.removeClass("drag") })
    })
});

var audio = new Audio()
$(function () {
  window.addEventListener("message", function (event) {
    var item = event.data;
    if (item.action == "sound") {
      audio.pause();
      audio = new Audio("sounds/audio.mp3");
      audio.play();
    }
  });
});
