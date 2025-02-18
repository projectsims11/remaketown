
$(function () {

    let dive = false

    window.addEventListener("message", ({ data }) => {
        switch (data.action) {
            case "send_default_data":
                if (data.show) {
                    $('.container').css('display', 'none')
                    $('.department-count-container').css('display', 'none')
                } else {
                    $('.container').fadeIn();
                    $('.department-count-container').css('display', 'block')
                }

                if (data.health) {
                    $("#health_percent").css({ width: data.health + "%" });

                }

                if (data.armor) {
                    $("#armour_percent").css({ width: data.armor + "%" });
                }

                if (data.id) {
                    $('#player_id').html(data.id)
                }

                if (data.dive < 100) {
                    $('#dive_status').css('display', 'flex')
                    if (data.dive > 5) {
                        $(`#rect_dive`).attr('stroke-dashoffset', 320 - (320 * (data.dive / 100)))
                    } else {
                        $(`#rect_dive`).css('display', 'none')
                    }
                } else if (data.dive > 100 || data.dive == 100) {
                    $('#dive_status').css('display', 'none')
                }

                break;
            case "register_status":

                if (!dive && data.status_name == 'dive') {
                    dive = true
                    $('#status_list').append(`
                    <div class="status" id="dive_status">
                        <svg id="loadingSquare" width="3.5vh" height="3.5vh" viewBox="0 0 120 120"
                            xmlns="http://www.w3.org/2000/svg">
                            <defs>
                                <linearGradient id="grad1" x1="0%" y1="0%" x2="100%" y2="0%">
                                    <stop offset="0%" style="stop-color:${data.status_data.color1};" />
                                    <stop offset="100%" style="stop-color:${data.status_data.color2};" />
                                </linearGradient>
                            </defs>

                            <rect id="rect_dive" x="10" y="10" width="100" height="100" fill="none" stroke="url(#grad1)"
                                stroke-width="12" stroke-dasharray="320 320" stroke-dashoffset="320" stroke-linecap="round"
                                rx="35" ry="35" />
                        </svg>

                        <div class="status_img">
                        <img src="./assests/${data.status_data.image}" alt="${data.status_name}">
                        </div>
                    </div>`);
                } else {
                    $('#status_list').append(`
                        <div class="status">
                            <svg id="loadingSquare" width="3.5vh" height="3.5vh" viewBox="0 0 120 120"
                                xmlns="http://www.w3.org/2000/svg">
                                <defs>
                                    <linearGradient id="grad1" x1="0%" y1="0%" x2="100%" y2="0%">
                                        <stop offset="0%" style="stop-color:${data.status_data.color1};" />
                                        <stop offset="100%" style="stop-color:${data.status_data.color2};" />
                                    </linearGradient>
                                </defs>
    
                                <rect id="rect_${data.status_name}" x="10" y="10" width="100" height="100" fill="none" stroke="url(#grad1)"
                                    stroke-width="12" stroke-dasharray="320 320" stroke-dashoffset="320" stroke-linecap="round"
                                    rx="35" ry="35" />
                            </svg>
    
                            <div class="status_img">
                                <img src="./assests/${data.status_data.image}" alt="${data.status_name}">
                            </div>
                        </div>`);
                }




                break;
            case "send_status_data":
                if (data.status_name) {
                    if (data.status_percent > 10) {
                        $(`#rect_${data.status_name}`).css('display', 'block')
                        $(`#rect_${data.status_name}`).attr('stroke-dashoffset', 320 - (320 * (data.status_percent / 100)))
                    } else {
                        $(`#rect_${data.status_name}`).css('display', 'none')
                    }
                }
                break;
            case "setup_department":
                $('.department-count-container').css('right', data.department.position.x + '%')
                $('.department-count-container').css('top', data.department.position.y + '%')

                for (x in data.department.job_list) {
                    let job = data.department.job_list[x]
                    $('.department-count-container').append(`
                        <div class="job">
                            <span id="count_${job.name}">0</span>
                            <div class="job_img">
                                <img src="./assests/${job.image}" alt="${job.name}">
                            </div>
                        </div>
                        `)
                }

                break;
            case "send_department_data":
                if (data.job_name && data.job_count) {
                    $(`#count_${data.job_name}`).html(data.job_count)
                }  else {
                    $(`#count_${data.job_name}`).html(0)    
                }
                break;
            case "send_voice_data":
                $('.voice-chat-dots .dot2').removeClass('active');
                $('.voice-chat-dots .dot2').css('background', 'linear-gradient(180deg, rgb(41, 41, 41) 0%, rgb(55, 55, 55) 50%, rgb(41, 41, 41) 100%)')

                for (let i = 0; i < data.voice_mode; i++) {
                    $('.voice-chat-dots .dot2').eq(i).addClass('active');
                    $('.voice-chat-dots .dot2').eq(i).css('background', 'linear-gradient(180deg, rgb(31, 122, 226) 0%, rgb(70, 145, 231) 100%)')
                }

                break;
        }
    })

    function updateTime() {
        const now = new Date();

        const hours = String(now.getHours()).padStart(2, '0');
        const minutes = String(now.getMinutes()).padStart(2, '0');
        const seconds = String(now.getSeconds()).padStart(2, '0');
        const day = String(now.getDate()).padStart(2, '0');
        const month = String(now.getMonth() + 1).padStart(2, '0');
        const year = now.getFullYear();

        const timeDateString = `${hours}:${minutes}:${seconds} ${day}/${month}/${year}`;

        $('#time_date').html(timeDateString);
    }

    setInterval(updateTime, 1000);

    updateTime();

})