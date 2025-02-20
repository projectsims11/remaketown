var open = document.createElement("audio");
var close = document.createElement("audio");
var start  = document.createElement("audio");
var end = document.createElement("audio");
var  Sound_End
var  Sound_Start  
var flagStart = true
var flagEnd = true
var chamName = ""
var timeShow 
window.addEventListener("message", (event) => {
    if (event.data.action === "nuiStatus") {
        if(event.data.name != undefined){
           
            chamName = event.data.name
            timeShow = event.data.time
        }
        nuiStatus(event.data.display);
  
    } else if (event.data.action === "setTime") {
        setTime(event.data.time)
    } else if (event.data.action === "setData") {
        setIMG(event.data.url, event.data.type)
        setName(event.data.name)
    } else if (event.data.action === "checkPaper") {
        checkPaper(event.data.display)
    }else if(event.data.action === "sendInfo"){
        Sound_End =event.data.SoundEnd
        Sound_Start =event.data.SoundStart
    }
});

function setIMG(url, type) {
    if (type === "box") {
        $("#img").attr('src', url);
    } else if (type === "person") {
        url = `https://nui-img/${url}/${url}?v=${Date.now()}`
        $("#img").attr('src', url);
    }else if(type === "unknown"){
        $("#img").attr('src', "img/person.png");
    }
}

function ShowCham() {

    $("#chamName").text("ผู้ชนะคือ  "+chamName);
    $('.text').hide()
    $('.containerTop').animate({width: 'toggle'},3000,function () {
        $('.text').fadeIn(1000)
        
    });
    setTimeout(() => {
        $('.containerTop').fadeOut(1500);
    }, timeShow * 1000);

}
function nuiStatus(display) {
    if (display) {
        if(flagStart == true){
            if (start.paused) {
                start.setAttribute("src",Sound_Start );
                start.volume = 0.3;
                start.play();
            }
            $(".arrest").fadeIn();
            flagStart = false
            flagEnd = true
        }
    } else {
    
        if(flagEnd == true){
            if (end.paused) {
                end.setAttribute("src", Sound_End);
                end.volume = 0.3;
                end.play();
            }
            
            ShowCham()
            flagEnd = false
            flagStart = true
        }

        $(".arrest").fadeOut();
    }
}

function checkPaper(display) {
    if (display) {
        if (open.paused) {
            open.setAttribute("src", "sounds/paper1.mp3");
            open.volume = 0.3;
            open.play();
        }
        $(".arrest").animate({
            width: "20vw",
            height: "29vw",
            right: "30vw",
            top: "40%",
        });
        $(".maintext").animate({
            marginTop: "5%",
            fontSize: "3.6vw",
        });
        $(".header").animate({
            marginTop: "2%",
            fontSize: "2vw",
        });
        $(".price").animate({
            marginTop: "0%",
            fontSize: "2vw",
        });
        $(".name").animate({
            marginTop: "2%",
            fontSize: "1.7vw",
        });

    } else {
        if (close.paused) {
            close.setAttribute("src", "sounds/paper1.mp3");
            close.volume = 0.3;
            close.play();
        }
        $(".arrest").animate({
            width: "10vw",
            height: "14.7vw",
            right: "-4vw",
            top: "50%",
        });
        $(".maintext").animate({
            marginTop: "0%",
            fontSize: "2vw",
        });
        $(".header").animate({
            marginTop: "2%",
            fontSize: "1vw",
        });
        $(".price").animate({
            marginTop: "2%",
            fontSize: "1.2vw",
        });
        $(".name").animate({
            marginTop: "0%",
            fontSize: "1.5vw",
        });

    }
}


function setName(name) {
    $(".name").text(name);
}

function setTime(time) {

    hour = Math.floor((time / 3600))
    time = time - (hour * 3600)
    mint = Math.floor(time / 60)
    time = time - (mint * 60)
    sec = Math.floor(time % 60)
    if (sec <= 9) {
        sec = "0" + sec
    }
    if (mint <= 9) {
        mint = "0" + mint
    }
    if (hour <= 9) {
        hour = "0" + hour
    }
    time = `${hour}:${mint}:${sec}`
    $("#time").text(time);
}

