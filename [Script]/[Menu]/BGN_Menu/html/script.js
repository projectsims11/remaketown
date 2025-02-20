function handleKeyPress(event) {
    if (event.which == 27) {
        $('#body').fadeOut(100);
        $.post('https://BGN_Menu/action', JSON.stringify({
            action: 'closeMenu'
        }));
    }
}

function openUi() {
    $('.box').remove();
    $('#body').fadeIn(100);
}

function createBox(box) {
    // var emoji = box.emoji;
    // var topic = box.topic;
    // var detail = box.detail;
    var event = box.event;
    var command = box.command;

    var boxDiv = document.createElement("div");
    boxDiv.className = "box";
    boxDiv.setAttribute("data-event", event);
    boxDiv.setAttribute("data-command", command);

    // var emojiIcon = document.createElement("div");
    // emojiIcon.className = emoji;

    // var topicDiv = document.createElement("div");
    // topicDiv.className = "topic";
    // topicDiv.innerText = topic;

    // var detailDiv = document.createElement("div");
    // detailDiv.className = "detail";
    // detailDiv.innerText = detail;

    $("#box-menu").append(boxDiv);
    // boxDiv.appendChild(emojiIcon);
    // boxDiv.appendChild(topicDiv);
    // boxDiv.appendChild(detailDiv);
    $(boxDiv).append(`
        <div class="icon" style="background: url(./img/${box.emoji}.png) center/contain no-repeat;"></div>
        <div class="box-bg">
            <div class="topic">${box.topic}</div>
            <div class="detail">${box.detail}</div>
        </div>
    `);
}

function setupEventListeners() {
    $(".box").on("click", function () {
        var event = $(this).data("event");
        var command = $(this).data("command");

        if (event) {
            $("#body").fadeOut(100);
            $.post('https://BGN_Menu/action', JSON.stringify({
                action: 'event',
                event: event
            }));
        } else if (command) {
            $("#body").fadeOut(100);
            $.post('https://BGN_Menu/action', JSON.stringify({
                action: 'command',
                event: command
            }));
        }
    });
}

$(document).ready(function () {

    document.onkeyup = handleKeyPress;

    window.addEventListener('message', function (event) {
        var data = event.data;

        if (data !== undefined) {
            if (data.type == 'openMenuUi') {
                if (data.display == true) {
                    openUi()

                    for (var i = 0; i < data.box.length; i++) {
                        createBox(data.box[i]);
                    }

                    setupEventListeners()
                }
            }
        }
    });
});