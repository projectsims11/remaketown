var InventoryImages = "SM_Admin"

var timeleft = 5000
var waiting = false
var IsShown = false

var playerSelect = undefined
var playerName = undefined
var playerPed = undefined
var jobLists = undefined
var playerLists = undefined


window.addEventListener('message', function(event) {
	let alert1 = new Audio("sound/alert1.mp3");
	alert1.volume = 0.3;
	var data = event.data;
	
	if (data !== undefined) {
		if (data.type == "Menu") {
			if (data.display == true) {
				$(".SM").fadeIn();
				SM.container.admin();
				SM.container.online();
			} else {
				$(".SM").fadeOut();
			}

		} else if (data.type == "Settings") {
			InventoryImages = data.url_images;
			playerPed = data.playerPed
			jobLists = data.joblist;

			SM.dialog.itemLists(data.itemslist);
			SM.dialog.weaponLists(data.weaponlist);
			SM.dialog.vehiclelist(data.vehiclelist);

		} else if (data.type == "playerlist") {
			playerLists = data.list
			SM.setUp.playerLists(data.list);

		} else if (data.type == "dataplayer") {
			SM.container.user(data.playerid, data.rpname, data.identifier, data.cash, data.bank, data.job, data.steamid);
			
		} else if ( data.type == "ShowHelp" ) {
			if (data.message) {
				$(".container-showHelp").fadeIn();
				$(".container-showHelp").html(`<span> ${data.message} </span>`);
				SM.HelpTimer(5000);
				if (IsShown == false) { IsShown = true }
			}

		} else if ( data.type == "ShowAnm" ) {
			if (data.message) {
				$(".container-showAnm").stop(true, true).fadeIn();
				$(".container-showAnm").html(`<span>ประกาศจากนายก : ${data.message}</span>`);
				alert1.play().then(() => {
					console.log("Audio played successfully.");
				}).catch(error => {
					console.error("Audio playback failed:", error);
				});
				
				clearTimeout(SM.announceTimer);
				SM.announceTimer = setTimeout(() => {
					$(".container-showAnm").fadeOut();
				}, 5000);
			}

		} else if ( data.type == "banLists" ) {
			$("#banlists-text").text(` Ban Lists (${data.banLists.length}) `);
			$.each(data.banLists, function(k, v) {
				$("#list-banlists").append(`
					<div class="item-banlists" id="item-banlists-${k}">
						<div class="banlists-name"> <i class="fad fa-user"></i> <span> Name: ${v.name} </span> </div>
						<div class="banlists-reason"> <i class="fad fa-file-signature"></i> <span> Reason: ${v.reason} </span> </div>
						<div class="banlists-submit" id="banlists-submit-${k}"> <span> ปลดแบน </span> </div>
					</div>
				`);

				$(`#banlists-submit-${k}`).click(function() {
					SM.PlaySound("Click_SFX");
					$.post("https://SM_Admin/unban", JSON.stringify({ 
						name : v.name,
						reason : v.reason,
						identifier : v.identifier,
					}));
					SM.container.banlist();
					setTimeout(function() { 
						$.post("https://SM_Admin/getbanlists");
					}, 1000);
				});
			});

		} 
    }
	
	document.onkeyup = function(data) {
		if (data.which == 27) {
			$.post("http://SM_Admin/NUIFocusOff");
		}
	};
});

