$('bear_player').hide();

window.addEventListener('message', (event) => {
    if (event.data.type === "ui") {
        if (event.data.status) {
            $('#body').fadeIn();
        } else {
            $('#body').fadeOut();
        }
    }
});