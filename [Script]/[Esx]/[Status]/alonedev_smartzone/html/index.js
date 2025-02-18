
$(function () {

    window.addEventListener("message", ({ data }) => {
        switch (data.action) {
            case "show_ui":
                $('.container').fadeIn()
                $('.Zone-Name').html(data.Zone)
                break;
            case "close_ui":
                $('.container').fadeOut()
                $('.Zone-Name').html('')
                break;
        }
    })
})