SM = {
	PlaySound : function(key) {
		var sound = new Audio("sound/"+key+".ogg");
		sound.volume = 0.3;
		sound.play();
	},

	formatMoney : function(n, c, d, t) {
		var c = isNaN(c = Math.abs(c)) ? 2 : c,
			d = d == undefined ? "." : d,
			t = t == undefined ? "," : t,
			s = n < 0 ? "-" : "",
			i = String(parseInt(n = Math.abs(Number(n) || 0).toFixed(c))),
			j = (j = i.length) > 3 ? j % 3 : 0;
	
		return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t);
	},

	HelpTimer : function(restore) {
		if (restore != null) { timeleft = 5000 }
		if (!waiting) {
			waiting = true 
			setTimeout(function() { 
				timeleft -= 1000
				if (timeleft == 0) { 
					$(".container-showHelp").fadeOut();
					IsShown = false;
				}
				waiting = false 
				SM.HelpTimer()   
			}, 1000) 
		}
	},

	Actions : function(type) {
		// Admin Actions
		if (type == "spawnVehicle") {
			$("#dialog-itemlist").fadeOut();
			$("#dialog-weaponlist").fadeOut();

			$(".container-dialog").fadeIn();
			$("#dialog-vehiclelist").fadeIn();
			return
		} else if (type == "setWeather") {
			$("#setWeather-actions").fadeIn();
			$("#setTime-actions").fadeOut();
			return
		} else if (type == "setTime") {
			$("#setTime-actions").fadeIn();
			$("#setWeather-actions").fadeOut();
			return
		} else if (type == "banlist") {
			SM.PlaySound("Click_SFX");
			SM.container.banlist();
			$.post("https://SM_Admin/getbanlists");
			return
		} else if (type == "giveItemme") {
			SM.openMenu("giveItem", `( ${playerPed.id} ) ${playerPed.name}`, playerPed.id);
			return
		} else if (type == "giveWeaponme") {
			SM.openMenu("giveWeapon", `( ${playerPed.id} ) ${playerPed.name}`, playerPed.id);
			return
		} else if (type == "giveItemall") {
			SM.openMenu("giveItem", "ทุกคน", -1);
			return
		} else if (type == "giveWeaponall") {
			SM.openMenu("giveWeapon", "ทุกคน", -1);
			return
		} else if (type == "healme") {
			$.post("https://SM_Admin/heal", JSON.stringify({ 
				type : "one",
				playerid : playerPed.id,
			}));
			return
		} else if (type == "reviveme") {
			$.post("https://SM_Admin/revive", JSON.stringify({ 
				type : "one",
				playerid : playerPed.id,
			}));
			return
		} else if (type == "godme") {
			$.post("https://SM_Admin/godme", JSON.stringify({ 
				playerid : playerPed.id,
			}));
			return
		} else if (type == "setTimeDay") {
			$.post("https://SM_Admin/setTime", JSON.stringify({ 
				time : "12:00",
			}));
			return
		} else if (type == "setTimeNight") {
			$.post("https://SM_Admin/setTime", JSON.stringify({ 
				time : "00:00",
			}));
			return
		} else if (type == "copyCoords") {
			$.post("https://SM_Admin/copyCoords", {}, function(data) {
				$(".coords").attr("coordData", data.coords);
				let b = $(".coords").attr("coordData");
				var a = $("<input>");
				$("body").append(a); a.val(b).select(); document.execCommand("copy"); a.remove();
			});
			return
		} 
		
		// User Actions
		if (type == "spectate") {
			$.post("https://SM_Admin/spectate", JSON.stringify({ 
				playerid : playerSelect,
			}));
			return
		} else if (type == "kick") {
			$("#kickban-actions").fadeIn();
			$("#kickban-actions").html(`
				<div class="container-kickban">
					<div class="kickban-header">
						<i class="fad fa-tasks"></i>
						<span id="kickban-text"> Kick Menu </span>
						<div class="kickban-btn-submit"> <span> ยืนยัน </span> </div>
						<div class="kickban-closemenu"> <span> ปิดหน้านี้ </span> </div>
					</div>
					<input type="text" name="kickban" id="kickban" placeholder="ใส่ข้อความ">
				</div>
			`);

			$('.kickban-closemenu').click(function() {
				SM.PlaySound("Cancel_SFX");
				$("#kickban-actions").fadeOut();
			});

			$('.kickban-btn-submit').click(function() {
				SM.PlaySound("Click_SFX");
				$("#kickban-actions").fadeOut();
				$.post("https://SM_Admin/kick", JSON.stringify({ 
					text : $("#kickban").val(),
					playerid : playerSelect
				}));
			});
			return
		} else if (type == "ban") {
			$("#kickban-actions").fadeIn();
			$("#kickban-actions").html(`
				<div class="container-kickban">
					<div class="kickban-header">
						<i class="fad fa-tasks"></i>
						<span id="kickban-text"> Ban Menu </span>
						<div class="kickban-btn-submit"> <span> ยืนยัน </span> </div>
						<div class="kickban-closemenu"> <span> ปิดหน้านี้ </span> </div>
					</div>
					<input type="text" name="kickban" id="kickban" placeholder="ใส่ข้อความ">
				</div>
			`);

			$('.kickban-closemenu').click(function() {
				SM.PlaySound("Cancel_SFX");
				$("#kickban-actions").fadeOut();
			});

			$('.kickban-btn-submit').click(function() {
				SM.PlaySound("Click_SFX");
				$("#kickban-actions").fadeOut();
				$.post("https://SM_Admin/ban", JSON.stringify({ 
					text : $("#kickban").val(),
					playerid : playerSelect
				}));
			});
			return
		} else if (type == "bring") {
			$.post("https://SM_Admin/bring", JSON.stringify({ 
				playerid : playerSelect,
			}));
			return
		} else if (type == "goto") {
			$.post("https://SM_Admin/goto", JSON.stringify({ 
				playerid : playerSelect,
			}));
			return
		} else if (type == "openinventory") {
			$.post("https://SM_Admin/openinventory", JSON.stringify({ 
				playerid : playerSelect,
			}));
			return
		} else if (type == "giveItem") {
			SM.openMenu("giveItem", `( ${playerSelect} ) ${playerName}`, playerSelect);
			return
		} else if (type == "giveWeapon") {
			SM.openMenu("giveWeapon", `( ${playerSelect} ) ${playerName}`, playerSelect);
			return
		} else if (type == "giveMoney") {
			$("#giveMoney-actions").fadeIn();
			$("#giveMoney-actions").html(`
				<div class="container-giveMoney">
					<div class="giveMoney-header">
						<i class="fad fa-tasks"></i>
						<span id="giveMoney-text"> Give Money Menu </span>
						<div class="giveMoney-btn-submit"> <span> ยืนยัน </span> </div>
						<div class="giveMoney-closemenu"> <span> ปิดหน้านี้ </span> </div>
						<select name="moneyType" id="moneyType" class="moneyType">
							<option value="money"> เงินเขียว </option>
							<option value="black_money"> เงินแดง </option>
							<option value="bank"> เงินธนาคาร </option>
						</select>
					</div>
					<input type="number" name="moneyAmount" id="moneyAmount" placeholder="ใส่จำนวนเงิน">
				</div>
			`);

			$('.giveMoney-closemenu').click(function() {
				SM.PlaySound("Cancel_SFX");
				$("#giveMoney-actions").fadeOut();
			});

			$('.giveMoney-btn-submit').click(function() {
				SM.PlaySound("Click_SFX");
				$("#giveMoney-actions").fadeOut();
				$.post("https://SM_Admin/giveMoney", JSON.stringify({ 
					type : $("#moneyType").val(),
					amount : $("#moneyAmount").val(),
					playerid : playerSelect
				}));
			});
			return
		} else if (type == "giveVeh") {
			console.log("open giveVeh menu")
			return
		} else if (type == "freeze") {
			$.post("https://SM_Admin/freeze", JSON.stringify({ 
				playerid : playerSelect,
			}));
			return
		} else if (type == "kill") {
			$.post("https://SM_Admin/kill", JSON.stringify({ 
				playerid : playerSelect,
			}));
			return
		} else if (type == "revive") {
			$.post("https://SM_Admin/revive", JSON.stringify({ 
				type : "one",
				playerid : playerSelect,
			}));
			return
		} else if (type == "heal") {
			$.post("https://SM_Admin/heal", JSON.stringify({ 
				type : "one",
				playerid : playerSelect,
			}));
			return
		} else if (type == "god") {
			$.post("https://SM_Admin/god", JSON.stringify({ 
				playerid : playerSelect,
			}));
			return
		} 

		$.post("http://SM_Admin/" + type);
	},

	openMenu : function(type, text, target) {
		playerSelect = target
		if (type == "giveItem") {
			$("#dialog-weaponlist").fadeOut();
			$("#dialog-vehiclelist").fadeOut();

			$(".container-dialog").fadeIn();
			$("#dialog-itemlist").fadeIn();
			$("#dialog-itemlist-text").text(text);
		} else if (type == "giveWeapon") {
			$("#dialog-itemlist").fadeOut();
			$("#dialog-vehiclelist").fadeOut();

			$(".container-dialog").fadeIn();
			$("#dialog-weaponlist").fadeIn();
			$("#dialog-weaponlist-text").text(text);
		}
	},

	container : {
		admin : function() {
			$(".container").fadeIn();
			$(".container").html(`
				<div id="admin-actions">
					<div class="header">
						<div class="close-menu"> <i class="fad fa-sign-out-alt"></i> </div>
						<i class="fad fa-crown"></i>
						<span id="header-text"> Admin Menu </span>
					</div>
					<div class="menu-actions">
						<i class="fad fa-tasks"></i>
						<span id="actions-text"> Admin Actions </span>
						<div class="actions-list">
							<div class="actions-item-list" id="copyCoords" onclick="SM.Actions('copyCoords')"> <span> คัดลอกที่อยู่ </span> <div hidden class="coords"></div> </div>
							<div class="actions-item-list" id="spawnVehicle" onclick="SM.Actions('spawnVehicle')"> <span> เสกรถ </span> </div>
							<div class="actions-item-list" id="customsVehicle" onclick="SM.Actions('customsVehicle')"> <span> แต่งรถ </span> </div>
							<div class="actions-item-list" id="repairVehicle" onclick="SM.Actions('repairVehicle')"> <span> ซ่อมรถ </span> </div>
							<div class="actions-item-list" id="delVehicle" onclick="SM.Actions('delVehicle')"> <span> ลบรถ </span> </div>
							<div class="actions-item-list" id="delVehicle50M" onclick="SM.Actions('delVehicle50M')"> <span> ลบรถ 50 M. </span> </div>
							<div class="actions-item-list" id="nametags" onclick="SM.Actions('nametags')"> <span> ชื่อบนหัว </span> </div>
							<div class="actions-item-list" id="blipPlayers" onclick="SM.Actions('blipPlayers')"> <span> Blip ผู้เล่น </span> </div>
							<div class="actions-item-list" id="blackout" onclick="SM.Actions('blackout')"> <span> ดับไฟเมือง </span> </div>
							<div class="actions-item-list" id="setWeather" onclick="SM.Actions('setWeather')"> <span> สภาพอากาศ </span> </div>
							<div class="actions-item-list" id="setTime" onclick="SM.Actions('setTime')"> <span> ปรับเวลา </span> </div>
							<div class="actions-item-list" id="freezeTime" onclick="SM.Actions('freezeTime')"> <span> หยุดเวลา </span> </div>
							<div class="actions-item-list" id="banlist" onclick="SM.Actions('banlist')"> <span> คนโดนแบน </span> </div>
							<div class="actions-item-list" id="tpwp" onclick="SM.Actions('tpwp')"> <span> วาปไปยังจุดที่ Mark </span> </div>
							<div class="actions-item-list" id="setTimeDay" onclick="SM.Actions('setTimeDay')"> <span> เวลากลางวัน 12:00 </span> </div>
							<div class="actions-item-list" id="setTimeNight" onclick="SM.Actions('setTimeNight')"> <span> เวลากลางคืน 00:00 </span> </div>
						</div>
					</div>
					<div class="menu-self">
						<i class="fad fa-tasks"></i>
						<span id="self-text"> Admin Self </span>
						<div class="self-list">
							<div class="self-item-list" id="healme" onclick="SM.Actions('healme')"> <span> ฮีล </span> </div>
							<div class="self-item-list" id="reviveme" onclick="SM.Actions('reviveme')"> <span> ชุบชีวิต </span> </div>
							<div class="self-item-list" id="godme" onclick="SM.Actions('godme')"> <span> อมตะ </span> </div>
							<div class="self-item-list" id="noclip" onclick="SM.Actions('noclip')"> <span> ลอย </span> </div>
							<div class="self-item-list" id="giveItemme" onclick="SM.Actions('giveItemme')"> <span> ให้ไอเท็ม </span> </div>
							<div class="self-item-list" id="giveWeaponme" onclick="SM.Actions('giveWeaponme')"> <span> ให้อาวุธ </span> </div>
						</div>
					</div>
					<div class="menu-allplayer">
						<i class="fad fa-tasks"></i>
						<span id="allplayer-text"> Admin All Player </span>
						<div class="allplayer-list">
							<div class="allplayer-item-list" id="healall" onclick="SM.Actions('healall')"> <span> ฮีล ทั้งหมด </span> </div>
							<div class="allplayer-item-list" id="reviveall" onclick="SM.Actions('reviveall')"> <span> ชุบ ทั้งหมด </span> </div>
							<div class="allplayer-item-list" id="giveItemall" onclick="SM.Actions('giveItemall')"> <span> ให้ไอเท็ม </span> </div>
							<div class="allplayer-item-list" id="giveWeaponall" onclick="SM.Actions('giveWeaponall')"> <span> ให้อาวุธ </span> </div>
						</div>
					</div>
					<div class="menu-announce">
						<i class="fad fa-tasks"></i>
						<span id="announce-text"> Admin Announcement </span>
						<div class="announce-btn-submit"> <span> ประกาศ </span> </div>
						<div class="announce-boxtext">
							<textarea id="announce" name="announce" placeholder="ใส่ข้อความ"></textarea>
						</div>
					</div>
				</div>

				<div id="setWeather-actions">
					<div class="container-setWeather">
						<div class="setWeather-header">
							<i class="fad fa-tasks"></i>
							<span id="setWeather-text"> Weather Menu </span>
							<div class="setWeather-btn-submit"> <span> ยืนยัน </span> </div>
							<div class="setWeather-closemenu"> <span> ปิดหน้านี้ </span> </div>
							<select name="weatherTypes" id="weatherTypes" class="weatherTypes">
								<option value="EXTRASUNNY"> แดดออก </option>
								<option value="CLEAR"> โปร่งใส </option>
								<option value="NEUTRAL"> NEUTRAL </option>
								<option value="SMOG"> หมอกควัน </option>
								<option value="FOGGY"> หมอก </option>
								<option value="OVERCAST"> เมฆครึ้ม </option>
								<option value="CLOUDS"> เมฆ </option>
								<option value="CLEARING"> เคลียร์ </option>
								<option value="RAIN"> ฝน </option>
								<option value="THUNDER"> ฟ้าร้อง </option>
								<option value="XMAS"> คริสต์มาส </option>
								<option value="BLIZZARD"> พายุหิมะ </option>
								<option value="SNOWLIGHT"> สโนว์ไลท์ </option>
								<option value="HALLOWEEN"> ฮาโลวีน </option>
							</select>
						</div>
					</div>
				</div>

				<div id="setTime-actions">
					<div class="container-setTime">
						<div class="setTime-header">
							<i class="fad fa-tasks"></i>
							<span id="setTime-text"> Time Menu </span>
							<div class="setTime-btn-submit"> <span> ยืนยัน </span> </div>
							<div class="setTime-closemenu"> <span> ปิดหน้านี้ </span> </div>
							<select name="timeTypes" id="timeTypes" class="timeTypes">
								<option value="06:00"> Early Morning - 06:00 AM </option>
								<option value="09:00"> Morning - 09:00 AM </option>
								<option value="12:00"> Noon - 12:00 PM </option>
								<option value="15:00"> Early Afternoon - 15:00 PM </option>
								<option value="18:00"> Afternoon - 18:00 PM </option>
								<option value="21:00"> Evening - 21:00 PM </option>
								<option value="00:00"> Midnight - 00:00 PM </option>
								<option value="03:00"> Night - 03:00 PM </option>
							</select>
						</div>
					</div>
				</div>
			`);

			$('.close-menu').click(function() {
				SM.PlaySound("Cancel_SFX");
				$.post("http://SM_Admin/NUIFocusOff");
			});

			$('.actions-item-list, .self-item-list, .allplayer-item-list').click(function() {
				SM.PlaySound("Click_SFX");
			});

			$('.announce-btn-submit').click(function() {
				SM.PlaySound("Click_SFX");
				$.post("https://SM_Admin/announce", JSON.stringify({ 
					text : $("#announce").val(),
				}));
			});

			$('.setWeather-closemenu, .setTime-closemenu').click(function() {
				SM.PlaySound("Cancel_SFX");
				$("#setTime-actions").fadeOut();
				$("#setWeather-actions").fadeOut();
			});

			$('.setWeather-btn-submit').click(function() {
				SM.PlaySound("Click_SFX");
				$.post("https://SM_Admin/setWeather", JSON.stringify({ 
					weather : $("#weatherTypes").val(),
				}));
			});

			$('.setTime-btn-submit').click(function() {
				SM.PlaySound("Click_SFX");
				$.post("https://SM_Admin/setTime", JSON.stringify({ 
					time : $("#timeTypes").val(),
				}));
			});
		},

		online : function() {
			$(".container-online").fadeIn();
			$(".container-online").html(`
				<div class="online-header">
					<div class="reload-online"> <i class="fad fa-sync-alt fa-flip-horizontal"></i> </div>
					<div class="online-all"> <i class="fad fa-users"></i> <span id="online-count"> 0 </span> </div>
					<span id="online-header-text"> Online Menu </span>
				</div>
				<input type="text" name="online-search" id="online-search" placeholder="ค้นหา ไอดี | ชื่อ สตรีม | identifier">
				<div class="online-list" id="online-list"></div>
			`);

			$('.reload-online').click(function() {
				SM.PlaySound("Click_SFX");
				SM.container.admin();
				$.post("https://SM_Admin/reload-online", {}, function(data) {
					SM.setUp.playerLists(data.list);
				});
			});

			$('#online-search').keyup(function() {  
				var str = $("#online-search").val().toLowerCase();
				if (str.length <= 0) {
					$("[data-online]").show();
				} else {
					$("[data-online]").hide().filter('[data-online*="'+str+'"]').show();
				}
			});

			$.post("https://SM_Admin/reload-online", {}, function(data) {
				SM.setUp.playerLists(data.list);
			});
		},

		user : function(playerid, rpname, identifier, cash, bank, job, steamid) {
			playerSelect = playerid
			$(".container").fadeIn();
			$(".container").html(`
				<div id="user-actions">
					<div class="header">
						<div class="close-menu-user-actions"> <i class="fad fa-sign-out-alt"></i> </div>
						<i class="fad fa-user"></i>
						<span id="header-text"> User Actions Menu </span>
					</div>
					<div class="box-infos">
						<div id="box-infos-playerimg"> <img class="infos-playerimg" src="${ steamid }"> </div>
						<div class="infos-playerid"> <span> <i class="fad fa-id-card"></i> <span id="user-playerid"> ID ${ playerid } </span> </span> </div>
						<div class="infos-playername"> <span> <i class="fad fa-user"></i> <span id="user-playername"> ${ rpname } - ${ identifier } </span> </span> </div>
						<div class="infos-money"> <span> <i class="fad fa-wallet"></i> <span id="user-cash"> Cash ${ SM.formatMoney(cash) }$ </span> </span> </div>
						<div class="infos-bank"> <span> <i class="fad fa-university"></i> <span id="user-bank"> Bank ${ SM.formatMoney(bank) }$ </span> </span> </div>
					</div>
					<div class="menu-setjob">
						<div class="setjob-text"> <span> <i class="fad fa-user-md"></i> อาชีพ <span id="user-job"> ${ job.label } - ${ job.grade_label } </span> </span> </div>
						<div class="btn-setjob"> <span> แต่งตั้ง </span> </div>
						<select name="jobs" class="jobs" id="jobs"></select>
						<select name="ranks" class="ranks" id="ranks">
							<option value="0">เลือกอาชีพก่อน</option>
						</select>
					</div>
					<div class="menu-useractions">
						<i class="fad fa-tasks"></i>
						<span id="useractions-text"> Actions Menu </span>
						<div class="useractions-list">
							<div class="useractions-item-list" id="spectate" onclick="SM.Actions('spectate')"> <span> แอบมอง </span> </div>
							<div class="useractions-item-list" id="kick" onclick="SM.Actions('kick')"> <span> เตะ </span> </div>
							<div class="useractions-item-list" id="ban" onclick="SM.Actions('ban')"> <span> แบน </span> </div>
							<div class="useractions-item-list" id="bring" onclick="SM.Actions('bring')"> <span> ดึงมา </span> </div>
							<div class="useractions-item-list" id="goto" onclick="SM.Actions('goto')"> <span> ไปหา </span> </div>
							<div class="useractions-item-list" id="openinventory" onclick="SM.Actions('openinventory')"> <span> เปิดกระเป๋า </span> </div>
							<div class="useractions-item-list" id="giveItem" onclick="SM.Actions('giveItem')"> <span> ให้ไอเท็ม </span> </div>
							<div class="useractions-item-list" id="giveWeapon" onclick="SM.Actions('giveWeapon')"> <span> ให้อาวุธ </span> </div>
							<div class="useractions-item-list" id="giveMoney" onclick="SM.Actions('giveMoney')"> <span> ให้เงิน </span> </div>
							<div class="useractions-item-list" id="giveVeh" onclick="SM.Actions('giveVeh')"> <span> ให้รถ </span> </div>
							<div class="useractions-item-list" id="freeze" onclick="SM.Actions('freeze')"> <span> แช่แข็ง </span> </div>
							<div class="useractions-item-list" id="kill" onclick="SM.Actions('kill')"> <span> ฆ่า </span> </div>
							<div class="useractions-item-list" id="revive" onclick="SM.Actions('revive')"> <span> ชุบชีวิต </span> </div>
							<div class="useractions-item-list" id="heal" onclick="SM.Actions('heal')"> <span> ฮีล </span> </div>
							<div class="useractions-item-list" id="god" onclick="SM.Actions('god')"> <span> อมตะ </span> </div>
						</div>
					</div>

					<div id="kickban-actions"></div>
					<div id="giveMoney-actions"></div>
				</div>
			`);

			$('.useractions-item-list').click(function() {
				SM.PlaySound("Click_SFX");
			});

			Jobs = [];
			jobId = [];
			gradeId = [];
			$.each(jobLists, function(k, v) {
				$("#jobs").append(`<option value="${v.name}"> ${v.label} </option>`);
				Jobs[v.name] = v.ranks
				jobId[v.name] = v.label
				$("#jobs").on("change", function() {
					let key = $(this).val();
					$("#ranks").html("");
					$.each(Jobs[key], function(s, m) {
						gradeId[m.grade] = m.label
						$("#ranks").append(`<option value="${m.grade}"> ${m.label} </option>`);
					})
				});
			});

			$(".btn-setjob").click(function() {
				SM.PlaySound("Click_SFX");
				$.post("https://SM_Admin/setjob", JSON.stringify({ 
					playerid : playerSelect,
					job : $("#jobs").val(),
					grade : $("#ranks").val(),
					jobLists : jobLists
				}));
				$("#user-job").text(`${ jobId[$("#jobs").val()] } - ${ gradeId[$("#ranks").val()] }`);
			});

			$(".close-menu-user-actions").click(function() {
				SM.PlaySound("Cancel_SFX");
				SM.container.admin();
				$(".player-list").removeClass("player-list-active");
			});
		},

		banlist : function() {
			$(".container").fadeIn();
			$(".container").html(`
				<div id="ban-actions">
					<div class="header">
						<div class="close-menu"> <i class="fad fa-sign-out-alt"></i> </div>
						<i class="fad fa-user-slash"></i>
						<span id="header-text"> Ban Lists Menu </span>
					</div>
					<div class="box-banlists">
						<i class="fad fa-tasks"></i>
						<span id="banlists-text"> Ban Lists (0) </span>
						<div class="list-banlists" id="list-banlists">
							<span id="banlists-notinfo"> ไม่พบข้อมูล </span>
						</div>
					</div>
				</div>
			`);

			$('.close-menu').click(function() {
				SM.PlaySound("Cancel_SFX");
				SM.container.admin();
			});
		},
	},

	dialog : {
		itemLists : function(itemLists) {
			$("#dialog-itemlist").html(`
				<div class="dialog-closemenu" id="dialog-itemlist-closemenu"> <span> ปิดหน้านี้ </span> </div>
				<div class="dialog-header">
					<span id="dialog-text"> ให้ไอเท็มผู้เล่น | <span id="dialog-itemlist-text"> ( 1 ) Dek Dee </span> </span>
				</div>
				<input type="text" name="dialog-search" id="dialog-item-search" placeholder="ค้นหาชื่อไอเท็ม">
				<input type="number" name="dialog-count" id="dialog-count" placeholder="จำนวนไอเท็ม" value="1">
				<div class="dialog-list" id="item-list"></div>
			`);

			$("#dialog-itemlist-closemenu").click(function() {
				SM.PlaySound("Cancel_SFX");
				$(".container-dialog").fadeOut();
			});

			$.each(itemLists, function(k, v) {
				var name = v.name.toLowerCase()
				var label = v.label.toLowerCase()
				$("#item-list").append(`
					<div class="dialog-item-list" id="item-${ v.name }" data-item="${ name } ${ label }">
						<img class="dialog-itemimg" src="${InventoryImages}${v.name}.png">
						<div class="dialog-itemname"> <span> ${ v.label } </span> </div>
					</div>
				`);

				/*$("img").bind("error",function() {
					$(this).attr("src", "https://img2.pic.in.th/pic/noimg0fb609255e96a209.png");
				});*/

				$(".dialog-itemimg").on("error", function() {
					$(this).attr("src", "https://img2.pic.in.th/pic/noimg0fb609255e96a209.png");
				});

				$(`#item-${ v.name }`).click(function() {
					SM.PlaySound("Click_SFX");
					$.post("https://SM_Admin/giveItem", JSON.stringify({ 
						playerid : playerSelect,
						name : v.name,
						amount : $("#dialog-count").val()
					}));
				});
			});

			$("#dialog-item-search").keyup(function() {  
				var str = $("#dialog-item-search").val().toLowerCase();
				if (str.length <= 0) {
					$("[data-item]").show();
				} else {
					$("[data-item]").hide().filter('[data-item*="'+str+'"]').show();
				}
			});
		},

		weaponLists : function(weaponLists) {
			$("#dialog-weaponlist").html(`
				<div class="dialog-closemenu" id="dialog-weaponlist-closemenu"> <span> ปิดหน้านี้ </span> </div>
				<div class="dialog-header">
					<span id="dialog-text"> ให้อาวุธผู้เล่น | <span id="dialog-weaponlist-text"> ( 1 ) Dek Dee </span> </span>
				</div>
				<input type="text" name="dialog-search" id="dialog-weaponlist-search" placeholder="ค้นหาชื่ออาวุธ" style="width: 93%;">
				<div class="dialog-list" id="weapon-list"></div>
			`);

			$("#dialog-weaponlist-closemenu").click(function() {
				SM.PlaySound("Cancel_SFX");
				$(".container-dialog").fadeOut();
			});

			$.each(weaponLists, function(k, v) {
				var name = v.name.toLowerCase()
				var label = v.label.toLowerCase()
				$("#weapon-list").append(`
					<div class="dialog-item-list" id="weapon-${ v.name }" data-weapon="${ name } ${ label }">
						<img class="dialog-itemimg" src="${InventoryImages}${v.name}.png">
						<div class="dialog-itemname"> <span> ${ v.label } </span> </div>
					</div>
				`);

				/*$("img").bind("error",function() {
					$(this).attr("src", "https://img2.pic.in.th/pic/noimg0fb609255e96a209.png");
				});*/

				$(".dialog-itemimg").on("error", function() {
					$(this).attr("src", "https://img2.pic.in.th/pic/noimg0fb609255e96a209.png");
				});

				$(`#weapon-${ v.name }`).click(function() {
					SM.PlaySound("Click_SFX");
					$.post("https://SM_Admin/giveWeapon", JSON.stringify({ 
						playerid : playerSelect,
						name : v.name
					}));
				});
			});

			$("#dialog-weaponlist-search").keyup(function() {  
				var str = $("#dialog-weaponlist-search").val().toLowerCase();
				if (str.length <= 0) {
					$("[data-weapon]").show();
				} else {
					$("[data-weapon]").hide().filter('[data-weapon*="'+str+'"]').show();
				}
			});
		},

		vehiclelist : function(vehicleLists) {
			$("#dialog-vehiclelist").html(`
				<div class="dialog-closemenu" id="dialog-vehiclelist-closemenu"> <span> ปิดหน้านี้ </span> </div>
				<div class="dialog-header">
					<span id="dialog-text"> Spawn Vehicle (${vehicleLists.length}) </span>
				</div>
				<input type="text" name="dialog-search" id="dialog-vehicle-search" placeholder="ค้นหาชื่อพาหนะ" style="width: 93%;">
				<div class="dialog-list" id="vehicle-list"></div>
			`);

			$("#dialog-vehiclelist-closemenu").click(function() {
				SM.PlaySound("Cancel_SFX");
				$(".container-dialog").fadeOut();
			});

			$.each(vehicleLists, function(k, v) { // zack
				var model = v.model.toLowerCase();
				var label = v.label.toLowerCase();
				var Path = `nui://${GetParentResourceName()}/html/img/vehicles/${model}.png`;

				$("#vehicle-list").append(`
					<div class="dialog-item-list" id="vehicle-${ v.model }" data-vehicle="${ model } ${ label }">
						<img class="dialog-itemimg" src="${ Path }">
						<div class="dialog-itemname"> <span> ${ v.label } </span> </div>
					</div>
				`);
				
				/*$("img").bind("error",function() {
					$(this).attr("src", "https://img2.pic.in.th/pic/noimg0fb609255e96a209.png");
				});*/

				$(".dialog-itemimg").on("error", function() {
					$(this).attr("src", "https://img2.pic.in.th/pic/noimg0fb609255e96a209.png");
				});
				
				
				$(`#vehicle-${ v.model }`).click(function() {
					SM.PlaySound("Click_SFX");
					$.post("https://SM_Admin/spawnVehicle", JSON.stringify({ 
						model : v.model,
					}));
				});
			});

			$("#dialog-vehicle-search").keyup(function() {  
				var str = $("#dialog-vehicle-search").val().toLowerCase();
				if (str.length <= 0) {
					$("[data-vehicle]").show();
				} else {
					$("[data-vehicle]").hide().filter('[data-vehicle*="'+str+'"]').show();
				}
			});
		},
	},

	setUp : {
		playerLists : function(data) {
			$("#online-list").html("");
			$("#online-count").text(data.length);
			$.each(data, function(k, v) {
				var name = v.name.toLowerCase();
				var identifier = v.identifier.toLowerCase();
				$("#online-list").append(`
					<div class="player-list" id="player-id-${v.playerid}" data-online="${v.playerid} ${name} ${identifier}">
						<div class="box-playerid"> <span> ID ${v.playerid} </span> </div>
						<div class="box-playername"> <i class="fad fa-user"></i> <span> ${v.name} </span> </div>
					</div>
				`);

				$(`#player-id-${v.playerid}`).click(function() {
					playerSelect = v.playerid
					playerName = v.name
					SM.PlaySound("Select_SFX");
					$(".player-list").removeClass("player-list-active");
        			$(`#player-id-${v.playerid}`).addClass("player-list-active");
					SM.container.user(v.playerid, v.name, v.identifier, "0", "0", "", "https://cdn.discordapp.com/attachments/771682310893994005/1094207794489610341/noimg.png");

					$.post("https://SM_Admin/user", JSON.stringify({ 
						playerid : v.playerid,
					}));
				});
			});
		},
	},
}

