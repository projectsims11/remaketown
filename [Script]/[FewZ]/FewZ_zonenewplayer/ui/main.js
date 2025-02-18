$(function() {
    window.addEventListener("message", function(d) {
        let e = d.data

        switch (e.action) {
            case 'Start':
                if (e.type == false) {
                    $(".container").css("opacity", "0")
                    var Sound = new Audio('cancel.wav');
                    Sound.volume = 0.5;
                    Sound.play();
                } else {
                    $(".container").css("opacity", "1")
                    var Sound = new Audio('open.wav');
                    Sound.volume = 0.5;
                    Sound.play();
                }
                break;
            default:
        }
    })
    document.querySelector("#exit").addEventListener("click", function() {
        $.post('https://FewZ_zonenewplayer/exit', JSON.stringify({}));
    });
    document.querySelector("#skin").addEventListener("click", function() {
        $.post('https://FewZ_zonenewplayer/skin', JSON.stringify({}));
    });
    document.querySelector("#tp").addEventListener("click", function() {
        $.post('https://FewZ_zonenewplayer/tp', JSON.stringify({}));
    });
})

$(document).keyup(function(e) {
    if (e.key === "Escape") { // escape key maps to keycode `27`
        $.post('https://FewZ_zonenewplayer/exit', JSON.stringify({}));
    }
});