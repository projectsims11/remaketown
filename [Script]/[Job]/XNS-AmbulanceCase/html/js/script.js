let waitcase = 0
let commingcase = 0
let successcase = 0
let allcase = 0

var Config = new Object();
Config.closeKeys = [177, 289, 113, 27, 90];
function SendMessage(namespace, data) {
    $.post('https://XNS-AmbulanceCase/' + namespace, JSON.stringify(data));
}

$(function() {

    closemenu = function() {
        $('.container').fadeOut();
        SendMessage("close", {});
    }

    $(document).ready(function() {
        $("body").on("keyup", function(key) {
            if (Config.closeKeys.includes(key.which)) {
                closemenu();
            }
        });
    });

    window.addEventListener('message', function(event) {
        if (event.data.Action == 'OpenMenu') {
            $('.container').fadeIn();
        } else if (event.data.Action == 'SyncCase') {
            $.each(event.data.Cache, function(index, data) {
                if (data.Suscess == true) {
                    $('#case').append(`
                        <div class="casecache" data-case="`+ data.Cache +`">
                            <div class="case-box">
                                <div class="case-box1" data-icon="`+ data.Cache +`">
                                    <i class="fas fa-check successcase-text"></i>
                                </div>
                                <div class="case-box2">
                                    <div class="case-phone-box" data-phone="`+ data.Cache +`" onclick="GetGPS('`+ data.Cache +`')">
                                        <p><i class="fas fa-phone-office"></i>&nbsp;<span>`+ data.Number +`</span> | `+ data.Text +`</p>
                                    </div>
                                </div>
                                <div class="case-box3">
                                    <div class="owner-case-box" data-ownercase="`+ data.Cache +`">
                                        <p>`+ data.Owner +` - กำลังไป</p>
                                    </div>
                                </div>
                                <div class="case-box4">
                                    <div class="consoleBtnbox">
                                        <div class="consoleBtn">
                                            <button class="consoleBtn-accepte2" onclick="">
                                                <i class="fas fa-user"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="consoleBtnbox">
                                        <div class="consoleBtn">
                                            <button class="consoleBtn-suscess" onclick="Suscess('`+ data.Cache +`')">
                                                <i class="fas fa-paper-plane"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="consoleBtnbox">
                                        <div class="consoleBtn">
                                            <button class="consoleBtn-delete" onclick="Delete('`+ data.Cache +`')">
                                                <i class="fas fa-trash-alt"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    `);
                    successcase = successcase + 1
                    $('#successcase').html(successcase)
                } else if (data.Owner != null) {
                    $('#case').append(`
                        <div class="casecache" data-case="`+ data.Cache +`">
                            <div class="case-box">
                                <div class="case-box1" data-icon="`+ data.Cache +`">
                                    <i class="fas fa-plane commingcase-text"></i>
                                </div>
                                <div class="case-box2">
                                    <div class="case-phone-box" data-phone="`+ data.Cache +`" onclick="GetGPS('`+ data.Cache +`')">
                                        <p><i class="fas fa-phone-office"></i>&nbsp;<span>`+ data.Number +`</span> | `+ data.Text +`</p>
                                    </div>
                                </div>
                                <div class="case-box3">
                                    <div class="owner-case-box" data-ownercase="`+ data.Cache +`">
                                        <p>`+ data.Owner +` - กำลังไป</p>
                                    </div>
                                </div>
                                <div class="case-box4">
                                    <div class="consoleBtnbox">
                                        <div class="consoleBtn">
                                            <button class="consoleBtn-accepte2" onclick="">
                                                <i class="fas fa-user"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="consoleBtnbox">
                                        <div class="consoleBtn">
                                            <button class="consoleBtn-suscess" onclick="Suscess('`+ data.Cache +`')">
                                                <i class="fas fa-paper-plane"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="consoleBtnbox">
                                        <div class="consoleBtn">
                                            <button class="consoleBtn-delete" onclick="Delete('`+ data.Cache +`')">
                                                <i class="fas fa-trash-alt"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    `);
                    commingcase = commingcase + 1
                    $('#commingcase').html(commingcase)
                } else {
                    $('#case').append(`
                        <div class="casecache" data-case="`+ data.Cache +`">
                            <div class="case-box">
                                <div class="case-box1" data-icon="`+ data.Cache +`">
                                    <i class="fas fa-rss waitcase-text"></i>
                                </div>
                                <div class="case-box2">
                                    <div class="case-phone-box" data-phone="`+ data.Cache +`" onclick="GetGPS('`+ data.Cache +`')">
                                        <p><i class="fas fa-phone-office"></i>&nbsp;<span>`+ data.Number +`</span> | `+ data.Text +`</p>
                                    </div>
                                </div>
                                <div class="case-box3">
                                    <div class="owner-case-box" data-ownercase="`+ data.Cache +`"></div>
                                </div>
                                <div class="case-box4">
                                    <div class="consoleBtnbox">
                                        <div class="consoleBtn">
                                            <button class="consoleBtn-accepte" onclick="Accepte('`+ data.Cache +`')">
                                                <i class="fas fa-user"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="consoleBtnbox">
                                        <div class="consoleBtn">
                                            <button class="consoleBtn-suscess" onclick="Suscess('`+ data.Cache +`')">
                                                <i class="fas fa-paper-plane"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="consoleBtnbox">
                                        <div class="consoleBtn">
                                            <button class="consoleBtn-delete" onclick="Delete('`+ data.Cache +`')">
                                                <i class="fas fa-trash-alt"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    `);
                    waitcase = waitcase + 1
                    $('#waitcase').html(waitcase)
                }
                allcase = allcase + 1
                $('#allcase').html(allcase)
            });
        } else if (event.data.Action == 'UpdateCase') {
            $('#case').append(`
                <div class="casecache" data-case="`+ event.data.Cache +`">
                    <div class="case-box">
                        <div class="case-box1" data-icon="`+ event.data.Cache +`">
                            <i class="fas fa-rss waitcase-text"></i>
                        </div>
                        <div class="case-box2">
                            <div class="case-phone-box" data-phone="`+ event.data.Cache +`" onclick="GetGPS('`+ event.data.Cache +`')">
                                <p><i class="fas fa-phone-office"></i>&nbsp;<span>`+ event.data.Number +`</span> | `+ event.data.Text +`</p>
                            </div>
                        </div>
                        <div class="case-box3">
                            <div class="owner-case-box" data-ownercase="`+ event.data.Cache +`"></div>
                        </div>
                        <div class="case-box4">
                            <div class="consoleBtnbox">
                                <div class="consoleBtn" data-consoleBtnaccepte="`+ event.data.Cache +`">
                                    <button class="consoleBtn-accepte" onclick="Accepte('`+ event.data.Cache +`')">
                                        <i class="fas fa-user"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="consoleBtnbox">
                                <div class="consoleBtn">
                                    <button class="consoleBtn-suscess" onclick="Suscess('`+ event.data.Cache +`')">
                                        <i class="fas fa-paper-plane"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="consoleBtnbox">
                                <div class="consoleBtn">
                                    <button class="consoleBtn-delete" onclick="Delete('`+ event.data.Cache +`')">
                                        <i class="fas fa-trash-alt"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            `);
            waitcase = waitcase + 1
            $('#waitcase').html(waitcase)
            allcase = allcase + 1
            $('#allcase').html(allcase)
        } else if (event.data.Action == 'UpdateOwner') {
            let CaseName = event.data.Cache;
            $(`[data-ownercase="${CaseName}"]`).html(`<p>${event.data.Owner} - กำลังไป</p>`)
            $(`[data-icon="${CaseName}"]`).html(`<i class="fas fa-plane commingcase-text"></i>`)
            waitcase = waitcase - 1
            $('#waitcase').html(waitcase)
            commingcase = commingcase + 1
            $('#commingcase').html(commingcase)
            // 
            $(`[data-consoleBtnaccepte="${CaseName}"]`).html(`
                <button class="consoleBtn-accepte2" onclick="">
                    <i class="fas fa-user"></i>
                </button>`
            )
        } else if (event.data.Action == 'UpdatePhone') {
            let CaseName = event.data.Cache;
            $(`[data-phone="${CaseName}"]`).html(`<p><i class="fas fa-phone-office"></i>&nbsp;<span> ${event.data.Number} </span> | ${event.data.Text}</p>`)
        } else if (event.data.Action == 'UpdateSuscess') {
            let CaseName = event.data.Cache;
            $(`[data-icon="${CaseName}"]`).html(`<i class="fas fa-check successcase-text"></i>`)
            commingcase = commingcase - 1
            $('#commingcase').html(commingcase)
            successcase = successcase + 1
            $('#successcase').html(successcase)
        } else if (event.data.Action == 'UpdateDelete') {
            let CaseName = event.data.Cache;
            $(`[data-case="${CaseName}"]`).empty()
            successcase = successcase - 1
            $('#successcase').html(successcase)
            allcase = allcase - 1
            $('#allcase').html(allcase)
        } else if (event.data.Action == 'PlaySound') {
            PlaySounds("main")
        }
    })
})

function GetGPS(Cache) {
    PlaySounds("click")
    SendMessage("GetGPS", {
        Name : Cache
    })
}

function Accepte(Cache) {
    PlaySounds("click")
    SendMessage("UpdateOwner", {
        Name : Cache
    })
}

function Suscess(Cache) {
    PlaySounds("click")
    SendMessage("UpdateSuscess", {
        Name : Cache
    })
}

function Delete(Cache) {
    PlaySounds("click")
    SendMessage("UpdateDelete", {
        Name : Cache
    })
}

function PlaySounds(name) {
    var sound = new Audio(`sounds/` + name + `.mp3`);
    sound.volume = 0.5;
    sound.play();
}

function myFunction() {
    var input, filter, ul, li, a, i, txtValue;
    input = document.getElementById("myInput");
    filter = input.value.toUpperCase();
    ul = document.getElementById("case");
    li = ul.getElementsByClassName("case-box");
    for (i = 0; i < li.length; i++) {
        a = li[i].getElementsByTagName("span")[0];
        txtValue = a.textContent || a.innerText;
        if (txtValue.toUpperCase().indexOf(filter) > -1) {
            li[i].style.display = "";
        } else {
            li[i].style.display = "none";
        }
    }
}