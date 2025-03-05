var msg = new Audio("https://cdn.pixabay.com/audio/2022/03/10/audio_80d46d9664.mp3");
msg.volume = 1;

let currentItem = []
var wasExecuted = false;
$(function () {
    function display(bool) {
        if (bool) {
            $(".container").show();
        } else {
            $(".container").hide();
        }
    }
    display(false)
    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post("http://2Dev-SystemAlert/CLOSE")
        }
    }
    window.addEventListener('message', function (event) {
        var data = event.data;
        if (data.action === "ui") {
            if (data.status == true) {
                display(true)
            } else {
                display(false)
            }
        } else if (data.action === "data") {
            currentItem = data.FeedbackTable
            reloadFeedbackTable()
        } else if (data.action === "data-case-status") {
            $("#data-accept-case").text(`รอการรับเคส : ${data.waiting}`)
            $("#data-go-case").text(`กำลังไป : ${data.accept}`)
            $("#data-success-case").text(`รักษาสำเร็จ : ${data.success}`)
            $("#data-all-case").text(`รวม : ${data.all}`)
        } else if (data.action === "data-update-case-id") {
            if (data.type === "accept") {
                $(`.case-status-id-${data.caesid}`).css('background-color', '#1C1C1C')
                $(`.case-status-id-${data.caesid}`).text(`${data.name} กำลังไป`)
            } else if (data.type === "success") {
                $(`.case-status-id-${data.caesid}`).css('background-color', '#1C1C1C')
                $(`.case-status-id-${data.caesid}`).text(`รักษาแล้ว #${data.name}`)
            } else if (data.type === "delete") {
                $(`#case-id-div-${data.caesid}`).remove()
            } else if (data.type === "deleteall") {
                $('.list').empty();
            }
        }
        else if (data.action === "sound") {
            msg.play();
        }
    })
})



function reloadFeedbackTable() {
    $('.list').empty();
    $.each(currentItem, function (index) {
        // currentItem[index].sort(function (a, b) {
        //     return b.caseid - a.caseid
        // })
        $('.list').empty();
        $.each(currentItem[index], function (index, item) {
            var dead = ''
            var status = ``
            if (item.alert == 'dead') {
                dead = 'สลบ'
            }
            if (item.alert == 'dead2') {
                dead = 'ถูกห่อศพ'
            }
            if (item.alert == 'deadrepeat') {
                dead = 'สลบ (เรียกซ้ำ)'
            }

            if (item.casestatus == false) {
                status = `<span class='case-status-id-${index + 1}' id='stage' style="background-color: #1C1C1C;">รอการรับเคส</span>`
            } else if (item.casestatus == true) {
                status = `<span class='case-status-id-${index + 1}' id='stage' style="background-color: #1C1C1C;">${item.acceptcase} กำลังไป</span>`
            } else {
                status = `<span class='case-status-id-${index + 1}' id='stage' style="background-color: #1C1C1C;">รักษาแล้ว #${item.acceptcase}</span>`
            }
            $(".list").append(`
                <div class="item" id="case-id-div-${index + 1}">
                    <div class="pic" style="background-image: url(&#39;https://media.discordapp.net/attachments/1030094411150930060/1040938437450145872/cat.png&#39;);"></div>
                    <div class="name">${item.name}&nbsp; [${dead}]</div>
                    <div class="phone-time">
                        <i class="fa-solid fa-square-phone"></i>&nbsp; 
                        <span id="phone-number">${item.phone}</span>&nbsp; | &nbsp;
                        <i class="fa-solid fa-clock"></i>&nbsp; 
                        <span id="time-number">${item.time}</span>&nbsp; | &nbsp;
                        ${status}
                    </div>
                    <div class="score">
                        <i id="SetMarkCase-${index + 1}" class="fa-solid fa-location-arrow"></i>
                        <i id="SuccessCase-${index + 1}" class="fa-solid fa-circle-check"></i>
                        <i id="DelCase-${index + 1}" class="fa-solid fa-trash fa-trash-fix"></i>
                    </div>
                </div>
            `)

            $(`#SetMarkCase-${index + 1}`).click(function () {
                SetMarkCase(index + 1, item);
            });
            $(`#SuccessCase-${index + 1}`).click(function () {
                SuccessCase(index + 1);
            });
            $(`#DelCase-${index + 1}`).click(function () {
                DelCase(index + 1);
            });
        });
    });
}

const SwitchSound = () => {
    var checkBox = document.getElementById("s2");
    $.post("http://2Dev-SystemAlert/SwitchSound ", JSON.stringify({ fixsound: checkBox.checked }));
    // if (checkBox.checked == true) { payType = "bank" }
    // else { payType = "cash" }
}


const DelAllCase = () => {
    if (wasExecuted) {
        return;
    }
    $.post("http://2Dev-SystemAlert/DelAllCase ", JSON.stringify({}));
    setTimeout(function () {
        wasExecuted = false;
    }, 2000);
}

const DelCase = (caseid) => {
    if (wasExecuted) {
        return;
    }
    $.post("http://2Dev-SystemAlert/DelCase ", JSON.stringify({ caesid: caseid }));
    setTimeout(function () {
        wasExecuted = false;
    }, 2000);
}

const SuccessCase = (caseid) => {
    if (wasExecuted) {
        return;
    }
    $.post("http://2Dev-SystemAlert/Success ", JSON.stringify({ caesid: caseid }));
    setTimeout(function () {
        wasExecuted = false;
    }, 2000);
}

const SetMarkCase = (caseid, itemData) => {
    if (wasExecuted) {
        return;
    }
    wasExecuted = true;
    var coordsx = itemData.coords.x
    var coordsy = itemData.coords.y
    $.post("http://2Dev-SystemAlert/SetMark ", JSON.stringify({
        coordsx: coordsx,
        coordsy: coordsy,
        caesid: caseid,
    }));
    setTimeout(function () {
        wasExecuted = false;
    }, 2000);
}