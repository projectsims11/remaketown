let Recevied = false;
const ResourceName = 'dnk.DailyLogin';
const PlaySound = function (volume, sound, file) {
    var msg = new Audio(`./sounds/${sound}.${file}`);
    msg.volume = volume;
    msg.play();
    setTimeout(() => {
        msg.volume = 0.0;
        msg.pause();
    }, 6 * 1000);
};
const LoadData = function (items, points, point, reward, back, inventory) {
    $('#main-list-items').empty();

    $(`#point-${10} .image`).html(`<img src="${inventory}/${reward[10].name}.png">`);
    $(`#point-${20} .image`).html(`<img src="${inventory}/${reward[20].name}.png">`);
    $(`#point-${30} .image`).html(`<img src="${inventory}/${reward[30].name}.png">`);
    if (points > 0) {
        if (points >= 10) {
            $(`#point-${10} .number`).removeClass('disabled');
            $('.progress').css('--load2', `${points / 20 * 100}%`);

            if (point < 10) {
                $(`#point-${10}`).on('click', function () {
                    $.post(`https://${ResourceName}/receviePoint`, JSON.stringify(10));
                    $(`#point-${10}`).off('click');
                });
            } else {
                $(`#point-${10} .number`).addClass('active');
                $(`#point-${10} .image`).addClass('received');
            }
        }

        if (points >= 20) {
            $(`#point-${20} .number`).removeClass('disabled');
            $('.progress').css('--load3', `${points / 30 * 100}%`);

            if (point < 20) {
                $(`#point-${20}`).on('click', function () {
                    $.post(`https://${ResourceName}/receviePoint`, JSON.stringify(20));
                    $(`#point-${20}`).off('click');
                });
            } else {
                $(`#point-${20} .number`).addClass('active');
                $(`#point-${20} .image`).addClass('received');
            }
        }

        if (points >= 30) {
            $(`#point-${30} .number`).removeClass('disabled');

            if (point < 30) {
                $(`#point-${30}`).on('click', function () {
                    $.post(`https://${ResourceName}/receviePoint`, JSON.stringify(30));
                    $(`#point-${30}`).off('click');
                });
            } else {
                $(`#point-${30} .number`).addClass('active');
                $(`#point-${30} .image`).addClass('received');
            }
        }
    };


    $.each(items, function (index, item) {
        $('#main-list-items').append(`
            <div id="login-${index}" class="item ${item.can_receive ? '' : 'disabled'} ${item.received ? 'received' : ''}  ${item.missed ? 'missed' : ''}">
                <header>
                    <span> ${index + 1} </span>
                </header>
                <main>
                    <img src="${inventory}${item.name}.png" alt="">
                </main>
                <footer>
                    <span> ${item.label} </span>
                </footer>
            </div>
        `);

        $(`#login-${index}`).off('click');
        $(`#login-${index}`).on('click', function (event) {

            if (item.missed && item.can_receiveback) {
                $('#received .received').html(`
                    <div class="info">
                        <header>
                            <span> เสียเงิน ${ back ? back.amount : 0 } เพื่อรับไอเทม? </span>
                        </header>
                        <footer>
                            <button id="cancel">ยกเลิก</button>
                            <button id="confirm">ยืนยัน</button>
                        </footer>
                    </div>
                `);
                $('#received').fadeIn();
                $('#received .received button#confirm, #received .received button#cancel').off('click');
                $('#received .received button#confirm').on('click', function () {
                    $.post(`https://${ResourceName}/recevieItem`, JSON.stringify(index));
                    $('#received .received button').off('click');
                    setTimeout(() => {
                        $('#received').fadeOut();
                    }, 200);
                });
                $('#received .received button#cancel').on('click', function () {
                    $('#received .received button').off('click');
                    $('#received').fadeOut();
                });
            }

            if (!Recevied && item.can_receive) {
                Recevied = true;
                $.post(`https://${ResourceName}/recevieItem`, JSON.stringify(index));
                setTimeout(() => {
                    Recevied = false;
                }, 60 * 1000);
            };
        });
    });
    $('button, .item').on('click', function () {
        PlaySound(0.5, 'sound', 'mp3');
    });
};
window.addEventListener('message', (event) => {
    const data = event.data;

    if (data.toggle == true) {
        $('#wrapper').fadeIn();
    } else if (data.load) {
        LoadData(data.load, data.points, data.point, data.reward, data.back, data.inventory);
    } else if (data.toggle == false) {
        $('#wrapper').fadeOut();
    };
});
$("body").on("keyup", function (key) {
    if (key.which == 27) {
        if ($('#received').is(':visible')) {
            $('#received').fadeOut();
        } else {
            $.post(`https://${ResourceName}/toggleMenu`);
        };
    };
});
