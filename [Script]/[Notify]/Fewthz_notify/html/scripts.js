$(function () {
    var sound = new Audio('sound.mp3');
    sound.volume = 1.0;
    window.addEventListener('message', function (event) {
        if (event.data.action == 'open') {
            var number = Math.floor((Math.random() * 1000) + 1);
            $('.toast').append(`
            <div class="notify wrapper-${number}">
                <div class="notification_main-${number}">
                    <div class="notify-text">
                        ${event.data.message}
                    </div>
                </div>
            </div>`)
            $('.notification_main-'+number).addClass('main')

            if (event.data.type == 'success') {
                $(`.notification_main-${number}`).addClass('success-icon')
                $(`.wrapper-${number}`).addClass('success success-border')
                sound.play();
            } else if (event.data.type == 'info') {
                $(`.notification_main-${number}`).addClass('info-icon')
                $(`.wrapper-${number}`).addClass('info info-border')
                sound.play();
            } else if (event.data.type == 'error') {
                $(`.notification_main-${number}`).addClass('error-icon')
                $(`.wrapper-${number}`).addClass('error error-border')
                sound.play();
            } else if (event.data.type == 'warning') {
                $(`.notification_main-${number}`).addClass('warning-icon')
                $(`.wrapper-${number}`).addClass('warning warning-border')
                sound.play();
            } else if (event.data.type == 'phonemessage') {
                $(`.notification_main-${number}`).addClass('phonemessage-icon')
                $(`.wrapper-${number}`).addClass('phonemessage phonemessage-border')
                sound.play();
            } else if (event.data.type == 'neutral') {
                $(`.notification_main-${number}`).addClass('neutral-icon')
                $(`.wrapper-${number}`).addClass('neutral neutral-border')
                sound.play();
            }
            anime({
                targets: `.wrapper-${number}`,
                translateX: -50,
                duration: 750,
                easing: 'spring(1, 70, 100, 10)',
            })
            setTimeout(function () {
                anime({
                    targets: `.wrapper-${number}`,
                    translateX: 500,
                    duration: 750,
                    easing: 'spring(1, 80, 100, 0)'
                })
                setTimeout(function () {
                    $(`.wrapper-${number}`).remove()
                }, 750)
            }, event.data.time)
        }
    })
})